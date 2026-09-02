// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get aboutContactSubscription => 'Om kontaktabonnement';

  @override
  String get aboutLabels => 'Om etiketter';

  @override
  String get aboutPhoneSubscriptionRules => 'Om telefonabonnementregler';

  @override
  String get aboutPhoneSubscriptions => 'Om telefonabonnementer';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Abonner på telefonregellister via URL, opdater automatisk regler. Understøtter regel-filer i JSON, CSV-format.';

  @override
  String get aboutSmsFilter => 'Om SMS-filtrering';

  @override
  String get aboutSmsSubscriptionRules => 'Om SMS-abonnementregler';

  @override
  String get aboutSubtitle => 'Applikationsversion og juridisk information';

  @override
  String get aboutTitle => 'Om';

  @override
  String get action => 'Handling';

  @override
  String get actionAll => 'Alle';

  @override
  String get actionAllow => 'Tillad';

  @override
  String get actionBlock => 'Bloker';

  @override
  String get actionFilterAll => 'Alle filtre';

  @override
  String get actionFilterTitle => 'Filtrer efter handlingstype';

  @override
  String get actionFilterTooltip => 'Handlingsfilter';

  @override
  String get actionNone => 'Ingen handling';

  @override
  String get actionSilence => 'Lydløs';

  @override
  String actionTag(Object actionType) {
    return 'Handling: $actionType';
  }

  @override
  String get actionType => 'Handlingstype';

  @override
  String get actionUnknown => 'Ukendt';

  @override
  String get add => 'Tilføj';

  @override
  String get addAllowedBlockedRule => 'Tilføj tillad/bloker regel';

  @override
  String get addAllowSubscription => 'Tilføj tillad abonnement';

  @override
  String get addBlockSubscription => 'Tilføj bloker abonnement';

  @override
  String get addContactButton => 'Tilføj kontakt';

  @override
  String addContactFailed(Object error) {
    return 'Kunne ikke tilføje kontakt: $error';
  }

  @override
  String get addedToAllowedRules => 'Tilføjet til tilladte regler';

  @override
  String get addedToBlacklist => 'Tilføjet til sortliste';

  @override
  String get addedToBlockedRules => 'Tilføjet til blokerede regler';

  @override
  String get addedToFavoriteContacts => 'Tilføjet til favoritkontakter';

  @override
  String get addedToFavorites => 'Tilføjet til favoritter';

  @override
  String get addedToWhitelist => 'Tilføjet til hvidliste';

  @override
  String get addFavorite => 'Tilføj favorit';

  @override
  String get addFilter => 'Tilføj filter';

  @override
  String get addLabel => 'Tilføj etikette';

  @override
  String get addLabelButton => 'Tilføj etikette';

  @override
  String addLabelFailed(Object error) {
    return 'Kunne ikke tilføje etikette: $error';
  }

  @override
  String get addLabelToCall => 'Tilføj etikette til opkaldsregistrering';

  @override
  String get addName => 'Tilføj navn';

  @override
  String get addNoneSubscription => 'Tilføj ingen abonnement';

  @override
  String get addOrEditContactInfo =>
      'Bruges til at tilføje eller redigere kontaktoplysninger';

  @override
  String get addPhoneMark => 'Tilføj telefonmarkering';

  @override
  String get addPhoneNumberRule => 'Tilføj telefonnummerregel';

  @override
  String get addPlugin => 'Tilføj plugin';

  @override
  String get addPluginFailed => 'Kunne ikke tilføje plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Kunne ikke tilføje plugin: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Tilføj plugin fra lokal fil';

  @override
  String get addPluginFromUrl => 'Tilføj plugin fra URL';

  @override
  String get addRegexRule => 'Tilføj Regex-regel';

  @override
  String get addRule => 'Tilføj regel';

  @override
  String get addRuleButton => 'Tilføj regel';

  @override
  String addRuleFailed(Object error) {
    return 'Kunne ikke tilføje regel: $error';
  }

  @override
  String get addRuleTooltip => 'Tilføj regel';

  @override
  String get addSilenceSubscription => 'Tilføj lydløs abonnement';

  @override
  String get addSimRuleButton => 'Tilføj SIM-regel';

  @override
  String get addSmsFilterRule => 'Tilføj SMS-filterregel';

  @override
  String get addSmsRule => 'Tilføj SMS-regel';

  @override
  String get addSmsSubscription => 'Tilføj SMS-abonnement';

  @override
  String get addSubscription => 'Tilføj abonnement';

  @override
  String get addSubscriptionButton => 'Tilføj abonnement';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Kunne ikke tilføje abonnement: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Tilføj abonnement';

  @override
  String get addToAllowedRules => 'Tilføj til tilladte regler';

  @override
  String get addToBlacklist => 'Tilføj til sortliste';

  @override
  String get addToBlockedRules => 'Tilføj til blokerede regler';

  @override
  String get addToFavoriteContacts => 'Tilføj til favoritkontakter';

  @override
  String get addToFavorites => 'Tilføj til favoritter';

  @override
  String get addToRules => 'Tilføj til regler';

  @override
  String get addToWhitelist => 'Tilføj til hvidliste';

  @override
  String get adPlaceholder => 'Annoncepladsholder';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Alle';

  @override
  String get allCallsTab => 'Alle';

  @override
  String get allDataClearedSuccessfully => 'Alle data er ryddet med succes';

  @override
  String get allow => 'Tillad';

  @override
  String get allowAllAllowRules => 'Tillad alle tilladelsesregler';

  @override
  String get allowAllAllowRulesDesc => 'Tillad opkald fra tilladelsesregler';

  @override
  String get allowAllBlacklistedNumbers => 'Tillad alle sortlistede numre';

  @override
  String get allowAllBlacklistedNumbersDesc => 'Tillad opkald fra sortlisten';

  @override
  String get allowAllBlockRules => 'Tillad alle blokeringsregler';

  @override
  String get allowAllBlockRulesDesc => 'Tillad opkald fra blokeringsregler';

  @override
  String get allowAllowedNumbers => 'Tillad tilladte numre';

  @override
  String get allowAllowedNumbersDesc => 'Tillad opkald fra hvidlisten';

  @override
  String get allowBlock => 'Tillad/Bloker';

  @override
  String get allowBlockedNumbers => 'Tillad blokerede numre';

  @override
  String get allowBlockedNumbersDesc => 'Tillad opkald fra sortlisten';

  @override
  String get allowedBlockedRule => 'Tillad/Bloker regel';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'Rediger tillad/bloker regel';

  @override
  String get allowedBlockedRuleManagement =>
      'Tillad/Bloker regeladministration';

  @override
  String get allowNonExceededNumbers =>
      'Tillad numre, der ikke overskrider tærsklen';

  @override
  String get allowNonExceededNumbersDescription =>
      'Tillad automatisk numre, der ikke overskrider tærsklen';

  @override
  String get allowRegexAllowRules => 'Tillad Regex-tilladelsesregler';

  @override
  String get allowRegexAllowRulesDesc =>
      'Aktiver regex-mønstermatchning for tilladelsesregler';

  @override
  String get allowRegexAllowRulesDescription =>
      'Aktiver regex-baserede tilladelsesregler';

  @override
  String get allowRegexBlockRules => 'Tillad Regex-blokeringsregler';

  @override
  String get allowRegexBlockRulesDesc =>
      'Aktiver regex-mønstermatchning for blokeringsregler';

  @override
  String get allowRegexBlockRulesDescription =>
      'Aktiver regex-baserede blokeringsregler';

  @override
  String get allowRule => 'Tilladelsesregel';

  @override
  String get allowRules => 'Tilladelsesregler';

  @override
  String get allowWhitelistedNumbers => 'Tillad Hvidlistede Numre';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Tillad alle numre på hvidlisten';

  @override
  String get allPermissionsGranted => 'Alle tilladelser givet';

  @override
  String get allSettingsCompleted => 'Alle indstillinger fuldført.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Alle opdateringer fuldført ($count regler)';
  }

  @override
  String get answerThenHangup => 'Besvar og læg derefter på';

  @override
  String get appLegalese =>
      '© 2023 Your Call Your Rule. Alle rettigheder forbeholdes.';

  @override
  String get applicationSoftware => 'Applikationssoftware';

  @override
  String get apply => 'Anvend';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Autorisation mislykkedes: Kontroller klient-id og nøgle';

  @override
  String get authorizationFailedMessage => 'Autorisation mislykkedes';

  @override
  String get authorizationSuccessMessage => 'Autorisation vellykket';

  @override
  String get authorizeLoginButton => 'Autoriser login';

  @override
  String get automotiveIndustry => 'Bilindustrien';

  @override
  String get autoSyncLabel => 'Automatisk synkronisering';

  @override
  String get autoUpdate => 'Automatisk opdatering';

  @override
  String get autoUpdateDescription =>
      'Indstil automatiske opdateringsintervaller for abonnementer eller opdater manuelt';

  @override
  String get autoUpdateSettings => 'Indstillinger for automatisk opdatering';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Administrer automatiske opdateringer til regler og plugins';

  @override
  String get autoUpdateSettingsTitle =>
      'Indstillinger for automatisk opdatering';

  @override
  String get autoUpdateSubtitle =>
      'Administrer automatiske opdateringer til regler og plugins';

  @override
  String get autoUpdateTitle => 'Automatisk opdatering';

  @override
  String get avatarBorderColor => 'Avatar kantfarve';

  @override
  String get avatarBorderSize => 'Avatar kantstørrelse';

  @override
  String get avatarIconSizesSetting => 'Avatar & Ikonstørrelser';

  @override
  String get avatarPosition => 'Avatar Position';

  @override
  String get avatarSize => 'Avatar størrelse';

  @override
  String axisPosition(Object axis) {
    return '$axis Position';
  }

  @override
  String get backgroundGradientSetting => 'Baggrundsgradient';

  @override
  String get backup => 'Sikkerhedskopi';

  @override
  String get backupAndRestore => 'Sikkerhedskopi og gendannelse';

  @override
  String get backupAndRestoreSubtitle =>
      'Sikkerhedskopier eller gendan applikationsdata';

  @override
  String get backupAndRestoreTitle => 'Sikkerhedskopi & Gendannelse';

  @override
  String get backupFailed => 'Sikkerhedskopi mislykkedes';

  @override
  String get backupFailedMessage => 'Sikkerhedskopi mislykkedes';

  @override
  String backupFailedWithError(Object error) {
    return 'Sikkerhedskopi mislykkedes: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'Sikkerhedskopier eller gendan applikationsdata';

  @override
  String get backupRestoreTitle => 'Sikkerhedskopi & Gendannelse';

  @override
  String get backupSectionTitle => 'Sikkerhedskopi';

  @override
  String get backupSettings => 'Indstillinger for sikkerhedskopi';

  @override
  String get backupSettingsDialogTitle => 'Indstillinger for sikkerhedskopi';

  @override
  String get backupSettingsTitle => 'Indstillinger for sikkerhedskopi';

  @override
  String get backupSuccessMessage => 'Sikkerhedskopieret til skyen med succes';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Sikkerhedskopi lykkedes til: $path';
  }

  @override
  String get backupToCloud => 'Sikkerhedskopi til skyen';

  @override
  String get backupToCloudDescription =>
      'Sikkerhedskopier indstillinger og regler til cloud-lager';

  @override
  String backupToCloudFailed(Object error) {
    return 'Kunne ikke sikkerhedskopiere til skyen: $error';
  }

  @override
  String get backupToCloudLabel => 'Sikkerhedskopi til skyen';

  @override
  String get backupToCloudSuccess => 'Sikkerhedskopieret til skyen med succes';

  @override
  String get backupToCloudTitle => 'Sikkerhedskopi til skyen';

  @override
  String get backupToLocalLabel => 'Sikkerhedskopi til lokal';

  @override
  String get bank => 'Bank';

  @override
  String get basicInfo => 'Grundlæggende oplysninger';

  @override
  String get basicRuleFilter => 'Grundlæggende regel Filter';

  @override
  String get basicRuleFiltering => 'Grundlæggende regel Filtrering';

  @override
  String get basicRuleFilteringExplanation =>
      '• Grundlæggende regel filtrering: Filtrering af regler baseret på sortliste, hvidliste og regex';

  @override
  String get basicRuleFilterSettings =>
      'Indstillinger for grundlæggende regel Filter';

  @override
  String get basicRuleFilterSubtitle =>
      'Filtrer opkald ved hjælp af sort-/hvidliste og regulære udtryk';

  @override
  String get batchDeleteContacts => 'Slet flere kontakter';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Er du sikker på, at du vil slette $count valgte kontakter?';
  }

  @override
  String get batchDeleteFailed => 'Bulk sletning mislykkedes';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Er du sikker på, at du vil slette $count etiketter?';
  }

  @override
  String get blacklist => 'Sortliste';

  @override
  String get blacklistingAndWhitelisting => 'Sortlistning og hvidlistning';

  @override
  String get blacklistLabel => 'Sortliste';

  @override
  String get blackWhiteList => 'Sort/Hvid Liste';

  @override
  String get block => 'Bloker';

  @override
  String get blockCalls => 'Bloker opkald';

  @override
  String get blocked => 'Blokeret';

  @override
  String get blockedCallAction => 'Blokeret opkalds handling';

  @override
  String get blockedCalls => 'Blokerede opkald';

  @override
  String get blockedCallsTitle => 'Blokerede opkald';

  @override
  String get blockedCommunications => 'Blokerede kommunikationer';

  @override
  String get blockedPhoneLabel => 'Blokerede opkald';

  @override
  String get blockedSpamCalls => 'Blokerede spam-opkald';

  @override
  String get blockingTrend => 'Blokeringstrend';

  @override
  String get blockInternationalCalls =>
      'matcher numre, der ikke starter med + eller 00';

  @override
  String get blockInternationalCallsTitle => 'Bloker internationale opkald';

  @override
  String get blockLandlineNumbersTitle => 'Bloker fastnetnumre';

  @override
  String get blockMobileNumbers => 'matcher numre, der ikke starter med 13-19';

  @override
  String get blockMobileNumbersTitle => 'Bloker mobilnumre';

  @override
  String get blockPremiumRateNumbers =>
      'matcher numre, der ikke starter med 118 eller 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'Bloker premium-rate numre';

  @override
  String get blockRule => 'Bloker regel';

  @override
  String get blockRules => 'Bloker regler';

  @override
  String get blockSpecificAreaCodes =>
      'matcher numre, der starter med 0 + 2-3 cifre';

  @override
  String get blockSpecificAreaCodesTitle => 'Bloker specifikke områder koder:';

  @override
  String get blockTypeAnalysisTitle => 'Blokeringstype Analyse';

  @override
  String get both => 'Begge';

  @override
  String get bulkDelete => 'Slet flere kontakter';

  @override
  String get bulkDeleteContacts => 'Slet flere kontakter';

  @override
  String get bulkDeleteLabels => 'Slet flere etiketter';

  @override
  String get call => 'Opkald';

  @override
  String get callback => 'Ring tilbage';

  @override
  String callbackTo(String number) {
    return 'Ring tilbage til $number';
  }

  @override
  String get callBlocking => 'Opkaldsblokering';

  @override
  String get callerIdApp => 'OpkaldsID App';

  @override
  String get callerIdCustomizationTitle => 'Tilpas OpkaldsID';

  @override
  String get callerIdDialogTitle => 'OpkaldsID Information';

  @override
  String get callerIdDisplayMode => 'Opkalds-ID Visningstilstand';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Markeret af $count';
  }

  @override
  String get callerIdPreview => 'Opkalds-ID Forhåndsvisning';

  @override
  String get callFilter => 'Opkaldsfilter';

  @override
  String get callFilterDescription =>
      'Når aktiveret, tjekkes indkommende opkald mod regellisten nedenfor. Opkaldsfiltreringsregler synkroniseres ikke mellem enheder som standard.';

  @override
  String get callFilterRules => 'Opkaldsfiltreringsregler';

  @override
  String get callFilterRulesDescription =>
      'Indstil grundlæggende regler for opkaldsfiltrering';

  @override
  String get callFilterSettings => 'Indstillinger for opkaldsfiltrering';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Indstil grænser for opkaldsfrekvens og blokeringsregler';

  @override
  String get callFrequencyInterceptionTitle => 'Opkaldsfrekvensaflytning';

  @override
  String get callHistory => 'Opkaldshistorik';

  @override
  String get callHistoryInfoDesc =>
      'Her vises din opkaldshistorik, herunder indgående, udgående og ubesvarede opkald.';

  @override
  String get callHistoryInfoTitle => 'Opkaldshistorik';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Kunne ikke initialisere opkaldshistorik: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Kunne ikke opdatere opkaldshistorik: $error';
  }

  @override
  String get callHistoryTab => 'Opkaldshistorik';

  @override
  String get callHistoryTimelineEarlier => 'Tidligere';

  @override
  String get callHistoryTimelineToday => 'I dag';

  @override
  String get callHistoryTimelineYesterday => 'I går';

  @override
  String get callScreeningPermission => 'Tilladelse til opkaldsscreening';

  @override
  String get callScreeningPermissionDescription =>
      ' Bruges til at screene og blokere spamopkald.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Tilladelse til opkaldsscreening ikke givet, kan påvirke appens funktionalitet.';

  @override
  String get callSettingsSubtitle =>
      'Indstillinger for opkalds-ID, filtrering og blokering';

  @override
  String get callSettingsTitle => 'Opkaldsindstillinger';

  @override
  String get callStatistics => 'Opkaldsstatistik';

  @override
  String get callTypeAnswered => 'Besvaret';

  @override
  String get callTypeBlocked => 'Blokeret';

  @override
  String get callTypeIconColor => 'Farve på opkaldstypeikon';

  @override
  String get callTypeMissed => 'Ubesvaret opkald';

  @override
  String get callTypeOutgoing => 'Udgående';

  @override
  String get callTypePosition => 'Position for opkaldstype';

  @override
  String get callTypeUnknown => 'Ukendt';

  @override
  String get cancelButton => 'Annuller';

  @override
  String get carRental => 'Biludlejning';

  @override
  String get carrier => 'Udbyder';

  @override
  String get carrierColor => 'Udbyderfarve';

  @override
  String get carrierFontSize => 'Udbyder skriftstørrelse';

  @override
  String get carrierPosition => 'Udbyderposition';

  @override
  String get changeLabel => 'Skift mærkat';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Kunne ikke ændre plugin-status: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Kunne ikke ændre abonnementsstatus: $error';
  }

  @override
  String get changeTag => 'Skift tag';

  @override
  String get charity => 'Velgørenhed';

  @override
  String chartMonthFormat(int month) {
    return 'Måned $month';
  }

  @override
  String get chartOneDayAgo => 'For 1 dag siden';

  @override
  String get chartOneMonthAgo => 'For 1 måned siden';

  @override
  String get chartOneWeekAgo => 'For 1 uge siden';

  @override
  String get chartTenDaysAgo => 'For 10 dage siden';

  @override
  String get chartThreeDaysAgo => 'For 3 dage siden';

  @override
  String get chartToday => 'I dag';

  @override
  String get checkFileFormat => 'Tjek venligst filformat eller tilladelser';

  @override
  String checkPermissionFailed(Object error) {
    return 'Kunne ikke tjekke tilladelser: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'Vælg standard aflytningshandling';

  @override
  String get clearAllData => 'Ryd alle data';

  @override
  String get clearAllDataConfirmation =>
      'Er du sikker på, at du vil rydde alle applikationsdata? Denne handling kan ikke fortrydes.';

  @override
  String get clearAllDataDescription => 'Ryd alle applikationsdata';

  @override
  String get clearAllDataLabel => 'Ryd alle data';

  @override
  String get clearFilter => 'Ryd filter';

  @override
  String get clearLabelFilter => 'Ryd mærkatfilter';

  @override
  String get clearLabelFilterButton => 'Ryd mærkatfilter';

  @override
  String get closeButton => 'Luk';

  @override
  String get cloudSync => 'Cloud Sync';

  @override
  String get cloudSyncAndBackupTitle => 'Cloud Sync & Backup';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Konfigurer WebDAV, OneDrive og Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Cloud Sync Indstillinger';

  @override
  String get cloudSyncTitle => 'Cloud Sync';

  @override
  String get collapseLabelSelector => 'Luk mærkatvælger';

  @override
  String get collection => 'Inkasso';

  @override
  String get colorPickerTitle => 'Vælg farve';

  @override
  String get configManagement => 'Konfigurationsstyring';

  @override
  String get configUpdated => 'Konfiguration opdateret';

  @override
  String get configurationAdvice =>
      'Gennem korrekt konfiguration kan du indstille forskellige filtreringsstrategier for arbejds- og private SIM-kort.';

  @override
  String get configureBackupOptions => 'Konfigurer backup-indstillinger';

  @override
  String get configureBackupOptionsSubtitle =>
      'Konfigurer backup-indstillinger';

  @override
  String get configureCloudSyncService => 'Konfigurer Cloud Sync Service';

  @override
  String get configureCloudSyncServiceHint =>
      'Konfigurer venligst en cloud sync-tjeneste for at aktivere synkronisering på tværs af flere enheder.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Konfigurer venligst en cloud sync-tjeneste for at aktivere synkronisering på tværs af flere enheder.';

  @override
  String get configureSimCardFilterRules =>
      'Konfigurer SIM-kort filtreringsregler';

  @override
  String get configureSyncServiceHint =>
      'Konfigurer venligst synkroniseringstjeneste i cloud sync-indstillinger først';

  @override
  String get confirm => 'Bekræft';

  @override
  String get confirmBatchDeleteContacts =>
      'Er du sikker på, at du vil slette de valgte';

  @override
  String get confirmButton => 'Bekræft';

  @override
  String get confirmDelete => 'Bekræft sletning';

  @override
  String get confirmDeleteContact => 'Er du sikker på, at du vil slette';

  @override
  String get confirmDeleteContactName => 'Bekræft sletning?';

  @override
  String get confirmDeleteFilter =>
      'Er du sikker på, at du vil slette dette filter?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Er du sikker på, at du vil slette mærkatet \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Er du sikker på, at du vil slette plugin \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Er du sikker på, at du vil slette $count plugins?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Er du sikker på, at du vil slette denne regel? Denne handling kan ikke fortrydes.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Er du sikker på, at du vil slette de valgte kontakter?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Er du sikker på, at du vil slette denne SMS-filterregel?';

  @override
  String get confirmDeleteSmsRule =>
      'Er du sikker på, at du vil slette denne SMS-regel?';

  @override
  String get confirmDeleteSubscription =>
      'Er du sikker på, at du vil slette dette abonnement?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Er du sikker på, at du vil slette $name?';
  }

  @override
  String get confirmPassword => 'Bekræft adgangskode';

  @override
  String get confirmPasswordLabel => 'Bekræft adgangskode';

  @override
  String get connectedStatus => 'Forbundet';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Forbindelse fejlet: Tjek venligst serveradresse, brugernavn og adgangskode';

  @override
  String get connectionFailedMessage => 'Forbindelse fejlet';

  @override
  String get connectionStatusLabel => 'Forbindelsesstatus';

  @override
  String get connectionSuccessMessage => 'Forbindelse opnået';

  @override
  String get contactAddSuccess => 'Kontakt tilføjet med succes';

  @override
  String get contactDeleted => 'Kontakt slettet';

  @override
  String get contactEditDialog => 'Kontakt Rediger Dialog';

  @override
  String get contactNameHint => 'Indtast kontaktnavn (valgfrit)';

  @override
  String get contactNameLabel => 'Navn';

  @override
  String get contactNameOptional => 'Kontaktnavn (valgfrit)';

  @override
  String get contactNotFound => 'Kontakt ikke fundet';

  @override
  String get contacts => 'kontakter';

  @override
  String contactsDeleted(Object count) {
    return 'Slettet $count kontakter';
  }

  @override
  String get contactSettingsSubtitle =>
      'Kontaktstyring og etiketteindstillinger';

  @override
  String get contactSettingsTitle => 'Kontaktindstillinger';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Kunne ikke indlæse kontakter: $error';
  }

  @override
  String get contactsManagement => 'Kontaktstyring';

  @override
  String get contactsManagementPageTitle => 'Side til Kontaktstyring';

  @override
  String get contactsPageTitle => 'Kontaktstyring';

  @override
  String get contactsPermission => 'Kontakttilladelse';

  @override
  String get contactsPermissionDescription =>
      'Bruges til at identificere kontaktkald.';

  @override
  String get contactsTab => 'Kontakter';

  @override
  String get contactSubscriptionDescription =>
      'Abonner på kontaktlister via URL, opdater automatisk kontaktinformation og etiketter. Understøtter data i JSON-format.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Kunne ikke indlæse kontaktabonnementer: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Kontaktabonnementer';

  @override
  String get contactUpdateSuccess => 'Kontakt opdateret med succes';

  @override
  String get contactUs => 'Kontakt os';

  @override
  String get content => 'Indhold';

  @override
  String get contentRegex => 'Indholdsregler';

  @override
  String get countColor => 'Antalfarve';

  @override
  String get countFontSize => 'Antal skriftstørrelse';

  @override
  String get countPosition => 'Antal position';

  @override
  String get country => 'Land';

  @override
  String get countryNameColor => 'Landsnavn farve';

  @override
  String get countryNameFontSize => 'Landsnavn skriftstørrelse';

  @override
  String get countryRegionNamePosition => 'Land/Regionsnavn position';

  @override
  String get countrySelectionDialog => 'Landvalg dialog';

  @override
  String get countrySelectionDialogDescription =>
      'Bruges til at vælge et land for at forespørge oplysninger om opkalds-id';

  @override
  String get countThresholdDescription =>
      'Indstil minimumstærsklen for antal, der kræves for at udløse filtreringshandlinger';

  @override
  String get countThresholdLabel => 'Antal tærskel';

  @override
  String get countThresholdSettings => 'Antal tærskelindstillinger';

  @override
  String countThresholdValue(Object count) {
    return 'Antal tærskel: $count';
  }

  @override
  String get createdRules => 'Oprettet regler';

  @override
  String get csvFormat => 'CSV-format';

  @override
  String get currentDeviceChip => 'Nuværende';

  @override
  String get currentDeviceLabel => 'Nuværende enhedslabel';

  @override
  String get currentDeviceTitle => 'Nuværende enhed';

  @override
  String get currentLabels => 'Nuværende etiketter:';

  @override
  String get currentLanguage => 'Nuværende sprog';

  @override
  String get currentPasswordLabel => 'Nuværende adgangskode';

  @override
  String get customerService => 'Kundeservice';

  @override
  String get customRange => 'Brugerdefineret område';

  @override
  String get dailyStatistics => 'Daglige statistikker';

  @override
  String get dailyStatisticsDesc =>
      'Modtag daglige statistikker om blokerede opkald og beskeder';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get dataAnalysis => 'Dataanalyse';

  @override
  String get dataAnalysisDashboardPage => 'Side til dataanalyse-dashboard';

  @override
  String get dataExport => 'Dataeksport';

  @override
  String dataLoadFailure(Object error) {
    return 'Data indlæsning fejlede: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Kunne ikke indlæse data: $error';
  }

  @override
  String get dataMigration => 'Datamigrering';

  @override
  String get dataMigrationDescription =>
      'Denne funktion giver dig mulighed for at overføre alle dine data mellem enheder. I øjeblikket kan du bruge backup- og gendannelsesfunktionerne til manuelt at migrere dine data.';

  @override
  String get dataMigrationDialogContent =>
      'Denne funktion giver dig mulighed for at overføre alle dine data mellem enheder. I øjeblikket kan du bruge backup- og gendannelsesfunktionerne til manuelt at migrere dine data.';

  @override
  String get dataMigrationDialogTitle => 'Datamigrering';

  @override
  String get dataMigrationSectionTitle => 'Datamigrering';

  @override
  String get dataSourceReminder => 'Datakilde påmindelse';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dage',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Dage VIP';
  }

  @override
  String get debtCollection => 'Gældsinddrivelse';

  @override
  String get defaultPeriod => 'Uge';

  @override
  String get delete => 'Slet';

  @override
  String get deleteButton => 'Slet';

  @override
  String get deleteContact => 'Slet kontakt';

  @override
  String deleteContactConfirm(Object name) {
    return 'Er du sikker på, at du vil slette $name?';
  }

  @override
  String get deleteContactConfirmation =>
      'Er du sikker på, at du vil slette kontakt';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Er du sikker på, at du vil slette $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Slet enhed';

  @override
  String deleteFailed(Object error) {
    return 'Sletning fejlede: $error';
  }

  @override
  String get deleteFilter => 'Slet filter';

  @override
  String get deleteLabel => 'Slet etikette';

  @override
  String deleteLabelFailed(Object error) {
    return 'Kunne ikke slette etikette: $error';
  }

  @override
  String get deletePlugin => 'Slet plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Kunne ikke slette plugin: $error';
  }

  @override
  String get deletePlugins => 'Slet plugins';

  @override
  String deletePluginsFailed(Object error) {
    return 'Kunne ikke slette plugins: $error';
  }

  @override
  String get deleteRule => 'Slet regel';

  @override
  String deleteRuleFailed(Object error) {
    return 'Sletning fejlede: $error';
  }

  @override
  String get deleteSelected => 'Slet valgte';

  @override
  String get deleteSmsRule => 'Slet SMS-regel';

  @override
  String get deleteSubscription => 'Slet abonnement';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Er du sikker på, at du vil slette abonnementet \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Kunne ikke slette abonnement: $error';
  }

  @override
  String get deleteSuccess => 'Sletning lykkedes';

  @override
  String get delivery => 'Levering';

  @override
  String get deviceDeletedSuccessfully => 'Enhed slettet med succes';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Enhed slettet med succes';

  @override
  String get deviceIdLabel => 'Enheds ID';

  @override
  String get deviceIDLabel => 'Enheds ID';

  @override
  String get deviceManagementSubtitle =>
      'Administrer synkronisering af flere enheder';

  @override
  String get deviceManagementTitle => 'Enhedsstyring';

  @override
  String get deviceModelLabel => 'Enhedsmodel';

  @override
  String get deviceName => 'Enhedsnavn';

  @override
  String get deviceNameCannotBeEmpty => 'Enhedsnavn må ikke være tomt';

  @override
  String get deviceNameHint => 'Indtast venligst enhedsnavn';

  @override
  String get deviceNameLabel => 'Enhedsnavn';

  @override
  String get deviceRenamedSuccessfully => 'Enhed omdøbt med succes';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Enhed omdøbt med succes';

  @override
  String get devicesSyncedSuccessfully => 'Enheder synkroniseret med succes';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Enheder synkroniseret med succes';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Enheder synkroniseret med succes';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Enhed afregistreret med succes';

  @override
  String get dialogTitle => 'Forklaring af Regex Mønster';

  @override
  String get differentFromLocalCounter =>
      'Denne funktion er anderledes end den lokale tællerfilter, da den fokuserer på gentagne opkaldsmønstre inden for kort tid frem for langsigtet markeringstællinger.';

  @override
  String get disabled => 'Deaktiveret';

  @override
  String get disabledStatus => 'Deaktiveret';

  @override
  String get disableGlobalPlugins => 'Deaktiver globale plugins';

  @override
  String get disableSubscriptionSuccessfully =>
      'Abonnement deaktiveret med succes';

  @override
  String get disconnectButton => 'Frakobl';

  @override
  String get disconnectedMessage => 'Frakoblet';

  @override
  String get disconnectedStatus => 'Frakoblet';

  @override
  String get disconnectFailedMessage => 'Frakobling mislykkedes';

  @override
  String get done => 'Færdig';

  @override
  String get dualSimAdvice =>
      'Denne funktion er særlig nyttig for dual-SIM-telefoner til at indstille forskellige filtreringsstrategier for arbejds- og personlige SIM-kort.';

  @override
  String get earlier => 'Tidligere';

  @override
  String get ecommerce => 'E-handel';

  @override
  String get edit => 'Rediger';

  @override
  String get editContact => 'Rediger kontakt';

  @override
  String get editFilter => 'Rediger filter';

  @override
  String get editLabel => 'Rediger etiket';

  @override
  String get editPhoneRule => 'Rediger telefonregel';

  @override
  String get editPhoneRules => 'Bruges til at redigere telefonregler';

  @override
  String get editPhoneRuleTitle => 'Rediger telefonregel';

  @override
  String get editRule => 'Rediger regel';

  @override
  String get editSmsRule => 'Rediger SMS-regel';

  @override
  String get education => 'Uddannelse';

  @override
  String get elementPositionsSetting => 'Elementpositioner';

  @override
  String get email => 'E-mail';

  @override
  String get emailOptional => 'E-mail (valgfrit)';

  @override
  String get enableCallFilter => 'Aktivér opkaldsfilter';

  @override
  String get enableCallFilterDescription =>
      'Når aktiveret, kontrolleres indgående opkald mod listen over regler nedenfor. Regler for opkaldsfiltrering synkroniseres ikke mellem enheder som standard.';

  @override
  String get enabled => 'Aktiveret';

  @override
  String get enabledStatus => 'Aktiveret';

  @override
  String get enableEncryption => 'Aktivér kryptering';

  @override
  String get enableEncryptionDescription => 'Krypter backupfiler';

  @override
  String get enableEncryptionLabel => 'Aktivér kryptering';

  @override
  String get enableEncryptionSubtitle => 'Backupfiler vil blive krypteret';

  @override
  String get enableEncryptionTitle => 'Aktivér kryptering';

  @override
  String get enableGlobalPlugins => 'Aktivér globale plugins';

  @override
  String get enableLocalCountFilter => 'Aktivér lokal tællerfilter';

  @override
  String get enableLocalCountFilterDescription =>
      'Filtrer automatisk spamopkald baseret på antallet af markeringer';

  @override
  String get enableLocalNotification => 'Brug lokal notifikation';

  @override
  String get enableLocalNotificationDescription =>
      'Når aktiveret, vises notifikationer for filtrerede beskeder på enheden';

  @override
  String get enableLocationSummary => 'Lokation';

  @override
  String get enableMuteRules => 'Aktivér lydløse regler';

  @override
  String get enableMuteRulesDesc =>
      'Anvend konfiguration af lydløse afskæringsregler';

  @override
  String get enableNoneActionRules => 'Aktivér ingen handling regler';

  @override
  String get enableNoneActionRulesDesc =>
      'Tillad regelkonfigurationer uden afskæringsaktioner';

  @override
  String get enableNotifications => 'Aktivér notifikationer';

  @override
  String get enableRemoteNumberFilter => 'Aktivér fjernnummerfilter';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Brug fjern database til at filtrere numre';

  @override
  String get enableRule => 'Aktivér regel';

  @override
  String get enableSmsFilter => 'Aktivér SMS-filtrering';

  @override
  String get enableSmsFilterDescription =>
      'Når aktiveret, vil beskeder automatisk blive filtreret i henhold til reglerne';

  @override
  String get enableStatisticsNotifications => 'Aktivér statistiknotifikationer';

  @override
  String get enableSubscriptionSuccessfully =>
      'Abonnement aktiveret med succes';

  @override
  String get enableTimeInterception => 'Aktivér tidsafskæring';

  @override
  String get enableTimeInterceptionDescription =>
      'Afskær gentagne opkald inden for kort tid';

  @override
  String get enableTimeInterceptor => 'Aktivér tidsafskærer';

  @override
  String get endCallImmediately => 'Afslut opkald øjeblikkeligt';

  @override
  String get endColor => 'Slut farve';

  @override
  String get endDate => 'Slut dato';

  @override
  String get enhancedFilterInstructionsTitle => 'Forbedret filtersystem';

  @override
  String get enhancedFilterSettings => 'Forbedrede filterindstillinger';

  @override
  String get enhancedFilterSettingsTitle => 'Forbedrede filterindstillinger';

  @override
  String get enhancedFilterSystemDescription =>
      'Det forbedrede filtersystem understøtter både globale regler og konfigurationer for filtrering pr. SIM-kort.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Indtast venligst både telefonnummer og regex-mønster';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Indtast venligst både telefonnummer og regex-mønster.';

  @override
  String get enterContactName => 'Indtast venligst kontaktnavn';

  @override
  String get enterCurrentPasswordHint =>
      'Indtast venligst nuværende adgangskode';

  @override
  String get enterDeviceName => 'Indtast enhedsnavn';

  @override
  String get enterDeviceNameHint => 'Indtast venligst enhedsnavn';

  @override
  String get enterEmail => 'Indtast venligst e-mail';

  @override
  String get enterEmailOptional => 'Indtast venligst e-mail (valgfrit)';

  @override
  String get enterEncryptionPasswordHint => 'Indtast krypteringsadgangskode';

  @override
  String get enterEncryptionPasswordTitle => 'Indtast krypteringsadgangskode';

  @override
  String get enterFilterName => 'Indtast venligst filter navn';

  @override
  String get enterFilterPattern => 'Indtast venligst filter mønster';

  @override
  String get enterIconCode => 'Indtast ikonkode';

  @override
  String get enterName => 'Indtast kontaktnavn';

  @override
  String get enterNewDeviceNameHint => 'Indtast et nyt navn for denne enhed';

  @override
  String get enterNewPasswordHint => 'Indtast venligst ny adgangskode';

  @override
  String get enterPasswordAgain => 'Indtast adgangskode igen';

  @override
  String get enterPasswordHint => 'Indtast venligst adgangskode';

  @override
  String get enterPhoneNumber => 'Indtast telefonnummer';

  @override
  String get enterPhoneNumberHint => 'Indtast telefonnummer for at teste';

  @override
  String get enterPhoneNumberMultiple =>
      'Indtast venligst telefonnummer, flere numre adskilt af kommaer';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Indtast telefonnummer for at starte søgning';

  @override
  String get enterPhoneNumberToVerify =>
      'Indtast telefonnummer for at verificere';

  @override
  String get enterPluginName => 'Indtast pluginnavn';

  @override
  String get enterPluginUrl => 'Indtast plugin URL-adresse';

  @override
  String get enterRegexHint => 'Indtast regex mønster';

  @override
  String get enterRuleNameAndPattern => 'Indtast venligst regelnavn og mønster';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Indtast både regelnavn og regex-mønster.';

  @override
  String get enterRuleNameHint => 'Indtast regelnavn';

  @override
  String get enterSearchContent => 'Indtast søgeindhold';

  @override
  String get enterSubscriptionName => 'Indtast abonnementsnavn';

  @override
  String get enterSubscriptionUrl => 'Indtast abonnements-URL';

  @override
  String get enterSyncFolderNameHint =>
      'Angiv navn på synkroniseringsmappe (standard: NotificationManager)';

  @override
  String get entertainment => 'Underholdning';

  @override
  String get enterValidNameAndUrl => 'Indtast gyldigt navn og URL';

  @override
  String get enterValidUrl => 'Indtast en gyldig URL';

  @override
  String get enterVersion => 'Indtast version';

  @override
  String get enterWebDAVPasswordHint => 'Indtast WebDAV-adgangskode';

  @override
  String get enterWebDAVServerAddressHint => 'Indtast WebDAV-serveradresse';

  @override
  String get enterWebDAVUsernameHint => 'Indtast WebDAV-brugernavn';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Fejl ved sletning af enhed: $error';
  }

  @override
  String get errorLoadingPlugin => 'Fejl ved indlæsning af plugin';

  @override
  String errorOccurredMessage(Object error) {
    return 'Der opstod en fejl: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Fejl ved omdøbning af enhed: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Fejl ved synkronisering af enheder: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Fejl ved synkronisering af enheder: $error';
  }

  @override
  String get errorText => 'Fejl';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Fejl ved afregistrering af enhed: $error';
  }

  @override
  String get exampleBlock400Prefix => 'f.eks. Blok 400-præfiksnumre';

  @override
  String get exampleBlockMarketingSms => 'f.eks. Blok markedsførings-SMS';

  @override
  String get exampleContentRegex => 'f.eks., .*tilbud.*';

  @override
  String get exampleContentRegexHint => 'Eksempel på indholds-regex';

  @override
  String get exampleCouponPromotionDiscount =>
      'f.eks. .*(kupon|kampagne|rabat).*';

  @override
  String get exampleFamilyFriends => 'f.eks. Familie, Venner osv.';

  @override
  String get examplePhoneNumber => 'f.eks. 10086, 12345 osv.';

  @override
  String get exampleRegex400Prefix => 'Eksempel på regex for 400-præfiks';

  @override
  String get exampleRegexFormat => 'Eksempel: ^10086\$ format';

  @override
  String get exampleSenderRegexHint => 'Eksempel';

  @override
  String get exchange => 'Udveksling';

  @override
  String get exchangeNow => 'Udveksl nu';

  @override
  String get exchangeVip => 'Udveksl VIP';

  @override
  String get expandLabelSelector => 'Udvid etiketvælger';

  @override
  String expiryTime(Object time) {
    return 'Udløbstid: $time';
  }

  @override
  String get export => 'Eksportér';

  @override
  String get exportAllApplicationSettings =>
      'Eksportér alle applikationsindstillinger';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Eksportér alle applikationsindstillinger';

  @override
  String get exportAllRuleConfigurations =>
      'Eksportér alle regelkonfigurationer';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Eksportér alle regelkonfigurationer';

  @override
  String get exportComplete => 'Eksport fuldført';

  @override
  String get exportConfig => 'Eksportér konfiguration';

  @override
  String get exportContacts => 'Eksportér kontakter';

  @override
  String get exportData => 'Eksportér data';

  @override
  String get exportError => 'Eksportfejl';

  @override
  String get exportFailed => 'Eksport mislykkedes';

  @override
  String get exportFailure => 'Kunne ikke eksportere konfiguration';

  @override
  String get exportFeatureComingSoon => 'Eksportfunktion kommer snart';

  @override
  String get exporting => 'Eksporterer...';

  @override
  String get exportLabels => 'Eksportér etiketter';

  @override
  String exportLabelsFailed(Object error) {
    return 'Kunne ikke eksportere etiketter: $error';
  }

  @override
  String get exportPluginList => 'Eksportér plugin-liste';

  @override
  String exportPluginListFailed(Object error) {
    return 'Kunne ikke eksportere plugin-liste: $error';
  }

  @override
  String get exportRules => 'Eksportér regler';

  @override
  String get exportRulesDialogTitle => 'Eksportér regler';

  @override
  String get exportRulesTitle => 'Eksportér regler';

  @override
  String get exportSmsRules => 'Eksportér SMS-regler';

  @override
  String get exportStatisticsData => 'Eksportér statistikdata';

  @override
  String get exportSuccess => 'Eksport lykkedes';

  @override
  String get exportSuccesslly => 'Konfiguration eksporteret succesfuldt';

  @override
  String get failedToAddContact => 'Kunne ikke tilføje kontakt';

  @override
  String failedToAddRule(Object error) {
    return 'Kunne ikke tilføje regel: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'Kunne ikke tilføje SMS-regel: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Kunne ikke tilføje SMS-abonnement: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Kunne ikke sikkerhedskopiere indstillinger: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'Kunne ikke dekryptere backupfil';

  @override
  String get failedToDeleteDevice => 'Kunne ikke slette enhed';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Kunne ikke slette SMS-regel: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Kunne ikke eksportere regler: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Kunne ikke eksportere SMS-regler: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Kunne ikke hente oplysninger om opkalds-ID: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Kunne ikke importere regler: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'Kunne ikke importere SMS-regler: $error';
  }

  @override
  String get failedToLoadContacts => 'Kunne ikke indlæse kontakter';

  @override
  String get failedToLoadPlugin => 'Kunne ikke indlæse plugin';

  @override
  String get failedToRenameDevice => 'Kunne ikke omdøbe enhed';

  @override
  String get failedToRestoreSettings => 'Kunne ikke gendanne indstillinger';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Kunne ikke gendanne indstillinger: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Kunne ikke indstille adgangskode: $error';
  }

  @override
  String get failedToSyncDevices => 'Kunne ikke synkronisere enheder';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Kunne ikke skifte regelstatus: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Kunne ikke skifte abonnementsstatus';

  @override
  String get failedToUpdateContact => 'Kunne ikke opdatere kontakt';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Kunne ikke opdatere SMS-regel: $error';
  }

  @override
  String get failure => 'Fejl';

  @override
  String get favoriteContacts => 'Favoritkontakter';

  @override
  String get featureAddRules => '• Tilføj specifikke regler for telefonnumre';

  @override
  String get featureCenter => 'Funktionscenter';

  @override
  String get featureEnableDisable =>
      '• Aktiver/deaktiver forskellige filtre pr. SIM-kort';

  @override
  String get featureListTitle => 'Funktioner:';

  @override
  String get featureManageRules => '• Administrer regel-lister pr. SIM-kort';

  @override
  String get features => 'Funktioner';

  @override
  String get fetchingCallerIdInfo => 'Henter oplysninger om opkalds-ID...';

  @override
  String fileSavedTo(Object path) {
    return 'Fil gemt til: $path';
  }

  @override
  String get filter => 'Filtrer';

  @override
  String get filterByLabel => 'Filtrer efter etiket';

  @override
  String get filterClear => 'Ryd filter';

  @override
  String get filterControlPanelTitle => 'Filterkontrolpanel';

  @override
  String get filterControlSubtitle =>
      'Administrer til/fra-status for alle filtre';

  @override
  String get filterControlTitle => 'Filterkontrol';

  @override
  String get filterDeleteFailed => 'Filter sletning mislykkedes';

  @override
  String get filterDeleteSuccess => 'Filter slettet med succes';

  @override
  String get filterDetails => 'Filterdetaljer';

  @override
  String get filtered => 'Filtreret';

  @override
  String get filteredSms => 'Filtreret SMS';

  @override
  String get filteredSmsLabel => 'Filtreret SMS';

  @override
  String get filterExplanation => 'Filterforklaring';

  @override
  String get filterManagement => 'Filteradministration';

  @override
  String get filterName => 'Filternavn';

  @override
  String get filterPattern => 'Filtermønster';

  @override
  String get filterPriorityNote =>
      'Bemærk: Der er prioriteringsrelationer mellem filtre, se hjælpedokumentationen for detaljer';

  @override
  String get filterSaveFailed => 'Filter gemning mislykkedes';

  @override
  String get filterSaveSuccess => 'Filter gemt med succes';

  @override
  String get filterSettings => 'Filterindstillinger';

  @override
  String get filterSettingsTitle => 'Filterindstillinger';

  @override
  String get filterSMS => 'Filtrer SMS';

  @override
  String get filterToggleInstructions =>
      'Aktiver eller deaktiver filtre for denne SIM-slot:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filter: $filterName';
  }

  @override
  String get filterType => 'Filtertype';

  @override
  String get financial => 'Finansiel';

  @override
  String get flexibleCombinationFeature =>
      '• Fleksible kombinationer: Aktiver/deaktiver filtre pr. SIM-slot';

  @override
  String get fontSizesSetting => 'Skriftstørrelser';

  @override
  String foundRules(Object count) {
    return 'Fandt $count regler';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Fandt $count regler. Vil du importere dem?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Fandt $count regler. Vil du importere dem?';
  }

  @override
  String get fraudAlert => 'SVINDEL ALARM - Læg på';

  @override
  String get fraudScamLikely => 'Svindel sandsynlig';

  @override
  String get free => 'Gratis';

  @override
  String get functionSettingsTitle => 'Funktionsindstillinger';

  @override
  String generalUpdateFailure(Object error) {
    return 'Opdatering mislykkedes: $error';
  }

  @override
  String get getFree => 'Få gratis';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Konfigurer globale filtre for alle SIM-kort:';

  @override
  String get globalFilterFeature =>
      '• Globale filtre: Grundlæggende regler for alle indgående opkald';

  @override
  String get globalFilterSettings => 'Globale filterindstillinger';

  @override
  String get globalFilterToggleInstructions =>
      'Konfigurer globale filterindstillinger, der gælder for alle SIM-slots:';

  @override
  String get globalSearchSubtitle =>
      'Søg efter kontakter, etiketter, sortlister, hvidlister osv.';

  @override
  String get globalSearchTitle => 'Global søgning';

  @override
  String get globalSettings => 'Globale indstillinger';

  @override
  String get googleAdDisplayPosition => 'Google Annoncevisningsposition';

  @override
  String get googleAdMobIntegrationText =>
      'Google AdMob-annoncer kan integreres her';

  @override
  String get googleDriveAuthDescription =>
      'Autoriser ved hjælp af systemkonfigureret Google Drive-klient-id og nøgle';

  @override
  String get googleDriveAuthorizationHint =>
      'Autoriser ved hjælp af systemkonfigureret Google Drive-klient-id og nøgle';

  @override
  String get googleDriveConfigTitle => 'Google Drev-konfiguration';

  @override
  String get googleDriveConfigurationTitle => 'Google Drev-konfiguration';

  @override
  String get government => 'Regering';

  @override
  String get granted => 'Bevilliget';

  @override
  String get grantNecessaryPermissions => 'Bevillig nødvendige tilladelser';

  @override
  String get grantPermissions => 'Bevillig tilladelser';

  @override
  String get headhunter => 'Headhunter';

  @override
  String get height => 'Højde';

  @override
  String get homePageTitle => 'Hjemmeside';

  @override
  String get homeTab => 'Hjem';

  @override
  String get howItWorksPoint1 =>
      '• Systemet vil automatisk tillade opkald fra samme nummer inden for det indstillede tidsvindue';

  @override
  String get howItWorksPoint2 =>
      '• Kortere tidsvinduer resulterer i strengere aflytning; længere tidsvinduer resulterer i løsere aflytning';

  @override
  String get howItWorksPoint3 =>
      '• Systemet tjekker opkaldslogfiler for at afgøre, om det er et gentaget opkald';

  @override
  String get howItWorksTitle => 'Sådan virker det:';

  @override
  String get iconCodeOptional => 'Ikonkode (valgfri)';

  @override
  String get iconSize => 'Ikonstørrelse';

  @override
  String get import => 'Importér';

  @override
  String get important => 'Vigtigt';

  @override
  String get importButton => 'Importér';

  @override
  String get importConfig => 'Importér konfiguration';

  @override
  String get importContacts => 'Importér kontakter';

  @override
  String get importExportContacts => 'Importér/Eksporter kontakter';

  @override
  String get importExportContactsTooltip => 'Importér/Eksporter kontakter';

  @override
  String get importExportRules => 'Importér/Eksporter regler';

  @override
  String importFailed(Object error) {
    return 'Import mislykkedes: $error';
  }

  @override
  String get importFailure => 'Kunne ikke importere konfiguration';

  @override
  String get importFeatureComingSoon => 'Importfunktion kommer snart';

  @override
  String get importLabels => 'Importér etiketter';

  @override
  String importLabelsFailed(Object error) {
    return 'Kunne ikke importere etiketter: $error';
  }

  @override
  String get importPluginList => 'Importér pluginliste';

  @override
  String importPluginListFailed(Object error) {
    return 'Kunne ikke importere pluginliste: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Importerede med succes $count plugins';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Importér regelkonfigurationer fra fil';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Importér regelkonfigurationer fra fil';

  @override
  String get importRules => 'Importér regler';

  @override
  String get importRulesButton => 'Importér regler';

  @override
  String get importRulesDialogTitle => 'Importér regler';

  @override
  String importRulesError(Object error) {
    return 'Kunne ikke importere regler: $error';
  }

  @override
  String get importRulesInstructions => 'Importér regler fra en CSV-fil';

  @override
  String get importRulesSuccess => 'Regler importeret med succes';

  @override
  String get importRulesTitle => 'Importér regler';

  @override
  String get importSuccess => 'Import lykkedes';

  @override
  String get incomingCallInterceptAction =>
      'Indgående opkaldsaflytningshandling';

  @override
  String get incomingCallNotification => 'Indgående opkaldsmeddelelse';

  @override
  String get incorrectPassword => 'Forkert adgangskode';

  @override
  String get initializing => 'Initialiserer';

  @override
  String get installed => 'Installeret';

  @override
  String get insufficientMarks => 'Utilstrækkelige point';

  @override
  String get insurance => 'Forsikring';

  @override
  String get interceptAction => 'Aflytningshandling';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Indstil, hvordan blokerede opkald håndteres';

  @override
  String get interceptionActionSettingsTitle =>
      'Indstillinger for aflytningshandling';

  @override
  String get interceptionTimeInterval => 'Aflytningsinterval';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service opdateringsinterval sat til $days dage';
  }

  @override
  String get invalidContentRegex => 'Ugyldig indholds regex';

  @override
  String get invalidLabel => 'Ugyldigt mærkat';

  @override
  String get invalidRegexPattern => 'Ugyldigt regex-mønster';

  @override
  String get invalidSenderRegex => 'Ugyldig afsender regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Tilmeld dig Telegram-kanalen og gruppen for mere information';

  @override
  String get jsLogsTitle => 'JS-logs';

  @override
  String get jsonFormat => 'JSON-format';

  @override
  String get keepAllVersions => 'Behold alle versioner';

  @override
  String get keepAllVersionsDescription =>
      'Behold alle historiske versioner af hver backup';

  @override
  String get keepAllVersionsLabel => 'Behold alle versioner';

  @override
  String get keepAllVersionsSubtitle =>
      'Behold historiske versioner af hver backup';

  @override
  String get keepAllVersionsTitle => 'Behold alle versioner';

  @override
  String get label => 'Mærkat';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Mærkat \"$name\" tilføjet med succes';
  }

  @override
  String get labelCategories => 'Mærkatkategorier';

  @override
  String get labelDeleted => 'Mærkat slettet';

  @override
  String get labelDescription =>
      'Mærkater hjælper dig med bedre at administrere kontakter, tilføj brugerdefinerede mærkater til telefonnumre for nem identifikation af opkald og beskeder.';

  @override
  String get labelFilter => 'Mærkatfilter';

  @override
  String get labelFilterTooltip => 'Mærkatfilter';

  @override
  String get labelIconColor => 'Mærkatikonfarve';

  @override
  String get labelManagement => 'Mærkatadministration';

  @override
  String get labelNotFound => 'Mærkat ikke fundet';

  @override
  String get labelRemoved => 'Mærkat fjernet';

  @override
  String labelRemoveFailed(Object error) {
    return 'Kunne ikke fjerne mærkat: $error';
  }

  @override
  String get labels => 'Mærkater';

  @override
  String get labelsColor => 'Mærkatfarver';

  @override
  String labelsDeleted(Object count) {
    return '$count mærkater slettet';
  }

  @override
  String get labelsExportedSuccessfully => 'Mærkater eksporteret med succes';

  @override
  String get labelsFontSize => 'Mærkater skriftstørrelse';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count mærkater importeret med succes';
  }

  @override
  String get labelsPosition => 'Mærkatposition';

  @override
  String labelTag(Object labelId) {
    return 'Mærkat: $labelId';
  }

  @override
  String get labelUpdated => 'Mærkat opdateret';

  @override
  String labelUpdateFailed(Object error) {
    return 'Kunne ikke opdatere mærkat: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Mærkat \"\$labelText\" opdateret med succes';

  @override
  String get languageSettings => 'Sprogindstillinger';

  @override
  String get languageSettingsSubtitle => 'Skift programmets visningssprog';

  @override
  String get languageSettingsTitle => 'Sprogindstillinger';

  @override
  String get last30Days => 'Sidste 30 dage';

  @override
  String get last7Days => 'Sidste 7 dage';

  @override
  String get lastSyncLabel => 'Sidste synkronisering';

  @override
  String lastUpdated(Object date) {
    return 'Sidst opdateret: $date';
  }

  @override
  String get lifetimeMembership => 'Livstidsmedlemskab';

  @override
  String get lifetimeMembershipDescription =>
      'Engangskøb, lås permanent op for alle premium-funktioner og fremtidige opdateringer';

  @override
  String loadContactsFailed(Object error) {
    return 'Kunne ikke indlæse kontakter: $error';
  }

  @override
  String get loadDataFailed => 'Kunne ikke indlæse data';

  @override
  String get loadFailed => 'Indlæsning mislykkedes';

  @override
  String get loading => 'Indlæser...';

  @override
  String get loadingData => 'Indlæser data...';

  @override
  String get loadingTags => 'Indlæser tags...';

  @override
  String loadLabelFailed(Object error) {
    return 'Kunne ikke indlæse mærkater: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Kunne ikke indlæse mærkater: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Kunne ikke indlæse markerede telefonnumre: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Kunne ikke indlæse markerede telefonnumre: $error';
  }

  @override
  String get loadMore => 'Indlæs mere';

  @override
  String get loadPluginButton => 'Indlæs plugin';

  @override
  String loadPluginsFailed(Object error) {
    return 'Kunne ikke indlæse plugins: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Kunne ikke indlæse indstillinger: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Kunne ikke indlæse SMS-regler: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Kunne ikke indlæse status';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Kunne ikke indlæse abonnementer: $error';
  }

  @override
  String get loan => 'Lån';

  @override
  String get localBackupTitle => 'Lokal backup';

  @override
  String get localCounterFilter => 'Lokal tællerfilter';

  @override
  String get localCounterFilterSubtitle =>
      'Filtrer automatisk spamopkald baseret på opkaldsfrekvens';

  @override
  String get localCountFilter => 'Lokal antal-filter';

  @override
  String get localCountFilterDescription =>
      'Afskær hyppige opkald baseret på lokale antal af numre';

  @override
  String get localCountFilterExplanationContent =>
      'Det lokale antal-filter analyserer opkaldshistorik for automatisk at identificere og blokere hyppige spamopkald.';

  @override
  String get localCountFilterExplanationTitle =>
      'Forklaring af lokalt antal-filter';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Bestem om der skal blokeres baseret på nummerets antal';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Når et nummers antal overstiger den indstillede tærskel, kan du vælge at blokere det automatisk';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Du kan selektivt tillade numre, der ikke overskrider tærsklen';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Du kan vælge, om alle forespørgselslogs skal registreres';

  @override
  String get localCountFiltering => 'Lokalt antal-filtrering';

  @override
  String get localCountFilteringExplanation =>
      '• Lokalt antal-filtrering: Filtreringsregler baseret på lokal markeringstælling';

  @override
  String get localCountFilterSettings =>
      'Indstillinger for lokalt antal-filter';

  @override
  String get localCountFilterUseCases =>
      'Dette filter er især velegnet til at identificere auto-opkaldte spamopkald og marketingopkald.';

  @override
  String get localFilterSettings => 'Indstillinger for lokalt filter';

  @override
  String get localNotificationDisabled => 'Lokal notifikation deaktiveret';

  @override
  String get localNotificationEnabled => 'Lokal notifikation aktiveret';

  @override
  String get localServices => 'Lokale tjenester';

  @override
  String get locationColor => 'Lokationsfarve';

  @override
  String get locationFontSize => 'Lokations skriftstørrelse';

  @override
  String get locationIconColor => 'Lokationsikonfarve';

  @override
  String get locationPosition => 'Lokationsposition';

  @override
  String get logAllLocalQueries => 'Log alle lokale forespørgsler';

  @override
  String get logAllLocalQueriesDescription =>
      'Registrer logs for alle forespørgsler om lokale numre';

  @override
  String get logAllRemoteQueries => 'Log alle eksterne forespørgsler';

  @override
  String get logAllRemoteQueriesDescription =>
      'Registrer alle forespørgselsoperationer for eksterne numre';

  @override
  String get manage => 'Administrer kontakter';

  @override
  String get manageContacts => 'Administrer';

  @override
  String get manageFavoriteContacts => 'Administrer favoritkontakter';

  @override
  String get manageFilterRules => 'Administrer filterregler';

  @override
  String get manageFilterRulesDescription =>
      'Tilføj, rediger eller slet SMS-filterregler';

  @override
  String get manageFrequentContacts => 'Administrer hyppige kontakter';

  @override
  String get markCounts => 'Markeringstællinger';

  @override
  String get markCount => 'Markeringstælling';

  @override
  String markedByCount(Object count) {
    return 'Markeret af $count';
  }

  @override
  String get markedPhonesList => 'Markerede telefonnumre';

  @override
  String get markExchange => 'Markering udveksling';

  @override
  String get markPhone => 'Markér telefonnummer';

  @override
  String markPhoneFailed(Object error) {
    return 'Kunne ikke markere telefonnummer: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'For at markere telefonnumre';

  @override
  String get markPhoneManagementTitle => 'Markér telefonnummerstyring';

  @override
  String get markPhoneSuccess => 'Telefonnummer markeret succesfuldt';

  @override
  String get matchFailed => 'Match mislykkedes!';

  @override
  String get matchFailedMessage => 'Match mislykkedes.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'matcher specifikt nummerformat';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Match numre med specialtegn:';

  @override
  String get matchSpecificDigitPatterns => 'matcher XXX-XXXX-XXXX format';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Match specifikke ciffermønstre:';

  @override
  String get matchSuccessful => 'Match lykkedes!';

  @override
  String get matchSuccessfulMessage => 'Match lykkedes!';

  @override
  String get medical => 'Medicinsk';

  @override
  String get membershipPrivileges => 'Medlemskabsfordele';

  @override
  String get migrationTool => 'Migrationsværktøj';

  @override
  String get migrationToolTitle => 'Migrationsværktøj';

  @override
  String get minutes => 'minutter';

  @override
  String get month => 'Måned';

  @override
  String get monthly => 'Månedligt';

  @override
  String get monthlyCallCount => 'Månedlige opkald';

  @override
  String get monthlyChartTitle => 'Månedlige blokerede opkald';

  @override
  String get monthlyMembership => 'Månedligt medlemskab';

  @override
  String get monthlyMembershipDescription =>
      'Lås op for alle premium-funktioner, automatisk fornyelse månedligt';

  @override
  String get monthlyTotal => 'Månedligt i alt';

  @override
  String get monthlyTotalLabel => 'Månedligt i alt';

  @override
  String get moreOptions => 'Flere indstillinger';

  @override
  String get mute => 'Mute';

  @override
  String get name => 'Navn';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Navn og telefonnummer kan ikke være tomme';

  @override
  String get nameAndPhoneNumberRequired =>
      'Navn og telefonnummer kan ikke være tomme';

  @override
  String get nameColor => 'Navnefarve';

  @override
  String get nameFontSize => 'Navnestørrelse';

  @override
  String nameLabel(Object name) {
    return 'Navn: $name';
  }

  @override
  String get namePosition => 'Navneposition';

  @override
  String get nameUnknown => 'Navn: Ukendt';

  @override
  String nameWithValue(String name) {
    return 'Navn: $name';
  }

  @override
  String get newPasswordLabel => 'Nyt adgangskode';

  @override
  String get nextStep => 'Næste';

  @override
  String get noAction => 'Ingen handling';

  @override
  String get noActionRules => 'Ingen handlingsregler';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Ingen aktiv cloud-synkroniseringstjeneste';

  @override
  String get noCallLogs => 'Ingen opkaldslogger';

  @override
  String get noCallRecords => 'Ingen opkaldsregistre';

  @override
  String get noContacts => 'Ingen kontakter endnu';

  @override
  String get noContactsYet => 'Ingen kontakter endnu';

  @override
  String get noData => 'Ingen data';

  @override
  String get noDevicesRegisteredMessage => 'Ingen enheder registreret';

  @override
  String get noDevicesRegisteredYet => 'Ingen enheder registreret endnu.';

  @override
  String get noFilters => 'Ingen filtre endnu';

  @override
  String get noLabels => 'Ingen etiketter endnu';

  @override
  String get noMarkedPhones => 'Ingen markerede telefonnumre';

  @override
  String get noMatchingContacts => 'Ingen matchende kontakter';

  @override
  String get noMatchingContactsFound => 'Ingen matchende kontakter fundet';

  @override
  String get noMatchingNumbersFound => 'Ingen matchende numre fundet';

  @override
  String get noMatchingRecords => 'Ingen matchende opkaldsregistre';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Ingen matchende $ruleType';
  }

  @override
  String get none => 'Ingen';

  @override
  String get noneServiceType => 'Ingen';

  @override
  String get noPlugins => 'Ingen plugins endnu';

  @override
  String get noRecords => 'Ingen opkaldsregistre';

  @override
  String get noResultReturned => 'Intet resultat returneret';

  @override
  String get noResultReturnedLog => 'Intet resultat returneret fra plugin';

  @override
  String noRules(Object ruleType) {
    return 'Ingen $ruleType endnu';
  }

  @override
  String get noRulesPrompt => 'Ingen regler fundet, tilføj venligst regler';

  @override
  String get noRulesToExport => 'Ingen regler at eksportere';

  @override
  String get noSmsFilterRulesYet => 'Ingen SMS-filterregler endnu';

  @override
  String get noSmsRulesYet => 'Ingen SMS-regler endnu';

  @override
  String get noSubscriptions => 'Ingen abonnementer';

  @override
  String get noSubscriptionsYet => 'Ingen abonnementer endnu';

  @override
  String get notGranted => 'Ikke givet';

  @override
  String get notificationModeDescription =>
      'Vis opkaldsinformation i notifikationslinjen';

  @override
  String get notificationPermission => 'Notifikationstilladelse';

  @override
  String get notificationPermissionDescription =>
      'Bruges til at vise notifikationer om indgående opkald og beskeder.';

  @override
  String get notifications => 'Notifikationer';

  @override
  String get notificationSettings => 'Notifikationindstillinger';

  @override
  String get notificationSettingsSaved =>
      'Notifikationsindstillinger gemt succesfuldt';

  @override
  String get notSet => 'Ikke indstillet';

  @override
  String get notVerifiedText => 'Ikke verificeret';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Ingen gyldige SMS-regler fundet i filen';

  @override
  String get number => 'Nummer';

  @override
  String get numberColor => 'Nummerfarve';

  @override
  String get numberFontSize => 'Nummerstørrelse';

  @override
  String get numberPosition => 'Nummerposition';

  @override
  String get numberSearch => 'Nummersøgning';

  @override
  String get numberTypeColor => 'Nummertypefarve';

  @override
  String get numberTypeFontSize => 'Nummertypsstørrelse';

  @override
  String get numberTypePosition => 'Nummertypposition';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Din opkaldssikkerhedschef er klar, start med at nyde en sikker opkaldsoplevelse!';

  @override
  String get onboardingLanguageDescription =>
      'Vælg dit foretrukne sprog for den bedste oplevelse.';

  @override
  String get onboardingPermissionsDescription =>
      'For at levere fuld service har vi brug for følgende tilladelser:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Et-klik blokering af spam-opkald og beskeder, tilpas blokeringsregler og giv dig et stille miljø.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Identificer automatisk ukendte opkald, marker mistænkelige numre og beskyt din opkaldssikkerhed.';

  @override
  String get onboardingWelcomeDescription =>
      'Din opkaldsstyringsekspert, der leverer omfattende opkaldsidentifikation og blokeringsservices.';

  @override
  String get oneDriveAuthDescription =>
      'Godkend ved hjælp af systemkonfigureret OneDrive-klient-id og nøgle';

  @override
  String get oneDriveAuthorizationHint =>
      'Godkend ved hjælp af systemkonfigureret OneDrive-klient-id og nøgle';

  @override
  String get oneDriveConfigTitle => 'OneDrive-konfiguration';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive-konfiguration';

  @override
  String get onlineCallerIdSubscription => 'Online Opkalds-ID Abonnement';

  @override
  String get openAppSettings => 'Åbn appindstillinger';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Kunne ikke åbne appindstillinger: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operationen mislykkedes: $error';
  }

  @override
  String get operationFailure => 'Operationen mislykkedes';

  @override
  String get operationSuccess => 'Operationen lykkedes';

  @override
  String get other => 'Andet';

  @override
  String get ourOtherApps => 'Vores andre apps';

  @override
  String get overlayMode => 'Flydende vindue';

  @override
  String get overlayModeDescription =>
      'Vis opkaldsoplysninger i et flydende vindue';

  @override
  String get overlayPermission => 'Overlejringstilladelse';

  @override
  String get overlayPermissionDescription =>
      'Bruges til at vise indgående opkaldsoverlejring.';

  @override
  String get overview => 'Oversigt';

  @override
  String get password => 'Adgangskode';

  @override
  String get passwordCannotBeEmpty => 'Adgangskode kan ikke være tom';

  @override
  String get passwordLabel => 'Adgangskode';

  @override
  String get passwordsDoNotMatch => 'Adgangskoder stemmer ikke overens';

  @override
  String get passwordSetSuccessfully => 'Adgangskode er sat succesfuldt';

  @override
  String get pattern => 'Mønster';

  @override
  String get pendingSync => 'Afventer synkronisering';

  @override
  String get periodMonth => 'Måned';

  @override
  String get periodWeek => 'Uge';

  @override
  String get periodYear => 'År';

  @override
  String get permissionDenied => 'Tilladelsesanmodning afvist';

  @override
  String get permissionGranted => 'Tilladelse givet';

  @override
  String get permissionManagement => 'Tilladelsesstyring';

  @override
  String get phoneCallsTab => 'Telefon';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get phoneNumberCannotBeEmpty => 'Telefonnummer kan ikke være tomt';

  @override
  String get phoneNumberHintText =>
      'Indtast telefonnummer for at tilføje regel';

  @override
  String get phoneNumberLabel => 'Telefonnummer';

  @override
  String get phoneNumberRegexRequired =>
      'Indtast venligst både telefonnummer og regex-mønster';

  @override
  String get phoneNumberTypeFixedLine => 'Fastnet';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Fastnet eller mobil';

  @override
  String get phoneNumberTypeMobile => 'Mobil';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Personligt nummer';

  @override
  String get phoneNumberTypePremiumRate => 'Premium sats';

  @override
  String get phoneNumberTypeSharedCost => 'Fælles omkostning';

  @override
  String get phoneNumberTypeTollFree => 'Gratis nummer';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Ukendt';

  @override
  String get phoneNumberTypeVoicemail => 'Svarer';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Telefontilladelse';

  @override
  String get phonePermissionDescription =>
      'Bruges til at identificere og blokere indgående opkald.';

  @override
  String get phoneRule => 'Telefonregel';

  @override
  String get phoneRuleEditDialog => 'Rediger dialog for telefonregel';

  @override
  String get phoneRuleManagement => 'Styring af telefonregler';

  @override
  String get phoneRuleSubscription => 'Abonnement på telefonregler';

  @override
  String get phoneSubscription => 'Telefonabonnement';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Abonner på URL-lister over telefonregler for automatisk at opdatere hvidliste- og sortlisteregler. Understøtter regel filer i JSON-format.';

  @override
  String get phoneSubscriptionTitle => 'Abonnementer på telefonregler';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Vælg venligst en etiket og indtast et gyldigt telefonnummer';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" tilføjet succesfuldt';
  }

  @override
  String get pluginDeleted => 'Plugin slettet';

  @override
  String get pluginLatestVersion => 'Plugin er allerede den seneste version';

  @override
  String get pluginListExportSuccess => 'Pluginliste eksporteret succesfuldt';

  @override
  String get pluginLoadedSuccessfully => 'Plugin indlæst succesfuldt';

  @override
  String get pluginManagement => 'Pluginstyring';

  @override
  String get pluginManagementSubtitle =>
      'Administrer og konfigurer tredjeparts plugins';

  @override
  String get pluginManagementTitle => 'Pluginstyring';

  @override
  String get pluginName => 'Pluginnavn';

  @override
  String get pluginNotLoaded =>
      'Plugin er endnu ikke indlæst. Indlæs venligst plugin først.';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugins slettet succesfuldt.';
  }

  @override
  String get pluginService => 'Plugin Service';

  @override
  String get pluginTestPageTitle => 'Plugin Test';

  @override
  String get pluginUpdateSuccess => 'Plugin opdateret succesfuldt';

  @override
  String get pluginUrl => 'Plugin URL';

  @override
  String get pluginUrlCannotBeEmpty => 'Plugin URL kan ikke være tom';

  @override
  String get pluginUrlHint => 'Indtast plugin URL';

  @override
  String get pluginUrlLabel => 'Plugin URL';

  @override
  String get pluginVersion => 'Plugin Version';

  @override
  String get political => 'Politisk';

  @override
  String get powerfulSpamBlocking => 'Kraftig spamblokering';

  @override
  String get previousStep => 'Forrige';

  @override
  String get prioritizeRemoteAction => 'Prioriter fjernhandlingsindstillinger';

  @override
  String get prioritizeRemoteActionDescription =>
      'Prioriter handlingsindstillinger fra den fjerne database';

  @override
  String get processing => 'Behandler...';

  @override
  String get processingOperation => 'Behandler...';

  @override
  String get purchase => 'Køb';

  @override
  String get quarterlyMembership => 'Kvartalsmedlemskab';

  @override
  String get quarterlyMembershipDescription =>
      'Lås op for alle premium-funktioner, automatisk fornyelse kvartalsvis';

  @override
  String get queryButton => 'Forespørgsel';

  @override
  String get queryFailed => 'Forespørgsel mislykkedes';

  @override
  String get queryFailedLog => 'Forespørgsel mislykkedes';

  @override
  String get querying => 'Forespørger...';

  @override
  String get queryingPhoneNumber => 'Forespørger telefonnummer';

  @override
  String get queryResultTitle => 'Forespørgselsresultat';

  @override
  String get ready => 'Klar!';

  @override
  String get receiveWeeklyStatistics => 'Modtag ugentlige statistikker';

  @override
  String get recruiter => 'Rekrutterer';

  @override
  String get reEnterPasswordHint => 'Indtast venligst adgangskoden igen';

  @override
  String get refresh => 'Opdater';

  @override
  String get refreshPermissionStatus => 'Opdater tilladelsesstatus';

  @override
  String get refreshTooltip => 'Opdater';

  @override
  String regexError(Object error) {
    return 'Regex-fejl: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex-fejl: $error';
  }

  @override
  String get regexPattern => 'Regex Mønster';

  @override
  String get regexPatternExplanation => 'Forklaring af Regex Mønster';

  @override
  String get regexPatternExplanationButton => 'Forklaring af Regex Mønster';

  @override
  String get regexPatternLabel => 'Regex Mønster';

  @override
  String get regexPatternsExamples =>
      'Brug standard regex-syntaks til at definere mønstre. Eksempler:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Regex Mønstre til Matchning af Telefonnumre';

  @override
  String get regexRule => 'Regex Regel';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Kunne ikke tilføje regex-regel: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex-regel tilføjet succesfuldt';

  @override
  String get regexRuleManagement => 'Regex Regel Administration';

  @override
  String get regexRuleNamePatternRequired =>
      'Regelnavn og regex-mønster kan ikke være tomme';

  @override
  String get regexRules => 'Regex Regler';

  @override
  String get regexTesterTitle => 'Regex Tester';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex-validering mislykkedes: $error';
  }

  @override
  String get regexValidationSuccess => 'Regex-validering lykkedes';

  @override
  String get region => 'Region';

  @override
  String get registeredDevicesTitle => 'Registrerede Enheder';

  @override
  String get rejectAllCalls => 'Afvis Alle Opkald';

  @override
  String get rejectAllCallsDescription =>
      'Når aktiveret, vil alle opkald blive afvist med højeste prioritet';

  @override
  String get rejectAllNumbers => 'Afvis Alle Numre';

  @override
  String get rejectAllNumbersDesc =>
      'Afvis alle indgående opkald, når aktiveret';

  @override
  String get rejectExceededNumbers => 'Afvis Overskredne Numre';

  @override
  String get rejectExceededNumbersDescription =>
      'Afvis automatisk numre, der overskrider tærsklen for antal';

  @override
  String get remoteFilterSettings => 'Fjernindstillinger for Filter';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Fjernindstillinger for Nummerfilter';

  @override
  String get remoteNumberFilter => 'Fjern Nummerfilter';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Dette filter bruger en uafhængig fjern-database til at få de seneste nummeroplysninger.';

  @override
  String get remoteNumberFilterDescription =>
      'Afskær chikanerende opkald baseret på information fra fjern-database';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Fjern nummerfilteret identificerer og blokerer spam-opkald ved at forespørge en fjern-database baseret på antallet af forekomster.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Forklaring af Fjern Nummerfilter';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Antal Tærskel: Bestem baseret på hyppigheden af nummerforekomster';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Filterhandlinger: Konfigurer hvordan numre, der overskrider tærsklen, skal håndteres';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Prioritetsindstillinger: Indstil prioritet for fjernhandlinger';

  @override
  String get remoteNumberFilterFeatures => 'Funktioner:';

  @override
  String get remoteNumberFiltering => 'Fjern Nummerfiltrering';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Fjern Nummerfiltrering: Filtreringsregler baseret på information fra fjern-database';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identificer spam-opkald ved hjælp af cloud-database og fællesskabsrapporter';

  @override
  String get removeAdsDescription =>
      'Fjern permanent alle annoncer i appen for en mere flydende oplevelse';

  @override
  String get removeAdsTitle => 'Fjern Annoncer';

  @override
  String get removedFromFavoriteContacts => 'Fjernet fra favoritkontakter';

  @override
  String get removedFromFavorites => 'Fjernet fra favoritkontakter';

  @override
  String get removeFavorite => 'Fjern Favorit';

  @override
  String get removeFromFavorites => 'Fjern fra Favoritter';

  @override
  String get renameButton => 'Omdøb';

  @override
  String get renameDeviceDialogTitle => 'Omdøb Enhed';

  @override
  String get renameDeviceTitle => 'Omdøb Enhed';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Dette vil erstatte alle dine nuværende indstillinger. Er du sikker på, at du vil fortsætte?';

  @override
  String get requestAllPermissions => 'Anmod om Alle Tilladelser';

  @override
  String get requestPermission => 'Anmod om Tilladelse';

  @override
  String requestPermissionFailed(Object error) {
    return 'Kunne ikke anmode om tilladelse: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Mærker';
  }

  @override
  String get reset => 'Nulstil';

  @override
  String get restore => 'Gendan';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Gendan Applikationsindstillinger fra Backup';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Gendan applikationsindstillinger fra backup';

  @override
  String get restoreButton => 'Gendan';

  @override
  String restoreFailedWithError(Object error) {
    return 'Gendan fra skyen mislykkedes: $error';
  }

  @override
  String get restoreFromCloud => 'Gendan fra Skyen';

  @override
  String get restoreFromCloudDescription =>
      'Gendan indstillinger og regler fra cloud-lager';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Kunne ikke gendanne fra skyen: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Gendan fra Skyen';

  @override
  String get restoreFromCloudSuccess => 'Succesfuldt gendannet fra skyen';

  @override
  String get restoreFromCloudTitle => 'Gendan fra Skyen';

  @override
  String get restoreFromLocal => 'Gendan fra Lokal';

  @override
  String get restorePurchases => 'Gendan Køb';

  @override
  String get restoreSectionTitle => 'Gendan';

  @override
  String get restoreSettings => 'Gendan Indstillinger';

  @override
  String get restoreSettingsConfirmation =>
      'Dette vil erstatte alle dine nuværende indstillinger. Er du sikker på, at du vil fortsætte?';

  @override
  String get restoreSettingsDialogTitle => 'Gendan Indstillinger';

  @override
  String get restoreSettingsTitle => 'Gendan Indstillinger';

  @override
  String get restoreSuccessFromLocal => 'Succesfuldt gendannet fra lokal';

  @override
  String get restoreSuccessMessage => 'Succesfuldt gendannet fra skyen';

  @override
  String get retry => 'Prøv Igen';

  @override
  String get ridesharing => 'Samkørsel';

  @override
  String get risk => 'Risiko';

  @override
  String get robocall => 'Robocall';

  @override
  String get ruleAction => 'Regelhandling';

  @override
  String get ruleAddButton => 'Tilføj Regel';

  @override
  String get ruleAddedSuccess => 'Regel tilføjet succesfuldt';

  @override
  String ruleAddFailure(Object error) {
    return 'Kunne ikke tilføje regel: $error';
  }

  @override
  String get ruleAddSuccess => 'Regel tilføjet succesfuldt';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Er du sikker på, at du vil slette denne $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Slet Regel';

  @override
  String get ruleDeletedSuccess => 'Regel slettet succesfuldt';

  @override
  String get ruleDeletedSuccessfully => 'Regel slettet succesfuldt';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Kunne ikke slette regel: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Kunne ikke slette regel: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Regel slettet succesfuldt';

  @override
  String get ruleDisabledSuccessfully => 'Regel deaktiveret succesfuldt';

  @override
  String get ruleEnabledSuccessfully => 'Regel aktiveret succesfuldt';

  @override
  String ruleLoadFailed(Object error) {
    return 'Kunne ikke indlæse regler: $error';
  }

  @override
  String get ruleManagement => 'Regel Administration';

  @override
  String get ruleManagementTitle => 'Regel Administration';

  @override
  String get ruleName => 'Regelnavn';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Regelnavn og indholds-regex kan ikke være tomme';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Regelnavn og telefonnummer kan ikke være tomme';

  @override
  String get ruleNameHint => 'f.eks. Familie, Venner, osv.';

  @override
  String get ruleNameLabel => 'Regelnavn';

  @override
  String get ruleNamePatternRequired => 'Indtast venligst regelnavn og mønster';

  @override
  String get ruleNameRequired =>
      'Regelnavn og telefonnummer kan ikke være tomme';

  @override
  String get ruleNotExist => 'Regel findes ikke eller er blevet slettet';

  @override
  String ruleNotFound(Object error) {
    return 'Regel ikke fundet: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Regel gemt succesfuldt!';

  @override
  String get ruleSavedSuccessMessage => 'Regel gemt succesfuldt!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Gemning mislykkedes: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Gemning mislykkedes: $error';
  }

  @override
  String get ruleSaveSuccess => 'Regel gemt succesfuldt!';

  @override
  String get rulesExportedSuccessfully => 'Regler eksporteret succesfuldt';

  @override
  String rulesExportedTo(Object path) {
    return 'Regler eksporteret til: $path';
  }

  @override
  String get rulesImported => 'Regler importeret succesfuldt';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count regler importeret succesfuldt';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Kunne ikke importere regler: $error';
  }

  @override
  String get ruleStatistics => 'Regelstatistik';

  @override
  String ruleStatusChanged(Object status) {
    return 'Regel $status succesfuldt';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operation mislykkedes: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Regel $status succesfuldt';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Kunne ikke opdatere regel: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Regel opdateret succesfuldt';

  @override
  String get ruleVerification => 'Regelverifikation';

  @override
  String get save => 'Gem';

  @override
  String get saveButton => 'Gem';

  @override
  String get saveButtonLabel => 'GEM';

  @override
  String get saveButtonText => 'Gem';

  @override
  String saveFailed(Object error) {
    return 'Gemning mislykkedes: $error';
  }

  @override
  String get saveFilter => 'Gem filter';

  @override
  String get saveSettings => 'Gem indstillinger';

  @override
  String saveSettingsFailed(Object error) {
    return 'Kunne ikke gemme indstillinger: $error';
  }

  @override
  String get scamsLikely => 'Svindel sandsynlig';

  @override
  String get search => 'Søg';

  @override
  String get searchContacts => 'Søg i kontakter';

  @override
  String searchError(Object error) {
    return 'Søgefejl: $error';
  }

  @override
  String get searchFilters => 'Søgefiltre';

  @override
  String get searchForContacts => 'Søg efter kontakter';

  @override
  String get searchHint => 'Søg...';

  @override
  String get searchSettingsSubtitle =>
      'Søg efter kontakter, etiketter, sort-/hvidlister osv.';

  @override
  String get searchSettingsTitle => 'Søgeindstillinger';

  @override
  String get securityMessage =>
      'Stol ikke på telefonopkald. Verificer altid kundeservicenumre uafhængigt. Del aldrig adgangskoder, bekræftelseskoder, kortnumre eller personlige oplysninger.';

  @override
  String get selectActionToPerform =>
      'Vælg den handling, der skal udføres, når reglen matcher';

  @override
  String get selectActionWhenBlockingCalls =>
      'Vælg handling ved blokering af opkald';

  @override
  String get selectActionWhenRuleMatches => 'Vælg handling, når reglen matcher';

  @override
  String get selectAll => 'Vælg alle';

  @override
  String get selectCountry => 'Vælg land';

  @override
  String get selectDateRange => 'Vælg datointerval';

  @override
  String get selectedDateRange => 'Valgt datointerval';

  @override
  String selectedItems(Object count) {
    return '$count elementer valgt';
  }

  @override
  String get selectedLabel => 'Valgt:';

  @override
  String get selectExportFormat => 'Vælg eksportformat';

  @override
  String get selectLabel => 'Vælg etiket';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Vælg venligst en etiket og indtast et gyldigt telefonnummer';

  @override
  String get selectLanguage => 'Vælg sprog';

  @override
  String get selectMultiple => 'Vælg flere';

  @override
  String get selectPeriod => 'Vælg periode';

  @override
  String get selectSimCard => 'Vælg SIM-kort';

  @override
  String get selectSimSlot => 'Vælg SIM-slot';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Vælg den specifikke handling, der skal udføres ved blokerede opkald';

  @override
  String get selectTag => 'Vælg tag';

  @override
  String get selectTags => 'Vælg tags';

  @override
  String get selectTrustedDataSource => 'Vælg venligst betroede datakilder';

  @override
  String get selectYourLanguage => 'Vælg dit sprog';

  @override
  String get sender => 'Afsender';

  @override
  String get senderRegexOptional => 'Afsender Regex (valgfrit)';

  @override
  String get serverAddressLabel => 'Serveradresse';

  @override
  String get serviceTypeContact => 'Kontaktabonnement';

  @override
  String get serviceTypeLabel => 'Servicetype';

  @override
  String get serviceTypePhone => 'Telefonabonnement';

  @override
  String get serviceTypePlugin => 'Plugin-opdatering';

  @override
  String get serviceTypeSms => 'SMS-abonnement';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Indstil';

  @override
  String get setEncryptionPassword => 'Indstil krypteringsadgangskode';

  @override
  String get setEncryptionPasswordDescription =>
      'Indstil krypteringsadgangskode til backup og gendannelse';

  @override
  String get setEncryptionPasswordLabel => 'Indstil krypteringsadgangskode';

  @override
  String get setEncryptionPasswordTitle => 'Indstil krypteringsadgangskode';

  @override
  String get setPasswordButton => 'Indstil';

  @override
  String get settings => 'Indstillinger';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Indstillinger sikkerhedskopieret til: $path';
  }

  @override
  String get settingsLoaded => 'Indstillinger indlæst';

  @override
  String settingsLoadFailed(Object error) {
    return 'Kunne ikke indlæse indstillinger: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Indstillinger gendannet succesfuldt. Genstart venligst appen, for at ændringerne kan træde i kraft.';

  @override
  String get settingsSaved => 'Indstillinger gemt';

  @override
  String settingsSaveFailed(Object error) {
    return 'Kunne ikke gemme indstillinger: $error';
  }

  @override
  String get settingsTab => 'Indstillinger';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get setup => 'Opsætning';

  @override
  String get showContactEditDialogStaticMethod =>
      'Statisk metode til at vise dialog for redigering af kontakt';

  @override
  String get showExplanation => 'Vis forklaring';

  @override
  String get silence => 'Afbryd';

  @override
  String get silenceAndNoAnswer => 'Afbryd og intet svar';

  @override
  String get silenceNoAnswer => 'Afbryd intet svar';

  @override
  String get silentCallVoiceClone => 'Stille opkald stemmekloning';

  @override
  String get silentRules => 'Stille regler';

  @override
  String simCard(Object simNumber) {
    return 'SIM-kort $simNumber';
  }

  @override
  String get simCardColor => 'SIM-kort farve';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM-kortkonfiguration: Indstil uafhængige filtreringsregler for hvert SIM-kort';

  @override
  String get simCardFilterRules => 'SIM-kort filterregler';

  @override
  String get simCardFilterRulesDescription =>
      'Indstil forskellige filtreringsregler baseret på SIM-kort slots';

  @override
  String get simCardFontSize => 'SIM-kort skriftstørrelse';

  @override
  String get simCardPosition => 'SIM-kort position';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Kunne ikke indlæse SIM-kortinformation: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM-slotregler giver dig mulighed for at konfigurere uafhængige filtreringsregler for hvert SIM-slot.';

  @override
  String get simRuleInstructionsTitle => 'SIM-slotregler';

  @override
  String get simRuleManagement => 'SIM-slotregelhåndtering';

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
    return 'Kunne ikke indlæse SIM-data: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM-slotfilterkonfiguration';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Tillader indstilling af filterregler efter SIM-slot';

  @override
  String get simSlotFilterDescription =>
      'Konfigurer uafhængige filtreringsregler for hvert SIM-kort:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM-slot $slotNumber filterindstillinger';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Kunne ikke indlæse SIM-slots: $error';
  }

  @override
  String get simSlotManagement => 'SIM-slotshåndtering';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM-slotoperation mislykkedes: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM-slotposition $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM-slotregler: Uafhængige filtreringsstrategier pr. SIM';

  @override
  String get simSlotRuleListTitle => 'Liste over SIM-slotregler';

  @override
  String get simSlotRuleManagement => 'SIM-slotregler';

  @override
  String get simSlotRuleManagementTitle => 'Regelhåndtering';

  @override
  String get simSlotSettings => 'SIM-slotindstillinger';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM-slot $slotNumber';
  }

  @override
  String get skip => 'Spring over';

  @override
  String get smartCallerId => 'Smart opkaldsidentifikation';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS-filtrering hjælper dig med automatisk at filtrere spam-beskeder og holde din beskedliste ren. Du kan indstille filterregler og notifikationsmetoder.';

  @override
  String get smsFilterDisabled => 'SMS-filtrering deaktiveret';

  @override
  String get smsFilterEnabled => 'SMS-filtrering aktiveret';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'SMS-filterregel tilføjet succesfuldt';

  @override
  String get smsFilterRules => 'SMS-filterregler';

  @override
  String get smsFilterSettings => 'SMS-filterindstillinger';

  @override
  String get smsHistory => 'SMS-historik';

  @override
  String get smsManagement => 'SMS-håndtering';

  @override
  String get smsPermission => 'SMS-tilladelse';

  @override
  String get smsPermissionDescription =>
      'Bruges til at filtrere spam-beskeder.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS-regel tilføjet succesfuldt';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS-regel slettet succesfuldt';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Kunne ikke indlæse SMS-regler: $error';
  }

  @override
  String get smsRuleManagement => 'SMS-regelhåndtering';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS-regler eksporteret succesfuldt til $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'SMS-regler importeret succesfuldt';

  @override
  String get smsRuleSubscription => 'SMS-regelsubskription';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS-regel opdateret succesfuldt';

  @override
  String get smsSettingsSubtitle => 'SMS-filtrering og blokeringsord';

  @override
  String get smsSettingsTitle => 'SMS-indstillinger';

  @override
  String get smsSubscription => 'SMS-abonnements';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'SMS-abonnement tilføjet succesfuldt';

  @override
  String get smsSubscriptionRulesDescription =>
      'Abonner på SMS-regellister via URL, understøtter regulære udtryksmatches. Du kan indstille blokerings- eller tilladelseshandlinger.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Nogle tilladelsesanmodninger nægtet';

  @override
  String get spamLikely => 'Sandsynligvis spam';

  @override
  String get startColor => 'Startfarve';

  @override
  String get startDate => 'Startdato';

  @override
  String get startUsing => 'Kom i gang';

  @override
  String get statAnswered => 'Besvaret';

  @override
  String get statBlocked => 'Blokeret';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Statisk metode til at vise dialogen for opkalds-id-oplysninger';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Statisk metode til at vise dialogen for valg af land';

  @override
  String get staticMethodToDisplayDialog =>
      'Statisk metode til at vise dialogen';

  @override
  String get statistics => 'Statistik';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Funktion til eksport af statistik kommer snart';

  @override
  String get statisticsGrid => 'Statistikgitter';

  @override
  String get statisticsPageTitle => 'Dataanalyse';

  @override
  String get stirColor => 'STIR-farve';

  @override
  String get stirFontSize => 'STIR-skriftstørrelse';

  @override
  String get stirPosition => 'STIR-position';

  @override
  String get storagePermission => 'Lagerpladstilladelse';

  @override
  String get storagePermissionDescription =>
      'Bruges til at gemme indstillinger og regler.';

  @override
  String get subscribe => 'Abonner';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Abonnement \"$name\" tilføjet succesfuldt';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Er du sikker på, at du vil slette dette abonnement?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Slet abonnement';

  @override
  String get subscriptionDeleted => 'Abonnement slettet';

  @override
  String get subscriptionDeletedSuccessfully =>
      'Abonnement slettet succesfuldt';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Kunne ikke slette abonnement: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Abonnement slettet';

  @override
  String get subscriptionEmptyState => 'Ingen abonnementer tilgængelige';

  @override
  String get subscriptionEmptyText => 'Endnu ingen abonnementer';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Kunne ikke indlæse abonnementer: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Kunne ikke indlæse abonnementer: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Abonnementshåndtering';

  @override
  String get subscriptionName => 'Abonnementsnavn';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Abonnementsnavn og URL kan ikke være tomme';

  @override
  String get subscriptionNameHint => 'Indtast abonnementsnavn';

  @override
  String get subscriptionPageTitle => 'Abonnementshåndtering';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Kunne ikke ændre abonnementsstatus: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Kunne ikke skifte abonnementsstatus: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Kunne ikke opdatere abonnement: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Abonnement opdateret succesfuldt';

  @override
  String get subscriptionUrl => 'Abonnements-URL';

  @override
  String get subscriptionUrlHint => 'Indtast abonnements-URL';

  @override
  String successfullyImportedRules(Object count) {
    return '$count regler importeret succesfuldt';
  }

  @override
  String get supportSync => 'Understøtter synkronisering';

  @override
  String get survey => 'Undersøgelse';

  @override
  String get syncDevicesButton => 'Synkroniser enheder';

  @override
  String get syncFailed => 'Synkronisering mislykkedes';

  @override
  String get syncFailedMessage => 'Synkronisering mislykkedes';

  @override
  String get syncFolderNameHint =>
      'Indtast synkroniseringsfoldernavn (standard: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Synkroniseringsfoldernavn';

  @override
  String get synchronized => 'Synkroniseret';

  @override
  String get syncing => 'Synkroniserer...';

  @override
  String get syncNow => 'Synkroniser nu';

  @override
  String get syncNowButton => 'Synkroniser nu';

  @override
  String get syncStatusTitle => 'Synkroniseringsstatus';

  @override
  String get syncStatusUpdatedMessage => 'Synkroniseringsstatus opdateret';

  @override
  String get syncSuccessful => 'Synkronisering lykkedes';

  @override
  String get syncSuccessMessage => 'Synkronisering lykkedes';

  @override
  String get syncWithCloudStorage => 'Synkroniser med cloud-lagring';

  @override
  String get syncWithCloudStorageSubtitle => 'Synkroniser med cloud-lagring';

  @override
  String get systemFeatures => 'Systemfunktioner:';

  @override
  String get systemSettingsTitle => 'Systemindstillinger';

  @override
  String get tabAll => 'Alle';

  @override
  String get tabAnswered => 'Besvaret';

  @override
  String get tabBlocked => 'Blokeret';

  @override
  String get tabMissed => 'Ubesvaret';

  @override
  String get tabOutgoing => 'Udgående';

  @override
  String tagLabel(String tag) {
    return 'Mærkat: $tag';
  }

  @override
  String get tagsUpdated => 'Mærkater opdateret';

  @override
  String get takeaway => 'Takeaway';

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
  String get testConnectionButton => 'Test forbindelse';

  @override
  String get textColorsSetting => 'Tekst- og etiketfarver';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Denne app er et kraftfuldt opkalds-id-værktøj, der giver dig mulighed for at identificere og blokere uønskede opkald.';

  @override
  String get thisWeek => 'Denne uge';

  @override
  String get timeInterceptor => 'Tidsafskærer';

  @override
  String get timeInterceptorDescription =>
      'Afskær/tillad automatisk potentielle opkald baseret på opkaldsfrekvens';

  @override
  String get timeInterceptorExplanation =>
      '• Tidsafskærer: Afskær/tillad gentagne opkald inden for kort tid';

  @override
  String get timeInterceptorExplanationContent =>
      'Funktionen til afskæring af opkaldsfrekvens analyserer opkaldsfrekvensen for automatisk at identificere og afskære/tillade hyppige spamopkald.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Forklaring af afskæring af opkaldsfrekvens';

  @override
  String get timeInterceptorSettingsTitle =>
      'Indstillinger for afskæring af opkaldsfrekvens';

  @override
  String get timeInterceptorSubtitle =>
      'Afskær automatisk potentielle spamopkald baseret på opkaldsfrekvens';

  @override
  String get timeInterceptorTitle => 'Aktivér afskæring af opkaldsfrekvens';

  @override
  String get timeWindowDescription =>
      'Indstil tidsvinduets størrelse for tilladelse af gentagne opkald. Opkald fra samme nummer inden for dette vindue vil blive tilladt';

  @override
  String timeWindowLabel(int minutes) {
    return 'Afskæringstidsvindue (minutter): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Indstil tidsvinduets størrelse for tilladelse af gentagne opkald. Opkald fra samme nummer inden for dette vindue vil blive tilladt';

  @override
  String get today => 'I dag';

  @override
  String get total => 'Total';

  @override
  String get totalBlocked => 'Totalt blokeret';

  @override
  String get totalFiltered => 'Totalt filtreret';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Overfør data mellem enheder eller platforme';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Overfør data mellem enheder eller platforme';

  @override
  String get travelTicketing => 'Rejsebillettering';

  @override
  String get trend => 'Tendens';

  @override
  String get trendChart => 'Tendensdiagram';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get type => 'Type';

  @override
  String get unassignedSIMCard => 'Uassigned SIM-kort';

  @override
  String get unknown => 'Ukendt';

  @override
  String get unknownLabel => 'Ukendt etiket';

  @override
  String get unknownTag => 'Mærkat: Ukendt';

  @override
  String get unregisterButton => 'Afmeld';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Er du sikker på, at du vil afmelde $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Afmeld enhed';

  @override
  String get unsupportedFileFormat => 'Filformat understøttes ikke';

  @override
  String get update => 'Opdater';

  @override
  String get updateAllNow => 'Opdater alle nu';

  @override
  String get updateCallFilterConfig => 'Opdater konfiguration af opkaldsfilter';

  @override
  String updateContactFailed(Object error) {
    return 'Kunne ikke opdatere kontakt: $error';
  }

  @override
  String get updateFavoriteStatus => 'Opdater favoritstatus';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Kunne ikke opdatere favoritstatus: $error';
  }

  @override
  String get updateInterval => 'Opdateringsinterval';

  @override
  String get updateLabelFailed => 'Kunne ikke opdatere etiket';

  @override
  String get updateNow => 'Opdater nu';

  @override
  String get updatePlugin => 'Opdater plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'Kunne ikke opdatere plugin: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Kunne ikke opdatere regel: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Kunne ikke opdatere abonnement: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service opdateret succesfuldt ($count regler)';
  }

  @override
  String get updateTags => 'Opdater mærkater';

  @override
  String get useCasesPoint1 => '• Identificer auto-genopkalds-spamopkald';

  @override
  String get useCasesPoint2 =>
      '• Afskær marketingopkald, der ringer flere gange i en kort periode';

  @override
  String get useCasesPoint3 => '• Forhindr telefonbombardement og chikane';

  @override
  String get useCasesTitle => 'Brugsscenarier:';

  @override
  String get useGlobalSettings => 'Brug globale indstillinger';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Brugernavn';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Brug standard regex-syntaks til at definere mønstre. Eksempler:';

  @override
  String get validateRegex => 'Valider Regex';

  @override
  String get verificationFailedText => 'Mislykkedes';

  @override
  String get verifiedText => 'Verificeret';

  @override
  String get verify => 'Verificer';

  @override
  String version(Object version) {
    return 'Version: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Byt VIP-medlemskab med antal markeringer af telefonnumre';

  @override
  String get vipExchangeTitle => 'Markér udveksling VIP';

  @override
  String get watchAd => 'Se annonce';

  @override
  String get watchAdForTemp => 'Se annonce for midlertidige privilegier';

  @override
  String get watchAdForTempDescription =>
      'Se en kort annonce for midlertidigt at låse op for nogle premium-funktioner';

  @override
  String get webDAVConfigTitle => 'WebDAV-konfiguration';

  @override
  String get webdavConfigurationTitle => 'WebDAV-konfiguration';

  @override
  String get webdavPasswordHint => 'Indtast venligst WebDAV-adgangskode';

  @override
  String get webdavServerAddressHint => 'Indtast venligst WebDAV-serveradresse';

  @override
  String get webdavUsernameHint => 'Indtast venligst WebDAV-brugernavn';

  @override
  String get week => 'Uge';

  @override
  String get weekly => 'Ugentlig';

  @override
  String get weeklyBlockedCallsSummary =>
      'Ugentlig oversigt over blokerede opkald';

  @override
  String get weeklyChartTitle => 'Ugentlig blokerede opkald';

  @override
  String get weeklyReport => 'Ugentlig rapport';

  @override
  String get weeklyReportDesc =>
      'Modtag ugentlig opsummeringsrapport over blokeringsaktivitet for opkald';

  @override
  String get welcome => 'Velkommen';

  @override
  String get whitelist => 'Hvidliste';

  @override
  String get whitelistLabel => 'Hvidliste';

  @override
  String get width => 'Bredde';

  @override
  String get wildcardMatchingDescription =>
      'Brug \'.\' til at matche ethvert tegn (f.eks. \'123.456\' matcher 123-456)';

  @override
  String get wildcardMatchingTitle => 'Wildcard-matching:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Wildcard-understøttelse til fleksibel filtrering';

  @override
  String get windowSizeSetting => 'Vinduesstørrelse';

  @override
  String get year => 'År';

  @override
  String get yearly => 'Årligt';

  @override
  String get yearlyChartTitle => 'Årlige blokerede opkald';

  @override
  String get noSimCardsDetected => 'Ingen SIM-kort fundet';

  @override
  String get filterManagementDescription => 'Indstil opkaldsfiltre';

  @override
  String get callerIdCustomizationSubtitle => 'Tilpas layout for opkalds-ID';

  @override
  String get fraudAlerSettingTitle => 'Svindel-alarmindstilling';

  @override
  String get fraudAlerSettingSubtitle => 'For at indstille svindel-alarm';

  @override
  String get enableFraudAlert => 'Aktivér svindel-alarm';

  @override
  String get enableFraudAlertDescription => 'Alarm for mistænkte svindelopkald';

  @override
  String get enableVibration => 'Aktivér vibration';

  @override
  String get enableVibrationDescription =>
      'Vibrer, når opkald er mistænkte svindelopkald';

  @override
  String get notificationSettingsTitle => 'Notifikationsindstillinger';

  @override
  String get useLocalNotification => 'Brug lokale notifikationer';

  @override
  String get useLocalNotificationDescription =>
      'Aktivér lokale notifikationer for indgående opkald';

  @override
  String get cancelLocalNotification => 'Luk lokale notifikationer';

  @override
  String get useStirNotification => 'Brug notifikation fra STIR';

  @override
  String get useStirNotificationDescription =>
      'Aktivér STIR-notifikationer for indgående opkald';

  @override
  String get cancelLocalNotificationDescription =>
      'Luk lokale notifikationer automatisk';

  @override
  String get callerIdSettingsTitle => 'Indstillinger for opkalds-ID';

  @override
  String get callerIdSettingsSubtitle =>
      'For at konfigurere indgående opkaldsnotifikation og visningstilstand';

  @override
  String get purchaseTitle => 'Køb';

  @override
  String get purchaseSubtitle => 'For at købe tjenesten';

  @override
  String get callerIdNotificationTitle => 'Info om indgående opkald';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Nummer: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Blokeret opkald';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Blokeret opkald fra $phoneNumber';
  }

  @override
  String get stirVerified => 'Verificeret';

  @override
  String get stirNotVerified => 'Ikke verificeret';

  @override
  String get stirFailed => 'Verifikation mislykkedes';

  @override
  String get stirUnknown => 'Ukendt verifikationsstatus';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN Verifikation';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage for nummer $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Indstillinger for rullende sikkerhedsbesked';

  @override
  String get messageColor => 'Beskedfarve';

  @override
  String get messageFontSize => 'Besked skriftstørrelse';

  @override
  String get messagePosition => 'Beskedposition';

  @override
  String get containerWidth => 'Beholderbredde';

  @override
  String get scrollSpeed => 'Rullefart';

  @override
  String get enableSecurityMessage => 'Aktivér sikkerhedsbesked';

  @override
  String get fraudAlertTitle => 'Svindel-alarm';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Potentielt svindelopkald fra $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Kunne ikke indlæse regler: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Kunne ikke indlæse opkaldslog: $error';
  }

  @override
  String get noBlockedTypeData => 'Ingen data om blokeret type tilgængelig';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importer $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName importeret succesfuldt, i alt $count poster importeret';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Kunne ikke importere $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Eksporter $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName eksporteret succesfuldt';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Kunne ikke eksportere $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Cloud Synkroniseringstjeneste';

  @override
  String get membershipCenter => 'Medlemskabscenter';

  @override
  String get redeemVipWithMarks => 'Indløs VIP med mærker';

  @override
  String get currentMarkCount => 'Nuværende antal mærker';

  @override
  String get markMoreNumbersForMore => 'Marker flere numre for flere mærker';

  @override
  String get noAds => 'Ingen reklamer';

  @override
  String get cloudBackup => 'Cloud Backup';

  @override
  String get callerIdEnhancement => 'Forbedring af opkalds-ID';

  @override
  String get voiceRecognition => 'Talegenkendelse';

  @override
  String get feature => 'Funktion';

  @override
  String get normalUser => 'Normal bruger';

  @override
  String get vipUser => 'VIP bruger';

  @override
  String get temporaryVip => 'Midlertidig VIP';

  @override
  String get removeAds => 'Fjern reklamer';

  @override
  String get unknownAction => 'Ukendt handling';

  @override
  String get settingsBackup => 'Indstillingsbackup ';

  @override
  String get allServicesStatusTitle => 'Aktuel tjenestestatus';

  @override
  String get allServicesStatusSubtitle =>
      'Aktuel status for hver cloudtjeneste';

  @override
  String get redirect => 'Omdiriger';

  @override
  String get notify => 'Underret';

  @override
  String get log => 'Log';

  @override
  String get custom => 'Brugerdefineret';

  @override
  String get allowActionDescription =>
      'Opkald vil blive tilladt, selvom nummeret er på blokeringslisten.';

  @override
  String get blockActionDescription =>
      'Opkald vil blive blokeret og vist i opkaldsloggen.';

  @override
  String get silenceActionDescription =>
      'Opkald vil blive lydløse, men vist i opkaldsloggen.';

  @override
  String get noneActionDescription =>
      'Ingen speciel handling vil blive udført for opkaldet.';

  @override
  String get redirectActionDescription =>
      'Omdiriger opkaldet til et angivet nummer.';

  @override
  String get labelActionDescription =>
      'Tilføj en etiket til opkaldet for nem identifikation.';

  @override
  String get notifyActionDescription =>
      'Send en notifikation, når et opkald modtages.';

  @override
  String get logActionDescription =>
      'Log opkaldsoplysninger uden at udføre andre handlinger.';

  @override
  String get customActionDescription => 'Udfør en brugerdefineret handling.';

  @override
  String get synced => 'Synkroniseret';

  @override
  String get needVipAccess =>
      'Du skal have VIP-adgang for at bruge denne funktion';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importer eller eksporter $entityTypeName data';
  }

  @override
  String get importExportTitle => 'Import/Eksport';

  @override
  String get noPhoneRules => 'Ingen telefonregler fundet';

  @override
  String get noRegexRules => 'Ingen regex-regler fundet';

  @override
  String get noAllowedBlockedRules => 'Ingen tilladte/blokerede regler fundet';

  @override
  String get importExport => 'Import/Eksport';

  @override
  String get filterByAction => 'Filtrer efter handling';

  @override
  String get upgradeToVip => 'Opgrader til VIP';

  @override
  String get batteryOptimizationPermission => 'Batterioptimering';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Tillad appen at køre i baggrunden for at levere tjenester som opkaldsidentifikation.';

  @override
  String get permissionTitle => 'Særlige Tilladelser';

  @override
  String get permissionSubtitle =>
      'Administrer overlay- og batterioptimeringsrettigheder';

  @override
  String get themeSettingsTitle => 'Temaindstillinger';

  @override
  String get themeSettingsSubtitle => 'Vælg dit yndlingstema';

  @override
  String get databaseSyncTitle => 'Datasynkronisering';

  @override
  String get countrySyncSettingsTitle =>
      'Landespecifik datasynkroniseringsindstillinger';

  @override
  String get countrySyncSettingsSubtitle => 'Vælg lande til datasynkronisering';

  @override
  String get countryDataDisclaimer =>
      'Bemærk venligst: Databasen indeholder muligvis ikke data for alle specifikke lande eller regioner.';

  @override
  String get editSubscription => 'Rediger abonnement';

  @override
  String get searchByNameOrPhoneNumber => 'Søg efter navn eller telefonnummer';

  @override
  String get allowedBlockedRulesInfo =>
      'Tilladte/blokerede regler bruges til at matche opkald med specifikke telefonnumre, som har den højeste prioritet.';

  @override
  String get searchPhoneRulesHint => 'Søg efter telefonregler';

  @override
  String get phoneRulesInfo =>
      'Telefonregler bruges til at matche opkald med specifikke telefonnumre, som har en lavere prioritet. Nogle kommer fra telefonregler-abonnementer';

  @override
  String get searchSubscriptionsHint => 'Søg efter abonnementer';

  @override
  String get searchPluginsHint => 'Søg efter plugins';

  @override
  String get searchLabelsHint => 'Søg efter etiketter';

  @override
  String get pluginDescription => 'Plugin-beskrivelse';

  @override
  String get enterPluginDescription => 'Indtast plugin-beskrivelse';

  @override
  String get searchRegexRulesHint => 'Søg efter regex-regler';

  @override
  String get regexRulesInfo =>
      'Regex-regler bruges til at filtrere opkald baseret på Regex-mønstre.';

  @override
  String get searchMarkedPhonesHint => 'Søg efter markerede telefoner';

  @override
  String get searchContactSubscriptionsHint => 'Søg efter kontaktabonnementer';

  @override
  String get showAllContacts => 'Vis alle kontakter';

  @override
  String get showFavorites => 'Vis favoritter';

  @override
  String get manualEntry => 'Manuel indtastningsinformation';

  @override
  String get scriptSaved => 'Script gemt';

  @override
  String editScriptFor(String pluginName) {
    return 'Rediger script for $pluginName';
  }

  @override
  String get saveScript => 'Gem script';

  @override
  String get testPlugin => 'Test plugin';

  @override
  String get description => 'Beskrivelse';

  @override
  String get accessTargetUrl => 'Få adgang til målets URL';

  @override
  String get result => 'Resultat';

  @override
  String get editScript => 'Rediger script';

  @override
  String get numberFormat => 'Nummerformat';

  @override
  String get nationalNumber => 'Nationalt nummer';

  @override
  String get e164Number => 'E164 nummer';

  @override
  String get pluginRulesInfo =>
      'Af sikkerhedsmæssige årsager, brug venligst kun plugins fra troværdige kilder. Du er velkommen til at bruge vores skabeloner til at oprette dine egne brugerdefinerede plugins!';

  @override
  String get advancedMode => 'Avanceret tilstand';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Indtast venligst mindst ét nummer.';

  @override
  String get openInWebView => 'Åbn i WebView';

  @override
  String get pluginLabel => 'Plugin-etiket';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Baggrundsfarve på besked';

  @override
  String get clearAllCallLogs => 'Ryd alle opkaldslogger';

  @override
  String get clearAllCallLogsConfirmation =>
      'Bekræft for at rydde alle opkaldslogger';

  @override
  String get allCallLogsCleared => 'Alle opkaldslogger er ryddet';

  @override
  String get unblocked => 'Fjernet blokering';

  @override
  String get blockNumber => 'Bloker nummer';

  @override
  String get blockNumberSuccess => 'Nummer blokeret succesfuldt';

  @override
  String get blockNumberFailed => 'Blokering af nummer mislykkedes';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Er du sikker på, at du vil fjerne blokeringen af $phoneNumber?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Ringer til $phoneNumber...';
  }

  @override
  String get viewDetails => 'Se detaljer';

  @override
  String get unblock => 'Fjern blokering';

  @override
  String get unblockNumber => 'Fjern blokering af nummer';

  @override
  String get unblockNumberSuccess => 'Nummer fjernet blokering succesfuldt';

  @override
  String get unblockNumberFailed => 'Fjernelse af nummer blokering mislykkedes';

  @override
  String get serviceNotAvailable => 'Tjeneste ikke tilgængelig';

  @override
  String get callingNumberFailed => 'Opkald til nummer mislykkedes';

  @override
  String get listView => 'Liste view';

  @override
  String get timelineView => 'Tidslinje view';

  @override
  String get nameCannotBeEmpty => 'Navn kan ikke være tomt';

  @override
  String get selectAction => 'Vælg handling';

  @override
  String get selectTargetService => 'Vælg måltjeneste';

  @override
  String get callDetails => 'Opkaldsdetaljer';

  @override
  String get callType => 'Opkaldstype';

  @override
  String get callTime => 'Opkaldstidspunkt';

  @override
  String get numberInvalidFormat => 'Nummer i ugyldigt format';

  @override
  String get membershipFeature => 'Medlemskabsfunktion';

  @override
  String get medium => 'Medium';

  @override
  String get finalRisk => 'Endelig risiko';

  @override
  String get simState => 'SIM-status';

  @override
  String get ipCountry => 'IP-land';

  @override
  String get simCountry => 'SIM-land';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Nummermatch';

  @override
  String get support => 'Support';

  @override
  String get rewardedAdService => 'Belønnede annoncetjenester';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Du har allerede VIP-privilegier (undtagen annoncer)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Du har allerede midlertidige privilegier, udløbsdato: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Du skal se $count annoncer mere for at få midlertidige VIP-privilegier';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Du er blevet tildelt $days dages midlertidig købsprivilegie. Udløbsdato: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Midlertidigt købsprivilegie er udløbet';

  @override
  String get loadingAd => 'Indlæser annonce...';

  @override
  String get earnedTempVip => 'Optjent midlertidig VIP';

  @override
  String get vipExchangeService => 'VIP-udvekslingstjeneste';

  @override
  String get marksInsufficient => 'Utilstrækkelige mærker til udveksling';

  @override
  String get invalidExchangeRule => 'Ugyldig udvekslingsregel';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Succesfuldt udvekslet for $description, udløbsdato: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Udveksling mislykkedes: $error';
  }

  @override
  String get vip3DaysWithAds => '3-dages VIP med annoncer (kun synkronisering)';

  @override
  String get vip5DaysNoAds => '5-dages fuldt udstyret reklamefri VIP';

  @override
  String get vip7DaysNoAds => '7-dages fuldt udstyret reklamefri VIP';

  @override
  String get noNotifications => 'Ingen notifikationer';

  @override
  String get clearAllNotifications => 'Ryd alle notifikationer';

  @override
  String get clearAllNotificationsConfirmation =>
      'Bekræft for at rydde alle notifikationer';

  @override
  String get allNotificationsCleared => 'Alle notifikationer ryddet';

  @override
  String get clearButton => 'Ryd';

  @override
  String get justNow => 'Lige nu';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutter siden',
      one: '1 minut siden',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count timer siden',
      one: '1 time siden',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dage siden',
      one: '1 dag siden',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'I går';

  @override
  String get deletionProposal => 'Sletningsforslag';

  @override
  String get createProposal => 'Opret forslag';

  @override
  String get createProposalTitle => 'Opret sletningsforslag';

  @override
  String get reason => 'Årsag';

  @override
  String get reasonOutdated => 'Forældet nummer';

  @override
  String get reasonPrivacy => 'Privatlivsproblemer';

  @override
  String get reasonNotInService => 'Ikke i brug';

  @override
  String get reasonWronglyIdentified => 'Forkert identificeret';

  @override
  String get reasonInaccurateInfo => 'Unøjagtige oplysninger';

  @override
  String get reasonWrongMarked => 'Forkert markeret';

  @override
  String get reasonOther => 'Andet';

  @override
  String get submit => 'Send';

  @override
  String get cancel => 'Annuller';

  @override
  String get proposalStatus => 'Status';

  @override
  String get statusPending => 'Afventer';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusCompleted => 'Gennemført';

  @override
  String get statusExpired => 'Udløbet';

  @override
  String get riskLevel => 'Risikoniveau';

  @override
  String get riskLevelVerified => 'Bekræftet';

  @override
  String get riskLevelLow => 'Lav';

  @override
  String get riskLevelHigh => 'Høj';

  @override
  String get riskLevelUnknown => 'Ukendt';

  @override
  String get votingProgress => 'Afstemningsfremgang';

  @override
  String agreeVotes(int count) {
    return 'Enige: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Uenige: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Total: $count';
  }

  @override
  String get voteAgree => 'Enig';

  @override
  String get voteDisagree => 'Uenig';

  @override
  String createdAt(String date) {
    return 'Oprettet: $date';
  }

  @override
  String get verificationReport => 'Verifikationsrapport';

  @override
  String get showReport => 'Vis rapport';

  @override
  String get hideReport => 'Skjul rapport';

  @override
  String get proposalStatistics => 'Forslagsstatistik';

  @override
  String get totalProposals => 'Totale forslag';

  @override
  String get activeProposals => 'Aktive forslag';

  @override
  String get completedProposals => 'Gennemførte forslag';

  @override
  String get myVotes => 'Mine stemmer';

  @override
  String get proposalCreated => 'Forslag oprettet succesfuldt';

  @override
  String get proposalCreateFailed => 'Kunne ikke oprette forslag';

  @override
  String get voteSubmitted => 'Stemme indsendt succesfuldt';

  @override
  String get voteSubmitFailed => 'Kunne ikke indsende stemme';

  @override
  String get noProposalsFound => 'Ingen forslag fundet';

  @override
  String get loadingProposals => 'Indlæser forslag...';

  @override
  String get refreshProposals => 'Opdater forslag';

  @override
  String get totalPendingProposals => 'Totale afventende forslag';

  @override
  String get highRisk => 'Høj risiko';

  @override
  String get mediumRisk => 'Medium risiko';

  @override
  String get lowRisk => 'Lav risiko';

  @override
  String get communityImpact => 'Fællesskabspåvirkning';

  @override
  String get criticalIssues => 'Kritiske problemer';

  @override
  String get communityParticipation => 'Fællesskabsdeltagelse';

  @override
  String get noActivity => 'Ingen aktivitet';

  @override
  String get low => 'Lav';

  @override
  String get moderate => 'Moderat';

  @override
  String get high => 'Høj';

  @override
  String get veryHigh => 'Meget høj';

  @override
  String get voted => 'Stemte';

  @override
  String get communityVotes => 'Fællesskabsstemmer';

  @override
  String get waitingForMoreVotes => 'Venter på flere fællesskabsstemmer';

  @override
  String get proposalProcessed => 'Dette forslag er blevet behandlet';

  @override
  String get supported => 'STØTTET';

  @override
  String get opposed => 'IMOD';

  @override
  String get approved => 'GODKENDT';

  @override
  String get rejected => 'AFVIST';

  @override
  String get completed => 'GENNEMFØRT';

  @override
  String get pending => 'AFVENTER';

  @override
  String get critical => 'Kritisk';

  @override
  String get oppose => 'Modarbejde';

  @override
  String get veryLow => 'Meget lav';

  @override
  String get deletionProposals => 'Sletningsforslag';

  @override
  String get deletionProposalNotificationDescription =>
      'Notifikationer om resultater og opdateringer af afstemninger om sletningsforslag.';

  @override
  String get deletionProposalCreated => 'Sletningsforslag oprettet';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Dit sletningsforslag for $phoneNumber er blevet indsendt til fællesskabsevaluering.';
  }

  @override
  String get proposalApproved => 'Forslag godkendt ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Sletningsforslaget for $phoneNumber er blevet godkendt af fællesskabet ($supportPercentage% støtte, $totalVotes stemmer).';
  }

  @override
  String get proposalRejected => 'Forslag afvist ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Sletningsforslaget for $phoneNumber er blevet afvist af fællesskabet ($supportPercentage% støtte, $totalVotes stemmer).';
  }

  @override
  String get communityVotingStarted => 'Fællesskabsafstemning startet';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Et nyt sletningsforslag for $phoneNumber er nu åbent for fællesskabsafstemning.';
  }

  @override
  String get votingCompleted => 'Afstemning afsluttet';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Fællesskabsafstemningen for $phoneNumber er afsluttet. Resultat: $result ($supportPercentage% støtte).';
  }

  @override
  String get newVoteReceived => 'Ny stemme modtaget';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Nogen stemte for at $voteType sletningen af $phoneNumber. Aktuelle stemmer: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Kunne ikke indlæse antal stemmer';

  @override
  String get voteCount => 'Antal stemmer';

  @override
  String get deletionProposalInfo => 'Oplysninger om sletningsforslag';

  @override
  String get deletionProposalDescription =>
      'Foreslå numre til sletning, der overtræder fællesskabets retningslinjer. Din deltagelse hjælper med at holde platformen sikker.';

  @override
  String get voteToEarnVip => 'Stem på forslag for at tjene VIP-privilegier!';

  @override
  String get voteFailed => 'Afstemning mislykkedes';

  @override
  String get searchProposals => 'Søg forslag';

  @override
  String get defaultNotifications => 'Standard notifikationer';

  @override
  String get defaultNotificationsDescription =>
      'Standard notifikationskanal for appen.';

  @override
  String get blockedCallNotifications => 'Blokerede opkaldsnotifikationer';

  @override
  String get blockedCallNotificationsDescription =>
      'Viser oplysninger om blokerede opkald.';

  @override
  String get stirVerification => 'STIR/SHAKEN Verifikation';

  @override
  String get stirVerificationDescription =>
      'Viser STIR/SHAKEN-verifikationsresultater for numre.';

  @override
  String get fraudAlerts => 'Svindeladvarsler';

  @override
  String get fraudAlertsDescription =>
      'Viser advarsler om potentielt svigagtige opkald.';

  @override
  String get notificationFrequencyDescription =>
      'Vælg, hvor ofte du modtager notifikationer om nye sletteforslag. Du kan modtage dem øjeblikkeligt, i batches eller med et brugerdefineret interval.';

  @override
  String get notificationMode => 'Notifikationstilstand';

  @override
  String get immediateNotifications => 'Øjeblikkelig';

  @override
  String get immediateNotificationsDescription =>
      'Modtag en notifikation, så snart et forslag er oprettet.';

  @override
  String get batchNotifications => 'Batch';

  @override
  String get batchNotificationsDescription =>
      'Modtag en opsummering af notifikationer med jævne mellemrum.';

  @override
  String get customNotifications => 'Brugerdefineret';

  @override
  String get customNotificationsDescription =>
      'Definer dit eget interval for modtagelse af notifikationer.';

  @override
  String get customFrequency => 'Brugerdefineret frekvens';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours t';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get pendingProposals => 'Afventende forslag';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count afventende forslag',
      one: '1 afventende forslag',
      zero: 'ingen afventende forslag',
    );
    return 'Du har $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Retningslinjer';

  @override
  String get riskLevelLabel => 'Risikoniveau';

  @override
  String get riskLevelDescription => 'Risikoniveau for nummeret';

  @override
  String get phoneNumberMinDigits =>
      'Telefonnummer skal være mindst 7 cifre langt';

  @override
  String get provideDetailedExplanation =>
      'Angiv en detaljeret forklaring (minimum 10 tegn)';

  @override
  String get reasonMinCharacters => 'Årsag skal være mindst 10 tegn lang';

  @override
  String get countryCodeTwoLetters => 'Landekode (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Landekode (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'f.eks. DK, US, GB';

  @override
  String get countryCodeRequired => 'Landekode er påkrævet';

  @override
  String get countryCodeLengthError => 'Landekoden skal være 2 bogstaver';

  @override
  String get phoneNumberHint => 'Indtast telefonnummer';

  @override
  String get phoneNumberRequired => 'Telefonnummer er påkrævet';

  @override
  String get phoneNumberLengthError =>
      'Telefonnummer skal være mindst 7 cifre langt';

  @override
  String get reasonHint => 'Angiv detaljeret forklaring (minimum 10 tegn)';

  @override
  String get reasonRequired => 'Årsag er påkrævet';

  @override
  String get reasonLengthError => 'Årsag skal være mindst 10 tegn lang';

  @override
  String get guidelinesTitle => 'Retningslinjer';

  @override
  String get guidelinesText =>
      '• Rapporter kun numre, der er reelt problematiske\n• Angiv nøjagtige og detaljerede årsager\n• Vælg passende risikoniveau baseret på sværhedsgrad\n• Falske rapporter kan medføre begrænsninger på kontoen';

  @override
  String get riskLevelCritical => 'Kritisk';

  @override
  String get riskLevelMedium => 'Mellem';

  @override
  String get riskLevelVeryLow => 'Meget lav';

  @override
  String get riskDescriptionVeryLow =>
      'Meget lav - Mindre irritation, sjældne opkald';

  @override
  String get riskDescriptionLow => 'Lav - Lejlighedsvise uønskede opkald';

  @override
  String get riskDescriptionMedium =>
      'Mellem - Regelmæssig spam eller telemarketing';

  @override
  String get riskDescriptionHigh =>
      'Høj - Vedvarende chikane eller svindelforsøg';

  @override
  String get riskDescriptionCritical =>
      'Kritisk - Farlige svindelnumre eller trusler';

  @override
  String get notificationFrequencyTitle => 'Notifikationsfrekvens';

  @override
  String get notificationFrequencyLabel => 'Notifikationsfrekvens (timer)';

  @override
  String errorMessage(String error) {
    return 'Fejl: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Stemmer: $totalVotes ($supportPercentage% opbakning)';
  }

  @override
  String get timeJustNow => 'Lige nu';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m siden';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}t siden';
  }

  @override
  String timeDaysAgo(int days) {
    return '${days}d siden';
  }

  @override
  String get reportingGuidelines =>
      '• Rapporter kun numre, der er reelt problematiske\n• Angiv nøjagtige og detaljerede årsager\n• Vælg passende risikoniveau baseret på sværhedsgrad\n• Falske rapporter kan medføre begrænsninger på kontoen';

  @override
  String get notificationFrequencyHours => 'Notifikationsfrekvens (timer)';

  @override
  String supportCount(int supportCount) {
    return 'Støtte ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Imod ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes stemmer ($supportPercentage% opbakning)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count timer',
      one: '1 time',
      zero: '0 timer',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Vigtig bemærkning';

  @override
  String get dataSourceDisclaimer =>
      'Numre hentes fra internettet og brugerindberetninger. Vi kan ikke garantere, at et nummer, når det er blevet slettet, ikke vil blive genindberettet af andre brugere eller kilder. Søg aktivt og verificer oplysninger.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Lokation';

  @override
  String get simCardTitle => 'SIM-kort';

  @override
  String get liveActivitiesSettingsTitle => 'Live Aktivitetsindstillinger';

  @override
  String get elementsSettingsTitle => 'Elementindstillinger';

  @override
  String get liveActivityMode => 'Live Aktivitet';

  @override
  String get liveActivityModeDescription =>
      'Viser opkaldsoplysninger som en vedvarende notifikation på låseskærmen og i Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'Telefonnummer Type';

  @override
  String get liveActivitiesTestEndActivity => 'Afslut Aktivitet';

  @override
  String get liveActivitiesTestSendNewActivity => 'Send Ny Aktivitet';

  @override
  String get liveActivitiesTestUpdateActivity => 'Opdater Aktivitet';

  @override
  String get liveActivityControlsTitle => 'Live Aktivitetsstyring';

  @override
  String get liveActivitiesTestTitle => 'Live Aktivitets Test';

  @override
  String get liveActivitiesTestSubtitle =>
      'Test live aktivitetsnotifikationen.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Tilpasning af Live Notifikation';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Tilpas udseendet af live notifikationer.';

  @override
  String get notification_instructions =>
      'Instruktioner:\n1. Tryk på \"SEND\" for at oprette eller opdatere en notifikation.\n2. Gå til din startskærm eller træk notifikationsbakken ned for at se resultatet.\n3. Tryk på \"AFSLUT\" for at lukke notifikationen.';

  @override
  String get autoCancelNotification => 'Automatisk annullering af notifikation';

  @override
  String get autoCancelNotificationDescription =>
      'Hvis markeret, annulleres notifikationen automatisk, når brugeren trykker på den.';

  @override
  String get setDelayTime => 'Indstil forsinkelsestid';

  @override
  String get proposalDetails => 'Forslagsdetaljer';

  @override
  String get filterByStatus => 'Filtrer efter status';

  @override
  String get proposalNotFound => 'Forslag ikke fundet';

  @override
  String get processed => 'Behandlet';

  @override
  String get showAll => 'Vis alle';

  @override
  String get filterAndSortTitle => 'Filtrer og Sorter';

  @override
  String get filterVerifiedOwner => 'Filtrer Verificeret Ejer';

  @override
  String get filterBy => 'Filtrer efter';

  @override
  String get sortOldest => 'Sorter Ældste';

  @override
  String get sortNewest => 'Sorter Nyeste';

  @override
  String get sortMostPopular => 'Sorter Mest Populære';

  @override
  String get sortLeastPopular => 'Sorter Mindst Populære';

  @override
  String get sortBy => 'Sorter efter';

  @override
  String get simRulesNotFound => 'SIM-regler ikke fundet';

  @override
  String get simSlotRules => 'SIM-slot regler';

  @override
  String get noSimCardDetected => 'Intet SIM-kort registreret';

  @override
  String get invalidSimData => 'Ugyldige SIM-data';

  @override
  String get simCardData => 'SIM-kort data';

  @override
  String get simSlot => 'SIM-slot';

  @override
  String get enableFiltering => 'Aktiver filtrering';

  @override
  String get detailedSettingsTitle => 'Detaljerede indstillinger';

  @override
  String get entryPointViewTitle => 'Indgangsvisning';

  @override
  String get callTypeRejected => 'Afvist';

  @override
  String get callTypeSilenced => 'Dæmpet';

  @override
  String get callTypeVoicemail => 'Svarer';

  @override
  String get callTypeUnknownIntercept => 'Ukendt opsnapning';

  @override
  String andMoreItems(int count) {
    return 'og $count flere emner';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

  @override
  String get localDatabaseSyncSubtitle => 'Sync data across devices';

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

  @override
  String get leaveEmptyToUseDefault => 'Leave empty to use default';

  @override
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';

  @override
  String failedToLoadSettingsSchema(String error) {
    return 'Failed to load settings schema: $error';
  }

  @override
  String get noSettingsAvailable => 'No settings available for this plugin.';

  @override
  String get fieldIsRequired => 'This field is required';

  @override
  String get answerThenHangupDescription =>
      'Automatically answer the incoming call and then immediately hang up to terminate it';
}
