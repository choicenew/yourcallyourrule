// [cleverdialerat.js] - Cleverdialer AT Plugin (Pure FlutterJS Regex V6.0)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function() {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'cleverdialerPlugin', // Preserving ID from original file
        name: 'Cleverdialer AT (Regex)',
        version: '6.0.0', 
        description: 'Queries cleverdialer.at for phone number information using Regex.',
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
        'Agencia de cobranza': 'Debt Collection', 'Apuestas': 'Other', 'Asesoría': 'Other', 'Buzón': 'Other',
        'Donación': 'Charity', 'Dudoso': 'Spam Likely', 'Encuesta': 'Survey', 'Fraude criptográfico': 'Fraud Scam Likely',
        'Gastronomia': 'Other', 'Llamada Ping': 'Spam Likely', 'Llamadas recurrentes': 'Spam Likely', 'Negocio': 'Other',
        'Phishing': 'Fraud Scam Likely', 'Prestación de Servicio': 'Customer Service', 'Publicidad': 'Telemarketing',
        'Salud': 'Medical', 'Servicio al cliente': 'Customer Service', 'Soporte': 'Customer Service', 'Spam': 'Spam Likely',
        'Trampa de costos': 'Fraud Scam Likely', 'Ventas': 'Telemarketing', 'Unknown': 'Unknown', 'Enervante': 'Spam Likely',
        'Neutral': 'Unknown', 'Positivo': 'Other', 'Excelente': 'Other', 'BUSINESS': 'Telemarketing', 'CHARITY': 'Charity',
        'COMMERCIAL': 'Telemarketing', 'CONTINUOUS_CALLS': 'Spam Likely', 'COST_TRAP': 'Fraud Scam Likely', 'COUNSEL': 'Other',
        'CRYPTO_FRAUD': 'Fraud Scam Likely', 'CUSTOMER_SERVICE': 'Customer Service', 'DEBT_COLLECTION_AGENCY': 'Debt Collection',
        'DUBIOUS': 'Spam Likely', 'HEALTH': 'Medical', 'HOSPITALITY': 'Other', 'MAILBOX': 'Other', 'PHISHING': 'Fraud Scam Likely',
        'SILENT_CALL': 'Silent Call Voice Clone', 'SALES': 'Telemarketing', 'SERVICE': 'Customer Service', 'SUPPORT': 'Customer Service',
        'SURVEY': 'Survey', 'SWEEPSTAKE': 'Other', 'Beratung': 'Other', 'Crypto Betrug': 'Fraud Scam Likely', 'Daueranrufe': 'Spam Likely',
        'Dienstleistung': 'Customer Service', 'Geschäft': 'Other', 'Gesundheit': 'Medical', 'Gewinnspiel': 'Other',
        'Inkassounternehmen': 'Debt Collection', 'Kostenfalle': 'Fraud Scam Likely', 'Kundendienst': 'Customer Service',
        'Mailbox': 'Other', 'Ping Anruf': 'Spam Likely', 'Spenden': 'Charity', 'Umfrage': 'Survey', 'Unseriös': 'Spam Likely',
        'Verkauf': 'Telemarketing', 'Werbung': 'Telemarketing', 'Bitte auswählen': 'Unknown',
        'Anrufbeantworter': 'Other', 'Betrug': 'Fraud Scam Likely', 'Call Center': 'Telemarketing', 'Inkasso': 'Debt Collection',
        'Krankenkasse': 'Medical', 'Meinungsforschung': 'Survey', 'Microsoft Betrug': 'Fraud Scam Likely', 'Mobilfunk': 'Telecommunication',
        'Unerwünschte Werbung': 'Telemarketing', 'Unbekannt': 'Unknown', 'Versicherung': 'Insurance', 'Zustellung': 'Delivery'
    };

    const blockKeywords = ['Fraud', 'Spam', 'Telemarketing', 'Robocall', 'Debt', 'Risk', 'Silent', 'Scam', 'Phishing', 'Kostenfalle', 'Unseriös', 'Betrug', 'Ping Anruf'];
    const allowKeywords = ['Delivery', 'Takeaway', 'Insurance', 'Customer', 'Bank', 'Medical', 'Charity', 'Zustellung', 'Versicherung', 'Spenden'];

    // --- Helpers ---
    function log(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] ${message}`); }
    function logError(message) { sendMessage('Log', `[${PLUGIN_CONFIG.id}] [ERROR] ${message}`); }
    function sendPluginResult(result) { sendMessage('PluginResultChannel', JSON.stringify(result)); }
    function sendPluginLoaded() { sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id, version: PLUGIN_CONFIG.version })); }

    // --- Core Logic ---
    function initiateQuery(phoneNumber, requestId) {
        log(`Initiating Query: ${phoneNumber}`);
        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "cleverdialer"; 

        const targetUrl = `https://www.cleverdialer.at/telefonnummer/${phoneNumber}`;
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
            const labelRegex = /<td\s+class=["']callertype["'][^>]*>([\s\S]*?)<\/td>/i;
            const labelMatch = html.match(labelRegex);
            if (labelMatch) {
                result.sourceLabel = labelMatch[1].trim();
                result.predefinedLabel = manualMapping[result.sourceLabel] || 'Unknown';
            }

            // 2. Star Rating Extraction
            if (!result.sourceLabel) {
                 const starRegex = /class=["'][^"']*front-stars\s+stars-(\d)[^"']*["']/i;
                 const starMatch = html.match(starRegex);
                 if (starMatch) {
                     const score = parseInt(starMatch[1], 10);
                     result.sourceLabel = `stars-${score}`;
                     if (score <= 2) result.predefinedLabel = 'Spam Likely';
                     else if (score >= 4) result.predefinedLabel = 'Other';
                     else result.predefinedLabel = 'Unknown';
                 }
            }

            // 3. Count Extraction
            // Covers "Bewertungen", "ratings", "valoraciones"
            const countRegex = /<span\s+class=["']nowrap["'][^>]*>[\s\S]*?(\d+)[\s\S]*?(Bewertungen|ratings|valoraciones)[\s\S]*?<\/span>/i;
            const countMatch = html.match(countRegex);
            if (countMatch) {
                result.count = parseInt(countMatch[1], 10);
            } else {
                const blockedRegex = /class=["']text-blocked["'][^>]*>(\d+)/i;
                const blockedMatch = html.match(blockedRegex);
                if (blockedMatch) result.count = parseInt(blockedMatch[1], 10);
            }

            // 4. City Extraction
            const cityRegex = /class=["']list-text["']>[\s\S]*?<h4>([\s\S]*?)<\/h4>/i;
            const cityMatch = html.match(cityRegex);
            if (cityMatch) result.city = cityMatch[1].trim();

            if (result.sourceLabel || result.count > 0 || result.city) {
                result.success = true;
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
                 for (const k of blockKeywords) { if (label.includes(k)) { determinedAction = 'block'; break; } }
                 if (determinedAction === 'none') {
                     for (const k of allowKeywords) { if (label.includes(k)) { determinedAction = 'allow'; break; } }
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
