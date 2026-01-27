// [doisjerepondre.js] - Doisjerepondre Plugin (Pure FlutterJS Regex V6.0)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function() {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'doisjerepondrePlugin',
        name: 'Doisjerepondre.fr (Regex)',
        version: '6.0.0', 
        description: 'Queries doisjerepondre.fr for phone number information using Regex.',
        settings: [
             { key: 'successMarker', label: 'Success Marker', type: 'text', hint: 'Bypass Marker', required: false }
        ]
    };

    const manualMapping = {
        'Télévendeur': 'Telemarketing', 'Centre d\'appel': 'Customer Service', 'Services financiers': 'Financial',
        'Agent de recouvrement': 'Debt Collection', 'Entreprise': 'Other', 'Service': 'Customer Service',
        'Organisation à but non lucratif': 'Charity', 'Sondage': 'Survey', 'Appel malveillant': 'Fraud Scam Likely',
        'Appel non sollicité': 'Spam Likely', 'Appel politique': 'Political', 'Appel d\'arnaque': 'Fraud Scam Likely',
        'Canular téléphonique': 'Spam Likely', 'Autre': 'Other', 'Inconnu': 'Unknown', 'Unknown': 'Unknown'
    };

    const blockKeywords = ['malveillant', 'arnaque', 'non sollicité', 'Canular', 'Télévendeur', 'recouvrement', 'Fraud', 'Spam'];
    const allowKeywords = ['Service', 'Entreprise', 'financiers', 'Charity'];

    // --- Helpers ---
    function log(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] [ERROR] ${message}`); }
    function sendPluginResult(result) { sendMessage('PluginResultChannel', JSON.stringify(result)); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version })); }

    // --- Core Logic ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query: ${phoneNumber}`);
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "doisjerepondre"; 

        const targetUrl = `https://www.doisjerepondre.fr/numero-de-telephone/${phoneNumber}`;
        const headers = { 
            'User-Agent': config.userAgent || 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36'
        };

        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: headers,
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker
        }));
    }

    function parseHTML(html) {
        const result = {
            sourceLabel: '', count: 0, province: '', city: '', carrier: '',
            name: '', predefinedLabel: '', source: PLUGIN_CONFIG.id, numbers: [], success: false, error: '', action: 'none'
        };

        if (!html) return result;

        try {
            // 1. Number Block Extraction (contains label and city)
            // <div class="number"> +33... <span style="color:#000">Label</span> ... <span>City</span></div>
            const numberBlockRegex = /<div\s+class=["']number["']>([\s\S]*?)<\/div>/i;
            const numberBlockMatch = html.match(numberBlockRegex);

            if (numberBlockMatch) {
                const blockContent = numberBlockMatch[1];
                
                // Label
                const labelRegex = /<span\s+style=["']color:#000["']>([\s\S]*?)<\/span>/i;
                const labelMatch = blockContent.match(labelRegex);
                if (labelMatch) {
                    let rawLabel = labelMatch[1].trim();
                     // Remove prefixes like "Négative", "Neutre", "Positive" if present in the text (often they are not inside the span, but just in case)
                    rawLabel = rawLabel.replace(/^(Négative|Neutre|Positive)\s*/i, '').trim();
                    result.sourceLabel = rawLabel;
                    result.predefinedLabel = manualMapping[rawLabel] || 'Unknown';
                    result.success = true;
                }

                // City (Last span)
                const allSpans = blockContent.match(/<span[^>]*>([\s\S]*?)<\/span>/gi);
                if (allSpans && allSpans.length > 0) {
                     const lastSpan = allSpans[allSpans.length - 1];
                     const innerText = lastSpan.replace(/<\/?span[^>]*>/g, '').trim();
                     const parts = innerText.split(',');
                     result.city = parts[parts.length - 1].trim();
                }
            }

            // 2. Count Extraction
            // <div class="advanced"> ... <strong>12</strong> ...
            const advancedRegex = /<div\s+class=["']advanced["'][\s\S]*?<strong>\s*(\d+)\s*<\/strong>/i;
            const countMatch = html.match(advancedRegex);
            if (countMatch) {
                result.count = parseInt(countMatch[1], 10);
                result.success = true;
            } else if (html.includes('Nous avons une')) {
                result.count = 1;
                result.success = true;
            }

            return result;
        } catch (e) {
            logError("Regex Parse Error: " + e.message);
            result.error = e.message;
            return result;
        }
    }

    function handleResponse(response) {
        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch(e) {}
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
                 for (const k of blockKeywords) { if (label.toLowerCase().includes(k.toLowerCase())) { determinedAction = 'block'; break; } }
                 if (determinedAction === 'none') {
                     for (const k of allowKeywords) { if (label.toLowerCase().includes(k.toLowerCase())) { determinedAction = 'allow'; break; } }
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
        sendPluginLoaded();
    }

    initialize();
})();