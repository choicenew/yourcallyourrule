// UnknownPhone API Plugin - Comparative Test (using RequestChannel)
(function() {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'unknownPhonePlugin',
        name: 'UnknownPhone Test',
        version: '1.0.1',
        description: 'Comparative test plugin using UnknownPhone API via RequestChannel.',
        author: 'Test',
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: '请输入 UnknownPhone API Key',
                required: true
            },
            {
                key: 'lang',
                label: '语言代码',
                type: 'text',
                hint: '例如: es, en (默认 en)',
                required: false
            }
        ]
    };

    // --- Constants ---
    const API_URL = "https://secure.unknownphone.com/api2/";
    // Default key from Kotlin source, used if not provided in settings
    const DEFAULT_API_KEY = "d7e07fec659645b12df76c94e378d47a";

    function log(message) { 
        console.log(`[${PLUGIN_CONFIG.id}] ${message}`); 
    }

    function logError(message, error) { 
        console.error(`[${PLUGIN_CONFIG.id}] ${message}`, error); 
    }

    function sendToFlutter(channel, data) {
        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler(channel, JSON.stringify(data));
        } else {
            logError(`Cannot send to Flutter on channel '${channel}', handler not available.`);
        }
    }

    function sendPluginLoaded() {
        log('Plugin loaded, notifying Flutter.');
        sendToFlutter('TestPageChannel', { type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version });
    }

    function sendPluginResult(result) {
        log(`Sending result to Flutter for req ${result.requestId}: ${JSON.stringify(result)}`);
        sendToFlutter('PluginResultChannel', result);
    }

    /**
     * Entry Point: Generate Output
     */
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`Initiating query for requestId: ${requestId}`);
        
        // Settings
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const apiKey = config.api_key || DEFAULT_API_KEY;
        const lang = config.lang || 'en';

        const queryNumber = e164Number || phoneNumber;
        
        if (!queryNumber) {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
            return;
        }

        // Construct Form Body (Manual string construction to ensure exact order and format)
        // Kotlin reference:
        // .add("user_type", "free")
        // .add("api_key", UNKNOWN_PHONE_API_KEY)
        // .add("phone", number)
        // .add("_action", "_get_info_for_phone")
        // .add("lang", lang)
        
        const encodedPhone = encodeURIComponent(queryNumber);
        const bodyString = `user_type=free&api_key=${apiKey}&phone=${encodedPhone}&_action=_get_info_for_phone&lang=${lang}`;

        const headers = {
            "Connection": "Keep-Alive",
            "Content-Type": "application/x-www-form-urlencoded",
            "Host": "secure.unknownphone.com",
            "User-Agent": "okhttp/3.14.9"
        };

        log(`Requesting Native HTTP POST: ${API_URL}`);

        // Use RequestChannel
        const payload = {
            method: 'POST',
            url: API_URL,
            headers: headers,
            body: bodyString,
            phoneRequestId: requestId,
            externalRequestId: requestId
        };

        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('RequestChannel', JSON.stringify(payload));
        } else {
            sendPluginResult({ requestId, success: false, error: 'Flutter RequestChannel not available.' });
        }
    }

    /**
     * Handle Native Response
     */
    function handleResponse(response) {
        log('Received response from Native layer');
        
        const requestId = response.phoneRequestId;
        const statusCode = response.status;
        const responseText = response.responseText;

        if (statusCode !== 200) {
            logError(`HTTP Error: ${statusCode}`);
            sendPluginResult({ 
                requestId, 
                success: false, 
                error: `HTTP Error ${statusCode}: ${response.statusText}` 
            });
            return;
        }

        try {
            const data = JSON.parse(responseText);
            
            // Logic based on Kotlin checkListaSpamApi
            const avgRatingsStr = data.avg_ratings || "3";
            const avgRating = parseFloat(avgRatingsStr);
            const isSpam = avgRating < 3; // < 3 is bad/dangerous

            let predefinedLabel = isSpam ? 'Spam Likely' : 'Normal';
            let action = isSpam ? 'block' : 'none';

            // Construct Result with available info
            const pluginResult = {
                requestId: requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                name: isSpam ? "Flagged Number" : "Unknown",
                phoneNumber: data.number || '', 
                rating: avgRating,
                count: data.comments_count || 0,
                sourceLabel: isSpam ? `Rating: ${avgRating}` : 'Safe',
                predefinedLabel: predefinedLabel,
                action: action,
                // Passing back raw data for debugging
                raw: data 
            };

            sendPluginResult(pluginResult);

        } catch (e) {
            logError('Error parsing JSON response', e);
            sendPluginResult({ 
                requestId, 
                success: false, 
                error: 'JSON parsing failed: ' + e.toString() 
            });
        }
    }

    // --- Initialization ---
    function initialize() {
        if (!window.plugin) {
            window.plugin = {};
        }
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse
        };
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
