# 严禁猜测与强制查验指南 (Strict No-Guessing Verification Rule)

为了确保工程代码与 CI/CD 自动化工作流 100% 稳定运行，所有 AI Agent 与开发脚本必须严格遵守以下红线原则：

---

### 一、 核心原则：严禁任何主观猜测 (Zero Assumptions)

1. **绝对禁止猜测文件名与路径**：
   - 不得主观拼写或猜测 HuggingFace / GitHub / 远程服务器上的文件名、扩展名或大小写（例如 `hy-mt2-1.8b-2bit.gguf` vs `Hy-MT2-1.8B-2bit.gguf`）。
   - **必须规则**：必须通过动态 API（如 `huggingface_hub.list_repo_files`）在运行时实时拉取远端绝对正确的文件名列表，或通过官方页面确认。

2. **绝对禁止猜测 API 参数与 Payload 格式**：
   - 不得盲目硬编码 API Endpoint、Request Headers 或 `model` 替代字段。
   - **必须规则**：针对 OpenAI / Gemini / OpenRouter 等不同 Provider，严格按官方 OpenAPI / REST 规范构造 Payload。针对 404 / 400 报错，实时捕获服务端返回的建议 Slug。

3. **大小写严格敏感 (Strict Case Sensitivity)**：
   - 包含 URL、HuggingFace Repo ID、文件路径在内的所有网络资源，一律按区分大小写（Case-Sensitive）处理，杜绝全小写盲目转换。

---

### 二、 自动化脚本设计红线

所有位于 `scripts/` 目录下的自动化工具：
- 必须具备**自愈与动态查验**机制（Dynamic Fallback / Verification）。
- 在发生错误时，必须完整输出**原始 HTTP 状态码与服务端 Response Body**，严禁吞掉真实报错信息。
- 所有远程资源获取前，必须进行动态列表检索或 HEAD 探测。
