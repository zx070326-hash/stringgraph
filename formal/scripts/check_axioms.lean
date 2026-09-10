/-
Copyright (c) 2026 stringgraph contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: stringgraph lean-formalizer
-/
import Lean.Util.CollectAxioms
import Lean.Util.Path

/-!
# Axiom audit for the declarations the dependency graph points at

A derivation may be marked `status: formalized` in `graph/` only if the Lean declaration named by
the target statement's `formal.lean_decl` compiles with **no `sorry` and no non-standard axiom**.
This script is the machine-checkable half of that rule: it loads the compiled environment and
prints, for each declaration name given, the set of axioms the declaration transitively depends on.

Standard (allowed) axioms are exactly Lean's three classical ones:
`propext`, `Classical.choice`, `Quot.sound`.  Anything else -- in particular `sorryAx`, which is
what a `sorry` leaves behind -- makes the script exit with code 1.

## Usage

```
cd formal
lake build                                    # the environment must be built first
lake env lean --run scripts/check_axioms.lean StringFormal.NoGhost.Fock.lie_Lop_Lop
lake env lean --run scripts/check_axioms.lean --all < names.txt
grep -rh "lean_decl:" ../graph/ | awk '{print $2}' | sort -u \
  | lake env lean --run scripts/check_axioms.lean --all
```

Options:

* `--all` reads whitespace-separated declaration names from stdin (in addition to any given on the
  command line).  Lines starting with `#` are ignored, so the output of a previous run can be fed
  back in.
* `--import <Module>` (repeatable) sets the environment to load; the default is `StringFormal`,
  which imports every module of this package.
* `--help` / `-h` prints usage.

## Output format (stable; `tools/stringgraph` parses it)

One tab-separated line per input name, in input order, plus `#`-prefixed comment lines:

```
<status>	<declaration>	<detail>
```

with `<status>` one of

* `ok` -- only standard axioms; `<detail>` is the space-separated axiom list (possibly empty);
* `bad` -- at least one non-standard axiom; `<detail>` is the full axiom list;
* `missing` -- no such constant in the environment; `<detail>` is a human-readable note.

Exit code: `0` if every name is `ok`, `1` if any is `bad` or `missing`, `2` on a usage error.
-/

open Lean

namespace StringFormal.CheckAxioms

/-- The axioms a declaration is allowed to depend on: Lean's three classical axioms. -/
def standardAxioms : Array Name := #[`propext, `Classical.choice, `Quot.sound]

/-- Minimal monad carrying the imported environment, so that `Lean.collectAxioms`
(`[Monad m] [MonadEnv m]`) can be run outside of `CoreM`. -/
abbrev CheckM := StateT Environment IO

instance : MonadEnv CheckM where
  getEnv := get
  modifyEnv := modify

/-- One output row. -/
structure Result where
  /-- The declaration name as given on the command line. -/
  decl : Name
  /-- `"ok"`, `"bad"` or `"missing"`. -/
  status : String
  /-- Axiom list for `ok`/`bad`, a human-readable note for `missing`. -/
  detail : String
  deriving Inhabited

/-- The tab-separated output line for one declaration. -/
def Result.line (r : Result) : String :=
  s!"{r.status}\t{r.decl}\t{r.detail}"

/-- Collect the axioms of `decl` and classify it. -/
def check (decl : Name) : CheckM Result := do
  let env ← getEnv
  if (env.find? decl).isNone then
    return { decl, status := "missing",
             detail := "no such constant in the imported environment \
               (misspelled, not exported, or a namespace rather than a declaration?)" }
  let axs ← collectAxioms decl
  let bad := axs.filter fun a => !standardAxioms.contains a
  let detail := " ".intercalate (axs.toList.map toString)
  return { decl, status := if bad.isEmpty then "ok" else "bad", detail }

