// [bd action.js] - Baidu Phone Query Plugin (Pure FlutterJS Regex V6.1)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function () {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'baiduPhoneNumberPlugin',
        name: 'Baidu Phone Lookup (Regex)',
        version: '6.1.1',
        description: 'Queries Baidu for phone number information using Regex parsing. Intelligently selects the best name.',
        config: {
            successMarker: "百度安全号码认证平台",
        },
        settings: [
            {
                key: 'successMarker',
                label: 'Success Marker',
                type: 'text',
                hint: '过盾标识',
                required: false
            }
        ]
    };

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
        '中介': 'Agent', '房产中介': 'Agent', '违规催收': 'Debt Collection', '快递物流': 'Delivery',
        '快递': 'Delivery', '教育培训': 'Education', '金融': 'Financial', '股票证券': 'Financial',
        '保险理财': 'Financial', '涉诈电话': 'Fraud Scam Likely', '诈骗': 'Fraud Scam Likely',
        '招聘': 'Recruiter', '猎头': 'Headhunter', '猎头招聘': 'Headhunter', '招聘猎头': 'Headhunter',
        '保险': 'Insurance', '保险推销': 'Insurance', '贷款理财': 'Loan', '医疗卫生': 'Medical',
        '其他': 'Other', '送餐外卖': 'Takeaway', '美团': 'Takeaway', '饿了么': 'Takeaway',
        '外卖': 'Takeaway', '滴滴/优步': 'Ridesharing', '出租车': 'Ridesharing', '网约车': 'Ridesharing',
        '违法': 'Risk', '淫秽色情': 'Risk', '反动谣言': 'Risk', '发票办证': 'Risk',
        '客服热线': 'Customer Service', '非应邀商业电话': 'Spam Likely', '广告': 'Spam Likely',
        '骚扰': 'Spam Likely', '骚扰电话': 'Spam Likely', '商业营销': 'Telemarketing',
        '广告推销': 'Telemarketing', '旅游推广': 'Telemarketing', '食药推销': 'Telemarketing',
        '推销': 'Telemarketing',
    };

    const blockKeywords = ['骚扰', '诈骗', '骗子', '推销', '广告', '风险', 'Risk', 'Scam', '违规', '反动'];
    const allowKeywords = ['快递', '外卖', '送餐', '客服', '银行', '验证码', '出租', '滴滴', '优步'];

    // --- Helpers ---
    function log(message) { console.log(`[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message, error) { console.error(`[${PLUGIN_CONFIG.id}] ${message}`, error); }

    function sendPluginResult(result) {
        if (typeof sendMessage === 'function') {
            sendMessage('PluginResultChannel', JSON.stringify(result));
        } else if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(result));
        }
    }

    function sendPluginLoaded() {
        if (typeof sendMessage === 'function') {
            sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
        } else if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
            window.flutter_inappwebview.callHandler('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version }));
        }
    }

    // --- Core Logic ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Scout query for '${phoneNumber}'`);

        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "new-pmd";
        const userAgent = config.userAgent || 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36';

        const targetUrl = `https://www.baidu.com/s?wd=${encodeURIComponent(phoneNumber)}&ie=utf-8`;
        const headers = { 'User-Agent': userAgent };

        try {
            sendMessage('httpFetch', JSON.stringify({
                url: targetUrl,
                method: 'GET',
                headers: headers,
                pluginId: PLUGIN_CONFIG.id,
                phoneRequestId: requestId,
                successMarker: successMarker
            }));
        } catch (e) {
            logError('Query Setup Failed', e);
            sendPluginResult({ requestId, success: false, error: 'Setup Failed: ' + e.toString() });
        }
    }

    function parseHTML(html, phoneNumber) {
        const result = {
            phoneNumber: phoneNumber, sourceLabel: '', count: 0, province: '', city: '', carrier: '',
            name: '', predefinedLabel: '', source: PLUGIN_CONFIG.name, numbers: [], success: false, error: '', action: 'none'
        };

        if (!html) return result;

        try {
            // 1. data-tools Extraction (JSON)
            let dataToolsName = "";
            const dataToolsRegex = /data-tools=['"](\{.*?\})['"]/i;
            const dataToolsMatch = html.match(dataToolsRegex);
            if (dataToolsMatch && dataToolsMatch[1]) {
                try {
                    const jsonStr = dataToolsMatch[1].replace(/&quot;/g, '"');
                    const toolsObj = JSON.parse(jsonStr);
                    if (toolsObj && toolsObj.title) {
                        dataToolsName = toolsObj.title.split(',')[0].trim();
                        log(`Found data-tools name: ${dataToolsName}`);
                    }
                } catch (e) { }
            }

            // 2. Official Card Title
            const officialTitleRegex = /<h3[^>]*class=["'].*?c-title.*?["'][^>]*>[\s\S]*?<a[^>]*>([\s\S]*?)<\/a>/i;
            const officialMatch = html.match(officialTitleRegex);

            // 3. Marked Card Label
            const markedLabelRegex = /class=["']op_mobilephone_label[^"']*["']>([\s\S]*?)<\/div>/i;
            const markedMatch = html.match(markedLabelRegex);

            // 4. Location
            const locationRegex = /归属地：(.*?)</i;
            const locationMatch = html.match(locationRegex);

            if (officialMatch) {
                // Official result
                const rawName = officialMatch[1].replace(/<[^>]+>/g, '').trim();
                result.name = rawName;
                result.success = true;
                result.numbers.push({ number: phoneNumber, name: rawName });
            } else if (markedMatch) {
                // Marked result
                let label = markedMatch[1].replace(/<[^>]+>/g, '').trim();
                label = label.replace(/标记：|标记为：|网络收录仅供参考/g, '').trim().split(/\s+/)[0];
                result.sourceLabel = label;
                result.count = 1;
                result.success = true;

                if (locationMatch) {
                    const locParts = locationMatch[1].trim().split(/\s+/);
                    result.province = locParts[0] || '';
                    result.city = locParts[1] || '';
                    result.carrier = locParts[2] || '';
                }
            }

            // Decide Name
            if (result.success && dataToolsName && dataToolsName.length > result.name.length) {
                result.name = dataToolsName;
            }

            // Predefined Label Logic
            if (result.success) {
                if (result.name.includes('客服') || (result.sourceLabel && result.sourceLabel.includes('客服'))) {
                    result.predefinedLabel = 'Customer Service';
                } else if (result.sourceLabel) {
                    for (const key in manualMapping) {
                        if (result.sourceLabel.includes(key)) {
                            result.predefinedLabel = manualMapping[key];
                            break;
                        }
                    }
                }
            }

            return result;
        } catch (e) {
            logError("Regex Parse Error", e);
            result.error = e.message;
            return result;
        }
    }

    function handleResponse(response) {
        log("handleResponse called.");

        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch (e) { }
        }

        if (response === "BUFFER") {
            // Placeholder
        }

        const requestId = final.requestId || final.phoneRequestId;
        if (!final.success) {
            sendPluginResult({ requestId, success: false, error: final.error || "HTTP Error" });
            return;
        }

        const html = final.responseText || "";
        const parsed = parseHTML(html, "");

        if (parsed.success) {
            const checkStr = (parsed.sourceLabel + " " + parsed.name).toLowerCase();
            let action = 'none';
            if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'block';
            else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'allow';
            parsed.action = action;
        }

        parsed.requestId = requestId;
        sendPluginResult(parsed);
    }

    function generateOutput(phone, national, e164, reqId) {
        if (phone) initiateQuery(phone, reqId);
        else sendPluginResult({ requestId: reqId, success: false, error: "No Number" });
    }

    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = { info: PLUGIN_CONFIG, generateOutput: generateOutput, handleResponse: handleResponse, config: {} };
        log(`Plugin registered. Version ${PLUGIN_CONFIG.version}`);
        sendPluginLoaded();
    }

    initialize();
})();