// ListaSpam ES Phone Query Plugin - Modern Scout Regex Solution
// =======================================================================================
// 说明:
// 此插件专为 ListaSpam.com 设计，采用了 Scout (httpFetch) 架构。
// 支持通过 ShieldBypassService 进行过盾处理，适用于需要点击验证的情况。
// =======================================================================================

(function() {
    
    // --- 区域 1: 插件核心配置 ---
    const PLUGIN_CONFIG = {
        id: 'listaspamHtmlPlugin', 
        name: 'ListaSpam ES Lookup (Scout Regex)',
        version: '1.1.0',
        description: 'Modern Scout-based plugin for ListaSpam. Matches slicklyHK pattern for robust bypass support.',
        config: {
            // [Generic Shield Logic] Tell Native what to wait for.
            successMarker: "number_data_box", 
        }
    };

    // --- 区域 2: 完整标签映射 (完全同步自原版 listaspam.js) ---
    const manualMapping = {
        'Suplantación de identidad': 'Fraud Scam Likely',
        'Presunta estafa': 'Fraud Scam Likely',
        'Presuntas amenazas': 'Fraud Scam Likely',
        'Cobro de deudas': 'Debt Collection',
        'Telemarketing': 'Telemarketing',
        'Llamada de broma': 'Spam Likely',
        'Mensaje SMS': 'Spam Likely',
        'Encuesta': 'Survey',
        'Recordatorio automático': 'Robocall',
        'Llamada perdida': 'Spam Likely',
        'Sin especificar': 'Unknown',
        'Unknown' : 'Unknown',
        'Spam Call' : 'Spam Likely',
        'Beratung': 'Other',
        'Crypto Betrug': 'Fraud Scam Likely',
        'Daueranrufe': 'Spam Likely',
        'Dienstleistung': 'Customer Service',
        'Gastronomie': 'Other',
        'Geschäft': 'Other',
        'Gesundheit': 'Medical',
        'Gewinnspiel': 'Other',
        'Inkassounternehmen': 'Debt Collection',
        'Kostenfalle': 'Fraud Scam Likely',
        'Kundendienst': 'Customer Service',
        'Mailbox': 'Other',
        'Phishing': 'Fraud Scam Likely',
        'Ping Anruf': 'Spam Likely',
        'Spam': 'Spam Likely',
        'Spenden': 'Charity',
        'Support': 'Customer Service',
        'Umfrage': 'Survey',
        'Unseriös': 'Spam Likely',
        'Verkauf': 'Telemarketing',
        'Werbung': 'Telemarketing',
        'Business': 'Other',
        'Charity': 'Charity',
        'Commercial': 'Telemarketing',
        'Continuous calls': 'Spam Likely',
        'Cost trap': 'Fraud Scam Likely',
        'Counsel': 'Other',
        'Crypto fraud': 'Fraud Scam Likely',
        'Customer Service': 'Customer Service',
        'Debt collection agency': 'Debt Collection',
        'Dubious': 'Spam Likely',
        'Health': 'Medical',
        'Hospitality industry': 'Other',
        'Ping call': 'Spam Likely',
        'Sales': 'Telemarketing',
        'Service': 'Customer Service',
        'Sweepstake': 'Other'
    };

    const blockKeywords = [
        'estafa', 'phishing', 'cobro', 'telemarketing', 'publicidad', 
        'spam', 'scam', 'fraud', 'fraudulent', 'identity'
    ];

    // --- 区域 3: 辅助工具函数 ---
    function log(message) { console.log(`[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message, error) { console.error(`[${PLUGIN_CONFIG.id}] ${message}`, error); }

    function sendPluginResult(result) {
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(result));
        } else if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(result));
        }
    }

    function sendPluginLoaded() {
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ 
                type: 'pluginLoaded', 
                pluginId: PLUGIN_CONFIG.id, 
                version: PLUGIN_CONFIG.version 
            }));
        }
    }

    // --- 区域 4: 核心查询逻辑 ---
    async function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Scout query for '${phoneNumber}' (requestId: ${requestId})`);

        const formattedNumber = phoneNumber.replace(/[^0-9]/g, '');
        
        if (!globalThis._active_phone_numbers) globalThis._active_phone_numbers = {};
        globalThis._active_phone_numbers[requestId] = formattedNumber;
        
        const targetSearchUrl = `https://www.listaspam.com/busca.php?Telefono=${formattedNumber}`;
        
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const userAgent = config.userAgent || 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36';
        const headers = { 'User-Agent': userAgent };
        
        const successMarker = config.successMarker || PLUGIN_CONFIG.config.successMarker;

        try {
            log(`Fetching HTML from: ${targetSearchUrl}`);
            
            sendMessage('httpFetch', JSON.stringify({
                url: targetSearchUrl,
                method: 'GET',
                headers: headers,
                pluginId: PLUGIN_CONFIG.id,
                phoneRequestId: requestId,
                successMarker: successMarker 
            }));
            
            log("ListaSpam Request sent. Waiting for handleResponse...");

        } catch (e) {
            logError('Query Setup Failed', e);
            sendPluginResult({ requestId, success: false, error: 'Setup Failed: ' + e.toString() });
        }
    }

    // --- 区域 5: 响应处理逻辑 ---
    function handleResponse(response) {
        log("handleResponse called for ListaSpam.");
        
        try {
             var finalResponse = null;
             if (response && typeof response === 'object') {
                 finalResponse = response;
             } else if (response === "BUFFER" || (!response && globalThis._native_buffer)) {
                 var buffer = globalThis._native_buffer || (window && window._native_buffer);
                 if (buffer && typeof buffer === 'string') {
                      var decoded = decodeURIComponent(escape(atob(buffer)));
                      finalResponse = JSON.parse(decoded);
                      if (globalThis._native_buffer) globalThis._native_buffer = null;
                 }
             }

             if (finalResponse) {
                processResponse(finalResponse.requestId || finalResponse.phoneRequestId, finalResponse);
             } else {
                logError("handleResponse: Response invalid.");
             }
        } catch (e) {
             logError("handleResponse Error", e);
             sendPluginResult({ requestId: 'unknown', success: false, error: "handleResponse Error: " + e });
        }
    }

    // --- 区域 6: HTML 解析逻辑 (Regex 架构) ---
    function parseHTML(html) {
        const result = {
            sourceLabel: '',
            count: 0,
            city: '',
            success: false
        };

        if (!html) return result;

        // 1. 匹配关键信息所在的 section (number_data_box)
        const labelOrder = Object.keys(manualMapping);

        for (const labelText of labelOrder) {
            // 匹配格式: <strong>Label</strong> (X veces/times/etc)
            const regex = new RegExp(`<strong>\\s*${labelText}\\s*</strong>\\s*\\((\\d+)`, 'i');
            const match = html.match(regex);
            if (match) {
                result.sourceLabel = labelText;
                result.count = parseInt(match[1], 10) || 0;
                result.success = true;
                break;
            }
        }

        // 2. 备用逻辑: 如果没找到上述特定标签，寻找通用的 rating 
        if (!result.success) {
            if (html.includes('phone_rating result-1') || html.includes('phone_rating result-2')) {
                result.sourceLabel = "Spam";
                result.success = true;
            }
            
            const countRegex = /n_reports[\s\S]*?result[\s\S]*?>(\d+)</i;
            const countMatch = html.match(countRegex);
            if (countMatch) {
                result.count = parseInt(countMatch[1], 10);
                result.success = true;
            }
        }

        const cityRegex = /data_location[\s\S]*?<span>([^<-]+)/i;
        const cityMatch = html.match(cityRegex);
        if (cityMatch) {
            result.city = cityMatch[1].trim();
        }

        return result;
    }

    function processResponse(requestId, response) {
        if (!response || response.status !== 200) {
            var err = response ? response.error || response.status : 'Unknown Native Error';
            sendPluginResult({ requestId, success: false, error: `HTTP Error: ${err}` });
            return;
        }

        const html = response.responseText || "";
        const parsed = parseHTML(html);

        log(`Parsed ListaSpam: Label=[${parsed.sourceLabel}], Count=[${parsed.count}], City=[${parsed.city}]`);

        let predefinedLabel = manualMapping[parsed.sourceLabel] || 'Unknown';
        let action = 'none';

        // 关键词拦截增强逻辑
        const checkStr = (parsed.sourceLabel + " " + predefinedLabel).toLowerCase();
        if (['Fraud Scam Likely', 'Risk', 'Debt Collection', 'Spam Likely'].includes(predefinedLabel) || 
            blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
            action = 'block';
        }

        const phoneNumber = globalThis._active_phone_numbers ? globalThis._active_phone_numbers[requestId] : 'unknown';
        if (globalThis._active_phone_numbers) delete globalThis._active_phone_numbers[requestId];

        sendPluginResult({
            requestId,
            success: parsed.success,
            source: PLUGIN_CONFIG.name,
            phoneNumber: phoneNumber,
            sourceLabel: parsed.sourceLabel || 'Untracked Info',
            predefinedLabel: predefinedLabel,
            action: action,
            name: '', 
            count: parsed.count,
            city: parsed.city
        });
    }

    // --- 区域 7: 插件入口 ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput (ListaSpam HTML) for: ${requestId}`);
        const numberToQuery = phoneNumber || nationalNumber;
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number.' });
        }
    }

    // --- 区域 8: 初始化 ---
    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse,
            config: {}
        };
        log(`ListaSpam HTML Plugin (Full Mapping) registered.`);
        sendPluginLoaded();
    }

    initialize();

})();
