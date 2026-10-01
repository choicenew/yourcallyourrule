---
name: plugin-automation-testing
description: 官方标准 JS 插件全流程自动化开发、调试与单测验证指南。内嵌 5 套官方全量标准模板（中文纯正则、通用 HTML 正则 CN/EN、REST API CN/EN），详解与 Native 通信协议、策略机制 (direct/render)、防封与 Cloudflare 盾突破原理。任何 AI 获得本项目与目标网页/API 后，均可基于本 Skill 独立完成插件编写、无模拟器测试与结果自愈校验。
---

# 🤖 Android 防骚扰/来电识别 JS 插件系统全流程自动化开发与测试指南 (Official Plugin Skill)

本 Skill 是 AI 智能体（及人类开发者）开发、测试和维护本系统 JavaScript 插件的**唯一权威标准规范**。Skill 内嵌了全部 5 套官方标准模板源码。将本项目代码与任何第三方号码查询网页（或 JSON API）交由 AI 后，AI 必须严格参照本指南与对应模板完成插件生成与单测闭环。

---

## 1. 系统核心使命与运行架构 (System Architecture)

### 1.1 核心使命
本系统是一个高性能 **Android 来电识别/防骚扰引擎**。系统通过动态加载拓展的 **JavaScript 插件**，在手机收到来电或用户搜索号码时，并发向第三方数据库（如 Tellows, Truecaller, Whoscall, 百度, 搜狗等）发起异步查询，提取并归一化输出：
- **机构/单位名称 (`name`)**：如 `"招商银行客服"`
- **原始来源标签 (`sourceLabel`)**：如 `"骚扰电话"`、`"广告推销"`、`"快递外卖"`
- **归一化内置标签 (`predefinedLabel`)**：如 `Spam Likely`, `Telemarketing`, `Delivery` 等
- **拦截/允许动作 (`action`)**：`'block'` (拦截), `'allow'` (放行), `'none'` (不处理)
- **标记/举报次数 (`count`)**：如 `128`

### 1.2 运行时双引擎架构 (Dual-Engine Execution)

```
                             ┌──────────────────────────────────────────────┐
                             │  来电/查询请求 (phoneNumber, national, e164) │
                             └──────────────────────┬───────────────────────┘
                                                    │
                                                    ▼
                             ┌──────────────────────────────────────────────┐
                             │ TransientPluginSession (闭环瞬时 QuickJS 沙盒)│
                             └──────────────────────┬───────────────────────┘
                                                    │
                                     ┌──────────────┴──────────────┐
                                     │   发起原生物理 HTTP (Dio)    │
                                     └──────────────┬──────────────┘
                                                    │
                                ┌───────────────────┴───────────────────┐
                                ▼                                       ▼
                       【直连模式 strategy: 'direct'】         【过盾模式 strategy: 'render'】
                         原生 HTTP (Dio + Chrome TLS)            触发 403/503 或验证码时
                         200 OK 网页直接传给 QuickJS             启动无头 WebView 模拟触控/滚屏
                         未标记号码直接返回 No Match            解锁后将 HTML/Cookies 传给 QuickJS
                                │                                       │
                                └───────────────────┬───────────────────┘
                                                    │
                                                    ▼
                                    【PluginResultChannel 归一化结果】
                                    毫秒级回调首个有效结果 ➔ 销毁 QuickJS RAM
```

1. **纯 QuickJS 瞬时闭环沙盒 (`TransientPluginSession`)**：
   - 运行环境为 **纯 QuickJS JS 引擎**，**不存在 DOM, `window.location`, `document`, `iframe` 等浏览器环境对象**。
   - 无来电时全系统 JS 引擎内存占用为 **0 MB**；有来电时秒级开辟沙盒，通过本地动态库（Windows 上为 `quickjs_c_bridge.dll`）执行多插件并发，用完即物理销毁。
2. **Native 网络通道与策略管理**：
   - **`strategy: 'direct'` (默认，直连模式)**：90%+ 搜索网站使用。原生 HTTP 直连提取。查无数据直接返回 No Match，绝不触发 WebView。
   - **`strategy: 'render'` (动态渲染/过盾模式)**：适用于 SPA 动态网页或触发 Cloudflare 503 阻断的场景。

---

## 2. 插件核心协议与全局 API (Protocol Specifications)

插件运行在 `globalThis` (或 `scope`) 作用域下，必须通过 `sendMessage` 函数与 Native 宿主双向通信。

### 2.1 注册与元数据注册 (`globalThis.plugin[id]`)

