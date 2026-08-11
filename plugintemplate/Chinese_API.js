// [Chinese_API.js] - FlutterJS 通用 API 插件模板 V6.0 (Native Channel)
// =======================================================================================
// 模板说明:
// 本模板适用于标准的 REST JSON API 对接。
// 核心逻辑:
// 1. 请求: 使用 sendMessage('httpFetch') 发送 POST/GET 请求。
// 2. 接收: handleResponse 接收 JSON 字符串。
// 3. 解析: JSON.parse 解析结果 (非 HTML Regex)。
// =======================================================================================

(function() {
    // --- 区域 1: 配置 ---
    const PLUGIN_CONFIG = {
        id: 'yourApiPluginId',
        name: 'API Plugin Template (CN)',
        version: '6.0.0',
        description: 'Standard API Plugin using Native Channel',
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: '请输入 API Key',
                required: true
            },
            {
                key: 'username',
                label: '用户名',
                type: 'text',
                hint: '可选用户 ID',
                required: false
            },
            {
                key: 'successMarker',
                label: 'Success Marker (可选)',
                type: 'text',
                hint: '用于 API 过盾的特征词 (通常 API 不需此项，但保留以防万一)',
                required: false
            }
        ]
    };

    // --- 区域 2: 映射 (标准结构) ---
    const manualMapping = { 'scam': 'Fraud Scam Likely', 'spam': 'Spam Likely' };
    const blockKeywords = ['诈骗', '骚扰'];

    // --- 区域 3: 工具 ---
    function log(msg) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${msg}`); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id })); }
    function sendPluginResult(res) { sendMessage('PluginResultChannel', JSON.stringify(res)); }

    // --- 区域 4: 发起请求 ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Querying API: ${phoneNumber}`);
        
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const apiKey = config.api_key;
        const successMarker = config.successMarker || null;

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: "Missing API Key" });
            return;
        }

        // 构造请求
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
            successMarker: successMarker 
        }));
    }

    // --- 区域 5: 响应处理 ---
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
            // 解析 API JSON
            // 假设返回结构: { type: "scam", count: 10 }
            const data = JSON.parse(final.responseText);
            
            const sourceLabel = data.type || "Unknown";
            const count = data.count || 0;
            
            let action = 'none';
            if (sourceLabel === 'scam') action = 'block';

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

    // --- 区域 6: 入口与初始化 ---
    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No Number" });
    }

    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse,
            config: {}
        };
        sendPluginLoaded();
    }
    initialize();
})();
