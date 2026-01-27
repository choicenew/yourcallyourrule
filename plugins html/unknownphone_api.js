// [UnknownPhone] - Native RequestChannel Solution Universal Template V5.2 (Absolute Complete Version)
// =======================================================================================
// TEMPLATE DESCRIPTION:
// Standardized API plugin template. Strictly aligns with the Iframe version (English.js) structure.
//
// CORE FEATURES:
// 1. User Configuration (settings): Users enter API Key etc. in the App.
// 2. Native Request: Uses RequestChannel (Native HTTP) to bypass WebView limitations.
// 3. Structural Consistency: Separates `initiateQuery` and `generateOutput` exactly like the Iframe template.
// =======================================================================================

(function () {
    // IIFE to isolate scope

    // --- SECTION 1: Plugin Configuration (MUST MODIFY) ---
    const PLUGIN_CONFIG = {
        id: 'unknownPhonePlugin', // Unique Plugin ID
        name: 'UnknownPhone API Lookup', // Readable Plugin Name
        version: '1.2.1', // Plugin Version
        description: 'Queries UnknownPhone API using Native RequestChannel.', // Plugin Description
        // Settings Definition
        settings: [
            {
                key: 'api_key',       // Setting Key
                label: 'API Key',     // UI Label
                type: 'text',         // Input Type
                hint: 'Enter UnknownPhone API Key', // Input Hint
                required: true        // Is Required
            },
            {
                key: 'lang',
                label: 'Language Code',
                type: 'text',
                hint: 'e.g: es, en (default en)',
                required: false
            }
        ]
    };

    // --- SECTION 2: Data Mapping & Keywords (Modify as needed) ---

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
     * @constant {Object} manualMapping - Manual mapping table.
     */
    const manualMapping = {
        'scam': 'Fraud Scam Likely',
        'spam': 'Spam Likely',
        'sales': 'Telemarketing',
        'delivery': 'Delivery',
    };

    const blockKeywords = [
        'Scam', 'Fraud', 'Spam', 'Telemarketing', 'Robocall'
    ];

    const allowKeywords = [
        'Delivery', 'Support', 'Bank', 'Courier', 'Service'
    ];

    // --- SECTION 3: Generic Framework (No need to modify) ---
    function log(message) { console.log(`[${PLUGIN_CONFIG.id} v${PLUGIN_CONFIG.version}] ${message}`); }
    function logError(message, error) { console.error(`[${PLUGIN_CONFIG.id} v${PLUGIN_CONFIG.version}] ${message}`, error); }

    function sendToFlutter(channel, data) {
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler(channel, JSON.stringify(data));
        } else {
            console.error(`Native channel '${channel}' not found.`);
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

    // --- SECTION 4.1: Internal State (Request Cache) ---
    const requestCache = {};

    // --- SECTION 4: Native Request Logic ---
    function sendNativeRequest(options) {
        const payload = {
            method: options.method,      // 'GET', 'POST', 'PUT', 'DELETE'
            url: options.url,            // Full URL
            headers: options.headers,    // Http Headers
            body: options.body || null,  // Body (for POST/PUT)
            phoneRequestId: options.requestId,
            externalRequestId: options.requestId
        };

        log(`Sending Native Request: ${payload.method} ${payload.url}`);
        
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('RequestChannel', JSON.stringify(payload));
        } else {
            sendPluginResult({ requestId: options.requestId, success: false, error: 'RequestChannel unavailable.' });
        }
    }

    // --- SECTION 5: Query Initiation Logic (Modify as needed) ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating query for '${phoneNumber}' (requestId: ${requestId})`);
        
        // Cache the request
        requestCache[requestId] = phoneNumber;

        // 1. Get Config (Injected by App)
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const apiKey = config.api_key || 'd7e07fec659645b12df76c94e378d47a'; // Default Key
        const lang = config.lang || 'en';
        const userAgent = config.userAgent || 'okhttp/3.14.9';

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: 'API Key not configured.' });
            return;
        }

        // 2. Build API Request
        const targetSearchUrl = "https://secure.unknownphone.com/api2/";
        
        // Manual body string for strict order
        // Note: encodeURIComponent(phoneNumber) ensures safe transfer
        const bodyString = `user_type=free&api_key=${apiKey}&phone=${encodeURIComponent(phoneNumber)}&_action=_get_info_for_phone&lang=${lang}`;
        
        const headers = {
            "Content-Type": "application/x-www-form-urlencoded",
            "User-Agent": userAgent,
            "Host": "secure.unknownphone.com", 
            "Connection": "Keep-Alive"
        };

        sendNativeRequest({
            method: 'POST',
            url: targetSearchUrl, 
            headers: headers,
            body: bodyString,
            requestId: requestId
        });
    }

    // --- SECTION 6: Response Handling Logic (Core Parsing) ---
    function handleResponse(response) {
        log('Received response from Native layer');
        
        const requestId = response.phoneRequestId;
        const statusCode = response.status;
        const responseText = response.responseText; // Raw text

        // Retrieve original phone number from cache
        const originalPhoneNumber = requestCache[requestId] || '';
        delete requestCache[requestId]; // Clean up

        if (statusCode !== 200) {
            logError(`HTTP Error: ${statusCode}`);
            sendPluginResult({ requestId, success: false, error: `HTTP Error ${statusCode}` });
            return;
        }

        try {
            // 1. Parse JSON
            const data = JSON.parse(responseText);
            
            // 2. Extract Fields
            const avgRatingsStr = data.avg_ratings || "3";
            const avgRating = parseFloat(avgRatingsStr);
            // < 3 is bad/dangerous
            const isSpam = avgRating < 3; 

            const sourceLabel = isSpam ? `Rating: ${avgRating}` : 'Safe';
            
            // 3. Intelligent Action Logic
            let predefinedLabel = isSpam ? 'Spam Likely' : 'Unknown';
            let action = isSpam ? 'block' : 'none';

            // 4. Return Result
            const result = {
                requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                phoneNumber: data.number || originalPhoneNumber,
                sourceLabel: sourceLabel,
                predefinedLabel: predefinedLabel,
                action: action,
                // Other fields
                name: isSpam ? "Flagged Number" : "Unknown",
                count: data.comments_count || 0,
                rating: avgRating
            };
            
            sendPluginResult(result);

        } catch (e) {
            logError('Parsing Error', e);
            sendPluginResult({ requestId, success: false, error: 'JSON Parse Failed: ' + e.message });
        }
    }

    // --- SECTION 7: Public Interface (No need to modify) ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput called for requestId: ${requestId}`);
        const numberToQuery = e164Number || phoneNumber || nationalNumber;
        
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
        }
    }

    // --- SECTION 8: Initialization & Registration (No need to modify) ---
    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse, 
            config: {}
        };
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
