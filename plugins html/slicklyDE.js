// [slicklyDE.js] - Slick.ly DE Plugin (Pure FlutterJS Regex V6.1)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function () {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'slicklyDePhoneNumberPlugin',
        name: 'Slick.ly DE (Regex)',
        version: '6.1.0',
        description: 'Queries Slick.ly (DE) for phone number information using Regex.',
        config: {
            successMarker: "slickly",
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
        { label: 'Fraud Scam Likely' }, { label: 'Spam Likely' }, { label: 'Telemarketing' },
        { label: 'Robocall' }, { label: 'Delivery' }, { label: 'Takeaway' },
        { label: 'Ridesharing' }, { label: 'Insurance' }, { label: 'Loan' },
        { label: 'Customer Service' }, { label: 'Unknown' }, { label: 'Financial' },
        { label: 'Bank' }, { label: 'Education' }, { label: 'Medical' },
        { label: 'Charity' }, { label: 'Other' }, { label: 'Debt Collection' },
        { label: 'Survey' }, { label: 'Political' }, { label: 'Ecommerce' },
        { label: 'Risk' }, { label: 'Agent' }, { label: 'Recruiter' },
        { label: 'Headhunter' }, { label: 'Silent Call Voice Clone' }, { label: 'Internet' },
        { label: 'Travel Ticketing' }, { label: 'Application Software' }, { label: 'Entertainment' },
        { label: 'Government' }, { label: 'Local Services' }, { label: 'Automotive Industry' },
        { label: 'Car Rental' }, { label: 'Telecommunication' },
    ];

    const manualMapping = {
        'Gefährlich': 'Risk', 'Verdächtig': 'Spam Likely', 'Sicher': 'Other',
        'Betrug': 'Fraud Scam Likely', 'Schwindel': 'Fraud Scam Likely', 'Scam': 'Fraud Scam Likely',
        'Abzocke': 'Fraud Scam Likely', 'Täuschung': 'Fraud Scam Likely', 'Spam': 'Spam Likely',
        'Unerwünscht': 'Spam Likely', 'Belästigung': 'Spam Likely', 'Werbung': 'Telemarketing',
        'Telemarketing': 'Telemarketing', 'Kaltanruf': 'Telemarketing', 'Telefonwerbung': 'Telemarketing',
        'Robocall': 'Robocall', 'Automatischer Anruf': 'Robocall', 'Sprachcomputer': 'Robocall',
        'Lieferung': 'Delivery', 'Zustellung': 'Delivery', 'Versand': 'Delivery',
        'Essen zum Mitnehmen': 'Takeaway', 'Abholung': 'Takeaway', 'Lieferservice': 'Takeaway',
        'Mitfahrgelegenheit': 'Ridesharing', 'Fahrgemeinschaft': 'Ridesharing', 'Taxi': 'Ridesharing',
        'Versicherung': 'Insurance', 'Police': 'Insurance', 'Absicherung': 'Insurance',
        'Kredit': 'Loan', 'Darlehen': 'Loan', 'Finanzierung': 'Loan',
        'Kundenservice': 'Customer Service', 'Support': 'Customer Service', 'Hilfe': 'Customer Service',
        'Unbekannt': 'Unknown', 'Anonym': 'Unknown', 'Versteckt': 'Unknown',
        'Finanzen': 'Financial', 'Geld': 'Financial', 'Finanziell': 'Financial',
        'Bank': 'Bank', 'Banking': 'Bank', 'Konto': 'Bank',
        'Bildung': 'Education', 'Ausbildung': 'Education', 'Schule': 'Education',
        'Medizinisch': 'Medical', 'Gesundheit': 'Medical', 'Arzt': 'Medical',
        'Wohltätigkeit': 'Charity', 'Spende': 'Charity', 'Hilfsorganisation': 'Charity',
        'Andere': 'Other', 'Sonstige': 'Other', 'Verschiedenes': 'Other',
        'Inkasso': 'Debt Collection', 'Schulden': 'Debt Collection', 'Forderung': 'Debt Collection',
        'Umfrage': 'Survey', 'Meinung': 'Survey', 'Marktforschung': 'Survey',
        'Politisch': 'Political', 'Wahl': 'Political', 'Partei': 'Political',
        'E-Commerce': 'Ecommerce', 'Online-Shop': 'Ecommerce', 'Internet-Handel': 'Ecommerce',
        'Risiko': 'Risk', 'Gefahr': 'Risk', 'Bedrohung': 'Risk',
        'Agent': 'Agent', 'Vertreter': 'Agent', 'Vermittler': 'Agent',
        'Personalvermittler': 'Recruiter', 'Recruiter': 'Recruiter', 'HR': 'Recruiter',
        'Headhunter': 'Headhunter', 'Kopfjäger': 'Headhunter', 'Executive Search': 'Headhunter',
        'Stiller Anruf': 'Silent Call Voice Clone', 'Ruhe am Telefon': 'Silent Call Voice Clone',
        'Kein Gespräch': 'Silent Call Voice Clone', 'Sprachklon': 'Silent Call Voice Clone',
        'Gefälschte Stimme': 'Silent Call Voice Clone', 'Stimmimitation': 'Silent Call Voice Clone',
        'Internet': 'Internet', 'Online': 'Internet', 'Netz': 'Internet',
        'Reisen und Tickets': 'Travel Ticketing', 'Tourismus': 'Travel Ticketing', 'Flugtickets': 'Travel Ticketing',
        'Anwendungssoftware': 'Application Software', 'Software': 'Application Software', 'Programme': 'Application Software',
        'Unterhaltung': 'Entertainment', 'Show': 'Entertainment', 'Kino': 'Entertainment',
        'Regierung': 'Government', 'Staat': 'Government', 'Behörde': 'Government',
        'Lokale Dienste': 'Local Services', 'Services': 'Local Services', 'Dienstleistungen': 'Local Services',
        'Automobilindustrie': 'Automotive Industry', 'Auto': 'Automotive Industry', 'PKW': 'Automotive Industry',
        'Autovermietung': 'Car Rental', 'Mietwagen': 'Car Rental', 'Leihwagen': 'Car Rental',
        'Telekommunikation': 'Telecommunication', 'Kommunikation': 'Telecommunication', 'Telefonie': 'Telecommunication',
        'Stromanbieterwerbung': 'Telemarketing'
    };

    const blockKeywords = [
        'Betrug', 'Schwindel', 'Scam', 'Abzocke', 'Täuschung',
        'Spam', 'Unerwünscht', 'Belästigung',
        'Telemarketing', 'Kaltanruf', 'Telefonwerbung',
        'Robocall', 'Automatischer Anruf',
        'Inkasso', 'Schulden', 'Forderung', 'Gefährlich', 'Verdächtig'
    ];
    const allowKeywords = [
        'Lieferung', 'Zustellung', 'Versand',
        'Essen zum Mitnehmen', 'Abholung', 'Lieferservice',
        'Mitfahrgelegenheit', 'Fahrgemeinschaft', 'Taxi',
        'Versicherung', 'Police', 'Absicherung',
        'Kundenservice', 'Support', 'Hilfe', 'Sicher'
    ];

    const countryCodeMap = {
        '49': 'de' // Germany Only
    };

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
    function initiateQuery(phoneNumber, requestId, countryCode) {
        log(`Initiating Query: ${phoneNumber} for ${countryCode}`);

        const config = (window.plugin && window.plugin[PLUGIN_CONFIG.id].config) || {};
        const successMarker = config.successMarker || "slickly";
        const userAgent = config.userAgent || 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

        const targetUrl = `https://slick.ly/${countryCode.toLowerCase()}/${phoneNumber}`;
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

    function parseHTML(html) {
        const result = {
            sourceLabel: '', count: 0, province: '', city: '', carrier: '',
            name: '', predefinedLabel: '', source: PLUGIN_CONFIG.name, numbers: [], success: false, error: '', action: 'none'
        };

        if (!html) return result;

        try {
            // 1. Comments Count (Match (123) pattern, covers "Comments (10)" or "Bemerkungen (10)")
            const countRegex = /class=["']comments-count["'].*?>[\s\S]*?\((\d+)\)/i;
            const countMatch = html.match(countRegex);
            if (countMatch) result.count = parseInt(countMatch[1], 10);

            // 2. Summary Label (Initial SourceLabel)
            const summaryRegex = /class=["']summary-result["']>([\s\S]*?)<\/span>/i;
            const summaryMatch = html.match(summaryRegex);
            if (summaryMatch) {
                result.sourceLabel = summaryMatch[1].trim();
            }

            // 3. Keywords (Specific SourceLabel)
            const keywordRegex = /class=["']keywords["'][\s\S]*?<span>([\s\S]*?)<\/span>/i;
            const keywordMatch = html.match(keywordRegex);
            if (keywordMatch) {
                const keywordText = keywordMatch[1].trim();
                if (manualMapping[keywordText]) {
                    result.sourceLabel = keywordText;
                }
            }

            // 4. City/Province (Basic Info)
            const basicRegex = /class=["']basic["'][\s\S]*?<span>([\s\S]*?)<\/span>/i;
            const basicMatch = html.match(basicRegex);
            if (basicMatch) {
                let locationInfo = basicMatch[1].trim();
                const separatorIndex = locationInfo.indexOf(' · ');
                if (separatorIndex !== -1) locationInfo = locationInfo.substring(0, separatorIndex).trim();

                const locMatch = locationInfo.match(/^(.+?)\s*\((.+?)\)$/);
                if (locMatch) {
                    const mainPart = locMatch[1].trim();
                    if (mainPart.includes(',')) {
                        const parts = mainPart.split(',').map(p => p.trim());
                        result.city = parts[0];
                        result.province = parts[1];
                    } else {
                        result.city = mainPart;
                    }
                } else {
                    result.city = locationInfo;
                }
            }

            // 5. Votes
            const negRegex = /class=["']negative-count["']>([\s\S]*?)<\/span>/i;
            const posRegex = /class=["']positive-count["']>([\s\S]*?)<\/span>/i;
            const negMatch = html.match(negRegex);
            const posMatch = html.match(posRegex);
            let negVotes = 0, posVotes = 0;
            if (negMatch) negVotes = parseInt(negMatch[1], 10);
            if (posMatch) posVotes = parseInt(posMatch[1], 10);

            // Mapping & Action Logic
            if (result.sourceLabel) {
                 result.success = true;
                 // Predefined Label
                 result.predefinedLabel = manualMapping[result.sourceLabel] || 'Unknown';
                 
                 // Action Logic
                 let determinedAction = 'none';
                 for (const k of blockKeywords) { if (result.sourceLabel.toLowerCase().includes(k.toLowerCase())) { determinedAction = 'block'; break; } }
                 if (determinedAction === 'none') {
                     for (const k of allowKeywords) { if (result.sourceLabel.toLowerCase().includes(k.toLowerCase())) { determinedAction = 'allow'; break; } }
                 }
                 
                 // Fallback to votes if no label-based action
                 if (determinedAction === 'none' && (negVotes > 0 || posVotes > 0)) {
                      if (negVotes > posVotes) determinedAction = 'block';
                      else if (posVotes > negVotes) determinedAction = 'allow';
                 }
                 
                 result.action = determinedAction;
            } else if (result.count > 0) {
                result.success = true; // Success if we at least found comments
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
            // Buffer legacy
        }

        const requestId = final.requestId || final.phoneRequestId;
        if (!final.success) {
            sendPluginResult({ requestId, success: false, error: final.error || "HTTP Error" });
            return;
        }

        const html = final.responseText || "";
        const parsed = parseHTML(html);

        parsed.requestId = requestId;
        sendPluginResult(parsed);
    }

    function generateOutput(phone, national, e164, reqId) {
        const numberToQuery = phone || national || e164;
        if (!numberToQuery) {
            sendPluginResult({ requestId: reqId, success: false, error: "No valid number" });
            return;
        }

        let countryCode = null;
        if (e164 && e164.startsWith('+')) {
            const match = e164.match(/^\+(\d{1,3})/);
            if (match && match[1]) {
                let extracted = match[1];
                 while (extracted.length > 0) {
                    if (countryCodeMap[extracted]) {
                        countryCode = countryCodeMap[extracted];
                        break;
                    }
                    extracted = extracted.slice(0, -1);
                }
            }
        }

        if (countryCode) {
            const formatted = numberToQuery.replace(/[^0-9]/g, '');
            initiateQuery(formatted, reqId, countryCode);
        } else {
             sendPluginResult({ requestId: reqId, success: false, error: "Unsupported Country Code (DE only allows +49)" });
        }
    }

    function initialize() {
        if (!window.plugin) window.plugin = {};
        window.plugin[PLUGIN_CONFIG.id] = { info: PLUGIN_CONFIG, generateOutput: generateOutput, handleResponse: handleResponse, config: {} };
        log(`Plugin registered. Version ${PLUGIN_CONFIG.version}`);
        sendPluginLoaded();
    }

    initialize();
})();