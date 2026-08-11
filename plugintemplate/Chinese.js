// [Chinese.js] - FlutterJS 通用正则插件模板 V6.0 (纯Regex架构)
// =======================================================================================
// 模板说明:
// 本模板适用于 QuickJS 纯 JS 环境 (无 DOM/Window/Iframe)。
// 核心逻辑: 
// 1. 发起请求: 通过 sendMessage('httpFetch') 调用原生网络层。
// 2. 接收响应: Native 回调 handleResponse。
// 3. 解析内容: 使用 Regex (正则表达式) 从 HTML 文本中提取数据。
//
// 注意事项:
// - 不可使用 document, window.location, iframe 等 DOM 对象。
// - 必须保留 PLUGIN_CONFIG 中的 settings 结构。
// =======================================================================================

(function() {
    // --- 区域 1: 插件核心配置 (必须修改) ---
    const PLUGIN_CONFIG = {
        id: 'yourUniqueChinesePluginId', // 插件唯一ID
        name: 'Your Chinese Plugin Name', // 插件名称
        version: '6.0.0', // 版本号
        description: 'Pure FlutterJS Regex Plugin for Chinese Websites',
        // 配置项定义 (不可删除)
        settings: [
            {
                key: 'api_key',
                label: 'API Key',
                type: 'text',
                hint: '请输入 API Key (如适用)',
                required: false // 根据情况修改
            },
            {
                key: 'successMarker',
                label: '成功标识 (Success Marker)',
                type: 'text',
                hint: '用于过盾检测的 HTML 特征词 (如: summary-result)',
                required: false
            }
        ]
    };

    // --- 区域 2: 标签映射与关键字 ---
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

    const manualMapping = {
        '骚扰': 'Spam Likely',
        '诈骗': 'Fraud Scam Likely',
        '推销': 'Telemarketing',
        '快递': 'Delivery',
        '外卖': 'Takeaway',
        '中介': 'Agent',
        '银行': 'Bank'
    };

    const blockKeywords = [
        '骚扰', '诈骗', '骗子', '推销', '广告', '风险', 'Risk', 'Scam'
    ];

    const allowKeywords = [
        '快递', '外卖', '送餐', '客服', '银行', '验证码', 'Delivery', 'Safe'
    ];

    // --- 区域 3: 辅助工具函数 ---
    function log(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] [ERROR] ${message}`); }

    function sendPluginResult(result) {
        sendMessage('PluginResultChannel', JSON.stringify(result));
    }

    function sendPluginLoaded() {
        sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
    }

    // --- 区域 4: 核心查询逻辑 (Native Call) ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query for: ${phoneNumber} (ID: ${requestId})`);

        // 1. 获取配置
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id] && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "result"; // 默认 Marker
        
        // 2. 构建目标 URL
        // [修改提示]: 修改下行 URL 模板以匹配目标网站
        const targetUrl = `https://www.example.com/search/${encodeURIComponent(phoneNumber)}`;

        // 3. 构建请求头
        // [修改提示]: QuickJS 环境中 navigator.userAgent 不一定可用，建议使用 Hardcoded Android UA 配合 Native Fingerprint
        const userAgent = "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36";
        const headers = { 
            'User-Agent': userAgent,
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8'
        };

        // 4. 发送 Native 请求 (Over Network Channel)
        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: headers,
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker // ★ 传递给 Native 用于过盾检测 ★
        }));
    }

    // --- 区域 5: 纯正则解析器 (Replacement for DOM Parser) ---
    function parseHTML(html) {
        const result = {
            sourceLabel: '',
            count: 0,
            hasContent: false
        };

        if (!html) return result;

        // [修改提示]: 编写正则表达式提取信息。
        // QuickJS 支持标准 ES2020 正则。
        // 为了健壮性，建议使用非贪婪匹配 [\s\S]*?

        // 示例 1: 提取主要的标签 (e.g., <span class="tag">Spam</span>)
        // const labelRegex = /<span[^>]*class=["']tag["'][^>]*>([\s\S]*?)<\/span>/i;
        const labelRegex = /<div class=["']label["']>([^<]+)<\/div>/i; // 仅示例
        const labelMatch = html.match(labelRegex);
        if (labelMatch && labelMatch[1]) {
            result.sourceLabel = labelMatch[1].trim();
            result.hasContent = true;
        }

        // 示例 2: 提取计数 (e.g., "Reported 5 times")
        const countRegex = /Reported\s+(\d+)\s+times/i;
        const countMatch = html.match(countRegex);
        if (countMatch && countMatch[1]) {
            result.count = parseInt(countMatch[1], 10);
            result.hasContent = true;
        }

        return result;
    }

    // --- 区域 6: 响应处理逻辑 ---
    function handleResponse(response) {
        log("handleResponse called.");
        
        // 1. 数据校验与提取
        let finalResponse = response;
        if (typeof response === 'string') {
            try { finalResponse = JSON.parse(response); } catch(e) { logError("JSON Parse Fail"); return; }
        }

        const requestId = finalResponse.requestId || finalResponse.phoneRequestId;
        if (!finalResponse.success && finalResponse.status !== 200) {
            sendPluginResult({ requestId, success: false, error: finalResponse.error || "HTTP Error" });
            return;
        }

        const html = finalResponse.responseText || "";
        
        // 2. 正则解析
        const parsed = parseHTML(html);
        log(`Parsed: Label=[${parsed.sourceLabel}], Count=[${parsed.count}]`);

        // 3. 智能分类决策
        let sourceLabel = parsed.sourceLabel || '';
        let predefinedLabel = 'Unknown';
        let action = 'none';

        // 3.1 Mapping
        if (manualMapping[sourceLabel]) {
            predefinedLabel = manualMapping[sourceLabel];
        } else {
             const key = Object.keys(manualMapping).find(k => sourceLabel.includes(k));
             if (key) predefinedLabel = manualMapping[key];
        }

        // 3.2 Action
        const checkStr = (sourceLabel + " " + predefinedLabel).toLowerCase();
        if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
            action = 'block';
        } else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
            action = 'allow';
        }

        // 4. 返回结果
        sendPluginResult({
            requestId,
            success: parsed.hasContent, // 只要解析到了内容就算成功
            source: PLUGIN_CONFIG.name,
            phoneNumber: "", // 可以在这里回填号码，如果需要
            sourceLabel: sourceLabel,
            predefinedLabel: predefinedLabel,
            action: action,
            count: parsed.count
        });
    }

    // --- 区域 7: 插件入口 ---
    function generateOutput(phoneNumber, nationalNumber, e164Number, requestId) {
        // [修改提示]: 选择合适的号码格式
        const numberToQuery = phoneNumber || nationalNumber; 
        if (numberToQuery) {
            initiateQuery(numberToQuery, requestId);
        } else {
            sendPluginResult({ requestId, success: false, error: 'No phone number' });
        }
    }

    // --- 区域 8: 初始化 ---
    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = {
            info: PLUGIN_CONFIG,
            generateOutput: generateOutput,
            handleResponse: handleResponse, // 必须暴露
            config: {}
        };
        log("Plugin registered.");
        sendPluginLoaded();
    }

    initialize();
})();