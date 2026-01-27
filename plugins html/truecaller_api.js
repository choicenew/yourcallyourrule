// [Truecaller] - Native RequestChannel Solution Universal Template V5.2 (Absolute Complete Version)
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
        id: 'truecallerApi', // Must match Dart callback ID usage logic (if dynamic) or keep unique
        name: 'Truecaller (API)', 
        version: '1.2.0', 
        description: 'Truecaller API Lookup via Native RequestChannel',
        // Settings Definition
        settings: [
            {
                key: 'auth_token',
                label: 'Auth Token',
                type: 'text',
                hint: 'Enter Truecaller Auth Token (Bearer)',
                required: true
            },
            {
                key: 'country_code',
                label: 'Default Country Code',
                type: 'text',
                hint: 'e.g: IN, US, CN (Optional)',
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
        'spam': 'Spam Likely',
        'scam': 'Fraud Scam Likely',
        'sales': 'Telemarketing',
        'marketing': 'Telemarketing',
        'delivery': 'Delivery',
        'finance': 'Financial',
        'loan': 'Loan',
        'insurance': 'Insurance',
        'agent': 'Agent',
        // Add more truecaller tags if known
    };

    /**
     * @constant {Array<string>} blockKeywords - Keywords that determine 'block' action
     */
    const blockKeywords = [
        'Scam', 'Fraud', 'Spam', 'Telemarketing', 'Robocall'
    ];

    /**
     * @constant {Array<string>} allowKeywords - Keywords that determine 'allow' action
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

    // --- SECTION 5: Query Initiation Logic (Must Modify) ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating query for '${phoneNumber}' (requestId: ${requestId})`);
        
        // Cache the phone number
        requestCache[requestId] = phoneNumber;

        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const authToken = config.auth_token;
        const countryCode = config.country_code || 'US';

        if (!authToken) {
            sendPluginResult({ requestId, success: false, error: 'Auth Token not configured.' });
            return;
        }

        // Build Truecaller URL
        // Using the v2 search endpoint as per previous logic
        const targetSearchUrl = `https://search5-noneu.truecaller.com/v2/search?q=${encodeURIComponent(phoneNumber)}&countryCode=${encodeURIComponent(countryCode)}&type=4&locAddr=&placement=SEARCH_RESULTS,HISTORY,DETAILS&encoding=json`;
        
        // Headers from Python logic
        const headers = {
            "User-Agent": config.userAgent || "Truecaller/15.32.6 (Android;14)",
            "Accept": "application/json",
            "Authorization": `Bearer ${authToken}`
        };

        sendNativeRequest({
            method: 'GET',
            url: targetSearchUrl, 
            headers: headers,
            requestId: requestId
        });
    }

    // --- SECTION 6: Response Handling Logic (Core Parsing) ---
    function safeFirst(array, key) {
        if (Array.isArray(array) && array.length > 0 && array[0]) {
            return array[0][key] || '';
        }
        return '';
    }

    function handleResponse(response) {
        log('Received response from Native layer');
        
        const requestId = response.phoneRequestId;
        const statusCode = response.status;
        const responseText = response.responseText; 

        // Retrieve original phone number from cache
        const originalPhoneNumber = requestCache[requestId] || '';
        delete requestCache[requestId]; // Clean up

        if (statusCode !== 200) {
            logError(`HTTP Error: ${statusCode}`);
            let errorMsg = `HTTP Error ${statusCode}`;
            if (statusCode === 401) errorMsg = "Truecaller Token Expired (401)";
            sendPluginResult({ requestId, success: false, error: errorMsg });
            return;
        }

        try {
            // 1. Parse JSON
            const data = JSON.parse(responseText);
            
            // 2. Extract Fields (Python logic)
            // info = data.get("data", [{}])[0]
            const dataList = data.data || [{}];
            const info = dataList[0] || {};

            const name = info.name || '';
            const phone = safeFirst(info.phones, 'e164Format');
            const carrier = safeFirst(info.phones, 'carrier');
            const email = safeFirst(info.internetAddresses, 'id');
            const gender = info.gender || '';
            const city = safeFirst(info.addresses, 'city');
            const country = safeFirst(info.addresses, 'countryCode');
            const image = info.image || '';
            const isFraud = info.isFraud === true;
            
            // Use returnedNum if available, otherwise fallback
            const finalPhoneNumber = phone || originalPhoneNumber;
            
            // 3. Action Logic
            let sourceLabel = 'Normal';
            let predefinedLabel = 'Unknown';
            let action = 'none';

            // Logic: isFraud
            if (isFraud) {
                sourceLabel = 'Spam/Fraud';
                predefinedLabel = 'Fraud Scam Likely';
                action = 'block';
            }
            
            // spamScore / spamType logic
            const spamScore = info.spamScore || 0;
            if (spamScore > 0 && !isFraud) {
                sourceLabel = info.spamType || 'Spam';
                // Try mapping
                if (manualMapping[sourceLabel.toLowerCase()]) {
                    predefinedLabel = manualMapping[sourceLabel.toLowerCase()];
                }
                if (spamScore > 50) {
                     // High score logic
                     if(predefinedLabel === 'Unknown') predefinedLabel = 'Spam Likely';
                     action = 'block'; 
                }
            }

            // 4. Return Result
            const result = {
                requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                phoneNumber: finalPhoneNumber,
                sourceLabel: sourceLabel,
                predefinedLabel: predefinedLabel,
                action: action,
                
                // Extra fields
                name: name,
                carrier: carrier,
                city: city,
                province: country,
                image: image,
                gender: gender,
                email: email,
                count: spamScore
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
        // Use e164Number if available as priority
        const numberToQuery = e164Number || phoneNumber || nationalNumber;
        
        if (numberToQuery) {
            // Truecaller usually expects clean number, e164 format is safe for query param
            // Python code used: safe_first(..., "e164Format") for result, so inputting e164 is good.
            // Some APIs want number without '+'. If that's the case: numberToQuery.replace('+', '')
            // Given "2026308598" in logs, looks like it might take raw digits.
            // Let's stick to e164 for now, or raw digits if needed. The requestCache handles whatever is passed.
            initiateQuery(numberToQuery.replace('+', ''), requestId); 
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
