// [Universal_Regex_API_HTML_EN.js] - FlutterJS Universal HTML Regex Template V6.0
// =======================================================================================
// TEMPLATE DESCRIPTION:
// Universal Template for HTML Scraping via Regex in QuickJS.
// Uses Native Channel for HTTP requests.
// =======================================================================================

(function() {
    const PLUGIN_CONFIG = {
        id: 'universalRegexHtmlEn',
        name: 'Universal HTML Regex (EN)',
        version: '6.0.0',
        description: 'Universal Regex Plugin using Native Channel',
        settings: [
            {
                key: 'target_url',
                label: 'URL Template',
                type: 'text',
                hint: 'https://ex.com/s/{num}',
                required: true
            },
            {
                key: 'label_regex',
                label: 'Regex (Group 1)',
                type: 'text',
                hint: 'class="tag">([^<]+)<',
                required: true
            },
            {
                key: 'successMarker',
                label: 'Success Marker',
                type: 'text',
                hint: 'Bypass Marker',
                required: false
            }
        ]
    };

    const manualMapping = { 'scam': 'Fraud Scam Likely' };
    const blockKeywords = ['Scam', 'Fraud'];

    function log(msg) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${msg}`); }
    function sendPluginResult(res) { sendMessage('PluginResultChannel', JSON.stringify(res)); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id })); }

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
            headers: { 'User-Agent': 'Mozilla/5.0 (Linux; Android 10)' },
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker
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
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
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

        sendPluginResult({
            requestId,
            success: hasContent,
            source: PLUGIN_CONFIG.name,
            sourceLabel: sourceLabel,
            predefinedLabel: 'Unknown', // Enhancements needed here
            action: blockKeywords.some(k => sourceLabel.includes(k)) ? 'block' : 'none'
        });
    }

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