/-- Parsed command line. -/
structure Config where
  /-- Declaration names given on the command line. -/
  decls : Array Name := #[]
  /-- Modules to import; empty means the default `StringFormal`. -/
  imports : Array Name := #[]
  /-- Whether to read further names from stdin (`--all`). -/
  readStdin : Bool := false
  /-- Whether `--help` was given. -/
  help : Bool := false

/-- Command line parser. -/
partial def parseArgs (args : List String) (cfg : Config := {}) : Except String Config :=
  match args with
  | [] => .ok cfg
  | "--all" :: rest => parseArgs rest { cfg with readStdin := true }
  | "--help" :: rest => parseArgs rest { cfg with help := true }
  | "-h" :: rest => parseArgs rest { cfg with help := true }
  | "--import" :: m :: rest => parseArgs rest { cfg with imports := cfg.imports.push m.toName }
  | "--import" :: [] => .error "--import needs a module name"
  | a :: rest =>
      if a.startsWith "-" then
        .error s!"unknown option '{a}'"
      else
        parseArgs rest { cfg with decls := cfg.decls.push a.toName }

/-- Usage text. -/
def usage : String :=
  "usage: lake env lean --run scripts/check_axioms.lean [--import <Module>] [--all] <DeclName>...\n\
   \n\
   Prints one tab-separated line '<status>\\t<declaration>\\t<axioms>' per declaration, where\n\
   <status> is ok / bad / missing.  Exits 1 if any declaration uses an axiom outside\n\
   {propext, Classical.choice, Quot.sound} or does not exist, 2 on a usage error."

/-- Split stdin into declaration names, ignoring blank lines and `#` comment lines. -/
def stdinNames (input : String) : Array Name := Id.run do
  let mut out : Array Name := #[]
  for rawLine in input.splitOn "\n" do
    let line := (rawLine.replace "\t" " ").replace "\r" " "
    let toks := (line.splitOn " ").filter fun t => !t.isEmpty
    match toks with
    | [] => pure ()
    | first :: _ =>
      if !first.startsWith "#" then
        for tok in toks do
          out := out.push tok.toName
  return out

/-- Load the environment and check every requested declaration. -/
def run (cfg : Config) : IO UInt32 := do
  let mut decls := cfg.decls
  if cfg.readStdin then
    decls := decls ++ stdinNames (← (← IO.getStdin).readToEnd)
  if decls.isEmpty then
    IO.eprintln "check_axioms: no declaration names given"
    IO.eprintln usage
    return 2
  let imports := if cfg.imports.isEmpty then #[`StringFormal] else cfg.imports
  initSearchPath (← findSysroot)
  -- `loadExts := false`: loading environment extensions would require `enableInitializersExecution`
  -- and hence an `unsafe` main.  `Lean.collectAxioms` only needs the constant map: without the
  -- extension it falls back to walking the declaration bodies itself (which `importModules` loads
  -- in full at the default `OLeanLevel.private`), giving the same answer as `#print axioms`.
  let env ← importModules (imports.map fun m => { module := m }) {} (loadExts := false)
  let (results, _) ← (decls.mapM check).run env
  IO.println s!"# check_axioms: {decls.size} declaration(s), imports: \
    {" ".intercalate (imports.toList.map toString)}"
  IO.println s!"# standard axioms: {" ".intercalate (standardAxioms.toList.map toString)}"
  for r in results do
    IO.println r.line
  let count (s : String) := results.filter (·.status == s) |>.size
  let nOk := count "ok"
  let nBad := count "bad"
  let nMissing := count "missing"
  IO.println s!"# summary: ok={nOk} bad={nBad} missing={nMissing}"
  return if nBad + nMissing == 0 then 0 else 1

end StringFormal.CheckAxioms

open StringFormal.CheckAxioms in
/-- Entry point for `lake env lean --run scripts/check_axioms.lean`. -/
def main (args : List String) : IO UInt32 := do
  match parseArgs args with
  | .error e =>
      IO.eprintln s!"check_axioms: {e}"
      IO.eprintln usage
      return 2
  | .ok cfg =>
      if cfg.help then
        IO.println usage
        return 0
      run cfg
