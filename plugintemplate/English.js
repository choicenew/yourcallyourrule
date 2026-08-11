// [English.js] - FlutterJS Universal Regex Plugin Template V6.0 (Pure Regex)
// =======================================================================================
// TEMPLATE DESCRIPTION:
// This template is optimized for QuickJS (Pure JS) environment with NO DOM access.
// Core Logic:
// 1. Request: Use sendMessage('httpFetch') to call Native Network Layer.
// 2. Response: Receive callback via handleResponse.
// 3. Parsing: Use Regex to extract data from raw HTML strings.
//
// NOTES:
// - DO NOT use document, window.location, iframe, or any DOM APIs.
// - MUST preserve PLUGIN_CONFIG.settings structure.
// =======================================================================================

(function() {
    // --- SECTION 1: Core Configuration ---
    const PLUGIN_CONFIG = {
        id: 'yourUniqueEnglishPluginId', // Unique ID (camelCase)
        name: 'Your English Plugin Name', // Display Name
        version: '6.0.0',
        description: 'Pure FlutterJS Regex Plugin for English Websites',
        // Settings Definitions (DO NOT DELETE)
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: 'Enter API Key if applicable',
                required: false
            },
            {
                key: 'successMarker',
                label: 'Success Marker',
                type: 'text',
                hint: 'HTML string indicating successful load (e.g. summary-result)',
                required: false
            }
        ]
    };

    // --- SECTION 2: Mappings and Keywords ---
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
        'Scam': 'Fraud Scam Likely',
        'Spam': 'Spam Likely',
        'Telemarketer': 'Telemarketing',
        'Delivery': 'Delivery',
        'Courier': 'Delivery',
        'Agent': 'Agent',
        'Bank': 'Bank'
    };

    const blockKeywords = [
        'Spam', 'Scam', 'Fraud', 'Telemarketing', 'Risk', 'Robocall', 'Harassment'
    ];

    const allowKeywords = [
        'Delivery', 'Courier', 'Support', 'Bank', 'Safe', 'Legit'
    ];

    // --- SECTION 3: Helper Functions ---
    function log(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] [ERROR] ${message}`); }

    function sendPluginResult(result) {
        sendMessage('PluginResultChannel', JSON.stringify(result));
    }

    function sendPluginLoaded() {
        sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
    }

    // --- SECTION 4: Core Query Logic (Native Call) ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query for: ${phoneNumber} (ID: ${requestId})`);

        // 1. Get Config
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id] && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "reviews"; // Default Marker
        
        // 2. Build Target URL
        // [TODO]: Update URL template
        const targetUrl = `https://www.example.com/check/${encodeURIComponent(phoneNumber)}`;

        // 3. Build Headers
        // Use standard Android UA for consistency
        const userAgent = "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36";
        const headers = { 
            'User-Agent': userAgent,
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
        };

        // 4. Send Native Request
        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: headers,
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker // ★ Pass Success Marker for Bypass ★
        }));
    }

    // --- SECTION 5: Pure Regex Parser ---
    function parseHTML(html) {
        const result = {
            sourceLabel: '',
            count: 0,
            hasContent: false
        };

        if (!html) return result;

        // [TODO]: Write your regex here.
        // Example: <h1 class="status">Scam</h1>
        const labelRegex = /<h1[^>]*class=["']status["'][^>]*>([^<]+)<\/h1>/i;
        const labelMatch = html.match(labelRegex);
        if (labelMatch && labelMatch[1]) {
            result.sourceLabel = labelMatch[1].trim();
            result.hasContent = true;
        }

        return result;
    }

    // --- SECTION 6: Response Handling ---
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
        
        // Regex Parsing
        const parsed = parseHTML(html);
        log(`Parsed: Label=[${parsed.sourceLabel}]`);

        // Logic Decision
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
            sourceLabel: sourceLabel,
            predefinedLabel: predefinedLabel,
            action: action,
            count: parsed.count
        });
    }

    // --- SECTION 7: Entry Point ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        const numberToQuery = phoneNumber || nationalNumber; 
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No phone number' });
        }
    }

    // --- SECTION 8: Initialization ---
    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = {
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