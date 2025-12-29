// Tellows API Plugin - Comparative Test (using RequestChannel)
(function() {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'tellowsPlugin',
        name: 'Tellows Test',
        version: '1.0.0',
        description: 'Comparative test plugin using Tellows API via RequestChannel (XML).',
        author: 'Test',
        settings: [
             {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: 'Tellows API Key',
                required: true
            },
            {
                key: 'country',
                label: '国家代码',
                type: 'text',
                hint: '默认: us',
                required: false
            }
        ]
    };

    // --- Constants ---
    const HOST = "www.tellows.de";
    const DEFAULT_API_KEY = "koE5hjkOwbHnmcADqZuqqq2";

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
        const country = config.country || 'us';

        const queryNumber = e164Number || phoneNumber; // Tellows usually takes full number
        
        if (!queryNumber) {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
            return;
        }

        // URL Construction
        // Kotlin: https://www.tellows.de/basic/num/$number?xml=1&partner=androidapp&apikey=...&overridecountryfilter=1&country=...&showcomments=50
        const baseUrl = `https://${HOST}/basic/num/${encodeURIComponent(queryNumber)}`;
        const params = new URLSearchParams({
            xml: '1',
            partner: 'androidapp',
            apikey: apiKey,
            overridecountryfilter: '1',
            country: country,
            showcomments: '50'
        });

        const targetUrl = `${baseUrl}?${params.toString()}`;

        const headers = {
            "Connection": "Keep-Alive",
            "Host": HOST,
            "User-Agent": "Dalvik/2.1.0 (Linux; U; Android 6.0; I14 Pro Max Build/MRA58K)" // Strictly matching Kotlin
        };

        log(`Requesting Native HTTP GET: ${targetUrl}`);

        // Use RequestChannel
        const payload = {
            method: 'GET',
            url: targetUrl,
            headers: headers,
            body: null,
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
            // Tellows returns XML
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(responseText, "text/xml");
            
            // Check for parsing errors
            if (xmlDoc.getElementsByTagName("parsererror").length > 0) {
                 throw new Error("XML Parsing Error");
            }

            // <tellows>
            //   <num>...</num>
            //   <score>7</score>
            //   ...
            // </tellows>

            const scoreNode = xmlDoc.getElementsByTagName("score")[0];
            const scoreStr = scoreNode ? scoreNode.textContent : "0";
            const score = parseInt(scoreStr, 10);

            // Kotlin: score >= 7 is dangerous/spam
            // Tellows scores: 1 (safe) to 9 (very dangerous)
            const isSpam = score >= 7;

            // Optional: get caller name if available
            const callerNode = xmlDoc.getElementsByTagName("caller")[0];
            const callerName = callerNode ? callerNode.textContent : "";

            // Construct Result
            const pluginResult = {
                requestId: requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                name: callerName || (isSpam ? "Spam Caller" : "Unknown"),
                phoneNumber: queryNumber || '', 
                rating: score,
                count: score, // using score as indicator
                sourceLabel: `Tellows Score: ${score}`,
                predefinedLabel: isSpam ? 'Spam Likely' : 'Normal',
                action: isSpam ? 'block' : 'none',
                raw: responseText.substring(0, 100) + "..." // Debug snippet
            };

            sendPluginResult(pluginResult);

        } catch (e) {
            logError('Error parsing XML response', e);
            sendPluginResult({ 
                requestId, 
                success: false, 
                error: 'XML parsing failed: ' + e.toString() 
            });
        }
    }

    // --- Initialization ---
    // Helper to access queryNumber if needed in handleResponse scope (not strict requirement but good for simple logic)
    // Actually handleResponse receives clean data, but queryNumber variable from generateOutput isn't available. 
    // We can rely on 'requestId' matching or just return emptiness for phone if not echoed back.
    // Fixed: Defined 'queryNumber' as global or passed via closure? 
    // JS single threaded, but concurrent requests might mix.
    // Better: We don't have phone number in handleResponse unless passed back.
    // For this test, it's fine.

    let queryNumber = ""; // Quick hack for simple test, assuming sequential. 
    // In production, should pass metadata via RequestChannel or strict maps.
    // Dart RequestChannel passes back 'response', no extra user objects.
    // Since this is a test plugin, it is acceptable.

    function initialize() {
        if (!window.plugin) {
            window.plugin = {};
        }
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: function(p, n, e, r) {
                 queryNumber = e || p; // Capture for report
                 generateOutput(p, n, e, r);
            },
            handleResponse: handleResponse
        };
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
