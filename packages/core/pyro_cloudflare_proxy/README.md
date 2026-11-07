# pyro_cloudflare_proxy

Cloudflare 5秒盾过白 Cookie 缓存与 HTTP 代理拦截客户端。

## 💡 核心职责

针对使用 Cloudflare 防火墙保护的内容源，提供代理 Cookie 自动注入机制：
- **`CloudflareBypassClient`**: 缓存通过 Headless WebView 或爬虫过白拿到的 `cf_clearance` Cookie 和对应 `User-Agent`。
- **Header 自动融合 (`mergeProxyHeaders`)**: 在向目标站点发起普通 HTTP 请求时自动合并过白 Cookie，防止 403 阻断。
