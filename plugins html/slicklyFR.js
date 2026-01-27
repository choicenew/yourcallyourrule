// [slicklyFR.js] - Slick.ly FR Plugin (Pure FlutterJS Regex V6.1)
// =======================================================================================
// Architecture: Native Channel (httpFetch) + Regex Parsing
// No DOM/Iframe dependencies.
// =======================================================================================

(function () {
    // --- Plugin Configuration ---
    const PLUGIN_CONFIG = {
        id: 'slicklyFrPhoneNumberPlugin',
        name: 'Slick.ly FR (Regex)',
        version: '6.1.0',
        description: 'Queries Slick.ly (FR) for phone number information using Regex.',
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
        'Dangereux': 'Risk', 'Méfiant': 'Spam Likely',
        'Fraude': 'Fraud Scam Likely', 'Arnaque': 'Fraud Scam Likely', 'Escroquerie': 'Fraud Scam Likely',
        'Imposture': 'Fraud Scam Likely', 'Supercherie': 'Fraud Scam Likely', 'Spam': 'Spam Likely',
        'Indésirable': 'Spam Likely', 'Pourriel': 'Spam Likely', 'Non sollicité': 'Spam Likely',
        'Télémarketing': 'Telemarketing', 'Marketing téléphonique': 'Telemarketing',
        'Démarchage téléphonique': 'Telemarketing', 'Robocall': 'Robocall',
        'Appel automatique': 'Robocall', 'Robot': 'Robocall', 'Livraison': 'Delivery',
        'Expédition': 'Delivery', 'Distribution': 'Delivery', 'Plats à emporter': 'Takeaway',
        'À emporter': 'Takeaway', 'Vente à emporter': 'Takeaway', 'Covoiturage': 'Ridesharing',
        'Partage de voiture': 'Ridesharing', 'Voiture partagée': 'Ridesharing',
        'Assurance': 'Insurance', 'Police': 'Insurance', 'Couverture': 'Insurance',
        'Prêt': 'Loan', 'Emprunt': 'Loan', 'Crédit': 'Loan',
        'Service client': 'Customer Service', 'Assistance': 'Customer Service', 'Support': 'Customer Service',
        'Inconnu': 'Unknown', 'Masqué': 'Unknown', 'Non identifié': 'Unknown',
        'Financier': 'Financial', 'Argent': 'Financial', 'Finance': 'Financial',
        'Banque': 'Bank', 'Bancaire': 'Bank', 'Compte': 'Bank',
        'Éducation': 'Education', 'Formation': 'Education', 'École': 'Education',
        'Médical': 'Medical', 'Santé': 'Medical', 'Docteur': 'Medical',
        'Charité': 'Charity', 'Don': 'Charity', 'Association caritative': 'Charity',
        'Autre': 'Other', 'Divers': 'Other', 'Varié': 'Other',
        'Recouvrement de créances': 'Debt Collection', 'Dette': 'Debt Collection', 'Facture impayée': 'Debt Collection',
        'Sondage': 'Survey', 'Enquête': 'Survey', 'Questionnaire': 'Survey',
        'Politique': 'Political', 'Élection': 'Political', 'Parti politique': 'Political',
        'Commerce électronique': 'Ecommerce', 'Boutique en ligne': 'Ecommerce', 'Vente en ligne': 'Ecommerce',
        'Risque': 'Risk', 'Danger': 'Risk', 'Menace': 'Risk',
        'Agent': 'Agent', 'Représentant': 'Agent', 'Intermédiaire': 'Agent',
        'Recruteur': 'Recruiter', 'RH': 'Recruiter', 'Ressources humaines': 'Recruiter',
        'Chasseur de têtes': 'Headhunter', 'Executive Search': 'Headhunter', 'Recrutement de cadres': 'Headhunter',
        'Appel silencieux': 'Silent Call Voice Clone', 'Silence au téléphone': 'Silent Call Voice Clone',
        'Aucune réponse': 'Silent Call Voice Clone', 'Clone de voix': 'Silent Call Voice Clone',
        'Fausse voix': 'Silent Call Voice Clone', 'Imitation de voix': 'Silent Call Voice Clone',
        'Internet': 'Internet', 'En ligne': 'Internet', 'Web': 'Internet',
        'Voyages et billets': 'Travel Ticketing', 'Tourisme': 'Travel Ticketing', 'Billets d avion': 'Travel Ticketing',
        'Logiciel d application': 'Application Software', 'Application': 'Application Software', 'Programme': 'Application Software',
        'Divertissement': 'Entertainment', 'Spectacle': 'Entertainment', 'Cinéma': 'Entertainment',
        'Gouvernement': 'Government', 'État': 'Government', 'Autorité': 'Government',
        'Services locaux': 'Local Services', 'Services de proximité': 'Local Services', 'Services municipaux': 'Local Services',
        'Industrie automobile': 'Automotive Industry', 'Automobile': 'Automotive Industry', 'Voiture': 'Automotive Industry',
        'Location de voitures': 'Car Rental', 'Voiture de location': 'Car Rental', 'Véhicule de location': 'Car Rental',
        'Télécommunications': 'Telecommunication', 'Communications': 'Telecommunication', 'Téléphonie': 'Telecommunication',
        'couper': 'Other', 'laissé': 'Other', 'message': 'Other', 'rappelé': 'Other', 'sonnerie': 'Other'
    };

    const blockKeywords = [
        'Fraude', 'Arnaque', 'Escroquerie', 'Imposture', 'Supercherie',
        'Spam', 'Indésirable', 'Pourriel',
        'Télémarketing', 'Marketing téléphonique',
        'Robocall', 'Appel automatique',
        'Recouvrement de créances', 'Dette', 'Dangereux', 'Méfiant'
    ];
    const allowKeywords = [
        'Livraison', 'Expédition',
        'Plats à emporter', 'À emporter',
        'Covoiturage', 'Partage de voiture',
        'Assurance', 'Police',
        'Service client', 'Assistance'
    ];

    const countryCodeMap = {
        '33': 'fr' // France Only
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
            // 1. Comments Count (Cover "Commentaires (10)")
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
             sendPluginResult({ requestId: reqId, success: false, error: "Unsupported Country Code (FR only allows +33)" });
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