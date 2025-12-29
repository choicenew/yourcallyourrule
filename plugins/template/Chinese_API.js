// [插件名称] - API 接口解决方案通用模板 V1.0 (API版)
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
        id: 'yourUniqueApiPluginId', // 插件的唯一ID，使用驼峰命名法 (例如: 'someApiPlugin')
        name: 'Your API Plugin Name', // 插件的可读名称
        version: '1.0.0', // 插件版本号
        description: 'Query phone info via Official API.', // 插件功能描述
        // [新增] 配置项定义
        settings: [
            {
                key: 'api_key',       // 配置项的键名，代码中通过 config.api_key 访问
                label: 'API Key',     // UI显示的标签
                type: 'text',         // 输入框类型: text, password, etc.
                hint: '请输入从官网获取的 API Key', // 输入提示
                required: true        // 是否必填
            },
            {
                key: 'username',
                label: '用户名',
                type: 'text',
                hint: 'API 账户用户名 (可选)',
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
        'scam': 'Fraud Scam Likely',
        'sales': 'Telemarketing',
        'delivery': 'Delivery',
        // ... 根据 API 文档填写
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
    
    async function performApiQuery(phoneNumber, requestId) {
        log(`Starting API query for ${phoneNumber}`);
        
        // 1. 获取配置
        // config 对象由 App 在运行前注入
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const apiKey = config.api_key;

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: 'API Key not configured.' });
            return;
        }

        // 2. 构建请求
        // 示例 API URL
        const apiUrl = `https://api.example.com/v1/phone/${encodeURIComponent(phoneNumber)}?key=${encodeURIComponent(apiKey)}`;
        
        // 如果需要 POST，可以调整 fetch 选项
        const fetchOptions = {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                // 'Authorization': `Bearer ${apiKey}` // 如果是 Bearer Token 方式
            }
        };

        try {
            // 3. 发起请求
            // 如果遇到 CORS 问题，可以使用 App 提供的代理 (同 iframe 版的 proxyUrl 构造方式)，或者 App 侧实现的 fetch 代理
            // 这里假设直接 fetch 可用，或者 API 支持 CORS。
            // 如果必须走代理，请参考 iframe 版的 proxyUrl 构造，然后用 fetch(proxyUrl)
            
            const response = await fetch(apiUrl, fetchOptions);
            
            if (!response.ok) {
                throw new Error(`API response error: ${response.status} ${response.statusText}`);
            }

            const data = await response.json();
            log(`API response received: ${JSON.stringify(data)}`);

            // 4. 解析结果
            // 假设 API 返回结构: { type: 'scam', location: 'Beijing' }
            
            let sourceLabel = data.type || '';
            let predefinedLabel = 'Unknown';
            let action = 'none';

            // 映射标签
            if (manualMapping[sourceLabel]) {
                predefinedLabel = manualMapping[sourceLabel];
            } else if (sourceLabel) {
                 // 简单包含匹配作为后备
                 const mappedKey = Object.keys(manualMapping).find(key => sourceLabel.includes(key));
                 if (mappedKey) predefinedLabel = manualMapping[mappedKey];
            }

            // 简单规则判断 action (或者复用 blockKeywords 逻辑)
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


    // --- 区域 5: 插件公共接口 ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput called for requestId: ${requestId}`);
        const numberToQuery = phoneNumber || nationalNumber || e164Number;
        
        if (numberToQuery) {
            performApiQuery(numberToQuery, requestId);
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
            info: PLUGIN_CONFIG, // 包含 settings 定义
            generateOutput: generateOutput,
            config: {} // 初始化为空对象，App 会注入值
        };
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
