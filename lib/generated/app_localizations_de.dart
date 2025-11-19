// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get aboutContactSubscription => 'Über Kontakt-Abonnement';

  @override
  String get aboutLabels => 'Über Labels';

  @override
  String get aboutPhoneSubscriptionRules => 'Über Telefon-Abonnementregeln';

  @override
  String get aboutPhoneSubscriptions => 'Über Telefon-Abonnements';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Abonnieren Sie Listen mit Telefonregeln per URL und aktualisieren Sie Regeln automatisch. Unterstützt Regeldateien im JSON- und CSV-Format.';

  @override
  String get aboutSmsFilter => 'Über SMS-Filterung';

  @override
  String get aboutSmsSubscriptionRules => 'Über SMS-Abonnementregeln';

  @override
  String get aboutSubtitle => 'Anwendungsversion und rechtliche Informationen';

  @override
  String get aboutTitle => 'Über';

  @override
  String get action => 'Aktion';

  @override
  String get actionAll => 'Alle';

  @override
  String get actionAllow => 'Erlauben';

  @override
  String get actionBlock => 'Blockieren';

  @override
  String get actionFilterAll => 'Alle Filter';

  @override
  String get actionFilterTitle => 'Filtern nach Aktionstyp';

  @override
  String get actionFilterTooltip => 'Aktionsfilter';

  @override
  String get actionNone => 'Keine Aktion';

  @override
  String get actionSilence => 'Stummschalten';

  @override
  String actionTag(Object actionType) {
    return 'Aktion: $actionType';
  }

  @override
  String get actionType => 'Aktionstyp';

  @override
  String get actionUnknown => 'Unbekannt';

  @override
  String get add => 'Hinzufügen';

  @override
  String get addAllowedBlockedRule =>
      'Regel zum Erlauben/Blockieren hinzufügen';

  @override
  String get addAllowSubscription => 'Erlaube-Abonnement hinzufügen';

  @override
  String get addBlockSubscription => 'Blockiere-Abonnement hinzufügen';

  @override
  String get addContactButton => 'Kontakt hinzufügen';

  @override
  String addContactFailed(Object error) {
    return 'Hinzufügen des Kontakts fehlgeschlagen: $error';
  }

  @override
  String get addedToAllowedRules => 'Zu den erlaubten Regeln hinzugefügt';

  @override
  String get addedToBlacklist => 'Zur Blacklist hinzugefügt';

  @override
  String get addedToBlockedRules => 'Zu den blockierten Regeln hinzugefügt';

  @override
  String get addedToFavoriteContacts => 'Zu den Lieblingskontakten hinzugefügt';

  @override
  String get addedToFavorites => 'Zu den Lieblingskontakten hinzugefügt';

  @override
  String get addedToWhitelist => 'Zur Whitelist hinzugefügt';

  @override
  String get addFavorite => 'Favorit hinzufügen';

  @override
  String get addFilter => 'Filter hinzufügen';

  @override
  String get addLabel => 'Label hinzufügen';

  @override
  String get addLabelButton => 'Label hinzufügen';

  @override
  String addLabelFailed(Object error) {
    return 'Hinzufügen des Labels fehlgeschlagen: $error';
  }

  @override
  String get addLabelToCall => 'Label zum Anrufdatensatz hinzufügen';

  @override
  String get addName => 'Namen hinzufügen';

  @override
  String get addNoneSubscription => 'Kein Abonnement hinzufügen';

  @override
  String get addOrEditContactInfo =>
      'Wird verwendet, um Kontaktinformationen hinzuzufügen oder zu bearbeiten';

  @override
  String get addPhoneMark => 'Telefonmarkierung hinzufügen';

  @override
  String get addPhoneNumberRule => 'Telefonnummernregel hinzufügen';

  @override
  String get addPlugin => 'Plugin hinzufügen';

  @override
  String get addPluginFailed => 'Hinzufügen des Plugins fehlgeschlagen';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Hinzufügen des Plugins fehlgeschlagen: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Plugin von lokaler Datei hinzufügen';

  @override
  String get addPluginFromUrl => 'Plugin von URL hinzufügen';

  @override
  String get addRegexRule => 'Regex-Regel hinzufügen';

  @override
  String get addRule => 'Regel hinzufügen';

  @override
  String get addRuleButton => 'Regel hinzufügen';

  @override
  String addRuleFailed(Object error) {
    return 'Regel konnte nicht hinzugefügt werden: $error';
  }

  @override
  String get addRuleTooltip => 'Regel hinzufügen';

  @override
  String get addSilenceSubscription => 'Stummschaltungs-Abonnement hinzufügen';

  @override
  String get addSimRuleButton => 'SIM-Regel hinzufügen';

  @override
  String get addSmsFilterRule => 'SMS-Filterregel hinzufügen';

  @override
  String get addSmsRule => 'SMS-Regel hinzufügen';

  @override
  String get addSmsSubscription => 'SMS-Abonnement hinzufügen';

  @override
  String get addSubscription => 'Abonnement hinzufügen';

  @override
  String get addSubscriptionButton => 'Abonnement hinzufügen';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Abonnement konnte nicht hinzugefügt werden: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Abonnement hinzufügen';

  @override
  String get addToAllowedRules => 'Zu erlaubten Regeln hinzufügen';

  @override
  String get addToBlacklist => 'Zur Sperrliste hinzufügen';

  @override
  String get addToBlockedRules => 'Zu blockierten Regeln hinzufügen';

  @override
  String get addToFavoriteContacts => 'Zu Lieblingskontakten hinzufügen';

  @override
  String get addToFavorites => 'Zu Favoriten hinzufügen';

  @override
  String get addToRules => 'Zu Regeln hinzufügen';

  @override
  String get addToWhitelist => 'Zur Whitelist hinzufügen';

  @override
  String get adPlaceholder => 'Platzhalter für Werbung';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Alle';

  @override
  String get allCallsTab => 'Alle';

  @override
  String get allDataClearedSuccessfully => 'Alle Daten erfolgreich gelöscht';

  @override
  String get allow => 'Erlauben';

  @override
  String get allowAllAllowRules => 'Alle Erlaubnisregeln zulassen';

  @override
  String get allowAllAllowRulesDesc => 'Anrufe von Erlaubnisregeln zulassen';

  @override
  String get allowAllBlacklistedNumbers => 'Alle gesperrten Nummern zulassen';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'Anrufe von der Sperrliste zulassen';

  @override
  String get allowAllBlockRules => 'Alle Blockregeln zulassen';

  @override
  String get allowAllBlockRulesDesc => 'Anrufe von Blockregeln zulassen';

  @override
  String get allowAllowedNumbers => 'Erlaubte Nummern zulassen';

  @override
  String get allowAllowedNumbersDesc => 'Anrufe von der Whitelist zulassen';

  @override
  String get allowBlock => 'Erlauben/Blockieren';

  @override
  String get allowBlockedNumbers => 'Blockierte Nummern zulassen';

  @override
  String get allowBlockedNumbersDesc => 'Anrufe von der Sperrliste zulassen';

  @override
  String get allowedBlockedRule => 'Erlauben/Blockieren-Regel';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Erlauben/Blockieren-Regel bearbeiten';

  @override
  String get allowedBlockedRuleManagement =>
      'Erlauben/Blockieren-Regelverwaltung';

  @override
  String get allowNonExceededNumbers => 'Nicht überschrittene Nummern zulassen';

  @override
  String get allowNonExceededNumbersDescription =>
      'Automatisch Nummern zulassen, die den Schwellenwert nicht überschreiten';

  @override
  String get allowRegexAllowRules => 'Regex-Erlaubnisregeln zulassen';

  @override
  String get allowRegexAllowRulesDesc =>
      'Regex-Mustererkennung für Erlaubnisregeln aktivieren';

  @override
  String get allowRegexAllowRulesDescription =>
      'Regex-basierte Erlaubnisregeln aktivieren';

  @override
  String get allowRegexBlockRules => 'Regex-Blockregeln zulassen';

  @override
  String get allowRegexBlockRulesDesc =>
      'Regex-Mustererkennung für Blockregeln aktivieren';

  @override
  String get allowRegexBlockRulesDescription =>
      'Regex-basierte Blockregeln aktivieren';

  @override
  String get allowRule => 'Erlaubnisregel';

  @override
  String get allowRules => 'Erlaubnisregeln';

  @override
  String get allowWhitelistedNumbers => 'Erlaube Nummern auf der Whitelist';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Erlaube alle Nummern auf der Whitelist';

  @override
  String get allPermissionsGranted => 'Alle Berechtigungen erteilt';

  @override
  String get allSettingsCompleted => 'Alle Einstellungen abgeschlossen.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Alle Aktualisierungen abgeschlossen ($count Regeln)';
  }

  @override
  String get answerThenHangup => 'Annehmen und dann auflegen';

  @override
  String get appLegalese =>
      '© 2023 Your Call Your Rule. Alle Rechte vorbehalten.';

  @override
  String get applicationSoftware => 'Anwendungssoftware';

  @override
  String get apply => 'Anwenden';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Autorisierung fehlgeschlagen: Bitte überprüfen Sie Client-ID und Schlüssel';

  @override
  String get authorizationFailedMessage => 'Autorisierung fehlgeschlagen';

  @override
  String get authorizationSuccessMessage => 'Autorisierung erfolgreich';

  @override
  String get authorizeLoginButton => 'Login autorisieren';

  @override
  String get automotiveIndustry => 'Automobilindustrie';

  @override
  String get autoSyncLabel => 'Auto-Synchronisierung';

  @override
  String get autoUpdate => 'Auto-Update';

  @override
  String get autoUpdateDescription =>
      'Auto-Update-Intervalle für Abonnements festlegen oder manuell aktualisieren';

  @override
  String get autoUpdateSettings => 'Auto-Update-Einstellungen';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Automatische Updates für Regeln und Plugins verwalten';

  @override
  String get autoUpdateSettingsTitle => 'Auto-Update-Einstellungen';

  @override
  String get autoUpdateSubtitle =>
      'Automatische Updates für Regeln und Plugins verwalten';

  @override
  String get autoUpdateTitle => 'Auto-Update';

  @override
  String get avatarBorderColor => 'Avatar Rahmenfarbe';

  @override
  String get avatarBorderSize => 'Avatar Rahmengröße';

  @override
  String get avatarIconSizesSetting => 'Avatar- & Icon-Größen';

  @override
  String get avatarPosition => 'Avatar Position';

  @override
  String get avatarSize => 'Avatar Größe';

  @override
  String axisPosition(Object axis) {
    return '$axis Position';
  }

  @override
  String get backgroundGradientSetting => 'Hintergrundfarbverlauf';

  @override
  String get backup => 'Sicherung';

  @override
  String get backupAndRestore => 'Sichern und Wiederherstellen';

  @override
  String get backupAndRestoreSubtitle =>
      'Anwendungsdaten sichern oder wiederherstellen';

  @override
  String get backupAndRestoreTitle => 'Sichern & Wiederherstellen';

  @override
  String get backupFailed => 'Sicherung fehlgeschlagen';

  @override
  String get backupFailedMessage => 'Sicherung fehlgeschlagen';

  @override
  String backupFailedWithError(Object error) {
    return 'Sicherung fehlgeschlagen: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'Anwendungsdaten sichern oder wiederherstellen';

  @override
  String get backupRestoreTitle => 'Sichern & Wiederherstellen';

  @override
  String get backupSectionTitle => 'Sicherung';

  @override
  String get backupSettings => 'Sicherungseinstellungen';

  @override
  String get backupSettingsDialogTitle => 'Sicherungseinstellungen';

  @override
  String get backupSettingsTitle => 'Sicherungseinstellungen';

  @override
  String get backupSuccessMessage => 'Erfolgreich in der Cloud gesichert';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Sicherung erfolgreich nach: $path';
  }

  @override
  String get backupToCloud => 'In Cloud sichern';

  @override
  String get backupToCloudDescription =>
      'Einstellungen und Regeln im Cloud-Speicher sichern';

  @override
  String backupToCloudFailed(Object error) {
    return 'Sicherung in der Cloud fehlgeschlagen: $error';
  }

  @override
  String get backupToCloudLabel => 'In Cloud sichern';

  @override
  String get backupToCloudSuccess => 'Erfolgreich in der Cloud gesichert';

  @override
  String get backupToCloudTitle => 'Backup in die Cloud';

  @override
  String get backupToLocalLabel => 'Backup lokal';

  @override
  String get bank => 'Bank';

  @override
  String get basicInfo => 'Grundlegende Informationen';

  @override
  String get basicRuleFilter => 'Grundlegender Regel-Filter';

  @override
  String get basicRuleFiltering => 'Grundlegende Regel-Filterung';

  @override
  String get basicRuleFilteringExplanation =>
      '• Grundlegende Regel-Filterung: Filterregeln basierend auf Blacklist, Whitelist und Regex';

  @override
  String get basicRuleFilterSettings =>
      'Einstellungen für den grundlegenden Regel-Filter';

  @override
  String get basicRuleFilterSubtitle =>
      'Anrufe mit Blacklist/Whitelist und regulären Ausdrücken filtern';

  @override
  String get batchDeleteContacts => 'Kontakte stapelweise löschen';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Sind Sie sicher, dass Sie $count ausgewählte Kontakte löschen möchten?';
  }

  @override
  String get batchDeleteFailed => 'Stapelweises Löschen fehlgeschlagen';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Sind Sie sicher, dass Sie $count Etiketten löschen möchten?';
  }

  @override
  String get blacklist => 'Blacklist';

  @override
  String get blacklistingAndWhitelisting => 'Blacklisting und Whitelisting';

  @override
  String get blacklistLabel => 'Blacklist';

  @override
  String get blackWhiteList => 'Schwarz-/Weiße Liste';

  @override
  String get block => 'Blockieren';

  @override
  String get blockCalls => 'Anrufe blockieren';

  @override
  String get blocked => 'Blockiert';

  @override
  String get blockedCallAction => 'Aktion für blockierte Anrufe';

  @override
  String get blockedCalls => 'Blockierte Anrufe';

  @override
  String get blockedCallsTitle => 'Blockierte Anrufe';

  @override
  String get blockedCommunications => 'Blockierte Kommunikation';

  @override
  String get blockedPhoneLabel => 'Blockierte Anrufe';

  @override
  String get blockedSpamCalls => 'Blockierte Spam-Anrufe';

  @override
  String get blockingTrend => 'Blockierungs-Trend';

  @override
  String get blockInternationalCalls =>
      'entspricht Nummern, die nicht mit + oder 00 beginnen';

  @override
  String get blockInternationalCallsTitle => 'Internationale Anrufe blockieren';

  @override
  String get blockLandlineNumbersTitle => 'Festnetznummern blockieren';

  @override
  String get blockMobileNumbers =>
      'entspricht Nummern, die nicht mit 13-19 beginnen';

  @override
  String get blockMobileNumbersTitle => 'Mobilfunknummern blockieren';

  @override
  String get blockPremiumRateNumbers =>
      'entspricht Nummern, die nicht mit 118 oder 120-190 beginnen';

  @override
  String get blockPremiumRateNumbersTitle => 'Premium-Tarifnummern blockieren';

  @override
  String get blockRule => 'Blockierregel';

  @override
  String get blockRules => 'Blockierregeln';

  @override
  String get blockSpecificAreaCodes =>
      'entspricht Nummern, die mit 0 + 2-3 Ziffern beginnen';

  @override
  String get blockSpecificAreaCodesTitle =>
      'Spezifische Vorwahlbereiche blockieren:';

  @override
  String get blockTypeAnalysisTitle => 'Blocktyp-Analyse';

  @override
  String get both => 'Beide';

  @override
  String get bulkDelete => 'Kontakte stapelweise löschen';

  @override
  String get bulkDeleteContacts => 'Kontakte stapelweise löschen';

  @override
  String get bulkDeleteLabels => 'Etiketten stapelweise löschen';

  @override
  String get call => 'Anruf';

  @override
  String get callback => 'Zurückrufen';

  @override
  String callbackTo(String number) {
    return 'Rückruf an $number';
  }

  @override
  String get callBlocking => 'Anrufblockierung';

  @override
  String get callerIdApp => 'Anrufer-ID-App';

  @override
  String get callerIdCustomizationTitle => 'Anrufer-ID anpassen';

  @override
  String get callerIdDialogTitle => 'Anrufer-ID-Informationen';

  @override
  String get callerIdDisplayMode => 'Anrufer-ID-Anzeigemodus';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Markiert von $count';
  }

  @override
  String get callerIdPreview => 'Anrufer-ID-Vorschau';

  @override
  String get callFilter => 'Anruffilter';

  @override
  String get callFilterDescription =>
      'Wenn aktiviert, werden eingehende Anrufe anhand der untenstehenden Regelliste überprüft. Anruffilterregeln werden standardmäßig nicht zwischen Geräten synchronisiert.';

  @override
  String get callFilterRules => 'Anruffilterregeln';

  @override
  String get callFilterRulesDescription =>
      'Grundregeln für die Anruffilterung festlegen';

  @override
  String get callFilterSettings => 'Anruffiltereinstellungen';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Anruffrequenzgrenzen und Blockierungsregeln festlegen';

  @override
  String get callFrequencyInterceptionTitle => 'Anruffrequenz-Abfang';

  @override
  String get callHistory => 'Anrufliste';

  @override
  String get callHistoryInfoDesc =>
      'Hier wird Ihre Anrufliste angezeigt, einschließlich eingehender, ausgehender und verpasster Anrufe.';

  @override
  String get callHistoryInfoTitle => 'Anrufliste';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Initialisierung der Anrufliste fehlgeschlagen: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Aktualisierung der Anrufliste fehlgeschlagen: $error';
  }

  @override
  String get callHistoryTab => 'Anrufliste';

  @override
  String get callHistoryTimelineEarlier => 'Früher';

  @override
  String get callHistoryTimelineToday => 'Heute';

  @override
  String get callHistoryTimelineYesterday => 'Gestern';

  @override
  String get callScreeningPermission => 'Anruferkennungsberechtigung';

  @override
  String get callScreeningPermissionDescription =>
      'Wird verwendet, um Spam-Anrufe zu erkennen und zu blockieren.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Anruferkennungsberechtigung nicht erteilt, was die App-Funktionalität beeinträchtigen kann.';

  @override
  String get callSettingsSubtitle =>
      'Anrufer-ID-, Filter- und Blockierungseinstellungen';

  @override
  String get callSettingsTitle => 'Anrufeinstellungen';

  @override
  String get callStatistics => 'Anrufstatistik';

  @override
  String get callTypeAnswered => 'Angenommen';

  @override
  String get callTypeBlocked => 'Blockiert';

  @override
  String get callTypeIconColor => 'Anruftyp-Symbolfarbe';

  @override
  String get callTypeMissed => 'Verpasster Anruf';

  @override
  String get callTypeOutgoing => 'Ausgehend';

  @override
  String get callTypePosition => 'Anruftyp-Position';

  @override
  String get callTypeUnknown => 'Unbekannt';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get carRental => 'Autovermietung';

  @override
  String get carrier => 'Anbieter';

  @override
  String get carrierColor => 'Anbieterfarbe';

  @override
  String get carrierFontSize => 'Anbieter-Schriftgröße';

  @override
  String get carrierPosition => 'Anbieterposition';

  @override
  String get changeLabel => 'Label ändern';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Änderung des Plugin-Status fehlgeschlagen: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Änderung des Abonnementstatus fehlgeschlagen: $error';
  }

  @override
  String get changeTag => 'Tag ändern';

  @override
  String get charity => 'Wohltätigkeit';

  @override
  String chartMonthFormat(int month) {
    return 'Monat $month';
  }

  @override
  String get chartOneDayAgo => 'Vor 1 Tag';

  @override
  String get chartOneMonthAgo => 'Vor 1 Monat';

  @override
  String get chartOneWeekAgo => 'Vor 1 Woche';

  @override
  String get chartTenDaysAgo => 'Vor 10 Tagen';

  @override
  String get chartThreeDaysAgo => 'Vor 3 Tagen';

  @override
  String get chartToday => 'Heute';

  @override
  String get checkFileFormat =>
      'Bitte überprüfen Sie das Dateiformat oder die Berechtigungen';

  @override
  String checkPermissionFailed(Object error) {
    return 'Fehler beim Überprüfen der Berechtigungen: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Wählen Sie die Standard-Abfangaktion';

  @override
  String get clearAllData => 'Alle Daten löschen';

  @override
  String get clearAllDataConfirmation =>
      'Sind Sie sicher, dass Sie alle Anwendungsdaten löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get clearAllDataDescription => 'Alle Anwendungsdaten löschen';

  @override
  String get clearAllDataLabel => 'Alle Daten löschen';

  @override
  String get clearFilter => 'Filter löschen';

  @override
  String get clearLabelFilter => 'Label-Filter löschen';

  @override
  String get clearLabelFilterButton => 'Label-Filter löschen';

  @override
  String get closeButton => 'Schließen';

  @override
  String get cloudSync => 'Cloud-Synchronisierung';

  @override
  String get cloudSyncAndBackupTitle => 'Cloud-Synchronisierung & Backup';

  @override
  String get cloudSyncSettingsSubtitle =>
      'WebDAV, OneDrive und Google Drive konfigurieren';

  @override
  String get cloudSyncSettingsTitle => 'Cloud-Synchronisierungseinstellungen';

  @override
  String get cloudSyncTitle => 'Cloud-Synchronisierung';

  @override
  String get collapseLabelSelector => 'Label-Auswahl einklappen';

  @override
  String get collection => 'Inkasso';

  @override
  String get colorPickerTitle => 'Farbe auswählen';

  @override
  String get configManagement => 'Konfigurationsverwaltung';

  @override
  String get configUpdated => 'Konfiguration aktualisiert';

  @override
  String get configurationAdvice =>
      'Durch die richtige Konfiguration können Sie verschiedene Filterstrategien für berufliche und private SIM-Karten festlegen.';

  @override
  String get configureBackupOptions => 'Backup-Optionen konfigurieren';

  @override
  String get configureBackupOptionsSubtitle => 'Backup-Optionen konfigurieren';

  @override
  String get configureCloudSyncService =>
      'Cloud-Synchronisierungsdienst konfigurieren';

  @override
  String get configureCloudSyncServiceHint =>
      'Bitte konfigurieren Sie einen Cloud-Synchronisierungsdienst, um die Synchronisierung über mehrere Geräte zu ermöglichen.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Bitte konfigurieren Sie einen Cloud-Synchronisierungsdienst, um die Synchronisierung über mehrere Geräte zu ermöglichen.';

  @override
  String get configureSimCardFilterRules =>
      'SIM-Karten-Filterregeln konfigurieren';

  @override
  String get configureSyncServiceHint =>
      'Bitte konfigurieren Sie zuerst den Synchronisierungsdienst in den Cloud-Synchronisierungseinstellungen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get confirmBatchDeleteContacts =>
      'Sind Sie sicher, dass Sie die ausgewählten löschen möchten';

  @override
  String get confirmButton => 'Bestätigen';

  @override
  String get confirmDelete => 'Löschen bestätigen';

  @override
  String get confirmDeleteContact =>
      'Sind Sie sicher, dass Sie löschen möchten';

  @override
  String get confirmDeleteContactName => 'Löschen bestätigen?';

  @override
  String get confirmDeleteFilter =>
      'Sind Sie sicher, dass Sie diesen Filter löschen möchten?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Sind Sie sicher, dass Sie das Label \"$name\" löschen möchten?';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Sind Sie sicher, dass Sie das Plugin \"$name\" löschen möchten?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Sind Sie sicher, dass Sie $count Plugins löschen möchten?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Sind Sie sicher, dass Sie diese Regel löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Sind Sie sicher, dass Sie die ausgewählten Kontakte löschen möchten?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Sind Sie sicher, dass Sie diese SMS-Filterregel löschen möchten?';

  @override
  String get confirmDeleteSmsRule =>
      'Sind Sie sicher, dass Sie diese SMS-Regel löschen möchten?';

  @override
  String get confirmDeleteSubscription =>
      'Sind Sie sicher, dass Sie dieses Abonnement löschen möchten?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Sind Sie sicher, dass Sie $name löschen möchten?';
  }

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get connectedStatus => 'Verbunden';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Verbindung fehlgeschlagen: Bitte überprüfen Sie Serveradresse, Benutzername und Passwort';

  @override
  String get connectionFailedMessage => 'Verbindung fehlgeschlagen';

  @override
  String get connectionStatusLabel => 'Verbindungsstatus';

  @override
  String get connectionSuccessMessage => 'Verbindung erfolgreich';

  @override
  String get contactAddSuccess => 'Kontakt erfolgreich hinzugefügt';

  @override
  String get contactDeleted => 'Kontakt gelöscht';

  @override
  String get contactEditDialog => 'Kontaktbearbeitungsdialog';

  @override
  String get contactNameHint => 'Kontaktname eingeben (optional)';

  @override
  String get contactNameLabel => 'Name';

  @override
  String get contactNameOptional => 'Kontaktname (optional)';

  @override
  String get contactNotFound => 'Kontakt nicht gefunden';

  @override
  String get contacts => 'Kontakte';

  @override
  String contactsDeleted(Object count) {
    return '$count Kontakte gelöscht';
  }

  @override
  String get contactSettingsSubtitle =>
      'Kontaktverwaltung und Etiketteinstellungen';

  @override
  String get contactSettingsTitle => 'Kontakteinstellungen';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Fehler beim Laden der Kontakte: $error';
  }

  @override
  String get contactsManagement => 'Kontaktverwaltung';

  @override
  String get contactsManagementPageTitle => 'Kontaktverwaltungsseite';

  @override
  String get contactsPageTitle => 'Kontaktverwaltung';

  @override
  String get contactsPermission => 'Kontaktberechtigung';

  @override
  String get contactsPermissionDescription =>
      'Wird verwendet, um Kontaktanrufe zu identifizieren.';

  @override
  String get contactsTab => 'Kontakte';

  @override
  String get contactSubscriptionDescription =>
      'Abonnieren Sie Kontaktlisten über URL, aktualisieren Sie automatisch Kontaktinformationen und Etiketten. Unterstützt Daten im JSON-Format.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Fehler beim Laden der Kontakt-Abonnements: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Kontakt-Abonnements';

  @override
  String get contactUpdateSuccess => 'Kontakt erfolgreich aktualisiert';

  @override
  String get contactUs => 'Kontaktiere uns';

  @override
  String get content => 'Inhalt';

  @override
  String get contentRegex => 'Inhalts-Regex';

  @override
  String get countColor => 'Zählfarbe';

  @override
  String get countFontSize => 'Zähl-Schriftgröße';

  @override
  String get countPosition => 'Zählposition';

  @override
  String get country => 'Land';

  @override
  String get countryNameColor => 'Ländernamenfarbe';

  @override
  String get countryNameFontSize => 'Ländernamen-Schriftgröße';

  @override
  String get countryRegionNamePosition => 'Positionsname Land/Region';

  @override
  String get countrySelectionDialog => 'Länderauswahldialog';

  @override
  String get countrySelectionDialogDescription =>
      'Wird verwendet, um ein Land auszuwählen, um Anrufer-ID-Informationen abzufragen';

  @override
  String get countThresholdDescription =>
      'Legen Sie den Mindestzählschwellenwert fest, der erforderlich ist, um Filteraktionen auszulösen';

  @override
  String get countThresholdLabel => 'Zählschwellenwert';

  @override
  String get countThresholdSettings =>
      'Einstellungen für den Zählschwellenwert';

  @override
  String countThresholdValue(Object count) {
    return 'Zählschwellenwert: $count';
  }

  @override
  String get createdRules => 'Erstellte Regeln';

  @override
  String get csvFormat => 'CSV-Format';

  @override
  String get currentDeviceChip => 'Aktuell';

  @override
  String get currentDeviceLabel => 'Aktuelles Gerätelabel';

  @override
  String get currentDeviceTitle => 'Aktuelles Gerät';

  @override
  String get currentLabels => 'Aktuelle Etiketten:';

  @override
  String get currentLanguage => 'Aktuelle Sprache';

  @override
  String get currentPasswordLabel => 'Aktuelles Passwort';

  @override
  String get customerService => 'Kundenservice';

  @override
  String get customRange => 'Benutzerdefinierter Bereich';

  @override
  String get dailyStatistics => 'Tägliche Statistiken';

  @override
  String get dailyStatisticsDesc =>
      'Erhalten Sie tägliche Statistiken über blockierte Anrufe und Nachrichten';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get dataAnalysis => 'Datenanalyse';

  @override
  String get dataAnalysisDashboardPage => 'Datenanalyse-Dashboard-Seite';

  @override
  String get dataExport => 'Datenexport';

  @override
  String dataLoadFailure(Object error) {
    return 'Daten konnten nicht geladen werden: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Fehler beim Laden der Daten: $error';
  }

  @override
  String get dataMigration => 'Datenmigration';

  @override
  String get dataMigrationDescription =>
      'Diese Funktion ermöglicht es Ihnen, alle Ihre Daten zwischen Geräten zu übertragen. Derzeit können Sie die Backup- und Wiederherstellungsfunktionen verwenden, um Ihre Daten manuell zu migrieren.';

  @override
  String get dataMigrationDialogContent =>
      'Diese Funktion ermöglicht es Ihnen, alle Ihre Daten zwischen Geräten zu übertragen. Derzeit können Sie die Backup- und Wiederherstellungsfunktionen verwenden, um Ihre Daten manuell zu migrieren.';

  @override
  String get dataMigrationDialogTitle => 'Datenmigration';

  @override
  String get dataMigrationSectionTitle => 'Datenmigration';

  @override
  String get dataSourceReminder => 'Datenquellen-Erinnerung';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Tage VIP';
  }

  @override
  String get debtCollection => 'Inkasso';

  @override
  String get defaultPeriod => 'Woche';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get deleteContact => 'Kontakt löschen';

  @override
  String deleteContactConfirm(Object name) {
    return 'Sind Sie sicher, dass Sie $name löschen möchten?';
  }

  @override
  String get deleteContactConfirmation =>
      'Sind Sie sicher, dass Sie den Kontakt löschen möchten';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Sind Sie sicher, dass Sie $deviceName löschen möchten?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Gerät löschen';

  @override
  String deleteFailed(Object error) {
    return 'Löschen fehlgeschlagen: $error';
  }

  @override
  String get deleteFilter => 'Filter löschen';

  @override
  String get deleteLabel => 'Label löschen';

  @override
  String deleteLabelFailed(Object error) {
    return 'Fehler beim Löschen des Labels: $error';
  }

  @override
  String get deletePlugin => 'Plugin löschen';

  @override
  String deletePluginFailed(Object error) {
    return 'Fehler beim Löschen des Plugins: $error';
  }

  @override
  String get deletePlugins => 'Plugins löschen';

  @override
  String deletePluginsFailed(Object error) {
    return 'Fehler beim Löschen der Plugins: $error';
  }

  @override
  String get deleteRule => 'Regel löschen';

  @override
  String deleteRuleFailed(Object error) {
    return 'Löschen fehlgeschlagen: $error';
  }

  @override
  String get deleteSelected => 'Ausgewählte löschen';

  @override
  String get deleteSmsRule => 'SMS-Regel löschen';

  @override
  String get deleteSubscription => 'Abonnement löschen';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Sind Sie sicher, dass Sie das Abonnement \"$name\" löschen möchten?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Fehler beim Löschen des Abonnements: $error';
  }

  @override
  String get deleteSuccess => 'Erfolgreich gelöscht';

  @override
  String get delivery => 'Zustellung';

  @override
  String get deviceDeletedSuccessfully => 'Gerät erfolgreich gelöscht';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Gerät erfolgreich gelöscht';

  @override
  String get deviceIdLabel => 'Geräte-ID';

  @override
  String get deviceIDLabel => 'Geräte-ID';

  @override
  String get deviceManagementSubtitle =>
      'Mehrgeräte-Synchronisierung verwalten';

  @override
  String get deviceManagementTitle => 'Geräteverwaltung';

  @override
  String get deviceModelLabel => 'Gerätemodell';

  @override
  String get deviceName => 'Gerätename';

  @override
  String get deviceNameCannotBeEmpty => 'Der Gerätename darf nicht leer sein';

  @override
  String get deviceNameHint => 'Bitte Gerätenamen eingeben';

  @override
  String get deviceNameLabel => 'Gerätename';

  @override
  String get deviceRenamedSuccessfully => 'Gerät erfolgreich umbenannt';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Gerät erfolgreich umbenannt';

  @override
  String get devicesSyncedSuccessfully => 'Geräte erfolgreich synchronisiert';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Geräte erfolgreich synchronisiert';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Geräte erfolgreich synchronisiert';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Gerät erfolgreich abgemeldet';

  @override
  String get dialogTitle => 'Regex-Muster Erklärung';

  @override
  String get differentFromLocalCounter =>
      'Diese Funktion unterscheidet sich vom lokalen Zählerfilter, da sie sich auf wiederholte Anrufmuster in kurzer Zeit konzentriert und nicht auf langfristige Markierungszählungen.';

  @override
  String get disabled => 'Deaktiviert';

  @override
  String get disabledStatus => 'Deaktiviert';

  @override
  String get disableGlobalPlugins => 'Globale Plugins deaktivieren';

  @override
  String get disableSubscriptionSuccessfully =>
      'Abonnement erfolgreich deaktiviert';

  @override
  String get disconnectButton => 'Trennen';

  @override
  String get disconnectedMessage => 'Getrennt';

  @override
  String get disconnectedStatus => 'Getrennt';

  @override
  String get disconnectFailedMessage => 'Verbindung fehlgeschlagen';

  @override
  String get done => 'Fertig';

  @override
  String get dualSimAdvice =>
      'Diese Funktion ist besonders nützlich für Dual-SIM-Telefone, um verschiedene Filterstrategien für berufliche und private SIM-Karten festzulegen.';

  @override
  String get earlier => 'Früher';

  @override
  String get ecommerce => 'E-Commerce';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get editContact => 'Kontakt bearbeiten';

  @override
  String get editFilter => 'Filter bearbeiten';

  @override
  String get editLabel => 'Label bearbeiten';

  @override
  String get editPhoneRule => 'Telefonregel bearbeiten';

  @override
  String get editPhoneRules => 'Wird verwendet, um Telefonregeln zu bearbeiten';

  @override
  String get editPhoneRuleTitle => 'Telefonregel bearbeiten';

  @override
  String get editRule => 'Regel bearbeiten';

  @override
  String get editSmsRule => 'SMS-Regel bearbeiten';

  @override
  String get education => 'Bildung';

  @override
  String get elementPositionsSetting => 'Elementpositionen';

  @override
  String get email => 'E-Mail';

  @override
  String get emailOptional => 'E-Mail (Optional)';

  @override
  String get enableCallFilter => 'Anruffilter aktivieren';

  @override
  String get enableCallFilterDescription =>
      'Wenn aktiviert, werden eingehende Anrufe anhand der untenstehenden Regelliste geprüft. Anruffilterregeln werden standardmäßig nicht zwischen Geräten synchronisiert.';

  @override
  String get enabled => 'Aktiviert';

  @override
  String get enabledStatus => 'Aktiviert';

  @override
  String get enableEncryption => 'Verschlüsselung aktivieren';

  @override
  String get enableEncryptionDescription => 'Backup-Dateien verschlüsseln';

  @override
  String get enableEncryptionLabel => 'Verschlüsselung aktivieren';

  @override
  String get enableEncryptionSubtitle => 'Backup-Dateien werden verschlüsselt';

  @override
  String get enableEncryptionTitle => 'Verschlüsselung aktivieren';

  @override
  String get enableGlobalPlugins => 'Globale Plugins aktivieren';

  @override
  String get enableLocalCountFilter => 'Lokalen Zählfilter aktivieren';

  @override
  String get enableLocalCountFilterDescription =>
      'Spam-Anrufe automatisch basierend auf der Anzahl der Anrufmarkierungen filtern';

  @override
  String get enableLocalNotification => 'Lokale Benachrichtigung verwenden';

  @override
  String get enableLocalNotificationDescription =>
      'Wenn aktiviert, werden Benachrichtigungen für gefilterte Nachrichten auf dem Gerät angezeigt';

  @override
  String get enableLocationSummary => 'Standort';

  @override
  String get enableMuteRules => 'Stumm-Regeln aktivieren';

  @override
  String get enableMuteRulesDesc => 'Stumm-Abfangregeln Konfiguration anwenden';

  @override
  String get enableNoneActionRules => 'Regeln ohne Aktion aktivieren';

  @override
  String get enableNoneActionRulesDesc =>
      'Regelkonfigurationen ohne Abfangaktionen erlauben';

  @override
  String get enableNotifications => 'Benachrichtigungen aktivieren';

  @override
  String get enableRemoteNumberFilter => 'Remote-Nummernfilter aktivieren';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Remote-Datenbank zur Filterung von Nummern verwenden';

  @override
  String get enableRule => 'Regel aktivieren';

  @override
  String get enableSmsFilter => 'SMS-Filterung aktivieren';

  @override
  String get enableSmsFilterDescription =>
      'Wenn aktiviert, werden Nachrichten automatisch gemäß den Regeln gefiltert';

  @override
  String get enableStatisticsNotifications =>
      'Statistikbenachrichtigungen aktivieren';

  @override
  String get enableSubscriptionSuccessfully =>
      'Abonnement erfolgreich aktiviert';

  @override
  String get enableTimeInterception => 'Zeitliche Abfangung aktivieren';

  @override
  String get enableTimeInterceptionDescription =>
      'Wiederholte Anrufe innerhalb kurzer Zeit abfangen';

  @override
  String get enableTimeInterceptor => 'Zeitlicher Abfänger aktivieren';

  @override
  String get endCallImmediately => 'Anruf sofort beenden';

  @override
  String get endColor => 'Endfarbe';

  @override
  String get endDate => 'Enddatum';

  @override
  String get enhancedFilterInstructionsTitle => 'Erweitertes Filtersystem';

  @override
  String get enhancedFilterSettings => 'Erweiterte Filtereinstellungen';

  @override
  String get enhancedFilterSettingsTitle => 'Erweiterte Filtereinstellungen';

  @override
  String get enhancedFilterSystemDescription =>
      'Das erweiterte Filtersystem unterstützt sowohl globale Regeln als auch Filterkonfigurationen pro SIM-Karte.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Bitte geben Sie sowohl Telefonnummer als auch Regex-Muster ein';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Bitte geben Sie sowohl Telefonnummer als auch Regex-Muster ein.';

  @override
  String get enterContactName => 'Bitte geben Sie den Kontaktnamen ein';

  @override
  String get enterCurrentPasswordHint =>
      'Bitte geben Sie das aktuelle Passwort ein';

  @override
  String get enterDeviceName => 'Gerätenamen eingeben';

  @override
  String get enterDeviceNameHint => 'Bitte geben Sie den Gerätenamen ein';

  @override
  String get enterEmail => 'E-Mail-Adresse eingeben';

  @override
  String get enterEmailOptional => 'E-Mail-Adresse eingeben (optional)';

  @override
  String get enterEncryptionPasswordHint => 'Verschlüsselungspasswort eingeben';

  @override
  String get enterEncryptionPasswordTitle =>
      'Verschlüsselungspasswort eingeben';

  @override
  String get enterFilterName => 'Bitte geben Sie den Filternamen ein';

  @override
  String get enterFilterPattern => 'Bitte geben Sie das Filtermuster ein';

  @override
  String get enterIconCode => 'Icon-Code eingeben';

  @override
  String get enterName => 'Namen des Kontakts eingeben';

  @override
  String get enterNewDeviceNameHint =>
      'Geben Sie einen neuen Namen für dieses Gerät ein';

  @override
  String get enterNewPasswordHint => 'Bitte geben Sie ein neues Passwort ein';

  @override
  String get enterPasswordAgain => 'Passwort erneut eingeben';

  @override
  String get enterPasswordHint => 'Bitte geben Sie das Passwort ein';

  @override
  String get enterPhoneNumber => 'Telefonnummer eingeben';

  @override
  String get enterPhoneNumberHint =>
      'Geben Sie die zu testende Telefonnummer ein';

  @override
  String get enterPhoneNumberMultiple =>
      'Bitte geben Sie die Telefonnummer ein, mehrere Nummern durch Kommas getrennt';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Geben Sie die Telefonnummer ein, um die Suche zu starten';

  @override
  String get enterPhoneNumberToVerify =>
      'Geben Sie die zu überprüfende Telefonnummer ein';

  @override
  String get enterPluginName => 'Plugin-Namen eingeben';

  @override
  String get enterPluginUrl => 'Plugin-URL-Adresse eingeben';

  @override
  String get enterRegexHint => 'Regex-Muster eingeben';

  @override
  String get enterRuleNameAndPattern =>
      'Bitte geben Sie Regelname und -muster ein';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Bitte geben Sie sowohl den Regelnamen als auch das Regex-Muster ein.';

  @override
  String get enterRuleNameHint => 'Regelnamen eingeben';

  @override
  String get enterSearchContent => 'Bitte Suchinhalt eingeben';

  @override
  String get enterSubscriptionName => 'Abonnementnamen eingeben';

  @override
  String get enterSubscriptionUrl => 'Abonnement-URL eingeben';

  @override
  String get enterSyncFolderNameHint =>
      'Bitte geben Sie den Namen des Synchronisierungsordners ein (Standard: NotificationManager)';

  @override
  String get entertainment => 'Unterhaltung';

  @override
  String get enterValidNameAndUrl =>
      'Bitte geben Sie einen gültigen Namen und eine gültige URL ein';

  @override
  String get enterValidUrl => 'Bitte geben Sie eine gültige URL ein';

  @override
  String get enterVersion => 'Version eingeben';

  @override
  String get enterWebDAVPasswordHint => 'Bitte WebDAV-Passwort eingeben';

  @override
  String get enterWebDAVServerAddressHint =>
      'Bitte WebDAV-Serveradresse eingeben';

  @override
  String get enterWebDAVUsernameHint => 'Bitte WebDAV-Benutzernamen eingeben';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Fehler beim Löschen des Geräts: $error';
  }

  @override
  String get errorLoadingPlugin => 'Fehler beim Laden des Plugins';

  @override
  String errorOccurredMessage(Object error) {
    return 'Ein Fehler ist aufgetreten: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Fehler beim Umbenennen des Geräts: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Fehler beim Synchronisieren der Geräte: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Fehler beim Synchronisieren der Geräte: $error';
  }

  @override
  String get errorText => 'Fehler';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Fehler beim Abmelden des Geräts: $error';
  }

  @override
  String get exampleBlock400Prefix => 'z.B. Block 400 Präfixnummern';

  @override
  String get exampleBlockMarketingSms => 'z.B. Block Marketing SMS';

  @override
  String get exampleContentRegex => 'z.B. .*Angebot.*';

  @override
  String get exampleContentRegexHint => 'Beispiel Regex für Inhalte';

  @override
  String get exampleCouponPromotionDiscount =>
      'z.B. .*(Gutschein|Werbung|Rabatt).*';

  @override
  String get exampleFamilyFriends => 'z.B. Familie, Freunde, usw.';

  @override
  String get examplePhoneNumber => 'z.B. 10086, 12345, usw.';

  @override
  String get exampleRegex400Prefix => 'Beispiel-Regex für 400-Präfix';

  @override
  String get exampleRegexFormat => 'Beispiel: ^10086\$ Format';

  @override
  String get exampleSenderRegexHint => 'Beispiel';

  @override
  String get exchange => 'Austausch';

  @override
  String get exchangeNow => 'Jetzt austauschen';

  @override
  String get exchangeVip => 'VIP austauschen';

  @override
  String get expandLabelSelector => 'Label-Selektor erweitern';

  @override
  String expiryTime(Object time) {
    return 'Ablaufzeit: $time';
  }

  @override
  String get export => 'Exportieren';

  @override
  String get exportAllApplicationSettings =>
      'Alle Anwendungseinstellungen exportieren';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Alle Anwendungseinstellungen exportieren';

  @override
  String get exportAllRuleConfigurations =>
      'Alle Regelkonfigurationen exportieren';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Alle Regelkonfigurationen exportieren';

  @override
  String get exportComplete => 'Export abgeschlossen';

  @override
  String get exportConfig => 'Konfiguration exportieren';

  @override
  String get exportContacts => 'Kontakte exportieren';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get exportError => 'Fehler beim Exportieren';

  @override
  String get exportFailed => 'Export fehlgeschlagen';

  @override
  String get exportFailure => 'Export der Konfiguration fehlgeschlagen';

  @override
  String get exportFeatureComingSoon => 'Export-Funktion folgt in Kürze';

  @override
  String get exporting => 'Exportiere...';

  @override
  String get exportLabels => 'Etiketten exportieren';

  @override
  String exportLabelsFailed(Object error) {
    return 'Exportieren der Etiketten fehlgeschlagen: $error';
  }

  @override
  String get exportPluginList => 'Plugin-Liste exportieren';

  @override
  String exportPluginListFailed(Object error) {
    return 'Exportieren der Plugin-Liste fehlgeschlagen: $error';
  }

  @override
  String get exportRules => 'Regeln exportieren';

  @override
  String get exportRulesDialogTitle => 'Regeln exportieren';

  @override
  String get exportRulesTitle => 'Regeln exportieren';

  @override
  String get exportSmsRules => 'SMS-Regeln exportieren';

  @override
  String get exportStatisticsData => 'Statistikdaten exportieren';

  @override
  String get exportSuccess => 'Export erfolgreich';

  @override
  String get exportSuccesslly => 'Konfiguration erfolgreich exportiert';

  @override
  String get failedToAddContact => 'Kontakt konnte nicht hinzugefügt werden';

  @override
  String failedToAddRule(Object error) {
    return 'Regel konnte nicht hinzugefügt werden: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMS-Regel konnte nicht hinzugefügt werden: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS-Abonnement konnte nicht hinzugefügt werden: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Sicherung der Einstellungen fehlgeschlagen: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Entschlüsselung der Sicherungsdatei fehlgeschlagen';

  @override
  String get failedToDeleteDevice => 'Gerät konnte nicht gelöscht werden';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS-Regel konnte nicht gelöscht werden: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Exportieren der Regeln fehlgeschlagen: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Exportieren der SMS-Regeln fehlgeschlagen: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Abrufen der Anrufer-ID-Informationen fehlgeschlagen: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Importieren der Regeln fehlgeschlagen: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'Importieren der SMS-Regeln fehlgeschlagen: $error';
  }

  @override
  String get failedToLoadContacts => 'Laden der Kontakte fehlgeschlagen';

  @override
  String get failedToLoadPlugin => 'Laden des Plugins fehlgeschlagen';

  @override
  String get failedToRenameDevice => 'Umbenennen des Geräts fehlgeschlagen';

  @override
  String get failedToRestoreSettings =>
      'Wiederherstellung der Einstellungen fehlgeschlagen';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Wiederherstellung der Einstellungen fehlgeschlagen: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Festlegen des Passworts fehlgeschlagen: $error';
  }

  @override
  String get failedToSyncDevices =>
      'Synchronisierung der Geräte fehlgeschlagen';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Ändern des Regelstatus fehlgeschlagen: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Ändern des Abonnementstatus fehlgeschlagen';

  @override
  String get failedToUpdateContact =>
      'Aktualisieren des Kontakts fehlgeschlagen';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Aktualisieren der SMS-Regel fehlgeschlagen: $error';
  }

  @override
  String get failure => 'Fehler';

  @override
  String get favoriteContacts => 'Favoritenkontakte';

  @override
  String get featureAddRules =>
      '• Regeln für bestimmte Telefonnummern hinzufügen';

  @override
  String get featureCenter => 'Funktionszentrum';

  @override
  String get featureEnableDisable =>
      '• Aktivieren/Deaktivieren verschiedener Filter pro SIM';

  @override
  String get featureListTitle => 'Funktionen:';

  @override
  String get featureManageRules => '• Regellisten pro SIM verwalten';

  @override
  String get features => 'Funktionen';

  @override
  String get fetchingCallerIdInfo => 'Rufe Anrufer-ID-Informationen ab...';

  @override
  String fileSavedTo(Object path) {
    return 'Datei gespeichert unter: $path';
  }

  @override
  String get filter => 'Filter';

  @override
  String get filterByLabel => 'Nach Etikett filtern';

  @override
  String get filterClear => 'Filter löschen';

  @override
  String get filterControlPanelTitle => 'Filter-Bedienfeld';

  @override
  String get filterControlSubtitle => 'Ein-/Aus-Status aller Filter verwalten';

  @override
  String get filterControlTitle => 'Filtersteuerung';

  @override
  String get filterDeleteFailed => 'Filterlöschung fehlgeschlagen';

  @override
  String get filterDeleteSuccess => 'Filter erfolgreich gelöscht';

  @override
  String get filterDetails => 'Filterdetails';

  @override
  String get filtered => 'Gefiltert';

  @override
  String get filteredSms => 'Gefilterte SMS';

  @override
  String get filteredSmsLabel => 'Gefilterte SMS';

  @override
  String get filterExplanation => 'Filtererklärung';

  @override
  String get filterManagement => 'Filterverwaltung';

  @override
  String get filterName => 'Filtername';

  @override
  String get filterPattern => 'Filtermuster';

  @override
  String get filterPriorityNote =>
      'Hinweis: Es gibt Prioritätsbeziehungen zwischen Filtern. Bitte beachten Sie die Hilfedokumentation für Details';

  @override
  String get filterSaveFailed => 'Filterspeicherung fehlgeschlagen';

  @override
  String get filterSaveSuccess => 'Filter erfolgreich gespeichert';

  @override
  String get filterSettings => 'Filtereinstellungen';

  @override
  String get filterSettingsTitle => 'Filtereinstellungen';

  @override
  String get filterSMS => 'Filter-SMS';

  @override
  String get filterToggleInstructions =>
      'Aktiviere oder deaktiviere Filter für diesen SIM-Slot:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status Filter: $filterName';
  }

  @override
  String get filterType => 'Filtertyp';

  @override
  String get financial => 'Finanziell';

  @override
  String get flexibleCombinationFeature =>
      '• Flexible Kombinationen: Aktiviere/deaktiviere Filter pro SIM-Slot';

  @override
  String get fontSizesSetting => 'Schriftgrößen';

  @override
  String foundRules(Object count) {
    return '$count Regeln gefunden';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count Regeln gefunden. Möchten Sie diese importieren?';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count Regeln gefunden. Möchten Sie diese importieren?';
  }

  @override
  String get fraudAlert => 'BETRUGSVERSUCH - Legen Sie auf';

  @override
  String get fraudScamLikely => 'Betrugsverdacht wahrscheinlich';

  @override
  String get free => 'Kostenlos';

  @override
  String get functionSettingsTitle => 'Funktionseinstellungen';

  @override
  String generalUpdateFailure(Object error) {
    return 'Aktualisierung fehlgeschlagen: $error';
  }

  @override
  String get getFree => 'Kostenlos erhalten';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Konfigurieren Sie globale Filter für alle SIM-Karten:';

  @override
  String get globalFilterFeature =>
      '• Globale Filter: Grundlegende Regeln für alle eingehenden Anrufe';

  @override
  String get globalFilterSettings => 'Globale Filtereinstellungen';

  @override
  String get globalFilterToggleInstructions =>
      'Konfigurieren Sie globale Filtereinstellungen, die für alle SIM-Slots gelten:';

  @override
  String get globalSearchSubtitle =>
      'Suche Kontakte, Labels, Blacklists, Whitelists, usw.';

  @override
  String get globalSearchTitle => 'Globale Suche';

  @override
  String get globalSettings => 'Globale Einstellungen';

  @override
  String get googleAdDisplayPosition => 'Google Ad-Anzeigeposition';

  @override
  String get googleAdMobIntegrationText =>
      'Google AdMob-Anzeigen können hier integriert werden';

  @override
  String get googleDriveAuthDescription =>
      'Autorisieren Sie die Verwendung der systemkonfigurierten Google Drive-Client-ID und des Schlüssels';

  @override
  String get googleDriveAuthorizationHint =>
      'Autorisieren Sie die Verwendung der systemkonfigurierten Google Drive-Client-ID und des Schlüssels';

  @override
  String get googleDriveConfigTitle => 'Google Drive-Konfiguration';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive-Konfiguration';

  @override
  String get government => 'Regierung';

  @override
  String get granted => 'Gewährt';

  @override
  String get grantNecessaryPermissions =>
      'Erforderliche Berechtigungen erteilen';

  @override
  String get grantPermissions => 'Berechtigungen erteilen';

  @override
  String get headhunter => 'Headhunter';

  @override
  String get height => 'Größe';

  @override
  String get homePageTitle => 'Startseite';

  @override
  String get homeTab => 'Start';

  @override
  String get howItWorksPoint1 =>
      '• Das System erlaubt automatisch Anrufe von derselben Nummer innerhalb des eingestellten Zeitfensters';

  @override
  String get howItWorksPoint2 =>
      '• Kürzere Zeitfenster führen zu einer strengeren Abfangung; längere Zeitfenster führen zu einer lockeren Abfangung';

  @override
  String get howItWorksPoint3 =>
      '• Das System überprüft Anrufprotokolle, um festzustellen, ob es sich um einen wiederholten Anruf handelt';

  @override
  String get howItWorksTitle => 'So funktioniert es:';

  @override
  String get iconCodeOptional => 'Icon-Code (Optional)';

  @override
  String get iconSize => 'Icon-Größe';

  @override
  String get import => 'Importieren';

  @override
  String get important => 'Wichtig';

  @override
  String get importButton => 'Importieren';

  @override
  String get importConfig => 'Konfiguration importieren';

  @override
  String get importContacts => 'Kontakte importieren';

  @override
  String get importExportContacts => 'Kontakte importieren/exportieren';

  @override
  String get importExportContactsTooltip => 'Kontakte importieren/exportieren';

  @override
  String get importExportRules => 'Regeln importieren/exportieren';

  @override
  String importFailed(Object error) {
    return 'Import fehlgeschlagen: $error';
  }

  @override
  String get importFailure => 'Konfiguration konnte nicht importiert werden';

  @override
  String get importFeatureComingSoon => 'Importfunktion folgt in Kürze';

  @override
  String get importLabels => 'Labels importieren';

  @override
  String importLabelsFailed(Object error) {
    return 'Labels konnten nicht importiert werden: $error';
  }

  @override
  String get importPluginList => 'Plugin-Liste importieren';

  @override
  String importPluginListFailed(Object error) {
    return 'Plugin-Liste konnte nicht importiert werden: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '$count Plugins erfolgreich importiert';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Regelkonfigurationen aus Datei importieren';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Regelkonfigurationen aus Datei importieren';

  @override
  String get importRules => 'Regeln importieren';

  @override
  String get importRulesButton => 'Regeln importieren';

  @override
  String get importRulesDialogTitle => 'Regeln importieren';

  @override
  String importRulesError(Object error) {
    return 'Regeln konnten nicht importiert werden: $error';
  }

  @override
  String get importRulesInstructions =>
      'Regeln aus einer CSV-Datei importieren';

  @override
  String get importRulesSuccess => 'Regeln erfolgreich importiert';

  @override
  String get importRulesTitle => 'Regeln importieren';

  @override
  String get importSuccess => 'Import erfolgreich';

  @override
  String get incomingCallInterceptAction =>
      'Aktion zur Abfangung eingehender Anrufe';

  @override
  String get incomingCallNotification =>
      'Benachrichtigung über eingehenden Anruf';

  @override
  String get incorrectPassword => 'Falsches Passwort';

  @override
  String get initializing => 'Initialisierung';

  @override
  String get installed => 'Installiert';

  @override
  String get insufficientMarks => 'Unzureichende Markierungen';

  @override
  String get insurance => 'Versicherung';

  @override
  String get interceptAction => 'Abfangaktion';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Festlegen, wie blockierte Anrufe behandelt werden';

  @override
  String get interceptionActionSettingsTitle =>
      'Einstellungen für die Abfangaktion';

  @override
  String get interceptionTimeInterval => 'Zeitintervall für die Abfangung';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service Aktualisierungsintervall auf $days Tage gesetzt';
  }

  @override
  String get invalidContentRegex => 'Ungültiger Inhalts-Regex';

  @override
  String get invalidLabel => 'Ungültige Bezeichnung';

  @override
  String get invalidRegexPattern => 'Ungültiges Regex-Muster';

  @override
  String get invalidSenderRegex => 'Ungültiger Absender-Regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Treten Sie dem Telegram-Kanal und der Gruppe bei, um weitere Informationen zu erhalten';

  @override
  String get jsLogsTitle => 'JS-Protokolle';

  @override
  String get jsonFormat => 'JSON-Format';

  @override
  String get keepAllVersions => 'Alle Versionen beibehalten';

  @override
  String get keepAllVersionsDescription =>
      'Alle historischen Versionen jedes Backups beibehalten';

  @override
  String get keepAllVersionsLabel => 'Alle Versionen beibehalten';

  @override
  String get keepAllVersionsSubtitle =>
      'Historische Versionen jedes Backups beibehalten';

  @override
  String get keepAllVersionsTitle => 'Alle Versionen beibehalten';

  @override
  String get label => 'Bezeichnung';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Bezeichnung \"$name\" erfolgreich hinzugefügt';
  }

  @override
  String get labelCategories => 'Bezeichnungskategorien';

  @override
  String get labelDeleted => 'Bezeichnung gelöscht';

  @override
  String get labelDescription =>
      'Bezeichnungen helfen Ihnen, Kontakte besser zu verwalten. Fügen Sie Telefonnummern benutzerdefinierte Bezeichnungen hinzu, um Anrufe und Nachrichten einfach zu identifizieren.';

  @override
  String get labelFilter => 'Bezeichnungsfilter';

  @override
  String get labelFilterTooltip => 'Bezeichnungsfilter';

  @override
  String get labelIconColor => 'Bezeichnungs-Symbolfarbe';

  @override
  String get labelManagement => 'Bezeichnungsverwaltung';

  @override
  String get labelNotFound => 'Bezeichnung nicht gefunden';

  @override
  String get labelRemoved => 'Bezeichnung entfernt';

  @override
  String labelRemoveFailed(Object error) {
    return 'Fehler beim Entfernen der Bezeichnung: $error';
  }

  @override
  String get labels => 'Bezeichnungen';

  @override
  String get labelsColor => 'Bezeichnungsfarbe';

  @override
  String labelsDeleted(Object count) {
    return '$count Bezeichnungen gelöscht';
  }

  @override
  String get labelsExportedSuccessfully =>
      'Bezeichnungen erfolgreich exportiert';

  @override
  String get labelsFontSize => 'Bezeichnungs-Schriftgröße';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count Bezeichnungen erfolgreich importiert';
  }

  @override
  String get labelsPosition => 'Bezeichnungsposition';

  @override
  String labelTag(Object labelId) {
    return 'Bezeichnung: $labelId';
  }

  @override
  String get labelUpdated => 'Bezeichnung aktualisiert';

  @override
  String labelUpdateFailed(Object error) {
    return 'Fehler beim Aktualisieren der Bezeichnung: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Bezeichnung \"\$labelText\" erfolgreich aktualisiert';

  @override
  String get languageSettings => 'Spracheinstellungen';

  @override
  String get languageSettingsSubtitle => 'Anzeigesprache der Anwendung ändern';

  @override
  String get languageSettingsTitle => 'Spracheinstellungen';

  @override
  String get last30Days => 'Letzte 30 Tage';

  @override
  String get last7Days => 'Letzte 7 Tage';

  @override
  String get lastSyncLabel => 'Letzte Synchronisierung';

  @override
  String lastUpdated(Object date) {
    return 'Letzte Aktualisierung: $date';
  }

  @override
  String get lifetimeMembership => 'Lebenslange Mitgliedschaft';

  @override
  String get lifetimeMembershipDescription =>
      'Einmaliger Kauf, schalte dauerhaft alle Premium-Funktionen und zukünftige Updates frei';

  @override
  String loadContactsFailed(Object error) {
    return 'Fehler beim Laden der Kontakte: $error';
  }

  @override
  String get loadDataFailed => 'Fehler beim Laden der Daten';

  @override
  String get loadFailed => 'Laden fehlgeschlagen';

  @override
  String get loading => 'Laden...';

  @override
  String get loadingData => 'Daten werden geladen...';

  @override
  String get loadingTags => 'Schlagwörter werden geladen...';

  @override
  String loadLabelFailed(Object error) {
    return 'Fehler beim Laden der Bezeichnungen: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Das Laden der Labels ist fehlgeschlagen: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Das Laden der Anzahl markierter Telefonnummern ist fehlgeschlagen: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Das Laden der markierten Telefone ist fehlgeschlagen: $error';
  }

  @override
  String get loadMore => 'Mehr laden';

  @override
  String get loadPluginButton => 'Plugin laden';

  @override
  String loadPluginsFailed(Object error) {
    return 'Das Laden der Plugins ist fehlgeschlagen: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Das Laden der Einstellungen ist fehlgeschlagen: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Das Laden der SMS-Regeln ist fehlgeschlagen: $error';
  }

  @override
  String get loadStatusFailedMessage =>
      'Das Laden des Status ist fehlgeschlagen';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Das Laden der Abonnements ist fehlgeschlagen: $error';
  }

  @override
  String get loan => 'Kredit';

  @override
  String get localBackupTitle => 'Lokale Sicherung';

  @override
  String get localCounterFilter => 'Lokaler Zählerfilter';

  @override
  String get localCounterFilterSubtitle =>
      'Automatische Filterung von Spam-Anrufen basierend auf der Anrufhäufigkeit';

  @override
  String get localCountFilter => 'Lokaler Zählfilter';

  @override
  String get localCountFilterDescription =>
      'Häufige Anrufe basierend auf lokalen Nummernzählungen abfangen';

  @override
  String get localCountFilterExplanationContent =>
      'Der lokale Zählfilter analysiert Anrufprotokolle, um häufige Spam-Anrufe automatisch zu identifizieren und zu blockieren.';

  @override
  String get localCountFilterExplanationTitle =>
      'Erläuterung zum lokalen Zählfilter';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Bestimmen Sie, ob basierend auf dem Zählwert der Nummer blockiert werden soll';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Wenn die Anzahl einer Nummer den festgelegten Schwellenwert überschreitet, können Sie diese automatisch blockieren';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Sie können selektiv Nummern zulassen, die den Schwellenwert nicht überschreiten';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Sie können wählen, ob alle Abfrageprotokolle aufgezeichnet werden sollen';

  @override
  String get localCountFiltering => 'Lokale Zählfilterung';

  @override
  String get localCountFilteringExplanation =>
      '• Lokale Zählfilterung: Filterregeln basierend auf der lokalen Markierungsanzahl';

  @override
  String get localCountFilterSettings =>
      'Einstellungen für den lokalen Zählfilter';

  @override
  String get localCountFilterUseCases =>
      'Dieser Filter eignet sich besonders zur Identifizierung von automatisch gewählten Spam-Anrufen und Marketinganrufen.';

  @override
  String get localFilterSettings => 'Lokale Filtereinstellungen';

  @override
  String get localNotificationDisabled => 'Lokale Benachrichtigung deaktiviert';

  @override
  String get localNotificationEnabled => 'Lokale Benachrichtigung aktiviert';

  @override
  String get localServices => 'Lokale Dienste';

  @override
  String get locationColor => 'Standortfarbe';

  @override
  String get locationFontSize => 'Standort-Schriftgröße';

  @override
  String get locationIconColor => 'Standort-Symbolfarbe';

  @override
  String get locationPosition => 'Standortposition';

  @override
  String get logAllLocalQueries => 'Alle lokalen Abfragen protokollieren';

  @override
  String get logAllLocalQueriesDescription =>
      'Protokolle für alle lokalen Nummern-Abfragen aufzeichnen';

  @override
  String get logAllRemoteQueries => 'Alle Remote-Abfragen protokollieren';

  @override
  String get logAllRemoteQueriesDescription =>
      'Alle Remote-Nummern-Abfragevorgänge aufzeichnen';

  @override
  String get manage => 'Kontakte verwalten';

  @override
  String get manageContacts => 'Verwalten';

  @override
  String get manageFavoriteContacts => 'Favoriten-Kontakte verwalten';

  @override
  String get manageFilterRules => 'Filterregeln verwalten';

  @override
  String get manageFilterRulesDescription =>
      'SMS-Filterregeln hinzufügen, bearbeiten oder löschen';

  @override
  String get manageFrequentContacts => 'Häufige Kontakte verwalten';

  @override
  String get markCounts => 'Markierungsanzahlen';

  @override
  String get markCount => 'Markierungsanzahl';

  @override
  String markedByCount(Object count) {
    return 'Markiert von $count';
  }

  @override
  String get markedPhonesList => 'Liste markierter Telefonnummern';

  @override
  String get markExchange => 'Austausch markieren';

  @override
  String get markPhone => 'Telefonnummer markieren';

  @override
  String markPhoneFailed(Object error) {
    return 'Fehler beim Markieren der Telefonnummer: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'Zum Markieren von Telefonnummern';

  @override
  String get markPhoneManagementTitle => 'Telefonnummern-Verwaltung markieren';

  @override
  String get markPhoneSuccess => 'Telefonnummer erfolgreich markiert';

  @override
  String get matchFailed => 'Übereinstimmung fehlgeschlagen!';

  @override
  String get matchFailedMessage => 'Übereinstimmung fehlgeschlagen.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'entspricht einem bestimmten Zahlenformat';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Übereinstimmende Zahlen mit Sonderzeichen:';

  @override
  String get matchSpecificDigitPatterns =>
      'entspricht dem Format XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Übereinstimmende spezifische Ziffernmuster:';

  @override
  String get matchSuccessful => 'Übereinstimmung erfolgreich!';

  @override
  String get matchSuccessfulMessage => 'Übereinstimmung erfolgreich!';

  @override
  String get medical => 'Medizinisch';

  @override
  String get membershipPrivileges => 'Mitgliedschafts-Privilegien';

  @override
  String get migrationTool => 'Migrationstool';

  @override
  String get migrationToolTitle => 'Migrationstool';

  @override
  String get minutes => 'Minuten';

  @override
  String get month => 'Monat';

  @override
  String get monthly => 'Monatlich';

  @override
  String get monthlyCallCount => 'Monatliche Anrufe';

  @override
  String get monthlyChartTitle => 'Monatliche blockierte Anrufe';

  @override
  String get monthlyMembership => 'Monatliche Mitgliedschaft';

  @override
  String get monthlyMembershipDescription =>
      'Schalte alle Premium-Funktionen frei, automatische monatliche Verlängerung';

  @override
  String get monthlyTotal => 'Monatlicher Gesamtbetrag';

  @override
  String get monthlyTotalLabel => 'Monatlicher Gesamtbetrag';

  @override
  String get moreOptions => 'Mehr Optionen';

  @override
  String get mute => 'Stumm schalten';

  @override
  String get name => 'Name';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Name und Telefonnummer dürfen nicht leer sein';

  @override
  String get nameAndPhoneNumberRequired =>
      'Name und Telefonnummer dürfen nicht leer sein';

  @override
  String get nameColor => 'Namensfarbe';

  @override
  String get nameFontSize => 'Namens-Schriftgröße';

  @override
  String nameLabel(Object name) {
    return 'Name: $name';
  }

  @override
  String get namePosition => 'Position des Namens';

  @override
  String get nameUnknown => 'Name: Unbekannt';

  @override
  String nameWithValue(String name) {
    return 'Name: $name';
  }

  @override
  String get newPasswordLabel => 'Neues Passwort';

  @override
  String get nextStep => 'Weiter';

  @override
  String get noAction => 'Keine Aktion';

  @override
  String get noActionRules => 'Keine Aktionsregeln';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Kein aktiver Cloud-Sync-Dienst';

  @override
  String get noCallLogs => 'Keine Anrufprotokolle';

  @override
  String get noCallRecords => 'Keine Anrufaufzeichnungen';

  @override
  String get noContacts => 'Noch keine Kontakte';

  @override
  String get noContactsYet => 'Noch keine Kontakte';

  @override
  String get noData => 'Keine Daten';

  @override
  String get noDevicesRegisteredMessage => 'Keine Geräte registriert';

  @override
  String get noDevicesRegisteredYet => 'Noch keine Geräte registriert.';

  @override
  String get noFilters => 'Noch keine Filter';

  @override
  String get noLabels => 'Noch keine Labels';

  @override
  String get noMarkedPhones => 'Keine markierten Telefonnummern';

  @override
  String get noMatchingContacts => 'Keine übereinstimmenden Kontakte';

  @override
  String get noMatchingContactsFound =>
      'Keine übereinstimmenden Kontakte gefunden';

  @override
  String get noMatchingNumbersFound =>
      'Keine übereinstimmenden Nummern gefunden';

  @override
  String get noMatchingRecords => 'Keine übereinstimmenden Anrufaufzeichnungen';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Keine übereinstimmenden $ruleType';
  }

  @override
  String get none => 'Keine';

  @override
  String get noneServiceType => 'Keine';

  @override
  String get noPlugins => 'Noch keine Plugins';

  @override
  String get noRecords => 'Keine Anrufaufzeichnungen';

  @override
  String get noResultReturned => 'Kein Ergebnis zurückgegeben';

  @override
  String get noResultReturnedLog => 'Kein Ergebnis vom Plugin zurückgegeben';

  @override
  String noRules(Object ruleType) {
    return 'Noch keine $ruleType';
  }

  @override
  String get noRulesPrompt =>
      'Keine Regeln gefunden, bitte fügen Sie Regeln hinzu';

  @override
  String get noRulesToExport => 'Keine Regeln zum Exportieren';

  @override
  String get noSmsFilterRulesYet => 'Noch keine SMS-Filterregeln';

  @override
  String get noSmsRulesYet => 'Noch keine SMS-Regeln';

  @override
  String get noSubscriptions => 'Keine Abonnements';

  @override
  String get noSubscriptionsYet => 'Noch keine Abonnements';

  @override
  String get notGranted => 'Nicht gewährt';

  @override
  String get notificationMode => 'Benachrichtigungsmodus';

  @override
  String get notificationModeDescription =>
      'Anruferinformationen in der Benachrichtigungsleiste anzeigen';

  @override
  String get notificationPermission => 'Benachrichtigungsberechtigung';

  @override
  String get notificationPermissionDescription =>
      'Wird verwendet, um Benachrichtigungen über eingehende Anrufe und Nachrichten anzuzeigen.';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get notificationSettings => 'Benachrichtigungseinstellungen';

  @override
  String get notificationSettingsSaved =>
      'Benachrichtigungseinstellungen erfolgreich gespeichert';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get notVerifiedText => 'Nicht verifiziert';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Keine gültigen SMS-Regeln in der Datei gefunden';

  @override
  String get number => 'Nummer';

  @override
  String get numberColor => 'Nummernfarbe';

  @override
  String get numberFontSize => 'Nummer Schriftgröße';

  @override
  String get numberPosition => 'Nummernposition';

  @override
  String get numberSearch => 'Nummernsuchen';

  @override
  String get numberTypeColor => 'Nummerntyp Farbe';

  @override
  String get numberTypeFontSize => 'Nummerntyp Schriftgröße';

  @override
  String get numberTypePosition => 'Nummerntyp Position';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Ihr Anrufsicherheitsmanager ist bereit. Genießen Sie ab sofort ein sicheres Anruferlebnis!';

  @override
  String get onboardingLanguageDescription =>
      'Wählen Sie Ihre bevorzugte Sprache für das beste Erlebnis.';

  @override
  String get onboardingPermissionsDescription =>
      'Um den vollen Service zu bieten, benötigen wir folgende Berechtigungen:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Ein-Klick-Blockierung von Spam-Anrufen und -Nachrichten, Anpassen von Blockierungsregeln und Bereitstellung einer ruhigen Umgebung.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Automatische Identifizierung unbekannter Anrufe, Markierung verdächtiger Nummern und Schutz Ihrer Anrufsicherheit.';

  @override
  String get onboardingWelcomeDescription =>
      'Ihr Anrufmanagement-Experte, der umfassende Anruferkennungs- und Blockierungsdienste bietet.';

  @override
  String get oneDriveAuthDescription =>
      'Autorisierung mit systemkonfigurierter OneDrive-Client-ID und -Schlüssel';

  @override
  String get oneDriveAuthorizationHint =>
      'Autorisierung mit systemkonfigurierter OneDrive-Client-ID und -Schlüssel';

  @override
  String get oneDriveConfigTitle => 'OneDrive-Konfiguration';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive-Konfiguration';

  @override
  String get onlineCallerIdSubscription => 'Online Anrufer-ID-Abonnement';

  @override
  String get openAppSettings => 'App-Einstellungen öffnen';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Das Öffnen der App-Einstellungen ist fehlgeschlagen: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operation fehlgeschlagen: $error';
  }

  @override
  String get operationFailure => 'Operation fehlgeschlagen';

  @override
  String get operationSuccess => 'Operation erfolgreich';

  @override
  String get other => 'Sonstige';

  @override
  String get ourOtherApps => 'Unsere anderen Apps';

  @override
  String get overlayMode => 'Schwebendes Fenster';

  @override
  String get overlayModeDescription =>
      'Anruferinformationen in einem schwebenden Fenster anzeigen';

  @override
  String get overlayPermission => 'Overlay-Berechtigung';

  @override
  String get overlayPermissionDescription =>
      'Wird verwendet, um das Overlay für eingehende Anrufe anzuzeigen.';

  @override
  String get overview => 'Übersicht';

  @override
  String get password => 'Passwort';

  @override
  String get passwordCannotBeEmpty => 'Das Passwort darf nicht leer sein';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get passwordSetSuccessfully => 'Passwort erfolgreich gesetzt';

  @override
  String get pattern => 'Muster';

  @override
  String get pendingSync => 'Ausstehende Synchronisierung';

  @override
  String get periodMonth => 'Monat';

  @override
  String get periodWeek => 'Woche';

  @override
  String get periodYear => 'Jahr';

  @override
  String get permissionDenied => 'Berechtigungsanfrage abgelehnt';

  @override
  String get permissionGranted => 'Berechtigung erteilt';

  @override
  String get permissionManagement => 'Berechtigungsverwaltung';

  @override
  String get phoneCallsTab => 'Telefon';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get phoneNumberCannotBeEmpty =>
      'Die Telefonnummer darf nicht leer sein';

  @override
  String get phoneNumberHint => 'Telefonnummer eingeben';

  @override
  String get phoneNumberHintText => 'Telefonnummer zur Regel hinzufügen';

  @override
  String get phoneNumberLabel => 'Telefonnummer';

  @override
  String get phoneNumberRegexRequired =>
      'Bitte geben Sie sowohl Telefonnummer als auch Regex-Muster ein';

  @override
  String get phoneNumberRequired => 'Telefonnummer ist erforderlich';

  @override
  String get phoneNumberTypeFixedLine => 'Festnetz';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Festnetz oder Mobilfunk';

  @override
  String get phoneNumberTypeMobile => 'Mobilfunk';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Persönliche Nummer';

  @override
  String get phoneNumberTypePremiumRate => 'Premium-Rate';

  @override
  String get phoneNumberTypeSharedCost => 'Shared Cost';

  @override
  String get phoneNumberTypeTollFree => 'Gebührenfrei';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Unbekannt';

  @override
  String get phoneNumberTypeVoicemail => 'Voicemail';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Telefonberechtigung';

  @override
  String get phonePermissionDescription =>
      'Wird verwendet, um eingehende Anrufe zu identifizieren und zu blockieren.';

  @override
  String get phoneRule => 'Telefonregel';

  @override
  String get phoneRuleEditDialog => 'Dialog zur Bearbeitung von Telefonregeln';

  @override
  String get phoneRuleManagement => 'Telefonregelverwaltung';

  @override
  String get phoneRuleSubscription => 'Telefonregel-Abonnement';

  @override
  String get phoneSubscription => 'Telefon-Abonnement';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Abonnieren Sie Telefonregellisten über eine URL, um Whitelist- und Blacklist-Regeln automatisch zu aktualisieren. Unterstützt Regeldateien im JSON-Format.';

  @override
  String get phoneSubscriptionTitle => 'Telefonregel-Abonnements';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Bitte wählen Sie eine Bezeichnung und geben Sie eine gültige Telefonnummer ein';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" erfolgreich hinzugefügt';
  }

  @override
  String get pluginDeleted => 'Plugin gelöscht';

  @override
  String get pluginLatestVersion => 'Plugin ist bereits die neueste Version';

  @override
  String get pluginListExportSuccess => 'Plugin-Liste erfolgreich exportiert';

  @override
  String get pluginLoadedSuccessfully => 'Plugin erfolgreich geladen';

  @override
  String get pluginManagement => 'Plugin-Verwaltung';

  @override
  String get pluginManagementSubtitle =>
      'Plugins von Drittanbietern verwalten und konfigurieren';

  @override
  String get pluginManagementTitle => 'Plugin-Verwaltung';

  @override
  String get pluginName => 'Plugin-Name';

  @override
  String get pluginNotLoaded =>
      'Plugin ist noch nicht geladen. Bitte laden Sie das Plugin zuerst.';

  @override
  String pluginsDeleted(Object count) {
    return '$count Plugins erfolgreich gelöscht.';
  }

  @override
  String get pluginService => 'Plugin-Service';

  @override
  String get pluginTestPageTitle => 'Plugin-Test';

  @override
  String get pluginUpdateSuccess => 'Plugin erfolgreich aktualisiert';

  @override
  String get pluginUrl => 'Plugin-URL';

  @override
  String get pluginUrlCannotBeEmpty => 'Plugin-URL darf nicht leer sein';

  @override
  String get pluginUrlHint => 'Plugin-URL eingeben';

  @override
  String get pluginUrlLabel => 'Plugin-URL';

  @override
  String get pluginVersion => 'Plugin-Version';

  @override
  String get political => 'Politisch';

  @override
  String get powerfulSpamBlocking => 'Leistungsstarke Spam-Blockierung';

  @override
  String get previousStep => 'Zurück';

  @override
  String get prioritizeRemoteAction =>
      'Remote-Aktionseinstellungen priorisieren';

  @override
  String get prioritizeRemoteActionDescription =>
      'Aktionseinstellungen aus der Remote-Datenbank priorisieren';

  @override
  String get processing => 'Verarbeitung...';

  @override
  String get processingOperation => 'Verarbeitung...';

  @override
  String get purchase => 'Kaufen';

  @override
  String get quarterlyMembership => 'Vierteljährliche Mitgliedschaft';

  @override
  String get quarterlyMembershipDescription =>
      'Schalten Sie alle Premium-Funktionen frei, automatische Verlängerung vierteljährlich';

  @override
  String get queryButton => 'Abfrage';

  @override
  String get queryFailed => 'Abfrage fehlgeschlagen';

  @override
  String get queryFailedLog => 'Abfrage fehlgeschlagen';

  @override
  String get querying => 'Abfrage...';

  @override
  String get queryingPhoneNumber => 'Telefonnummer wird abgefragt';

  @override
  String get queryResultTitle => 'Abfrageergebnis';

  @override
  String get ready => 'Fertig!';

  @override
  String get receiveWeeklyStatistics => 'Wöchentliche Statistiken erhalten';

  @override
  String get recruiter => 'Personalvermittler';

  @override
  String get reEnterPasswordHint => 'Bitte geben Sie das Passwort erneut ein';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get refreshPermissionStatus => 'Berechtigungsstatus aktualisieren';

  @override
  String get refreshTooltip => 'Aktualisieren';

  @override
  String regexError(Object error) {
    return 'Regex-Fehler: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex-Fehler: $error';
  }

  @override
  String get regexPattern => 'Regex-Muster';

  @override
  String get regexPatternExplanation => 'Regex-Muster Erklärung';

  @override
  String get regexPatternExplanationButton => 'Regex-Muster Erklärung';

  @override
  String get regexPatternLabel => 'Regex-Muster';

  @override
  String get regexPatternsExamples =>
      'Verwenden Sie die Standard-Regex-Syntax, um Muster zu definieren. Beispiele:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Regex-Muster für die Übereinstimmung mit Telefonnummern';

  @override
  String get regexRule => 'Regex-Regel';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Das Hinzufügen der Regex-Regel ist fehlgeschlagen: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex-Regel erfolgreich hinzugefügt';

  @override
  String get regexRuleManagement => 'Regex-Regelverwaltung';

  @override
  String get regexRuleNamePatternRequired =>
      'Regelname und Regex-Muster dürfen nicht leer sein';

  @override
  String get regexRules => 'Regex-Regeln';

  @override
  String get regexTesterTitle => 'Regex-Tester';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex-Validierung fehlgeschlagen: $error';
  }

  @override
  String get regexValidationSuccess => 'Regex-Validierung erfolgreich';

  @override
  String get region => 'Region';

  @override
  String get registeredDevicesTitle => 'Registrierte Geräte';

  @override
  String get rejectAllCalls => 'Alle Anrufe ablehnen';

  @override
  String get rejectAllCallsDescription =>
      'Wenn aktiviert, werden alle Anrufe mit höchster Priorität abgewiesen';

  @override
  String get rejectAllNumbers => 'Alle Nummern ablehnen';

  @override
  String get rejectAllNumbersDesc =>
      'Alle eingehenden Anrufe ablehnen, wenn aktiviert';

  @override
  String get rejectExceededNumbers => 'Überschrittene Nummern ablehnen';

  @override
  String get rejectExceededNumbersDescription =>
      'Automatisch Nummern ablehnen, die den Schwellenwert überschreiten';

  @override
  String get remoteFilterSettings => 'Remote-Filtereinstellungen';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Einstellungen für den Remote-Nummernfilter';

  @override
  String get remoteNumberFilter => 'Remote-Nummernfilter';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Dieser Filter verwendet eine unabhängige Remote-Datenbank, um die neuesten Nummerinformationen zu erhalten.';

  @override
  String get remoteNumberFilterDescription =>
      'Abfangen von belästigenden Anrufen basierend auf Informationen aus der Remote-Datenbank';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Der Remote-Nummernfilter identifiziert und blockiert Spam-Anrufe, indem er eine Remote-Datenbank basierend auf der Anzahl der Nummern abfragt.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Erklärung zum Remote-Nummernfilter';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Anzahl Schwellenwert: Bestimmen Sie basierend auf der Häufigkeit des Auftretens von Nummern';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Filteraktionen: Konfigurieren Sie, wie mit Nummern umgegangen werden soll, die den Schwellenwert überschreiten';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Prioritätseinstellungen: Legen Sie die Priorität für Remote-Aktionen fest';

  @override
  String get remoteNumberFilterFeatures => 'Funktionen:';

  @override
  String get remoteNumberFiltering => 'Remote-Nummernfilterung';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Remote-Nummernfilterung: Filterregeln basierend auf Informationen aus der Remote-Datenbank';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identifizieren Sie Spam-Anrufe mithilfe der Cloud-Datenbank und Community-Berichten';

  @override
  String get removeAdsDescription =>
      'Entfernen Sie dauerhaft alle Anzeigen in der App für ein reibungsloseres Erlebnis';

  @override
  String get removeAdsTitle => 'Anzeigen entfernen';

  @override
  String get removedFromFavoriteContacts =>
      'Aus den Favoritenkontakten entfernt';

  @override
  String get removedFromFavorites => 'Aus den Favoritenkontakten entfernt';

  @override
  String get removeFavorite => 'Favorit entfernen';

  @override
  String get removeFromFavorites => 'Aus Favoriten entfernen';

  @override
  String get renameButton => 'Umbenennen';

  @override
  String get renameDeviceDialogTitle => 'Gerät umbenennen';

  @override
  String get renameDeviceTitle => 'Gerät umbenennen';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Dadurch werden alle aktuellen Einstellungen ersetzt. Möchten Sie wirklich fortfahren?';

  @override
  String get requestAllPermissions => 'Alle Berechtigungen anfordern';

  @override
  String get requestPermission => 'Berechtigung anfordern';

  @override
  String requestPermissionFailed(Object error) {
    return 'Fehler beim Anfordern der Berechtigung: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Markierungen';
  }

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Anwendungseinstellungen aus Backup wiederherstellen';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Anwendungseinstellungen aus Backup wiederherstellen';

  @override
  String get restoreButton => 'Wiederherstellen';

  @override
  String restoreFailedWithError(Object error) {
    return 'Wiederherstellung aus der Cloud fehlgeschlagen: $error';
  }

  @override
  String get restoreFromCloud => 'Aus der Cloud wiederherstellen';

  @override
  String get restoreFromCloudDescription =>
      'Einstellungen und Regeln aus Cloud-Speicher wiederherstellen';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Fehler beim Wiederherstellen aus der Cloud: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Aus der Cloud wiederherstellen';

  @override
  String get restoreFromCloudSuccess =>
      'Erfolgreich aus der Cloud wiederhergestellt';

  @override
  String get restoreFromCloudTitle => 'Aus der Cloud wiederherstellen';

  @override
  String get restoreFromLocal => 'Lokal wiederherstellen';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get restoreSectionTitle => 'Wiederherstellen';

  @override
  String get restoreSettings => 'Einstellungen wiederherstellen';

  @override
  String get restoreSettingsConfirmation =>
      'Dies ersetzt alle Ihre aktuellen Einstellungen. Möchten Sie wirklich fortfahren?';

  @override
  String get restoreSettingsDialogTitle => 'Einstellungen wiederherstellen';

  @override
  String get restoreSettingsTitle => 'Einstellungen wiederherstellen';

  @override
  String get restoreSuccessFromLocal => 'Erfolgreich lokal wiederhergestellt';

  @override
  String get restoreSuccessMessage =>
      'Erfolgreich aus der Cloud wiederhergestellt';

  @override
  String get retry => 'Wiederholen';

  @override
  String get ridesharing => 'Mitfahrgelegenheit';

  @override
  String get risk => 'Risiko';

  @override
  String get robocall => 'Roboteranruf';

  @override
  String get ruleAction => 'Regelaktion';

  @override
  String get ruleAddButton => 'Regel hinzufügen';

  @override
  String get ruleAddedSuccess => 'Regel erfolgreich hinzugefügt';

  @override
  String ruleAddFailure(Object error) {
    return 'Regel konnte nicht hinzugefügt werden: $error';
  }

  @override
  String get ruleAddSuccess => 'Regel erfolgreich hinzugefügt';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Sind Sie sicher, dass Sie diese $ruleType löschen möchten?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Regel löschen';

  @override
  String get ruleDeletedSuccess => 'Regel erfolgreich gelöscht';

  @override
  String get ruleDeletedSuccessfully => 'Regel erfolgreich gelöscht';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Regel konnte nicht gelöscht werden: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Regel konnte nicht gelöscht werden: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Regel erfolgreich gelöscht';

  @override
  String get ruleDisabledSuccessfully => 'Regel erfolgreich deaktiviert';

  @override
  String get ruleEnabledSuccessfully => 'Regel erfolgreich aktiviert';

  @override
  String ruleLoadFailed(Object error) {
    return 'Regeln konnten nicht geladen werden: $error';
  }

  @override
  String get ruleManagement => 'Regelverwaltung';

  @override
  String get ruleManagementTitle => 'Regelverwaltung';

  @override
  String get ruleName => 'Regelname';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Regelname und Inhalts-Regex dürfen nicht leer sein';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Regelname und Telefonnummer dürfen nicht leer sein';

  @override
  String get ruleNameHint => 'z.B. Familie, Freunde, usw.';

  @override
  String get ruleNameLabel => 'Regelname';

  @override
  String get ruleNamePatternRequired =>
      'Bitte geben Sie einen Regelnamen und ein Muster ein';

  @override
  String get ruleNameRequired =>
      'Regelname und Telefonnummer dürfen nicht leer sein';

  @override
  String get ruleNotExist => 'Regel existiert nicht oder wurde gelöscht';

  @override
  String ruleNotFound(Object error) {
    return 'Regel nicht gefunden: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Regel erfolgreich gespeichert!';

  @override
  String get ruleSavedSuccessMessage => 'Regel erfolgreich gespeichert!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get ruleSaveSuccess => 'Regel erfolgreich gespeichert!';

  @override
  String get rulesExportedSuccessfully => 'Regeln erfolgreich exportiert';

  @override
  String rulesExportedTo(Object path) {
    return 'Regeln exportiert nach: $path';
  }

  @override
  String get rulesImported => 'Regeln erfolgreich importiert';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count Regeln erfolgreich importiert';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Fehler beim Importieren von Regeln: $error';
  }

  @override
  String get ruleStatistics => 'Regelstatistik';

  @override
  String ruleStatusChanged(Object status) {
    return 'Regel $status erfolgreich';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operation fehlgeschlagen: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Regel $status erfolgreich';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Fehler beim Aktualisieren der Regel: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Regel erfolgreich aktualisiert';

  @override
  String get ruleVerification => 'Regelüberprüfung';

  @override
  String get save => 'Speichern';

  @override
  String get saveButton => 'Speichern';

  @override
  String get saveButtonLabel => 'SPEICHERN';

  @override
  String get saveButtonText => 'Speichern';

  @override
  String saveFailed(Object error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get saveFilter => 'Filter speichern';

  @override
  String get saveSettings => 'Einstellungen speichern';

  @override
  String saveSettingsFailed(Object error) {
    return 'Fehler beim Speichern der Einstellungen: $error';
  }

  @override
  String get scamsLikely => 'Betrug wahrscheinlich';

  @override
  String get search => 'Suchen';

  @override
  String get searchContacts => 'Kontakte suchen';

  @override
  String searchError(Object error) {
    return 'Suchfehler: $error';
  }

  @override
  String get searchFilters => 'Suchfilter';

  @override
  String get searchForContacts => 'Nach Kontakten suchen';

  @override
  String get searchHint => 'Suchen...';

  @override
  String get searchSettingsSubtitle =>
      'Kontakte, Labels, Blacklists, Whitelists usw. suchen.';

  @override
  String get searchSettingsTitle => 'Sucheinstellungen';

  @override
  String get securityMessage =>
      'Vertrauen Sie keinen Anrufen. Überprüfen Sie Kundendienstnummern immer unabhängig voneinander. Geben Sie niemals Passwörter, Bestätigungscodes, Kartennummern oder persönliche Informationen weiter.';

  @override
  String get selectActionToPerform =>
      'Wählen Sie die Aktion aus, die ausgeführt werden soll, wenn die Regel übereinstimmt';

  @override
  String get selectActionWhenBlockingCalls =>
      'Aktion auswählen, wenn Anrufe blockiert werden';

  @override
  String get selectActionWhenRuleMatches =>
      'Aktion auswählen, wenn die Regel übereinstimmt';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get selectCountry => 'Land auswählen';

  @override
  String get selectDateRange => 'Zeitraum auswählen';

  @override
  String get selectedDateRange => 'Ausgewählter Zeitraum';

  @override
  String selectedItems(Object count) {
    return '$count Elemente ausgewählt';
  }

  @override
  String get selectedLabel => 'Ausgewählt:';

  @override
  String get selectExportFormat => 'Exportformat auswählen';

  @override
  String get selectLabel => 'Label auswählen';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Bitte wählen Sie ein Label aus und geben Sie eine gültige Telefonnummer ein';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get selectMultiple => 'Mehrere auswählen';

  @override
  String get selectPeriod => 'Zeitraum auswählen';

  @override
  String get selectSimCard => 'SIM-Karte auswählen';

  @override
  String get selectSimSlot => 'SIM-Slot auswählen';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Wählen Sie die spezifische Aktion aus, die beim Blockieren von Anrufen ausgeführt werden soll';

  @override
  String get selectTag => 'Tag auswählen';

  @override
  String get selectTags => 'Tags auswählen';

  @override
  String get selectTrustedDataSource =>
      'Bitte wählen Sie vertrauenswürdige Datenquellen aus';

  @override
  String get selectYourLanguage => 'Wählen Sie Ihre Sprache';

  @override
  String get sender => 'Absender';

  @override
  String get senderRegexOptional => 'Absender Regex (Optional)';

  @override
  String get serverAddressLabel => 'Serveradresse';

  @override
  String get serviceTypeContact => 'Kontakt-Abonnement';

  @override
  String get serviceTypeLabel => 'Servicetyp';

  @override
  String get serviceTypePhone => 'Telefon-Abonnement';

  @override
  String get serviceTypePlugin => 'Plugin-Update';

  @override
  String get serviceTypeSms => 'SMS-Abonnement';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Festlegen';

  @override
  String get setEncryptionPassword => 'Verschlüsselungspasswort festlegen';

  @override
  String get setEncryptionPasswordDescription =>
      'Verschlüsselungspasswort für Sicherung und Wiederherstellung festlegen';

  @override
  String get setEncryptionPasswordLabel => 'Verschlüsselungspasswort festlegen';

  @override
  String get setEncryptionPasswordTitle => 'Verschlüsselungspasswort festlegen';

  @override
  String get setPasswordButton => 'Festlegen';

  @override
  String get settings => 'Einstellungen';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Einstellungen gesichert in: $path';
  }

  @override
  String get settingsLoaded => 'Einstellungen geladen';

  @override
  String settingsLoadFailed(Object error) {
    return 'Fehler beim Laden der Einstellungen: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Einstellungen erfolgreich wiederhergestellt. Bitte starten Sie die App neu, damit die Änderungen wirksam werden.';

  @override
  String get settingsSaved => 'Einstellungen gespeichert';

  @override
  String settingsSaveFailed(Object error) {
    return 'Fehler beim Speichern der Einstellungen: $error';
  }

  @override
  String get settingsTab => 'Einstellungen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get setup => 'Einrichtung';

  @override
  String get showContactEditDialogStaticMethod =>
      'Statische Methode zur Anzeige des Kontaktbearbeitungsdialogs';

  @override
  String get showExplanation => 'Erklärung anzeigen';

  @override
  String get silence => 'Stummschalten';

  @override
  String get silenceAndNoAnswer => 'Stummschalten und nicht antworten';

  @override
  String get silenceNoAnswer => 'Stummschalten Nicht Antworten';

  @override
  String get silentCallVoiceClone => 'Stummer Anruf-Sprachklon';

  @override
  String get silentRules => 'Stille Regeln';

  @override
  String simCard(Object simNumber) {
    return 'SIM-Karte $simNumber';
  }

  @override
  String get simCardColor => 'SIM-Kartenfarbe';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM-Kartenkonfiguration: Legen Sie unabhängige Filterregeln für jede SIM-Karte fest';

  @override
  String get simCardFilterRules => 'SIM-Karten-Filterregeln';

  @override
  String get simCardFilterRulesDescription =>
      'Legen Sie verschiedene Filterregeln basierend auf SIM-Karten-Slots fest';

  @override
  String get simCardFontSize => 'SIM-Karten-Schriftgröße';

  @override
  String get simCardPosition => 'SIM-Kartenposition';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Fehler beim Laden der SIM-Karteninformationen: $error';
  }

  @override
  String get simRuleInstructions =>
      'Mit SIM-Slot-Regeln können Sie unabhängige Filterregeln für jeden SIM-Slot konfigurieren.';

  @override
  String get simRuleInstructionsTitle => 'SIM-Slot-Regeln';

  @override
  String get simRuleManagement => 'SIM-Slot-Regelverwaltung';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'Fehler beim Laden der SIM-Daten: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM-Slot-Filterkonfiguration';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Ermöglicht das Festlegen von Filterregeln nach SIM-Slot';

  @override
  String get simSlotFilterDescription =>
      'Konfigurieren Sie unabhängige Filterregeln für jede SIM-Karte:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Filtereinstellungen für SIM-Slot $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Fehler beim Laden der SIM-Slots: $error';
  }

  @override
  String get simSlotManagement => 'SIM-Slot-Verwaltung';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM-Slot-Operation fehlgeschlagen: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM-Slot-Position $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM-Slot-Regeln: Unabhängige Filterstrategien pro SIM';

  @override
  String get simSlotRuleListTitle => 'SIM-Slot-Regelliste';

  @override
  String get simSlotRuleManagement => 'SIM-Slot-Regeln';

  @override
  String get simSlotRuleManagementTitle => 'Regelverwaltung';

  @override
  String get simSlotSettings => 'SIM-Slot-Einstellungen';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM-Slot $slotNumber';
  }

  @override
  String get skip => 'Überspringen';

  @override
  String get smartCallerId => 'Intelligente Anrufererkennung';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Die SMS-Filterung hilft Ihnen, Spam-Nachrichten automatisch zu filtern und Ihre Nachrichtenliste sauber zu halten. Sie können Filterregeln und Benachrichtigungsmethoden festlegen.';

  @override
  String get smsFilterDisabled => 'SMS-Filterung deaktiviert';

  @override
  String get smsFilterEnabled => 'SMS-Filterung aktiviert';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'SMS-Filterregel erfolgreich hinzugefügt';

  @override
  String get smsFilterRules => 'SMS-Filterregeln';

  @override
  String get smsFilterSettings => 'SMS-Filtereinstellungen';

  @override
  String get smsHistory => 'SMS-Verlauf';

  @override
  String get smsManagement => 'SMS-Verwaltung';

  @override
  String get smsPermission => 'SMS-Berechtigung';

  @override
  String get smsPermissionDescription =>
      'Wird zum Filtern von Spam-Nachrichten verwendet.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS-Regel erfolgreich hinzugefügt';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS-Regel erfolgreich gelöscht';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Fehler beim Laden der SMS-Regeln: $error';
  }

  @override
  String get smsRuleManagement => 'SMS-Regelverwaltung';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS-Regeln erfolgreich nach $filePath exportiert';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'SMS-Regeln erfolgreich importiert';

  @override
  String get smsRuleSubscription => 'SMS-Regel-Abonnement';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS-Regel erfolgreich aktualisiert';

  @override
  String get smsSettingsSubtitle => 'SMS-Filterung und Keyword-Blockierung';

  @override
  String get smsSettingsTitle => 'SMS-Einstellungen';

  @override
  String get smsSubscription => 'SMS-Abonnement';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'SMS-Abonnement erfolgreich hinzugefügt';

  @override
  String get smsSubscriptionRulesDescription =>
      'Abonnieren Sie SMS-Regellisten über eine URL, die den Abgleich regulärer Ausdrücke unterstützt. Sie können Blockier- oder Zulassungsaktionen festlegen.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied =>
      'Einige Berechtigungsanfragen wurden abgelehnt';

  @override
  String get spamLikely => 'Wahrscheinlich Spam';

  @override
  String get startColor => 'Startfarbe';

  @override
  String get startDate => 'Startdatum';

  @override
  String get startUsing => 'Loslegen';

  @override
  String get statAnswered => 'Beantwortet';

  @override
  String get statBlocked => 'Blockiert';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Statische Methode, um das Anrufer-ID-Informationsdialogfeld anzuzeigen';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Statische Methode, um den Länderauswahldialog anzuzeigen';

  @override
  String get staticMethodToDisplayDialog =>
      'Statische Methode, um ein Dialogfeld anzuzeigen';

  @override
  String get statistics => 'Statistiken';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Funktion zum Exportieren von Statistiken in Kürze verfügbar';

  @override
  String get statisticsGrid => 'Statistikraster';

  @override
  String get statisticsPageTitle => 'Datenanalyse';

  @override
  String get stirColor => 'STIR-Farbe';

  @override
  String get stirFontSize => 'STIR-Schriftgröße';

  @override
  String get stirPosition => 'STIR-Position';

  @override
  String get storagePermission => 'Speicherberechtigung';

  @override
  String get storagePermissionDescription =>
      'Wird zum Speichern von Einstellungen und Regeln verwendet.';

  @override
  String get subscribe => 'Abonnieren';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Abonnement \"$name\" erfolgreich hinzugefügt';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Sind Sie sicher, dass Sie dieses Abonnement löschen möchten?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Abonnement löschen';

  @override
  String get subscriptionDeleted => 'Abonnement gelöscht';

  @override
  String get subscriptionDeletedSuccessfully =>
      'Abonnement erfolgreich gelöscht';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Fehler beim Löschen des Abonnements: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Abonnement gelöscht';

  @override
  String get subscriptionEmptyState => 'Keine Abonnements verfügbar';

  @override
  String get subscriptionEmptyText => 'Noch keine Abonnements';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Fehler beim Laden von Abonnements: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Fehler beim Laden von Abonnements: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Abonnementverwaltung';

  @override
  String get subscriptionName => 'Abonnementname';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Abonnementname und URL dürfen nicht leer sein';

  @override
  String get subscriptionNameHint => 'Abonnementname eingeben';

  @override
  String get subscriptionPageTitle => 'Abonnementverwaltung';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Fehler beim Ändern des Abonnementstatus: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Fehler beim Umschalten des Abonnementstatus: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Fehler beim Aktualisieren des Abonnements: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Abonnement erfolgreich aktualisiert';

  @override
  String get subscriptionUrl => 'Abonnement-URL';

  @override
  String get subscriptionUrlHint => 'Abonnement-URL eingeben';

  @override
  String successfullyImportedRules(Object count) {
    return '$count Regeln erfolgreich importiert';
  }

  @override
  String get supportSync => 'Synchronisierung unterstützen';

  @override
  String get survey => 'Umfrage';

  @override
  String get syncDevicesButton => 'Geräte synchronisieren';

  @override
  String get syncFailed => 'Synchronisierung fehlgeschlagen';

  @override
  String get syncFailedMessage => 'Synchronisierung fehlgeschlagen';

  @override
  String get syncFolderNameHint =>
      'Bitte geben Sie den Namen des Synchronisationsordners ein (Standard: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Name des Synchronisationsordners';

  @override
  String get synchronized => 'Synchronisiert';

  @override
  String get syncing => 'Synchronisierung...';

  @override
  String get syncNow => 'Jetzt synchronisieren';

  @override
  String get syncNowButton => 'Jetzt synchronisieren';

  @override
  String get syncStatusTitle => 'Synchronisationsstatus';

  @override
  String get syncStatusUpdatedMessage => 'Synchronisationsstatus aktualisiert';

  @override
  String get syncSuccessful => 'Synchronisierung erfolgreich';

  @override
  String get syncSuccessMessage => 'Synchronisierung erfolgreich';

  @override
  String get syncWithCloudStorage => 'Mit Cloud-Speicher synchronisieren';

  @override
  String get syncWithCloudStorageSubtitle =>
      'Mit Cloud-Speicher synchronisieren';

  @override
  String get systemFeatures => 'Systemfunktionen:';

  @override
  String get systemSettingsTitle => 'Systemeinstellungen';

  @override
  String get tabAll => 'Alle';

  @override
  String get tabAnswered => 'Angenommen';

  @override
  String get tabBlocked => 'Blockiert';

  @override
  String get tabMissed => 'Verpasst';

  @override
  String get tabOutgoing => 'Ausgehend';

  @override
  String tagLabel(String tag) {
    return 'Tag: $tag';
  }

  @override
  String get tagsUpdated => 'Tags aktualisiert';

  @override
  String get takeaway => 'Essen zum Mitnehmen';

  @override
  String get telecommunication => 'Telekommunikation';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get testConnectionButton => 'Verbindung testen';

  @override
  String get textColorsSetting => 'Text- und Beschriftungsfarben';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Diese App ist ein leistungsstarkes Tool zur Anruferkennung, mit dem Sie unerwünschte Anrufe identifizieren und blockieren können.';

  @override
  String get thisWeek => 'Diese Woche';

  @override
  String get timeInterceptor => 'Zeit-Interceptor';

  @override
  String get timeInterceptorDescription =>
      'Potenzielle Anrufe basierend auf der Anruffrequenz automatisch abfangen/zulassen';

  @override
  String get timeInterceptorExplanation =>
      '• Zeit-Interceptor: Wiederholte Anrufe innerhalb kurzer Zeit abfangen/zulassen';

  @override
  String get timeInterceptorExplanationContent =>
      'Die Funktion zur Unterdrückung häufiger Anrufe analysiert die Anruffrequenz, um häufige Spam-Anrufe automatisch zu erkennen und zu unterdrücken/zuzulassen.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Erklärung zur Anruf-Frequenzunterdrückung';

  @override
  String get timeInterceptorSettingsTitle =>
      'Einstellungen für die Anruf-Frequenzunterdrückung';

  @override
  String get timeInterceptorSubtitle =>
      'Potenzielle Spam-Anrufe basierend auf der Anruffrequenz automatisch abfangen';

  @override
  String get timeInterceptorTitle => 'Anruf-Frequenzunterdrückung aktivieren';

  @override
  String get timeWindowDescription =>
      'Legen Sie die Fenstergröße für die Zulassung wiederholter Anrufe fest. Anrufe von derselben Nummer innerhalb dieses Fensters werden zugelassen';

  @override
  String timeWindowLabel(int minutes) {
    return 'Unterdrückungszeitfenster (Minuten): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Legen Sie die Fenstergröße für die Zulassung wiederholter Anrufe fest. Anrufe von derselben Nummer innerhalb dieses Fensters werden zugelassen';

  @override
  String get today => 'Heute';

  @override
  String get total => 'Gesamt';

  @override
  String get totalBlocked => 'Gesamt blockiert';

  @override
  String get totalFiltered => 'Gesamt gefiltert';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Daten zwischen Geräten oder Plattformen übertragen';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Daten zwischen Geräten oder Plattformen übertragen';

  @override
  String get travelTicketing => 'Reisetickets';

  @override
  String get trend => 'Trend';

  @override
  String get trendChart => 'Trenddiagramm';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get type => 'Typ';

  @override
  String get unassignedSIMCard => 'Nicht zugewiesene SIM-Karte';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get unknownLabel => 'Unbekannte Bezeichnung';

  @override
  String get unknownTag => 'Tag: Unbekannt';

  @override
  String get unregisterButton => 'Abmelden';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Möchten Sie $deviceName wirklich abmelden?';
  }

  @override
  String get unregisterDeviceTitle => 'Gerät abmelden';

  @override
  String get unsupportedFileFormat => 'Nicht unterstütztes Dateiformat';

  @override
  String get update => 'Aktualisieren';

  @override
  String get updateAllNow => 'Alle jetzt aktualisieren';

  @override
  String get updateCallFilterConfig => 'Anruffilterkonfiguration aktualisieren';

  @override
  String updateContactFailed(Object error) {
    return 'Fehler beim Aktualisieren des Kontakts: $error';
  }

  @override
  String get updateFavoriteStatus => 'Favoritenstatus aktualisieren';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Fehler beim Aktualisieren des Favoritenstatus: $error';
  }

  @override
  String get updateInterval => 'Aktualisierungsintervall';

  @override
  String get updateLabelFailed => 'Fehler beim Aktualisieren der Bezeichnung';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get updatePlugin => 'Plugin aktualisieren';

  @override
  String updatePluginFailed(Object error) {
    return 'Fehler beim Aktualisieren des Plugins: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Fehler beim Aktualisieren der Regel: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Fehler beim Aktualisieren des Abonnements: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service erfolgreich aktualisiert ($count Regeln)';
  }

  @override
  String get updateTags => 'Tags aktualisieren';

  @override
  String get useCasesPoint1 =>
      '• Automatische Spam-Wählversuche identifizieren';

  @override
  String get useCasesPoint2 =>
      '• Marketinganrufe abfangen, die kurz hintereinander mehrmals anrufen';

  @override
  String get useCasesPoint3 =>
      '• Telefonbombardierung und Belästigung verhindern';

  @override
  String get useCasesTitle => 'Anwendungsfälle:';

  @override
  String get useGlobalSettings => 'Globale Einstellungen verwenden';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Benutzername';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Verwenden Sie die standardmäßige Regex-Syntax, um Muster zu definieren. Beispiele:';

  @override
  String get validateRegex => 'Regex validieren';

  @override
  String get verificationFailedText => 'Fehlgeschlagen';

  @override
  String get verifiedText => 'Verifiziert';

  @override
  String get verify => 'Verifizieren';

  @override
  String version(Object version) {
    return 'Version: $version';
  }

  @override
  String get vipExchangeDescription =>
      'VIP-Mitgliedschaft mit der Anzahl der Telefonnummernmarkierungen austauschen';

  @override
  String get vipExchangeTitle => 'Mark Exchange VIP';

  @override
  String get watchAd => 'Anzeige ansehen';

  @override
  String get watchAdForTemp => 'Anzeige für temporäre Privilegien ansehen';

  @override
  String get watchAdForTempDescription =>
      'Sehen Sie sich eine kurze Anzeige an, um einige Premium-Funktionen vorübergehend freizuschalten';

  @override
  String get webDAVConfigTitle => 'WebDAV-Konfiguration';

  @override
  String get webdavConfigurationTitle => 'WebDAV-Konfiguration';

  @override
  String get webdavPasswordHint => 'Bitte geben Sie das WebDAV-Passwort ein';

  @override
  String get webdavServerAddressHint =>
      'Bitte geben Sie die WebDAV-Serveradresse ein';

  @override
  String get webdavUsernameHint =>
      'Bitte geben Sie den WebDAV-Benutzernamen ein';

  @override
  String get week => 'Woche';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get weeklyBlockedCallsSummary =>
      'Wöchentliche Zusammenfassung blockierter Anrufe';

  @override
  String get weeklyChartTitle => 'Wöchentliche Grafik der blockierten Anrufe';

  @override
  String get weeklyReport => 'Wöchentlicher Bericht';

  @override
  String get weeklyReportDesc =>
      'Wöchentlichen zusammenfassenden Bericht über die Anrufblockierungsaktivität erhalten';

  @override
  String get welcome => 'Willkommen';

  @override
  String get whitelist => 'Whitelist';

  @override
  String get whitelistLabel => 'Whitelist';

  @override
  String get width => 'Breite';

  @override
  String get wildcardMatchingDescription =>
      'Verwenden Sie \'.\' um ein beliebiges Zeichen zu matchen (z.B. \'123.456\' matcht 123-456)';

  @override
  String get wildcardMatchingTitle => 'Platzhalter-Übereinstimmung:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Platzhalter-Unterstützung für flexible Filterung';

  @override
  String get windowSizeSetting => 'Fenstergröße';

  @override
  String get year => 'Jahr';

  @override
  String get yearly => 'Jährlich';

  @override
  String get yearlyChartTitle => 'Jährliche blockierte Anrufe';

  @override
  String get noSimCardsDetected => 'Keine SIM-Karten erkannt';

  @override
  String get filterManagementDescription => 'Anruffilter einstellen';

  @override
  String get callerIdCustomizationSubtitle => 'Anrufer-ID-Layout anpassen';

  @override
  String get fraudAlerSettingTitle => 'Betrugswarnungseinstellung';

  @override
  String get fraudAlerSettingSubtitle => 'Um Betrugswarnung einzustellen';

  @override
  String get enableFraudAlert => 'Betrugswarnung aktivieren';

  @override
  String get enableFraudAlertDescription =>
      'Warnung vor verdächtigen Betrugsanrufen';

  @override
  String get enableVibration => 'Vibration aktivieren';

  @override
  String get enableVibrationDescription =>
      'Vibrieren, wenn der Anruf als verdächtiger Betrugsanruf vermutet wird';

  @override
  String get notificationSettingsTitle => 'Benachrichtigungseinstellungen';

  @override
  String get useLocalNotification => 'Lokale Benachrichtigungen verwenden';

  @override
  String get useLocalNotificationDescription =>
      'Lokale Benachrichtigungen für eingehende Anrufe aktivieren';

  @override
  String get cancelLocalNotification => 'Lokale Benachrichtigungen schließen';

  @override
  String get useStirNotification => 'Benachrichtigung von STIR verwenden';

  @override
  String get useStirNotificationDescription =>
      'STIR-Benachrichtigungen für eingehende Anrufe aktivieren';

  @override
  String get cancelLocalNotificationDescription =>
      'Lokale Benachrichtigungen automatisch schließen';

  @override
  String get callerIdSettingsTitle => 'Anrufer-ID-Einstellungen';

  @override
  String get callerIdSettingsSubtitle =>
      'Um Benachrichtigungen für eingehende Anrufe und Anzeigemodus einzurichten';

  @override
  String get purchaseTitle => 'Kaufen';

  @override
  String get purchaseSubtitle => 'Um den Service zu kaufen';

  @override
  String get callerIdNotificationTitle => 'Eingehende Anrufinformationen';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Nummer: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Blockierter Anruf';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Blockierter Anruf von $phoneNumber';
  }

  @override
  String get stirVerified => 'Verifiziert';

  @override
  String get stirNotVerified => 'Nicht verifiziert';

  @override
  String get stirFailed => 'Verifizierung fehlgeschlagen';

  @override
  String get stirUnknown => 'Unbekannter Verifizierungsstatus';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN Verifizierung';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage für Nummer $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Einstellungen für scrollende Sicherheitsmeldungen';

  @override
  String get messageColor => 'Nachrichtenfarbe';

  @override
  String get messageFontSize => 'Nachrichtengröße';

  @override
  String get messagePosition => 'Nachrichtenposition';

  @override
  String get containerWidth => 'Containerbreite';

  @override
  String get scrollSpeed => 'Scrollgeschwindigkeit';

  @override
  String get enableSecurityMessage => 'Sicherheitsmeldung aktivieren';

  @override
  String get fraudAlertTitle => 'Betrugswarnung';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Potenzieller Betrugsanruf von $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Regeln konnten nicht geladen werden: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Anrufliste konnte nicht geladen werden: $error';
  }

  @override
  String get noBlockedTypeData =>
      'Keine Daten für den blockierten Typ verfügbar';

  @override
  String importEntity(Object entityTypeName) {
    return '$entityTypeName importieren';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName erfolgreich importiert, insgesamt $count Datensätze importiert';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Import von $entityTypeName fehlgeschlagen: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '$entityTypeName exportieren';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName erfolgreich exportiert';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Export von $entityTypeName fehlgeschlagen: $error';
  }

  @override
  String get cloudSyncService => 'Cloud-Sync-Dienst';

  @override
  String get membershipCenter => 'Mitgliedschaftszentrum';

  @override
  String get redeemVipWithMarks => 'VIP mit Punkten einlösen';

  @override
  String get currentMarkCount => 'Aktuelle Punktzahl';

  @override
  String get markMoreNumbersForMore => 'Markiere mehr Nummern für mehr Punkte';

  @override
  String get noAds => 'Keine Werbung';

  @override
  String get cloudBackup => 'Cloud-Backup';

  @override
  String get callerIdEnhancement => 'Anrufer-ID-Verbesserung';

  @override
  String get voiceRecognition => 'Spracherkennung';

  @override
  String get feature => 'Funktion';

  @override
  String get normalUser => 'Normaler Benutzer';

  @override
  String get vipUser => 'VIP-Benutzer';

  @override
  String get temporaryVip => 'Temporärer VIP';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get unknownAction => 'Unbekannte Aktion';

  @override
  String get settingsBackup => 'Einstellungen-Backup';

  @override
  String get allServicesStatusTitle => 'Aktueller Dienststatus';

  @override
  String get allServicesStatusSubtitle =>
      'Aktueller Status jedes Cloud-Dienstes';

  @override
  String get redirect => 'Weiterleiten';

  @override
  String get notify => 'Benachrichtigen';

  @override
  String get log => 'Protokollieren';

  @override
  String get custom => 'Benutzerdefiniert';

  @override
  String get allowActionDescription =>
      'Anrufe werden zugelassen, auch wenn sich die Nummer auf der Sperrliste befindet.';

  @override
  String get blockActionDescription =>
      'Anrufe werden blockiert und im Anrufprotokoll angezeigt.';

  @override
  String get silenceActionDescription =>
      'Anrufe werden stummgeschaltet, aber im Anrufprotokoll angezeigt.';

  @override
  String get noneActionDescription =>
      'Es werden keine besonderen Maßnahmen für den Anruf ergriffen.';

  @override
  String get redirectActionDescription =>
      'Leiten Sie den Anruf an eine bestimmte Nummer weiter.';

  @override
  String get labelActionDescription =>
      'Fügen Sie dem Anruf eine Kennzeichnung hinzu, um ihn leicht identifizieren zu können.';

  @override
  String get notifyActionDescription =>
      'Senden Sie eine Benachrichtigung, wenn ein Anruf empfangen wird.';

  @override
  String get logActionDescription =>
      'Protokollieren Sie die Anrufinformationen, ohne weitere Maßnahmen zu ergreifen.';

  @override
  String get customActionDescription =>
      'Führen Sie eine benutzerdefinierte Aktion aus.';

  @override
  String get synced => 'Synchronisiert';

  @override
  String get needVipAccess =>
      'Sie benötigen VIP-Zugang, um diese Funktion zu nutzen';

  @override
  String importExportDescription(Object entityTypeName) {
    return '$entityTypeName-Daten importieren oder exportieren';
  }

  @override
  String get importExportTitle => 'Import/Export';

  @override
  String get noPhoneRules => 'Keine Telefonregeln gefunden';

  @override
  String get noRegexRules => 'Keine Regex-Regeln gefunden';

  @override
  String get noAllowedBlockedRules =>
      'Keine Regeln für Erlauben/Blockieren gefunden';

  @override
  String get importExport => 'Import/Export';

  @override
  String get filterByAction => 'Nach Aktion filtern';

  @override
  String get upgradeToVip => 'Zum VIP upgraden';

  @override
  String get batteryOptimizationPermission => 'Akku-Optimierung';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Erlauben Sie der App, im Hintergrund zu laufen, um Dienste wie die Anrufer-ID bereitzustellen.';

  @override
  String get permissionTitle => 'Spezielle Berechtigungen';

  @override
  String get permissionSubtitle =>
      'Overlay- und Akkuoptimierungsberechtigungen verwalten';

  @override
  String get themeSettingsTitle => 'Themen-Einstellungen';

  @override
  String get themeSettingsSubtitle => 'Wähle dein Lieblingsthema';

  @override
  String get databaseSyncTitle => 'Datenbank-Synchronisierung';

  @override
  String get countrySyncSettingsTitle =>
      'Länderbasierte Datenbank-Synchronisierungseinstellungen';

  @override
  String get countrySyncSettingsSubtitle =>
      'Wähle Länder für die Datensynchronisierung';

  @override
  String get countryDataDisclaimer =>
      'Bitte beachten: Die Datenbank enthält möglicherweise nicht für alle spezifischen Länder oder Regionen Daten.';

  @override
  String get editSubscription => 'Abonnement bearbeiten';

  @override
  String get searchByNameOrPhoneNumber => 'Suche nach Name oder Telefonnummer';

  @override
  String get allowedBlockedRulesInfo =>
      'Zulässige/blockierte Regeln werden verwendet, um Anrufe mit bestimmten Telefonnummern abzugleichen, die die höchste Priorität haben.';

  @override
  String get searchPhoneRulesHint => 'Telefonieregeln suchen';

  @override
  String get phoneRulesInfo =>
      'Telefonregeln werden verwendet, um Anrufe mit bestimmten Telefonnummern abzugleichen, die eine niedrigere Priorität haben. Einige stammen aus den Telefonregel-Abonnements';

  @override
  String get searchSubscriptionsHint => 'Abonnements suchen';

  @override
  String get searchPluginsHint => 'Plugins suchen';

  @override
  String get searchLabelsHint => 'Labels suchen';

  @override
  String get pluginDescription => 'Plugin-Beschreibung';

  @override
  String get enterPluginDescription => 'Plugin-Beschreibung eingeben';

  @override
  String get searchRegexRulesHint => 'Regex-Regeln suchen';

  @override
  String get regexRulesInfo =>
      'Regex-Regeln werden verwendet, um Anrufe basierend auf den Regex-Mustern zu filtern.';

  @override
  String get searchMarkedPhonesHint => 'Markierte Telefone suchen';

  @override
  String get searchContactSubscriptionsHint => 'Kontakt-Abonnements suchen';

  @override
  String get showAllContacts => 'Alle Kontakte anzeigen';

  @override
  String get showFavorites => 'Favoriten anzeigen';

  @override
  String get manualEntry => 'Manuelle Eingabeinformationen';

  @override
  String get scriptSaved => 'Skript gespeichert';

  @override
  String editScriptFor(String pluginName) {
    return 'Skript bearbeiten für $pluginName';
  }

  @override
  String get saveScript => 'Skript speichern';

  @override
  String get testPlugin => 'Plugin testen';

  @override
  String get description => 'Beschreibung';

  @override
  String get accessTargetUrl => 'Ziel-URL aufrufen';

  @override
  String get result => 'Ergebnis';

  @override
  String get editScript => 'Skript bearbeiten';

  @override
  String get numberFormat => 'Zahlenformat';

  @override
  String get nationalNumber => 'Nationale Nummer';

  @override
  String get e164Number => 'E164-Nummer';

  @override
  String get pluginRulesInfo =>
      'Aus Sicherheitsgründen verwende bitte nur Plugins aus vertrauenswürdigen Quellen. Nutze gerne unsere Vorlagen, um deine eigenen benutzerdefinierten Plugins zu erstellen!';

  @override
  String get advancedMode => 'Erweiterter Modus';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Bitte gib mindestens eine Nummer ein.';

  @override
  String get openInWebView => 'In WebView öffnen';

  @override
  String get pluginLabel => 'Plugin-Label';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Nachrichten-Hintergrundfarbe';

  @override
  String get clearAllCallLogs => 'Alle Anrufprotokolle löschen';

  @override
  String get clearAllCallLogsConfirmation =>
      'Bestätigen, um alle Anrufprotokolle zu löschen';

  @override
  String get allCallLogsCleared => 'Alle Anrufprotokolle gelöscht';

  @override
  String get unblocked => 'Entblockt';

  @override
  String get blockNumber => 'Blocknummer';

  @override
  String get blockNumberSuccess => 'Blocknummer erfolgreich';

  @override
  String get blockNumberFailed => 'Blocknummer fehlgeschlagen';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Möchten Sie $phoneNumber wirklich entsperren?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Anrufen von $phoneNumber...';
  }

  @override
  String get viewDetails => 'Details anzeigen';

  @override
  String get unblock => 'Entsperren';

  @override
  String get unblockNumber => 'Nummer entsperren';

  @override
  String get unblockNumberSuccess => 'Nummer erfolgreich entsperrt';

  @override
  String get unblockNumberFailed => 'Nummer entsperren fehlgeschlagen';

  @override
  String get serviceNotAvailable => 'Dienst nicht verfügbar';

  @override
  String get callingNumberFailed => 'Anruf fehlgeschlagen';

  @override
  String get listView => 'Listenansicht';

  @override
  String get timelineView => 'Zeitachsenansicht';

  @override
  String get nameCannotBeEmpty => 'Name darf nicht leer sein';

  @override
  String get selectAction => 'Aktion auswählen';

  @override
  String get selectTargetService => 'Zieldienst auswählen';

  @override
  String get callDetails => 'Anrufdetails';

  @override
  String get callType => 'Anruftyp';

  @override
  String get callTime => 'Anrufzeit';

  @override
  String get numberInvalidFormat => 'Ungültiges Zahlenformat';

  @override
  String get membershipFeature => 'Mitgliedschaftsfunktion';

  @override
  String get medium => 'Medium';

  @override
  String get verificationReport => 'Verifizierungsbericht';

  @override
  String get finalRisk => 'Endgültiges Risiko';

  @override
  String get simState => 'SIM-Status';

  @override
  String get ipCountry => 'IP-Land';

  @override
  String get simCountry => 'SIM-Land';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Nummer übereinstimmend';

  @override
  String get support => 'Support';

  @override
  String get rewardedAdService => 'Belohnter Anzeigendienst';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Sie haben bereits VIP-Privilegien (mit Ausnahme von Anzeigen)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Sie haben bereits temporäre Privilegien, Ablaufdatum: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Sie müssen $count weitere Anzeigen ansehen, um temporäre VIP-Privilegien zu erhalten';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Ihnen wurden $days Tage temporäre Kaufprivilegien gewährt. Ablaufdatum: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Temporäres Kaufprivileg ist abgelaufen';

  @override
  String get loadingAd => 'Anzeige wird geladen...';

  @override
  String get earnedTempVip => 'Temporärer VIP verdient';

  @override
  String get vipExchangeService => 'VIP-Austauschdienst';

  @override
  String get marksInsufficient => 'Nicht genügend Punkte zum Umtauschen';

  @override
  String get invalidExchangeRule => 'Ungültige Austauschregel';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Erfolgreich gegen $description eingetauscht, Ablaufdatum: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Austausch fehlgeschlagen: $error';
  }

  @override
  String get vip3DaysWithAds =>
      '3 Tage VIP mit Anzeigen (nur Synchronisierung)';

  @override
  String get vip5DaysNoAds => '5 Tage voll ausgestattetes werbefreies VIP';

  @override
  String get vip7DaysNoAds => '7 Tage voll ausgestattetes werbefreies VIP';

  @override
  String get noNotifications => 'Keine Benachrichtigungen';

  @override
  String get clearAllNotifications => 'Alle Benachrichtigungen löschen';

  @override
  String get clearAllNotificationsConfirmation =>
      'Bestätigen, um alle Benachrichtigungen zu löschen';

  @override
  String get allNotificationsCleared => 'Alle Benachrichtigungen gelöscht';

  @override
  String get clearButton => 'Leeren';

  @override
  String get justNow => 'Gerade eben';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vor $count Minuten',
      one: 'Vor 1 Minute',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vor $count Stunden',
      one: 'Vor 1 Stunde',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vor $count Tagen',
      one: 'Vor 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Gestern';

  @override
  String get deletionProposal => 'Löschvorschlag';

  @override
  String get deletionProposals => 'Löschvorschläge';

  @override
  String get createProposal => 'Vorschlag erstellen';

  @override
  String get createProposalTitle => 'Löschvorschlag erstellen';

  @override
  String get reason => 'Grund';

  @override
  String get reasonOutdated => 'Veraltete Nummer';

  @override
  String get reasonPrivacy => 'Datenschutzbedenken';

  @override
  String get reasonNotInService => 'Nicht im Dienst';

  @override
  String get reasonWronglyIdentified => 'Falsch identifiziert';

  @override
  String get reasonInaccurateInfo => 'Ungenau Informationen';

  @override
  String get reasonWrongMarked => 'Falsch markiert';

  @override
  String get reasonOther => 'Andere';

  @override
  String get submit => 'Absenden';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get proposalStatus => 'Status';

  @override
  String get statusPending => 'Ausstehend';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusCompleted => 'Abgeschlossen';

  @override
  String get statusExpired => 'Abgelaufen';

  @override
  String get riskLevel => 'Risikostufe';

  @override
  String get riskLevelVerified => 'Verifiziert';

  @override
  String get riskLevelLow => 'Niedrig';

  @override
  String get riskLevelHigh => 'Hoch';

  @override
  String get riskLevelUnknown => 'Unbekannt';

  @override
  String get votingProgress => 'Fortschritt der Abstimmung';

  @override
  String agreeVotes(int count) {
    return 'Zustimmen: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Ablehnen: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Gesamt: $count';
  }

  @override
  String get voteAgree => 'Zustimmen';

  @override
  String get voteDisagree => 'Ablehnen';

  @override
  String createdAt(String date) {
    return 'Erstellt: $date';
  }

  @override
  String get showReport => 'Bericht anzeigen';

  @override
  String get hideReport => 'Bericht ausblenden';

  @override
  String get proposalStatistics => 'Vorschlagsstatistik';

  @override
  String get totalProposals => 'Gesamtzahl der Vorschläge';

  @override
  String get activeProposals => 'Aktive Vorschläge';

  @override
  String get completedProposals => 'Abgeschlossene Vorschläge';

  @override
  String get myVotes => 'Meine Stimmen';

  @override
  String get proposalCreated => 'Vorschlag erfolgreich erstellt';

  @override
  String get proposalCreateFailed => 'Fehler beim Erstellen des Vorschlags';

  @override
  String get voteSubmitted => 'Stimme erfolgreich abgegeben';

  @override
  String get voteSubmitFailed => 'Fehler beim Abgeben der Stimme';

  @override
  String get noProposalsFound => 'Keine Vorschläge gefunden';

  @override
  String get loadingProposals => 'Vorschläge werden geladen...';

  @override
  String get refreshProposals => 'Vorschläge aktualisieren';

  @override
  String get totalPendingProposals => 'Anzahl der ausstehenden Vorschläge';

  @override
  String get highRisk => 'Hohes Risiko';

  @override
  String get mediumRisk => 'Mittleres Risiko';

  @override
  String get lowRisk => 'Geringes Risiko';

  @override
  String get communityImpact => 'Auswirkung auf die Community';

  @override
  String get criticalIssues => 'Kritische Probleme';

  @override
  String get communityParticipation => 'Beteiligung der Community';

  @override
  String get noActivity => 'Keine Aktivität';

  @override
  String get low => 'Niedrig';

  @override
  String get moderate => 'Mäßig';

  @override
  String get high => 'Hoch';

  @override
  String get veryHigh => 'Sehr hoch';

  @override
  String get voted => 'Abgestimmt';

  @override
  String get communityVotes => 'Community-Abstimmungen';

  @override
  String get waitingForMoreVotes => 'Warten auf weitere Community-Abstimmungen';

  @override
  String get proposalProcessed => 'Dieser Vorschlag wurde bearbeitet';

  @override
  String get supported => 'UNTERSTÜTZT';

  @override
  String get opposed => 'ABGELEHNT';

  @override
  String get approved => 'GENEHMIGT';

  @override
  String get rejected => 'ABGELEHNT';

  @override
  String get completed => 'ABGESCHLOSSEN';

  @override
  String get pending => 'AUSSTEHEND';

  @override
  String get critical => 'Kritisch';

  @override
  String get oppose => 'Ablehnen';

  @override
  String get veryLow => 'Sehr niedrig';

  @override
  String get deletionProposalNotificationDescription =>
      'Benachrichtigungen über Abstimmungsergebnisse und Aktualisierungen von Löschungsvorschlägen.';

  @override
  String get deletionProposalCreated => 'Löschungsvorschlag erstellt';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Ihr Löschungsvorschlag für $phoneNumber wurde zur Überprüfung durch die Community eingereicht.';
  }

  @override
  String get proposalApproved => 'Vorschlag genehmigt ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Der Löschungsvorschlag für $phoneNumber wurde von der Community genehmigt ($supportPercentage% Unterstützung, $totalVotes Stimmen).';
  }

  @override
  String get proposalRejected => 'Vorschlag abgelehnt ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Der Löschungsvorschlag für $phoneNumber wurde von der Community abgelehnt ($supportPercentage% Unterstützung, $totalVotes Stimmen).';
  }

  @override
  String get communityVotingStarted => 'Community-Abstimmung gestartet';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Ein neuer Löschungsvorschlag für $phoneNumber ist jetzt für die Community-Abstimmung geöffnet.';
  }

  @override
  String get votingCompleted => 'Abstimmung abgeschlossen';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Die Community-Abstimmung für $phoneNumber ist beendet. Ergebnis: $result ($supportPercentage% Unterstützung).';
  }

  @override
  String get newVoteReceived => 'Neue Stimme erhalten';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Jemand hat für $voteType der Löschung von $phoneNumber gestimmt. Aktuelle Stimmen: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Fehler beim Laden der Stimmenanzahl';

  @override
  String get voteCount => 'Stimmenanzahl';

  @override
  String get deletionProposalInfo => 'Informationen zum Löschungsvorschlag';

  @override
  String get deletionProposalDescription =>
      'Schlagen Sie Nummern zur Löschung vor, die gegen die Community-Richtlinien verstoßen. Ihre Teilnahme trägt zur Sicherheit der Plattform bei.';

  @override
  String get voteToEarnVip =>
      'Stimmen Sie über Vorschläge ab, um VIP-Privilegien zu verdienen!';

  @override
  String get voteFailed => 'Abstimmung fehlgeschlagen';

  @override
  String get searchProposals => 'Vorschläge suchen';

  @override
  String get defaultNotifications => 'Standardbenachrichtigungen';

  @override
  String get defaultNotificationsDescription =>
      'Standardbenachrichtigungskanal für die App.';

  @override
  String get blockedCallNotifications =>
      'Benachrichtigungen über blockierte Anrufe';

  @override
  String get blockedCallNotificationsDescription =>
      'Zeigt Informationen über blockierte Anrufe an.';

  @override
  String get stirVerification => 'STIR/SHAKEN-Verifizierung';

  @override
  String get stirVerificationDescription =>
      'Zeigt die STIR/SHAKEN-Verifizierungsergebnisse für Nummern an.';

  @override
  String get fraudAlerts => 'Betrugswarnungen';

  @override
  String get fraudAlertsDescription =>
      'Zeigt Warnungen für potenziell betrügerische Anrufe an.';

  @override
  String get notificationFrequencyDescription =>
      'Wählen Sie aus, wie oft Sie Benachrichtigungen über neue Löschvorschläge erhalten möchten. Sie können sie sofort, in Batches oder in einem benutzerdefinierten Intervall erhalten.';

  @override
  String get immediateNotifications => 'Sofort';

  @override
  String get immediateNotificationsDescription =>
      'Erhalten Sie eine Benachrichtigung, sobald ein Vorschlag erstellt wurde.';

  @override
  String get batchNotifications => 'Gebündelt';

  @override
  String get batchNotificationsDescription =>
      'Erhalten Sie regelmäßig eine Zusammenfassung der Benachrichtigungen.';

  @override
  String get customNotifications => 'Benutzerdefiniert';

  @override
  String get customNotificationsDescription =>
      'Definieren Sie Ihr eigenes Intervall für den Empfang von Benachrichtigungen.';

  @override
  String get customFrequency => 'Benutzerdefinierte Frequenz';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours Std.';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String get pendingProposals => 'Ausstehende Vorschläge';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausstehende Vorschläge',
      one: '1 ausstehenden Vorschlag',
      zero: 'keine ausstehenden Vorschläge',
    );
    return 'Sie haben $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Richtlinien';

  @override
  String get reportingGuidelines =>
      '• Melden Sie nur Nummern, die wirklich problematisch sind\n• Geben Sie genaue und detaillierte Gründe an\n• Wählen Sie das geeignete Risikoniveau basierend auf der Schwere des Problems\n• Falsche Berichte können zu Kontobeschränkungen führen';

  @override
  String get riskLevelLabel => 'Risikoniveau';

  @override
  String get riskLevelDescription => 'Risikoniveau der Nummer';

  @override
  String get phoneNumberMinDigits =>
      'Die Telefonnummer muss mindestens 7 Ziffern haben';

  @override
  String get provideDetailedExplanation =>
      'Geben Sie eine detaillierte Erklärung an (mindestens 10 Zeichen)';

  @override
  String get reasonMinCharacters =>
      'Der Grund muss mindestens 10 Zeichen lang sein';

  @override
  String get countryCodeTwoLetters => 'Ländercode (ISO 3166-1 Alpha-2) *';

  @override
  String get countryCodeLabel => 'Ländercode (ISO 3166-1 Alpha-2) *';

  @override
  String get countryCodeHint => 'z. B. US, CN, GB';

  @override
  String get countryCodeRequired => 'Ländercode ist erforderlich';

  @override
  String get countryCodeLengthError =>
      'Der Ländercode muss 2 Buchstaben lang sein';

  @override
  String get phoneNumberLengthError =>
      'Die Telefonnummer muss mindestens 7 Ziffern lang sein';

  @override
  String get reasonHint =>
      'Geben Sie eine detaillierte Erklärung an (mindestens 10 Zeichen)';

  @override
  String get reasonRequired => 'Grund ist erforderlich';

  @override
  String get reasonLengthError =>
      'Der Grund muss mindestens 10 Zeichen lang sein';

  @override
  String get guidelinesTitle => 'Richtlinien';

  @override
  String get guidelinesText =>
      '• Melden Sie nur Nummern, die wirklich problematisch sind\n• Geben Sie genaue und detaillierte Gründe an\n• Wählen Sie das geeignete Risikoniveau basierend auf der Schwere des Problems\n• Falsche Berichte können zu Kontobeschränkungen führen';

  @override
  String get riskLevelCritical => 'Kritisch';

  @override
  String get riskLevelMedium => 'Mittel';

  @override
  String get riskLevelVeryLow => 'Sehr niedrig';

  @override
  String get riskDescriptionVeryLow =>
      'Sehr niedrig - Geringfügige Belästigung, seltene Anrufe';

  @override
  String get riskDescriptionLow =>
      'Niedrig - Gelegentliche unerwünschte Anrufe';

  @override
  String get riskDescriptionMedium =>
      'Mittel - Regelmäßiger Spam oder Telemarketing';

  @override
  String get riskDescriptionHigh =>
      'Hoch - Anhaltende Belästigung oder Betrugsversuche';

  @override
  String get riskDescriptionCritical =>
      'Kritisch - Gefährliche Betrügereien oder Drohungen';

  @override
  String get notificationFrequencyTitle => 'Benachrichtigungshäufigkeit';

  @override
  String get notificationFrequencyLabel =>
      'Benachrichtigungshäufigkeit (Stunden)';

  @override
  String errorMessage(String error) {
    return 'Fehler: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Stimmen: $totalVotes ($supportPercentage% Unterstützung)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Unterstützung ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Ablehnung ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Gerade eben';

  @override
  String timeMinutesAgo(int minutes) {
    return 'Vor $minutes Min.';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'Vor $hours Std.';
  }

  @override
  String timeDaysAgo(int days) {
    return 'Vor $days T.';
  }

  @override
  String get notificationFrequencyHours =>
      'Benachrichtigungshäufigkeit (Stunden)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes Stimmen ($supportPercentage% Unterstützung)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Stunden',
      one: '1 Stunde',
      zero: '0 Stunden',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Wichtiger Hinweis';

  @override
  String get dataSourceDisclaimer =>
      'Die Zahlen stammen aus dem Internet und von Benutzereingaben. Wir können nicht garantieren, dass eine einmal gelöschte Zahl nicht von anderen Benutzern oder Quellen erneut eingereicht wird. Bitte suchen und überprüfen Sie Informationen aktiv.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Standort';

  @override
  String get simCardTitle => 'SIM-Karte';

  @override
  String get liveActivitiesSettingsTitle => 'Live-Aktivitäten Einstellungen';

  @override
  String get elementsSettingsTitle => 'Elementeinstellungen';

  @override
  String get liveActivityMode => 'Live-Aktivität';

  @override
  String get liveActivityModeDescription =>
      'Zeigt Anrufinformationen als persistente Benachrichtigung auf dem Sperrbildschirm und in der Dynamic Island (iOS) an.';

  @override
  String get phoneNumberType => 'Telefonnummerntyp';

  @override
  String get liveActivitiesTestEndActivity => 'Aktivität beenden';

  @override
  String get liveActivitiesTestSendNewActivity => 'Neue Aktivität senden';

  @override
  String get liveActivitiesTestUpdateActivity => 'Aktivität aktualisieren';

  @override
  String get liveActivityControlsTitle => 'Live-Aktivitätssteuerung';

  @override
  String get liveActivitiesTestTitle => 'Live-Aktivitäten Test';

  @override
  String get liveActivitiesTestSubtitle =>
      'Testen Sie die Live-Aktivitätsbenachrichtigung.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Live-Benachrichtigungsanpassung';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Passen Sie das Aussehen von Live-Benachrichtigungen an.';

  @override
  String get notification_instructions =>
      'Anleitung:\n1. Tippen Sie auf \"SENDEN\", um eine Benachrichtigung zu erstellen oder zu aktualisieren.\n2. Gehen Sie zu Ihrem Startbildschirm oder ziehen Sie die Benachrichtigungsleiste herunter, um das Ergebnis zu sehen.\n3. Tippen Sie auf \"BEENDEN\", um die Benachrichtigung zu entfernen.';

  @override
  String get autoCancelNotification =>
      'Automatische Benachrichtigung stornieren';

  @override
  String get autoCancelNotificationDescription =>
      'Wenn diese Option aktiviert ist, wird die Benachrichtigung automatisch geschlossen, wenn der Benutzer darauf tippt.';

  @override
  String get setDelayTime => 'Verzögerungszeit einstellen';

  @override
  String get proposalDetails => 'Details zum Vorschlag';

  @override
  String get filterByStatus => 'Nach Status filtern';

  @override
  String get proposalNotFound => 'Vorschlag nicht gefunden';

  @override
  String get processed => 'Verarbeitet';

  @override
  String get showAll => 'Alle anzeigen';

  @override
  String get filterAndSortTitle => 'Filtern und Sortieren';

  @override
  String get filterVerifiedOwner => 'Verifizierten Eigentümer filtern';

  @override
  String get filterBy => 'Filtern nach';

  @override
  String get sortOldest => 'Älteste zuerst';

  @override
  String get sortNewest => 'Neueste zuerst';

  @override
  String get sortMostPopular => 'Beliebteste zuerst';

  @override
  String get sortLeastPopular => 'Unbeliebteste zuerst';

  @override
  String get sortBy => 'Sortieren nach';

  @override
  String get simRulesNotFound => 'SIM-Regeln nicht gefunden';

  @override
  String get simSlotRules => 'SIM-Slot-Regeln';

  @override
  String get noSimCardDetected => 'Keine SIM-Karte erkannt';

  @override
  String get invalidSimData => 'Ungültige SIM-Daten';

  @override
  String get simCardData => 'SIM-Kartendaten';

  @override
  String get simSlot => 'SIM-Slot';

  @override
  String get enableFiltering => 'Filterung aktivieren';

  @override
  String get detailedSettingsTitle => 'Detaillierte Einstellungen';

  @override
  String get entryPointViewTitle => 'Einstiegspunkt-Ansicht';

  @override
  String get callTypeRejected => 'Abgelehnt';

  @override
  String get callTypeSilenced => 'Stummgeschaltet';

  @override
  String get callTypeVoicemail => 'Mailbox';

  @override
  String get callTypeUnknownIntercept => 'Unbekannt abgefangen';

  @override
  String andMoreItems(int count) {
    return 'und $count weitere Elemente';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Cloud Sync Settings';

  @override
  String get localDatabaseSyncDescription =>
      'Connect your personal Supabase database to sync data across devices.';

  @override
  String get supabaseProjectUrl => 'Supabase Project URL';

  @override
  String get supabaseAnonKey => 'Anon Key';

  @override
  String get supabaseAnonKeyHint => 'API Key, anon public key';

  @override
  String get connectionString => 'Connection String (URI)';

  @override
  String get connectionStringHelper =>
      'Only needed for \'Initialize Database\'';

  @override
  String get syncCallHistory => 'Sync Call History';

  @override
  String get syncCallHistorySubtitle => 'Include private call logs in sync';

  @override
  String get requiredField => 'Required';

  @override
  String get requiredInitField => 'Required for initialization';

  @override
  String get initDbButton => 'Initialize Database';

  @override
  String get dbInitSuccess => 'Database Initialized Successfully!';

  @override
  String syncSuccess(int pushed, int pulled) {
    return 'Sync Complete. Sent: $pushed, Received: $pulled';
  }

  @override
  String get errorPrefix => 'Error';

  @override
  String get errorLoadingSettings => 'Error loading settings';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusConnected => 'Connected / Configured';

  @override
  String get statusNotConfigured => 'Not Configured';

  @override
  String get configSaved => 'Configuration Saved!';

  @override
  String get masterDeviceLabel => 'Is Master Device (Admin)';

  @override
  String get masterDeviceHelp =>
      'Only the master device can initialize the database structure.';

  @override
  String get syncIntervalLabel => 'Auto-sync Interval';

  @override
  String syncIntervalValue(int hours) {
    return 'Every $hours hours';
  }
}
