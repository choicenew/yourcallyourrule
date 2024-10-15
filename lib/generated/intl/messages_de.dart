// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(permissionName) =>
      "${permissionName}-Berechtigung wurde nicht erteilt.";

  static String m1(listType) => "Zu ${listType} hinzufügen";

  static String m2(listType) => "Zu ${listType} hinzufügen";

  static String m3(permissionName) =>
      "Sie müssen die ${permissionName}-Berechtigung manuell in den App-Einstellungen deaktivieren.";

  static String m4(listType) => "${listType} entfernen";

  static String m5(listType) => "${listType} entfernen";

  static String m6(permissionName) =>
      "Sie müssen die Berechtigung ${permissionName} manuell in den App-Einstellungen deaktivieren.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("Über"),
        "accept": MessageLookupByLibrary.simpleMessage("Annehmen"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("Werbung aktiviert:"),
        "add": MessageLookupByLibrary.simpleMessage("Hinzufügen"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Erlaubten Eintrag hinzufügen\""),
        "addBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Blacklist hinzufügen\""),
        "addBlockedPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Blockiert hinzufügen\""),
        "addContact":
            MessageLookupByLibrary.simpleMessage("Kontakt hinzufügen"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Kontaktabonnement hinzufügen\""),
        "addLabelPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Etikett hinzufügen\""),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Seite \"Plugin hinzufügen\""),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("Seite \"Regex hinzufügen\""),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Blacklist hinzufügen\""),
        "addSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Abonnement hinzufügen\""),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Text-Blacklist hinzufügen\""),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Text-Whitelists hinzufügen\""),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Whitelist hinzufügen\""),
        "addSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Abonnement hinzufügen\""),
        "addToAllowed":
            MessageLookupByLibrary.simpleMessage("Zu \"Erlaubt\" hinzufügen"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Zu \"Blockiert\" hinzufügen"),
        "addToBlockedtype": m2,
        "addToLabel":
            MessageLookupByLibrary.simpleMessage("Zu Etikett hinzufügen"),
        "addWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Whitelists hinzufügen\""),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("erfolgreich hinzugefügt"),
        "all": MessageLookupByLibrary.simpleMessage("Alle"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "Alle erlaubten Nummern zulassen"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Alle Blacklist-Nummern zulassen"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Alle Whitelist-Nummern zulassen"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("Blockierte Nummern zulassen"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Regex-Blacklist-Muster zulassen"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Regex-Whitelist-Muster zulassen"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Wiederholte eingehende Anrufe zulassen"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Dieser App erlauben, die Anrufer-ID anzuzeigen"),
        "allowed": MessageLookupByLibrary.simpleMessage("Erlaubt"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Seite \"Erlaubter Eintrag\""),
        "allowedpageview":
            MessageLookupByLibrary.simpleMessage("Ansicht der erlaubten Seite"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Annehmen und auflegen"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Sind Sie sicher, dass Sie das Element löschen möchten?"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Sind Sie sicher, dass Sie diesen Kontakt löschen möchten?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Lokale Benachrichtigung automatisch schließen"),
        "autoUpdateDisabled": MessageLookupByLibrary.simpleMessage(
            "Automatisches Update deaktiviert"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage(
            "Automatisches Update aktiviert"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("Avatar- und Symbolgrößen"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("Avatar-Rahmenfarbe"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("Avatar-Rahmengröße"),
        "avatarPosition":
            MessageLookupByLibrary.simpleMessage("Avatar-Position"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("Avatar-Größe"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("Avatar-URL oder -Pfad"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Hintergrundverlauf"),
        "backup": MessageLookupByLibrary.simpleMessage("Sicherungskopie"),
        "backupAndRestore": MessageLookupByLibrary.simpleMessage(
            "Sichern und Wiederherstellen"),
        "bank": MessageLookupByLibrary.simpleMessage("Bank"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Batterieoptimierung"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Blacklist"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("Blacklist-Seite"),
        "blacklistingAndWhitelisting": MessageLookupByLibrary.simpleMessage(
            "Blacklisting und Whitelisting"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("Ansicht der Blacklist-Seite"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Anrufe von bestimmten Vorwahlen blockieren:"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "Internationale Anrufe blockieren:"),
        "blocked": MessageLookupByLibrary.simpleMessage("Blockiert"),
        "blockedCallAction": MessageLookupByLibrary.simpleMessage(
            "Aktion bei blockierten Anrufen"),
        "blockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Benachrichtigung über blockierte Anrufe"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics": MessageLookupByLibrary.simpleMessage(
            "Statistiken blockierter Anrufe"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("Blockierte Seite"),
        "blockedpageview": MessageLookupByLibrary.simpleMessage(
            "Ansicht der blockierten Seite"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Benachrichtigung der ursprünglichen Anruf-App & lokale Benachrichtigung"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Ursprüngliche SMS- & lokale Benachrichtigung"),
        "call": MessageLookupByLibrary.simpleMessage("Anruf"),
        "callHistory": MessageLookupByLibrary.simpleMessage("Anrufliste"),
        "callLog": MessageLookupByLibrary.simpleMessage("Anrufprotokoll"),
        "callLogPermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Berechtigung für Anrufprotokoll verweigert"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Anrufüberprüfungsrollen-Anfrage fehlgeschlagen!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Anrufüberprüfungsrollen-Anfrage erfolgreich!"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("Anrufer-ID-App"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("Anrufer-ID-Stil"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("Inhalt des Anrufer-ID-Stils"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("Farbe des Anruftypsymbols"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Netzbetreiber:"),
        "carrierColor":
            MessageLookupByLibrary.simpleMessage("Netzbetreiberfarbe"),
        "carrierFontSize": MessageLookupByLibrary.simpleMessage(
            "Schriftgröße des Netzbetreibers"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("Netzbetreiberposition"),
        "charity": MessageLookupByLibrary.simpleMessage("Wohltätigkeit"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Avatar auswählen (lokal oder Netzwerk):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Aus Galerie auswählen"),
        "chooseOnlyLinkOrFile": MessageLookupByLibrary.simpleMessage(
            "Wählen Sie nur Link oder Datei"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Standardmäßige Abfangaktion auswählen"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Sprache auswählen"),
        "clientId": MessageLookupByLibrary.simpleMessage("Client-ID"),
        "close": MessageLookupByLibrary.simpleMessage("Schließen"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName": MessageLookupByLibrary.simpleMessage(
            "Name des Cloud-Backup-Verzeichnisses"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "Cloud-Backup erfordert automatische Sicherung"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("Cloud-Dienste"),
        "collection": MessageLookupByLibrary.simpleMessage("Inkasso"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "Konfiguration in Datei exportiert!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Konfiguration importiert"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Konfiguration erfolgreich importiert"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Konfiguration gespeichert!"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Löschung bestätigen"),
        "contactFile": MessageLookupByLibrary.simpleMessage("Kontaktdatei"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Seite \"Kontaktabonnement\""),
        "contactUs":
            MessageLookupByLibrary.simpleMessage("Kontaktieren Sie uns"),
        "contacts": MessageLookupByLibrary.simpleMessage("Kontakte"),
        "contactsExportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Kontakte erfolgreich exportiert"),
        "contactsImportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Kontakte erfolgreich importiert"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("Kontaktseite"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("Kontakte mit Nummer"),
        "contactsubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Listenansicht der Kontaktabonnements"),
        "countColor": MessageLookupByLibrary.simpleMessage("Anzahlfarbe"),
        "countFontSize":
            MessageLookupByLibrary.simpleMessage("Schriftgröße der Anzahl"),
        "countPosition": MessageLookupByLibrary.simpleMessage("Anzahlposition"),
        "country": MessageLookupByLibrary.simpleMessage("Land:"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Farbe des Ländernamens"),
        "countryNameFontSize": MessageLookupByLibrary.simpleMessage(
            "Schriftgröße des Ländernamens"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Position des Ländernamens"),
        "cropAvatar":
            MessageLookupByLibrary.simpleMessage("Avatar zuschneiden"),
        "customerService": MessageLookupByLibrary.simpleMessage("Kundendienst"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("Anrufer-ID anpassen"),
        "dark": MessageLookupByLibrary.simpleMessage("Dunkel"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dunkelmodus"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "deleteContact":
            MessageLookupByLibrary.simpleMessage("Kontakt löschen"),
        "deleted": MessageLookupByLibrary.simpleMessage("Gelöscht"),
        "delivery": MessageLookupByLibrary.simpleMessage("Lieferung"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Sie haben die Berechtigung verweigert. Sie können die Berechtigung manuell in den Einstellungen aktivieren."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Benachrichtigung über blockierte Anrufe deaktivieren"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("Berechtigung deaktivieren"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Lokale SMS-Benachrichtigung deaktivieren"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Dieser App die Anzeige der Anrufer-ID verbieten"),
        "disabled": MessageLookupByLibrary.simpleMessage("Deaktiviert"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("E-Commerce"),
        "edit": MessageLookupByLibrary.simpleMessage("Bearbeiten"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("Avatar bearbeiten"),
        "editCode": MessageLookupByLibrary.simpleMessage("Code bearbeiten"),
        "editContact":
            MessageLookupByLibrary.simpleMessage("Kontakt bearbeiten"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Plugin-Code bearbeiten"),
        "education": MessageLookupByLibrary.simpleMessage("Bildung"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Elementpositionen"),
        "email": MessageLookupByLibrary.simpleMessage("E-Mail"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Benachrichtigung über blockierte Anrufe aktivieren"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Dunkelmodus basierend auf der Uhrzeit aktivieren"),
        "enableOverlayPermission": MessageLookupByLibrary.simpleMessage(
            "Overlay-Berechtigung aktivieren"),
        "enableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Lokale SMS-Benachrichtigung aktivieren"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds": MessageLookupByLibrary.simpleMessage(
            "Aktivieren, um Werbung zu entfernen"),
        "enabled": MessageLookupByLibrary.simpleMessage("Aktiviert"),
        "endColor": MessageLookupByLibrary.simpleMessage("Endfarbe"),
        "endcall": MessageLookupByLibrary.simpleMessage("Auflegen"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Bild-URL eingeben"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("Plugin-Code hier eingeben"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("URL eingeben"),
        "entry": MessageLookupByLibrary.simpleMessage("Eintrag"),
        "entryAddedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Eintrag erfolgreich hinzugefügt"),
        "error": MessageLookupByLibrary.simpleMessage("Fehler"),
        "errorExportingContacts": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Exportieren von Kontakten:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Abrufen des Berechtigungsstatus"),
        "errorImporting":
            MessageLookupByLibrary.simpleMessage("Fehler beim Importieren"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Fehler bei der Anforderung der Anrufüberprüfungsrolle:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Exportieren"),
        "exportAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Erlaubten Eintrag exportieren\""),
        "exportAsCsv":
            MessageLookupByLibrary.simpleMessage("Als CSV exportieren"),
        "exportAsJson":
            MessageLookupByLibrary.simpleMessage("Als JSON exportieren"),
        "exportAsVcf":
            MessageLookupByLibrary.simpleMessage("Als VCF exportieren"),
        "exportAsYaml":
            MessageLookupByLibrary.simpleMessage("Als YAML exportieren"),
        "exportBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Blacklist exportieren\""),
        "exportBlockedPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Blockiert exportieren\""),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Kontaktabonnement exportieren\""),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("Kontakte exportieren"),
        "exportFailed":
            MessageLookupByLibrary.simpleMessage("Export fehlgeschlagen"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("Exportformat:"),
        "exportLabelPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Etikett exportieren\""),
        "exportPluginPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Plugin exportieren\""),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("Seite \"Regex exportieren\""),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Blacklists exportieren\""),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Abonnement exportieren\""),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Text-Blacklists exportieren\""),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Text-Whitelists exportieren\""),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Whitelists exportieren\""),
        "exportSubscriptionsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Abonnements exportieren\""),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("Export erfolgreich"),
        "exportWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Whitelists exportieren\""),
        "failed": MessageLookupByLibrary.simpleMessage("Fehlgeschlagen"),
        "failedToAdd":
            MessageLookupByLibrary.simpleMessage("Fehler beim Hinzufügen:"),
        "failedToAddEntry": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Hinzufügen des Eintrags:"),
        "feature": MessageLookupByLibrary.simpleMessage("Funktion"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("Funktionsbeschreibung"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages": MessageLookupByLibrary.simpleMessage(
            "Eingehende SMS-Nachrichten filtern"),
        "filterRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Wiederholte eingehende Anrufe filtern"),
        "financial": MessageLookupByLibrary.simpleMessage("Finanziell"),
        "firstName": MessageLookupByLibrary.simpleMessage("Vorname"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("Wahrscheinlich Betrug/Scam"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Loslegen"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "Anmeldung bei Google Drive fehlgeschlagen"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Anmeldung bei Google Drive erfolgreich"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Google Drive-Einstellung"),
        "grantPermission":
            MessageLookupByLibrary.simpleMessage("Berechtigung erteilen"),
        "group": MessageLookupByLibrary.simpleMessage("Gruppe"),
        "height": MessageLookupByLibrary.simpleMessage("Höhe"),
        "history": MessageLookupByLibrary.simpleMessage("Verlauf"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("Symbolgröße"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Importieren"),
        "importAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Erlaubten Eintrag importieren\""),
        "importBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Blacklists importieren\""),
        "importBlockedentriesPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Blockierte Einträge importieren\""),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Importkonfiguration"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("Kontakte importieren"),
        "importFromCsv":
            MessageLookupByLibrary.simpleMessage("Aus CSV importieren"),
        "importFromFile":
            MessageLookupByLibrary.simpleMessage("Aus Datei importieren"),
        "importFromJson":
            MessageLookupByLibrary.simpleMessage("Aus JSON importieren"),
        "importFromUrl":
            MessageLookupByLibrary.simpleMessage("Von URL importieren"),
        "importFromVcf":
            MessageLookupByLibrary.simpleMessage("Aus VCF importieren"),
        "importFromYaml":
            MessageLookupByLibrary.simpleMessage("Aus YAML importieren"),
        "importLabelPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Etikett importieren\""),
        "importPluginPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Plugin importieren\""),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("Seite \"Regex importieren\""),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Abonnement importieren\""),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Text-Blacklists importieren\""),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Text-Whitelists importieren\""),
        "importSubscriptionsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Abonnements importieren\""),
        "importWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"Whitelists importieren\""),
        "importedSuccessfullyFromUrl": MessageLookupByLibrary.simpleMessage(
            "Erfolgreich von URL importiert"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("In-App-Käufe aktiviert"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Aktion beim Abfangen eingehender Anrufe"),
        "initializing":
            MessageLookupByLibrary.simpleMessage("Initialisierung..."),
        "initializingDatabase": MessageLookupByLibrary.simpleMessage(
            "Datenbank wird initialisiert..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "OneDrive-Anmeldedaten eingeben"),
        "insurance": MessageLookupByLibrary.simpleMessage("Versicherung"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Wiederholte eingehende Anrufe innerhalb des Zeitraums abfangen"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Ungültiges JSON-Format"),
        "isNotSubscribed":
            MessageLookupByLibrary.simpleMessage("ist nicht abonniert"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("ist abonniert"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Treten Sie dem Telegram-Kanal und der Gruppe bei, um weitere Informationen zu erhalten"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "Nur das neueste Backup behalten"),
        "keyword": MessageLookupByLibrary.simpleMessage("Schlüsselwort"),
        "label": MessageLookupByLibrary.simpleMessage("Etikett"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("Farbe des Etikettensymbols"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Etikettenseite"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("Ansicht der Etikettenseite"),
        "labelsColor":
            MessageLookupByLibrary.simpleMessage("Beschriftungsfarbe"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage(
            "Schriftgröße der Beschriftungen"),
        "labelsPosition":
            MessageLookupByLibrary.simpleMessage("Beschriftungsposition"),
        "lastName": MessageLookupByLibrary.simpleMessage("Nachname"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Hell"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loading": MessageLookupByLibrary.simpleMessage("Laden..."),
        "loan": MessageLookupByLibrary.simpleMessage("Kredit"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Lokales Backup-Verzeichnis nur unter dem Download-Ordner"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Lokale Karte 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("Inhalt der lokalen Karte 1"),
        "locationColor": MessageLookupByLibrary.simpleMessage("Standortfarbe"),
        "locationFontSize":
            MessageLookupByLibrary.simpleMessage("Schriftgröße des Standorts"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("Farbe des Standortsymbols"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Standortposition"),
        "login": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Anmeldung fehlgeschlagen"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Bei Google Drive anmelden"),
        "loginlogoutGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Anmelden/Abmelden bei Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Von Google Drive abmelden"),
        "manageRules": MessageLookupByLibrary.simpleMessage("Regeln verwalten"),
        "manualBackup":
            MessageLookupByLibrary.simpleMessage("Manuelle Sicherung"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Markiert von"),
        "matchAnyCharacter": MessageLookupByLibrary.simpleMessage(
            "Beliebiges Zeichen abgleichen:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Telefonnummern abgleichen, die bestimmte Ziffern enthalten:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Telefonnummern mit bestimmten Zeichen in der Mitte abgleichen:"),
        "medical": MessageLookupByLibrary.simpleMessage("Medizinisch"),
        "merge": MessageLookupByLibrary.simpleMessage("Zusammenführen"),
        "mergeContacts":
            MessageLookupByLibrary.simpleMessage("Kontakte zusammenführen"),
        "mergeSelected":
            MessageLookupByLibrary.simpleMessage("Ausgewählte zusammenführen"),
        "message": MessageLookupByLibrary.simpleMessage("Nachricht"),
        "mins": MessageLookupByLibrary.simpleMessage("Min."),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Name darf nicht leer sein"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Namensfarbe"),
        "nameFontSize":
            MessageLookupByLibrary.simpleMessage("Schriftgröße des Namens"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Namensposition"),
        "next": MessageLookupByLibrary.simpleMessage("Weiter"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("Kein Bild ausgewählt"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Kein Filter für eingehende SMS-Nachrichten"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified":
            MessageLookupByLibrary.simpleMessage("Nicht verifiziert"),
        "notifications":
            MessageLookupByLibrary.simpleMessage("Benachrichtigungen"),
        "numberColor": MessageLookupByLibrary.simpleMessage("Nummernfarbe"),
        "numberFontSize":
            MessageLookupByLibrary.simpleMessage("Schriftgröße der Nummer"),
        "numberPosition":
            MessageLookupByLibrary.simpleMessage("Nummernposition"),
        "numberType": MessageLookupByLibrary.simpleMessage("Nummerntyp"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("Farbe des Nummerntyps"),
        "numberTypeFontSize": MessageLookupByLibrary.simpleMessage(
            "Schriftgröße des Nummerntyps"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Position des Nummerntyps"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("OneDrive-Einstellung"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription": MessageLookupByLibrary.simpleMessage(
            "Online-Anrufer-ID-Abonnement"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Nur Benachrichtigung der ursprünglichen Anruf-App"),
        "onlyRingLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Nur lokale Benachrichtigung klingeln lassen"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Nur ursprüngliche SMS-Benachrichtigung verwenden"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Lokalen Ordner öffnen"),
        "other": MessageLookupByLibrary.simpleMessage("Andere"),
        "overlay": MessageLookupByLibrary.simpleMessage("Overlay"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "Die Overlay-Berechtigung wurde nicht erteilt, was die Anzeigefunktion der Anrufer-ID beeinträchtigen kann. Sie können die Berechtigung in den App-Einstellungen aktivieren."),
        "page": MessageLookupByLibrary.simpleMessage("Seite"),
        "password": MessageLookupByLibrary.simpleMessage("Passwort"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("JSON einfügen"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("JSON-Konfiguration einfügen"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("JSON hier einfügen"),
        "pattern": MessageLookupByLibrary.simpleMessage("Muster"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Berechtigung verweigert"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Berechtigung erteilt"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":Sie müssen die Berechtigung manuell in den App-Einstellungen deaktivieren."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "Berechtigung in den App-Einstellungen manuell deaktivieren."),
        "permissionWasNotGranted": MessageLookupByLibrary.simpleMessage(
            "Berechtigung wurde nicht erteilt."),
        "permissions": MessageLookupByLibrary.simpleMessage("Berechtigungen"),
        "permissionsRequired": MessageLookupByLibrary.simpleMessage(
            "Erforderliche Berechtigungen"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefon"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Festnetz"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("Festnetz,Mobil"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("Mobil"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("Pager"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Persönliche Nummer"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("Premium-Tarif"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("Geteilte Kosten"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Gebührenfrei"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Unbekannt"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Voicemail"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("Telefonnummer"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("Bitte eingeben"),
        "pleaseEnterAPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie eine Telefonnummer ein"),
        "pleaseEnterAnPattern": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie ein Muster ein"),
        "pleaseEnterAnUrl": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie eine URL ein"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Bitte wählen Sie eine Datei aus oder geben Sie eine URL ein"),
        "pleaseSelectALabel": MessageLookupByLibrary.simpleMessage(
            "Bitte wählen Sie ein Etikett aus"),
        "pleaseSelectAnExportFolder": MessageLookupByLibrary.simpleMessage(
            "Bitte wählen Sie einen Exportordner aus"),
        "pleaseSelectAnOutputFile": MessageLookupByLibrary.simpleMessage(
            "Bitte wählen Sie eine Ausgabedatei aus:"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Bitte wählen Sie Einträge zum Exportieren aus"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Bitte tippen Sie auf \"Berechtigung erteilen\" und erlauben Sie die Berechtigung im nächsten Bildschirm."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Bitte tippen Sie auf \"Standard einrichten\" und erlauben Sie die Berechtigung im nächsten Bildschirm."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Bitte warten Sie, bis die Datenbankinitialisierung abgeschlossen ist."),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Plugin-Seite"),
        "plugins": MessageLookupByLibrary.simpleMessage("Plugins"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("Ansicht der Plugin-Seite"),
        "political": MessageLookupByLibrary.simpleMessage("Politisch"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchaseFailed":
            MessageLookupByLibrary.simpleMessage("Purchase failed:"),
        "purchaseIsBeingProcessed": MessageLookupByLibrary.simpleMessage(
            "Purchase is being processed..."),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("Purchase successful!"),
        "quarterlySubscription":
            MessageLookupByLibrary.simpleMessage("Quarterly Subscription"),
        "regex": MessageLookupByLibrary.simpleMessage("Regex"),
        "regexPage": MessageLookupByLibrary.simpleMessage("Regex-Seite"),
        "regexPatternExplanation": MessageLookupByLibrary.simpleMessage(
            "Erläuterung des Regex-Musters"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Regex-Muster sind reguläre Ausdrücke, die zum Abgleichen von Telefonnummern verwendet werden."),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("Ansicht der Regex-Seite"),
        "region": MessageLookupByLibrary.simpleMessage("Region:"),
        "reject": MessageLookupByLibrary.simpleMessage("Ablehnen"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Alle Nummern ablehnen"),
        "remove": MessageLookupByLibrary.simpleMessage("Entfernen"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Werbung entfernen und Online-Backup aktivieren"),
        "removeAllowed":
            MessageLookupByLibrary.simpleMessage("\"Erlaubt\" entfernen"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("\"Blockiert\" entfernen"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn": MessageLookupByLibrary.simpleMessage(
            "Wiederholte blockierte Anrufe in"),
        "repeatedCalls":
            MessageLookupByLibrary.simpleMessage("Wiederholte Anrufe"),
        "restoreFromGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Von Google Drive wiederherstellen"),
        "restoreFromLocal":
            MessageLookupByLibrary.simpleMessage("Von lokal wiederherstellen"),
        "restoreFromOnedrive": MessageLookupByLibrary.simpleMessage(
            "Von OneDrive wiederherstellen"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Von WebDAV wiederherstellen"),
        "ridesharing":
            MessageLookupByLibrary.simpleMessage("Mitfahrgelegenheit"),
        "risk": MessageLookupByLibrary.simpleMessage("Risiko"),
        "robocall": MessageLookupByLibrary.simpleMessage("Robocall"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("Kontakte suchen"),
        "searchEntries":
            MessageLookupByLibrary.simpleMessage("Einträge suchen"),
        "selectALabel":
            MessageLookupByLibrary.simpleMessage("Wähle ein Etikett aus:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Alle auswählen"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Farbe auswählen"),
        "selectCountryCodeOptional": MessageLookupByLibrary.simpleMessage(
            "Ländercode auswählen (optional)"),
        "selectEntries":
            MessageLookupByLibrary.simpleMessage("Einträge auswählen"),
        "selectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Einträge zum Exportieren auswählen"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Ausgewählte Kontakte erfolgreich zusammengeführt"),
        "selectedLabel":
            MessageLookupByLibrary.simpleMessage("Ausgewähltes Etikett"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("Exportordner auswählen"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Service-Aktualisierungsintervalle (Tage)"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("Einstellungen gespeichert"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("Standard einrichten"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Standard-Anrufer-ID-App einrichten"),
        "sharing": MessageLookupByLibrary.simpleMessage("Teilen"),
        "showContactButton": MessageLookupByLibrary.simpleMessage(
            "Schaltfläche \"Kontakt anzeigen\""),
        "showContactIconButton": MessageLookupByLibrary.simpleMessage(
            "Schaltfläche \"Kontaktsymbol anzeigen\""),
        "showTelegram":
            MessageLookupByLibrary.simpleMessage("Telegram anzeigen"),
        "showWhatsapp":
            MessageLookupByLibrary.simpleMessage("WhatsApp anzeigen"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("Ergebnisse anzeigen für"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer": MessageLookupByLibrary.simpleMessage(
            "Stumm schalten, nicht antworten"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("SIM-Kartenfarbe"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("Schriftgröße der SIM-Karte"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("SIM-Kartenposition"),
        "skip": MessageLookupByLibrary.simpleMessage("Überspringen"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Seite \"SMS-Blacklist\""),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("SMS-Filterung"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "Die SMS-Filterung erfordert SMS-, Benachrichtigungs- und Telefonberechtigungen. Bitte erteilen Sie diese Berechtigungen, um diese Funktion zu aktivieren."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Lokale SMS-Benachrichtigung"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("SMS-Benachrichtigung"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Seite \"SMS-Abonnement\""),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Seite \"SMS-Text-Whitelist\""),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Ansicht der SMS-Blacklist-Seite"),
        "smssubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Listenansicht der SMS-Abonnements"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Ansicht der SMS-Text-Blacklist-Seite"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Ansicht der SMS-Text-Whitelist-Seite"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Ansicht der SMS-Whitelist-Seite"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely":
            MessageLookupByLibrary.simpleMessage("Wahrscheinlich Spam"),
        "startColor": MessageLookupByLibrary.simpleMessage("Startfarbe"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Statistikzeitraum (Minuten):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("STIR-Farbe"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("Schriftgröße von STIR"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("STIR-Position"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Speicher"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Abonnieren"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Abonniert"),
        "subscribedLink":
            MessageLookupByLibrary.simpleMessage("Abonnierter Link"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("Seite \"Abonnementliste\""),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Listenansicht der Abonnements"),
        "successfully": MessageLookupByLibrary.simpleMessage("erfolgreich"),
        "survey": MessageLookupByLibrary.simpleMessage("Umfrage"),
        "sync": MessageLookupByLibrary.simpleMessage("Synchronisieren"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "takeaway": MessageLookupByLibrary.simpleMessage("Mitnahme"),
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
            MessageLookupByLibrary.simpleMessage("Text- & Beschriftungsfarben"),
        "textType": MessageLookupByLibrary.simpleMessage("Texttyp"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Diese App ist ein leistungsstarkes Anrufer-ID-Tool, mit dem Sie unbekannte Anrufer identifizieren und unerwünschte Anrufe blockieren können. Es bietet folgende Funktionen:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Diese App benötigt Zugriff auf Ihre Anrufprotokollinformationen, um ordnungsgemäß zu funktionieren. Bitte erteilen Sie die Berechtigung."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "Diese Berechtigung ist erforderlich, damit unsere App die Standard-Anrufer-ID-App ist."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "Diese Berechtigung ist erforderlich, damit unsere App wichtige Informationen über anderen Apps anzeigen kann.\\n\\n"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Tutorial"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unbekannt"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("Nicht abonniert"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("URL-Format ist falsch"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("Netzwerkbild verwenden"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Verwenden Sie das Zeichen \'.\' zum Abgleichen eines beliebigen einzelnen Zeichens. Zum Beispiel stimmt das Muster \'123.456\' mit \'123-456\', \'123.456\', \'123a456\' usw. überein."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Verwenden Sie das Muster \'^0[0-9]{2,3}\' zum Abgleichen von Telefonnummern, die mit \'0\' gefolgt von 2 oder 3 Ziffern beginnen, was typischerweise eine Vorwahl darstellt.\nVerwenden Sie das Muster \'^010\', um Anrufe von der Pekinger Vorwahl (010) zu blockieren.\nVerwenden Sie das Muster \'^202\', um Anrufe von der Washingtoner Vorwahl (202) zu blockieren.\nErsetzen Sie die Vorwahl \'^0[0-9]{2,3}\' durch diejenige, die Sie blockieren möchten."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Verwenden Sie das Muster \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' zum Abgleichen von Telefonnummern im Format \'XXX-XXXX-XXXX\'. Ersetzen Sie \'X\' durch die spezifischen Ziffern, die Sie abgleichen möchten."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Verwenden Sie das Muster \'^\\+\' zum Abgleichen aller Telefonnummern, die mit einem Pluszeichen beginnen, was typischerweise auf eine internationale Nummer hinweist."),
        "userName": MessageLookupByLibrary.simpleMessage("Benutzername"),
        "verified": MessageLookupByLibrary.simpleMessage("Verifiziert"),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("WebDAV-Einstellung"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("WebDAV-URL"),
        "website": MessageLookupByLibrary.simpleMessage("Website"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Whitelist"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("Whitelist-Seite"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("Ansicht der Whitelist-Seite"),
        "width": MessageLookupByLibrary.simpleMessage("Breite"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "Wildcard-Unterstützung für flexible Filterung"),
        "windowSize": MessageLookupByLibrary.simpleMessage("Fenstergröße"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "Sie können die Standard-Syntax für reguläre Ausdrücke verwenden, um Muster zu definieren, oder die KI bitten, das Muster für Flutter zu generieren."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Sie haben die Berechtigung verweigert. Sie können die Berechtigung manuell in den Einstellungen aktivieren."),
        "youHaveEnabledThePermission": MessageLookupByLibrary.simpleMessage(
            "Sie haben die Berechtigung aktiviert."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("Sie müssen die"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