```javascript
(function(scope) {
  const PLUGIN_CONFIG = {
    id: 'yourUniquePluginId',
    name: 'Your Plugin Name',
    version: '6.0.0',
    description: 'Plugin description',
    config: { strategy: 'direct' }, // 'direct' | 'render'
    settings: [
      { key: 'api_key', label: 'API Key', type: 'text', hint: '请输入 Key', required: false },
      { key: 'successMarker', label: '成功标识', type: 'text', hint: '过盾特征词', required: false }
    ]
  };

  if (!scope.plugin) scope.plugin = {};
  scope.plugin[PLUGIN_CONFIG.id] = {
    info: PLUGIN_CONFIG,
    config: {}, // 运行时由 Native 注入
    generateOutput: generateOutput,
    handleResponse: handleResponse
  };
  
  sendPluginLoaded();
})(globalThis);
```

### 2.2 核心通信 API

| API 函数 / 通道 | 作用 | 示例 Payload / 代码 |
| :--- | :--- | :--- |
| `sendMessage('httpFetch', json)` | 异步发起 Native 网络请求 | `{ url, method, headers, body, pluginId, phoneRequestId, successMarker, strategy }` |
| `sendMessage('PluginResultChannel', json)` | 投递解析归一化后的最终结果 | `{ requestId, success, source, sourceLabel, predefinedLabel, action, count }` |
| `sendMessage('TestPageChannel', json)` | 告知 Native 插件脚本加载完成 | `{ type: 'pluginLoaded', pluginId, version }` |
| `sendMessage('Log', json)` | 打印带插件 ID 前缀的日志 | `sendMessage('Log', JSON.stringify("[pluginId] msg"))` |

---

## 3. 官方标准插件模板模块 (Official Standard Templates Module)

### 3.1 模板 1: `Chinese.js` (中文非 API 纯正则 HTML 提取模板 V6.0)

