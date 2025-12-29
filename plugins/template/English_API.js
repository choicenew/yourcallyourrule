// [Plugin Name] - Native RequestChannel Solution Universal Template V5.2 (Absolute Complete Version)
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
        id: 'yourUniqueApiPluginId', 
        name: 'Your API Plugin Name', 
        version: '5.2.0', 
        description: 'Native RequestChannel API Plugin Template',
        // Settings Definition
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: 'Enter API Key from website',
                required: true
            },
            {
                key: 'username',
                label: 'Username',
                type: 'text',
                hint: 'API Account Username (Optional)',
                required: false
            }
        ]
    };

    // --- SECTION 2: Data Mapping & Keywords (Modify as needed) ---

    // Standard app labels
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

    // Manual Mapping Table
    const manualMapping = {
        'scam': 'Fraud Scam Likely',
        'spam': 'Spam Likely',
        'sales': 'Telemarketing',
        'delivery': 'Delivery',
    };

    /**
     * @constant {Array<string>} blockKeywords - Keywords that determine 'block' action
     * @description If the parsed `sourceLabel` or `predefinedLabel` contains any keyword in this list,
     *              the `action` field in the result will be set to 'block'.
     */
    const blockKeywords = [
        'Scam', 'Fraud', 'Spam', 'Telemarketing', 'Robocall'
    ];

    /**
     * @constant {Array<string>} allowKeywords - Keywords that determine 'allow' action
     * @description If the parsed `sourceLabel` or `predefinedLabel` contains any keyword in this list,
     *              and it does not match block criteria, the `action` field will be set to 'allow'.
     */
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

    // --- SECTION 5: Query Initiation Logic (Must Modify) ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating query for '${phoneNumber}' (requestId: ${requestId})`);
        
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const apiKey = config.api_key;
        const username = config.username;
        const userAgent = config.userAgent || 'okhttp/3.14.9';

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: 'API Key not configured.' });
            return;
        }

        // ★★★ Build Target URL (Use 'targetSearchUrl' for Regex support) ★★★
        
        // Example A: GET Request
        /*
        const targetSearchUrl = `https://api.example.com/lookup?phone=${encodeURIComponent(phoneNumber)}&key=${apiKey}`;
        const headers = { 
            "User-Agent": "YourApp/1.0 (Android)",
            "Accept": "application/json" 
        };

        sendNativeRequest({
            method: 'GET',
            url: targetSearchUrl,
            headers: headers,
            requestId: requestId
        });
        */

        // Example B: POST Request
        const targetSearchUrl = "https://api.example.com/v2/search";
        const bodyString = `user=${encodeURIComponent(username || '')}&phone=${encodeURIComponent(phoneNumber)}&key=${apiKey}`;
        const headers = {
            "Content-Type": "application/x-www-form-urlencoded",
            "User-Agent": userAgent,
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
        const responseText = response.responseText; 

        if (statusCode !== 200) {
            logError(`HTTP Error: ${statusCode}`);
            sendPluginResult({ requestId, success: false, error: `HTTP Error ${statusCode}` });
            return;
        }

        try {
            // 1. Parse JSON
            const data = JSON.parse(responseText);
            
            // 2. Extract Fields
            const sourceLabel = data.type || ''; 
            const sourceName = data.name || '';
            const score = data.score || 0;
            
            // 3. Action Logic
            let predefinedLabel = 'Unknown';
            let action = 'none';

            // 3.1 Map Label
            if (manualMapping[sourceLabel]) {
                predefinedLabel = manualMapping[sourceLabel];
            } else {
                const mappedKey = Object.keys(manualMapping).find(key => sourceLabel.includes(key));
                if (mappedKey) predefinedLabel = manualMapping[mappedKey];
            }

            // 3.2 Determine Action (Block/Allow)
            const labelToCheck = (sourceLabel + " " + predefinedLabel).toLowerCase();
            let determinedAction = 'none';

            // Check Block Keywords
            for (const keyword of blockKeywords) {
                if (labelToCheck.includes(keyword.toLowerCase())) {
                    determinedAction = 'block';
                    break;
                }
            }

            // Check Allow Keywords
            if (determinedAction === 'none') {
                 for (const keyword of allowKeywords) {
                    if (labelToCheck.includes(keyword.toLowerCase())) {
                        determinedAction = 'allow';
                        break;
                    }
                }
            }
            action = determinedAction;


            // 4. Return Result
            const result = {
                requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                phoneNumber: data.number || '',
                sourceLabel: sourceLabel,
                predefinedLabel: predefinedLabel,
                action: action,
                name: sourceName,
                count: score
            };
            
            sendPluginResult(result);

        } catch (e) {
            logError('Parsing Error', e);
            sendPluginResult({ requestId, success: false, error: 'JSON Parse Failed: ' + e.message });
        }
    }

    // --- SECTION 7: Public Interface ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput called for requestId: ${requestId}`);
        // Keep any parameter as needed.
        const numberToQuery = phoneNumber || nationalNumber || e164Number;
        
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
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
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
