// [jpnumber.js] - Telnavi/Jpnumber Plugin (Pure FlutterJS Regex V6.0)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function() {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'telnaviPlugin', // Preserved from original
        name: 'Telnavi (jpnumber) (Regex)',
        version: '6.0.0', 
        description: 'Queries jpnumber.com for phone number information using Regex.',
        settings: [
             { key: 'successMarker', label: 'Success Marker', type: 'text', hint: 'Bypass Marker', required: false }
        ]
    };

    const manualMapping = {
        '迷惑電話': 'Spam Likely', '注意': 'Spam Likely', '安全': 'Other', '安全(推測)': 'Other',
        '不明': 'Unknown', '営業': 'Telemarketing', 'いたずら': 'Spam Likely', 'ワン切り': 'Spam Likely',
        '架空請求': 'Fraud Scam Likely', '勧誘': 'Telemarketing', '取り立て': 'Debt Collection',
        '詐欺': 'Fraud Scam Likely', '融資保証金詐欺': 'Fraud Scam Likely', 'ヤミ金': 'Fraud Scam Likely',
        '選挙': 'Political', '世論調査': 'Survey', '督促': 'Debt Collection', '配送': 'Delivery',
        '役所': 'Government', '病院': 'Medical', '学校': 'Education', '銀行': 'Bank',
        'カード': 'Financial', '保険': 'Insurance', '不動産': 'Telemarketing', 'リサイクル': 'Telemarketing',
        '廃品回収': 'Telemarketing', '家庭教師': 'Telemarketing', '塾': 'Education', '通信販売': 'Ecommerce',
        '飲食店': 'Other', '宿泊施設': 'Other', '美容': 'Other', '医療': 'Medical',
        '介護': 'Medical', '公共施設': 'Government', '警察': 'Government', '消防': 'Government',
        '弁護士': 'Other', '司法書士': 'Other', '行政書士': 'Other', '会計士': 'Other',
        '税理士': 'Other', '社労士': 'Other', '探偵': 'Other', '便利屋': 'Other',
        '代行': 'Other', '修理': 'Other', '清掃': 'Other', '運送': 'Delivery',
        '引越し': 'Delivery', 'タクシー': 'Ridesharing', '運転代行': 'Ridesharing', 'レンタカー': 'Car Rental',
        '旅行': 'Travel Ticketing', 'ホテル': 'Other', '旅館': 'Other', '民宿': 'Other',
        'ペンション': 'Other', 'キャンプ場': 'Other', '温泉': 'Other', '銭湯': 'Other',
        'サウナ': 'Other', 'エステ': 'Other', 'マッサージ': 'Other', 'ネイル': 'Other',
        'まつげ': 'Other', 'ヘアサロン': 'Other', 'ペット': 'Other', '動物病院': 'Medical',
        'ペットショップ': 'Other', 'トリミング': 'Other', 'ペットホテル': 'Other', 'しつけ': 'Other',
        'ブリーダー': 'Other', '里親': 'Other', '保護': 'Other', 'ボランティア': 'Charity'
    };

    const blockKeywords = ['迷惑電話', '注意', 'いたずら', 'ワン切り', '架空請求', '勧誘', '取り立て', '詐欺', 'ヤミ金', 'Spam', 'Fraud'];
    const allowKeywords = ['安全', '配送', '役所', '病院', '学校', '銀行', '公共施設', '警察', '消防', '運送', '引越し', 'Delivery', 'Medical', 'Government'];

    // --- Helpers ---
    function log(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] [ERROR] ${message}`); }
    function sendPluginResult(result) { sendMessage('PluginResultChannel', JSON.stringify(result)); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version })); }

    // --- Core Logic ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query: ${phoneNumber}`);
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "jpnumber"; 

        const targetUrl = `https://www.jpnumber.com/searchnumber.do?number=${phoneNumber}`;
        const headers = { 
            'User-Agent': config.userAgent || 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36'
        };

        sendMessage('httpFetch', JSON.stringify({
            url: targetUrl,
            method: 'GET',
            headers: headers,
            pluginId: PLUGIN_CONFIG.id,
            phoneRequestId: requestId,
            successMarker: successMarker
        }));
    }

    function parseHTML(html) {
        const result = {
            sourceLabel: '', count: 0, province: '', city: '', carrier: '',
            name: '', predefinedLabel: '', source: PLUGIN_CONFIG.id, numbers: [], success: false, error: '', action: 'none'
        };

        if (!html) return result;

        try {
            // 1. Name/Title Extraction
            // <span class="title-text12"><a ...>Name | Info</a></span>
            const titleRegex = /<span\s+class=["']title-text12["'][\s\S]*?<a[^>]*>([\s\S]*?)<\/a>/i;
            const titleMatch = html.match(titleRegex);

            if (titleMatch) {
                const fullTitle = titleMatch[1].replace(/<[^>]+>/g, '').trim();
                const parts = fullTitle.split('|');
                if (parts.length > 0) {
                    result.name = parts[0].trim();
                    result.success = true;
                    // Try to guess a label from the name itself if it matches mapping keys
                }
            }

            // 2. Count Extraction
            // 口コミ数:<span class="orange">123</span>
            const countRegex = /口コミ数:<span\s+class=["']orange["']>(\d+)<\/span>/i;
            const countMatch = html.match(countRegex);
            if (countMatch) {
                result.count = parseInt(countMatch[1], 10);
                if (result.count > 0) result.success = true;
            }

            // 3. Label/Keyword Extraction from Content
            // Scan for keywords in the whole HTML or specific content blocks
            // This is a simplification but extracting specific tags is hard without DOM
            for (const key in manualMapping) {
                if (html.indexOf(key) !== -1) {
                     // Found a keyword
                     if (!result.sourceLabel) result.sourceLabel = key; // Use first found
                     result.predefinedLabel = manualMapping[key];
                     break; // Stop after first match? Or prioritize? 
                            // Usually "Hazardous" keywords appear in prominent places.
                }
            }
            
            // If we have a name but no label, maybe check name against mapping
            if (result.name && !result.sourceLabel) {
                 for (const key in manualMapping) {
                    if (result.name.indexOf(key) !== -1) {
                        result.sourceLabel = key;
                        result.predefinedLabel = manualMapping[key];
                        break;
                    }
                 }
            }

            return result;
        } catch (e) {
            logError("Regex Parse Error: " + e.message);
            result.error = e.message;
            return result;
        }
    }

    function handleResponse(response) {
        let final = response;
        if (typeof response === 'string') {
            try { final = JSON.parse(response); } catch(e) {}
        }

        const requestId = final.requestId || final.phoneRequestId;
        if (!final.success) {
            sendPluginResult({ requestId, success: false, error: final.error || "HTTP Error" });
            return;
        }

        const html = final.responseText || "";
        const parsed = parseHTML(html);

        if (parsed.success) {
             const label = parsed.predefinedLabel || parsed.sourceLabel;
             if (label) {
                 let determinedAction = 'none';
                 for (const k of blockKeywords) { if (label.includes(k) || (parsed.sourceLabel && parsed.sourceLabel.includes(k))) { determinedAction = 'block'; break; } }
                 if (determinedAction === 'none') {
                     for (const k of allowKeywords) { if (label.includes(k) || (parsed.sourceLabel && parsed.sourceLabel.includes(k))) { determinedAction = 'allow'; break; } }
                 }
                 parsed.action = determinedAction;
             }
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
        sendPluginLoaded();
    }

    initialize();
})();
