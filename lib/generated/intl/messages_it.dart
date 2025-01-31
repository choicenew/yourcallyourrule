// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'it';

  static String m0(permissionName) =>
      "Autorizzazione ${permissionName} non concessa.";

  static String m1(listType) => "Aggiungi a ${listType}";

  static String m2(listType) => "Aggiungi a ${listType}";

  static String m3(permissionName) =>
      "È necessario disabilitare manualmente l\'autorizzazione ${permissionName} nelle impostazioni dell\'app.";

  static String m4(listType) => "Rimuovi ${listType}";

  static String m5(listType) => "Rimuovi ${listType}";

  static String m6(permissionName) =>
      "È necessario disabilitare manualmente l\'autorizzazione ${permissionName} nelle impostazioni dell\'app.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("Informazioni"),
        "accept": MessageLookupByLibrary.simpleMessage("Accetta"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("Annunci abilitati:"),
        "add": MessageLookupByLibrary.simpleMessage("Aggiungi"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina voce consentita"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Aggiungi pagina lista nera"),
        "addBlockedPage":
            MessageLookupByLibrary.simpleMessage("Aggiungi pagina bloccati"),
        "addContact": MessageLookupByLibrary.simpleMessage("Aggiungi contatto"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina iscrizione contatto"),
        "addLabelPage":
            MessageLookupByLibrary.simpleMessage("Aggiungi pagina etichetta"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Aggiungi pagina plugin"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("Aggiungi pagina regex"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina lista nera SMS"),
        "addSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina iscrizione SMS"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina lista nera testo SMS"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina lista bianca testo SMS"),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina lista bianca SMS"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Aggiungi pagina iscrizione"),
        "addToAllowed":
            MessageLookupByLibrary.simpleMessage("Aggiungi ai consentiti"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Aggiungi ai bloccati"),
        "addToBlockedtype": m2,
        "addToLabel":
            MessageLookupByLibrary.simpleMessage("Aggiungi a etichetta"),
        "addWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Aggiungi pagina liste bianche"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("aggiunto correttamente"),
        "all": MessageLookupByLibrary.simpleMessage("Tutti"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "Consenti tutti i numeri consentiti"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Consenti tutti i numeri in lista nera"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Consenti tutti i numeri in lista bianca"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("Consenti numeri bloccati"),
        "allowOtherNumbers":
            MessageLookupByLibrary.simpleMessage("Allow Other Numbers"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Consenti modelli in lista nera Regex"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Consenti modelli in lista bianca Regex"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Consenti chiamate in arrivo ripetute"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Consenti a questa app di mostrare l\'ID chiamante"),
        "allowed": MessageLookupByLibrary.simpleMessage("Consentito"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Pagina voce consentita"),
        "allowedpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina consentita"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Rispondi e riaggancia"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Sei sicuro di voler eliminare l\'elemento"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Sei sicuro di voler eliminare questo contatto?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Chiusura automatica notifica locale"),
        "autoUpdateDisabled": MessageLookupByLibrary.simpleMessage(
            "Aggiornamento automatico disabilitato"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage(
            "Aggiornamento automatico abilitato"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatar": MessageLookupByLibrary.simpleMessage("Avatar"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("Dimensioni avatar e icone"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("Colore bordo avatar"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("Dimensione bordo avatar"),
        "avatarPosition":
            MessageLookupByLibrary.simpleMessage("Posizione avatar"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("Dimensione avatar"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("URL o percorso avatar"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Sfumatura sfondo"),
        "backup": MessageLookupByLibrary.simpleMessage("Backup"),
        "backupAndRestore":
            MessageLookupByLibrary.simpleMessage("Backup e ripristino"),
        "bank": MessageLookupByLibrary.simpleMessage("Banca"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Ottimizzazione batteria"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Lista nera"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("Pagina lista nera"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("Liste nere e liste bianche"),
        "blacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina lista nera"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Blocca chiamate da prefissi specifici:"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "Blocca chiamate internazionali:"),
        "blocked": MessageLookupByLibrary.simpleMessage("Bloccato"),
        "blockedCallAction":
            MessageLookupByLibrary.simpleMessage("Azione chiamata bloccata"),
        "blockedCallNotification":
            MessageLookupByLibrary.simpleMessage("Notifica chiamata bloccata"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics": MessageLookupByLibrary.simpleMessage(
            "Statistiche chiamate bloccate"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("Pagina bloccati"),
        "blockedpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina bloccati"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Notifica app chiamata originale e locale"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Notifica SMS originale e locale"),
        "call": MessageLookupByLibrary.simpleMessage("Chiama"),
        "callHistory":
            MessageLookupByLibrary.simpleMessage("Cronologia chiamate"),
        "callLog": MessageLookupByLibrary.simpleMessage("Registro chiamate"),
        "callLogPermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Autorizzazione registro chiamate negata"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Richiesta ruolo screening chiamate non riuscita!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Richiesta ruolo screening chiamate riuscita!"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("App ID chiamante"),
        "callerIdData": MessageLookupByLibrary.simpleMessage("Caller ID Data:"),
        "callerIdDataIsNotAvailable": MessageLookupByLibrary.simpleMessage(
            "Caller ID Data is not available"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("Stile ID chiamante"),
        "callerIdStyleContent": MessageLookupByLibrary.simpleMessage(
            "contenuto stile ID chiamante"),
        "calltypeIconColor": MessageLookupByLibrary.simpleMessage(
            "Colore icona tipo di chiamata"),
        "cancel": MessageLookupByLibrary.simpleMessage("annulla"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Operatore:"),
        "carrierColor":
            MessageLookupByLibrary.simpleMessage("Colore operatore"),
        "carrierFontSize": MessageLookupByLibrary.simpleMessage(
            "Dimensione carattere operatore"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("Posizione operatore"),
        "charity": MessageLookupByLibrary.simpleMessage("Beneficenza"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Scegli Avatar (Locale o Rete):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Scegli dalla galleria"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("Scegli solo link o file"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Scegli l\'azione di intercettazione predefinita"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Scegli la tua lingua"),
        "clientId": MessageLookupByLibrary.simpleMessage("ID client"),
        "close": MessageLookupByLibrary.simpleMessage("Chiudi"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName":
            MessageLookupByLibrary.simpleMessage("Nome directory backup cloud"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "Il backup cloud richiede il backup automatico"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("Servizi cloud"),
        "collection": MessageLookupByLibrary.simpleMessage("Raccolta fondi"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "Configurazione esportata su file!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Configurazione importata"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Configurazione importata correttamente"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Configurazione salvata!"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Conferma eliminazione"),
        "contactFile": MessageLookupByLibrary.simpleMessage("File contatto"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Pagina iscrizione contatto"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contattaci"),
        "contacts": MessageLookupByLibrary.simpleMessage("Contatti"),
        "contactsExportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Contatti esportati correttamente"),
        "contactsImportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Contatti importati correttamente"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("Pagina contatti"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("contatti con numero"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione elenco iscrizioni contatto"),
        "count": MessageLookupByLibrary.simpleMessage("Count"),
        "countColor": MessageLookupByLibrary.simpleMessage("Colore conteggio"),
        "countFontSize": MessageLookupByLibrary.simpleMessage(
            "Dimensione carattere conteggio"),
        "countPosition":
            MessageLookupByLibrary.simpleMessage("Posizione conteggio"),
        "country": MessageLookupByLibrary.simpleMessage("Paese:"),
        "countryCode": MessageLookupByLibrary.simpleMessage("Country Code"),
        "countryName": MessageLookupByLibrary.simpleMessage("Country Name"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Colore nome paese"),
        "countryNameFontSize": MessageLookupByLibrary.simpleMessage(
            "Dimensione carattere nome paese"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Posizione nome paese"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("Ritaglia avatar"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("Servizio clienti"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("Personalizza ID chiamante"),
        "dark": MessageLookupByLibrary.simpleMessage("Scuro"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Modalità scura"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Elimina"),
        "deleteContact":
            MessageLookupByLibrary.simpleMessage("Elimina contatto"),
        "deleted": MessageLookupByLibrary.simpleMessage("Eliminato"),
        "delivery": MessageLookupByLibrary.simpleMessage("Consegna"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Hai negato l\'autorizzazione. Puoi abilitarla manualmente nelle Impostazioni."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Disabilita notifica chiamata bloccata"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("Disabilita autorizzazione"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Disabilita notifica SMS locale"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Impedisci a questa app di mostrare l\'ID chiamante"),
        "disabled": MessageLookupByLibrary.simpleMessage("Disabilitato"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("E-commerce"),
        "edit": MessageLookupByLibrary.simpleMessage("Modifica"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("Modifica avatar"),
        "editCode": MessageLookupByLibrary.simpleMessage("Modifica codice"),
        "editContact":
            MessageLookupByLibrary.simpleMessage("Modifica contatto"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Modifica codice plugin"),
        "education": MessageLookupByLibrary.simpleMessage("Istruzione"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Posizioni elementi"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Abilita notifica chiamata bloccata"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Abilita la modalità scura in base all\'ora"),
        "enableOverlayPermission": MessageLookupByLibrary.simpleMessage(
            "Abilita autorizzazione overlay"),
        "enableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Abilita notifica SMS locale"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds": MessageLookupByLibrary.simpleMessage(
            "Abilita per rimuovere gli annunci"),
        "enabled": MessageLookupByLibrary.simpleMessage("Abilitato"),
        "endColor": MessageLookupByLibrary.simpleMessage("Colore finale"),
        "endcall": MessageLookupByLibrary.simpleMessage("Termina chiamata"),
        "enterCountryCode": MessageLookupByLibrary.simpleMessage(
            "Enter country code (e.g., US, CA)"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Inserisci URL immagine"),
        "enterPluginCodeHere": MessageLookupByLibrary.simpleMessage(
            "Inserisci il codice del plugin qui"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("Inserisci URL"),
        "entry": MessageLookupByLibrary.simpleMessage("Voce"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("voce aggiunta correttamente"),
        "error": MessageLookupByLibrary.simpleMessage("Errore"),
        "errorExportingContacts": MessageLookupByLibrary.simpleMessage(
            "Errore durante l\'esportazione dei contatti:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Errore durante il recupero dello stato dell\'autorizzazione"),
        "errorImporting": MessageLookupByLibrary.simpleMessage(
            "Errore durante l\'importazione"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Errore durante la richiesta del ruolo di screening chiamate:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Esporta"),
        "exportAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina voce consentita"),
        "exportAsCsv": MessageLookupByLibrary.simpleMessage("Esporta come CSV"),
        "exportAsJson":
            MessageLookupByLibrary.simpleMessage("Esporta come JSON"),
        "exportAsVcf": MessageLookupByLibrary.simpleMessage("Esporta come VCF"),
        "exportAsYaml":
            MessageLookupByLibrary.simpleMessage("Esporta come YAML"),
        "exportBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Esporta pagina lista nera"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("Esporta pagina bloccati"),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina iscrizione contatto"),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("Esporta contatti"),
        "exportFailed":
            MessageLookupByLibrary.simpleMessage("Esportazione non riuscita"),
        "exportFormat":
            MessageLookupByLibrary.simpleMessage("formato di esportazione:"),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("Esporta pagina etichetta"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("Esporta pagina plugin"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("Esporta pagina regex"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina liste nere SMS"),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina iscrizione SMS"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina liste nere testo SMS"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina liste bianche testo SMS"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina liste bianche SMS"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Esporta pagina iscrizioni"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("Esportazione riuscita"),
        "exportWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Esporta pagina liste bianche"),
        "failed": MessageLookupByLibrary.simpleMessage("Fallito"),
        "failedToAdd":
            MessageLookupByLibrary.simpleMessage("Impossibile aggiungere:"),
        "failedToAddEntry": MessageLookupByLibrary.simpleMessage(
            "Impossibile aggiungere la voce:"),
        "feature": MessageLookupByLibrary.simpleMessage("Funzionalità"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("descrizione funzionalità"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages": MessageLookupByLibrary.simpleMessage(
            "Filtra i messaggi SMS in arrivo"),
        "filterRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Filtra chiamate in arrivo ripetute"),
        "financial": MessageLookupByLibrary.simpleMessage("Finanziario"),
        "firstName": MessageLookupByLibrary.simpleMessage("Nome"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("Probabile frode/truffa"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Inizia"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "Accesso a Google Drive non riuscito"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Accesso a Google Drive riuscito"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Impostazioni Google Drive"),
        "grantPermission":
            MessageLookupByLibrary.simpleMessage("Concedi autorizzazione"),
        "group": MessageLookupByLibrary.simpleMessage("Gruppo"),
        "height": MessageLookupByLibrary.simpleMessage("Altezza"),
        "history": MessageLookupByLibrary.simpleMessage("Cronologia"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("Dimensione icona"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Importa"),
        "importAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Importa pagina voce consentita"),
        "importBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("Importa pagina liste nere"),
        "importBlockedentriesPage": MessageLookupByLibrary.simpleMessage(
            "Importa pagina voci bloccate"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Importa configurazione"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("Importa contatti"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("Importa da CSV"),
        "importFromFile":
            MessageLookupByLibrary.simpleMessage("Importa da file"),
        "importFromJson":
            MessageLookupByLibrary.simpleMessage("Importa da JSON"),
        "importFromUrl": MessageLookupByLibrary.simpleMessage("Importa da URL"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("Importa da VCF"),
        "importFromYaml":
            MessageLookupByLibrary.simpleMessage("Importa da YAML"),
        "importLabelPage":
            MessageLookupByLibrary.simpleMessage("Importa pagina etichetta"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("Importa pagina plugin"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("Importa pagina regex"),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Importa pagina iscrizione SMS"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Importa pagina liste nere testo SMS"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Importa pagina liste bianche testo SMS"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Importa pagina iscrizioni"),
        "importWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Importa pagina liste bianche"),
        "importedSuccessfullyFromUrl": MessageLookupByLibrary.simpleMessage(
            "Importato correttamente da URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("Acquisti in-app abilitati"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Azione di intercettazione chiamata in arrivo"),
        "initializing": MessageLookupByLibrary.simpleMessage(
            "Inizializzazione in corso..."),
        "initializingDatabase": MessageLookupByLibrary.simpleMessage(
            "Inizializzazione database in corso..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "Inserisci le credenziali di OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("Assicurazione"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Intercetta le chiamate in arrivo ripetute entro l\'intervallo di tempo"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Formato JSON non valido"),
        "isNotSubscribed":
            MessageLookupByLibrary.simpleMessage("non è iscritto"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("è iscritto"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Unisciti al canale e al gruppo Telegram per maggiori informazioni"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "Mantieni solo l\'ultimo backup"),
        "keyword": MessageLookupByLibrary.simpleMessage("Parola chiave"),
        "label": MessageLookupByLibrary.simpleMessage("Etichetta"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("Colore icona etichetta"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Pagina etichetta"),
        "labelpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina etichetta"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("Colore etichette"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage(
            "Dimensione carattere etichette"),
        "labelsPosition":
            MessageLookupByLibrary.simpleMessage("Posizione etichette"),
        "lastName": MessageLookupByLibrary.simpleMessage("Cognome"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Chiaro"),
        "link": MessageLookupByLibrary.simpleMessage("Collegamento"),
        "loading":
            MessageLookupByLibrary.simpleMessage("Caricamento in corso..."),
        "loan": MessageLookupByLibrary.simpleMessage("Prestito"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Directory di backup locale solo nella cartella Download"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Scheda locale 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("contenuto scheda locale 1"),
        "locationColor":
            MessageLookupByLibrary.simpleMessage("Colore posizione"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage(
            "Dimensione carattere posizione"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("Colore icona posizione"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Posizione posizione"),
        "login": MessageLookupByLibrary.simpleMessage("Accedi"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Accesso non riuscito"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Accedi a Google Drive"),
        "loginlogoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Accedi/Esci da Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Esci da Google Drive"),
        "manageRules": MessageLookupByLibrary.simpleMessage("Gestisci regole"),
        "manualBackup": MessageLookupByLibrary.simpleMessage("Backup manuale"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Contrassegnato da"),
        "matchAnyCharacter": MessageLookupByLibrary.simpleMessage(
            "Trova corrispondenze con qualsiasi carattere:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Trova corrispondenze con i numeri di telefono che contengono cifre specifiche:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Trova corrispondenze con i numeri di telefono con caratteri specifici nel mezzo:"),
        "matchSuccessful":
            MessageLookupByLibrary.simpleMessage("Match successful!"),
        "medical": MessageLookupByLibrary.simpleMessage("Medico"),
        "merge": MessageLookupByLibrary.simpleMessage("Unisci"),
        "mergeContacts":
            MessageLookupByLibrary.simpleMessage("Unisci contatti"),
        "mergeSelected":
            MessageLookupByLibrary.simpleMessage("Unisci selezionati"),
        "message": MessageLookupByLibrary.simpleMessage("Messaggio"),
        "mins": MessageLookupByLibrary.simpleMessage("min"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Nome"),
        "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "Il nome non può essere vuoto"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Colore nome"),
        "nameFontSize":
            MessageLookupByLibrary.simpleMessage("Dimensione carattere nome"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Posizione nome"),
        "next": MessageLookupByLibrary.simpleMessage("Avanti"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected": MessageLookupByLibrary.simpleMessage(
            "Nessuna immagine selezionata"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Nessun filtro messaggi SMS in arrivo"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Non verificato"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifiche"),
        "numberColor": MessageLookupByLibrary.simpleMessage("Colore numero"),
        "numberFontSize":
            MessageLookupByLibrary.simpleMessage("Dimensione carattere numero"),
        "numberPosition":
            MessageLookupByLibrary.simpleMessage("Posizione numero"),
        "numberType": MessageLookupByLibrary.simpleMessage("Tipo di numero"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("Colore tipo di numero"),
        "numberTypeFontSize": MessageLookupByLibrary.simpleMessage(
            "Dimensione carattere tipo di numero"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Posizione tipo di numero"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("Impostazioni OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription": MessageLookupByLibrary.simpleMessage(
            "Iscrizione ID chiamante online"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Solo notifica app chiamata originale"),
        "onlyRingLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Solo squillo e notifica locale"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Utilizza solo la notifica SMS originale"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Apri cartella locale"),
        "other": MessageLookupByLibrary.simpleMessage("Altro"),
        "overlay": MessageLookupByLibrary.simpleMessage("Overlay"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "Autorizzazione overlay non concessa, il che potrebbe influire sulla funzione di visualizzazione dell\'ID chiamante. È possibile abilitare l\'autorizzazione nelle impostazioni dell\'app."),
        "page": MessageLookupByLibrary.simpleMessage("Pagina"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("Incolla JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("Incolla configurazione JSON"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("Incolla JSON qui"),
        "pattern": MessageLookupByLibrary.simpleMessage("Modello"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Autorizzazione negata"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Autorizzazione concessa"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":È necessario disabilitare manualmente l\'autorizzazione nelle impostazioni dell\'app."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "l\'autorizzazione nelle impostazioni dell\'app."),
        "permissionWasNotGranted": MessageLookupByLibrary.simpleMessage(
            "l\'autorizzazione non è stata concessa."),
        "permissions": MessageLookupByLibrary.simpleMessage("Autorizzazioni"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("Autorizzazioni richieste"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefono"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Linea fissa"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("Linea fissa, Cellulare"),
        "phoneNumberTypeMobile":
            MessageLookupByLibrary.simpleMessage("Cellulare"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("Pager"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Numero personale"),
        "phoneNumberTypePremiumRate": MessageLookupByLibrary.simpleMessage(
            "Numero a tariffazione maggiorata"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("Numero a costo condiviso"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Numero verde"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Sconosciuto"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Segreteria telefonica"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber":
            MessageLookupByLibrary.simpleMessage("Numero di telefono"),
        "pleaseEnter":
            MessageLookupByLibrary.simpleMessage("Per favore inserisci"),
        "pleaseEnterAPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Inserisci un numero di telefono"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a phone number and regex pattern"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("Inserisci un modello"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("Inserisci un URL"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Seleziona un file o inserisci un URL"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("Seleziona un\'etichetta"),
        "pleaseSelectAnExportFolder": MessageLookupByLibrary.simpleMessage(
            "Seleziona una cartella di esportazione"),
        "pleaseSelectAnOutputFile": MessageLookupByLibrary.simpleMessage(
            "Seleziona un file di output:"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Seleziona le voci da esportare"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Tocca \"Concedi autorizzazione\" e consenti l\'autorizzazione nella schermata successiva."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Tocca \"Imposta predefinito\" e consenti l\'autorizzazione nella schermata successiva."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Attendere il completamento dell\'inizializzazione del database."),
        "pluginData": MessageLookupByLibrary.simpleMessage("Plugin Data:"),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Pagina plugin"),
        "plugins": MessageLookupByLibrary.simpleMessage("Plugin"),
        "pluginspageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina plugin"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("Politico"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchaseFailed":
            MessageLookupByLibrary.simpleMessage("Purchase failed:"),
        "purchaseIsBeingProcessed": MessageLookupByLibrary.simpleMessage(
            "Purchase is being processed..."),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("Purchase successful!"),
        "quarterlySubscription":
            MessageLookupByLibrary.simpleMessage("Quarterly Subscription"),
        "recordbackup": MessageLookupByLibrary.simpleMessage("RecordBackup"),
        "regex": MessageLookupByLibrary.simpleMessage("Regex"),
        "regexPage": MessageLookupByLibrary.simpleMessage("Pagina regex"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("Spiegazione modello Regex"),
        "regexPatternTest":
            MessageLookupByLibrary.simpleMessage("Regex Pattern Test"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "I modelli Regex sono espressioni regolari utilizzate per trovare corrispondenze con i numeri di telefono."),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("Regex Phone Number Test"),
        "regexpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina regex"),
        "region": MessageLookupByLibrary.simpleMessage("Regione:"),
        "reject": MessageLookupByLibrary.simpleMessage("Rifiuta"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Rifiuta tutti i numeri"),
        "remove": MessageLookupByLibrary.simpleMessage("Rimuovi"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Rimuovi annunci e abilita backup online"),
        "removeAllowed":
            MessageLookupByLibrary.simpleMessage("Rimuovi dai consentiti"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("Rimuovi dai bloccati"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn": MessageLookupByLibrary.simpleMessage(
            "Chiamate bloccate ripetute in"),
        "repeatedCalls":
            MessageLookupByLibrary.simpleMessage("Chiamate ripetute"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Ripristina da Google Drive"),
        "restoreFromLocal":
            MessageLookupByLibrary.simpleMessage("Ripristina da locale"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("Ripristina da OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Ripristina da WebDAV"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("Ride-sharing"),
        "risk": MessageLookupByLibrary.simpleMessage("Rischio"),
        "robocall": MessageLookupByLibrary.simpleMessage("Chiamata automatica"),
        "save": MessageLookupByLibrary.simpleMessage("Salva"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("Cerca contatti"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("Cerca voci"),
        "selectALabel":
            MessageLookupByLibrary.simpleMessage("Seleziona un\'etichetta:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Seleziona tutto"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Seleziona colore"),
        "selectCountryCodeOptional": MessageLookupByLibrary.simpleMessage(
            "Seleziona prefisso internazionale (opzionale)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("Seleziona voci"),
        "selectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Seleziona le voci da esportare"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Contatti selezionati uniti correttamente"),
        "selectedLabel":
            MessageLookupByLibrary.simpleMessage("Etichetta selezionata"),
        "selectingExportFolder": MessageLookupByLibrary.simpleMessage(
            "selezione cartella di esportazione"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Intervalli di aggiornamento del servizio (giorni)"),
        "settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("Impostazioni salvate"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("Imposta predefinito"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Imposta app ID chiamante predefinita"),
        "sharing": MessageLookupByLibrary.simpleMessage("Condivisione"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("Mostra pulsante contatto"),
        "showContactIconButton": MessageLookupByLibrary.simpleMessage(
            "Mostra pulsante icona contatto"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("Mostra Telegram"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("Mostra WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("Risultati per"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("Silenzioso senza risposta"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("Colore SIM"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("Dimensione carattere SIM"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("Posizione SIM"),
        "skip": MessageLookupByLibrary.simpleMessage("Salta"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Pagina lista nera SMS"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("Filtro SMS"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "Il filtro SMS richiede le autorizzazioni SMS, notifica e telefono. Concedere queste autorizzazioni per abilitare questa funzionalità."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Notifica SMS locale"),
        "smsNotification": MessageLookupByLibrary.simpleMessage("Notifica SMS"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Pagina iscrizione SMS"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Pagina lista bianca testo SMS"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina lista nera SMS"),
        "smssubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione elenco iscrizioni SMS"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina lista nera testo SMS"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina lista bianca testo SMS"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina lista bianca SMS"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("Probabile spam"),
        "startColor": MessageLookupByLibrary.simpleMessage("Colore iniziale"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Intervallo di tempo statistiche (minuti):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("Colore STIR"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("Dimensione carattere STIR"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("Posizione STIR"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Archiviazione"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Iscriviti"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Iscritto"),
        "subscribedLink": MessageLookupByLibrary.simpleMessage("Link iscritto"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("Pagina elenco iscrizioni"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione elenco iscrizioni"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "successfully": MessageLookupByLibrary.simpleMessage("correttamente"),
        "survey": MessageLookupByLibrary.simpleMessage("Sondaggio"),
        "sync": MessageLookupByLibrary.simpleMessage("Sincronizza"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "takeaway": MessageLookupByLibrary.simpleMessage("Asporto"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("Telemarketing"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("Test"),
        "testCallerIdOverlay":
            MessageLookupByLibrary.simpleMessage("Test Caller ID Overlay"),
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("Colori testo ed etichette"),
        "textType": MessageLookupByLibrary.simpleMessage("Tipo di testo"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Questa app è un potente strumento di ID chiamante che ti consente di identificare chiamanti sconosciuti e bloccare chiamate indesiderate. Offre le seguenti funzionalità:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Questa app necessita di accedere alle informazioni del registro chiamate per funzionare correttamente. Concedi l\'autorizzazione."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "Questa autorizzazione è necessaria affinché la nostra app sia l\'app ID chiamante predefinita."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "Questa autorizzazione è necessaria affinché la nostra app visualizzi informazioni importanti sopra altre app.\\n\\n"),
        "toTestRules": MessageLookupByLibrary.simpleMessage("To test rules"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Tutorial"),
        "unknown": MessageLookupByLibrary.simpleMessage("Sconosciuto"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("Non iscritto"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect": MessageLookupByLibrary.simpleMessage(
            "Il formato dell\'URL non è corretto"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("Usa immagine di rete"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Utilizza il carattere \'.\' per trovare corrispondenze con qualsiasi singolo carattere. Ad esempio, il modello \'123.456\' corrisponde a \'123-456\', \'123.456\', \'123a456\', ecc."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Utilizza il modello \'^0[0-9]{2,3}\' per trovare corrispondenze con i numeri di telefono che iniziano con \'0\' seguito da 2 o 3 cifre, che in genere rappresenta un prefisso.\nUtilizza il modello \'^010\' per bloccare le chiamate dal prefisso di Pechino (010).\nUtilizza il modello \'^202\' per bloccare le chiamate dal prefisso di Washington (202).\nSostituisci il prefisso \'^0[0-9]{2,3}\' con quello specifico che desideri bloccare."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Utilizza il modello \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' per trovare corrispondenze con i numeri di telefono nel formato \'XXX-XXXX-XXXX\'. Sostituisci \'X\' con le cifre specifiche che desideri trovare."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Utilizza il modello \'^\\+\' per trovare corrispondenze con tutti i numeri di telefono che iniziano con un segno più, che in genere indica un numero internazionale."),
        "userName": MessageLookupByLibrary.simpleMessage("Nome utente"),
        "verificationPageRules":
            MessageLookupByLibrary.simpleMessage("Verification Page (Rules)"),
        "verificationResultsRules": MessageLookupByLibrary.simpleMessage(
            "Verification Results (shouldAcceptCall Rules):"),
        "verified": MessageLookupByLibrary.simpleMessage("Verificato"),
        "verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "verifyPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Verify Phone Number"),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("Impostazioni WebDAV"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("URL WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("Sito web"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Lista bianca"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("Pagina lista bianca"),
        "whitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Visualizzazione pagina lista bianca"),
        "width": MessageLookupByLibrary.simpleMessage("Larghezza"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "Supporto caratteri jolly per un filtro flessibile"),
        "windowSize":
            MessageLookupByLibrary.simpleMessage("Dimensione finestra"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "È possibile utilizzare la sintassi standard delle espressioni regolari per definire i modelli oppure chiedere all\'IA di generare il modello per Flutter."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Hai negato l\'autorizzazione. Puoi abilitarla manualmente nelle Impostazioni."),
        "youHaveEnabledThePermission": MessageLookupByLibrary.simpleMessage(
            "Hai abilitato l\'autorizzazione."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe": MessageLookupByLibrary.simpleMessage(
            "È necessario disabilitare manualmente"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
