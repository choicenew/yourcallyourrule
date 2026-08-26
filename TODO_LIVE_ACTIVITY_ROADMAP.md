# Live Activity 与来电识别演进规划 (TODO List)

---

## 一、待办事项 (TODO List)

### 1. 深度链接 (DeepLink) 业务落地拓展
- [ ] **参数化路由跳转**：未来为 `yourcallyourrule://` 协议添加精准传参，支持：
  - `yourcallyourrule://caller_detail?phone=...`：直接跳转至该号码的详细标记与规则设置页。
  - `yourcallyourrule://fraud_warning?phone=...`：高危诈骗号码点击后直接弹出安全警示与一键拦截上报弹窗。
- [ ] **数据上报与分析**：在用户点击灵动岛/锁屏通知后，记录用户行为与防诈提示有效触达率。

---

## 二、iOS 端号码实时录取与识别架构设计（基于快捷指令自动化）

### 1. 业务背景与传统方案局限
* **传统 Call Directory Extension 局限**：仅支持静态离线全量数据导入（百万级数据限制），不支持动态查库。
* **实时网络服务器查询的弊端**：对小型服务端并发与实时吞吐要求极高，成本大、维护难。

### 2. 快捷指令自动化 (Shortcuts Automation) 创新方案链路
```
[iOS 收到来电/短信通知]
         │
         ▼
[快捷指令个人自动化 (Personal Automation) 自动触发]
         │ 提取通知文本内容，正则解析手机号码
         ▼
[通过 DeepLink 唤醒 App]
`yourcallyourrule://lookup?phone=13800000000`
         │
         ▼
[App 本地/轻量级查询号码信息]
         │
         ▼
[调用 LiveActivity.show(...) 触发灵动岛 / 锁屏卡片]
         │
         ▼
[用户在灵动岛或锁屏上即时看到来电标记与防诈卡片]
```
