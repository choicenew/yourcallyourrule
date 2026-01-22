// Slick.ly Phone Query Plugin - Modern Scout Regex Solution (Traditional Chinese)
// =======================================================================================
// 说明:
// 此插件专为 Slick.ly (HK/TW/MO) 设计，采用了最新的 Scout (httpFetch) 架构。
// 相比旧版 Iframe 方案，它更轻量、更快，且能自动利用 Scout 的过盾能力。
// =======================================================================================

(function() {
    // 使用 IIFE 封装
    
    // --- 区域 1: 插件核心配置 ---
    const PLUGIN_CONFIG = {
        id: 'slicklyTwHkPhoneNumberPlugin', // 保持 ID 一致以兼容现有配置
        name: 'Slick.ly TW/HK/MO Lookup (Scout Regex)',
        version: '3.0.0', // V3: Legacy Architecture (Fire-and-Forget) 
        description: 'Modern Scout-based plugin for Slick.ly. Supports automatic shield handling and fast regex parsing.'
    };

    // --- 区域 2: 标签映射与关键字 (完全迁移自旧版) ---
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
        '危險': 'Risk', '安全': 'Other', '詐騙': 'Fraud Scam Likely', '騙局': 'Fraud Scam Likely',
        '垃圾郵件': 'Spam Likely', '騷扰': 'Spam Likely', '騷擾': 'Spam Likely', '電話行銷': 'Telemarketing',
        '自動拨號': 'Robocall', '自动拨号': 'Robocall', '送貨': 'Delivery', '外卖': 'Takeaway',
        '外賣': 'Takeaway', '保險': 'Insurance', '貸款': 'Loan', '金融': 'Financial',
        '銀行': 'Bank', '補習': 'Education', '滋擾': 'Spam Likely'
    };

    const blockKeywords = [
        '推銷', '廣告', '違规', '詐騙', '騙子', '滋擾', '騷擾', '危險', '风险', 'Risk', 'Scam'
    ];

    const allowKeywords = [
        '外賣', '送貨', '快遞', '叫車', '安全', 'Safe'
    ];

    // --- 区域 3: 辅助工具函数 ---
    function log(message) { console.log(`[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message, error) { console.error(`[${PLUGIN_CONFIG.id}] ${message}`, error); }

    function sendPluginResult(result) {
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(result));
        }
    }

    function sendPluginLoaded() {
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
        }
    }

    // --- 区域 4: 核心查询逻辑 (Fire-and-Forget) ---
    async function initiateQuery(phoneNumber, requestId, countryCode) {
        log(`Initiating Scout query for '${phoneNumber}' [${countryCode}] (requestId: ${requestId})`);

        const formattedNumber = phoneNumber.replace(/[^0-9]/g, '');
        const targetSearchUrl = `https://slick.ly/${countryCode}/${formattedNumber}`;
        
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        // [Fix] JS Context has no 'navigator'. Use hardcoded Android UA to match WebView.
        // This solves the "Windows vs Android" fingerprint mismatch.
        const userAgent = config.userAgent || 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36';
        const headers = { 'User-Agent': userAgent };

        try {
            log(`Fetching HTML from: ${targetSearchUrl}`);
            
            // Fire and Forget - Legacy Style
            // Native will call window.plugin['slicklyTwHkPhoneNumberPlugin'].handleResponse(...)
            sendMessage('httpFetch', JSON.stringify({
                url: targetSearchUrl,
                method: 'GET',
                headers: headers,
                pluginId: PLUGIN_CONFIG.id,
                phoneRequestId: requestId
            }));
            
            log("Legacy Request sent. Waiting for handleResponse...");

        } catch (e) {
            logError('Query Setup Failed', e);
            sendPluginResult({ requestId, success: false, error: 'Setup Failed: ' + e.toString() });
        }
    }

    // --- 区域 5: 响应处理逻辑 (Legacy Pattern) ---
    function handleResponse(response) {
        log("handleResponse called.");
        
        try {
             var finalResponse = null;

             // [Legacy V3 Fix] Direct Object Priority
             // If Native sends an Object, use it immediately. 
             // Do not check buffer unless told to do so.
             if (response && typeof response === 'object') {
                 log("handleResponse: Received Direct Object.");
                 finalResponse = response;
             } 
             // If Native sends a Signal String (e.g. "BUFFER")
             else if (response === "BUFFER" || (!response && globalThis._native_buffer)) {
                 log("handleResponse: Buffer Signal received.");
                 var buffer = globalThis._native_buffer || (window && window._native_buffer);
                 if (buffer && typeof buffer === 'string') {
                      var decoded = decodeURIComponent(escape(atob(buffer)));
                      finalResponse = JSON.parse(decoded);
                      
                      if (globalThis._native_buffer) globalThis._native_buffer = null;
                      if (window && window._native_buffer) window._native_buffer = null;
                 }
             }
             // Support legacy String (Base64) fallback just in case
             else if (typeof response === 'string') {
                  try {
                      var decoded = decodeURIComponent(escape(atob(response)));
                      finalResponse = JSON.parse(decoded);
                  } catch(e) {
                      finalResponse = JSON.parse(response);
                  }
             }

             if (finalResponse) {
                processResponse(finalResponse.requestId || finalResponse.phoneRequestId, finalResponse);
             } else {
                logError("handleResponse: Final response is null or invalid type: " + typeof response);
             }

        } catch (e) {
             logError("handleResponse Error", e);
             var reqId = response ? (response.requestId || response.phoneRequestId) : 'unknown';
             sendPluginResult({ requestId: reqId, success: false, error: "handleResponse Error: " + e });
        }
    }

    function processResponse(requestId, response) {
            // NativeRequestChannel returns { success: bool, status: int, responseText: string, ... }
            if (!response || response.status !== 200) {
                var err = response ? response.error || response.status : 'Unknown Native Error';
                logError(`HTTP Error: ${err}`);
                sendPluginResult({ requestId, success: false, error: `HTTP Error: ${err}` });
                return;
            }

            const html = response.responseText || "";
            
            // --- 正则提取逻辑 ---
            // 1. 提取 Summary 结果 (危险/安全)
            let summaryLabel = '';
            const summaryMatch = html.match(/<span class="summary-result">([^<]+)<\/span>/i);
            if (summaryMatch) summaryLabel = summaryMatch[1].trim();

            // 2. 提取 Keywords
            let keywordsText = '';
            const keywordsMatch = html.match(/<div class="keywords"><span>([^<]+)<\/span>/i);
            if (keywordsMatch) keywordsText = keywordsMatch[1].trim();

            // 3. 提取注释数量
            let count = 0;
            const countMatch = html.match(/註釋\s*\((\d+)\)/i);
            if (countMatch) count = parseInt(countMatch[1], 10);

            log(`Parsed: Summary=[${summaryLabel}], Keywords=[${keywordsText}], Count=[${count}]`);

            // --- 智能分类决策 ---
            let sourceLabel = keywordsText || summaryLabel || '';
            let predefinedLabel = 'Unknown';
            let action = 'none';

            // 映射逻辑
            const mappingSource = (keywordsText + " " + summaryLabel).split(/[,，\s]+/).filter(x => x);
            for (let part of mappingSource) {
                if (manualMapping[part]) {
                    predefinedLabel = manualMapping[part];
                    break;
                }
            }

            // 行为判断
            const checkStr = (sourceLabel + " " + predefinedLabel).toLowerCase();
            if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
                action = 'block';
            } else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
                action = 'allow';
            }

            // 返回最终结果
            sendPluginResult({
                requestId,
                success: (summaryLabel || keywordsText || count > 0),
                source: PLUGIN_CONFIG.name,
                phoneNumber: '', // Not strictly needed for return
                sourceLabel: sourceLabel || 'No specific label found',
                predefinedLabel: predefinedLabel,
                action: action,
                name: '', 
                count: count
            });
    }

    // --- 区域 6: 插件入口 ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput called for requestId: ${requestId}`);
        
        // 国家代码识别
        let countryCode = 'tw'; // 默认
        if (e164Number && e164Number.startsWith('+')) {
            if (e164Number.startsWith('+852')) countryCode = 'hk';
            else if (e164Number.startsWith('+853')) countryCode = 'mo';
            else if (e164Number.startsWith('+886')) countryCode = 'tw';
        }

        const numberToQuery = phoneNumber || nationalNumber;
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId, countryCode);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number.' });
        }
    }

    // --- 区域 7: 初始化 ---
    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse, // Legacy Registration
            config: {}
        };
        log(`Plugin registered. Using Legacy Architecture V3 (Fire-and-Forget).`);
        sendPluginLoaded();
    }

    initialize();

})();