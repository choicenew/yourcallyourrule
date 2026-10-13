---
name: cloud-setup-config-generator
description: 远程云端初始配置(app_setup_config.json)与各国家/地区规则库标准生成指南。规范 JSON 架构定义、CDN 镜像加速源映射、多国家规则下发及纯规则库数据文件规范。
---

# 云端初始配置与规则库标准生成指南 (Cloud Setup Config Standard)

本指南规范了 Your Call Your Rule 客户端初始化引导向导 (`InitialSetupPage`) 所依赖的云端动态配置文件及其规则库文件的标准生成格式与部署规则。

---

## 1. 核心架构设计

系统采用 **双层解耦网络架构**：
1. **顶层入口清单 (`app_setup_config.json`)**：
   - 托管于 GitHub 仓库根目录或云端 API。
   - 包含版本控制、国家地区推荐列表（`countries_data`）和插件超市入口（`plugins_recommendation`）。
   - 包含原始 GitHub 链接与 CDN 镜像加速链接。
2. **底层规则数据源 (`rules.json` / `manifest.json`)**：
   - 每个国家对应一个或多个规则源。
   - 数据为直接符合 `RuleImportExportService` 解析标准的规则实体 JSON 数组，包含普通号码规则 (`phone_rule`) 与正则规则 (`regex`)。

---

## 2. 顶层入口配置标准 (`app_setup_config.json`)

### 2.1 JSON Schema 规范

```json
{
  "version": "1.0.0",
  "updated_at": "2026-10-13T00:00:00Z",
  "countries_data": [
    {
      "id": "CN",
      "name": "中国 (China)",
      "icon_url": "https://raw.githubusercontent.com/<owner>/<repo>/main/assets/flags/cn.png",
      "description": "中国大陆高频推销、诈骗、催收及号段正则拦截库",
      "manifest_url": "https://raw.githubusercontent.com/<owner>/<repo>/main/rules/CN/rules.json",
      "cdn_manifest_url": "https://cdn.jsdelivr.net/gh/<owner>/<repo>@main/rules/CN/rules.json"
    },
    {
      "id": "FR",
      "name": "France / 法国",
      "icon_url": "https://raw.githubusercontent.com/<owner>/<repo>/main/assets/flags/fr.png",
      "description": "法国商业推广与高频骚扰号码拦截库",
      "manifest_url": "https://raw.githubusercontent.com/<owner>/<repo>/main/rules/FR/rules.json",
      "cdn_manifest_url": "https://cdn.jsdelivr.net/gh/<owner>/<repo>@main/rules/FR/rules.json"
    },
    {
      "id": "US",
      "name": "United States / 美国",
      "icon_url": "https://raw.githubusercontent.com/<owner>/<repo>/main/assets/flags/us.png",
      "description": "美国 FCC 数据与高频骚扰诈骗拦截规则库",
      "manifest_url": "https://raw.githubusercontent.com/<owner>/<repo>/main/rules/US/rules.json",
      "cdn_manifest_url": "https://cdn.jsdelivr.net/gh/<owner>/<repo>@main/rules/US/rules.json"
    }
  ],
  "plugins_recommendation": {
    "title": "探索高级防骚扰插件",
    "description": "发现更多开源社区维护的来电与短信在线云查识别插件",
    "web_portal_url": "https://github.com/<owner>/<repo>/plugins"
  }
}
```

### 2.2 字段说明
| 字段 | 类型 | 必填 | 含义 |
| :--- | :--- | :--- | :--- |
| `id` | String | 是 | ISO 3166-1 alpha-2 大写国家代号（如 `CN`, `US`, `FR`），用于匹配客户端 IP 定位与优先自动勾选 |
| `name` | String | 是 | 展示名称 |
| `icon_url` | String | 否 | 国旗或图标链接 |
| `description`| String | 是 | 规则简述说明 |
| `manifest_url` | String | 是 | GitHub 原始规则下载链接 |
| `cdn_manifest_url` | String | 否 | 对应 CDN 镜像加速下载链接 |

---

## 3. 底层国家规则库标准 (`rules.json`)

每个国家 `manifest_url` 指向的必须是**纯 JSON 数组**，数组中每一项由客户端 `RuleRepositoryImpl.createRuleFromMap` 解析。

### 3.1 规则 JSON 规范样例

```json
[
  {
    "id": "cn-phone-001",
    "name": "恶意推销高频电话",
    "phoneNumber": "19512345678",
    "action": "block",
    "ruleType": "phone_rule",
    "isEnabled": 1
  },
  {
    "id": "cn-regex-001",
    "name": "95号段商业推广电话",
    "pattern": "^(95[0-9]{6,})$",
    "action": "block",
    "ruleType": "regex",
    "isEnabled": 1
  },
  {
    "id": "cn-allow-001",
    "name": "公共紧急服务电话",
    "phoneNumber": "110",
    "action": "allow",
    "ruleType": "allow_block",
    "isEnabled": 1
  }
]
```

### 3.2 规则字段约束
- `ruleType`: 必填，支持 `phone_rule`（普通号码规则）、`regex`（正则规则）、`allow_block`（显式黑白名单规则）。
- `action`: 必填，必须为 `block`（拦截阻止）、`allow`（放行允许）、`silence`（静音）。
- `phoneNumber`: 当 `ruleType` 为 `phone_rule` 或 `allow_block` 时必填。
- `pattern`: 当 `ruleType` 为 `regex` 时必填，正则表达式必须转义斜杠。
- `isEnabled`: 整数，`1` 表示启用，`0` 表示禁用。

---

## 4. 容错与 CDN 加速规则
1. **GitHub Raw 限制**：由于部分地区访问 `raw.githubusercontent.com` 存在网络波动，必须同时提供 CDN 链接（如 jsDelivr: `https://cdn.jsdelivr.net/gh/<user>/<repo>@<branch>/...` 或 ghproxy）。
2. **客户端本地兜底 (Built-in Fallback)**：客户端必须内置一份离线基础 `app_setup_config.json`，在无网络时兜底展示，绝不允许白屏或完全阻塞用户。
