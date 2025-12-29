// [插件名称] - 原生 RequestChannel 解决方案通用模板 V5.2 (绝对完整一致版)
// =======================================================================================
// 模板说明:
// 这是一个标准化的 API 插件模板。它严格对齐 Iframe 版 (Chinese.js) 的结构、变量命名和逻辑流。
//
// 核心特性:
// 1. 支持用户配置 (settings): 用户在 App 中输入 API Key 等信息。
// 2. 原生请求: 使用 RequestChannel (Native HTTP) 绕过 WebView 限制。
// 3. 结构一致性: 保持与 Chinese.js (Iframe版) 完全一致的代码结构和注释风格。
// =======================================================================================

(function () {
    // 使用 IIFE (立即调用函数表达式) 来封装插件逻辑，避免污染全局作用域。

    // --- 区域 1: 插件核心配置 (必须修改) ---
    // ---------------------------------------------------------------------------------------
    // 这是每个插件的唯一标识。请务必为你的插件提供独特的信息。
    // ---------------------------------------------------------------------------------------
    const PLUGIN_CONFIG = {
        id: 'yourUniqueApiPluginId', // 插件的唯一ID，使用驼峰命名法
        name: 'Your API Plugin Name', // 插件的可读名称
        version: '5.2.0', // 插件版本号
        description: 'Native RequestChannel API Plugin Template', // 插件功能描述
        // 配置项定义
        settings: [
            {
                key: 'api_key',       // 配置项的键名
                label: 'API Key',     // UI显示的标签
                type: 'text',         // 输入框类型
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
    // 这个区域定义了如何将 API 返回的原始标签（sourceLabel）映射到标准标签（predefinedLabel）。
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
     * Key是 API 返回的原始值，Value是标准标签。
     */
    const manualMapping = {
        'scam': 'Fraud Scam Likely',
        'spam': 'Spam Likely',
        'sales': 'Telemarketing',
        'delivery': 'Delivery',
    };

    /**
     * @constant {Array<string>} blockKeywords - 用于决定推荐操作为 "block" 的关键字列表。
     * @description 如果解析出的 `sourceLabel` 或 `predefinedLabel` 包含此列表中的任何关键字，
     *              结果中的 `action` 字段将被设置为 'block'。
     */
    const blockKeywords = [
        '骚扰', '诈骗', '广告', '推销', '营销', '违规', '涉诈', 'Fraud', 'Spam', 'Telemarketing'
    ];

    /**
     * @constant {Array<string>} allowKeywords - 用于决定推荐操作为 "allow" 的关键字列表。
     * @description 如果解析出的 `sourceLabel` 或 `predefinedLabel` 包含此列表中的任何关键字，
     *              并且它不符合 block 的条件，`action` 字段将被设置为 'allow'。
     */
    const allowKeywords = [
        '快递', '外卖', '送餐', '客服', '银行', '验证码', 'Delivery', 'Support', 'Bank'
    ];

    // --- 区域 3: 通用框架部分 (无需修改) ---
    // ---------------------------------------------------------------------------------------
    // 这部分代码是插件框架的核心，负责与Flutter的通信。
    // ---------------------------------------------------------------------------------------
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

    // --- 区域 4: 原生请求发送逻辑 (核心功能) ---
    
    // 封装 RequestChannel 调用，保持代码整洁
    function sendNativeRequest(options) {
        const payload = {
            method: options.method,      // 'GET', 'POST', 'PUT', 'DELETE'
            url: options.url,            // 完整 URL
            headers: options.headers,    // Http Headers
            body: options.body || null,  // 请求体 (POST/PUT 用)
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

    // --- 区域 5: 查询启动逻辑 (按需微调) ---
    // ---------------------------------------------------------------------------------------
    // 这部分负责根据电话号码构建请求参数，并通过 RequestChannel 发起查询。
    // ---------------------------------------------------------------------------------------
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating query for '${phoneNumber}' (requestId: ${requestId})`);
        
        // 1. 获取配置 (由 App 注入)
        const config = window.plugin[PLUGIN_CONFIG.id].config || {};
        const apiKey = config.api_key;
        const username = config.username;
        const userAgent = config.userAgent || 'okhttp/3.14.9';

        if (!apiKey) {
            sendPluginResult({ requestId, success: false, error: 'API Key not configured.' });
            return;
        }

        // ★★★ 2. 构建 API 请求 (根据 API 文档修改) ★★★
        
        // 示例 A: GET 请求
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

        // 示例 B: POST 请求 (Form-UrlEncoded)
        // 很多老旧 API 需要严格的顺序和编码
        const targetSearchUrl = "https://api.example.com/v2/search";
        const bodyString = `user=${encodeURIComponent(username || '')}&phone=${encodeURIComponent(phoneNumber)}&key=${apiKey}`;
        const headers = {
            "Content-Type": "application/x-www-form-urlencoded",
            "User-Agent": userAgent,
        };

        sendNativeRequest({
            method: 'POST',
            url: targetSearchUrl, // 必须传递完整 URL
            headers: headers,
            body: bodyString,
            requestId: requestId
        });
    }

    // --- 区域 6: 响应处理逻辑 (核心解析) ---
    // ---------------------------------------------------------------------------------------
    // 原生层请求完成后，会回调此函数。在这里解析 JSON 并返回结果。
    // ---------------------------------------------------------------------------------------
    function handleResponse(response) {
        log('Received response from Native layer');
        
        const requestId = response.phoneRequestId;
        const statusCode = response.status;
        const responseText = response.responseText; // 原始文本

        if (statusCode !== 200) {
            logError(`HTTP Error: ${statusCode}`);
            sendPluginResult({ requestId, success: false, error: `HTTP Error ${statusCode}` });
            return;
        }

        try {
            // 1. 解析 JSON
            const data = JSON.parse(responseText);
            
            // 2. 提取字段 (依据 API 返回结构)
            const sourceLabel = data.type || ''; 
            const sourceName = data.name || '';
            const score = data.score || 0;
            
            // 3. 智能 Action 判断逻辑 (与 Iframe 版一致)
            let predefinedLabel = 'Unknown';
            let action = 'none';

            // 3.1 尝试映射 predefinedLabel
            if (manualMapping[sourceLabel]) {
                predefinedLabel = manualMapping[sourceLabel];
            } else {
                // 模糊匹配
                const mappedKey = Object.keys(manualMapping).find(key => sourceLabel.includes(key));
                if (mappedKey) predefinedLabel = manualMapping[mappedKey];
            }

            // 3.2 决定 Action (Block/Allow)
            const labelToCheck = (sourceLabel + " " + predefinedLabel).toLowerCase();
            let determinedAction = 'none';

            // 检查 Block 关键字
            for (const keyword of blockKeywords) {
                if (labelToCheck.includes(keyword.toLowerCase())) {
                    determinedAction = 'block';
                    break;
                }
            }

            // 如果不是 Block，检查 Allow 关键字
            if (determinedAction === 'none') {
                 for (const keyword of allowKeywords) {
                    if (labelToCheck.includes(keyword.toLowerCase())) {
                        determinedAction = 'allow';
                        break;
                    }
                }
            }
            action = determinedAction;


            // 4. 返回结果
            const result = {
                requestId,
                success: true,
                source: PLUGIN_CONFIG.name,
                phoneNumber: data.number || '',
                sourceLabel: sourceLabel,
                predefinedLabel: predefinedLabel,
                action: action,
                // 其他字段
                name: sourceName,
                count: score
            };
            
            sendPluginResult(result);

        } catch (e) {
            logError('Parsing Error', e);
            sendPluginResult({ requestId, success: false, error: 'JSON Parse Failed: ' + e.message });
        }
    }

    // --- 区域 7: 插件的公共接口 (无需修改) ---
    // ---------------------------------------------------------------------------------------
    // 这是Flutter调用此插件的入口点。
    // ---------------------------------------------------------------------------------------
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        log(`generateOutput called for requestId: ${requestId}`);
        // 里面依据情况保留任何一个参数，有些网站只支持某种格式，如果不是必要不用同时保留3个。
        const numberToQuery = phoneNumber || nationalNumber || e164Number;
        
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No valid phone number provided.' });
        }
    }

    // --- 区域 8: 初始化与注册 (无需修改) ---
    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse, // 必须暴露给原生层
            config: {}
        };
        log(`Plugin registered: window.plugin.${PLUGIN_CONFIG.id}`);
        sendPluginLoaded();
    }

    initialize();

})();
