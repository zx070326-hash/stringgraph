"""Extract text (PyMuPDF) and render page images from the Borcherds 1992 reprint.

Usage (from repo root):
    uv run --with pymupdf python research/attempts/borcherds-rank-one-noghost/scripts/extract_pdf.py <pdf> <outdir> [first_page last_page]

Pages are 1-based. Produces <outdir>/page-NN.txt (PyMuPDF text, reading order
"blocks") and <outdir>/page-NN.png (200 dpi render) for each page in range.

Tool discipline (project rule): PyMuPDF only, never pdftotext; every formula that
carries a verdict must additionally be re-read from the rendered PNG.
"""
import sys
import pymupdf

pdf, outdir = sys.argv[1], sys.argv[2]
doc = pymupdf.open(pdf)
n = len(doc)
first = int(sys.argv[3]) if len(sys.argv) > 3 else 1
last = int(sys.argv[4]) if len(sys.argv) > 4 else n
print(f"{pdf}: {n} pages; metadata={doc.metadata}")
for i in range(first - 1, min(last, n)):
    page = doc[i]
    txt = page.get_text("text", sort=True)
    with open(f"{outdir}/page-{i+1:02d}.txt", "w", encoding="utf-8") as f:
        f.write(txt)
    pix = page.get_pixmap(dpi=200)
    pix.save(f"{outdir}/page-{i+1:02d}.png")
    print(f"page {i+1}: {len(txt)} chars")
