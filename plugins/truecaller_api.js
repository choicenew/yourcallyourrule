// [插件名称] - Truecaller API 解决方案 V1.0 (API版)
// =======================================================================================
// 模板说明:
// 这是一个用于创建基于 API 的电话号码查询插件的标准化模板。
// 与网页解析版不同，此模板直接调用第三方 API 获取数据，无需 iframe 解析。
//
// 核心特性:
// 1. 支持用户配置 (settings): 插件可以定义需要的配置项 (如 API Key)，用户在 App 中填写。
// 2. 直接 API 调用: 使用 fetch 或 App 提供的代理 fetch 直接获取 JSON 数据。
//
// 工作流程:
// 1. Flutter 调用 `generateOutput` 函数。
// 2. 插件从 `window.plugin[ID].config` 获取用户配置的 API Key 等信息。
// 3. 构建 API 请求 URL。
// 4. 发起请求并解析 JSON 响应。
// 5. 将结果通过 `sendToFlutter` 返回给 App。
// =======================================================================================

(function () {
    // 使用 IIFE (立即调用函数表达式) 来封装插件逻辑，避免污染全局作用域。

    // --- 区域 1: 插件核心配置 (必须修改) ---
    // ---------------------------------------------------------------------------------------
    // 这是每个插件的唯一标识。请务必为你的插件提供独特的信息。
    // ---------------------------------------------------------------------------------------
    const PLUGIN_CONFIG = {
        id: 'truecallerApi', // 插件的唯一ID，使用驼峰命名法
        name: 'Truecaller (API)', // 插件的可读名称
        version: '1.0.1', // 插件版本号
        description: 'Query phone info via Truecaller API.', // 插件功能描述
        // [新增] 配置项定义
        settings: [
            {
                key: 'auth_token',    // 配置项的键名
                label: 'Auth Token',  // UI显示的标签
                type: 'text',         // 输入框类型
                hint: '请输入 Truecaller Auth Token (Bearer)', // 输入提示
                required: true        // 是否必填
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

    // --- 区域 2: 业务相关的数据映射与关键字 (按需修改) ---
    // ---------------------------------------------------------------------------------------
    // 同网页版，定义标准标签映射。
    // ---------------------------------------------------------------------------------------

    /**
     * @constant {Array<Object>} predefinedLabels - 应用内部固定的、预定义的标签列表。
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
     * @constant {Object} manualMapping - 手动映射表。
     * API 返回的类型字段值 -> 标准标签
     */
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
        // 可以根据 Truecaller 实际返回的 tag 补充
    };

    // --- 区域 3: 通用框架部分 (无需修改) ---
    const PROXY_SCHEME = "https";
    const PROXY_HOST = "flutter-webview-proxy.internal";
    const PROXY_PATH_FETCH = "/fetch";

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

    // --- 区域 4: API 请求与解析 (核心逻辑) ---

    // 辅助函数: 安全获取数组第一个元素的特定属性
    function safeFirst(array, key) {
        if (Array.isArray(array) && array.length > 0 && array[0]) {
            return array[0][key] || '';
        }
        return '';
    }
    
    async function performApiQuery(phoneNumber, requestId) {
        log(`Starting API query for ${phoneNumber}`);
        
        // 1. 获取配置
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const authToken = config.auth_token;
        const countryCode = config.country_code || 'US'; 

        if (!authToken) {
            sendPluginResult({ requestId, success: false, error: 'Auth Token not configured.' });
            return;
        }

        // 2. 构建请求
        const apiUrl = `https://search5-noneu.truecaller.com/v2/search?q=${encodeURIComponent(phoneNumber)}&countryCode=${encodeURIComponent(countryCode)}&type=4&locAddr=&placement=SEARCH_RESULTS,HISTORY,DETAILS&encoding=json`;
        
        const fetchOptions = {
            method: 'GET',
            headers: {
                "User-Agent": "Truecaller/15.32.6 (Android;14)",
                "Accept": "application/json",
                // "Accept-Encoding": "gzip", // 浏览器/Webview 通常会自动处理 gzip，显式添加可能导致解码问题如果 webview 不自动解压
                "Authorization": `Bearer ${authToken}`
            }
        };

        try {
            // 3. 发起请求
            const response = await fetch(apiUrl, fetchOptions);
            
            if (!response.ok) {
                if (response.status === 401 || response.status === 403) {
                     throw new Error(`Auth failed: ${response.status}`);
                }
                throw new Error(`API response error: ${response.status} ${response.statusText}`);
            }

            const resData = await response.json();
            log(`API response received.`);

            // 4. 解析结果
            // python: info = data.get("data", [{}])[0]
            const dataList = resData.data || [{}];
            const info = dataList[0] || {};

            // python:
            // "name": info.get("name"),
            // "phone": safe_first(info.get("phones"), "e164Format"),
            // "carrier": safe_first(info.get("phones"), "carrier"),
            // "email": safe_first(info.get("internetAddresses"), "id"),
            // "gender": info.get("gender"),
            // "city": safe_first(info.get("addresses"), "city"),
            // "country": safe_first(info.get("addresses"), "countryCode"),
            // "image": info.get("image"),
            // "isFraud": info.get("isFraud", False)

            const name = info.name || '';
            const phone = safeFirst(info.phones, 'e164Format');
            const carrier = safeFirst(info.phones, 'carrier');
            const email = safeFirst(info.internetAddresses, 'id');
            const gender = info.gender || '';
            const city = safeFirst(info.addresses, 'city');
            const country = safeFirst(info.addresses, 'countryCode');
            const image = info.image || '';
            const isFraud = info.isFraud === true;
            
            // 为了兼容插件标准字段
            let sourceLabel = 'Normal';
            let predefinedLabel = 'Unknown';
            let action = 'none';

            // 逻辑: 如果 isFraud 为 true，则是骚扰
            if (isFraud) {
                sourceLabel = 'Spam/Fraud';
                predefinedLabel = 'Fraud Scam Likely';
                action = 'block';
            }
            
            // spamScore 也可以保留作为补充
            const spamScore = info.spamScore || 0;
             if (spamScore > 0 && !isFraud) {
                sourceLabel = info.spamType || 'Spam';
                // 尝试映射
                if (manualMapping[sourceLabel.toLowerCase()]) {
                    predefinedLabel = manualMapping[sourceLabel.toLowerCase()];
                }
                if (spamScore > 50) {
                     action = 'block'; // 或者 alert
                     if(predefinedLabel === 'Unknown') predefinedLabel = 'Spam Likely';
                }
            }


            const result = {
                requestId,
                phoneNumber: phone || phoneNumber,
                sourceLabel,
                predefinedLabel,
                action,
                province: country, // 映射 country 到 province 位置，或者 city
                city: city,
                carrier: carrier,
                name: name,
                image: image, // 额外字段 plugin 可以传回
                gender: gender,
                email: email,
                count: spamScore, 
                success: true,
                source: PLUGIN_CONFIG.id
            };

            sendPluginResult(result);

        } catch (error) {
            logError('API Query failed', error);
            sendPluginResult({ requestId, success: false, error: error.toString() });
        }
    }


    // --- 区域 5: 插件公共接口 ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput called for requestId: ${requestId}`);
        // 优先使用 e164Number 对于 API 通常更好，去掉了格式符号
        const numberToQuery = e164Number || phoneNumber || nationalNumber;
        
        if (numberToQuery) {
            // Truecaller 搜索时要把 + 去掉? 视具体 API 而定，这里假设不去掉或者由 API 处理
            // 很多时候 e164 格式 (+123456789) 是最标准的
            performApiQuery(numberToQuery.replace('+', ''), requestId); // 尝试去掉 + 号
        } else {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
        }
    }

    // --- 区域 6: 初始化 ---
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
            config: {} // 初始化 config
        };
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
