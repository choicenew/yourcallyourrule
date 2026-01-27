// [Universal_Regex_API_HTML_CN.js] - FlutterJS 通用正则 HTML 插件模板 V6.0
// =======================================================================================
// 模板说明:
// 专为 "HTML 下载 + 正则提取" 场景设计 (QuickJS 环境)。
// 移除了 async/await 的 httpFetch 调用，改为 Native 回调模式。
// =======================================================================================

(function() {
    // --- 区域 1: 配置 ---
    const PLUGIN_CONFIG = {
        id: 'universalRegexHtmlCn',
        name: '通用 HTML 正则插件 (CN)',
        version: '6.0.0',
        description: 'Universal Regex Plugin using Native Channel',
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

    // --- 区域 2: 映射 (略) ---
    const manualMapping = { 'scam': 'Fraud Scam Likely' };
    const blockKeywords = ['诈骗'];

    // --- 区域 3: 工具 ---
    function log(msg) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${msg}`); }
    function logError(msg) { sendMessage('Log', `[ERROR] ${msg}`); }
    function sendPluginResult(res) { sendMessage('PluginResultChannel', JSON.stringify(res)); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id })); }

    // --- 区域 4: 请求 ---
    function initiateQuery(phoneNumber, requestId) {
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
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
            successMarker: successMarker
        }));
    }

    // --- 区域 5: 响应与正则 ---
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
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
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

        sendPluginResult({
            requestId,
            success: hasContent,
            source: PLUGIN_CONFIG.name,
            sourceLabel: sourceLabel || "No Match",
            predefinedLabel: manualMapping[sourceLabel.toLowerCase()] || 'Unknown',
            action: blockKeywords.some(k => sourceLabel.includes(k)) ? 'block' : 'none'
        });
    }

    // --- 区域 6: 初始化 ---
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