```javascript
// [Chinese.js] - FlutterJS 通用正则插件模板 V6.0 (纯Regex架构)
// =======================================================================================
// 模板说明:
// 本模板适用于 QuickJS 纯 JS 环境 (无 DOM/Window/Iframe)。
// 核心逻辑: 
// 1. 发起请求: 通过 sendMessage('httpFetch') 调用原生网络层。
// 2. 接收响应: Native 回调 handleResponse。
// 3. 解析内容: 使用 Regex (正则表达式) 从 HTML 文本中提取数据。
//
// 注意事项:
// - 不可使用 document, window.location, iframe 等 DOM 对象。
// - 必须保留 PLUGIN_CONFIG 中的 settings 结构。
// =======================================================================================

(function(scope) {
    // --- 区域 1: 插件核心配置 (必须修改) ---
    const PLUGIN_CONFIG = {
        id: 'yourUniqueChinesePluginId', // 插件唯一ID
        name: 'Your Chinese Plugin Name', // 插件名称
        version: '6.0.0', // 版本号
        description: 'Pure FlutterJS Regex Plugin for Chinese Websites',
        // --- strategy 策略说明 ---
        // 'direct' (默认): 原生 HTTP 直连模式。查无数据直接返回，不切 WebView。
        // 'render': 无头 WebView 动态渲染模式。适用于百度等 AJAX 动态网页。
        config: {
            strategy: 'direct', // 'direct' | 'render'
        },
        // 配置项定义 (不可删除)
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: '请输入 API Key (如适用)',
                required: false // 根据情况修改
            },
            {
                key: 'successMarker',
                label: '成功标识 (Success Marker)',
                type: 'text',
                hint: '用于过盾检测的 HTML 特征词 (如: summary-result)',
                required: false
            }
        ]
    };

    // --- 区域 2: 标签映射与关键字 ---
    const predefinedLabels = [
        { 'label': 'Fraud Scam Likely' }, { 'label': 'Spam Likely' }, { 'label': 'Telemarketing' },
        { 'label': 'Robocall' }, { 'label': 'Delivery' }, { 'label': 'Takeaway' },
        { 'label': 'Ridesharing' }, { 'label': 'Insurance' }, { 'label': 'Loan' },
        { 'label': 'Customer Service' }, { 'label': 'Unknown' }, { 'label': 'Financial' },
        { 'label': 'Bank' }, { 'label': 'Education' }, { 'label': 'Medical' },
        { 'label': 'Charity' }, { 'label': 'Other' }, { 'label': 'Debt Collection' },
        { 'label': 'Survey' }, { 'label': 'Political' }, { 'label': 'Ecommerce' },
        { 'label': 'Risk' }, { 'label': 'Agent' }, { 'label': 'Recruiter' },
        { 'label': 'Headhunter' }, { 'label': 'Silent Call Voice Clone' }, { 'label': 'Internet' },
        { 'label': 'Travel Ticketing' }, { 'label': 'Application Software' }, { 'label': 'Entertainment' },
        { 'label': 'Government' }, { 'label': 'Local Services' }, { 'label': 'Automotive Industry' },
        { 'label': 'Car Rental' }, { 'label': 'Telecommunication' },
    ];

    const manualMapping = {
        '骚扰': 'Spam Likely',
        '诈骗': 'Fraud Scam Likely',
        '推销': 'Telemarketing',
        '快递': 'Delivery',
        '外卖': 'Takeaway',
        '中介': 'Agent',
        '银行': 'Bank'
    };

    const blockKeywords = [
        '骚扰', '诈骗', '骗子', '推销', '广告', '风险', 'Risk', 'Scam'
    ];

    const allowKeywords = [
        '快递', '外卖', '送餐', '客服', '银行', '验证码', 'Delivery', 'Safe'
    ];

    // --- 区域 3: 辅助工具函数 ---
    function log(message) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] ${message}`)); }
    function logError(message) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] [ERROR] ${message}`)); }

    function sendPluginResult(result) {
        if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(result));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(result));
        }
    }

    function sendPluginLoaded() {
        if (typeof sendMessage === 'function') {
            sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
        }
    }

    // --- 区域 4: 核心查询逻辑 (Native Call) ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query for: ${phoneNumber} (ID: ${requestId})`);

        const config = (scope.plugin && scope.plugin[PLUGIN_CONFIG.id] && scope.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "result";
        
        const targetUrl = `https://www.example.com/search/${encodeURIComponent(phoneNumber)}`;

        const userAgent = "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36";
        const headers = { 
            'User-Agent': userAgent,
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8'
        };

        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: headers,
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker,
            strategy: config.strategy || 'direct'
        }));
    }

    // --- 区域 5: 纯正则解析器 ---
    function parseHTML(html) {
        const result = {
            sourceLabel: '',
            count: 0,
            hasContent: false
        };

        if (!html) return result;

        const labelRegex = /<div class=["']label["']>([^<]+)<\/div>/i;
        const labelMatch = html.match(labelRegex);
        if (labelMatch && labelMatch[1]) {
            result.sourceLabel = labelMatch[1].trim();
            result.hasContent = true;
        }

        const countRegex = /Reported\s+(\d+)\s+times/i;
        const countMatch = html.match(countRegex);
        if (countMatch && countMatch[1]) {
            result.count = parseInt(countMatch[1], 10);
            result.hasContent = true;
        }

        return result;
    }

    // --- 区域 6: 响应处理逻辑 ---
    function handleResponse(response) {
        log("handleResponse called.");
        
        let finalResponse = response;
        if (typeof response === 'string') {
            try { finalResponse = JSON.parse(response); } catch(e) { logError("JSON Parse Fail"); return; }
        }

        const requestId = finalResponse.requestId || finalResponse.phoneRequestId;
        if (!finalResponse.success && finalResponse.status !== 200) {
            sendPluginResult({ requestId, success: false, error: finalResponse.error || "HTTP Error" });
            return;
        }

        const html = finalResponse.responseText || "";
        
        const parsed = parseHTML(html);
        log(`Parsed: Label=[${parsed.sourceLabel}], Count=[${parsed.count}]`);

        let sourceLabel = parsed.sourceLabel || '';
        let predefinedLabel = 'Unknown';
        let action = 'none';

        if (manualMapping[sourceLabel]) {
            predefinedLabel = manualMapping[sourceLabel];
        } else {
             const key = Object.keys(manualMapping).find(k => sourceLabel.includes(k));
             if (key) predefinedLabel = manualMapping[key];
        }

        const checkStr = (sourceLabel + " " + predefinedLabel).toLowerCase();
        if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
            action = 'block';
        } else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
            action = 'allow';
        }

        sendPluginResult({
            requestId,
            success: parsed.hasContent,
            source: PLUGIN_CONFIG.name,
            phoneNumber: "",
            sourceLabel: sourceLabel,
            predefinedLabel: predefinedLabel,
            action: action,
            count: parsed.count
        });
    }

    // --- 区域 7: 插件入口 ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        const numberToQuery = phoneNumber || nationalNumber; 
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No phone number' });
        }
    }

    // --- 区域 8: 初始化 ---
    function initialize() {
        if (!scope.plugin) scope.plugin = {};
        scope.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse,
            config: {}
        };
        log("Plugin registered.");
        sendPluginLoaded();
    }

    initialize();
})();
```

---

### 3.2 模板 2: `Universal_Regex_API_HTML_CN.js` (通用正则 HTML 动态配置模板 CN V6.1.2)

```javascript
// [Universal_Regex_API_HTML_CN.js] - FlutterJS 通用正则 HTML 插件模板 V6.1.2
// =======================================================================================
// 模板说明:
// 专为 "HTML 下载 + 正则提取" 场景设计 (QuickJS 环境)。
// 允许在设置界面动态配置 URL 模板与 label_regex。
// =======================================================================================

