// [cleverdialer copy.js] - Cleverdialer Plugin Copy (Pure FlutterJS Regex V6.1)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function () {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'cleverdialerPlugin',
        name: 'Cleverdialer (Regex)',
        version: '6.1.0',
        description: 'Queries cleverdialer.com for phone number information using Regex.',
        config: {
            successMarker: "cleverdialer",
        },
        settings: [
            {
                key: 'successMarker',
                label: 'Success Marker',
                type: 'text',
                hint: '过盾标识',
                required: false
            }
        ]
    };

    const manualMapping = {
        'Agencia de cobranza': 'Debt Collection', 'Apuestas': 'Other', 'Asesoría': 'Other', 'Buzón': 'Other',
        'Donación': 'Charity', 'Dudoso': 'Spam Likely', 'Encuesta': 'Survey', 'Fraude criptográfico': 'Fraud Scam Likely',
        'Gastronomia': 'Other', 'Llamada Ping': 'Spam Likely', 'Llamadas recurrentes': 'Spam Likely', 'Negocio': 'Other',
        'Phishing': 'Fraud Scam Likely', 'Prestación de Servicio': 'Customer Service', 'Publicidad': 'Telemarketing',
        'Salud': 'Medical', 'Servicio al cliente': 'Customer Service', 'Soporte': 'Customer Service', 'Spam': 'Spam Likely',
        'Trampa de costos': 'Fraud Scam Likely', 'Ventas': 'Telemarketing', 'Unknown': 'Unknown', 'Enervante': 'Spam Likely',
        'Neutral': 'Unknown', 'Positivo': 'Other', 'Excelente': 'Other', 'BUSINESS': 'Telemarketing', 'CHARITY': 'Charity',
        'COMMERCIAL': 'Telemarketing', 'CONTINUOUS_CALLS': 'Spam Likely', 'COST_TRAP': 'Fraud Scam Likely', 'COUNSEL': 'Other',
        'CRYPTO_FRAUD': 'Fraud Scam Likely', 'CUSTOMER_SERVICE': 'Customer Service', 'DEBT_COLLECTION_AGENCY': 'Debt Collection',
        'DUBIOUS': 'Spam Likely', 'HEALTH': 'Medical', 'HOSPITALITY': 'Other', 'MAILBOX': 'Other', 'PHISHING': 'Fraud Scam Likely',
        'SILENT_CALL': 'Silent Call Voice Clone', 'SALES': 'Telemarketing', 'SERVICE': 'Customer Service', 'SUPPORT': 'Customer Service',
        'SURVEY': 'Survey', 'SWEEPSTAKE': 'Other', 'Beratung': 'Other', 'Crypto Betrug': 'Fraud Scam Likely', 'Daueranrufe': 'Spam Likely',
        'Dienstleistung': 'Customer Service', 'Geschäft': 'Other', 'Gesundheit': 'Medical', 'Gewinnspiel': 'Other',
        'Inkassounternehmen': 'Debt Collection', 'Kostenfalle': 'Fraud Scam Likely', 'Kundendienst': 'Customer Service',
        'Mailbox': 'Other', 'Ping Anruf': 'Spam Likely', 'Spenden': 'Charity', 'Umfrage': 'Survey', 'Unseriös': 'Spam Likely',
        'Verkauf': 'Telemarketing', 'Werbung': 'Telemarketing', 'Bitte auswählen': 'Unknown'
    };

    const blockKeywords = ['Fraud', 'Spam', 'Telemarketing', 'Robocall', 'Debt', 'Risk', 'Silent', 'Scam', 'Phishing', 'Kostenfalle', 'Unseriös'];
    const allowKeywords = ['Delivery', 'Takeaway', 'Insurance', 'Customer', 'Bank', 'Medical', 'Charity'];

    // --- Helpers ---
    function log(message) { console.log(`[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message, error) { console.error(`[${PLUGIN_CONFIG.id}] ${message}`, error); }

    function sendPluginResult(result) {
        if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(result));
        } else if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(result));
        }
    }

    function sendPluginLoaded() {
        if (typeof sendMessage === 'function') {
            sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
        } else if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
        }
    }

    // --- Core Logic ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query: ${phoneNumber}`);

        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "cleverdialer";
        const userAgent = config.userAgent || 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

        const targetUrl = `https://www.cleverdialer.com/phonenumber/${phoneNumber}`;
        const headers = { 'User-Agent': userAgent };

        try {
            sendMessage('httpFetch', JSON.stringify({
                url: targetUrl,
                method: 'GET',
                headers: headers,
                pluginId: PLUGIN_CONFIG.id,
                phoneRequestId: requestId,
                successMarker: successMarker
            }));
        } catch (e) {
            logError('Query Setup Failed', e);
            sendPluginResult({ requestId, success: false, error: 'Setup Failed: ' + e.toString() });
        }
    }

    function parseHTML(html) {
        const result = {
            sourceLabel: '', count: 0, province: '', city: '', carrier: '',
            name: '', predefinedLabel: '', source: PLUGIN_CONFIG.name, numbers: [], success: false, error: '', action: 'none'
        };

        if (!html) return result;

        try {
            // 1. Label Extraction
            const labelRegex = /<td\s+class=["']callertype["'][^>]*>([\s\S]*?)<\/td>/i;
            const labelMatch = html.match(labelRegex);
            if (labelMatch) {
                result.sourceLabel = labelMatch[1].trim();
                result.predefinedLabel = manualMapping[result.sourceLabel] || 'Unknown';
            }

            // 2. Star Rating Extraction
            if (!result.sourceLabel) {
                const starRegex = /class=["'][^"']*front-stars\s+stars-(\d)[^"']*["']/i;
                const starMatch = html.match(starRegex);
                if (starMatch) {
                    const score = parseInt(starMatch[1], 10);
                    result.sourceLabel = `stars-${score}`;
                    if (score <= 2) result.predefinedLabel = 'Spam Likely';
                    else if (score >= 4) result.predefinedLabel = 'Other';
                    else result.predefinedLabel = 'Unknown';
                }
            }

            // 3. Count Extraction
            const countRegex = /<span\s+class=["']nowrap["'][^>]*>[\s\S]*?(\d+)[\s\S]*?(Bewertungen|ratings|valoraciones)[\s\S]*?<\/span>/i;
            const countMatch = html.match(countRegex);
            if (countMatch) {
                result.count = parseInt(countMatch[1], 10);
            } else {
                const blockedRegex = /class=["']text-blocked["'][^>]*>(\d+)/i;
                const blockedMatch = html.match(blockedRegex);
                if (blockedMatch) result.count = parseInt(blockedMatch[1], 10);
            }

            // 4. City Extraction
            const cityRegex = /class=["']list-text["']>[\s\S]*?<h4>([\s\S]*?)<\/h4>/i;
            const cityMatch = html.match(cityRegex);
            if (cityMatch) result.city = cityMatch[1].trim();

            if (result.sourceLabel || result.count > 0 || result.city) {
                result.success = true;
            }

            return result;
        } catch (e) {
            logError("Regex Parse Error", e);
            result.error = e.message;
            return result;
        }
    }

    function handleResponse(response) {
        log("handleResponse called.");

        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch (e) { }
        }

        if (response === "BUFFER") {
            // Buffer legacy
        }

        const requestId = final.requestId || final.phoneRequestId;
        if (!final.success) {
            sendPluginResult({ requestId, success: false, error: final.error || "HTTP Error" });
            return;
        }

        const html = final.responseText || "";
        const parsed = parseHTML(html);

        if (parsed.success) {
            const label = parsed.predefinedLabel || parsed.sourceLabel;
            if (label) {
                let determinedAction = 'none';
                for (const k of blockKeywords) { if (label.includes(k)) { determinedAction = 'block'; break; } }
                if (determinedAction === 'none') {
                    for (const k of allowKeywords) { if (label.includes(k)) { determinedAction = 'allow'; break; } }
                }
                parsed.action = determinedAction;
            }
        }

        parsed.requestId = requestId;
        sendPluginResult(parsed);
    }

    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No Number" });
    }

    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = { info: PLUGIN_CONFIG, generateOutput: generateOutput, handleResponse: handleResponse, config: {} };
        log(`Plugin registered. Version ${PLUGIN_CONFIG.version}`);
        sendPluginLoaded();
    }

    initialize();
})();
