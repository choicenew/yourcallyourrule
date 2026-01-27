// [bd action copy.js] - Baidu Phone Query Plugin (Pure FlutterJS Regex V6.1)
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
        // Support both WebView and FlutterJS modes automatically
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
        const successMarker = config.successMarker || "result-op";
        const userAgent = config.userAgent || 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36';

        const targetUrl = `https://www.baidu.com/s?wd=${encodeURIComponent(phoneNumber)}&ie=utf-8`;
        const headers = { 'User-Agent': userAgent };

        try {
            log(`Fetching HTML from: ${targetUrl}`);

            // Fire and Forget - Native will handle bypass and callback
            sendMessage('httpFetch', JSON.stringify({
                url: targetUrl,
                method: 'GET',
                headers: headers,
                pluginId: PLUGIN_CONFIG.id,
                phoneRequestId: requestId,
                successMarker: successMarker
            }));

            log("Request sent. Waiting for handleResponse...");

        } catch (e) {
            logError('Query Setup Failed', e);
            sendPluginResult({ requestId, success: false, error: 'Setup Failed: ' + e.toString() });
        }
    }

    function parseHTML(html, phoneNumber) {
        const pluginResults = {
            phoneNumber: phoneNumber, sourceLabel: '', count: 0, province: '', city: '', carrier: '',
            name: '', predefinedLabel: '', source: PLUGIN_CONFIG.name, numbers: [], success: false, error: '', action: 'none'
        };

        if (!html) return pluginResults;

        try {
            // 1. data-tools Extraction (JSON)
            let dataToolsName = "";
            const dataToolsRegex = /data-tools=['"](\{.*?\})['"]/i;
            const dataToolsMatch = html.match(dataToolsRegex);
            if (dataToolsMatch && dataToolsMatch[1]) {
                try {
                    const jsonStr = dataToolsMatch[1].replace(/&quot;/g, '"').replace(/&#39;/g, '"');
                    const toolsObj = JSON.parse(jsonStr);
                    if (toolsObj && toolsObj.title) {
                        dataToolsName = toolsObj.title.split(',')[0].trim();
                        log(`Found data-tools name: ${dataToolsName}`);
                    }
                } catch (e) { 
                    logError("data-tools parse error", e);
                }
            }

            // 2. s-data Extraction (Comment JSON) - Precise field matching
            const sDataRegex = /<!--s-data:([\s\S]*?)-->/g;
            let match;
            while ((match = sDataRegex.exec(html)) !== null) {
                try {
                    const sDataJson = match[1];
                    const sDataObj = JSON.parse(sDataJson);
                    
                    // Extraction from JSON fields
                    if (sDataObj.marker) pluginResults.sourceLabel = sDataObj.marker;
                    if (sDataObj.prov) pluginResults.province = sDataObj.prov;
                    if (sDataObj.city) pluginResults.city = sDataObj.city;
                    if (sDataObj.phoneno && !pluginResults.phoneNumber) pluginResults.phoneNumber = sDataObj.phoneno;

                    if (sDataObj.wise_text && sDataObj.wise_text.includes(PLUGIN_CONFIG.config.successMarker)) {
                        pluginResults.success = true;
                        if (!pluginResults.name) pluginResults.name = sDataObj.wise_text;
                    }
                    
                    if (sDataObj.title && (sDataObj.phoneno || sDataObj.title.includes(phoneNumber))) {
                         if (!pluginResults.name) pluginResults.name = sDataObj.title.replace(/<[^>]+>/g, '').trim();
                         pluginResults.success = true;
                    }

                } catch (e) {}
            }

            // 3. New-PMD HTML Structure (cc-title, cc-row)
            const pmdTitleRegex = /class=["'][^"']*cc-title_[^"']*["'][^>]*>([\s\S]*?)</i;
            const pmdRowRegex = /class=["'][^"']*cc-row_[^"']*["'][^>]*>([\s\S]*?)</i;

            const pmdTitleMatch = html.match(pmdTitleRegex);
            if (pmdTitleMatch) {
                const title = pmdTitleMatch[1].trim();
                if (title) {
                    pluginResults.name = title;
                    pluginResults.sourceLabel = title;
                    pluginResults.success = true;
                }
            }
            const pmdRowMatch = html.match(pmdRowRegex);
            if (pmdRowMatch) {
                const row = pmdRowMatch[1].trim().split(/\s+/);
                if (row[0]) pluginResults.province = row[0];
                if (row[1]) pluginResults.city = row[1];
            }

            // 4. Legacy DOM Extractions
            const officialTitleRegex = /<h3[^>]*class=["'].*?c-title.*?["'][^>]*>[\s\S]*?<a[^>]*>([\s\S]*?)<\/a>/i;
            const officialMatch = html.match(officialTitleRegex);

            const markedLabelRegex = /class=["']op_mobilephone_label[^"']*["']>([\s\S]*?)<\/div>/i;
            const markedMatch = html.match(markedLabelRegex);

            const locationRegex = /归属地：(.*?)</i;
            const locationMatch = html.match(locationRegex);

            if (officialMatch) {
                const rawName = officialMatch[1].replace(/<[^>]+>/g, '').trim();
                pluginResults.name = rawName;
                pluginResults.success = true;
                pluginResults.numbers.push({ number: phoneNumber, name: rawName });
            } else if (markedMatch) {
                let label = markedMatch[1].replace(/<[^>]+>/g, '').trim();
                label = label.replace(/标记：|标记为：|网络收录仅供参考/g, '').trim().split(/\s+/)[0];
                pluginResults.sourceLabel = label;
                pluginResults.count = 1;
                pluginResults.success = true;
                pluginResults.numbers.push({ number: phoneNumber, name: label });

                if (locationMatch) {
                    const locParts = locationMatch[1].trim().split(/\s+/);
                    pluginResults.province = locParts[0] || '';
                    pluginResults.city = locParts[1] || '';
                    pluginResults.carrier = locParts[2] || '';
                }
            }

            // Decide Name priority
            if (pluginResults.success && dataToolsName && (!pluginResults.name || dataToolsName.length > pluginResults.name.length)) {
                pluginResults.name = dataToolsName;
            }

            // Predefined Label Logic
            if (pluginResults.success) {
                if (pluginResults.name.includes('客服') || (pluginResults.sourceLabel && pluginResults.sourceLabel.includes('客服'))) {
                    pluginResults.predefinedLabel = 'Customer Service';
                } else if (pluginResults.sourceLabel) {
                    for (const key in manualMapping) {
                        if (pluginResults.sourceLabel.includes(key)) {
                            pluginResults.predefinedLabel = manualMapping[key];
                            break;
                        }
                    }
                }
            }

            return pluginResults;
        } catch (e) {
            logError("Regex Parse Error", e);
            pluginResults.error = e.message;
            return pluginResults;
        }
    }

    function handleResponse(response) {
        log("handleResponse called.");

        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch (e) { }
        }

        // Handle BUFFER signal (Legacy)
        if (response === "BUFFER") {
            // ... (Buffer logic if needed, skipped for simplicity as we use NativeRequestChannel direct)
        }

        const requestId = final.requestId || final.phoneRequestId;
        if (!final.success) {
            logError(`HTTP Error: ${final.error}`);
            sendPluginResult({ requestId, success: false, error: final.error || "HTTP Error" });
            return;
        }

        const html = final.responseText || "";
        // Note: phoneNumber is not part of response usually, we rely on context or pass empty for parsing
        const parsed = parseHTML(html, "");

        if (parsed.success) {
            const checkStr = (parsed.sourceLabel + " " + parsed.name).toLowerCase();
            let action = 'none';
            if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'block';
            else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) action = 'allow';
            parsed.action = action;
        }

        parsed.requestId = requestId;
        log(`Logic: Success=${parsed.success}, Label=${parsed.predefinedLabel}`);
        sendPluginResult(parsed);
    }

    function generateOutput(phone, national, e164, reqId) {
        log(`generateOutput called for requestId: ${reqId}`);
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