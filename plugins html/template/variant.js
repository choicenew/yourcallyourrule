// [variant.js] - FlutterJS Variant Template V6.0 (Pure Regex)
// =======================================================================================
// TEMPLATE DESCRIPTION:
// A variant template optimized for specific country logic (e.g. Logic based on country code).
// Environment: QuickJS (No DOM).
// Architecture: Native Channel + Regex Parsing.
// =======================================================================================

(function() {
    // --- SECTION 1: Core Configuration ---
    const PLUGIN_CONFIG = {
        id: 'yourUniqueVariantPluginId',
        name: 'Variant Plugin (Regex)',
        version: '6.0.0',
        description: 'Country-aware Regex Plugin for QuickJS',
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: 'API Key (Optional)',
                required: false
            },
            {
                key: 'successMarker',
                label: 'Success Marker',
                type: 'text',
                hint: 'e.g. search-results',
                required: false
            }
        ]
    };

    // --- SECTION 2: Mapping ---
    const predefinedLabels = [ { 'label': 'Fraud Scam Likely' }, { 'label': 'Spam Likely' }, { 'label': 'Unknown' } ];
    const manualMapping = { 'Scam': 'Fraud Scam Likely', 'Spam': 'Spam Likely' };
    const blockKeywords = [ 'Spam', 'Scam' ];

    // --- SECTION 3: Helpers ---
    function log(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message) { sendMessage('Log', `[ERROR] ${message}`); }
    function sendPluginResult(result) { sendMessage('PluginResultChannel', JSON.stringify(result)); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id })); }

    // --- SECTION 4: Query Logic ---
    function initiateQuery(phoneNumber, requestId, countryCode) {
        log(`Querying: ${phoneNumber} [${countryCode}]`);

        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "wrapper";

        // Country-specific URL Logic
        const targetUrl = `https://www.example.com/${countryCode}/${encodeURIComponent(phoneNumber)}`;

        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: { 'User-Agent': 'Mozilla/5.0 (Linux; Android 10)' },
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker // ★ Bypassing Key ★
        }));
    }

    // --- SECTION 5: Parser ---
    function parseHTML(html) {
        const result = { sourceLabel: '', count: 0, hasContent: false };
        if (!html) return result;

        // Simple Regex Example
        const match = html.match(/<title>([^<]+)<\/title>/i);
        if (match && match[1]) {
            result.sourceLabel = match[1].trim();
            result.hasContent = true;
        }
        return result;
    }

    // --- SECTION 6: Response Handler ---
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

        const parsed = parseHTML(final.responseText || "");
        
        // Simple logic
        const action = parsed.sourceLabel.includes('Scam') ? 'block' : 'none';

        sendPluginResult({
            requestId,
            success: parsed.hasContent,
            source: PLUGIN_CONFIG.name,
            sourceLabel: parsed.sourceLabel,
            predefinedLabel: 'Unknown',
            action: action
        });
    }

    // --- SECTION 7: Entry Point ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        if (!e164Number) {
            sendPluginResult({ requestId, success: false, error: 'e164Number required for country detection' });
            return;
        }
        
        let countryCode = 'us'; // Default
        if (e164Number.startsWith('+44')) countryCode = 'uk';
        else if (e164Number.startsWith('+1')) countryCode = 'us';

        initiateQuery(e164Number.replace(/\+/g, ''), requestId, countryCode);
    }

    // --- SECTION 8: Init ---
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