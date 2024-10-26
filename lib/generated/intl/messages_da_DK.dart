// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a da_DK locale. All the
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
  String get localeName => 'da_DK';

  static String m0(permissionName) =>
      "${permissionName} tilladelse blev ikke givet.";

  static String m1(listType) => "Føj til ${listType}";

  static String m2(listType) => "Føj til ${listType}";

  static String m3(permissionName) =>
      "Du skal manuelt deaktivere ${permissionName} tilladelsen i appindstillingerne.";

  static String m4(listType) => "Fjern ${listType}";

  static String m5(listType) => "Fjern ${listType}";

  static String m6(permissionName) =>
      "Du skal manuelt deaktivere ${permissionName} tilladelsen i appindstillingerne.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("Om"),
        "accept": MessageLookupByLibrary.simpleMessage("Accepter"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("Annonce aktiveret:"),
        "add": MessageLookupByLibrary.simpleMessage("Tilføj"),
        "addAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Tilføj tilladt postside"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Tilføj sortlisteside"),
        "addBlockedPage":
            MessageLookupByLibrary.simpleMessage("Tilføj blokeret side"),
        "addContact": MessageLookupByLibrary.simpleMessage("Tilføj kontakt"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Tilføj kontaktabonnementsside"),
        "addLabelPage":
            MessageLookupByLibrary.simpleMessage("Tilføj etiketside"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Tilføj pluginside"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("Tilføj Regex-side"),
        "addSmsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Tilføj SMS-sortlisteside"),
        "addSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Tilføj SMS-abonnementsside"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Tilføj SMS-tekst sortlisteside"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Tilføj SMS-tekst hvidlistesider"),
        "addSmsWhitelistPage":
            MessageLookupByLibrary.simpleMessage("Tilføj SMS-hvidlisteside"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Tilføj abonnementsside"),
        "addToAllowed": MessageLookupByLibrary.simpleMessage("Føj til tilladt"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Føj til blokeret"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("Føj til etiket"),
        "addWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("Tilføj hvidlistesider"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("tilføjet med succes"),
        "all": MessageLookupByLibrary.simpleMessage("Alle"),
        "allowAllAllowedNumbers":
            MessageLookupByLibrary.simpleMessage("Tillad alle tilladte numre"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Tillad alle sortlistede numre"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Tillad alle hvidlistede numre"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("Tillad blokerede numre"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Tillad Regex-sortlistede mønstre"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Tillad Regex-hvidlistede mønstre"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Tillad gentagne indgående opkald"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Tillad denne app at vise opkalds-ID"),
        "allowed": MessageLookupByLibrary.simpleMessage("Tilladt"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Tilladt postside"),
        "allowedpageview":
            MessageLookupByLibrary.simpleMessage("TilladtSidevisning"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Svar og læg på"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Er du sikker på, at du vil slette elementet?"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Er du sikker på, at du vil slette denne kontakt?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Luk lokal notifikation automatisk"),
        "autoUpdateDisabled": MessageLookupByLibrary.simpleMessage(
            "Automatisk opdatering deaktiveret"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage(
            "Automatisk opdatering aktiveret"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("Avatar- og ikonstørrelser"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("Avatar-kantfarve"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("Avatar-kantstørrelse"),
        "avatarPosition":
            MessageLookupByLibrary.simpleMessage("Avatarposition"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("Avatarstørrelse"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("Avatar URL eller sti"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Baggrundsgradient"),
        "backup": MessageLookupByLibrary.simpleMessage("Backup"),
        "backupAndRestore":
            MessageLookupByLibrary.simpleMessage("Backup og gendannelse"),
        "bank": MessageLookupByLibrary.simpleMessage("Bank"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Batterioptimering"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Sortliste"),
        "blacklistPage": MessageLookupByLibrary.simpleMessage("Sortlisteside"),
        "blacklistingAndWhitelisting": MessageLookupByLibrary.simpleMessage(
            "Sortlistning og hvidlistning"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("Sortlistesidevisning"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Bloker opkald fra specifikke områdekoder:"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "Bloker internationale opkald:"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blokeret"),
        "blockedCallAction": MessageLookupByLibrary.simpleMessage(
            "Handling for blokeret opkald"),
        "blockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Notifikation om blokeret opkald"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics": MessageLookupByLibrary.simpleMessage(
            "Statistik over blokerede opkald"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("Blokeret side"),
        "blockedpageview":
            MessageLookupByLibrary.simpleMessage("BlokeretSidevisning"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Både original opkaldsapp og lokal notifikation"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Både original SMS og lokal notifikation"),
        "call": MessageLookupByLibrary.simpleMessage("Opkald"),
        "callHistory": MessageLookupByLibrary.simpleMessage("Opkaldshistorik"),
        "callLog": MessageLookupByLibrary.simpleMessage("Opkaldslog"),
        "callLogPermissionDenied":
            MessageLookupByLibrary.simpleMessage("Opkaldslogtilladelse nægtet"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Anmodning om opkalds screeningrolle mislykkedes!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Anmodning om opkalds screeningrolle lykkedes!"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("Opkalds-ID-app"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("Opkalds-ID-stil"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("Opkalds-ID-stilindhold"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("Opkaldstype-ikonfarve"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annuller"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Udbyder:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("Udbyderfarve"),
        "carrierFontSize":
            MessageLookupByLibrary.simpleMessage("Udbyderskriftstørrelse"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("Udbyderposition"),
        "charity": MessageLookupByLibrary.simpleMessage("Velgørenhed"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Vælg avatar (lokal eller netværk):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Vælg fra galleri"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("Vælg kun link eller fil"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Vælg standard afbrydelseshandling"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Vælg dit sprog"),
        "clientId": MessageLookupByLibrary.simpleMessage("Klient-ID"),
        "close": MessageLookupByLibrary.simpleMessage("Luk"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName":
            MessageLookupByLibrary.simpleMessage("Cloud backupmappenavn"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "Cloud backup kræver automatisk backup"),
        "cloudServices":
            MessageLookupByLibrary.simpleMessage("Cloud-tjenester"),
        "collection": MessageLookupByLibrary.simpleMessage("Indsamling"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "Konfiguration eksporteret til fil!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Konfiguration importeret"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Konfiguration importeret!"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Konfiguration gemt!"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Bekræft sletning"),
        "contactFile": MessageLookupByLibrary.simpleMessage("Kontaktfil"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Kontaktabonnementsside"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Kontakt os"),
        "contacts": MessageLookupByLibrary.simpleMessage("Kontakter"),
        "contactsExportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Kontakter eksporteret med succes"),
        "contactsImportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Kontakter importeret med succes"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("Kontakter side"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("kontakter med nummer"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Kontaktabonnementslistevisning"),
        "countColor": MessageLookupByLibrary.simpleMessage("Antalfarve"),
        "countFontSize":
            MessageLookupByLibrary.simpleMessage("Antalskriftstørrelse"),
        "countPosition": MessageLookupByLibrary.simpleMessage("Antalposition"),
        "country": MessageLookupByLibrary.simpleMessage("Land:"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Landsnavnefarve"),
        "countryNameFontSize":
            MessageLookupByLibrary.simpleMessage("Landsnavneskriftstørrelse"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Landsnavneposition"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("Beskær avatar"),
        "customerService": MessageLookupByLibrary.simpleMessage("Kundeservice"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("Tilpas opkalds-ID"),
        "dark": MessageLookupByLibrary.simpleMessage("Mørk"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Mørk tilstand"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Slet"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("Slet kontakt"),
        "deleted": MessageLookupByLibrary.simpleMessage("Slettet"),
        "delivery": MessageLookupByLibrary.simpleMessage("Levering"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Du har nægtet tilladelse. Du kan manuelt aktivere tilladelsen i Indstillinger."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Deaktiver notifikation om blokeret opkald"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("Deaktiver tilladelse"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Deaktiver lokal SMS-notifikation"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Deaktiver denne app at vise opkalds-ID"),
        "disabled": MessageLookupByLibrary.simpleMessage("Deaktiveret"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("E-handel"),
        "edit": MessageLookupByLibrary.simpleMessage("Rediger"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("Rediger avatar"),
        "editCode": MessageLookupByLibrary.simpleMessage("Rediger kode"),
        "editContact": MessageLookupByLibrary.simpleMessage("Rediger kontakt"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Rediger pluginkode"),
        "education": MessageLookupByLibrary.simpleMessage("Uddannelse"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Elementpositioner"),
        "email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Aktivér notifikation om blokeret opkald"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Aktivér mørk tilstand baseret på tid"),
        "enableOverlayPermission":
            MessageLookupByLibrary.simpleMessage("Aktivér overlay-tilladelse"),
        "enableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Aktivér lokal SMS-notifikation"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds": MessageLookupByLibrary.simpleMessage(
            "Aktivér for at fjerne annoncer"),
        "enabled": MessageLookupByLibrary.simpleMessage("Aktiveret"),
        "endColor": MessageLookupByLibrary.simpleMessage("Slutfarve"),
        "endcall": MessageLookupByLibrary.simpleMessage("Afslut opkald"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Indtast billed-URL"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("Indtast pluginkode her"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("Indtast URL"),
        "entry": MessageLookupByLibrary.simpleMessage("Post"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("post tilføjet med succes"),
        "error": MessageLookupByLibrary.simpleMessage("Fejl"),
        "errorExportingContacts": MessageLookupByLibrary.simpleMessage(
            "Fejl ved eksport af kontakter:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Fejl ved hentning af tilladelsesstatus"),
        "errorImporting":
            MessageLookupByLibrary.simpleMessage("Fejl ved import"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Fejl ved anmodning om opkalds screeningrolle:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Eksporter"),
        "exportAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Eksporter tilladt postside"),
        "exportAsCsv":
            MessageLookupByLibrary.simpleMessage("Eksporter som CSV"),
        "exportAsJson":
            MessageLookupByLibrary.simpleMessage("Eksporter som JSON"),
        "exportAsVcf":
            MessageLookupByLibrary.simpleMessage("Eksporter som VCF"),
        "exportAsYaml":
            MessageLookupByLibrary.simpleMessage("Eksporter som YAML"),
        "exportBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Eksporter sortlisteside"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("Eksporter blokeret side"),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Eksporter kontaktabonnementsside"),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("Eksporter kontakter"),
        "exportFailed":
            MessageLookupByLibrary.simpleMessage("Eksport mislykkedes"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("eksportformat:"),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("Eksporter etiketside"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("Eksporter pluginside"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("Eksporter Regex-side"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksporter SMS-sortlistesider"),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Eksporter SMS-abonnementsside"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksporter SMS-tekst sortlistesider"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksporter SMS-tekst hvidlistesider"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksporter SMS-hvidlistesider"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Eksporter abonnementsider"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("Eksport lykkedes"),
        "exportWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("Eksporter hvidlistesider"),
        "failed": MessageLookupByLibrary.simpleMessage("Mislykkedes"),
        "failedToAdd":
            MessageLookupByLibrary.simpleMessage("Kunne ikke tilføje:"),
        "failedToAddEntry":
            MessageLookupByLibrary.simpleMessage("Kunne ikke tilføje post:"),
        "feature": MessageLookupByLibrary.simpleMessage("Funktion"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("funktionsbeskrivelse"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages": MessageLookupByLibrary.simpleMessage(
            "Filtrer indgående SMS-beskeder"),
        "filterRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Filtrer gentagne indgående opkald"),
        "financial": MessageLookupByLibrary.simpleMessage("Finansiel"),
        "firstName": MessageLookupByLibrary.simpleMessage("Fornavn"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("Sandsynligvis svindel"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Kom i gang"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "Google Drive-login mislykkedes"),
        "googleDriveLoginSuccessfully":
            MessageLookupByLibrary.simpleMessage("Google Drive-login lykkedes"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Google Drive-indstilling"),
        "grantPermission":
            MessageLookupByLibrary.simpleMessage("Giv tilladelse"),
        "group": MessageLookupByLibrary.simpleMessage("Gruppe"),
        "height": MessageLookupByLibrary.simpleMessage("Højde"),
        "history": MessageLookupByLibrary.simpleMessage("Historik"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("Ikonstørrelse"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Importer"),
        "importAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Importer tilladt postside"),
        "importBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("Importer sortlistesider"),
        "importBlockedentriesPage": MessageLookupByLibrary.simpleMessage(
            "Importer blokerede poster-side"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Importer konfiguration"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("Importer kontakter"),
        "importFromCsv":
            MessageLookupByLibrary.simpleMessage("Importer fra CSV"),
        "importFromFile":
            MessageLookupByLibrary.simpleMessage("Importer fra fil"),
        "importFromJson":
            MessageLookupByLibrary.simpleMessage("Importer fra JSON"),
        "importFromUrl":
            MessageLookupByLibrary.simpleMessage("Importer fra URL"),
        "importFromVcf":
            MessageLookupByLibrary.simpleMessage("Importer fra VCF"),
        "importFromYaml":
            MessageLookupByLibrary.simpleMessage("Importer fra YAML"),
        "importLabelPage":
            MessageLookupByLibrary.simpleMessage("Importer etiketside"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("Importer pluginside"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("Importer Regex-side"),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Importer SMS-abonnementsside"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Importer SMS-tekst sortlistesider"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Importer SMS-tekst hvidlistesider"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Importer abonnementsider"),
        "importWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("Importer hvidlistesider"),
        "importedSuccessfullyFromUrl": MessageLookupByLibrary.simpleMessage(
            "Importeret med succes fra URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("Køb i appen aktiveret"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Afbrydelseshandling for indgående opkald"),
        "initializing":
            MessageLookupByLibrary.simpleMessage("Initialiserer..."),
        "initializingDatabase":
            MessageLookupByLibrary.simpleMessage("Initialiserer database..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "Indtast OneDrive-legitimationsoplysninger"),
        "insurance": MessageLookupByLibrary.simpleMessage("Forsikring"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Afbryd gentagne indgående opkald inden for tidsintervallet"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Ugyldigt JSON-format"),
        "isNotSubscribed":
            MessageLookupByLibrary.simpleMessage("er ikke abonneret"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("er abonneret"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Deltag i Telegram-kanalen og -gruppen for mere information"),
        "keepOnlyLatestBackup":
            MessageLookupByLibrary.simpleMessage("Behold kun seneste backup"),
        "keyword": MessageLookupByLibrary.simpleMessage("Nøgleord"),
        "label": MessageLookupByLibrary.simpleMessage("Etiket"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("Etiket-ikonfarve"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Etiketside"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("Etiketsidevisning"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("Etiketfarve"),
        "labelsFontSize":
            MessageLookupByLibrary.simpleMessage("Etiketskriftstørrelse"),
        "labelsPosition":
            MessageLookupByLibrary.simpleMessage("Etiketposition"),
        "lastName": MessageLookupByLibrary.simpleMessage("Efternavn"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Lys"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loading": MessageLookupByLibrary.simpleMessage("Indlæser..."),
        "loan": MessageLookupByLibrary.simpleMessage("Lån"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Lokal backupmappe kun under downloadmappe"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Lokalt kort 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("Lokalt kort 1 indhold"),
        "locationColor":
            MessageLookupByLibrary.simpleMessage("Placeringsfarve"),
        "locationFontSize":
            MessageLookupByLibrary.simpleMessage("Placeringsskriftstørrelse"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("Placering-ikonfarve"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Placeringsposition"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Login mislykkedes"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Login Google Drive"),
        "loginlogoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Login/Logout Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Logout Google Drive"),
        "manageRules":
            MessageLookupByLibrary.simpleMessage("Administrer regler"),
        "manualBackup": MessageLookupByLibrary.simpleMessage("Manuel backup"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Markeret af"),
        "matchAnyCharacter":
            MessageLookupByLibrary.simpleMessage("Match ethvert tegn:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Match telefonnumre, der indeholder specifikke cifre:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Match telefonnumre med specifikke tegn i midten:"),
        "medical": MessageLookupByLibrary.simpleMessage("Medicinsk"),
        "merge": MessageLookupByLibrary.simpleMessage("Flet"),
        "mergeContacts": MessageLookupByLibrary.simpleMessage("Flet kontakter"),
        "mergeSelected": MessageLookupByLibrary.simpleMessage("Flet valgte"),
        "message": MessageLookupByLibrary.simpleMessage("Besked"),
        "mins": MessageLookupByLibrary.simpleMessage("min"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Navn"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Navn kan ikke være tomt"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Navnefarve"),
        "nameFontSize":
            MessageLookupByLibrary.simpleMessage("Navneskriftstørrelse"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Navneposition"),
        "next": MessageLookupByLibrary.simpleMessage("Næste"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("Ingen billede valgt"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Ingen filter for indgående SMS-beskeder"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Ikke bekræftet"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifikationer"),
        "numberColor": MessageLookupByLibrary.simpleMessage("Nummerfarve"),
        "numberFontSize":
            MessageLookupByLibrary.simpleMessage("Nummerskriftstørrelse"),
        "numberPosition":
            MessageLookupByLibrary.simpleMessage("Nummerposition"),
        "numberType": MessageLookupByLibrary.simpleMessage("Nummertype"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("Nummertypefarve"),
        "numberTypeFontSize":
            MessageLookupByLibrary.simpleMessage("Nummertypeskriftstørrelse"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Nummertypeposition"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("OneDrive-indstilling"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription": MessageLookupByLibrary.simpleMessage(
            "Online opkalds-ID-abonnement"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Kun original opkaldsapp notifikation"),
        "onlyRingLocalNotification":
            MessageLookupByLibrary.simpleMessage("Kun ring lokal notifikation"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Kun brug original SMS-notifikation"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Åbn lokal mappe"),
        "other": MessageLookupByLibrary.simpleMessage("Andet"),
        "overlay": MessageLookupByLibrary.simpleMessage("Overlay"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "Overlay-tilladelse ikke givet, hvilket kan påvirke opkalds-ID-visningsfunktionen. Du kan aktivere tilladelsen i appindstillingerne."),
        "page": MessageLookupByLibrary.simpleMessage("Side"),
        "password": MessageLookupByLibrary.simpleMessage("Adgangskode"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("Indsæt JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("Indsæt JSON-konfiguration"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("Indsæt JSON her"),
        "pattern": MessageLookupByLibrary.simpleMessage("Mønster"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Tilladelse nægtet"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Tilladelse givet"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":Du skal manuelt deaktivere tilladelsen i appindstillingerne."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "tilladelsen i appindstillingerne."),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("tilladelse blev ikke givet."),
        "permissions": MessageLookupByLibrary.simpleMessage("Tilladelser"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("Nødvendige tilladelser"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefon"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Fastnet"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("Fastnet, Mobil"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("Mobil"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("Pager"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Personligt nummer"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("Premium Rate"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("Delte omkostninger"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Gratisnummer"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Ukendt"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Voicemail"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("Telefonnummer"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("Indtast venligst"),
        "pleaseEnterAPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Indtast venligst et telefonnummer"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("Indtast venligst et mønster"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("Indtast venligst en URL"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Vælg venligst en fil eller indtast en URL"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("Vælg venligst en etiket"),
        "pleaseSelectAnExportFolder": MessageLookupByLibrary.simpleMessage(
            "Vælg venligst en eksportmappe"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("Vælg venligst en outputfil:"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Vælg venligst poster, der skal eksporteres"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Tryk venligst på \"Giv tilladelse\" og tillad tilladelsen på det næste skærmbillede."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Tryk venligst på \"Opsæt standard\" og tillad tilladelsen på det næste skærmbillede."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Vent venligst, mens databaseinitialiseringen fuldføres."),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Pluginside"),
        "plugins": MessageLookupByLibrary.simpleMessage("Plugins"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("Pluginsidevisning"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("Politisk"),
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
        "regexPage": MessageLookupByLibrary.simpleMessage("Regex-side"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("Forklaring af Regex-mønster"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Regex-mønstre er regulære udtryk, der bruges til at matche telefonnumre."),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("RegexSidevisning"),
        "region": MessageLookupByLibrary.simpleMessage("Region:"),
        "reject": MessageLookupByLibrary.simpleMessage("Afvis"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Afvis alle numre"),
        "remove": MessageLookupByLibrary.simpleMessage("Fjern"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Fjern annoncer og aktiver online backup"),
        "removeAllowed": MessageLookupByLibrary.simpleMessage("Fjern tilladt"),
        "removeAllowedtype": m4,
        "removeBlocked": MessageLookupByLibrary.simpleMessage("Fjern blokeret"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn":
            MessageLookupByLibrary.simpleMessage("Gentagne blokerede opkald i"),
        "repeatedCalls":
            MessageLookupByLibrary.simpleMessage("Gentagne opkald"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Gendan fra Google Drive"),
        "restoreFromLocal":
            MessageLookupByLibrary.simpleMessage("Gendan fra lokal"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("Gendan fra OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Gendan fra WebDAV"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("Samkørsel"),
        "risk": MessageLookupByLibrary.simpleMessage("Risiko"),
        "robocall": MessageLookupByLibrary.simpleMessage("Robocall"),
        "save": MessageLookupByLibrary.simpleMessage("Gem"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts": MessageLookupByLibrary.simpleMessage("Søg kontakter"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("Søg poster"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("Vælg en etiket:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Vælg alle"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Vælg farve"),
        "selectCountryCodeOptional":
            MessageLookupByLibrary.simpleMessage("Vælg landekode (valgfrit)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("Vælg poster"),
        "selectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Vælg poster, der skal eksporteres"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Valgte kontakter flettet med succes"),
        "selectedLabel": MessageLookupByLibrary.simpleMessage("Valgt etiket"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("vælger eksportmappe"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Serviceopdateringsintervaller (dage)"),
        "settings": MessageLookupByLibrary.simpleMessage("Indstillinger"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("Indstillinger gemt"),
        "setupDefault": MessageLookupByLibrary.simpleMessage("Opsæt standard"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Opsæt standard opkalds-ID-app"),
        "sharing": MessageLookupByLibrary.simpleMessage("Deling"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("Vis kontaktknap"),
        "showContactIconButton":
            MessageLookupByLibrary.simpleMessage("Vis kontakt ikonknap"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("Vis Telegram"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("Vis WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("Viser resultater for"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("Stilhed uden svar"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("SIM-kortfarve"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("SIM-kortskriftstørrelse"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("SIM-kortposition"),
        "skip": MessageLookupByLibrary.simpleMessage("Spring over"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("SMS-sortlisteside"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("SMS-filtrering"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "SMS-filtrering kræver SMS-, notifikations- og telefontilladelser. Giv venligst disse tilladelser for at aktivere denne funktion."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Lokal SMS-notifikation"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("SMS-notifikation"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("SMS-abonnementsside"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage":
            MessageLookupByLibrary.simpleMessage("SMS-tekst hvidlisteside"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview":
            MessageLookupByLibrary.simpleMessage("SmsSortlistesidevisning"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("SmsAbonnementslistevisning"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "SmsTekstSortlistesidevisning"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "SmsTekstHvidlistesidevisning"),
        "smswhitelistpageview":
            MessageLookupByLibrary.simpleMessage("SmsHvidlistesidevisning"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely":
            MessageLookupByLibrary.simpleMessage("Sandsynligvis spam"),
        "startColor": MessageLookupByLibrary.simpleMessage("Startfarve"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Statistik tidsinterval (minutter):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("Stir-farve"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("Stir-skriftstørrelse"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("Stir-position"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Lagerplads"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Abonner"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Abonneret"),
        "subscribedLink":
            MessageLookupByLibrary.simpleMessage("Abonneret link"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("Abonnementslisteside"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Abonnementslistevisning"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successfully": MessageLookupByLibrary.simpleMessage("med succes"),
        "survey": MessageLookupByLibrary.simpleMessage("Undersøgelse"),
        "sync": MessageLookupByLibrary.simpleMessage("Synkroniser"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "takeaway": MessageLookupByLibrary.simpleMessage("Takeaway"),
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
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("Tekst- og etiketfarver"),
        "textType": MessageLookupByLibrary.simpleMessage("Teksttype"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Denne app er et kraftfuldt opkalds-ID-værktøj, der giver dig mulighed for at identificere ukendte opkaldere og blokere uønskede opkald. Den har følgende funktioner:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Denne app skal have adgang til dine opkaldsloginformationer for at fungere korrekt. Giv venligst tilladelse."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "Denne tilladelse er påkrævet for at vores app kan være standardopkalds-ID-appen."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "Denne tilladelse er påkrævet for at vores app kan vise vigtige oplysninger oven på andre apps.\\n\\n"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Vejledning"),
        "unknown": MessageLookupByLibrary.simpleMessage("Ukendt"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("Afmeldt"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("URL-formatet er forkert"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("Brug netværksbillede"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Brug \'.\'-tegnet til at matche ethvert enkelt tegn. For eksempel matcher mønsteret \'123.456\' \'123-456\', \'123.456\', \'123a456\' osv."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Brug mønsteret \'^0[0-9]{2,3}\' til at matche telefonnumre, der starter med \'0\' efterfulgt af 2 eller 3 cifre, hvilket typisk repræsenterer en områdekode.\nBrug mønsteret \'^010\' til at blokere opkald fra Beijing-områdekoden (010).\nBrug mønsteret \'^202\' til at blokere opkald fra Washington-områdekoden (202).\nErstat \'^0[0-9]{2,3}\' områdekoden med den specifikke, du vil blokere."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Brug mønsteret \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' til at matche telefonnumre i formatet \'XXX-XXXX-XXXX\'. Erstat \'X\' med de specifikke cifre, du vil matche."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Brug mønsteret \'^\\+\' til at matche alle telefonnumre, der starter med et plustegn, hvilket typisk indikerer et internationalt nummer."),
        "userName": MessageLookupByLibrary.simpleMessage("Brugernavn"),
        "verified": MessageLookupByLibrary.simpleMessage("Bekræftet"),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("WebDAV-indstilling"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
        "website": MessageLookupByLibrary.simpleMessage("Websted"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Hvidliste"),
        "whitelistPage": MessageLookupByLibrary.simpleMessage("Hvidlisteside"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("Hvidlistesidevisning"),
        "width": MessageLookupByLibrary.simpleMessage("Bredde"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "Jokertegnstøtte til fleksibel filtrering"),
        "windowSize": MessageLookupByLibrary.simpleMessage("Vindusstørrelse"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "Du kan bruge standard regulær udtrykssyntaks til at definere mønstre eller bede AI om at generere mønsteret til Flutter."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Du har nægtet tilladelse. Du kan manuelt aktivere tilladelsen i Indstillinger."),
        "youHaveEnabledThePermission": MessageLookupByLibrary.simpleMessage(
            "Du har aktiveret tilladelsen."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("Du skal manuelt deaktivere"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
