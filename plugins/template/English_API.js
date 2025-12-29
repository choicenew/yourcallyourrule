// [Plugin Name] - API Solution Universal Template V1.0 (API Version)
// =======================================================================================
// TEMPLATE DESCRIPTION:
// This is a standardized template for creating API-based phone number query plugins.
// Unlike the iframe version, this template directly calls third-party APIs to get data.
//
// CORE FEATURES:
// 1. User Configuration (settings): Plugins can define required settings (e.g., API Key),
//    which users fill in the App.
// 2. Direct API Call: Use `fetch` to get JSON data directly.
//
// WORKFLOW:
// 1. Flutter calls `generateOutput`.
// 2. Plugin retrieves API Key from `window.plugin[ID].config`.
// 3. Builds API request URL.
// 4. Sends request and parses JSON response.
// 5. Sends result back to App via `sendToFlutter`.
// =======================================================================================

(function () {
    // IIFE to encapsulate scope

    // --- SECTION 1: Core Plugin Configuration (MUST BE MODIFIED) ---
    const PLUGIN_CONFIG = {
        id: 'yourUniqueApiPluginId', // Unique ID (camelCase)
        name: 'Your API Plugin Name', // Readable name
        version: '1.0.0', // Version
        description: 'Query phone info via Official API.', 
        // [NEW] Settings Definition
        settings: [
            {
                key: 'api_key',       // Accessed via config.api_key
                label: 'API Key',     // UI Label
                type: 'text',         // 'text', 'password', etc.
                hint: 'Enter API Key from website', // Hint
                required: true        // Is required?
            }
        ]
    };

    // --- SECTION 2: Data Mapping & Keywords ---
    
    /**
     * @constant {Array<Object>} predefinedLabels - Standard app labels.
     */
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

    /**
     * @constant {Object} manualMapping - Map API values to standard labels.
     */
    const manualMapping = {
        'scam': 'Fraud Scam Likely',
        'sales': 'Telemarketing',
        'delivery': 'Delivery',
    };

    // --- SECTION 3: Generic Framework ---
    function log(message) { console.log(`[${PLUGIN_CONFIG.id} v${PLUGIN_CONFIG.version}] ${message}`); }
    function logError(message, error) { console.error(`[${PLUGIN_CONFIG.id} v${PLUGIN_CONFIG.version}] ${message}`, error); }

    function sendToFlutter(channel, data) {
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler(channel, JSON.stringify(data));
        } else {
            logError(`Cannot send to Flutter on channel '${channel}', handler not available.`);
        }
    }

    function sendPluginResult(result) {
        log(`Sending final result to Flutter: ${JSON.stringify(result)}`);
        sendToFlutter('PluginResultChannel', result);
    }

    function sendPluginLoaded() {
        log('Plugin loaded, notifying Flutter.');
        sendToFlutter('TestPageChannel', { type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version });
    }

    // --- SECTION 4: API Query Logic (Core) ---
    
    async function performApiQuery(phoneNumber, requestId) {
        log(`Starting API query for ${phoneNumber}`);
        
        // 1. Get Config
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const apiKey = config.api_key;

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: 'API Key not configured.' });
            return;
        }

        // 2. Build Request
        const apiUrl = `https://api.example.com/v1/phone/${encodeURIComponent(phoneNumber)}?key=${encodeURIComponent(apiKey)}`;
        
        const fetchOptions = {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        };

        try {
            // 3. Execute Fetch
            const response = await fetch(apiUrl, fetchOptions);
            
            if (!response.ok) {
                throw new Error(`API response error: ${response.status} ${response.statusText}`);
            }

            const data = await response.json();
            log(`API response received: ${JSON.stringify(data)}`);

            // 4. Parse Result
            let sourceLabel = data.type || '';
            let predefinedLabel = 'Unknown';
            let action = 'none';

            if (manualMapping[sourceLabel]) {
                predefinedLabel = manualMapping[sourceLabel];
            }

            if (predefinedLabel === 'Fraud Scam Likely' || predefinedLabel === 'Spam Likely') {
                action = 'block';
            }

            const result = {
                requestId,
                phoneNumber,
                sourceLabel,
                predefinedLabel,
                action,
                province: data.province || '',
                city: data.city || '',
                carrier: data.carrier || '',
                count: data.report_count || 0,
                success: true,
                source: PLUGIN_CONFIG.id
            };

            sendPluginResult(result);

        } catch (error) {
            logError('API Query failed', error);
            sendPluginResult({ requestId, success: false, error: error.toString() });
        }
    }


    // --- SECTION 5: Public API ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput called for requestId: ${requestId}`);
        const numberToQuery = phoneNumber || nationalNumber || e164Number;
        
        if (numberToQuery) {
            performApiQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
        }
    }

    // --- SECTION 6: Initialization ---
    function initialize() {
        if (window.plugin && window.plugin[PLUGIN_CONFIG.id]) {
            return;
        }
        if (!window.plugin) {
            window.plugin = {};
        }
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG, 
            generateOutput: generateOutput,
            config: {} // App will inject values here
        };
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