(function(scope) {
    const PLUGIN_CONFIG = {
        id: 'universalRegexHtmlCn',
        name: '通用 HTML 正则插件 (CN)',
        version: '6.1.2',
        description: 'Universal Regex Plugin using Native Channel',
        config: { strategy: 'direct' },
        settings: [
            {
                key: 'target_url',
                label: 'URL 模板',
                type: 'text',
                hint: 'https://ex.com/s/{num}',
                required: true
            },
            {
                key: 'label_regex',
                label: 'Regex (捕获组1)',
                type: 'text',
                hint: 'class="tag">([^<]+)<',
                required: true
            },
            {
                key: 'successMarker',
                label: 'Success Marker',
                type: 'text',
                hint: '过盾标识',
                required: false
            }
        ]
    };

    const predefinedLabels = [
        { 'label': 'Fraud Scam Likely' }, { 'label': 'Spam Likely' }, { 'label': 'Telemarketing' },
        { 'label': 'Robocall' }, { 'label': 'Delivery' }, { 'label': 'Takeaway' },
        { 'label': 'Ridesharing' }, { 'label': 'Insurance' }, { 'label': 'Loan' },
        { 'label': 'Customer Service' }, { 'label': 'Unknown' }, { 'label': 'Financial' },
        { 'label': 'Bank' }, { 'label': 'Education' }, { 'label': 'Medical' },
        { 'label': 'Charity' }, { 'label': 'Other' }, { 'label': 'Debt Collection' },
        { 'label': 'Survey' }, { 'label': 'Political' }, { 'label': 'Ecommerce' },
        { 'label': 'Risk' }, { 'label': 'Agent' }, { 'label': 'Recruiter' },
        { 'label': 'Headhunter' }, { 'label': 'Silent Call Voice Clone' }, { 'label': 'Internet' }
    ];

    const manualMapping = { 'scam': 'Fraud Scam Likely' };
    const blockKeywords = ['骚扰', '诈骗', '骗子', '推销', '广告', '风险', 'Risk', 'Scam', '违规', '反动'];
    const allowKeywords = ['快递', '外卖', '送餐', '客服', '银行', '验证码', '出租', '滴滴', '优步'];

    function log(msg) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] ${msg}`)); }
    function logError(msg) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] [ERROR] ${msg}`)); }
    function sendPluginResult(res) {
        if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(res));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(res));
        }
    }
    function sendPluginLoaded() {
        if (typeof sendMessage === 'function') {
            sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        }
    }

    function initiateQuery(phoneNumber, requestId) {
        const config = (scope.plugin && scope.plugin[PLUGIN_CONFIG.id].config) || {};
        const urlTemplate = config.target_url;
        const successMarker = config.successMarker;

        if (!urlTemplate) {
            sendPluginResult({ requestId, success: false, error: "No URL Template" });
            return;
        }

        const targetUrl = urlTemplate.replace('{num}', encodeURIComponent(phoneNumber));

        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: { 
                'User-Agent': config.userAgent || 'Mozilla/5.0 (Linux; Android 10)' 
            },
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker,
            strategy: config.strategy || 'direct'
        }));
    }

    function handleResponse(response) {
        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch(e) {}
        }
        
        const requestId = final.requestId || final.phoneRequestId;

        if (!final.success && final.status !== 200) {
            sendPluginResult({ requestId, success: false, error: final.error });
            return;
        }

        const html = final.responseText || "";
        const config = (scope.plugin && scope.plugin[PLUGIN_CONFIG.id].config) || {};
        const regexStr = config.label_regex;

        let sourceLabel = "";
        let hasContent = false;

        if (regexStr) {
            try {
                const regex = new RegExp(regexStr, 'i');
                const match = html.match(regex);
                if (match) {
                    sourceLabel = (match[1] || match[0]).trim();
                    hasContent = true;
                }
            } catch(e) {
                logError("Regex Error: " + e.message);
            }
        }

        const cleanStr = (s) => (s || '').replace(/[\u00a0\s]+/g, ' ').trim().toLowerCase();
        const lowerLabel = cleanStr(sourceLabel);
        let predefinedLabel = 'Unknown';
        for (const key in manualMapping) {
            if (cleanStr(key) === lowerLabel) {
                predefinedLabel = manualMapping[key];
                break;
            }
        }
        if (predefinedLabel === 'Unknown') {
            const match = predefinedLabels.find(l => cleanStr(l.label) === lowerLabel);
            if (match) predefinedLabel = match.label;
        }

        const checkStr = (sourceLabel + " " + predefinedLabel).toLowerCase();
        let action = 'none';
        if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'block';
        else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'allow';

        sendPluginResult({
            requestId,
            success: hasContent,
            source: PLUGIN_CONFIG.name,
            sourceLabel: sourceLabel || "No Match",
            predefinedLabel: predefinedLabel,
            action: action
        });
    }

    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No Number" });
    }

    function initialize() {
        if (!scope.plugin) scope.plugin = {};
        scope.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse,
            config: {}
        };
        sendPluginLoaded();
    }
    initialize();
})(globalThis);
```

---

### 3.3 模板 3: `Universal_Regex_API_HTML_EN.js` (通用正则 HTML 动态配置模板 EN V6.1.2)

```javascript
// [Universal_Regex_API_HTML_EN.js] - FlutterJS Universal HTML Regex Template V6.1.2
// =======================================================================================
// TEMPLATE DESCRIPTION:
// Universal Template for HTML Scraping via Regex in QuickJS.
// Uses Native Channel for HTTP requests.
// =======================================================================================

