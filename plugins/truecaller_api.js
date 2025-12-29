// Truecaller Query Plugin - Native Request Solution (Scheme A)
(function() {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'truecallerPluginchannel', // Must match the ID expected by Dart's handleResponse fallback
        name: 'Truecaller API Lookup',
        version: '1.0.11',
        description: 'Queries Truecaller API for caller ID and spam detection using native HTTP channel.',
        author: 'Converted from Python / Scheme A',
        settings: [
            {
                key: 'auth_token',
                label: 'Auth Token',
                type: 'text',
                hint: '请输入 Truecaller Auth Token (Bearer)',
                required: true
            },
            {
                key: 'country_code',
                label: '默认国家代码',
                type: 'text',
                hint: '例如: IN, US, CN (可选)',
                required: false
            }
        ]
    };

    // --- Constants ---
    const defaultToken = "a1i1V--ua298eldF0hb0rL520GjDz7bzVAdt63J2nzZBnWlEKNCJUeln_7kWj4Ir"; 

    // 映射 Truecaller 的垃圾分类到插件的标准标签
    const spamMapping = {
        'sales': 'Telemarketing',
        'spam': 'Spam Likely',
        'scam': 'Fraud Scam Likely',
        'fraud': 'Fraud Scam Likely',
        'nuisance': 'Spam Likely',
        'political': 'Political',
        'survey': 'Survey',
        'robocall': 'Robocall',
        'agent': 'Agent',
        'collection': 'Debt Collection',
        'finance': 'Financial',
        'charity': 'Charity',
    };

    function log(message) { 
        console.log(`[${PLUGIN_CONFIG.id} v${PLUGIN_CONFIG.version}] ${message}`); 
    }

    function logError(message, error) { 
        console.error(`[${PLUGIN_CONFIG.id} v${PLUGIN_CONFIG.version}] ${message}`, error); 
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
     * 入口函数：Flutter 调用此函数开始查询
     */
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`Initiating query for requestId: ${requestId}`);
        
        // 获取配置
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const authToken = config.auth_token || defaultToken;
        // 优先使用 countryCode 配置，没有则默认为 US (Scheme A 原文是 IN，但之前我们改成 US 了，这里用 config 决定)
        const countryCode = config.country_code || 'US'; 

        // 优先使用 e164 格式 (带+号)，如果没有则使用 raw phoneNumber
        const queryNumber = e164Number || phoneNumber;

        if (!queryNumber) {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
            return;
        }

        if (!authToken) {
            sendPluginResult({ requestId, success: false, error: 'Auth Token not configured.' });
            return;
        }

        // 构造 URL
        // 之前版本: https://${host}/v2/search?q=...&countryCode=...&type=4&locAddr=&placement=SEARCHRESULTS,HISTORY,DETAILS&adId=&encoding=json
        const host = "search5-noneu.truecaller.com";
        const targetUrl = `https://${host}/v2/search?q=${encodeURIComponent(queryNumber)}&countryCode=${encodeURIComponent(countryCode)}&type=4&locAddr=&placement=SEARCHRESULTS,HISTORY,DETAILS&adId=&encoding=json`;

        const headers = {
            "User-Agent": "Truecaller/9.00.3 (Android;10)", // Strictly match Kotlin Version
            "Accept": "application/json",
            "Authorization": `Bearer ${authToken}`,
            "Host": host, // Kotlin version explicitly sets Host
            "Connection": "Keep-Alive" // Kotlin version explicitly sets Connection
        };

        log(`Requesting Native HTTP GET: ${targetUrl}`);

        // 使用 RequestChannel 请求 Flutter 原生层发起 HTTP 请求
        const payload = {
            method: 'GET',
            url: targetUrl,
            headers: headers,
            body: null,
            phoneRequestId: requestId,
            externalRequestId: requestId // 用于回调匹配
        };

        if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('RequestChannel', JSON.stringify(payload));
        } else {
            sendPluginResult({ requestId, success: false, error: 'Flutter RequestChannel not available.' });
        }
    }

    /**
     * 回调函数：处理 Native HTTP 请求的响应
     * 对应 Dart 中的 window.plugin.truecallerPluginchannel.handleResponse(...)
     */
    function handleResponse(response) {
        log('Received response from Native layer');
        
        // 这里的 response 结构由 PluginWebViewService.dart 定义
        const requestId = response.phoneRequestId;
        const statusCode = response.status;
        const responseText = response.responseText;

        if (statusCode !== 200) {
            let errorMsg = `HTTP Error ${statusCode}: ${response.statusText}`;
            if (statusCode === 401) {
                errorMsg = "Truecaller Token Expired (401). Please update bearer token in settings.";
            } else if (statusCode === 0) {
                errorMsg = "Network Error/Timeout. Check internet connection.";
            }

            logError(errorMsg);
            sendPluginResult({ 
                requestId, 
                success: false, 
                error: errorMsg
            });
            return;
        }

        try {
            const data = JSON.parse(responseText);
            
            // 解析逻辑
            const info = (data.data && data.data.length > 0) ? data.data[0] : null;

            if (!info) {
                // 没有数据
                sendPluginResult({ 
                    requestId, 
                    success: false, 
                    error: 'No data found in Truecaller response (empty list)' 
                });
                return;
            }

            // 提取字段
            const phones = info.phones || [];
            const phoneObj = phones.length > 0 ? phones[0] : {};
            const addresses = info.addresses || [];
            const addrObj = addresses.length > 0 ? addresses[0] : {};

            const name = info.name || '';
            const carrier = phoneObj.carrier || '';
            const city = addrObj.city || '';
            const province = addrObj.countryCode || ''; // countryCode often holds standard region code
            
            const isFraud = info.isFraud === true;
            const spamInfo = info.spamInfo || {};
            const spamScore = spamInfo.spamScore || 0;
            const spamType = spamInfo.spamType || '';

            let predefinedLabel = '';
            let action = 'none';

            // 智能标签判断
            if (isFraud) {
                predefinedLabel = 'Fraud Scam Likely';
                action = 'block';
            } else if (spamScore > 0) {
                // 尝试映射 spamType
                if (spamType && spamMapping[spamType.toLowerCase()]) {
                    predefinedLabel = spamMapping[spamType.toLowerCase()];
                } else {
                    predefinedLabel = 'Spam Likely';
                }
                action = 'block'; 
            } else if (name.toLowerCase().includes('courier') || name.toLowerCase().includes('delivery')) {
                predefinedLabel = 'Delivery';
                action = 'allow';
            } else {
                predefinedLabel = 'Unknown';
            }

            // 构建最终结果
            const pluginResult = {
                requestId: requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                name: name,
                phoneNumber: phoneObj.e164Format || '',
                carrier: carrier,
                city: city,
                province: province,
                count: spamScore, // 使用垃圾评分作为 count
                sourceLabel: spamType || (isFraud ? 'Fraud' : 'Normal'), // 原始标签
                predefinedLabel: predefinedLabel,
                action: action,
                imageUrl: info.image || '',
                email: (info.internetAddresses && info.internetAddresses.length > 0) ? info.internetAddresses[0].id : ''
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
        
        // 注册插件对象，包含 generateOutput 和 handleResponse
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse // 必须暴露给 Dart 调用
        };

        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
