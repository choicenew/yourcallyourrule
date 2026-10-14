// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get aboutContactSubscription => 'Over Contact Abonnement';

  @override
  String get aboutLabels => 'Over Labels';

  @override
  String get aboutPhoneSubscriptionRules => 'Over Telefoon Abonnementregels';

  @override
  String get aboutSmsFilter => 'Over SMS-filtering';

  @override
  String get aboutSmsSubscriptionRules => 'Over SMS-abonnementregels';

  @override
  String get aboutSubtitle => 'Applicatieversie en juridische informatie';

  @override
  String get aboutTitle => 'Over';

  @override
  String get action => 'Actie';

  @override
  String get actionAll => 'Alles';

  @override
  String get actionAllow => 'Toestaan';

  @override
  String get actionBlock => 'Blokkeren';

  @override
  String get actionFilterTitle => 'Filter op Actietype';

  @override
  String get actionFilterTooltip => 'Actie Filter';

  @override
  String get actionNone => 'Geen Actie';

  @override
  String get actionSilence => 'Stil';

  @override
  String actionTag(Object actionType) {
    return 'Actie: $actionType';
  }

  @override
  String get actionType => 'Actietype';

  @override
  String get actionUnknown => 'Onbekend';

  @override
  String get add => 'Toevoegen';

  @override
  String get addAllowedBlockedRule => 'Toestaan/Blokkeren Regel Toevoegen';

  @override
  String get addAllowSubscription => 'Toestaan Abonnement Toevoegen';

  @override
  String get addBlockSubscription => 'Blokkeren Abonnement Toevoegen';

  @override
  String get addContactButton => 'Contact Toevoegen';

  @override
  String addContactFailed(Object error) {
    return 'Contact toevoegen mislukt: $error';
  }

  @override
  String get addedToFavorites => 'Toegevoegd aan favorieten';

  @override
  String get addLabel => 'Label Toevoegen';

  @override
  String get addLabelButton => 'Label Toevoegen';

  @override
  String addLabelFailed(Object error) {
    return 'Label toevoegen mislukt: $error';
  }

  @override
  String get addName => 'Naam Toevoegen';

  @override
  String get addNoneSubscription => 'Geen Abonnement Toevoegen';

  @override
  String get addPhoneMark => 'Telefoonmarkering Toevoegen';

  @override
  String get addPhoneNumberRule => 'Telefoonnummerregel Toevoegen';

  @override
  String get addPlugin => 'Plugin Toevoegen';

  @override
  String get addPluginFailed => 'Plugin toevoegen mislukt';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Plugin toevoegen mislukt: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Plugin Toevoegen vanuit Lokaal Bestand';

  @override
  String get addPluginFromUrl => 'Plugin Toevoegen vanuit URL';

  @override
  String get addRegexRule => 'Regex Regel Toevoegen';

  @override
  String get addRule => 'Regel Toevoegen';

  @override
  String addRuleFailed(Object error) {
    return 'Regel toevoegen mislukt: $error';
  }

  @override
  String get addRuleTooltip => 'Regel Toevoegen';

  @override
  String get addSilenceSubscription => 'Stil Abonnement Toevoegen';

  @override
  String get addSmsFilterRule => 'SMS Filterregel Toevoegen';

  @override
  String get addSmsRule => 'SMS Regel Toevoegen';

  @override
  String get addSmsSubscription => 'SMS Abonnement Toevoegen';

  @override
  String get addSubscription => 'Abonnement Toevoegen';

  @override
  String get addSubscriptionButton => 'Abonnement Toevoegen';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Abonnement toevoegen mislukt: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Abonnement Toevoegen';

  @override
  String get addToBlacklist => 'Toevoegen aan Zwarte Lijst';

  @override
  String get addToFavorites => 'Toevoegen aan Favorieten';

  @override
  String get addToRules => 'Toevoegen aan Regels';

  @override
  String get addToWhitelist => 'Toevoegen aan Witte Lijst';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Alle';

  @override
  String get allCallsTab => 'Alle';

  @override
  String get allow => 'Toestaan';

  @override
  String get allowAllAllowRules => 'Alle Toestaan Regels Inschakelen';

  @override
  String get allowAllAllowRulesDesc =>
      'Hoofdschakelaar om alle geconfigureerde toestaan-regels toe te passen';

  @override
  String get allowAllBlacklistedNumbers => 'Alle Geblokkeerde Nummers Toestaan';

  @override
  String get allowAllBlockRules => 'Alle Blokkeren Regels Inschakelen';

  @override
  String get allowAllBlockRulesDesc =>
      'Hoofdschakelaar om alle geconfigureerde blokkeer-regels toe te passen';

  @override
  String get allowAllowedNumbers => 'Alle Goedgekeurde Nummers Toestaan';

  @override
  String get allowAllowedNumbersDesc =>
      'Sta alle inkomende oproepen toe van nummers op uw toestaanlijst';

  @override
  String get allowBlock => 'Toestaan/Blokkeren';

  @override
  String get allowBlockedNumbers => 'Blokkeerlijst Omzeilen';

  @override
  String get allowBlockedNumbersDesc =>
      'Tijdelijk oproepen toestaan van nummers op uw blokkeerlijst';

  @override
  String get allowedBlockedRule => 'Toestaan/Blokkeren Regel';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Bewerken Toestaan/Blokkeren Regel';

  @override
  String get allowedBlockedRuleManagement => 'Beheer Toestaan/Blokkeren Regels';

  @override
  String get allowNonExceededNumbers => 'Niet-overschreden Nummers Toestaan';

  @override
  String get allowNonExceededNumbersDescription =>
      'Sta nummers automatisch toe die de drempelwaarde niet overschrijden';

  @override
  String get allowRegexAllowRules => 'Regex Toestaan Regels Inschakelen';

  @override
  String get allowRegexAllowRulesDesc =>
      'Schakel regex patroonherkenning in voor toestaan regels';

  @override
  String get allowRegexAllowRulesDescription =>
      'Schakel regex-gebaseerde toestaan regels in';

  @override
  String get allowRegexBlockRules => 'Regex Blokkeren Regels Inschakelen';

  @override
  String get allowRegexBlockRulesDesc =>
      'Schakel regex patroonherkenning in voor blokkeren regels';

  @override
  String get allowRegexBlockRulesDescription =>
      'Schakel regex-gebaseerde blokkeren regels in';

  @override
  String get allowRule => 'Toestaan Regel';

  @override
  String get allowRules => 'Toestaan Regels';

  @override
  String get allPermissionsGranted => 'Alle machtigingen verleend';

  @override
  String get allSettingsCompleted => 'Alle instellingen voltooid.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Alle updates voltooid ($count regels)';
  }

  @override
  String get answerThenHangup => 'Antwoorden en ophangen';

  @override
  String get applicationSoftware => 'Toepassingssoftware';

  @override
  String get apply => 'Toepassen';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Autorisatie mislukt: Controleer client-ID en sleutel';

  @override
  String get authorizationFailedMessage => 'Autorisatie mislukt';

  @override
  String get authorizationSuccessMessage => 'Autorisatie succesvol';

  @override
  String get authorizeLoginButton => 'Autoriseer login';

  @override
  String get automotiveIndustry => 'Automotive industrie';

  @override
  String get autoSyncLabel => 'Automatische synchronisatie';

  @override
  String get autoUpdate => 'Automatische update';

  @override
  String get autoUpdateDescription =>
      'Stel automatische update-intervallen in voor abonnementen of werk handmatig bij';

  @override
  String get autoUpdateSettings => 'Automatische update-instellingen';

  @override
  String get autoUpdateSubtitle =>
      'Beheer automatische updates voor regels en plugins';

  @override
  String get autoUpdateTitle => 'Automatische update';

  @override
  String get avatarBorderColor => 'Avatar randkleur';

  @override
  String get avatarBorderSize => 'Avatar randgrootte';

  @override
  String get avatarIconSizesSetting => 'Avatar- & Icoongroottes';

  @override
  String get avatarPosition => 'Avatar positie';

  @override
  String get avatarSize => 'Avatar grootte';

  @override
  String axisPosition(Object axis) {
    return '$axis positie';
  }

  @override
  String get backgroundGradientSetting => 'Achtergrondverloop';

  @override
  String get backup => 'Back-up';

  @override
  String get backupAndRestore => 'Back-up en herstel';

  @override
  String get backupAndRestoreSubtitle =>
      'Back-up of herstel applicatiegegevens';

  @override
  String get backupAndRestoreTitle => 'Back-up & Herstel';

  @override
  String get backupFailed => 'Back-up mislukt';

  @override
  String get backupSettings => 'Back-upinstellingen';

  @override
  String get backupToCloud => 'Back-up naar Cloud';

  @override
  String backupToCloudFailed(Object error) {
    return 'Back-up naar cloud mislukt: $error';
  }

  @override
  String get backupToCloudSuccess => 'Succesvol geback-upt naar de cloud';

  @override
  String get bank => 'Bank';

  @override
  String get basicInfo => 'Basisgegevens';

  @override
  String get basicRuleFilter => 'Basisregel filter';

  @override
  String get basicRuleFiltering => 'Basisregel filtering';

  @override
  String get basicRuleFilteringExplanation =>
      '• Basisregel filtering: Regels filteren op basis van zwarte lijst, witte lijst en regex';

  @override
  String get basicRuleFilterSubtitle =>
      'Filter oproepen met zwarte/witte lijsten en reguliere expressies';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Weet u zeker dat u $count geselecteerde contacten wilt verwijderen?';
  }

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Weet u zeker dat u $count labels wilt verwijderen?';
  }

  @override
  String get blacklist => 'Zwarte lijst';

  @override
  String get blacklistingAndWhitelisting => 'Zwarte en witte lijsten';

  @override
  String get blackWhiteList => 'Zwarte/Witte Lijst';

  @override
  String get block => 'Blokkeren';

  @override
  String get blockCalls => 'Oproepen blokkeren';

  @override
  String get blocked => 'Geblokkeerd';

  @override
  String get blockedCalls => 'Geblokkeerde oproepen';

  @override
  String get blockedCallsTitle => 'Geblokkeerde oproepen';

  @override
  String get blockedSpamCalls => 'Geblokkeerde spamoproepen';

  @override
  String get blockingTrend => 'Blokkeringstrend';

  @override
  String get blockInternationalCalls =>
      'komt overeen met nummers die niet beginnen met + of 00';

  @override
  String get blockInternationalCallsTitle =>
      'Internationale oproepen blokkeren';

  @override
  String get blockMobileNumbers =>
      'komt overeen met nummers die niet beginnen met 13-19';

  @override
  String get blockMobileNumbersTitle => 'Mobiele nummers blokkeren';

  @override
  String get blockPremiumRateNumbers =>
      'komt overeen met nummers die niet beginnen met 118 of 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'Premium tariefnummers blokkeren';

  @override
  String get blockRule => 'Blokkeerregel';

  @override
  String get blockRules => 'Blokkeerregels';

  @override
  String get blockSpecificAreaCodes =>
      'komt overeen met nummers die beginnen met 0 + 2-3 cijfers';

  @override
  String get blockSpecificAreaCodesTitle => 'Specifieke netnummers blokkeren:';

  @override
  String get blockTypeAnalysisTitle => 'Blokkeringstype analyse';

  @override
  String get both => 'Beide';

  @override
  String get bulkDelete => 'Batch contacten verwijderen';

  @override
  String get bulkDeleteContacts => 'Batch contacten verwijderen';

  @override
  String get bulkDeleteLabels => 'Batch labels verwijderen';

  @override
  String get call => 'Oproep';

  @override
  String get callback => 'Terugbellen';

  @override
  String get callBlocking => 'Oproep blokkering';

  @override
  String get callerIdApp => 'Oproep-ID App';

  @override
  String get callerIdCustomizationTitle => 'Oproep-ID aanpassen';

  @override
  String get callerIdDisplayMode => 'Weergavemodus nummerherkenning';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Gemarkeerd door $count';
  }

  @override
  String get callerIdPreview => 'Voorbeeld nummerherkenning';

  @override
  String get callFilterRules => 'Oproepfilterregels';

  @override
  String get callFilterRulesDescription =>
      'Stel basisregels in voor het filteren van oproepen';

  @override
  String get callFilterSettings => 'Oproepfilterinstellingen';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Stel limieten voor oproepfrequentie en blokkeringsregels in';

  @override
  String get callFrequencyInterceptionTitle =>
      'Oproepfrequentie-onderschepping';

  @override
  String get callHistory => 'Oproepgeschiedenis';

  @override
  String get callHistoryInfoDesc =>
      'Hier wordt uw oproepgeschiedenis weergegeven, inclusief inkomende, uitgaande en gemiste oproepen.';

  @override
  String get callHistoryInfoTitle => 'Oproepgeschiedenis';

  @override
  String get callHistoryTab => 'Oproepgeschiedenis';

  @override
  String get callScreeningPermission => 'Toestemming oproepfiltering';

  @override
  String get callScreeningPermissionDescription =>
      'Gebruikt om spamoproepen te filteren en te blokkeren.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Toestemming oproepfiltering niet verleend, kan functionaliteit van de app beïnvloeden.';

  @override
  String get callStatistics => 'Oproepstatistieken';

  @override
  String get callTypeAnswered => 'Beantwoord';

  @override
  String get callTypeBlocked => 'Geblokkeerd';

  @override
  String get callTypeIconColor => 'Kleur icoon oproeptype';

  @override
  String get callTypeMissed => 'Gemiste oproep';

  @override
  String get callTypeOutgoing => 'Uitgaande';

  @override
  String get callTypePosition => 'Positie oproeptype';

  @override
  String get callTypeUnknown => 'Onbekend';

  @override
  String get cancelButton => 'Annuleren';

  @override
  String get carRental => 'Autoverhuur';

  @override
  String get carrier => 'Provider';

  @override
  String get carrierColor => 'Kleur provider';

  @override
  String get carrierFontSize => 'Lettergrootte provider';

  @override
  String get carrierPosition => 'Positie provider';

  @override
  String get changeLabel => 'Label wijzigen';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Wijzigen pluginstatus mislukt: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Wijzigen abonnementsstatus mislukt: $error';
  }

  @override
  String get charity => 'Liefdadigheid';

  @override
  String get chartOneWeekAgo => '1 week geleden';

  @override
  String get chartThreeDaysAgo => '3 dagen geleden';

  @override
  String get chartToday => 'Vandaag';

  @override
  String get checkFileFormat => 'Controleer bestandsformaat of -machtigingen';

  @override
  String checkPermissionFailed(Object error) {
    return 'Machtigingen controleren mislukt: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Kies de standaard onderscheppingsactie';

  @override
  String get clearFilter => 'Filter wissen';

  @override
  String get clearLabelFilterButton => 'Labelfilter wissen';

  @override
  String get closeButton => 'Sluiten';

  @override
  String get cloudSync => 'Cloudsynchronisatie';

  @override
  String get cloudSyncAndBackupTitle => 'Cloud synchronisatie & back-up';

  @override
  String get cloudSyncSettingsSubtitle =>
      'WebDAV, OneDrive en Google Drive configureren';

  @override
  String get cloudSyncSettingsTitle => 'Cloudsynchronisatie-instellingen';

  @override
  String get cloudSyncTitle => 'Cloudsynchronisatie';

  @override
  String get collection => 'Incasso';

  @override
  String get colorPickerTitle => 'Kleur kiezen';

  @override
  String get configManagement => 'Configuratiebeheer';

  @override
  String get configUpdated => 'Configuratie bijgewerkt';

  @override
  String get configurationAdvice =>
      'Door de juiste configuratie kunt u verschillende filterstrategieën instellen voor werk- en persoonlijke simkaarten.';

  @override
  String get configureBackupOptions => 'Back-upopties configureren';

  @override
  String get configureCloudSyncService =>
      'Cloudsynchronisatieservice configureren';

  @override
  String get configureCloudSyncServiceMessage =>
      'Configureer een cloudsynchronisatieservice om synchronisatie tussen meerdere apparaten mogelijk te maken.';

  @override
  String get configureSimCardFilterRules =>
      'SIM-kaartfilterregels configureren';

  @override
  String get confirm => 'Bevestigen';

  @override
  String get confirmButton => 'Bevestigen';

  @override
  String get confirmDelete => 'Bevestig Verwijderen';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Weet u zeker dat u label \"$name\" wilt verwijderen';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Weet u zeker dat u plugin \"$name\" wilt verwijderen?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Weet u zeker dat u $count plugins wilt verwijderen?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Weet u zeker dat u deze regel wilt verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Weet u zeker dat u deze sms-filterregel wilt verwijderen?';

  @override
  String get confirmDeleteSmsRule =>
      'Weet u zeker dat u deze sms-regel wilt verwijderen?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Weet u zeker dat u $name wilt verwijderen?';
  }

  @override
  String get confirmPassword => 'Wachtwoord bevestigen';

  @override
  String get connectedStatus => 'Verbonden';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Verbinding mislukt: Controleer serveradres, gebruikersnaam en wachtwoord';

  @override
  String get connectionFailedMessage => 'Verbinding mislukt';

  @override
  String get connectionStatusLabel => 'Verbindingsstatus';

  @override
  String get connectionSuccessMessage => 'Verbinding succesvol';

  @override
  String get contactAddSuccess => 'Contact succesvol toegevoegd';

  @override
  String get contactDeleted => 'Contact verwijderd';

  @override
  String get contactNameLabel => 'Naam';

  @override
  String get contactNotFound => 'Contact niet gevonden';

  @override
  String get contacts => 'Contacten';

  @override
  String contactsDeleted(Object count) {
    return '$count contacten verwijderd';
  }

  @override
  String get contactsManagement => 'Contactbeheer';

  @override
  String get contactsPermission => 'Contacten Machtiging';

  @override
  String get contactsPermissionDescription =>
      'Gebruikt om contactoproepen te identificeren.';

  @override
  String get contactsTab => 'Contacten';

  @override
  String get contactSubscriptionDescription =>
      'Abonneren op contactlijsten via URL, contactinformatie en labels automatisch bijwerken. Ondersteunt JSON-formaatgegevens.';

  @override
  String get contactUpdateSuccess => 'Contact succesvol bijgewerkt';

  @override
  String get contactUs => 'Neem contact met ons op';

  @override
  String get content => 'Inhoud';

  @override
  String get contentRegex => 'Inhoud Regex';

  @override
  String get countColor => 'Aantal Kleur';

  @override
  String get countFontSize => 'Aantal Lettergrootte';

  @override
  String get countPosition => 'Aantal Positie';

  @override
  String get country => 'Land';

  @override
  String get countryNameColor => 'Landnaam Kleur';

  @override
  String get countryNameFontSize => 'Landnaam Lettergrootte';

  @override
  String get countryRegionNamePosition => 'Land/Regio Naam Positie';

  @override
  String get countThresholdDescription =>
      'Stel de minimale drempelwaarde in die nodig is om filteracties te activeren';

  @override
  String get countThresholdLabel => 'Aantal Drempelwaarde';

  @override
  String get createdRules => 'Aan gemaakte Regels';

  @override
  String get csvFormat => 'CSV Formaat';

  @override
  String get currentDeviceLabel => 'Huidig Apparaat Label';

  @override
  String get currentDeviceTitle => 'Huidig Apparaat';

  @override
  String get currentLanguage => 'Huidige Taal';

  @override
  String get customerService => 'Klantenservice';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get dataAnalysis => 'Gegevensanalyse';

  @override
  String dataLoadFailure(Object error) {
    return 'Gegevens laden mislukt: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Gegevens laden mislukt: $error';
  }

  @override
  String get dataMigration => 'Gegevensmigratie';

  @override
  String get dataMigrationDescription =>
      'Met deze functie kunt u al uw gegevens tussen apparaten overzetten. Momenteel kunt u de back-up- en herstel functies gebruiken om uw gegevens handmatig te migreren.';

  @override
  String get dataSourceReminder => 'Gegevensbron Herinnering';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dagen',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Dagen VIP';
  }

  @override
  String get debtCollection => 'Incasso';

  @override
  String get delete => 'Verwijderen';

  @override
  String get deleteButton => 'Verwijderen';

  @override
  String get deleteContact => 'Contact Verwijderen';

  @override
  String deleteContactConfirm(Object name) {
    return 'Weet u zeker dat u $name wilt verwijderen?';
  }

  @override
  String deleteFailed(Object error) {
    return 'Verwijderen mislukt: $error';
  }

  @override
  String get deleteLabel => 'Label Verwijderen';

  @override
  String deleteLabelFailed(Object error) {
    return 'Label verwijderen mislukt: $error';
  }

  @override
  String get deletePlugin => 'Plugin Verwijderen';

  @override
  String deletePluginFailed(Object error) {
    return 'Plugin verwijderen mislukt: $error';
  }

  @override
  String get deletePlugins => 'Plugins Verwijderen';

  @override
  String deletePluginsFailed(Object error) {
    return 'Plugins verwijderen mislukt: $error';
  }

  @override
  String get deleteRule => 'Regel Verwijderen';

  @override
  String deleteRuleFailed(Object error) {
    return 'Verwijderen mislukt: $error';
  }

  @override
  String get deleteSelected => 'Geselecteerde Verwijderen';

  @override
  String get deleteSubscription => 'Abonnement Verwijderen';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Weet u zeker dat u abonnement \"$name\" wilt verwijderen?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Abonnement verwijderen mislukt: $error';
  }

  @override
  String get deleteSuccess => 'Verwijderen succesvol';

  @override
  String get delivery => 'Levering';

  @override
  String get deviceIDLabel => 'Apparaat ID';

  @override
  String get deviceManagementSubtitle =>
      'Beheer synchronisatie van meerdere apparaten';

  @override
  String get deviceManagementTitle => 'Apparaatbeheer';

  @override
  String get deviceModelLabel => 'Apparaat Model';

  @override
  String get deviceName => 'Apparaatnaam';

  @override
  String get deviceNameLabel => 'Apparaatnaam';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Apparaat succesvol hernoemd';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Apparaten succesvol gesynchroniseerd';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Apparaat succesvol gederegistreerd';

  @override
  String get dialogTitle => 'Uitleg Regex Patronen';

  @override
  String get differentFromLocalCounter =>
      'Deze functie verschilt van het lokale tellerfilter, omdat deze zich richt op herhaalde oproeppatronen in korte tijd, in plaats van langdurige markeertellingen.';

  @override
  String get disabled => 'Uitgeschakeld';

  @override
  String get disabledStatus => 'Uitgeschakeld';

  @override
  String get disableGlobalPlugins => 'Globale plugins uitschakelen';

  @override
  String get disconnectButton => 'Verbinding verbreken';

  @override
  String get disconnectedMessage => 'Verbinding verbroken';

  @override
  String get disconnectedStatus => 'Verbinding verbroken';

  @override
  String get disconnectFailedMessage => 'Verbinding verbreken mislukt';

  @override
  String get done => 'Gereed';

  @override
  String get dualSimAdvice =>
      'Deze functie is met name handig voor dual-SIM telefoons om verschillende filterstrategieën in te stellen voor werk- en privé-SIM-kaarten.';

  @override
  String get earlier => 'Eerder';

  @override
  String get ecommerce => 'E-commerce';

  @override
  String get edit => 'Bewerken';

  @override
  String get editContact => 'Contact bewerken';

  @override
  String get editLabel => 'Label bewerken';

  @override
  String get editPhoneRule => 'Telefoonregel bewerken';

  @override
  String get editRule => 'Regel bewerken';

  @override
  String get education => 'Onderwijs';

  @override
  String get elementPositionsSetting => 'Elementposities';

  @override
  String get email => 'E-mail';

  @override
  String get enableCallFilter => 'Oproepfilter inschakelen';

  @override
  String get enableCallFilterDescription =>
      'Wanneer ingeschakeld, worden inkomende oproepen gecontroleerd aan de hand van de onderstaande regellijst. Oproepfilterregels worden standaard niet gesynchroniseerd tussen apparaten.';

  @override
  String get enabled => 'Ingeschakeld';

  @override
  String get enabledStatus => 'Ingeschakeld';

  @override
  String get enableEncryption => 'Encryptie inschakelen';

  @override
  String get enableEncryptionDescription => 'Back-upbestanden versleutelen';

  @override
  String get enableGlobalPlugins => 'Globale plugins inschakelen';

  @override
  String get enableLocalCountFilter =>
      'Bescherming Lokale Markeringsdrempel Inschakelen';

  @override
  String get enableLocalCountFilterDescription =>
      'Blokkeer inkomende oproepen wanneer het aantal lokale meldingen de drempel overschrijdt';

  @override
  String get enableLocalNotification => 'Lokale melding gebruiken';

  @override
  String get enableLocalNotificationDescription =>
      'Wanneer ingeschakeld, worden meldingen voor gefilterde berichten op het apparaat weergegeven';

  @override
  String get enableLocationSummary => 'Locatie';

  @override
  String get enableMuteRules => 'Onderschept Oproepen Dempen';

  @override
  String get enableMuteRulesDesc =>
      'Demp de beltoon voor onderschept oproepen in plaats van te weigeren';

  @override
  String get enableNoneActionRules =>
      'Alleen Loggen & Markeren (Geen Onderschepping)';

  @override
  String get enableNoneActionRulesDesc =>
      'Oproepmatches loggen en markeren zonder onderscheppingsactie uit te voeren';

  @override
  String get enableRemoteNumberFilter =>
      'Bescherming Cloud Query Drempel Inschakelen';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Blokkeer inkomende oproepen wanneer het aantal cloud query meldingen de drempel overschrijdt';

  @override
  String get enableRule => 'Regel inschakelen';

  @override
  String get enableSmsFilter => 'Sms-filtering inschakelen';

  @override
  String get enableSmsFilterDescription =>
      'Wanneer ingeschakeld, worden berichten automatisch gefilterd volgens de regels';

  @override
  String get enableTimeInterception => 'Tijdonderschepping inschakelen';

  @override
  String get enableTimeInterceptionDescription =>
      'Blokkeer herhaalde oproepen van hetzelfde nummer binnen korte tijd';

  @override
  String get enableTimeInterceptor => 'Tijdonderschepper inschakelen';

  @override
  String get endCallImmediately => 'Onmiddellijk Blokkeren';

  @override
  String get endColor => 'Eindkleur';

  @override
  String get endDate => 'Einddatum';

  @override
  String get enhancedFilterInstructionsTitle => 'Verbeterd filtersysteem';

  @override
  String get enhancedFilterSettings => 'Instellingen voor verbeterd filter';

  @override
  String get enhancedFilterSettingsTitle =>
      'Instellingen voor verbeterd filter';

  @override
  String get enhancedFilterSystemDescription =>
      'Het verbeterde filtersysteem ondersteunt zowel globale regels als filterconfiguraties per SIM-kaart.';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Voer zowel een telefoonnummer als een regex-patroon in.';

  @override
  String get enterContactName => 'Voer de contactnaam in';

  @override
  String get enterDeviceName => 'Apparaatnaam invoeren';

  @override
  String get enterEmailOptional => 'Voer e-mailadres in (optioneel)';

  @override
  String get enterEncryptionPasswordHint => 'Voer versleutelingswachtwoord in';

  @override
  String get enterIconCode => 'Voer icooncode in';

  @override
  String get enterName => 'Voer contactnaam in';

  @override
  String get enterNewDeviceNameHint =>
      'Voer een nieuwe naam in voor dit apparaat';

  @override
  String get enterPasswordAgain => 'Voer wachtwoord opnieuw in';

  @override
  String get enterPhoneNumber => 'Voer telefoonnummer in';

  @override
  String get enterPhoneNumberHint => 'Voer telefoonnummer in om te testen';

  @override
  String get enterPhoneNumberMultiple =>
      'Voer telefoonnummer in, meerdere nummers gescheiden door komma\'s';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Voer telefoonnummer in om de zoekopdracht te starten';

  @override
  String get enterPhoneNumberToVerify =>
      'Voer telefoonnummer in om te verifiëren';

  @override
  String get enterPluginName => 'Voer plug-in naam in';

  @override
  String get enterPluginUrl => 'Voer plug-in URL-adres in';

  @override
  String get enterRegexHint => 'Voer regex-patroon in';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Voer zowel regelnaam als regex-patroon in.';

  @override
  String get enterRuleNameHint => 'Voer regelnaam in';

  @override
  String get enterSearchContent => 'Voer zoekinhoud in';

  @override
  String get enterSubscriptionName => 'Voer abonnementsnaam in';

  @override
  String get enterSubscriptionUrl => 'Voer abonnements-URL in';

  @override
  String get enterSyncFolderNameHint =>
      'Voer mapnaam voor synchronisatie in (standaard: NotificationManager)';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get enterValidNameAndUrl => 'Voer geldige naam en URL in';

  @override
  String get enterValidUrl => 'Voer geldige URL in';

  @override
  String get enterVersion => 'Voer versie in';

  @override
  String get enterWebDAVPasswordHint => 'Voer WebDAV-wachtwoord in';

  @override
  String get enterWebDAVServerAddressHint => 'Voer WebDAV-serveradres in';

  @override
  String get enterWebDAVUsernameHint => 'Voer WebDAV-gebruikersnaam in';

  @override
  String errorOccurredMessage(Object error) {
    return 'Er is een fout opgetreden: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Fout bij het hernoemen van apparaat: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Fout bij het synchroniseren van apparaten: $error';
  }

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Fout bij het de-registreren van apparaat: $error';
  }

  @override
  String get exampleBlock400Prefix => 'bv. Blokkeer 400-prefixnummers';

  @override
  String get exampleBlockMarketingSms => 'bv. Blokkeer marketing-sms\'en';

  @override
  String get exampleContentRegexHint => 'Voorbeeld Content Regex';

  @override
  String get exampleCouponPromotionDiscount =>
      'bv. .*(coupon|promotie|korting).*';

  @override
  String get exampleFamilyFriends => 'bv. Familie, Vrienden, etc.';

  @override
  String get examplePhoneNumber => 'bv. 10086, 12345, etc.';

  @override
  String get exampleRegex400Prefix => 'Voorbeeld regex voor 400-prefix';

  @override
  String get exampleSenderRegexHint => 'Voorbeeld';

  @override
  String get exchange => 'Uitwisselen';

  @override
  String get exchangeNow => 'Nu uitwisselen';

  @override
  String get exchangeVip => 'VIP uitwisselen';

  @override
  String expiryTime(Object time) {
    return 'Vervaltijd: $time';
  }

  @override
  String get export => 'Exporteren';

  @override
  String get exportAllApplicationSettings => 'Alle app-instellingen exporteren';

  @override
  String get exportAllRuleConfigurations =>
      'Alle regelconfiguraties exporteren';

  @override
  String get exportConfig => 'Configuratie exporteren';

  @override
  String get exportContacts => 'Contacten exporteren';

  @override
  String get exportData => 'Gegevens exporteren';

  @override
  String get exportFailed => 'Exporteren mislukt';

  @override
  String get exportFailure => 'Configuratie niet kunnen exporteren';

  @override
  String get exportFeatureComingSoon => 'Exportfunctie binnenkort beschikbaar';

  @override
  String get exportLabels => 'Labels exporteren';

  @override
  String exportLabelsFailed(Object error) {
    return 'Labels niet kunnen exporteren: $error';
  }

  @override
  String get exportPluginList => 'Pluginlijst exporteren';

  @override
  String exportPluginListFailed(Object error) {
    return 'Pluginlijst niet kunnen exporteren: $error';
  }

  @override
  String get exportRules => 'Regels exporteren';

  @override
  String get exportSmsRules => 'SMS-regels exporteren';

  @override
  String get exportStatisticsData => 'Statistieken exporteren';

  @override
  String get exportSuccesslly => 'Configuratie succesvol geëxporteerd';

  @override
  String failedToAddRule(Object error) {
    return 'Regel niet kunnen toevoegen: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS-abonnement niet kunnen toevoegen: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Instellingen niet kunnen back-uppen: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Back-upbestand niet kunnen ontsleutelen';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS-regel niet kunnen verwijderen: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Regels niet kunnen exporteren: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Info over beller-ID niet kunnen ophalen: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Regels niet kunnen importeren: $error';
  }

  @override
  String get failedToRestoreSettings => 'Instellingen niet kunnen herstellen';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Instellingen niet kunnen herstellen: $error';
  }

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Regelstatus niet kunnen wisselen: $error';
  }

  @override
  String get favoriteContacts => 'Favoriete contacten';

  @override
  String get featureAddRules =>
      '• Specifieke regels toevoegen per telefoonnummer';

  @override
  String get featureCenter => 'Functiecentrum';

  @override
  String get featureEnableDisable =>
      '• Verschillende filters in-/uitschakelen per SIM';

  @override
  String get featureListTitle => 'Functies:';

  @override
  String get featureManageRules => '• Regel lijsten beheren per SIM';

  @override
  String get features => 'Functies';

  @override
  String get fetchingCallerIdInfo => 'Beller-ID-informatie ophalen...';

  @override
  String fileSavedTo(Object path) {
    return 'Bestand opgeslagen naar: $path';
  }

  @override
  String get filter => 'Filter';

  @override
  String get filterByLabel => 'Filteren op label';

  @override
  String get filterControlPanelTitle => 'Filter bedieningspaneel';

  @override
  String get filterControlSubtitle =>
      'Status van alle filters in-/uitschakelen beheren';

  @override
  String get filterControlTitle => 'Filter Controle';

  @override
  String get filtered => 'Gefilterd';

  @override
  String get filterExplanation => 'Filter Uitleg';

  @override
  String get filterManagement => 'Filter Beheer';

  @override
  String get filterName => 'Filter Naam';

  @override
  String get filterPriorityNote =>
      'Opmerking: Er zijn prioriteitsrelaties tussen filters, raadpleeg de helpdocumentatie voor details';

  @override
  String get filterSettings => 'Filter Instellingen';

  @override
  String get filterSettingsTitle => 'Filter Instellingen';

  @override
  String get filterSMS => 'Filter SMS';

  @override
  String get filterToggleInstructions =>
      'Schakel filters in of uit voor deze SIM-slot:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Filter $status: $filterName';
  }

  @override
  String get filterType => 'Filter Type';

  @override
  String get financial => 'Financieel';

  @override
  String get flexibleCombinationFeature =>
      '• Flexibele Combinaties: Filters in-/uitschakelen per SIM-slot';

  @override
  String get fontSizesSetting => 'Lettergroottes';

  @override
  String foundRules(Object count) {
    return '$count regels gevonden';
  }

  @override
  String get fraudAlert => 'FRAUDE ALERT - Hang de oproep op';

  @override
  String get fraudScamLikely => 'Fraude Scam Waarschijnlijk';

  @override
  String get free => 'Gratis';

  @override
  String get functionSettingsTitle => 'Functie Instellingen';

  @override
  String generalUpdateFailure(Object error) {
    return 'Update mislukt: $error';
  }

  @override
  String get getFree => 'Gratis Verkrijgen';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Configureer globale filters voor alle SIM-kaarten:';

  @override
  String get globalFilterFeature =>
      '• Globale Filters: Basisregels voor alle inkomende oproepen';

  @override
  String get globalFilterSettings => 'Globale Filter Instellingen';

  @override
  String get globalSettings => 'Globale Instellingen';

  @override
  String get googleDriveAuthDescription =>
      'Autoriseer met behulp van de systeemgeconfigureerde Google Drive client ID en sleutel';

  @override
  String get googleDriveConfigTitle => 'Google Drive Configuratie';

  @override
  String get government => 'Overheid';

  @override
  String get granted => 'Verleend';

  @override
  String get grantNecessaryPermissions => 'Verleen Noodzakelijke Rechten';

  @override
  String get grantPermissions => 'Verleen Rechten';

  @override
  String get headhunter => 'Headhunter';

  @override
  String get height => 'Hoogte';

  @override
  String get homeTab => 'Start';

  @override
  String get howItWorksPoint1 =>
      '• Het systeem zal automatisch oproepen van hetzelfde nummer binnen het ingestelde tijmvenster toestaan';

  @override
  String get howItWorksPoint2 =>
      '• Kortere tijmvensters resulteren in strengere onderschepping; langere tijmvensters resulteren in lossere onderschepping';

  @override
  String get howItWorksPoint3 =>
      '• Het systeem controleert oproepgeschiedenissen om te bepalen of het een herhaalde oproep is';

  @override
  String get howItWorksTitle => 'Hoe Het Werkt:';

  @override
  String get iconCodeOptional => 'Icoon Code (Optioneel)';

  @override
  String get iconSize => 'Icoon Grootte';

  @override
  String get import => 'Importeren';

  @override
  String get important => 'Belangrijk';

  @override
  String get importConfig => 'Configuratie Importeren';

  @override
  String get importContacts => 'Contacten Importeren';

  @override
  String get importExportContacts => 'Contacten Importeren/Exporteren';

  @override
  String get importExportContactsTooltip => 'Contacten Importeren/Exporteren';

  @override
  String get importExportRules => 'Regels Importeren/Exporteren';

  @override
  String importFailed(Object error) {
    return 'Importeren mislukt: $error';
  }

  @override
  String get importFailure => 'Kon de configuratie niet importeren';

  @override
  String get importFeatureComingSoon => 'Importfunctie komt binnenkort';

  @override
  String get importLabels => 'Labels Importeren';

  @override
  String importLabelsFailed(Object error) {
    return 'Kon labels niet importeren: $error';
  }

  @override
  String get importPluginList => 'Plugin Lijst Importeren';

  @override
  String importPluginListFailed(Object error) {
    return 'Kon plugin lijst niet importeren: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Succesvol $count plugins geïmporteerd';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Regelconfiguraties Importeren vanuit Bestand';

  @override
  String get importRules => 'Regels Importeren';

  @override
  String get importSuccess => 'Import succesvol';

  @override
  String get incomingCallInterceptAction =>
      'Onderscheppingsactie Inkomende Oproep';

  @override
  String get incorrectPassword => 'Onjuist wachtwoord';

  @override
  String get initializing => 'Initialiseren';

  @override
  String get installed => 'Geïnstalleerd';

  @override
  String get insufficientMarks => 'Onvoldoende Punten';

  @override
  String get insurance => 'Verzekering';

  @override
  String get interceptAction => 'Onderscheppingsactie';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Stel in hoe geblokkeerde oproepen worden afgehandeld';

  @override
  String get interceptionActionSettingsTitle =>
      'Onderscheppingsactie Instellingen';

  @override
  String get interceptionTimeInterval => 'Onderschepping Tijdsinterval';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service update-interval ingesteld op $days dagen';
  }

  @override
  String get invalidContentRegex => 'Ongeldige content regex';

  @override
  String get invalidLabel => 'Ongeldabel label';

  @override
  String get invalidRegexPattern => 'Ongeldabel regex patroon';

  @override
  String get invalidSenderRegex => 'Ongeldabel afzender regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Word lid van het Telegram Kanaal en Groep voor meer informatie';

  @override
  String get jsonFormat => 'JSON Formaat';

  @override
  String get keepAllVersions => 'Behoud alle versies';

  @override
  String get keepAllVersionsDescription =>
      'Behoud alle historische versies van elke back-up';

  @override
  String get label => 'Label';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Label \"$name\" succesvol toegevoegd';
  }

  @override
  String get labelCategories => 'Label Categorieën';

  @override
  String get labelDeleted => 'Label verwijderd';

  @override
  String get labelDescription =>
      'Labels helpen u contacten beter te beheren, aangepaste labels toe te voegen aan telefoonnummers voor eenvoudige identificatie van oproepen en berichten.';

  @override
  String get labelFilterTooltip => 'Label Filter';

  @override
  String get labelIconColor => 'Label Icoon Kleur';

  @override
  String get labelManagement => 'Label Beheer';

  @override
  String get labelNotFound => 'Label niet gevonden';

  @override
  String get labels => 'Labels';

  @override
  String get labelsColor => 'Labels Kleur';

  @override
  String labelsDeleted(Object count) {
    return '$count labels verwijderd';
  }

  @override
  String get labelsExportedSuccessfully => 'Labels succesvol geëxporteerd';

  @override
  String get labelsFontSize => 'Labels Lettergrootte';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Succesvol $count labels geïmporteerd';
  }

  @override
  String get labelsPosition => 'Labels Positie';

  @override
  String labelTag(Object labelId) {
    return 'Label: $labelId';
  }

  @override
  String labelUpdateFailed(Object error) {
    return 'Kon label niet bijwerken: $error';
  }

  @override
  String get labelUpdateSuccess => 'Label \"\$labelText\" succesvol bijgewerkt';

  @override
  String get languageSettings => 'Taalinstellingen';

  @override
  String get languageSettingsSubtitle =>
      'Wijzig de weergavetaal van de applicatie';

  @override
  String get languageSettingsTitle => 'Taalinstellingen';

  @override
  String get lastSyncLabel => 'Laatste Synchronisatie';

  @override
  String lastUpdated(Object date) {
    return 'Laatst bijgewerkt: $date';
  }

  @override
  String get lifetimeMembership => 'Levenslang Lidmaatschap';

  @override
  String get lifetimeMembershipDescription =>
      'Eenmalige aankoop, ontgrendel permanent alle premium functies en toekomstige updates';

  @override
  String loadContactsFailed(Object error) {
    return 'Kon contacten niet laden: $error';
  }

  @override
  String get loadDataFailed => 'Kon gegevens niet laden';

  @override
  String get loading => 'Laden...';

  @override
  String get loadingTags => 'Tags laden...';

  @override
  String loadLabelFailed(Object error) {
    return 'Kon labels niet laden: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Kon labels niet laden: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Kon gemarkeerde telefoonnummers niet laden: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Kon gemarkeerde telefoons niet laden: $error';
  }

  @override
  String loadPluginsFailed(Object error) {
    return 'Kon plugins niet laden: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Kon instellingen niet laden: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Kon SMS regels niet laden: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Status laden mislukt';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Kon abonnementen niet laden: $error';
  }

  @override
  String get loan => 'Lening';

  @override
  String get localCounterFilter => 'Lokale Teller Filter';

  @override
  String get localCounterFilterSubtitle =>
      'Automatisch spamoproepen filteren op basis van oproepfrequentie';

  @override
  String get localCountFilter => 'Bescherming Lokale Markeringsdrempel';

  @override
  String get localCountFilterDescription =>
      'Blokkeer automatisch oproepen die de lokale meldingsdrempel overschrijden';

  @override
  String get localCountFilterExplanationContent =>
      'Het lokale aantal filter analyseert oproepgeschiedenisrecords om frequente spamoproepen automatisch te identificeren en te blokkeren.';

  @override
  String get localCountFilterExplanationTitle => 'Lokale Aantal Filter Uitleg';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Bepaal of er geblokkeerd moet worden op basis van de aantalwaarde van het nummer';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Wanneer het aantal van een nummer de ingestelde drempel overschrijdt, kunt u ervoor kiezen om het automatisch te blokkeren';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• U kunt selectief nummers toestaan die de drempel niet overschrijden';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• U kunt kiezen of u alle query logs wilt vastleggen';

  @override
  String get localCountFiltering => 'Lokale Aantal Filtering';

  @override
  String get localCountFilteringExplanation =>
      '• Lokale Aantal Filtering: Filterregels op basis van lokale markeertelling';

  @override
  String get localCountFilterSettings => 'Lokale Aantal Filter Instellingen';

  @override
  String get localCountFilterUseCases =>
      'Dit filter is bijzonder geschikt voor het identificeren van automatisch gebelde spamoproepen en marketingoproepen.';

  @override
  String get localFilterSettings => 'Lokale Filter Instellingen';

  @override
  String get localNotificationDisabled => 'Lokale melding uitgeschakeld';

  @override
  String get localNotificationEnabled => 'Lokale melding ingeschakeld';

  @override
  String get localServices => 'Lokale Diensten';

  @override
  String get locationColor => 'Locatie Kleur';

  @override
  String get locationFontSize => 'Locatie Lettergrootte';

  @override
  String get locationIconColor => 'Locatie Icoon Kleur';

  @override
  String get locationPosition => 'Locatie Positie';

  @override
  String get logAllLocalQueries => 'Log alle lokale query\'s';

  @override
  String get logAllLocalQueriesDescription =>
      'Leg logs vast voor alle lokale nummerquery\'s';

  @override
  String get logAllRemoteQueries => 'Log alle externe query\'s';

  @override
  String get logAllRemoteQueriesDescription =>
      'Leg alle externe nummerquery-operaties vast';

  @override
  String get manage => 'Beheer Contacten';

  @override
  String get manageFavoriteContacts => 'Favoriete Contacten Beheren';

  @override
  String get manageFilterRules => 'Filterregels Beheren';

  @override
  String get manageFilterRulesDescription =>
      'Voeg SMS filterregels toe, bewerk ze of verwijder ze';

  @override
  String get markCounts => 'Markeer Aantallen';

  @override
  String get markCount => 'Markeer Aantal';

  @override
  String markedByCount(Object count) {
    return 'Gemarkeerd door $count';
  }

  @override
  String get markedPhonesList => 'Gemarkeerde Telefoonnummers';

  @override
  String get markExchange => 'Markeer Wissel';

  @override
  String get markPhone => 'Markeer Telefoonnummer';

  @override
  String markPhoneFailed(Object error) {
    return 'Telefoonnummer markeren mislukt: $error';
  }

  @override
  String get markPhoneManagementTitle => 'Telefoonnummerbeheer markeren';

  @override
  String get markPhoneSuccess => 'Telefoonnummer succesvol gemarkeerd';

  @override
  String get matchFailedMessage => 'Geen overeenkomst.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'komt overeen met specifiek nummerformaat';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Nummers matchen met speciale tekens:';

  @override
  String get matchSpecificDigitPatterns =>
      'komt overeen met XXX-XXXX-XXXX formaat';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Specifieke cijferpatronen matchen:';

  @override
  String get matchSuccessfulMessage => 'Overeenkomst succesvol!';

  @override
  String get medical => 'Medisch';

  @override
  String get membershipPrivileges => 'Lidmaatschapsvoordelen';

  @override
  String get migrationTool => 'Migratietool';

  @override
  String get minutes => 'minuten';

  @override
  String get month => 'Maand';

  @override
  String get monthly => 'Maandelijks';

  @override
  String get monthlyCallCount => 'Maandelijkse oproepen';

  @override
  String get monthlyMembership => 'Maandelijks lidmaatschap';

  @override
  String get monthlyMembershipDescription =>
      'Ontgrendel alle premium functies, automatisch maandelijks verlengd';

  @override
  String get monthlyTotal => 'Maandelijks totaal';

  @override
  String get moreOptions => 'Meer opties';

  @override
  String get mute => 'Dempen';

  @override
  String get name => 'Naam';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Naam en telefoonnummer mogen niet leeg zijn';

  @override
  String get nameColor => 'Naamkleur';

  @override
  String get nameFontSize => 'Naam lettergrootte';

  @override
  String get namePosition => 'Naampositie';

  @override
  String get nameUnknown => 'Naam: Onbekend';

  @override
  String get nextStep => 'Volgende';

  @override
  String get noAction => 'Geen actie';

  @override
  String get noActionRules => 'Geen actieregels';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Geen actieve cloud synchronisatieservice';

  @override
  String get noCallRecords => 'Geen oproepgegevens';

  @override
  String get noContactsYet => 'Nog geen contacten';

  @override
  String get noData => 'Geen gegevens';

  @override
  String get noDevicesRegisteredMessage => 'Geen apparaten geregistreerd';

  @override
  String get noLabels => 'Nog geen labels';

  @override
  String get noMarkedPhones => 'Geen gemarkeerde telefoonnummers';

  @override
  String get noMatchingContactsFound =>
      'Geen overeenkomende contacten gevonden';

  @override
  String get noMatchingNumbersFound => 'Geen overeenkomende nummers gevonden';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Geen overeenkomende $ruleType';
  }

  @override
  String get none => 'Geen';

  @override
  String get noneServiceType => 'Geen';

  @override
  String get noPlugins => 'Nog geen plugins';

  @override
  String noRules(Object ruleType) {
    return 'Geen $ruleType nog';
  }

  @override
  String get noRulesPrompt => 'Geen regels gevonden, voeg regels toe';

  @override
  String get noRulesToExport => 'Geen regels om te exporteren';

  @override
  String get noSmsFilterRulesYet => 'Nog geen SMS filterregels';

  @override
  String get noSmsRulesYet => 'Nog geen SMS-regels';

  @override
  String get noSubscriptions => 'Geen abonnementen';

  @override
  String get notGranted => 'Niet verleend';

  @override
  String get notificationModeDescription =>
      'Toon bellerinformatie in de meldingsbalk';

  @override
  String get notificationPermission => 'Meldingspermissie';

  @override
  String get notificationPermissionDescription =>
      'Gebruikt om meldingen van inkomende oproepen en berichten weer te geven.';

  @override
  String get notifications => 'Meldingen';

  @override
  String get notificationSettings => 'Meldingsinstellingen';

  @override
  String get notVerifiedText => 'Niet geverifieerd';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Geen geldige SMS-regels gevonden in bestand';

  @override
  String get number => 'Nummer';

  @override
  String get numberColor => 'Nummerkleur';

  @override
  String get numberFontSize => 'Nummer lettergrootte';

  @override
  String get numberPosition => 'Nummerpositie';

  @override
  String get numberSearch => 'Nummer zoeken';

  @override
  String get numberTypeColor => 'Nummertype kleur';

  @override
  String get numberTypeFontSize => 'Nummertype lettergrootte';

  @override
  String get numberTypePosition => 'Nummertype positie';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Uw oproepbeveiligingsmanager is klaar, geniet van een veilige oproepervaring!';

  @override
  String get onboardingLanguageDescription =>
      'Kies uw voorkeurstaal voor de beste ervaring.';

  @override
  String get onboardingPermissionsDescription =>
      'Om volledige service te bieden, hebben we de volgende machtigingen nodig:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Blokkeer spamoproepen en -berichten met één klik, pas blokkeringsregels aan en geef u een rustige omgeving.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Identificeer automatisch onbekende oproepen, markeer verdachte nummers en bescherm uw oproepveiligheid.';

  @override
  String get onboardingWelcomeDescription =>
      'Uw oproepbeheer-expert, die uitgebreide oproepidentificatie- en blokkeringsdiensten biedt.';

  @override
  String get oneDriveAuthDescription =>
      'Autoriseer met behulp van de door het systeem geconfigureerde OneDrive client-ID en sleutel';

  @override
  String get oneDriveConfigTitle => 'OneDrive configuratie';

  @override
  String get onlineCallerIdSubscription => 'Online Caller ID Abonnement';

  @override
  String get openAppSettings => 'App-instellingen openen';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Kon app-instellingen niet openen: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Bewerking mislukt: $error';
  }

  @override
  String get operationFailure => 'Bewerking mislukt';

  @override
  String get operationSuccess => 'Bewerking geslaagd';

  @override
  String get other => 'Andere';

  @override
  String get ourOtherApps => 'Onze andere apps';

  @override
  String get overlayMode => 'Zwevend venster';

  @override
  String get overlayModeDescription =>
      'Toon oproepinformatie in een zwevend venster';

  @override
  String get overlayPermission => 'Overlay-toestemming';

  @override
  String get overlayPermissionDescription =>
      'Gebruikt om de overlay van inkomende oproepen weer te geven.';

  @override
  String get overview => 'Overzicht';

  @override
  String get password => 'Wachtwoord';

  @override
  String get passwordCannotBeEmpty => 'Wachtwoord mag niet leeg zijn';

  @override
  String get passwordLabel => 'Wachtwoord';

  @override
  String get passwordsDoNotMatch => 'Wachtwoorden komen niet overeen';

  @override
  String get pattern => 'Patroon';

  @override
  String get pendingSync => 'Wacht op synchronisatie';

  @override
  String get periodMonth => 'Maand';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodYear => 'Jaar';

  @override
  String get permissionDenied => 'Toestemmingsverzoek geweigerd';

  @override
  String get permissionGranted => 'Toestemming verleend';

  @override
  String get permissionManagement => 'Toestemmingsbeheer';

  @override
  String get phoneCallsTab => 'Telefoon';

  @override
  String get phoneNumber => 'Telefoonnummer';

  @override
  String get phoneNumberCannotBeEmpty => 'Telefoonnummer mag niet leeg zijn';

  @override
  String get phoneNumberLabel => 'Telefoonnummer';

  @override
  String get phoneNumberTypeFixedLine => 'Vaste lijn';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Vaste lijn of mobiel';

  @override
  String get phoneNumberTypeMobile => 'Mobiel';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Persoonlijk nummer';

  @override
  String get phoneNumberTypePremiumRate => 'Premiumtarief';

  @override
  String get phoneNumberTypeSharedCost => 'Gedeelde kosten';

  @override
  String get phoneNumberTypeTollFree => 'Gratis';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Onbekend';

  @override
  String get phoneNumberTypeVoicemail => 'Voicemail';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Telefoon toestemming';

  @override
  String get phonePermissionDescription =>
      'Gebruikt om inkomende oproepen te identificeren en te blokkeren.';

  @override
  String get phoneRule => 'Telefoonregel';

  @override
  String get phoneRuleManagement => 'Beheer van telefoonregels';

  @override
  String get phoneRuleSubscription => 'Abonnement op telefoonregels';

  @override
  String get phoneSubscription => 'Telefoonabonnement';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Abonneren op telefoonregel-lijsten via URL om wit- en zwartlijstregels automatisch bij te werken. Ondersteunt regelbestanden in JSON-formaat.';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Selecteer een label en voer een geldig telefoonnummer in';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" succesvol toegevoegd';
  }

  @override
  String get pluginDeleted => 'Plugin verwijderd';

  @override
  String get pluginLatestVersion => 'Plugin is al de nieuwste versie';

  @override
  String get pluginListExportSuccess => 'Pluginlijst succesvol geëxporteerd';

  @override
  String get pluginManagement => 'Pluginbeheer';

  @override
  String get pluginManagementSubtitle =>
      'Beheer en configureer plug-ins van derden';

  @override
  String get pluginName => 'Pluginnaam';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugins succesvol verwijderd.';
  }

  @override
  String get pluginService => 'Plugin Service';

  @override
  String get pluginTestPageTitle => 'Plugin Test';

  @override
  String get pluginUpdateSuccess => 'Plugin succesvol bijgewerkt';

  @override
  String get pluginUrl => 'Plugin URL';

  @override
  String get pluginVersion => 'Pluginversie';

  @override
  String get political => 'Politiek';

  @override
  String get powerfulSpamBlocking => 'Krachtige spamblokkering';

  @override
  String get previousStep => 'Vorige';

  @override
  String get prioritizeRemoteAction =>
      'Prioriteer actie-instellingen van externe database';

  @override
  String get prioritizeRemoteActionDescription =>
      'Prioriteer actie-instellingen van de externe database';

  @override
  String get processing => 'Bezig met verwerken...';

  @override
  String get processingOperation => 'Bezig met verwerken...';

  @override
  String get purchase => 'Aankoop';

  @override
  String get quarterlyMembership => 'Kwartierlijks lidmaatschap';

  @override
  String get quarterlyMembershipDescription =>
      'Ontgrendel alle premiumfuncties, automatisch verlengd per kwartaal';

  @override
  String get ready => 'Klaar!';

  @override
  String get recruiter => 'Recruiter';

  @override
  String get refresh => 'Vernieuwen';

  @override
  String get refreshPermissionStatus => 'Vernieuw toestemmingsstatus';

  @override
  String get refreshTooltip => 'Vernieuwen';

  @override
  String regexErrorMessage(Object error) {
    return 'Regex-fout: $error';
  }

  @override
  String get regexPattern => 'Regex Patroon';

  @override
  String get regexPatternExplanation => 'Uitleg Regex Patroon';

  @override
  String get regexPatternExplanationButton => 'Uitleg Regex Patroon';

  @override
  String get regexPatternLabel => 'Regex Patroon';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Regex Patronen voor Telefoonnummer Matching';

  @override
  String get regexRule => 'Regex Regel';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Kon regex-regel niet toevoegen: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex-regel succesvol toegevoegd';

  @override
  String get regexRuleManagement => 'Regex Regelbeheer';

  @override
  String get regexRuleNamePatternRequired =>
      'Regelnaam en regex-patroon mogen niet leeg zijn';

  @override
  String get regexRules => 'Regex Regels';

  @override
  String get regexTesterTitle => 'Regex Tester';

  @override
  String get region => 'Regio';

  @override
  String get registeredDevicesTitle => 'Geregistreerde Apparaten';

  @override
  String get rejectAllCalls => 'Alle Oproepen Weigeren';

  @override
  String get rejectAllCallsDescription =>
      'Wanneer ingeschakeld, worden alle oproepen met de hoogste prioriteit geweigerd';

  @override
  String get rejectAllNumbers => 'Alle Inkomende Oproepen Weigeren';

  @override
  String get rejectAllNumbersDesc =>
      'Weiger alle inkomende oproepen met de hoogste prioriteit';

  @override
  String get rejectExceededNumbers => 'Overschreden Nummers Weigeren';

  @override
  String get rejectExceededNumbersDescription =>
      'Weiger automatisch nummers die de drempel overschrijden';

  @override
  String get remoteFilterSettings => 'Instellingen voor Externe Filter';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Instellingen voor Externe Nummerfilter';

  @override
  String get remoteNumberFilter => 'Bescherming Cloud Query Drempel';

  @override
  String get remoteNumberFilterDescription =>
      'Blokkeer automatisch oproepen die de cloud meldingsdrempel overschrijden';

  @override
  String get remoteNumberFiltering => 'Extern Nummerfilteren';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Extern Nummerfilteren: Filterregels gebaseerd op externe database-informatie';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identificeer spamoproepen met behulp van een clouddatabase en community-rapporten';

  @override
  String get removeAdsDescription =>
      'Verwijder permanent alle advertenties in de app voor een soepelere ervaring';

  @override
  String get removeAdsTitle => 'Advertenties Verwijderen';

  @override
  String get removedFromFavorites => 'Verwijderd uit favorieten';

  @override
  String get removeFromFavorites => 'Verwijderen uit Favorieten';

  @override
  String get renameDeviceTitle => 'Apparaat Hernoemen';

  @override
  String get requestAllPermissions => 'Alle Machtigingen Aanvragen';

  @override
  String get requestPermission => 'Machtiging Aanvragen';

  @override
  String requestPermissionFailed(Object error) {
    return 'Kon machtiging niet aanvragen: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Markeringen';
  }

  @override
  String get reset => 'Herstellen';

  @override
  String get restore => 'Herstellen';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Applicatie-instellingen Herstellen van Back-up';

  @override
  String get restoreFromCloud => 'Herstellen van Cloud';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Herstellen van cloud mislukt: $error';
  }

  @override
  String get restoreFromCloudSuccess => 'Succesvol hersteld van cloud';

  @override
  String get restorePurchases => 'Aankopen Herstellen';

  @override
  String get restoreSettings => 'Instellingen Herstellen';

  @override
  String get restoreSettingsConfirmation =>
      'Dit vervangt al uw huidige instellingen. Weet u zeker dat u wilt doorgaan?';

  @override
  String get retry => 'Opnieuw Proberen';

  @override
  String get ridesharing => 'Ridesharing';

  @override
  String get risk => 'Risico';

  @override
  String get robocall => 'Robocall';

  @override
  String get ruleAction => 'Regel Actie';

  @override
  String get ruleAddedSuccess => 'Regel succesvol toegevoegd';

  @override
  String get ruleAddSuccess => 'Regel succesvol toegevoegd';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Weet u zeker dat u deze $ruleType wilt verwijderen?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Regel Verwijderen';

  @override
  String get ruleDeletedSuccessfully => 'Regel succesvol verwijderd';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Kon regel niet verwijderen: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Regel succesvol verwijderd';

  @override
  String get ruleDisabledSuccessfully => 'Regel succesvol uitgeschakeld';

  @override
  String get ruleEnabledSuccessfully => 'Regel succesvol ingeschakeld';

  @override
  String ruleLoadFailed(Object error) {
    return 'Kon regels niet laden: $error';
  }

  @override
  String get ruleManagement => 'Regelbeheer';

  @override
  String get ruleName => 'Regelnaam';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Regelnaam en inhoud regex mogen niet leeg zijn';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Regelnaam en telefoonnummer mogen niet leeg zijn';

  @override
  String get ruleNameHint => 'bijv. Familie, Vrienden, etc.';

  @override
  String get ruleNameLabel => 'Regelnaam';

  @override
  String get ruleNameRequired =>
      'Regelnaam en telefoonnummer mogen niet leeg zijn';

  @override
  String get ruleNotExist => 'Regel bestaat niet of is verwijderd';

  @override
  String ruleNotFound(Object error) {
    return 'Regel niet gevonden: $error';
  }

  @override
  String get ruleSavedSuccessMessage => 'Regel succesvol opgeslagen!';

  @override
  String get rulesExportedSuccessfully => 'Regels succesvol geëxporteerd';

  @override
  String rulesExportedTo(Object path) {
    return 'Regels geëxporteerd naar: $path';
  }

  @override
  String get rulesImported => 'Regels succesvol geïmporteerd';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count regels succesvol geïmporteerd';
  }

  @override
  String ruleStatusChanged(Object status) {
    return 'Regel $status succesvol';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Bewerking mislukt: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Regel $status succesvol';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Regel bijwerken mislukt: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Regel succesvol bijgewerkt';

  @override
  String get ruleVerification => 'Regel Verificatie';

  @override
  String get save => 'Opslaan';

  @override
  String get saveButton => 'Opslaan';

  @override
  String get saveButtonText => 'Opslaan';

  @override
  String saveFailed(Object error) {
    return 'Opslaan mislukt: $error';
  }

  @override
  String get saveSettings => 'Instellingen opslaan';

  @override
  String get scamsLikely => 'Waarschijnlijk scams';

  @override
  String get search => 'Zoeken';

  @override
  String get searchContacts => 'Contacten zoeken';

  @override
  String searchError(Object error) {
    return 'Zoekfout: $error';
  }

  @override
  String get searchHint => 'Zoeken...';

  @override
  String get securityMessage =>
      'Vertrouw geen telefoongesprekken. Verifieer altijd klantenservicenummers onafhankelijk. Deel nooit wachtwoorden, verificatiecodes, kaartnummers of persoonlijke informatie.';

  @override
  String get selectActionWhenBlockingCalls =>
      'Selecteer actie bij het blokkeren van oproepen';

  @override
  String get selectActionWhenRuleMatches =>
      'Selecteer actie wanneer de regel overeenkomt';

  @override
  String get selectAll => 'Alles selecteren';

  @override
  String get selectCountry => 'Land selecteren';

  @override
  String selectedItems(Object count) {
    return '$count items geselecteerd';
  }

  @override
  String get selectedLabel => 'Geselecteerd:';

  @override
  String get selectExportFormat => 'Selecteer Exportformaat';

  @override
  String get selectLabel => 'Label selecteren';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Selecteer een label en voer een geldig telefoonnummer in';

  @override
  String get selectLanguage => 'Taal selecteren';

  @override
  String get selectMultiple => 'Meerdere selecteren';

  @override
  String get selectSimCard => 'SIM-kaart selecteren';

  @override
  String get selectTags => 'Tags selecteren';

  @override
  String get selectTrustedDataSource => 'Selecteer vertrouwde gegevensbronnen';

  @override
  String get selectYourLanguage => 'Selecteer uw taal';

  @override
  String get sender => 'Afzender';

  @override
  String get senderRegexOptional => 'Afzender Regex (Optioneel)';

  @override
  String get serverAddressLabel => 'Serveradres';

  @override
  String get serviceTypeContact => 'Contact Abonnement';

  @override
  String get serviceTypeLabel => 'Servicetype';

  @override
  String get serviceTypePhone => 'Telefoonabonnement';

  @override
  String get serviceTypePlugin => 'Plugin Update';

  @override
  String get serviceTypeSms => 'SMS Abonnement';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setEncryptionPassword => 'Encryptiewachtwoord instellen';

  @override
  String get settings => 'Instellingen';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Instellingen geback-upt naar: $path';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Instellingen succesvol hersteld. Start de app opnieuw op om de wijzigingen van kracht te laten worden.';

  @override
  String get settingsSaved => 'Instellingen opgeslagen';

  @override
  String settingsSaveFailed(Object error) {
    return 'Instellingen opslaan mislukt: $error';
  }

  @override
  String get settingsTab => 'Instellingen';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get setup => 'Installatie';

  @override
  String get silence => 'Stilte';

  @override
  String get silenceAndNoAnswer => 'Beltoon Dempen';

  @override
  String get silenceNoAnswer => 'Stilte geen antwoord';

  @override
  String get silentCallVoiceClone => 'Stille Oproep Stemklonen';

  @override
  String get silentRules => 'Stille regels';

  @override
  String simCard(Object simNumber) {
    return 'SIM-kaart $simNumber';
  }

  @override
  String get simCardColor => 'SIM-kaart Kleur';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM-kaart configuratie: Stel onafhankelijke filterregels in voor elke SIM-kaart';

  @override
  String get simCardFilterRules => 'SIM-kaart filterregels';

  @override
  String get simCardFilterRulesDescription =>
      'Stel verschillende filterregels in op basis van SIM-kaart slots';

  @override
  String get simCardFontSize => 'SIM-kaart Lettergrootte';

  @override
  String get simCardPosition => 'SIM-kaart Positie';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String get simRuleInstructions =>
      'SIM-slotregels stellen u in staat om onafhankelijke filterregels te configureren voor elke SIM-sleuf.';

  @override
  String get simRuleInstructionsTitle => 'SIM-sleufregels';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String get simSlotFilterDescription =>
      'Configureer onafhankelijke filterregels voor elke simkaart:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM-sleuf $slotNumber Filterinstellingen';
  }

  @override
  String get simSlotManagement => 'SIM-sleufbeheer';

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM-sleufpositie $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM-sleufregels: Onafhankelijke filterstrategieën per SIM';

  @override
  String get simSlotRuleListTitle => 'Lijst met SIM-sleufregels';

  @override
  String get simSlotRuleManagement => 'SIM-sleufregels';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM-sleuf $slotNumber';
  }

  @override
  String get skip => 'Overslaan';

  @override
  String get smartCallerId => 'Slimme oproepidentificatie';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS-filtering helpt u automatisch spamberichten te filteren en uw berichtlijst schoon te houden. U kunt filterregels en meldingsmethoden instellen.';

  @override
  String get smsFilterDisabled => 'SMS-filtering uitgeschakeld';

  @override
  String get smsFilterEnabled => 'SMS-filtering ingeschakeld';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'SMS-filterregel succesvol toegevoegd';

  @override
  String get smsFilterRules => 'SMS-filterregels';

  @override
  String get smsFilterSettings => 'SMS-filterinstellingen';

  @override
  String get smsManagement => 'SMS-beheer';

  @override
  String get smsPermission => 'SMS-toestemming';

  @override
  String get smsPermissionDescription =>
      'Gebruikt om spamberichten te filteren.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS-regel succesvol toegevoegd';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS-regel succesvol verwijderd';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'SMS-regels konden niet worden geladen: $error';
  }

  @override
  String get smsRuleManagement => 'SMS-regelbeheer';

  @override
  String get smsRuleSubscription => 'SMS-regelsabonnement';

  @override
  String get smsSubscription => 'SMS-abonnement';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'SMS-abonnement succesvol toegevoegd';

  @override
  String get smsSubscriptionRulesDescription =>
      'Abonneer u op SMS-regellijsten via URL, ondersteuning voor reguliere expressie-matching. U kunt blokkeer- of toestaande acties instellen.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Sommige toestemmingsverzoeken geweigerd';

  @override
  String get spamLikely => 'Waarschijnlijk spam';

  @override
  String get startColor => 'Beginkleur';

  @override
  String get startDate => 'Begindatum';

  @override
  String get startUsing => 'Beginnen met gebruiken';

  @override
  String get statAnswered => 'Beantwoord';

  @override
  String get statBlocked => 'Geblokkeerd';

  @override
  String get statistics => 'Statistieken';

  @override
  String get statisticsPageTitle => 'Gegevensanalyse';

  @override
  String get stirColor => 'STIR-kleur';

  @override
  String get stirFontSize => 'STIR-lettergrootte';

  @override
  String get stirPosition => 'STIR-positie';

  @override
  String get storagePermission => 'Opslagpermissie';

  @override
  String get storagePermissionDescription =>
      'Gebruikt om instellingen en regels op te slaan.';

  @override
  String get subscribe => 'Abonneren';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Abonnement \"$name\" succesvol toegevoegd';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Weet u zeker dat u dit abonnement wilt verwijderen?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Abonnement verwijderen';

  @override
  String get subscriptionDeleted => 'Abonnement verwijderd';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Abonnement kon niet worden verwijderd: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Abonnement verwijderd';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Abonnementen konden niet worden geladen: $error';
  }

  @override
  String get subscriptionName => 'Abonnementsnaam';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Abonnementsnaam en URL mogen niet leeg zijn';

  @override
  String get subscriptionNameHint => 'Voer abonnementsnaam in';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Status van abonnement kon niet worden gewijzigd: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Abonnement kon niet worden bijgewerkt: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Abonnement succesvol bijgewerkt';

  @override
  String get subscriptionUrl => 'Abonnements-URL';

  @override
  String get subscriptionUrlHint => 'Voer abonnements-URL in';

  @override
  String successfullyImportedRules(Object count) {
    return 'Succesvol $count regels geïmporteerd';
  }

  @override
  String get supportSync => 'Ondersteuning voor synchronisatie';

  @override
  String get survey => 'Enquête';

  @override
  String get syncDevicesButton => 'Apparaten synchroniseren';

  @override
  String get syncFailed => 'Synchronisatie mislukt';

  @override
  String get syncFailedMessage => 'Synchronisatie mislukt';

  @override
  String get syncFolderNameLabel => 'Naam synchronisatiemap';

  @override
  String get synchronized => 'Gesynchroniseerd';

  @override
  String get syncing => 'Synchroniseren...';

  @override
  String get syncNow => 'Nu synchroniseren';

  @override
  String get syncNowButton => 'Nu synchroniseren';

  @override
  String get syncStatusTitle => 'Synchronisatiestatus';

  @override
  String get syncStatusUpdatedMessage => 'Synchronisatiestatus bijgewerkt';

  @override
  String get syncSuccessMessage => 'Synchronisatie succesvol';

  @override
  String get syncWithCloudStorage => 'Synchroniseren met Cloudopslag';

  @override
  String get systemFeatures => 'Systeembeloningen:';

  @override
  String get systemSettingsTitle => 'Systeeminstellingen';

  @override
  String get tabAll => 'Alles';

  @override
  String get tabAnswered => 'Beantwoord';

  @override
  String get tabBlocked => 'Geblokkeerd';

  @override
  String get tabMissed => 'Gemist';

  @override
  String get tabOutgoing => 'Uitgaand';

  @override
  String tagLabel(String tag) {
    return 'Tag: $tag';
  }

  @override
  String get takeaway => 'Afhalen';

  @override
  String get telecommunication => 'Telecommunicatie';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testConnectionButton => 'Verbinding testen';

  @override
  String get textColorsSetting => 'Tekst- en labelkleuren';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Deze app is een krachtige tool voor nummerherkenning waarmee u ongewenste oproepen kunt identificeren en blokkeren.';

  @override
  String get thisWeek => 'Deze week';

  @override
  String get timeInterceptor => 'Bescherming Frequente Oproepen';

  @override
  String get timeInterceptorDescription =>
      'Blokkeer herhaalde oproepen van hetzelfde nummer binnen korte tijd';

  @override
  String get timeInterceptorExplanation =>
      '• Tijd Onderschepper: Herhaalde oproepen binnen korte tijd onderscheppen/toestaan';

  @override
  String get timeInterceptorExplanationContent =>
      'De functie voor het onderscheppen van oproepfrequentie analyseert de oproepfrequentie om frequente spamoproepen automatisch te identificeren en te onderscheppen/toestaan.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Uitleg Onderscheppen Oproepfrequentie';

  @override
  String get timeInterceptorSettingsTitle =>
      'Instellingen Onderscheppen Oproepfrequentie';

  @override
  String get timeWindowDescription =>
      'Stel de tijdsvenstergrootte in voor het toestaan van herhaalde oproepen. Oproepen van hetzelfde nummer binnen dit venster worden toegestaan';

  @override
  String timeWindowLabel(int minutes) {
    return 'Onderscheppingstijdsvenster (minuten): $minutes';
  }

  @override
  String get today => 'Vandaag';

  @override
  String get total => 'Totaal';

  @override
  String get totalBlocked => 'Totaal Geblokkeerd';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Gegevens overdragen tussen apparaten of platforms';

  @override
  String get travelTicketing => 'Reisticketverkoop';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get type => 'Type';

  @override
  String get unassignedSIMCard => 'Niet-toegewezen SIM-kaart';

  @override
  String get unknown => 'Onbekend';

  @override
  String get unknownTag => 'Tag: Onbekend';

  @override
  String get unregisterButton => 'Afmelden';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Weet u zeker dat u $deviceName wilt afmelden?';
  }

  @override
  String get unregisterDeviceTitle => 'Apparaat Afmelden';

  @override
  String get unsupportedFileFormat => 'Niet-ondersteund bestandsformaat';

  @override
  String get update => 'Bijwerken';

  @override
  String get updateAllNow => 'Alles nu bijwerken';

  @override
  String updateContactFailed(Object error) {
    return 'Contact bijwerken mislukt: $error';
  }

  @override
  String get updateFavoriteStatus => 'Favoriete status bijwerken';

  @override
  String get updateInterval => 'Update Interval';

  @override
  String get updateNow => 'Nu bijwerken';

  @override
  String get updatePlugin => 'Plugin bijwerken';

  @override
  String updatePluginFailed(Object error) {
    return 'Plugin bijwerken mislukt: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Regel bijwerken mislukt: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Abonnement bijwerken mislukt: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service succesvol bijgewerkt ($count regels)';
  }

  @override
  String get useCasesPoint1 =>
      '• Identificeer automatisch opnieuw kiezen spamoproepen';

  @override
  String get useCasesPoint2 =>
      '• Onderschep marketingoproepen die meerdere keren in korte tijd bellen';

  @override
  String get useCasesPoint3 =>
      '• Voorkom telefoonbombardementen en intimidatie';

  @override
  String get useCasesTitle => 'Gebruiksscenario\'s:';

  @override
  String get useGlobalSettings => 'Gebruik Globale Instellingen';

  @override
  String get usernameLabel => 'Gebruikersnaam';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Gebruik standaard regex-syntaxis om patronen te definiëren. Voorbeelden:';

  @override
  String get verificationFailedText => 'Mislukt';

  @override
  String get verifiedText => 'Geverifieerd';

  @override
  String get verify => 'Verifiëren';

  @override
  String version(Object version) {
    return 'Versie: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Ruil VIP-lidmaatschap met aantal telefoonnummer markeringen';

  @override
  String get vipExchangeTitle => 'Markeer Wissel VIP';

  @override
  String get watchAd => 'Bekijk advertentie';

  @override
  String get watchAdForTemp => 'Bekijk advertentie voor tijdelijke privileges';

  @override
  String get watchAdForTempDescription =>
      'Bekijk een korte advertentie om tijdelijk enkele premium functies te ontgrendelen';

  @override
  String get webDAVConfigTitle => 'WebDAV Configuratie';

  @override
  String get week => 'Week';

  @override
  String get welcome => 'Welkom';

  @override
  String get whitelist => 'Whitelist';

  @override
  String get width => 'Breedte';

  @override
  String get wildcardMatchingDescription =>
      'Gebruik \'.\' om elk willekeurig teken te matchen (bv. \'123.456\' matcht 123-456)';

  @override
  String get wildcardMatchingTitle => 'Wildcard matching:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Wildcard Ondersteuning voor Flexibele Filtering';

  @override
  String get windowSizeSetting => 'Venstergrootte';

  @override
  String get year => 'Jaar';

  @override
  String get noSimCardsDetected => 'Geen SIM-kaarten gedetecteerd';

  @override
  String get filterManagementDescription => 'Bel Filters Instellen';

  @override
  String get callerIdCustomizationSubtitle =>
      'Aanpassen Telefoonnummer Weergave Lay-out';

  @override
  String get fraudAlerSettingTitle => 'Fraude Alert Instelling';

  @override
  String get fraudAlerSettingSubtitle => 'Fraude Alert Instellen';

  @override
  String get enableFraudAlert => 'Fraude Alert Inschakelen';

  @override
  String get enableFraudAlertDescription =>
      'Alert voor vermoedelijke scam oproepen';

  @override
  String get enableVibration => 'Trillen Inschakelen';

  @override
  String get enableVibrationDescription =>
      'Trillen wanneer een oproep wordt vermoed als scam oproep';

  @override
  String get notificationSettingsTitle => 'Notificatie Instellingen';

  @override
  String get useLocalNotification => 'Lokale Notificaties Gebruiken';

  @override
  String get useLocalNotificationDescription =>
      'Lokale notificaties inschakelen voor inkomende oproepen';

  @override
  String get cancelLocalNotification => 'Lokale Notificaties Sluiten';

  @override
  String get useStirNotification => 'Notificatie van STIR Gebruiken';

  @override
  String get cancelLocalNotificationDescription =>
      'Lokale Notificaties Automatisch Sluiten';

  @override
  String get callerIdSettingsTitle => 'Telefoonnummer Weergave Instellingen';

  @override
  String get callerIdSettingsSubtitle =>
      'Instellen Melding & Weergavemodus Inkomende Oproep';

  @override
  String get purchaseTitle => 'Aankoop';

  @override
  String get purchaseSubtitle => 'De Service Aanschaffen';

  @override
  String get callerIdNotificationTitle => 'Info Inkomende Oproep';

  @override
  String get blockedCallTitle => 'Geblokkeerde Oproep';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Geblokkeerde oproep van $phoneNumber';
  }

  @override
  String get stirVerified => 'Geverifieerd';

  @override
  String get stirNotVerified => 'Niet Geverifieerd';

  @override
  String get stirFailed => 'Verificatie Mislukt';

  @override
  String get stirUnknown => 'Onbekende Verificatiestatus';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN Verificatie';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage voor nummer $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Scrollende Beveiligingsbericht Instellingen';

  @override
  String get messageColor => 'Bericht Kleur';

  @override
  String get messageFontSize => 'Bericht Lettergrootte';

  @override
  String get messagePosition => 'Bericht Positie';

  @override
  String get containerWidth => 'Container Breedte';

  @override
  String get scrollSpeed => 'Scroll Snelheid';

  @override
  String get enableSecurityMessage => 'Beveiligingsbericht Inschakelen';

  @override
  String get fraudAlertTitle => 'Fraude Alert';

  @override
  String get noBlockedTypeData => 'Geen geblokkeerde type gegevens beschikbaar';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importeer $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName succesvol geïmporteerd, totaal $count records geïmporteerd';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName importeren mislukt: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Exporteer $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName succesvol geëxporteerd';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName exporteren mislukt: $error';
  }

  @override
  String get cloudSyncService => 'Cloud Synchronisatie Service';

  @override
  String get membershipCenter => 'Lidmaatschaps Centrum';

  @override
  String get redeemVipWithMarks => 'VIP Inwisselen met Punten';

  @override
  String get currentMarkCount => 'Huidig Aantal Punten';

  @override
  String get markMoreNumbersForMore => 'Markeer meer nummers voor meer punten';

  @override
  String get noAds => 'Geen Advertenties';

  @override
  String get cloudBackup => 'Cloud Back-up';

  @override
  String get callerIdEnhancement => 'Telefoonnummer Weergave Verbetering';

  @override
  String get voiceRecognition => 'Spraakherkenning';

  @override
  String get feature => 'Functie';

  @override
  String get normalUser => 'Normale Gebruiker';

  @override
  String get vipUser => 'VIP Gebruiker';

  @override
  String get temporaryVip => 'Tijdelijke VIP';

  @override
  String get removeAds => 'Advertenties Verwijderen';

  @override
  String get settingsBackup => 'Back-up Instellingen ';

  @override
  String get allServicesStatusTitle => 'Huidige Service Status';

  @override
  String get allServicesStatusSubtitle =>
      'Huidige Status van Elke Cloud Service';

  @override
  String get redirect => 'Omleiden';

  @override
  String get notify => 'Notificeren';

  @override
  String get log => 'Logboek';

  @override
  String get custom => 'Aangepast';

  @override
  String get allowActionDescription =>
      'Oproepen worden toegestaan, zelfs als het nummer op de blokkeerlijst staat.';

  @override
  String get blockActionDescription =>
      'Oproepen worden geblokkeerd en weergegeven in het oproepenlogboek.';

  @override
  String get silenceActionDescription =>
      'Oproepen worden stilgezet maar weergegeven in het oproepenlogboek.';

  @override
  String get noneActionDescription =>
      'Er wordt geen speciale actie ondernomen voor de oproep.';

  @override
  String get redirectActionDescription =>
      'Leid de oproep om naar een gespecificeerd nummer.';

  @override
  String get labelActionDescription =>
      'Voeg een label toe aan de oproep voor gemakkelijke identificatie.';

  @override
  String get notifyActionDescription =>
      'Stuur een notificatie wanneer een oproep wordt ontvangen.';

  @override
  String get logActionDescription =>
      'Log de oproepinformatie zonder verdere actie.';

  @override
  String get customActionDescription => 'Voer een aangepaste actie uit.';

  @override
  String get synced => 'Gesynchroniseerd';

  @override
  String get needVipAccess =>
      'Je hebt VIP toegang nodig om deze functie te gebruiken';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importeer of exporteer $entityTypeName gegevens';
  }

  @override
  String get importExportTitle => 'Importeren/Exporteren';

  @override
  String get noPhoneRules => 'Geen telefoonregels gevonden';

  @override
  String get noRegexRules => 'Geen regexregels gevonden';

  @override
  String get noAllowedBlockedRules =>
      'Geen toegestane/geblokkeerde regels gevonden';

  @override
  String get importExport => 'Importeren/Exporteren';

  @override
  String get filterByAction => 'Filteren op Actie';

  @override
  String get upgradeToVip => 'Upgrade naar VIP';

  @override
  String get batteryOptimizationPermission => 'Batterijoptimalisatie';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Sta de app toe om op de achtergrond te draaien om services zoals nummerherkenning te bieden.';

  @override
  String get permissionTitle => 'Speciale Machtigingen';

  @override
  String get permissionSubtitle =>
      'Beheer overlay- en batterijoptimalisatiemachtigingen';

  @override
  String get themeSettingsTitle => 'Thema-instellingen';

  @override
  String get themeSettingsSubtitle => 'Kies uw favoriete thema';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get themeSystem => 'Systeemstandaard';

  @override
  String get databaseSyncTitle => 'Database Synchronisatie';

  @override
  String get countrySyncSettingsTitle =>
      'Landspecifieke Database Synchronisatie-instellingen';

  @override
  String get countrySyncSettingsSubtitle =>
      'Selecteer landen voor datasynchronisatie';

  @override
  String get countryDataDisclaimer =>
      'Let op: De database bevat mogelijk geen gegevens voor alle specifieke landen of regio\'s.';

  @override
  String get editSubscription => 'Abonnement bewerken';

  @override
  String get searchByNameOrPhoneNumber => 'Zoeken op naam of telefoonnummer';

  @override
  String get allowedBlockedRulesInfo =>
      'Toegestane/geblokkeerde regels worden gebruikt om oproepen te matchen met specifieke telefoonnummers, die de hoogste prioriteit hebben.';

  @override
  String get searchPhoneRulesHint => 'Zoek telefoonregels';

  @override
  String get phoneRulesInfo =>
      'Telefoonregels worden gebruikt om oproepen te matchen met specifieke telefoonnummers, die een lagere prioriteit hebben. Sommige komen van de telefoonregelabonnementen.';

  @override
  String get searchSubscriptionsHint => 'Zoek abonnementen';

  @override
  String get searchPluginsHint => 'Zoek plug-ins';

  @override
  String get searchLabelsHint => 'Zoek labels';

  @override
  String get pluginDescription => 'Beschrijving plug-in';

  @override
  String get enterPluginDescription => 'Voer beschrijving plug-in in';

  @override
  String get searchRegexRulesHint => 'Zoek regex-regels';

  @override
  String get regexRulesInfo =>
      'Regex-regels worden gebruikt om oproepen te filteren op basis van de Regex-patronen.';

  @override
  String get searchMarkedPhonesHint => 'Zoek gemarkeerde telefoons';

  @override
  String get searchContactSubscriptionsHint => 'Zoek contactabonnementen';

  @override
  String get showAllContacts => 'Alle Contacten Tonen';

  @override
  String get showFavorites => 'Favorieten Tonen';

  @override
  String get manualEntry => 'Handmatige Invoer Info';

  @override
  String get scriptSaved => 'Script opgeslagen';

  @override
  String editScriptFor(String pluginName) {
    return 'Script bewerken voor $pluginName';
  }

  @override
  String get saveScript => 'Script Opslaan';

  @override
  String get testPlugin => 'Plugin Testen';

  @override
  String get description => 'Beschrijving';

  @override
  String get accessTargetUrl => 'Toegang tot Doel-URL';

  @override
  String get result => 'Resultaat';

  @override
  String get editScript => 'Script Bewerken';

  @override
  String get numberFormat => 'Nummer Formaat';

  @override
  String get nationalNumber => 'Nationaal Nummer';

  @override
  String get e164Number => 'E164 Nummer';

  @override
  String get pluginRulesInfo =>
      'Gebruik uit veiligheidsoverwegingen alleen plug-ins van vertrouwde bronnen. Gebruik gerust onze sjablonen om uw eigen aangepaste plug-ins te maken!';

  @override
  String get advancedMode => 'Geavanceerde Modus';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Voer alstublieft ten minste één nummer in.';

  @override
  String get openInWebView => 'Openen in WebView';

  @override
  String get pluginLabel => 'Label Plug-in';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Achtergrondkleur Bericht';

  @override
  String get clearAllCallLogs => 'Alle Oproeplogboeken Wissen';

  @override
  String get clearAllCallLogsConfirmation =>
      'Bevestig om alle oproeplogboeken te wissen';

  @override
  String get allCallLogsCleared => 'Alle oproeplogboeken gewist';

  @override
  String get unblocked => 'Gedeblokkeerd';

  @override
  String get blockNumber => 'Nummer Blokkeren';

  @override
  String get blockNumberSuccess => 'Nummer succesvol geblokkeerd';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Weet u zeker dat u $phoneNumber wilt deblokkeren?';
  }

  @override
  String get viewDetails => 'Details Bekijken';

  @override
  String get unblock => 'Deblokkeren';

  @override
  String get unblockNumber => 'Nummer Deblokkeren';

  @override
  String get unblockNumberSuccess => 'Nummer succesvol gedeblokkeerd';

  @override
  String get unblockNumberFailed => 'Nummer deblokkeren mislukt';

  @override
  String get callingNumberFailed => 'Oproepen van nummer mislukt';

  @override
  String get listView => 'Lijstweergave';

  @override
  String get timelineView => 'Tijdlijnweergave';

  @override
  String get nameCannotBeEmpty => 'Naam mag niet leeg zijn';

  @override
  String get selectAction => 'Selecteer de actie';

  @override
  String get selectTargetService => 'Selecteer de doel-service';

  @override
  String get callDetails => 'Oproepdetails';

  @override
  String get callType => 'Oproeptype';

  @override
  String get callTime => 'Oproeptijd';

  @override
  String get numberInvalidFormat => 'Nummer ongeldig formaat';

  @override
  String get medium => 'Medium';

  @override
  String get finalRisk => 'Eindrisico';

  @override
  String get simState => 'SIM-status';

  @override
  String get ipCountry => 'IP Land';

  @override
  String get simCountry => 'SIM Land';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Nummer Match';

  @override
  String get support => 'Ondersteuning';

  @override
  String get rewardedAdService => 'Beloonde Advertenties Service';

  @override
  String get hasVipPrivilegeExceptAds =>
      'U heeft al VIP-privileges (behalve advertenties)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'U heeft al tijdelijke privileges, vervaldatum: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'U moet nog $count advertenties bekijken om tijdelijke VIP-privileges te krijgen';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'U heeft $days dagen tijdelijke aankoop privileges ontvangen. Vervaldatum: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Tijdelijke aankoop privilege is verlopen';

  @override
  String get loadingAd => 'Advertentie laden...';

  @override
  String get earnedTempVip => 'Verdiende tijdelijke VIP';

  @override
  String get vipExchangeService => 'VIP Wissel Service';

  @override
  String get marksInsufficient => 'Onvoldoende punten om te wisselen';

  @override
  String get invalidExchangeRule => 'Ongeldige wisselregel';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Succesvol gewisseld voor $description, vervaldatum: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Wisselen mislukt: $error';
  }

  @override
  String get vip3DaysWithAds =>
      '3 dagen VIP met advertenties (alleen synchronisatie)';

  @override
  String get vip5DaysNoAds =>
      '5 dagen volledig uitgeruste advertentievrije VIP';

  @override
  String get vip7DaysNoAds =>
      '7 dagen volledig uitgeruste advertentievrije VIP';

  @override
  String get noNotifications => 'Geen meldingen';

  @override
  String get clearAllNotifications => 'Alle Meldingen Wissen';

  @override
  String get clearAllNotificationsConfirmation =>
      'Bevestig om alle meldingen te wissen';

  @override
  String get clearButton => 'Wissen';

  @override
  String get justNow => 'Zojuist';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuten geleden',
      one: '1 minuut geleden',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uur geleden',
      one: '1 uur geleden',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dagen geleden',
      one: '1 dag geleden',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Gisteren';

  @override
  String get deletionProposal => 'Verwijderingsvoorstel';

  @override
  String get createProposal => 'Voorstel maken';

  @override
  String get createProposalTitle => 'Verwijderingsvoorstel maken';

  @override
  String get reason => 'Reden';

  @override
  String get reasonOutdated => 'Verouderd nummer';

  @override
  String get reasonPrivacy => 'Privacyzorg';

  @override
  String get reasonNotInService => 'Niet in gebruik';

  @override
  String get reasonWronglyIdentified => 'Verkeerd geïdentificeerd';

  @override
  String get reasonInaccurateInfo => 'Onnauwkeurige informatie';

  @override
  String get reasonOther => 'Overig';

  @override
  String get submit => 'Verzenden';

  @override
  String get cancel => 'Annuleren';

  @override
  String get riskLevel => 'Risiconiveau';

  @override
  String get riskLevelLow => 'Laag';

  @override
  String get riskLevelHigh => 'Hoog';

  @override
  String agreeVotes(int count) {
    return 'Eens: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Totaal: $count';
  }

  @override
  String get voteAgree => 'Eens';

  @override
  String get voteDisagree => 'Oneens';

  @override
  String createdAt(String date) {
    return 'Gemaakt: $date';
  }

  @override
  String get verificationReport => 'Verificatierapport';

  @override
  String get proposalStatistics => 'Voorstelstatistieken';

  @override
  String get totalProposals => 'Totaal voorstellen';

  @override
  String get activeProposals => 'Actieve voorstellen';

  @override
  String get proposalCreated => 'Voorstel succesvol aangemaakt';

  @override
  String get voteSubmitted => 'Stem succesvol ingediend';

  @override
  String get noProposalsFound => 'Geen voorstellen gevonden';

  @override
  String get refreshProposals => 'Voorstellen vernieuwen';

  @override
  String get totalPendingProposals => 'Totaal openstaande voorstellen';

  @override
  String get highRisk => 'Hoog risico';

  @override
  String get mediumRisk => 'Gemiddeld risico';

  @override
  String get lowRisk => 'Laag risico';

  @override
  String get communityImpact => 'Community Impact';

  @override
  String get criticalIssues => 'Kritieke problemen';

  @override
  String get communityParticipation => 'Community deelname';

  @override
  String get noActivity => 'Geen activiteit';

  @override
  String get low => 'Laag';

  @override
  String get moderate => 'Gemiddeld';

  @override
  String get high => 'Hoog';

  @override
  String get veryHigh => 'Zeer hoog';

  @override
  String get voted => 'Gestemd';

  @override
  String get communityVotes => 'Community stemmen';

  @override
  String get waitingForMoreVotes => 'Wachten op meer community stemmen';

  @override
  String get proposalProcessed => 'Dit voorstel is verwerkt';

  @override
  String get supported => 'ONDERSTEUND';

  @override
  String get opposed => 'AFGEWEZEN';

  @override
  String get approved => 'GOEDGEKEURD';

  @override
  String get rejected => 'AFGEKEURD';

  @override
  String get completed => 'VOLTOOID';

  @override
  String get pending => 'IN AFWACHTING';

  @override
  String get critical => 'Kritiek';

  @override
  String get oppose => 'Tegenstemmen';

  @override
  String get veryLow => 'Zeer laag';

  @override
  String get deletionProposals => 'Verwijderingsvoorstellen';

  @override
  String get deletionProposalNotificationDescription =>
      'Meldingen over de resultaten en updates van de stemmingen voor verwijderingsvoorstellen.';

  @override
  String get deletionProposalCreated => 'Verwijderingsvoorstel aangemaakt';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Uw verwijderingsvoorstel voor $phoneNumber is ingediend voor community review.';
  }

  @override
  String get proposalApproved => 'Voorstel Goedgekeurd ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Het verwijderingsvoorstel voor $phoneNumber is goedgekeurd door de community ($supportPercentage% ondersteuning, $totalVotes stemmen).';
  }

  @override
  String get proposalRejected => 'Voorstel Afgekeurd ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Het verwijderingsvoorstel voor $phoneNumber is afgewezen door de community ($supportPercentage% ondersteuning, $totalVotes stemmen).';
  }

  @override
  String get communityVotingStarted => 'Community stemmen gestart';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Een nieuw verwijderingsvoorstel voor $phoneNumber is nu open voor community stemmen.';
  }

  @override
  String get votingCompleted => 'Stemmen voltooid';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Community stemmen voor $phoneNumber is beëindigd. Resultaat: $result ($supportPercentage% ondersteuning).';
  }

  @override
  String get newVoteReceived => 'Nieuwe stem ontvangen';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Iemand heeft gestemd om de verwijdering van $phoneNumber te $voteType. Huidige stemmen: $totalVotes.';
  }

  @override
  String get voteCount => 'Aantal stemmen';

  @override
  String get deletionProposalDescription =>
      'Stel nummers voor ter verwijdering die communityrichtlijnen schenden. Uw deelname helpt het platform veilig te houden.';

  @override
  String get searchProposals => 'Voorstellen zoeken';

  @override
  String get defaultNotifications => 'Standaardmeldingen';

  @override
  String get defaultNotificationsDescription =>
      'Standaard meldingskanaal voor de app.';

  @override
  String get blockedCallNotifications => 'Geblokkeerde oproepmeldingen';

  @override
  String get blockedCallNotificationsDescription =>
      'Toont informatie over geblokkeerde oproepen.';

  @override
  String get stirVerification => 'STIR/SHAKEN Verificatie';

  @override
  String get stirVerificationDescription =>
      'Toont STIR/SHAKEN verificatieresultaten voor nummers.';

  @override
  String get fraudAlerts => 'Fraude waarschuwingen';

  @override
  String get fraudAlertsDescription =>
      'Toont waarschuwingen voor potentieel frauduleuze oproepen.';

  @override
  String get notificationMode => 'Meldingsmodus';

  @override
  String get pendingProposals => 'In afwachting van voorstellen';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count openstaande voorstellen',
      one: '1 openstaand voorstel',
      zero: 'geen openstaande voorstellen',
    );
    return 'U heeft $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Richtlijnen';

  @override
  String get riskLevelLabel => 'Risiconiveau';

  @override
  String get phoneNumberMinDigits =>
      'Telefoonnummer moet minimaal 7 cijfers bevatten';

  @override
  String get provideDetailedExplanation =>
      'Geef een gedetailleerde uitleg (minimaal 10 tekens)';

  @override
  String get reasonMinCharacters => 'Reden moet minimaal 10 tekens bevatten';

  @override
  String get countryCodeTwoLetters => 'Landcode (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Landcode (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'bijv. NL, BE, DE';

  @override
  String get countryCodeRequired => 'Landcode is verplicht';

  @override
  String get phoneNumberHint => 'Voer telefoonnummer in';

  @override
  String get phoneNumberRequired => 'Telefoonnummer is vereist';

  @override
  String get reasonRequired => 'Reden is verplicht';

  @override
  String get riskLevelCritical => 'Kritiek';

  @override
  String get riskLevelMedium => 'Medium';

  @override
  String get riskLevelVeryLow => 'Zeer Laag';

  @override
  String get notificationFrequencyTitle => 'Meldingsfrequentie';

  @override
  String errorMessage(String error) {
    return 'Fout: $error';
  }

  @override
  String get reportingGuidelines =>
      '• Rapporteer alleen nummers die echt problematisch zijn\n• Geef nauwkeurige en gedetailleerde redenen\n• Kies het juiste risiconiveau op basis van de ernst\n• Valse meldingen kunnen leiden tot accountbeperkingen';

  @override
  String get notificationFrequencyHours => 'Meldingsfrequentie (Uren)';

  @override
  String supportCount(int supportCount) {
    return 'Ondersteuning ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Tegenstand ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes stemmen ($supportPercentage% ondersteuning)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uur',
      one: '1 uur',
      zero: '0 uur',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Belangrijke Mededeling';

  @override
  String get dataSourceDisclaimer =>
      'Nummers zijn afkomstig van internet en door gebruikers ingediende gegevens. We kunnen niet garanderen dat een nummer, eenmaal verwijderd, niet opnieuw wordt ingediend door andere gebruikers of bronnen. Zoek en verifieer informatie actief.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Locatie';

  @override
  String get simCardTitle => 'SIM-kaart';

  @override
  String get liveActivitiesSettingsTitle => 'Live Activiteiten Instellingen';

  @override
  String get elementsSettingsTitle => 'Elementen Instellingen';

  @override
  String get liveActivityMode => 'Live Activiteit';

  @override
  String get liveActivityModeDescription =>
      'Toont oproepinformatie als een persistente melding op het vergrendelingsscherm en in de Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'Telefoonnummer Type';

  @override
  String get liveActivitiesTestEndActivity => 'Activiteit Beëindigen';

  @override
  String get liveActivitiesTestSendNewActivity => 'Nieuwe Activiteit Verzenden';

  @override
  String get liveActivitiesTestUpdateActivity => 'Activiteit Bijwerken';

  @override
  String get liveActivityControlsTitle => 'Live Activiteit Bedieningselementen';

  @override
  String get liveActivitiesTestTitle => 'Live Activiteiten Test';

  @override
  String get liveNotificationCustomizationTitle => 'Live Melding Aanpassing';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Pas het uiterlijk van live meldingen aan.';

  @override
  String get notification_instructions =>
      'Instructies:\n1. Tik op \"VERSTUUR\" om een melding te maken of bij te werken.\n2. Ga naar uw startscherm of trek de meldingslade naar beneden om het resultaat te zien.\n3. Tik op \"BEËINDIG\" om de melding te sluiten.';

  @override
  String get autoCancelNotification => 'Automatisch Annuleren Melding';

  @override
  String get autoCancelNotificationDescription =>
      'Indien aangevinkt, wordt de melding automatisch gesloten wanneer de gebruiker erop tikt.';

  @override
  String get setDelayTime => 'Vertraging instellen';

  @override
  String get proposalDetails => 'Voorstel Details';

  @override
  String get proposalNotFound => 'Voorstel niet gevonden';

  @override
  String get processed => 'Verwerkt';

  @override
  String get filterAndSortTitle => 'Filteren en Sorteren';

  @override
  String get filterVerifiedOwner => 'Filter Geverifieerde Eigenaar';

  @override
  String get filterBy => 'Filteren Op';

  @override
  String get sortOldest => 'Sorteren Oudste';

  @override
  String get sortNewest => 'Sorteren Nieuwste';

  @override
  String get sortMostPopular => 'Sorteren Meest Populair';

  @override
  String get sortLeastPopular => 'Sorteren Minst Populair';

  @override
  String get sortBy => 'Sorteren Op';

  @override
  String get simRulesNotFound => 'SIM-regels niet gevonden';

  @override
  String get simSlotRules => 'SIM-slot Regels';

  @override
  String get noSimCardDetected => 'Geen SIM-kaart gedetecteerd';

  @override
  String get invalidSimData => 'Ongeldige SIM-gegevens';

  @override
  String get simSlot => 'SIM-slot';

  @override
  String get enableFiltering => 'Filteren Inschakelen';

  @override
  String get detailedSettingsTitle => 'Gedetailleerde Instellingen';

  @override
  String get entryPointViewTitle => 'Entry Point View';

  @override
  String get callTypeRejected => 'Geweigerd';

  @override
  String get callTypeSilenced => 'Stilgezet';

  @override
  String andMoreItems(int count) {
    return 'en nog $count items';
  }

  @override
  String get ruleType => 'Regeltype';

  @override
  String get localDatabaseSyncTitle => 'Lokale databasesynchronisatie';

  @override
  String get localDatabaseSyncSubtitle =>
      'Gegevens synchroniseren tussen apparaten';

  @override
  String get supabaseProjectUrl => 'Supabase Project-URL';

  @override
  String get supabaseAnonKey => 'Anonieme sleutel';

  @override
  String get supabaseAnonKeyHint => 'API Key, anonieme openbare sleutel';

  @override
  String get connectionString => 'Verbindingsreeks (URI)';

  @override
  String get connectionStringHelper =>
      'Alleen nodig voor \'Database initialiseren\'';

  @override
  String get syncCallHistory => 'Oproepgeschiedenis synchroniseren';

  @override
  String get syncCallHistorySubtitle =>
      'Prive-oproepjournalen opnemen in synchronisatie';

  @override
  String get requiredField => 'Verplicht';

  @override
  String get requiredInitField => 'Verplicht voor initialisatie';

  @override
  String get initDbButton => 'Database initialiseren';

  @override
  String get dbInitSuccess => 'Database succesvol geïnitialiseerd!';

  @override
  String syncSuccess(int pushed, int pulled) {
    return 'Synchronisatie voltooid. Verzonden: $pushed, Ontvangen: $pulled';
  }

  @override
  String get errorPrefix => 'Fout';

  @override
  String get errorLoadingSettings => 'Fout bij laden van instellingen';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusConnected => 'Verbonden / Geconfigureerd';

  @override
  String get statusNotConfigured => 'Niet geconfigureerd';

  @override
  String get configSaved => 'Configuratie opgeslagen!';

  @override
  String get masterDeviceLabel => 'Hoofdapparaat (Admin)';

  @override
  String get masterDeviceHelp =>
      'Alleen het hoofdapparaat kan de databasestructuur initialiseren.';

  @override
  String get syncIntervalLabel => 'Automatische synchronisatie-interval';

  @override
  String syncIntervalValue(int hours) {
    return 'Om de $hours uur';
  }

  @override
  String get leaveEmptyToUseDefault =>
      'Laat leeg om standaardwaarde te gebruiken';

  @override
  String get vipAccessSubtitle => 'Bekijk gratis advertenties of koop VIP';

  @override
  String failedToLoadSettingsSchema(String error) {
    return 'Laden van instellingenschema mislukt: $error';
  }

  @override
  String get fieldIsRequired => 'Veld is verplicht';

  @override
  String get answerThenHangupDescription =>
      'Beantwoord de oproep eerst en hang daarna direct op.';

  @override
  String get initialSetupTitle => 'Regelbibliotheek instellen';

  @override
  String get initialSetupDesc =>
      'Selecteer de regionale regelbibliotheken die u wilt blokkeren. Deze regels helpen u om veel voorkomende verkoop- en oplichtingsgesprekken in uw regio automatisch te blokkeren.';

  @override
  String get initialSetupRetry => 'Opnieuw proberen';

  @override
  String get initialSetupSkip => 'Overslaan';

  @override
  String get initialSetupSave => 'Geselecteerde met één klik instellen';

  @override
  String get initialSetupSaving => 'Opslaan...';

  @override
  String get initialSetupSaveSuccess =>
      '✅ Configuratie succesvol opgeslagen, regels worden binnenkort automatisch opgehaald';

  @override
  String initialSetupSaveFailed(String error) {
    return 'Opslaan van configuratie mislukt: $error';
  }

  @override
  String get initialSetupGetFailed => 'Ophalen van configuratie mislukt';

  @override
  String get initialSetupSourceTitle => 'Bron van regeldatabase';

  @override
  String get initialSetupSourceGithub => 'Officiële GitHub-bron';

  @override
  String get initialSetupSourceCdn => 'Spiegel-CDN-versnellingsbron';

  @override
  String get initialSetupSourceCustom => 'Zelfgehoste spiegelbron';

  @override
  String get initialSetupCustomUrlHint =>
      'Voer zelfgehoste spiegel JSON-configuratie-URL in';

  @override
  String get initialSetupCustomUrlLoad => 'Configuratie laden';

  @override
  String get initialSetupDetectedLocation => 'Gedetecteerde locatie';

  @override
  String deepLinkImportTitle(String type) {
    return 'Configuratie importeren';
  }

  @override
  String get deepLinkTypePlugin => 'Plugin';

  @override
  String get deepLinkTypeSubscription => 'Abonnement';

  @override
  String get deepLinkDefaultPluginName => 'Geïmporteerde plugin';

  @override
  String get deepLinkDefaultSubName => 'Geïmporteerd abonnement';

  @override
  String get deepLinkDetectedTitle => 'Deep link gedetecteerd';

  @override
  String deepLinkNameLabel(String name) {
    return 'Naam';
  }

  @override
  String deepLinkTypeLabel(String type) {
    return 'Type';
  }

  @override
  String deepLinkUrlLabel(String url) {
    return 'URL';
  }

  @override
  String get deepLinkConfirmButton => 'Import bevestigen';

  @override
  String get deepLinkEmptyUrlError => 'URL mag niet leeg zijn';

  @override
  String deepLinkPluginDownloadFailed(Object error) {
    return 'Downloaden van plugin mislukt: $error';
  }

  @override
  String get deepLinkImportSuccess => 'Succesvol geïmporteerd';

  @override
  String deepLinkImportFailed(String error) {
    return 'Import mislukt: $error';
  }

  @override
  String get initialSetupSettingsHint =>
      'Tip: U kunt deze instellingspagina op elk moment opnieuw openen via Instellingen.';

  @override
  String get initialSetupGoToSettings => 'Ga naar Instellingen';

  @override
  String get separateSims => 'Afzonderlijke SIM-kaarten';

  @override
  String get separateSimsDesc =>
      'Schakel aparte filterregels in voor elke SIM-kaart';

  @override
  String get masterAndOverrides => 'Hoofdbediening';

  @override
  String get masterAndOverridesDesc => 'Globale regelinstellingen';
}