(function(scope) {
    const PLUGIN_CONFIG = {
        id: 'universalRegexHtmlEn',
        name: 'Universal HTML Regex (EN)',
        version: '6.1.2',
        description: 'Universal Regex Plugin using Native Channel',
        config: { strategy: 'direct' },
        settings: [
            { key: 'target_url', label: 'URL Template', type: 'text', hint: 'https://ex.com/s/{num}', required: true },
            { key: 'label_regex', label: 'Regex (Group 1)', type: 'text', hint: 'class="tag">([^<]+)<', required: true },
            { key: 'successMarker', label: 'Success Marker', type: 'text', hint: 'Bypass Marker', required: false }
        ]
    };

    const predefinedLabels = [
        { 'label': 'Fraud Scam Likely' }, { 'label': 'Spam Likely' }, { 'label': 'Telemarketing' },
        { 'label': 'Robocall' }, { 'label': 'Delivery' }, { 'label': 'Takeaway' },
        { 'label': 'Ridesharing' }, { 'label': 'Insurance' }, { 'label': 'Loan' },
        { 'label': 'Customer Service' }, { 'label': 'Unknown' }, { 'label': 'Financial' },
        { 'label': 'Bank' }, { 'label': 'Education' }, { 'label': 'Medical' },
        { 'label': 'Charity' }, { 'label': 'Other' }, { 'label': 'Debt Collection' }
    ];

    const manualMapping = { 'scam': 'Fraud Scam Likely' };
    const blockKeywords = ['Scam', 'Fraud', 'Spam', 'Telemarketing', 'Risk', 'Robocall'];
    const allowKeywords = ['Delivery', 'Courier', 'Support', 'Bank', 'Safe', 'Legit'];

    function log(msg) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] ${msg}`)); }
    function logError(msg) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] [ERROR] ${msg}`)); }
    function sendPluginResult(res) {
        if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(res));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(res));
        }
    }
    function sendPluginLoaded() {
        if (typeof sendMessage === 'function') {
            sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        }
    }

    function initiateQuery(phoneNumber, requestId) {
        const config = (scope.plugin && scope.plugin[PLUGIN_CONFIG.id].config) || {};
        const urlTemplate = config.target_url;
        const successMarker = config.successMarker;

        if (!urlTemplate) {
            sendPluginResult({ requestId, success: false, error: "No URL Template" });
            return;
        }

        const targetUrl = urlTemplate.replace('{num}', encodeURIComponent(phoneNumber));

        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: { 'User-Agent': 'Mozilla/5.0 (Linux; Android 10)' },
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker,
            strategy: config.strategy || 'direct'
        }));
    }

    function handleResponse(response) {
        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch(e) {}
        }
        
        const requestId = final.requestId || final.phoneRequestId;

        if (!final.success) {
            sendPluginResult({ requestId, success: false, error: final.error });
            return;
        }

        const html = final.responseText || "";
        const config = (scope.plugin && scope.plugin[PLUGIN_CONFIG.id].config) || {};
        const regexStr = config.label_regex;

        let sourceLabel = "No Match";
        let hasContent = false;

        if (regexStr) {
            try {
                const regex = new RegExp(regexStr, 'i');
                const match = html.match(regex);
                if (match) {
                    sourceLabel = (match[1] || match[0]).trim();
                    hasContent = true;
                }
            } catch(e) {}
        }

        const cleanStr = (s) => (s || '').replace(/[\u00a0\s]+/g, ' ').trim().toLowerCase();
        const lowerLabel = cleanStr(sourceLabel);
        let predefinedLabel = 'Unknown';
        for (const key in manualMapping) {
            if (cleanStr(key) === lowerLabel) {
                predefinedLabel = manualMapping[key];
                break;
            }
        }
        if (predefinedLabel === 'Unknown') {
            const match = predefinedLabels.find(l => cleanStr(l.label) === lowerLabel);
            if (match) predefinedLabel = match.label;
        }

        const checkStr = (sourceLabel + " " + predefinedLabel).toLowerCase();
        let action = 'none';
        if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'block';
        else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'allow';

        sendPluginResult({
            requestId,
            success: hasContent,
            source: PLUGIN_CONFIG.name,
            sourceLabel: sourceLabel || "No Match",
            predefinedLabel: predefinedLabel,
            action: action
        });
    }

    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No Number" });
    }

    function initialize() {
        if (!scope.plugin) scope.plugin = {};
        scope.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse,
            config: {}
        };
        sendPluginLoaded();
    }
    initialize();
})(globalThis);
```

---

### 3.4 模板 4: `Chinese_API.js` (中文 REST JSON API 插件模板 V6.0)

```javascript
// [Chinese_API.js] - FlutterJS 通用 API 插件模板 V6.0 (Native Channel)
// =======================================================================================
// 模板说明:
// 本模板适用于标准的 REST JSON API 对接。
// 核心逻辑:
// 1. 请求: 使用 sendMessage('httpFetch') 发送 POST/GET 请求。
// 2. 接收: handleResponse 接收 JSON 字符串。
// 3. 解析: JSON.parse 解析结果 (非 HTML Regex)。
// =======================================================================================

