// [callfilter.js] - CallFilter Plugin (Pure FlutterJS Regex V6.0)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function() {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'callfilterPlugin',
        name: 'Call Filter (Regex)',
        version: '6.0.0', 
        description: 'Queries callfilter.app for phone number information using Regex.',
        settings: [
             { key: 'successMarker', label: 'Success Marker', type: 'text', hint: 'Bypass Marker', required: false }
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
        'Telemarketer': 'Telemarketing', 'Call centre': 'Customer Service', 'Financial services': 'Financial',
        'Debt collector': 'Debt Collection', 'Company': 'Other', 'Service': 'Customer Service',
        'Non-profit Organization': 'Charity', 'Survey': 'Survey', 'Nuisance call': 'Spam Likely',
        'Unsolicited call': 'Spam Likely', 'Political call': 'Political', 'Scam call': 'Fraud Scam Likely',
        'Prank call': 'Spam Likely', 'Other': 'Other', 'NEGATIVE TELEMARKETER': 'Telemarketing',
        'Unknown': 'Unknown', 'company': 'Unknown',
    };

    // --- Helpers ---
    function log(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] [ERROR] ${message}`); }
    function sendPluginResult(result) { sendMessage('PluginResultChannel', JSON.stringify(result)); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version })); }

    // --- Core Logic ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query: ${phoneNumber}`);
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "callfilter"; 

        const targetUrl = `https://callfilter.app/${phoneNumber}`;
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
            // 1. Label Extraction
            // <span style="color:#000">Telemarketer</span>
            const labelRegex = /<span\s+style=["']color:#000["']>([\s\S]*?)<\/span>/i;
            const labelMatch = html.match(labelRegex);
            if (labelMatch) {
                const parts = labelMatch[1].trim().split(',');
                result.sourceLabel = (parts.length > 1 ? parts[1] : parts[0]).trim();
                result.success = true;
            }

            // 2. Region Extraction
            // <span id="region">Region</span>
            const regionRegex = /<span\s+id=["']region["']>([\s\S]*?)<\/span>/i;
            const regionMatch = html.match(regionRegex);
            if (regionMatch) {
                result.province = regionMatch[1].trim();
                result.success = true;
            }

            // 3. Count Extraction
            // <li class="active">... 9x ...</li> OR <strong>5</strong>
            const countRegexLi = /<li\s+class=["']active["']>[\s\S]*?(\d+)x[\s\S]*?<\/li>/i;
            const countMatchLi = html.match(countRegexLi);
            
            if (countMatchLi) {
                result.count = parseInt(countMatchLi[1], 10);
                result.success = true;
            } else {
                 // Fallback: <div class="advanced" id="moreInfo"> ... <strong>5</strong> (twice, take 2nd)
                 const moreInfoRegex = /id=["']moreInfo["'][\s\S]*?<strong>\d+<\/strong>[\s\S]*?<strong>(\d+)<\/strong>/i;
                 const moreInfoMatch = html.match(moreInfoRegex);
                 if (moreInfoMatch) {
                     result.count = parseInt(moreInfoMatch[1], 10);
                     result.success = true;
                 }
            }

            // Mapping
            if (result.success && result.sourceLabel) {
                if (manualMapping[result.sourceLabel]) {
                    result.predefinedLabel = manualMapping[result.sourceLabel];
                } else {
                     const match = predefinedLabels.find(l => l.label === result.sourceLabel);
                     result.predefinedLabel = match ? match.label : 'Unknown';
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

        // Action Logic (Simplified)
        if (parsed.success) {
            if (['Spam Likely', 'Fraud Scam Likely', 'Telemarketing'].includes(parsed.predefinedLabel)) {
                parsed.action = 'block';
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
