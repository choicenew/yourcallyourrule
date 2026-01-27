// [English_API.js] - FlutterJS Universal API Plugin Template V6.0 (Native Channel)
// =======================================================================================
// TEMPLATE DESCRIPTION:
// Standard API Plugin for English services using Native Channel (httpFetch).
// Core Logic:
// 1. Request: sendMessage('httpFetch')
// 2. Response: handleResponse (Async Callback)
// 3. Parsing: JSON.parse
// =======================================================================================

(function() {
    // --- SECTION 1: Config ---
    const PLUGIN_CONFIG = {
        id: 'yourApiPluginIdEn',
        name: 'API Plugin Template (EN)',
        version: '6.0.0',
        description: 'Standard API Plugin using Native Channel',
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: 'Enter your API Key',
                required: true
            },
            {
                key: 'successMarker',
                label: 'Success Marker',
                type: 'text',
                hint: 'Optional Bypass Marker',
                required: false
            }
        ]
    };

    // --- SECTION 2: Mapping ---
    const manualMapping = { 'Scam': 'Fraud Scam Likely', 'Spam': 'Spam Likely' };
    const blockKeywords = ['Scam', 'Spam'];

    // --- SECTION 3: Helpers ---
    function log(msg) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${msg}`); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id })); }
    function sendPluginResult(res) { sendMessage('PluginResultChannel', JSON.stringify(res)); }

    // --- SECTION 4: Request ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Querying API: ${phoneNumber}`);
        
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
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
            successMarker: successMarker
        }));
    }

    // --- SECTION 5: Response ---
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
            const action = blockKeywords.includes(label) ? 'block' : 'none';

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

    // --- SECTION 6: Init ---
    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No number" });
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