(function(scope) {
    const PLUGIN_CONFIG = {
        id: 'yourApiPluginId',
        name: 'API Plugin Template (CN)',
        version: '6.0.0',
        description: 'Standard API Plugin using Native Channel',
        config: { strategy: 'direct' },
        settings: [
            { key: 'api_key', label: 'API Key', type: 'text', hint: '请输入 API Key', required: true },
            { key: 'username', label: '用户名', type: 'text', hint: '可选用户 ID', required: false },
            { key: 'successMarker', label: 'Success Marker (可选)', type: 'text', hint: '用于 API 过盾的特征词', required: false }
        ]
    };

    const predefinedLabels = [
        { 'label': 'Fraud Scam Likely' }, { 'label': 'Spam Likely' }, { 'label': 'Telemarketing' },
        { 'label': 'Robocall' }, { 'label': 'Delivery' }, { 'label': 'Takeaway' },
        { 'label': 'Ridesharing' }, { 'label': 'Insurance' }, { 'label': 'Loan' },
        { 'label': 'Customer Service' }, { 'label': 'Unknown' }, { 'label': 'Financial' },
        { 'label': 'Bank' }, { 'label': 'Education' }, { 'label': 'Medical' }
    ];

    const manualMapping = { 'scam': 'Fraud Scam Likely', 'spam': 'Spam Likely' };
    const blockKeywords = ['诈骗', '骚扰', '广告', '风险', '虚假', '违法'];
    const allowKeywords = ['快递', '送餐', '外卖', '客服', '银行', '验证码', '出租', '滴滴', '优步'];

    function log(msg) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] ${msg}`)); }
    function sendPluginLoaded() {
        if (typeof sendMessage === 'function') {
            sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        }
    }
    function sendPluginResult(res) {
        if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(res));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(res));
        }
    }

    function initiateQuery(phoneNumber, requestId) {
        log(`Querying API: ${phoneNumber}`);
        const config = (scope.plugin && scope.plugin[PLUGIN_CONFIG.id] && scope.plugin[PLUGIN_CONFIG.id].config) || {};
        const apiKey = config.api_key;
        const successMarker = config.successMarker || null;

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: "Missing API Key" });
            return;
        }

        const url = "https://api.example.com/v1/check";
        const body = JSON.stringify({
            number: phoneNumber,
            key: apiKey
        });

        sendMessage('httpFetch', JSON.stringify({
            url: url,
            method: 'POST',
            headers: { 
                'Content-Type': 'application/json',
                'User-Agent': config.userAgent || 'App/1.0'
            },
            body: body,
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker,
            strategy: config.strategy || 'direct'
        }));
    }

    function handleResponse(response) {
        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch(e) {}
        }
        
        const requestId = final.requestId || final.phoneRequestId;

        if (!final.success && final.status !== 200) {
            sendPluginResult({ requestId, success: false, error: final.error || "API Error" });
            return;
        }

        try {
            const data = JSON.parse(final.responseText);
            const sourceLabel = data.type || "Unknown";
            const count = data.count || 0;
            
            const checkStr = (sourceLabel + " " + (manualMapping[sourceLabel] || 'Unknown')).toLowerCase();
            let action = 'none';
            if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'block';
            else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'allow';

            sendPluginResult({
                requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                sourceLabel: sourceLabel,
                predefinedLabel: manualMapping[sourceLabel] || 'Unknown',
                action: action,
                count: count
            });
        } catch(e) {
            sendPluginResult({ requestId, success: false, error: "Parse Error: " + e.message });
        }
    }

    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No Number" });
    }

    function initialize() {
        if (!scope.plugin) scope.plugin = {};
        scope.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse,
            config: {}
        };
        sendPluginLoaded();
    }
    initialize();
})(globalThis);
```

---

### 3.5 模板 5: `English_API.js` (英文 REST JSON API 插件模板 V6.0)

```javascript
// [English_API.js] - FlutterJS Universal API Plugin Template V6.0 (Native Channel)
// =======================================================================================
// TEMPLATE DESCRIPTION:
// Standard API Plugin for English services using Native Channel (httpFetch).
// Core Logic:
// 1. Request: sendMessage('httpFetch')
// 2. Response: handleResponse (Async Callback)
// 3. Parsing: JSON.parse
// =======================================================================================

(function(scope) {
    const PLUGIN_CONFIG = {
        id: 'yourApiPluginIdEn',
        name: 'API Plugin Template (EN)',
        version: '6.0.0',
        description: 'Standard API Plugin using Native Channel',
        config: { strategy: 'direct' },
        settings: [
            { key: 'api_key', label: 'API Key', type: 'text', hint: 'Enter your API Key', required: true },
            { key: 'successMarker', label: 'Success Marker', type: 'text', hint: 'Optional Bypass Marker', required: false }
        ]
    };

    const predefinedLabels = [
        { 'label': 'Fraud Scam Likely' }, { 'label': 'Spam Likely' }, { 'label': 'Telemarketing' },
        { 'label': 'Robocall' }, { 'label': 'Delivery' }, { 'label': 'Takeaway' },
        { 'label': 'Ridesharing' }, { 'label': 'Insurance' }, { 'label': 'Loan' },
        { 'label': 'Customer Service' }, { 'label': 'Unknown' }, { 'label': 'Financial' }
    ];

    const manualMapping = { 'Scam': 'Fraud Scam Likely', 'Spam': 'Spam Likely' };
    const blockKeywords = ['Scam', 'Spam', 'Fraud', 'Telemarketing', 'Risk', 'Robocall'];
    const allowKeywords = ['Delivery', 'Courier', 'Support', 'Bank', 'Safe', 'Legit'];

    function log(msg) { if (typeof sendMessage === 'function') sendMessage('Log', JSON.stringify(`[${PLUGIN_CONFIG.id}] ${msg}`)); }
    function sendPluginLoaded() {
        if (typeof sendMessage === 'function') {
            sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
        }
    }
    function sendPluginResult(res) {
        if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(res));
        } else if (scope.flutter_inappwebview && scope.flutter_inappwebview.callHandler) {
            scope.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(res));
        }
    }

    function initiateQuery(phoneNumber, requestId) {
        log(`Querying API: ${phoneNumber}`);
        const config = (scope.plugin && scope.plugin[PLUGIN_CONFIG.id].config) || {};
        const apiKey = config.api_key;
        const successMarker = config.successMarker;

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: "Missing API Key" });
            return;
        }

        const url = "https://api.unknown.com/lookup";
        const body = JSON.stringify({ number: phoneNumber });

        sendMessage('httpFetch', JSON.stringify({
            url: url,
            method: 'POST',
            headers: { 
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json' 
            },
            body: body,
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker,
            strategy: config.strategy || 'direct'
        }));
    }

    function handleResponse(response) {
        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch(e) {}
        }
        
        const requestId = final.requestId || final.phoneRequestId;

        if (!final.success) {
            sendPluginResult({ requestId, success: false, error: final.error });
            return;
        }

        try {
            const data = JSON.parse(final.responseText);
            const label = data.label || "Unknown";
            const checkStr = (label + " " + (manualMapping[label] || 'Unknown')).toLowerCase();
            let action = 'none';
            if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'block';
            else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'allow';

            sendPluginResult({
                requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                sourceLabel: label,
                predefinedLabel: manualMapping[label] || 'Unknown',
                action: action,
                count: data.reports || 0
            });
        } catch(e) {
            sendPluginResult({ requestId, success: false, error: "Parse Error: " + e.message });
        }
    }

    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No number" });
    }

    function initialize() {
        if (!scope.plugin) scope.plugin = {};
        scope.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse,
            config: {}
        };
        sendPluginLoaded();
    }
    initialize();
})(globalThis);
```

---

## 4. AI 自动化插件测试 SOP (Full AI Automated Workflow)

当用户向 AI 提交**一个插件源码**或**一个网页/API 文档**时，AI 必须严格执行以下 5 步 SOP：

### Step 1: 判定插件类型与模版选择
1. 若对接 REST / JSON API，使用 **`Chinese_API.js`** 或 **`English_API.js`**。
2. 若抓取网页 HTML 源码，使用 **`Chinese.js`**、**`Universal_Regex_API_HTML_CN.js`** 或 **`Universal_Regex_API_HTML_EN.js`**。
3. **环境硬性约束：环境为纯 QuickJS，严禁使用 `document`, `window.location`, `DOMParser` 等浏览器对象！**

### Step 2: 提取与核验正则表达式 / API JSON 字段
1. 若为网页抓取模式：查看原生控制台打印的全量 HTML Dump 日志：
   ```
   📄 [NATIVE HTML DUMP START] --------------------------------
   <html> ... 源码 ... </html>
   📄 [NATIVE HTML DUMP END] ----------------------------------
   ```
2. 比对 HTML 中的目标节点，确保正则表达式使用 ES2020 语法，且捕获组 1 (`match[1]`) 准确提取 `sourceLabel` 与 `count`。

### Step 3: 免模拟器单测运行 (Execution via `plugindemo`)
在 `plugindemo` 环境下，无需启动模拟器，直接调用 `PluginTestService` 触发 FFI 单元测试：
```dart
final service = PluginTestService();
await service.initialize();
final result = await service.testPlugin(pluginEntry, phoneNumber: '02112345678');
print('测试结果: $result');
```

### Step 4: 校验返回结果有效性
检查回调结果 Map 是否满足断言条件：
- `result['success'] == true`
- 包含有效业务数据：`sourceLabel` 不为空且不等于 `'No Match'`，或 `count > 0`。

### Step 5: 自愈与规则优化
- 若发现 403 / 503 阻断，将 `config.strategy` 改为 `'render'` 启动无头 WebView 过盾。
- 若提取标签乱码或包含 HTML 字符，使用 `.replace(/[\u00a0\s]+/g, ' ').trim()` 进行清理。

---

## 5. 标准枚举对照表 (Predefined Labels Reference)

| predefinedLabel 枚举值 | 含义 | 常见中文关联词 |
| :--- | :--- | :--- |
| `Fraud Scam Likely` | 诈骗电话 | 诈骗、涉诈、骗子、假冒公检法 |
| `Spam Likely` | 骚扰/非应邀电话 | 骚扰、广告、非应邀 |
| `Telemarketing` | 营销推销 | 推销、商业营销、房产推销 |
| `Robocall` | 自动语音 | 自动语音电话、机器人呼叫 |
| `Delivery` | 快递物流 | 快递、顺丰、圆通、中通、京东 |
| `Takeaway` | 外卖餐饮 | 外卖、美团、饿了么、送餐 |
| `Ridesharing` | 网约车/出租车 | 滴滴、网约车、出租车 |
| `Insurance` | 保险推销 | 保险、平安、人寿 |
| `Loan` | 贷款理财 | 贷款、网贷、催收 |
| `Customer Service` | 客服热线 | 官方客服、售后客服 |
| `Bank` | 银行电话 | 招商银行、工商银行、建行 |
| `Agent` | 中介经纪 | 房产中介、猎头、招聘 |
