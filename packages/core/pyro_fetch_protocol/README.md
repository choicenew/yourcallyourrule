# pyro_fetch_protocol

`pyro_fetch_protocol` 是获取/抓取数据体系的**基础契约与协议包**。它和 `pyro_push_protocol` 及 `pyro_render_protocol` 的地位一样，是最底层的纯接口定义层。

## 核心设计理念
本包不包含具体的抓取逻辑网络请求，也不包含注册分发机制，纯粹为了解耦而生。

## 主要内容
### 1. `PyroSource` (源模型)
定义了可以获取数据的数据源配置信息，包括：
*   `id`: 源的唯一标识。
*   `name`: 源的名称。
*   `protocol`: 源使用的抓取协议（如 `opds`, `rss`, `hetu_script` 等）。
*   `supportsSearch`, `supportsExplore`: 该源是否支持搜索和发现。
*   `config`: 动态配置数据。

### 2. `SourceExecutor` (抽象执行器契约)
定义了每一种抓取协议都需要实现的能力：
*   `search(...)`: 根据关键字搜索资源。
*   `explore(...)`: 发现/浏览资源。
*   `getDetail(...)`: 获取资源详细信息。
*   `getAuthorProfile(...)`: 获取创作者档案信息（可选）。
*   `getAuthorWorks(...)`: 获取创作者作品列表（自带降级为 `author:` 搜索）。
*   `getConfigSchema(...)`: 获取数据源支持的动态配置项 Schema。
*   `verifySource(...)`: 测试连接或校验源。

