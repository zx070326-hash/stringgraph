# tools/stringgraph/ — Python 工具

纯 Python 3.11+，依赖只有 `pyyaml` 与 `jsonschema`。不引入新依赖，除非任务明确要求。

## 模块

| 文件 | 职责 |
|---|---|
| `model.py` | 数据类与状态等级 `LEVEL` |
| `loader.py` | 从 `graph/` 读 YAML，宽松加载，只记录不可读错误 |
| `validate.py` | 所有校验规则；返回 `Problem` 列表 |
| `propagate.py` | 有效状态传播算法（文档在 `docs/STATUS_LEVELS.md`） |
| `report.py` | 报告、搜索、dot 导出 |
| `cli.py` | `stringgraph` 命令 |

## 规则

- 校验规则的每一条改动都要在 `tests/` 加对应用例。
- 传播算法改动必须同步改 `docs/STATUS_LEVELS.md`。
- `validate` 的退出码是 pre-commit 的依据，不要把 error 降级成 warning 来"让它过"。
- 输出面向 agent 消费：`--json` 选项要保持稳定的键名。

## 跑测试

```bash
uv run pytest -q
```
