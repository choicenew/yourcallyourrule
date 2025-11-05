// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get aboutContactSubscription => 'Oor Kontakinskrywing';

  @override
  String get aboutLabels => 'Oor Etikette';

  @override
  String get aboutPhoneSubscriptionRules => 'Oor Telefooninskrywingsreëls';

  @override
  String get aboutPhoneSubscriptions => 'Oor Telefooninskrywings';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Teken in op telefoonreëllyste via URL, werk reëls outomaties op. Ondersteun JSON, CSV formaat reëllêers.';

  @override
  String get aboutSmsFilter => 'Oor SMS-filtrering';

  @override
  String get aboutSmsSubscriptionRules => 'Oor SMS-inskrywingsreëls';

  @override
  String get aboutSubtitle => 'Toepassingsweergawe en wettige inligting';

  @override
  String get aboutTitle => 'Meer';

  @override
  String get action => 'Aksie';

  @override
  String get actionAll => 'Alles';

  @override
  String get actionAllow => 'Toelaat';

  @override
  String get actionBlock => 'Blokkeer';

  @override
  String get actionFilterAll => 'Alle filters';

  @override
  String get actionFilterTitle => 'Filter volgens aksietipe';

  @override
  String get actionFilterTooltip => 'Aksie Filter';

  @override
  String get actionNone => 'Geen aksie nie';

  @override
  String get actionSilence => 'Stil';

  @override
  String actionTag(Object actionType) {
    return 'Aksie: $actionType';
  }

  @override
  String get actionType => 'Aksietipe';

  @override
  String get actionUnknown => 'Onbekend';

  @override
  String get add => 'Voeg by';

  @override
  String get addAllowedBlockedRule => 'Voeg Toelaat/Blokkeer Reël by';

  @override
  String get addAllowSubscription => 'Voeg Toelaatinskrywing by';

  @override
  String get addBlockSubscription => 'Voeg Blokinskrywing by';

  @override
  String get addContactButton => 'Voeg kontak by';

  @override
  String addContactFailed(Object error) {
    return 'Kon nie kontak byvoeg nie: $error';
  }

  @override
  String get addedToAllowedRules => 'By Toegelate Reëls gevoeg';

  @override
  String get addedToBlacklist => 'By Swartlys gevoeg';

  @override
  String get addedToBlockedRules => 'By Geblokkeerde Reëls gevoeg';

  @override
  String get addedToFavoriteContacts => 'By gunstelingkontakte gevoeg';

  @override
  String get addedToFavorites => 'By gunstelinge gevoeg';

  @override
  String get addedToWhitelist => 'By Witlys gevoeg';

  @override
  String get addFavorite => 'Voeg gunsteling by';

  @override
  String get addFilter => 'Voeg filter by';

  @override
  String get addLabel => 'Voeg etiket by';

  @override
  String get addLabelButton => 'Voeg etiket by';

  @override
  String addLabelFailed(Object error) {
    return 'Kon nie etiket byvoeg nie: $error';
  }

  @override
  String get addLabelToCall => 'Voeg etiket by oproeprekord';

  @override
  String get addName => 'Voeg naam by';

  @override
  String get addNoneSubscription => 'Voeg Geeninskrywing by';

  @override
  String get addOrEditContactInfo =>
      'Gebruik om kontakbesonderhede by te voeg of te wysig';

  @override
  String get addPhoneMark => 'Voeg Telefoonmerk by';

  @override
  String get addPhoneNumberRule => 'Voeg Telefoonnommer Reël by';

  @override
  String get addPlugin => 'Voeg inprop by';

  @override
  String get addPluginFailed => 'Kon nie inprop byvoeg nie';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Kon nie inprop byvoeg nie: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Voeg inprop vanaf lokale lêer by';

  @override
  String get addPluginFromUrl => 'Voeg inprop vanaf URL by';

  @override
  String get addRegexRule => 'Voeg Regex Reël by';

  @override
  String get addRule => 'Voeg reël by';

  @override
  String get addRuleButton => 'Voeg reël by';

  @override
  String addRuleFailed(Object error) {
    return 'Kon nie reël byvoeg nie: $error';
  }

  @override
  String get addRuleTooltip => 'Voeg Reël by';

  @override
  String get addSilenceSubscription => 'Voeg Stilte-inskrywing by';

  @override
  String get addSimRuleButton => 'Voeg SIM Reël by';

  @override
  String get addSmsFilterRule => 'Voeg SMS Filter Reël by';

  @override
  String get addSmsRule => 'Voeg SMS Reël by';

  @override
  String get addSmsSubscription => 'Voeg SMS-inskrywing by';

  @override
  String get addSubscription => 'Voeginskrywing by';

  @override
  String get addSubscriptionButton => 'Voeginskrywing by';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Kon nie inskrywing byvoeg nie: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Voeg Inskrywing by';

  @override
  String get addToAllowedRules => 'Voeg by Toegelate Reëls';

  @override
  String get addToBlacklist => 'Voeg by Swartlys';

  @override
  String get addToBlockedRules => 'Voeg by Geblokkeerde Reëls';

  @override
  String get addToFavoriteContacts => 'Voeg by Gunsteling Kontakte';

  @override
  String get addToFavorites => 'Voeg by Gunstelinge';

  @override
  String get addToRules => 'Voeg by Reëls';

  @override
  String get addToWhitelist => 'Voeg by Witlys';

  @override
  String get adPlaceholder => 'Ad Placeholder';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Alles';

  @override
  String get allCallsTab => 'Alle';

  @override
  String get allDataClearedSuccessfully => 'Alle data suksesvol uitgevee';

  @override
  String get allow => 'Toelaat';

  @override
  String get allowAllAllowRules => 'Laat Alle Toelaat Reëls toe';

  @override
  String get allowAllAllowRulesDesc => 'Laat oproepe van toelaatreëls toe';

  @override
  String get allowAllBlacklistedNumbers => 'Laat Alle Swartgelyste Nommers toe';

  @override
  String get allowAllBlacklistedNumbersDesc => 'Laat oproepe van swartlys toe';

  @override
  String get allowAllBlockRules => 'Laat Alle Blok Reëls toe';

  @override
  String get allowAllBlockRulesDesc => 'Laat oproepe van blokreëls toe';

  @override
  String get allowAllowedNumbers => 'Laat Toegelate Nommers toe';

  @override
  String get allowAllowedNumbersDesc => 'Laat oproepe van toelaatlys toe';

  @override
  String get allowBlock => 'Toelaat/Blokkeer';

  @override
  String get allowBlockedNumbers => 'Laat Geblokkeerde Nommers toe';

  @override
  String get allowBlockedNumbersDesc => 'Laat oproepe van swartlys toe';

  @override
  String get allowedBlockedRule => 'Toelaat/Blokkeer Reël';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'Wysig Toelaat/Blokkeer Reël';

  @override
  String get allowedBlockedRuleManagement => 'Toelaat/Blokkeer Reëlbestuur';

  @override
  String get allowNonExceededNumbers => 'Laat Nie-oorskryding Nommers toe';

  @override
  String get allowNonExceededNumbersDescription =>
      'Laat nommers wat nie die tellingdrempel oorskry nie outomaties toe';

  @override
  String get allowRegexAllowRules => 'Laat Regex Toelaat Reëls toe';

  @override
  String get allowRegexAllowRulesDesc =>
      'Aktiveer regex-patroonpassing vir toelaatreëls';

  @override
  String get allowRegexAllowRulesDescription =>
      'Aktiveer regex-gebaseerde toelaatreëls';

  @override
  String get allowRegexBlockRules => 'Laat Regex Blok Reëls toe';

  @override
  String get allowRegexBlockRulesDesc =>
      'Aktiveer regex-patroonpassing vir blokreëls';

  @override
  String get allowRegexBlockRulesDescription =>
      'Aktiveer regex-gebaseerde blokreëls';

  @override
  String get allowRule => 'Toelaat Reël';

  @override
  String get allowRules => 'Toelaat Reëls';

  @override
  String get allowWhitelistedNumbers => 'Laat Witgelyste Nommers Toe';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Laat alle nommers op die witlys toe';

  @override
  String get allPermissionsGranted => 'Alle toestemmings toegestaan';

  @override
  String get allSettingsCompleted => 'Alle instellings voltooi.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Alle opdaterings voltooi ($count reëls)';
  }

  @override
  String get answerThenHangup => 'Beantwoord dan hang op';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. Alle regte voorbehou.';

  @override
  String get applicationSoftware => 'Toepassing Sagteware';

  @override
  String get apply => 'Pas Toe';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Magtiging het misluk: Gaan asseblief kliënt ID en sleutel na';

  @override
  String get authorizationFailedMessage => 'Magtiging het misluk';

  @override
  String get authorizationSuccessMessage => 'Magtiging suksesvol';

  @override
  String get authorizeLoginButton => 'Magtig Login';

  @override
  String get automotiveIndustry => 'Motorbedryf';

  @override
  String get autoSyncLabel => 'Outo Sinkronisering';

  @override
  String get autoUpdate => 'Outo-opdatering';

  @override
  String get autoUpdateDescription =>
      'Stel outo-opdatering-intervalle vir intekeninge in of werk handmatig op';

  @override
  String get autoUpdateSettings => 'Outo-opdateringsinstellings';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Bestuur outomatiese opdaterings vir reëls en inproppe';

  @override
  String get autoUpdateSettingsTitle => 'Outo-opdateringsinstellings';

  @override
  String get autoUpdateSubtitle =>
      'Bestuur outomatiese opdaterings vir reëls en inproppe';

  @override
  String get autoUpdateTitle => 'Outo-opdatering';

  @override
  String get avatarBorderColor => 'Avatar Rand Kleur';

  @override
  String get avatarBorderSize => 'Avatar Rand Grootte';

  @override
  String get avatarIconSizesSetting => 'Avatar & Ikoongroottes';

  @override
  String get avatarPosition => 'Avatar Posisionering';

  @override
  String get avatarSize => 'Avatar Grootte';

  @override
  String axisPosition(Object axis) {
    return '$axis Posisionering';
  }

  @override
  String get backgroundGradientSetting => 'Agtergrond Gradiënt';

  @override
  String get backup => 'Rugsteun';

  @override
  String get backupAndRestore => 'Rugsteun en Herstel';

  @override
  String get backupAndRestoreSubtitle => 'Rugsteun of herstel toepassing data';

  @override
  String get backupAndRestoreTitle => 'Rugsteun & Herstel';

  @override
  String get backupFailed => 'Rugsteun het misluk';

  @override
  String get backupFailedMessage => 'Rugsteun het misluk';

  @override
  String backupFailedWithError(Object error) {
    return 'Rugsteun het misluk: $error';
  }

  @override
  String get backupRestoreSubtitle => 'Rugsteun of herstel toepassing data';

  @override
  String get backupRestoreTitle => 'Rugsteun & Herstel';

  @override
  String get backupSectionTitle => 'Rugsteun';

  @override
  String get backupSettings => 'Rugsteuninstellings';

  @override
  String get backupSettingsDialogTitle => 'Rugsteuninstellings';

  @override
  String get backupSettingsTitle => 'Rugsteuninstellings';

  @override
  String get backupSuccessMessage => 'Suksesvol na die wolk gerugsteun';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Rugsteun suksesvol na: $path';
  }

  @override
  String get backupToCloud => 'Rugsteun na Wolk';

  @override
  String get backupToCloudDescription =>
      'Rugsteun instellings en reëls na wolkrekenaaropslag';

  @override
  String backupToCloudFailed(Object error) {
    return 'Kon nie na wolk rugsteun nie: $error';
  }

  @override
  String get backupToCloudLabel => 'Rugsteun na Wolk';

  @override
  String get backupToCloudSuccess => 'Suksesvol na die wolk gerugsteun';

  @override
  String get backupToCloudTitle => 'Rugsteun na Wolk';

  @override
  String get backupToLocalLabel => 'Rugsteun na Plaaslik';

  @override
  String get bank => 'Bank';

  @override
  String get basicInfo => 'Basiese Inligting';

  @override
  String get basicRuleFilter => 'Basiese Reëlfilter';

  @override
  String get basicRuleFiltering => 'Basiese Reëlfiltrering';

  @override
  String get basicRuleFilteringExplanation =>
      '• Basiese Reëlfiltrering: Filter reëls gebaseer op swartlys, witlys en regex';

  @override
  String get basicRuleFilterSettings => 'Basiese Reëlfilterinstellings';

  @override
  String get basicRuleFilterSubtitle =>
      'Filter oproepe met swartlys/witlys en gereelde uitdrukkings';

  @override
  String get batchDeleteContacts => 'Groepverwydering van Kontakte';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Is jy seker jy wil $count geselekteerde kontakte uitvee?';
  }

  @override
  String get batchDeleteFailed => 'Groepverwydering het misluk';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Is jy seker jy wil $count etikette uitvee?';
  }

  @override
  String get blacklist => 'Swartlys';

  @override
  String get blacklistingAndWhitelisting => 'Swartlys en Witlys';

  @override
  String get blacklistLabel => 'Swartlys';

  @override
  String get blackWhiteList => 'Swart/Witlys';

  @override
  String get block => 'Blokkeer';

  @override
  String get blockCalls => 'Blokkeer Oproepe';

  @override
  String get blocked => 'Geblokkeer';

  @override
  String get blockedCallAction => 'Geblokkeerde Oproep Aksie';

  @override
  String get blockedCalls => 'Geblokkeerde Oproepe';

  @override
  String get blockedCallsTitle => 'Geblokkeerde Oproepe';

  @override
  String get blockedCommunications => 'Geblokkeerde Kommunikasie';

  @override
  String get blockedPhoneLabel => 'Geblokkeerde Oproepe';

  @override
  String get blockedSpamCalls => 'Geblokkeerde Spam Oproepe';

  @override
  String get blockingTrend => 'Blokkeer Tendens';

  @override
  String get blockInternationalCalls =>
      'pas nommers wat nie met + of 00 begin nie';

  @override
  String get blockInternationalCallsTitle => 'Blokkeer Internasionale Oproepe';

  @override
  String get blockLandlineNumbersTitle => 'Blokkeer Landlyn Nommers';

  @override
  String get blockMobileNumbers => 'pas nommers wat nie met 13-19 begin nie';

  @override
  String get blockMobileNumbersTitle => 'Blokkeer Mobiele Nommers';

  @override
  String get blockPremiumRateNumbers =>
      'pas nommers wat nie met 118 of 120-190 begin nie';

  @override
  String get blockPremiumRateNumbersTitle => 'Blokkeer Premium Tarief Nommers';

  @override
  String get blockRule => 'Blokkeer Reël';

  @override
  String get blockRules => 'Blokkeer Reëls';

  @override
  String get blockSpecificAreaCodes =>
      'pas nommers wat met 0 + 2-3 syfers begin';

  @override
  String get blockSpecificAreaCodesTitle => 'Blokkeer spesifieke area kodes:';

  @override
  String get blockTypeAnalysisTitle => 'Blok Tipe Analise';

  @override
  String get both => 'Beide';

  @override
  String get bulkDelete => 'Groepverwydering';

  @override
  String get bulkDeleteContacts => 'Groepverwydering van Kontakte';

  @override
  String get bulkDeleteLabels => 'Groepverwydering van Etikette';

  @override
  String get call => 'Oproep';

  @override
  String get callback => 'Terugbel';

  @override
  String callbackTo(String number) {
    return 'Bel terug na $number';
  }

  @override
  String get callBlocking => 'Oproepblokkering';

  @override
  String get callerIdApp => 'Loods ID App';

  @override
  String get callerIdCustomizationTitle => 'Pas Loods ID aan';

  @override
  String get callerIdDialogTitle => 'Loods ID Inligting';

  @override
  String get callerIdDisplayMode => 'Vertoonmodus van oproeper-ID';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Gemerker deur $count';
  }

  @override
  String get callerIdPreview => 'Voorskou van oproeper-ID';

  @override
  String get callFilter => 'Oproepfilter';

  @override
  String get callFilterDescription =>
      'Wanneer geaktiveer, word inkomende oproepe nagegaan teen die reëllys hieronder. Oproepfilterreëls word nie by verstek tussen toestelle gesinchroniseer nie.';

  @override
  String get callFilterRules => 'Oproepfilterreëls';

  @override
  String get callFilterRulesDescription =>
      'Stel basiese reëls vir oproepfiltering';

  @override
  String get callFilterSettings => 'Oproepfilterinstellings';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Stel oproepfrekwensielimiete en blokkeer-reëls';

  @override
  String get callFrequencyInterceptionTitle => 'Oproepfrekwensie-onderskepping';

  @override
  String get callHistory => 'Oproepgeskiedenis';

  @override
  String get callHistoryInfoDesc =>
      'Hier word jou oproepgeskiedenis vertoon, insluitend inkomende, uitgaande en gemiste oproepe.';

  @override
  String get callHistoryInfoTitle => 'Oproepgeskiedenis';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Kon nie oproepgeskiedenis initialiseer nie: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Kon nie oproepgeskiedenis verfris nie: $error';
  }

  @override
  String get callHistoryTab => 'Oproepgeskiedenis';

  @override
  String get callHistoryTimelineEarlier => 'Vroeër';

  @override
  String get callHistoryTimelineToday => 'Vandag';

  @override
  String get callHistoryTimelineYesterday => 'Gister';

  @override
  String get callScreeningPermission => 'Toestemming vir oproepondersoek';

  @override
  String get callScreeningPermissionDescription =>
      'Gebruik om spam-oproepe te ondersoek en te blokkeer.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Toestemming vir oproepondersoek nie toegestaan nie, kan app-funksionaliteit beïnvloed.';

  @override
  String get callSettingsSubtitle =>
      'Instellings vir oproeper-ID, filtering en blokkering';

  @override
  String get callSettingsTitle => 'Oproepinstellings';

  @override
  String get callStatistics => 'Oproepstatistieke';

  @override
  String get callTypeAnswered => 'Beantwoord';

  @override
  String get callTypeBlocked => 'Geblokkeer';

  @override
  String get callTypeIconColor => 'Ikoonkleur van oproeptipe';

  @override
  String get callTypeMissed => 'Gemiste Oproep';

  @override
  String get callTypeOutgoing => 'Uitgaande';

  @override
  String get callTypePosition => 'Posisie van oproeptipe';

  @override
  String get callTypeUnknown => 'Onbekend';

  @override
  String get cancelButton => 'Kanselleer';

  @override
  String get carRental => 'Huur van motor';

  @override
  String get carrier => 'Litraer';

  @override
  String get carrierColor => 'Litraer-kleur';

  @override
  String get carrierFontSize => 'Litraer-lettergrootte';

  @override
  String get carrierPosition => 'Litraer-posisie';

  @override
  String get changeLabel => 'Verander etiket';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Kon nie inprop-status verander nie: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Kon nie intekeningstatus verander nie: $error';
  }

  @override
  String get changeTag => 'Verander etiket';

  @override
  String get charity => 'Liefdadigheid';

  @override
  String chartMonthFormat(int month) {
    return 'Maand $month';
  }

  @override
  String get chartOneDayAgo => '1 dag gelede';

  @override
  String get chartOneMonthAgo => '1 Maand gelede';

  @override
  String get chartOneWeekAgo => '1 week gelede';

  @override
  String get chartTenDaysAgo => '10 dae gelede';

  @override
  String get chartThreeDaysAgo => '3 dae gelede';

  @override
  String get chartToday => 'Vandag';

  @override
  String get checkFileFormat =>
      'Kontroleer asseblief lêerformaat of toestemmings';

  @override
  String checkPermissionFailed(Object error) {
    return 'Kon nie toestemmings nagaan nie: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Kies die verstek onderskeppingsaksie';

  @override
  String get clearAllData => 'Vee alle data uit';

  @override
  String get clearAllDataConfirmation =>
      'Is jy seker jy wil alle programdata uitvee? Hierdie aksie kan nie ongedaan gemaak word nie.';

  @override
  String get clearAllDataDescription => 'Vee alle programdata uit';

  @override
  String get clearAllDataLabel => 'Vee alle data uit';

  @override
  String get clearFilter => 'Vee filter uit';

  @override
  String get clearLabelFilter => 'Vee etiketfilter uit';

  @override
  String get clearLabelFilterButton => 'Vee etiketfilter uit';

  @override
  String get closeButton => 'Sluit';

  @override
  String get cloudSync => 'Wolksinkronisering';

  @override
  String get cloudSyncAndBackupTitle => 'Wolksinkronisering en Rugsteun';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Konfigureer WebDAV, OneDrive en Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Wolksinkroniseringinstellings';

  @override
  String get cloudSyncTitle => 'Wolksinkronisering';

  @override
  String get collapseLabelSelector => 'Vou etiketkieser toe';

  @override
  String get collection => 'Skuldeurpligting';

  @override
  String get colorPickerTitle => 'Kies Kleur';

  @override
  String get configManagement => 'Konfigurasiebestuur';

  @override
  String get configUpdated => 'Konfigurasie opgedateer';

  @override
  String get configurationAdvice =>
      'Deur behoorlike konfigurasie kan jy verskillende filterstrategieë vir werk- en persoonlike SIM-kaarte stel.';

  @override
  String get configureBackupOptions => 'Konfigureer Rugsteunopsies';

  @override
  String get configureBackupOptionsSubtitle => 'Konfigureer rugsteunopsies';

  @override
  String get configureCloudSyncService =>
      'Konfigureer Wolksinkroniseringsdiens';

  @override
  String get configureCloudSyncServiceHint =>
      'Konfigureer asseblief \'n wolksinkroniseringsdiens om sinkronisering tussen verskeie toestelle moontlik te maak.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Konfigureer asseblief \'n wolksinkroniseringsdiens om sinkronisering tussen verskeie toestelle moontlik te maak.';

  @override
  String get configureSimCardFilterRules => 'Konfigureer SIM-kaart filterreëls';

  @override
  String get configureSyncServiceHint =>
      'Konfigureer asseblief eers die sinkroniseringsdiens in wolksinkroniseringinstellings';

  @override
  String get confirm => 'Bevestig';

  @override
  String get confirmBatchDeleteContacts =>
      'Is jy seker jy wil die geselekteerde uitvee';

  @override
  String get confirmButton => 'Bevestig';

  @override
  String get confirmDelete => 'Bevestig Uitvee';

  @override
  String get confirmDeleteContact => 'Is jy seker jy wil uitvee';

  @override
  String get confirmDeleteContactName => 'Bevestig uitvee?';

  @override
  String get confirmDeleteFilter => 'Is jy seker jy wil hierdie filter uitvee?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Is jy seker jy wil etiket \"$name\" uitvee';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Is jy seker jy wil inprop \"$name\" uitvee?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Is jy seker jy wil $count inproppe uitvee?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Is jy seker jy wil hierdie reël uitvee? Hierdie aksie kan nie ongedaan gemaak word nie.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Is jy seker om geselekteerde kontakte uit te vee?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Is jy seker jy wil hierdie SMS filterreël uitvee?';

  @override
  String get confirmDeleteSmsRule =>
      'Is jy seker jy wil hierdie SMS-reël uitvee?';

  @override
  String get confirmDeleteSubscription =>
      'Is jy seker jy wil hierdie intekening uitvee?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Is jy seker jy wil $name uitvee?';
  }

  @override
  String get confirmPassword => 'Bevestig wagwoord';

  @override
  String get confirmPasswordLabel => 'Bevestig wagwoord';

  @override
  String get connectedStatus => 'Gekoppel';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Konneksie misluk: Kontroleer asseblief die bedieneradres, gebruikersnaam en wagwoord';

  @override
  String get connectionFailedMessage => 'Konneksie misluk';

  @override
  String get connectionStatusLabel => 'Verbindingsstatus';

  @override
  String get connectionSuccessMessage => 'Verbinding suksesvol';

  @override
  String get contactAddSuccess => 'Kontak bygevoeg suksesvol';

  @override
  String get contactDeleted => 'Kontak uitgevee';

  @override
  String get contactEditDialog => 'Kontak Redigeer Dialoogvenster';

  @override
  String get contactNameHint => 'Voer kontaknaam in (opsioneel)';

  @override
  String get contactNameLabel => 'Naam';

  @override
  String get contactNameOptional => 'Kontaknaam (opsioneel)';

  @override
  String get contactNotFound => 'Kontak nie gevind nie';

  @override
  String get contacts => 'Kontakte';

  @override
  String contactsDeleted(Object count) {
    return 'Uitgevee $count kontakte';
  }

  @override
  String get contactSettingsSubtitle => 'Kontakbestuur en etiketinstellings';

  @override
  String get contactSettingsTitle => 'Kontakinstellings';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Het misluk om kontakte te laai: $error';
  }

  @override
  String get contactsManagement => 'Kontakbestuur';

  @override
  String get contactsManagementPageTitle => 'Kontakbestuur Bladsy';

  @override
  String get contactsPageTitle => 'Kontakbestuur';

  @override
  String get contactsPermission => 'Kontakte Toestemming';

  @override
  String get contactsPermissionDescription =>
      'Word gebruik om oproepe van kontakte te identifiseer.';

  @override
  String get contactsTab => 'Kontakte';

  @override
  String get contactSubscriptionDescription =>
      'Teken in op kontaklyste via URL, werk outomaties kontakbesonderhede en etikette op. Ondersteun JSON-formaatdata.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Het misluk om kontakinskrywings te laai: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Kontak Inskrywings';

  @override
  String get contactUpdateSuccess => 'Kontak opgedateer suksesvol';

  @override
  String get contactUs => 'Kontak Ons';

  @override
  String get content => 'Inhoud';

  @override
  String get contentRegex => 'Inhoud Regex';

  @override
  String get countColor => 'Aantal Kleur';

  @override
  String get countFontSize => 'Aantal Lettergrootte';

  @override
  String get countPosition => 'Aantal Posisie';

  @override
  String get country => 'Land';

  @override
  String get countryNameColor => 'Landnaam Kleur';

  @override
  String get countryNameFontSize => 'Landnaam Lettergrootte';

  @override
  String get countryRegionNamePosition => 'Land/Streek Naam Posisie';

  @override
  String get countrySelectionDialog => 'Land Keuse Dialoogvenster';

  @override
  String get countrySelectionDialogDescription =>
      'Word gebruik om \'n land te kies om oproeper-ID-inligting op te soek';

  @override
  String get countThresholdDescription =>
      'Stel die minimum aantal drempel wat nodig is om filteraksies te aktiveer';

  @override
  String get countThresholdLabel => 'Aantal Drempel';

  @override
  String get countThresholdSettings => 'Aantal Drempel Instellinge';

  @override
  String countThresholdValue(Object count) {
    return 'Aantal Drempel: $count';
  }

  @override
  String get createdRules => 'Geskepte Reëls';

  @override
  String get csvFormat => 'CSV-formaat';

  @override
  String get currentDeviceChip => 'Huidig';

  @override
  String get currentDeviceLabel => 'Huidige Toestel Etiket';

  @override
  String get currentDeviceTitle => 'Huidige Toestel';

  @override
  String get currentLabels => 'Huidige Etikette:';

  @override
  String get currentLanguage => 'Huidige Taal';

  @override
  String get currentPasswordLabel => 'Huidige Wagwoord';

  @override
  String get customerService => 'Kliëntediens';

  @override
  String get customRange => 'Pasgemaakte Reeks';

  @override
  String get dailyStatistics => 'Daaglikse Statistiek';

  @override
  String get dailyStatisticsDesc =>
      'Ontvang daaglikse statistieke oor geblokkeerde oproepe en boodskappe';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get dataAnalysis => 'Data-analise';

  @override
  String get dataAnalysisDashboardPage => 'Data-analise Dashboard Bladsy';

  @override
  String get dataExport => 'Data Uitvoer';

  @override
  String dataLoadFailure(Object error) {
    return 'Data laai misluk: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Het misluk om data te laai: $error';
  }

  @override
  String get dataMigration => 'Data Migrasie';

  @override
  String get dataMigrationDescription =>
      'Hierdie funksie laat jou toe om al jou data tussen toestelle oor te dra. Tans kan jy die rugsteun- en herstelkenmerke gebruik om jou data handmatig te migreer.';

  @override
  String get dataMigrationDialogContent =>
      'Hierdie funksie laat jou toe om al jou data tussen toestelle oor te dra. Tans kan jy die rugsteun- en herstelkenmerke gebruik om jou data handmatig te migreer.';

  @override
  String get dataMigrationDialogTitle => 'Data Migrasie';

  @override
  String get dataMigrationSectionTitle => 'Data Migrasie';

  @override
  String get dataSourceReminder => 'Data Bron Herinnering';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dae',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Dae VIP';
  }

  @override
  String get debtCollection => 'Skuldinvordering';

  @override
  String get defaultPeriod => 'Week';

  @override
  String get delete => 'Vee uit';

  @override
  String get deleteButton => 'Vee uit';

  @override
  String get deleteContact => 'Vee Kontak uit';

  @override
  String deleteContactConfirm(Object name) {
    return 'Is jy seker jy wil $name uitvee?';
  }

  @override
  String get deleteContactConfirmation => 'Is jy seker jy wil kontak uitvee';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Is jy seker jy wil $deviceName uitvee?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Vee Toestel uit';

  @override
  String deleteFailed(Object error) {
    return 'Vee uit misluk: $error';
  }

  @override
  String get deleteFilter => 'Vee Filter uit';

  @override
  String get deleteLabel => 'Vee Etiket uit';

  @override
  String deleteLabelFailed(Object error) {
    return 'Het misluk om etiket uit te vee: $error';
  }

  @override
  String get deletePlugin => 'Vee Plugin uit';

  @override
  String deletePluginFailed(Object error) {
    return 'Het misluk om plugin uit te vee: $error';
  }

  @override
  String get deletePlugins => 'Vee Plugins uit';

  @override
  String deletePluginsFailed(Object error) {
    return 'Het misluk om plugins uit te vee: $error';
  }

  @override
  String get deleteRule => 'Vee Reël uit';

  @override
  String deleteRuleFailed(Object error) {
    return 'Vee uit misluk: $error';
  }

  @override
  String get deleteSelected => 'Vee Geselekteerdes uit';

  @override
  String get deleteSmsRule => 'Vee SMS Reël uit';

  @override
  String get deleteSubscription => 'Vee Inskrywing uit';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Is jy seker jy wil inskrywing \"$name\" uitvee?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Het misluk om inskrywing uit te vee: $error';
  }

  @override
  String get deleteSuccess => 'Vee uit suksesvol';

  @override
  String get delivery => 'Aflewering';

  @override
  String get deviceDeletedSuccessfully => 'Toestel suksesvol uitgevee';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Toestel suksesvol uitgevee';

  @override
  String get deviceIdLabel => 'Toestel ID';

  @override
  String get deviceIDLabel => 'Toestel ID';

  @override
  String get deviceManagementSubtitle => 'Bestuur multi-toestel sinchronisasie';

  @override
  String get deviceManagementTitle => 'Toestelbestuur';

  @override
  String get deviceModelLabel => 'Toestelmodel';

  @override
  String get deviceName => 'Toestel Naam';

  @override
  String get deviceNameCannotBeEmpty => 'Apparaatnaam kan nie leeg wees nie';

  @override
  String get deviceNameHint => 'Voer asseblief die apparaatnaam in';

  @override
  String get deviceNameLabel => 'Apparaatnaam';

  @override
  String get deviceRenamedSuccessfully => 'Apparaat suksesvol hernoem';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Apparaat suksesvol hernoem';

  @override
  String get devicesSyncedSuccessfully => 'Toestelle suksesvol gesinchroniseer';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Toestelle suksesvol gesinchroniseer';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Toestelle suksesvol gesinchroniseer';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Apparaat suksesvol gederegistreer';

  @override
  String get dialogTitle => 'Regex Patroon Verduideliking';

  @override
  String get differentFromLocalCounter =>
      'Hierdie funksie verskil van die plaaslike toonbankfilter, aangesien dit fokus op herhaalde oprooppatrone in \'n kort tydperk eerder as langtermyn merkgetalle.';

  @override
  String get disabled => 'Gestrem';

  @override
  String get disabledStatus => 'Gestrem';

  @override
  String get disableGlobalPlugins => 'Deaktiveer globale plugins';

  @override
  String get disableSubscriptionSuccessfully =>
      'Intekening suksesvol gedeaktiveer';

  @override
  String get disconnectButton => 'Ontkoppel';

  @override
  String get disconnectedMessage => 'Ontkoppel';

  @override
  String get disconnectedStatus => 'Ontkoppel';

  @override
  String get disconnectFailedMessage => 'Ontkoppeling het mislukluk';

  @override
  String get done => 'Klaar';

  @override
  String get dualSimAdvice =>
      'Hierdie funksie is besonder nuttig vir dubbel-SIM-fone om verskillende filterstrategieë vir werk- en persoonlike SIM-kaarte in te stel.';

  @override
  String get earlier => 'Vroeër';

  @override
  String get ecommerce => 'E-handel';

  @override
  String get edit => 'Wysig';

  @override
  String get editContact => 'Wysig Kontak';

  @override
  String get editFilter => 'Wysig Filter';

  @override
  String get editLabel => 'Wysig Etiket';

  @override
  String get editPhoneRule => 'Wysig Telefoonreël';

  @override
  String get editPhoneRules => 'Gebruik om telefoonreëls te wysig';

  @override
  String get editPhoneRuleTitle => 'Wysig Telefoonreël';

  @override
  String get editRule => 'Wysig Reël';

  @override
  String get editSmsRule => 'Wysig SMS-reël';

  @override
  String get education => 'Onderwys';

  @override
  String get elementPositionsSetting => 'Elementposisies';

  @override
  String get email => 'E-pos';

  @override
  String get emailOptional => 'E-pos (Opsioneel)';

  @override
  String get enableCallFilter => 'Aktiveer Oproepfilter';

  @override
  String get enableCallFilterDescription =>
      'Wanneer geaktiveer, word inkomende oproepe teen die onderstaande reëllys nagegaan. Oproepfilterreëls word standaard nie tussen toestelle gesinchroniseer nie.';

  @override
  String get enabled => 'Geaktiveer';

  @override
  String get enabledStatus => 'Geaktiveer';

  @override
  String get enableEncryption => 'Aktiveer Enkripsie';

  @override
  String get enableEncryptionDescription => 'Enkripteer rugsteunlêers';

  @override
  String get enableEncryptionLabel => 'Aktiveer Enkripsie';

  @override
  String get enableEncryptionSubtitle => 'Rugsteunlêers sal enkripteer word';

  @override
  String get enableEncryptionTitle => 'Aktiveer Enkripsie';

  @override
  String get enableGlobalPlugins => 'Aktiveer globale plugins';

  @override
  String get enableLocalCountFilter => 'Aktiveer Plaaslike Toonbankfilter';

  @override
  String get enableLocalCountFilterDescription =>
      'Filter outomaties spamoproepe gebaseer op oproepmerkgetal';

  @override
  String get enableLocalNotification => 'Gebruik Plaaslike Kennisgewing';

  @override
  String get enableLocalNotificationDescription =>
      'Wanneer geaktiveer, sal kennisgewings vir gefiltreerde boodskappe op die toestel vertoon word';

  @override
  String get enableLocationSummary => 'Ligging';

  @override
  String get enableMuteRules => 'Aktiveer Dempreëls';

  @override
  String get enableMuteRulesDesc => 'Pas dempinteksie reëls konfigurasie toe';

  @override
  String get enableNoneActionRules => 'Aktiveer Geen Aksie Reëls';

  @override
  String get enableNoneActionRulesDesc =>
      'Laat reëlkonfigurasies toe met geen inperkingsaksies nie';

  @override
  String get enableNotifications => 'Aktiveer Kennisgewings';

  @override
  String get enableRemoteNumberFilter => 'Aktiveer Afgeleë Nommerfilter';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Gebruik afgeleë databasis om nommers te filter';

  @override
  String get enableRule => 'Aktiveer Reël';

  @override
  String get enableSmsFilter => 'Aktiveer SMS Filtering';

  @override
  String get enableSmsFilterDescription =>
      'Wanneer geaktiveer, sal boodskappe outomaties gefiltreer word volgens die reëls';

  @override
  String get enableStatisticsNotifications =>
      'Aktiveer Statistiek Kennisgewings';

  @override
  String get enableSubscriptionSuccessfully =>
      'Intekening suksesvol geaktiveer';

  @override
  String get enableTimeInterception => 'Aktiveer Tydinperking';

  @override
  String get enableTimeInterceptionDescription =>
      'Onderskep herhaalde oproepe binne \'n kort tydperk';

  @override
  String get enableTimeInterceptor => 'Aktiveer Tydinperker';

  @override
  String get endCallImmediately => 'Beëindig oproep onmiddellik';

  @override
  String get endColor => 'Eindkleur';

  @override
  String get endDate => 'Einddatum';

  @override
  String get enhancedFilterInstructionsTitle =>
      'Verbeterde Filtersisteem Instruksies';

  @override
  String get enhancedFilterSettings => 'Verbeterde Filterinstellings';

  @override
  String get enhancedFilterSettingsTitle => 'Verbeterde Filterinstellings';

  @override
  String get enhancedFilterSystemDescription =>
      'Die verbeterde filtersisteem ondersteun beide globale reëls en per-SIM-kaart filterkonfigurasies.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Voer asseblief beide telefoonnommer en regex-patroon in';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Voer asseblief beide telefoonnommer en regex-patroon in.';

  @override
  String get enterContactName => 'Voer asseblief kontaknaam in';

  @override
  String get enterCurrentPasswordHint => 'Voer asseblief huidige wagwoord in';

  @override
  String get enterDeviceName => 'Voer Apparaatnaam in';

  @override
  String get enterDeviceNameHint => 'Voer asseblief die apparaatnaam in';

  @override
  String get enterEmail => 'Voer asseblief e-pos in';

  @override
  String get enterEmailOptional => 'Voer asseblief e-pos in (opsioneel)';

  @override
  String get enterEncryptionPasswordHint => 'Voer enkripsiewagwoord in';

  @override
  String get enterEncryptionPasswordTitle => 'Voer Enkripsiewagwoord in';

  @override
  String get enterFilterName => 'Voer asseblief filternaam in';

  @override
  String get enterFilterPattern => 'Voer asseblief filterpatroon in';

  @override
  String get enterIconCode => 'Voer ikoonkode in';

  @override
  String get enterName => 'Voer kontaknaam in';

  @override
  String get enterNewDeviceNameHint =>
      'Voer \'n nuwe naam vir hierdie toestel in';

  @override
  String get enterNewPasswordHint => 'Voer asseblief nuwe wagwoord in';

  @override
  String get enterPasswordAgain => 'Voer Wagwoord Weer In';

  @override
  String get enterPasswordHint => 'Voer asseblief wagwoord in';

  @override
  String get enterPhoneNumber => 'Voer telefoonnommer in';

  @override
  String get enterPhoneNumberHint => 'Voer telefoonnommer in om te toets';

  @override
  String get enterPhoneNumberMultiple =>
      'Voer asseblief telefoonnommer in, veelvuldige nommers geskei deur kommas';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Voer telefoonnommer in om te begin soek';

  @override
  String get enterPhoneNumberToVerify =>
      'Voer telefoonnommer in om te verifieer';

  @override
  String get enterPluginName => 'Voer Plugin Naam in';

  @override
  String get enterPluginUrl => 'Voer plugin URL adres in';

  @override
  String get enterRegexHint => 'Voer regex-patroon in';

  @override
  String get enterRuleNameAndPattern => 'Voer asseblief reëlnaam en patroon in';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Voer asseblief beide reëlnaam en regex-patroon in.';

  @override
  String get enterRuleNameHint => 'Voer reëlnaam in';

  @override
  String get enterSearchContent => 'Voer asseblief soekinhoud in';

  @override
  String get enterSubscriptionName => 'Voer intekeningnaam in';

  @override
  String get enterSubscriptionUrl => 'Voer intekening URL in';

  @override
  String get enterSyncFolderNameHint =>
      'Voer asseblief sinkroniseer-vouernaam in (verstek: NotificationManager)';

  @override
  String get entertainment => 'Vermaak';

  @override
  String get enterValidNameAndUrl => 'Voer asseblief geldige naam en URL in';

  @override
  String get enterValidUrl => 'Voer asseblief \'n geldige URL in';

  @override
  String get enterVersion => 'Voer weergawe in';

  @override
  String get enterWebDAVPasswordHint => 'Voer asseblief WebDAV-wagwoord in';

  @override
  String get enterWebDAVServerAddressHint =>
      'Voer asseblief WebDAV-bedieneradres in';

  @override
  String get enterWebDAVUsernameHint =>
      'Voer asseblief WebDAV-gebruikersnaam in';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Fout met toestelverwydering: $error';
  }

  @override
  String get errorLoadingPlugin => 'Fout met inprop-laai';

  @override
  String errorOccurredMessage(Object error) {
    return '\'n Fout het voorgekom: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Fout met toestelhernoeming: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Fout met toestelsinkronisering: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Fout met toestelsinkronisering: $error';
  }

  @override
  String get errorText => 'Fout';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Fout met toestelontreking: $error';
  }

  @override
  String get exampleBlock400Prefix => 'bv. Blokkeer 400 voorvoegselnommers';

  @override
  String get exampleBlockMarketingSms => 'bv. Blokkeer bemarkings-SMS';

  @override
  String get exampleContentRegex => 'bv., .*aanbod.*';

  @override
  String get exampleContentRegexHint => 'Voorbeeld Inhoud Regex';

  @override
  String get exampleCouponPromotionDiscount =>
      'bv. .*(koepon|promosie|afslag).*';

  @override
  String get exampleFamilyFriends => 'bv. Familie, Vriende, ens.';

  @override
  String get examplePhoneNumber => 'bv. 10086, 12345, ens.';

  @override
  String get exampleRegex400Prefix => 'Voorbeeld regex vir 400 voorvoegsel';

  @override
  String get exampleRegexFormat => 'Voorbeeld: ^10086\$ formaat';

  @override
  String get exampleSenderRegexHint => 'Voorbeeld';

  @override
  String get exchange => 'Ruil';

  @override
  String get exchangeNow => 'Ruil Nou';

  @override
  String get exchangeVip => 'Ruil VIP';

  @override
  String get expandLabelSelector => 'Brei etiketkieser uit';

  @override
  String expiryTime(Object time) {
    return 'Vervaltyd: $time';
  }

  @override
  String get export => 'Uitvoer';

  @override
  String get exportAllApplicationSettings =>
      'Voer alle toepassingsinstellings uit';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Voer alle toepassingsinstellings uit';

  @override
  String get exportAllRuleConfigurations => 'Voer alle reëlkonfigurasies uit';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Voer alle reëlkonfigurasies uit';

  @override
  String get exportComplete => 'Uitvoer Voltooi';

  @override
  String get exportConfig => 'Voer Konfigurasie uit';

  @override
  String get exportContacts => 'Voer Kontakte uit';

  @override
  String get exportData => 'Voer Data uit';

  @override
  String get exportError => 'Uitvoer Fout';

  @override
  String get exportFailed => 'Uitvoer het misluk het';

  @override
  String get exportFailure => 'Konfigurasie kon nie uitgevoer word nie';

  @override
  String get exportFeatureComingSoon => 'Uitvoerfunksie kom binnekort';

  @override
  String get exporting => 'Uitvoer...';

  @override
  String get exportLabels => 'Voer Etikette uit';

  @override
  String exportLabelsFailed(Object error) {
    return 'Etikette kon nie uitgevoer word nie: $error';
  }

  @override
  String get exportPluginList => 'Voer Inproplys uit';

  @override
  String exportPluginListFailed(Object error) {
    return 'Inproplys kon nie uitgevoer word nie: $error';
  }

  @override
  String get exportRules => 'Voer Reëls uit';

  @override
  String get exportRulesDialogTitle => 'Voer Reëls uit';

  @override
  String get exportRulesTitle => 'Voer Reëls uit';

  @override
  String get exportSmsRules => 'Voer SMS-reëls uit';

  @override
  String get exportStatisticsData => 'Voer Statistiekdata uit';

  @override
  String get exportSuccess => 'Uitvoer suksesvol';

  @override
  String get exportSuccesslly => 'Konfigurasie suksesvol uitgevoer';

  @override
  String get failedToAddContact => 'Kontak kon nie bygevoeg word nie';

  @override
  String failedToAddRule(Object error) {
    return 'Reël kon nie bygevoeg word nie: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMS-reël kon nie bygevoeg word nie: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS-intekening kon nie bygevoeg word nie: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Instellings kon nie gerugsteun word nie: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Rugsteunlêer kon nie ontsyfer word nie';

  @override
  String get failedToDeleteDevice => 'Toestel kon nie uitgevee word nie';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS-reël kon nie uitgevee word nie: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Reëls kon nie uitgevoer word nie: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'SMS-reëls kon nie uitgevoer word nie: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Oproeper-ID-inligting kon nie verkry word nie: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Reëls kon nie ingevoer word nie: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'SMS-reëls kon nie ingevoer word nie: $error';
  }

  @override
  String get failedToLoadContacts => 'Kontakte kon nie gelaai word nie';

  @override
  String get failedToLoadPlugin => 'Inprop kon nie gelaai word nie';

  @override
  String get failedToRenameDevice => 'Toestel kon nie hernoem word nie';

  @override
  String get failedToRestoreSettings => 'Instellings kon nie herstel word nie';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Instellings kon nie herstel word nie: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Wagwoord kon nie gestel word nie: $error';
  }

  @override
  String get failedToSyncDevices => 'Toestelle kon nie gesinkroniseer word nie';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Reëlstatus kon nie omgeskakel word nie: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Intekeningstatus kon nie omgeskakel word nie';

  @override
  String get failedToUpdateContact => 'Kontak kon nie opgedateer word nie';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'SMS-reël kon nie opgedateer word nie: $error';
  }

  @override
  String get failure => 'Mislukking';

  @override
  String get favoriteContacts => 'Gunsteling Kontakte';

  @override
  String get featureAddRules => '• Voeg foonnommer-spesifieke reëls by';

  @override
  String get featureCenter => 'Funksiesentrum';

  @override
  String get featureEnableDisable =>
      '• Aktiveer/deaktiveer verskillende filters per SIM';

  @override
  String get featureListTitle => 'Kenmerke:';

  @override
  String get featureManageRules => '• Bestuur reëllyste per SIM';

  @override
  String get features => 'Kenmerke';

  @override
  String get fetchingCallerIdInfo => 'Oproeper-ID-inligting word verkry...';

  @override
  String fileSavedTo(Object path) {
    return 'Lêer gestoor by: $path';
  }

  @override
  String get filter => 'Filter';

  @override
  String get filterByLabel => 'Filter volgens etiket';

  @override
  String get filterClear => 'Vee Filter uit';

  @override
  String get filterControlPanelTitle => 'Filter Beheerpaneel';

  @override
  String get filterControlSubtitle => 'Bestuur aan/af-status van alle filters';

  @override
  String get filterControlTitle => 'Beheer van filters';

  @override
  String get filterDeleteFailed => 'Filter kon nie uitgevee word nie';

  @override
  String get filterDeleteSuccess => 'Filter suksesvol uitgevee';

  @override
  String get filterDetails => 'Filterbesonderhede';

  @override
  String get filtered => 'Gefiltreer';

  @override
  String get filteredSms => 'Gefiltreerde SMS';

  @override
  String get filteredSmsLabel => 'Gefiltreerde SMS';

  @override
  String get filterExplanation => 'Filterverduideliking';

  @override
  String get filterManagement => 'Bestuur van filters';

  @override
  String get filterName => 'Filter naam';

  @override
  String get filterPattern => 'Filter patroon';

  @override
  String get filterPriorityNote =>
      'Let op: Daar is prioriteitsverhoudinge tussen filters, verwys asseblief na die hulpdokumentasie vir besonderhede';

  @override
  String get filterSaveFailed => 'Filter kon nie gestoor word nie';

  @override
  String get filterSaveSuccess => 'Filter suksesvol gestoor';

  @override
  String get filterSettings => 'Filter instellings';

  @override
  String get filterSettingsTitle => 'Filter instellings';

  @override
  String get filterSMS => 'Filter SMS';

  @override
  String get filterToggleInstructions =>
      'Aktiveer of deaktiveer filters vir hierdie SIM-gleuf:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filter: $filterName';
  }

  @override
  String get filterType => 'Filter tipe';

  @override
  String get financial => 'Finansieel';

  @override
  String get flexibleCombinationFeature =>
      '• Buigsame Kombinasies: Aktiveer/deaktiveer filters per SIM-gleuf';

  @override
  String get fontSizesSetting => 'Lettergroottes';

  @override
  String foundRules(Object count) {
    return '$count reëls gevind';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count reëls gevind. Wil jy dit invoer?';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count reëls gevind. Wil jy dit invoer?';
  }

  @override
  String get fraudAlert => 'BEDRIEGSWAARSKUWING - Hang die oproep op';

  @override
  String get fraudScamLikely => 'Bedrogpoging Waarskynlik';

  @override
  String get free => 'Gratis';

  @override
  String get functionSettingsTitle => 'Funksiestelle';

  @override
  String generalUpdateFailure(Object error) {
    return 'Opdatering misluk: $error';
  }

  @override
  String get getFree => 'Kry Gratis';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Stel globale filters vir alle SIM-kaarte op:';

  @override
  String get globalFilterFeature =>
      '• Globale Filters: Basiese reëls vir alle inkomende oproepe';

  @override
  String get globalFilterSettings => 'Globale filterinstellinge';

  @override
  String get globalFilterToggleInstructions =>
      'Stel globale filterinstellings op wat op alle SIM-gleuwe van toepassing is:';

  @override
  String get globalSearchSubtitle =>
      'Soek kontakte, etikette, swartlyste, witlyste, ens.';

  @override
  String get globalSearchTitle => 'Globale Soektog';

  @override
  String get globalSettings => 'Globale instellings';

  @override
  String get googleAdDisplayPosition => 'Google Ad Vertoonposisie';

  @override
  String get googleAdMobIntegrationText =>
      'Google AdMob-advertensies kan hier geïntegreer word';

  @override
  String get googleDriveAuthDescription =>
      'Autoriseer met behulp van die stelsel-gekonfigureerde Google Drive-kliënt ID en sleutel';

  @override
  String get googleDriveAuthorizationHint =>
      'Autoriseer met behulp van die stelsel-gekonfigureerde Google Drive-kliënt ID en sleutel';

  @override
  String get googleDriveConfigTitle => 'Google Drive-konfigurasie';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive-konfigurasie';

  @override
  String get government => 'Regering';

  @override
  String get granted => 'Toegestaan';

  @override
  String get grantNecessaryPermissions => 'Verleen Nodige Toestemmings';

  @override
  String get grantPermissions => 'Verleen Toestemmings';

  @override
  String get headhunter => 'Hoofjagter';

  @override
  String get height => 'Hoogte';

  @override
  String get homePageTitle => 'Tuisskerm';

  @override
  String get homeTab => 'Tuis';

  @override
  String get howItWorksPoint1 =>
      '• Die stelsel sal outomaties oproepe vanaf dieselfde nommer binne die vasgestelde tydvenster toelaat';

  @override
  String get howItWorksPoint2 =>
      '• Korter tydvensters lei tot strenger onderskepping; langer tydvensters lei tot losser onderskepping';

  @override
  String get howItWorksPoint3 =>
      '• Die stelsel kontroleer oproepgeskiedenis om te bepaal of dit \'n herhaalde oproep is';

  @override
  String get howItWorksTitle => 'Hoe Dit Werk:';

  @override
  String get iconCodeOptional => 'Ikoonkode (Opsioneel)';

  @override
  String get iconSize => 'Ikoongrootte';

  @override
  String get import => 'Invoer';

  @override
  String get important => 'Belangrik';

  @override
  String get importButton => 'Invoer';

  @override
  String get importConfig => 'Invoer Konfigurasie';

  @override
  String get importContacts => 'Invoer Kontakte';

  @override
  String get importExportContacts => 'Invoer/Uitvoer Kontakte';

  @override
  String get importExportContactsTooltip => 'Invoer/Uitvoer Kontakte';

  @override
  String get importExportRules => 'Invoer/Uitvoer Reëls';

  @override
  String importFailed(Object error) {
    return 'Invoer misluk: $error';
  }

  @override
  String get importFailure => 'Kon nie konfigurasie invoer nie';

  @override
  String get importFeatureComingSoon => 'Invoerfunksie kom binnekort';

  @override
  String get importLabels => 'Invoer Etikette';

  @override
  String importLabelsFailed(Object error) {
    return 'Kon nie etikette invoer nie: $error';
  }

  @override
  String get importPluginList => 'Invoer Plugin Lys';

  @override
  String importPluginListFailed(Object error) {
    return 'Kon nie plugin lys invoer nie: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Suksesvol $count plugins ingevoer';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Voer Reëlkonfigurasies uit \'n Lêer in';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Voer reëlkonfigurasies uit lêer in';

  @override
  String get importRules => 'Voer Reëls In';

  @override
  String get importRulesButton => 'Voer Reëls In';

  @override
  String get importRulesDialogTitle => 'Voer Reëls In';

  @override
  String importRulesError(Object error) {
    return 'Kon nie reëls invoer nie: $error';
  }

  @override
  String get importRulesInstructions => 'Voer reëls in vanaf \'n CSV-lêer';

  @override
  String get importRulesSuccess => 'Reëls suksesvol ingevoer';

  @override
  String get importRulesTitle => 'Voer Reëls In';

  @override
  String get importSuccess => 'Invoer suksesvol';

  @override
  String get incomingCallInterceptAction =>
      'Inkomende Oproep Onderskeppingsaksie';

  @override
  String get incomingCallNotification => 'Inkomende Oproep Kennisgewing';

  @override
  String get incorrectPassword => 'Verkeerde wagwoord';

  @override
  String get initializing => 'Initialiseer';

  @override
  String get installed => 'Geïnstalleer';

  @override
  String get insufficientMarks => 'Onvoldoende punte';

  @override
  String get insurance => 'Versekering';

  @override
  String get interceptAction => 'Onderskeppingsaksie';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Stel hoe geblokkeerde oproepe hanteer word';

  @override
  String get interceptionActionSettingsTitle =>
      'Onderskeppingsaksie-instellinge';

  @override
  String get interceptionTimeInterval => 'Onderskeppingstydinterval';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service opdateringsinterval gestel tot $days dae';
  }

  @override
  String get invalidContentRegex => 'Ongeldige inhoud regex';

  @override
  String get invalidLabel => 'Ongeldige etiket';

  @override
  String get invalidRegexPattern => 'Ongeldige regex patroon';

  @override
  String get invalidSenderRegex => 'Ongeldige sender regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Sluit aan by die Telegram Kanaal en Groep vir Meer Inligting';

  @override
  String get jsLogsTitle => 'JS Logs';

  @override
  String get jsonFormat => 'JSON Formaat';

  @override
  String get keepAllVersions => 'Hou Alle Weergawses';

  @override
  String get keepAllVersionsDescription =>
      'Hou alle historiese weergawses van elke rugsteun';

  @override
  String get keepAllVersionsLabel => 'Hou Alle Weergawses';

  @override
  String get keepAllVersionsSubtitle =>
      'Hou historiese weergawses van elke rugsteun';

  @override
  String get keepAllVersionsTitle => 'Hou Alle Weergawses';

  @override
  String get label => 'Etiket';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Etiket \"$name\" suksesvol bygevoeg';
  }

  @override
  String get labelCategories => 'Etiket Kategorieë';

  @override
  String get labelDeleted => 'Etiket uitgevee';

  @override
  String get labelDescription =>
      'Etikette help jou om kontakte beter te bestuur, pasgemaakte etikette by telefoonnommers te voeg vir maklike identifikasie van oproepe en boodskappe.';

  @override
  String get labelFilter => 'Etiket Filter';

  @override
  String get labelFilterTooltip => 'Etiket Filter';

  @override
  String get labelIconColor => 'Etiket Ikoon Kleur';

  @override
  String get labelManagement => 'Etiket Bestuur';

  @override
  String get labelNotFound => 'Etiket nie gevind nie';

  @override
  String get labelRemoved => 'Etiket verwyder';

  @override
  String labelRemoveFailed(Object error) {
    return 'Kon nie etiket verwyder nie: $error';
  }

  @override
  String get labels => 'Etikette';

  @override
  String get labelsColor => 'Etikette Kleur';

  @override
  String labelsDeleted(Object count) {
    return '$count etikette uitgevee';
  }

  @override
  String get labelsExportedSuccessfully => 'Etikette suksesvol uitgevoer';

  @override
  String get labelsFontSize => 'Etikette Lettergrootte';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Het suksesvol $count etikette ingevoer';
  }

  @override
  String get labelsPosition => 'Etikette Posisie';

  @override
  String labelTag(Object labelId) {
    return 'Etiket: $labelId';
  }

  @override
  String get labelUpdated => 'Etiket opgedateer';

  @override
  String labelUpdateFailed(Object error) {
    return 'Kon nie etiket opdateer nie: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Etiket \"\$labelText\" suksesvol opgedateer';

  @override
  String get languageSettings => 'Taalinstellings';

  @override
  String get languageSettingsSubtitle => 'Verander toepassing vertoon taal';

  @override
  String get languageSettingsTitle => 'Taalinstellings';

  @override
  String get last30Days => 'Laaste 30 Dae';

  @override
  String get last7Days => 'Laaste 7 Dae';

  @override
  String get lastSyncLabel => 'Laaste Sinkronisasie';

  @override
  String lastUpdated(Object date) {
    return 'Laaste opgedateer: $date';
  }

  @override
  String get lifetimeMembership => 'Lewenslange Lidmaatskap';

  @override
  String get lifetimeMembershipDescription =>
      'Eenmalige aankoop, ontsluit permanent alle premium kenmerke en toekomstige opdaterings';

  @override
  String loadContactsFailed(Object error) {
    return 'Kon nie kontakte laai nie: $error';
  }

  @override
  String get loadDataFailed => 'Kon nie data laai nie';

  @override
  String get loadFailed => 'Laai Misluk';

  @override
  String get loading => 'Laai...';

  @override
  String get loadingData => 'Laai Data...';

  @override
  String get loadingTags => 'Laai etikette...';

  @override
  String loadLabelFailed(Object error) {
    return 'Kon nie etikette laai nie: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Kon nie etikette laai nie: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Kon nie gemerkte telefoonnommers laai nie: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Kon nie gemerkte nommers laai nie: $error';
  }

  @override
  String get loadMore => 'Laai Meer';

  @override
  String get loadPluginButton => 'Laai Plugin';

  @override
  String loadPluginsFailed(Object error) {
    return 'Kon nie plugins laai nie: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Kon nie instellings laai nie: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Kon nie SMS reëls laai nie: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Kon nie status laai nie';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Kon nie intekeninge laai nie: $error';
  }

  @override
  String get loan => 'Lening';

  @override
  String get localBackupTitle => 'Plaaslike Rugsteun';

  @override
  String get localCounterFilter => 'Plaaslike Teller Filter';

  @override
  String get localCounterFilterSubtitle =>
      'Filter strooiposoproepe outomaties gebaseer op oproepfrekwensie';

  @override
  String get localCountFilter => 'Plaaslike Aantal Filter';

  @override
  String get localCountFilterDescription =>
      'Intercept gereelde oproepe gebaseer op plaaslike nommer tellings';

  @override
  String get localCountFilterExplanationContent =>
      'Die plaaslike aantal filter ontleed oproepgeskiedenis rekords om gereelde strooiposoproepe outomaties te identifiseer en te blokkeer.';

  @override
  String get localCountFilterExplanationTitle =>
      'Plaaslike Aantal Filter Verduideliking';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Bepaal of om te blokkeer gebaseer op die nommer se aantal waarde';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Wanneer \'n nommer se telling die gestelde drempel oorskry, kan jy kies om dit outomaties te blokkeer';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Jy kan selektief nommers toelaat wat nie die drempel oorskry nie';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Jy kan kies of alle navraag logboeke aangeteken moet word';

  @override
  String get localCountFiltering => 'Plaaslike Aantal Filtrering';

  @override
  String get localCountFilteringExplanation =>
      '• Plaaslike Aantal Filtrering: Filter reëls gebaseer op plaaslike merk telling';

  @override
  String get localCountFilterSettings => 'Plaaslike Aantal Filter Instellings';

  @override
  String get localCountFilterUseCases =>
      'Hierdie filter is veral geskik vir die identifisering van outomaties geskakelde strooiposoproepe en bemarkingsoproepe.';

  @override
  String get localFilterSettings => 'Plaaslike Filter Instellings';

  @override
  String get localNotificationDisabled => 'Plaaslike kennisgewing gedeaktiveer';

  @override
  String get localNotificationEnabled => 'Plaaslike kennisgewing geaktiveer';

  @override
  String get localServices => 'Plaaslike Dienste';

  @override
  String get locationColor => 'Ligging Kleur';

  @override
  String get locationFontSize => 'Ligging Lettergrootte';

  @override
  String get locationIconColor => 'Ligging Ikoon Kleur';

  @override
  String get locationPosition => 'Ligging Posisie';

  @override
  String get logAllLocalQueries => 'Log Alle Plaaslike Navrae';

  @override
  String get logAllLocalQueriesDescription =>
      'Teken logboeke aan vir alle plaaslike nommer navrae';

  @override
  String get logAllRemoteQueries => 'Log Alle Afgeleë Navrae';

  @override
  String get logAllRemoteQueriesDescription =>
      'Teken alle afgeleë nommer navraag bedrywighede aan';

  @override
  String get manage => 'Bestuur Kontakte';

  @override
  String get manageContacts => 'Bestuur';

  @override
  String get manageFavoriteContacts => 'Bestuur Gunsteling Kontakte';

  @override
  String get manageFilterRules => 'Bestuur Filter Reëls';

  @override
  String get manageFilterRulesDescription =>
      'Voeg, wysig of verwyder SMS filter reëls';

  @override
  String get manageFrequentContacts => 'Bestuur Gereelde Kontakte';

  @override
  String get markCounts => 'Merk Tellings';

  @override
  String get markCount => 'Merk Aantal';

  @override
  String markedByCount(Object count) {
    return 'Gemerker deur $count';
  }

  @override
  String get markedPhonesList => 'Gemerker Telefoonnommers';

  @override
  String get markExchange => 'Merk Uitruil';

  @override
  String get markPhone => 'Merk Telefoonnommer';

  @override
  String markPhoneFailed(Object error) {
    return 'Ag dit merk van telefoonnommer het misluk:';
  }

  @override
  String get markPhoneManagementSubtitle => 'Om telefoonnommers te merk';

  @override
  String get markPhoneManagementTitle => 'Merk Telefoonbestuur';

  @override
  String get markPhoneSuccess => 'Telefoonnommer suksesvol gemerk';

  @override
  String get matchFailed => 'Passing het misluk!';

  @override
  String get matchFailedMessage => 'Passing het misluk.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'pas spesifieke nommerformaat';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Pas nommers met spesiale karakters aan:';

  @override
  String get matchSpecificDigitPatterns => 'pas XXX-XXXX-XXXX-formaat';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Pas spesifieke syferpatrone aan:';

  @override
  String get matchSuccessful => 'Passing suksesvol!';

  @override
  String get matchSuccessfulMessage => 'Passing suksesvol!';

  @override
  String get medical => 'Medies';

  @override
  String get membershipPrivileges => 'Lidmaatskapvoorregte';

  @override
  String get migrationTool => 'Migrasiehulpmiddel';

  @override
  String get migrationToolTitle => 'Migrasiehulpmiddel';

  @override
  String get minutes => 'minute';

  @override
  String get month => 'Maand';

  @override
  String get monthly => 'Maandeliks';

  @override
  String get monthlyCallCount => 'Maandelikse oproepe';

  @override
  String get monthlyChartTitle => 'Maandelikse geblokkeerde oproepe';

  @override
  String get monthlyMembership => 'Maandelikse lidmaatskap';

  @override
  String get monthlyMembershipDescription =>
      'Onsluit alle premiumfunksies, outomaties hernu maandeliks';

  @override
  String get monthlyTotal => 'Maandelikse totaal';

  @override
  String get monthlyTotalLabel => 'Maandelikse totaal';

  @override
  String get moreOptions => 'Meer opsies';

  @override
  String get mute => 'Dem';

  @override
  String get name => 'Naam';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Naam en telefoonnommer mag nie leeg wees nie';

  @override
  String get nameAndPhoneNumberRequired =>
      'Naam en telefoonnommer mag nie leeg wees nie';

  @override
  String get nameColor => 'Naamkleur';

  @override
  String get nameFontSize => 'Naam lettergrootte';

  @override
  String nameLabel(Object name) {
    return 'Naam: $name';
  }

  @override
  String get namePosition => 'Naamposisie';

  @override
  String get nameUnknown => 'Naam: Onbekend';

  @override
  String nameWithValue(String name) {
    return 'Naam: $name';
  }

  @override
  String get newPasswordLabel => 'Nuwe wagwoord';

  @override
  String get nextStep => 'Volgende';

  @override
  String get noAction => 'Geen aksie';

  @override
  String get noActionRules => 'Geen aksiereëls nie';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Geen aktiewe wolk sinkroniseringsdiens nie';

  @override
  String get noCallLogs => 'Geen oproeprekords nie';

  @override
  String get noCallRecords => 'Geen oproeprekords nie';

  @override
  String get noContacts => 'Nog geen kontakte nie';

  @override
  String get noContactsYet => 'Nog geen kontakte nie';

  @override
  String get noData => 'Geen data nie';

  @override
  String get noDevicesRegisteredMessage => 'Geen toestelle geregistreer nie';

  @override
  String get noDevicesRegisteredYet => 'Nog geen toestelle geregistreer nie.';

  @override
  String get noFilters => 'Nog geen filters nie';

  @override
  String get noLabels => 'Nog geen etikette nie';

  @override
  String get noMarkedPhones => 'Geen gemerkte telefoonnommers nie';

  @override
  String get noMatchingContacts => 'Geen bypassende kontakte nie';

  @override
  String get noMatchingContactsFound => 'Geen bypassende kontakte gevind nie';

  @override
  String get noMatchingNumbersFound => 'Geen bypassende nommers gevind nie';

  @override
  String get noMatchingRecords => 'Geen bypassende oproeprekords nie';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Geen bypassende $ruleType nie';
  }

  @override
  String get none => 'Geen';

  @override
  String get noneServiceType => 'Geen';

  @override
  String get noPlugins => 'Nog geen inproppe nie';

  @override
  String get noRecords => 'Geen oproeprekords nie';

  @override
  String get noResultReturned => 'Geen resultaat teruggestuur nie';

  @override
  String get noResultReturnedLog =>
      'Geen resultaat teruggestuur van inprop nie';

  @override
  String noRules(Object ruleType) {
    return 'Geen $ruleType nog nie';
  }

  @override
  String get noRulesPrompt => 'Geen reëls gevind nie, voeg asseblief reëls by';

  @override
  String get noRulesToExport => 'Geen reëls om uit te voer nie';

  @override
  String get noSmsFilterRulesYet => 'Nog geen SMS-filterreëls nie';

  @override
  String get noSmsRulesYet => 'Nog geen SMS-reëls nie';

  @override
  String get noSubscriptions => 'Geen intekeninge nie';

  @override
  String get noSubscriptionsYet => 'Nog geen intekeninge nie';

  @override
  String get notGranted => 'Nie toegeken nie';

  @override
  String get notificationMode => 'Kennisgewingmodus';

  @override
  String get notificationModeDescription =>
      'Wys bellerinligting in die kennisgewingbalk';

  @override
  String get notificationPermission => 'Kennisgewingtoestemming';

  @override
  String get notificationPermissionDescription =>
      'Gebruik om inkomende oproep- en boodskapvertonings te vertoon.';

  @override
  String get notifications => 'Kennisgewings';

  @override
  String get notificationSettings => 'Kennisgewinginstellings';

  @override
  String get notificationSettingsSaved =>
      'Kennisgewinginstellings suksesvol gestoor';

  @override
  String get notSet => 'Nie gestel nie';

  @override
  String get notVerifiedText => 'Nie geverifieer nie';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Geen geldige SMS-reëls in lêer gevind nie';

  @override
  String get number => 'Nommer';

  @override
  String get numberColor => 'Nommerkleur';

  @override
  String get numberFontSize => 'Nommer lettergrootte';

  @override
  String get numberPosition => 'Nommerposisie';

  @override
  String get numberSearch => 'Nommer soektog';

  @override
  String get numberTypeColor => 'Nommertipe kleur';

  @override
  String get numberTypeFontSize => 'Nommertipe lettergrootte';

  @override
  String get numberTypePosition => 'Nommertipe posisie';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'U oproepbestuurder is gereed, begin met \'n veilige oproep-ervaring!';

  @override
  String get onboardingLanguageDescription =>
      'Kies u voorkeurtaal vir die beste ervaring.';

  @override
  String get onboardingPermissionsDescription =>
      'Om volle diens te lewer, benodig ons die volgende toestemmings:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Een-klik blokkering van spam-oproepe en boodskappe, pas blokkeer-reëls aan, en gee u \'n stil omgewing.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Identifiseer onbekende oproepe outomaties, merk verdagte nommers en beskerm u oproepveiligheid.';

  @override
  String get onboardingWelcomeDescription =>
      'U oproepbestuurkundige, wat omvattende oproepidentifikasie- en blokkeringsdienste lewer.';

  @override
  String get oneDriveAuthDescription =>
      'Magtig met behulp van die stelsel-gekonfigureerde OneDrive-kliënt-ID en sleutel';

  @override
  String get oneDriveAuthorizationHint =>
      'Magtig met behulp van die stelsel-gekonfigureerde OneDrive-kliënt-ID en sleutel';

  @override
  String get oneDriveConfigTitle => 'OneDrive Konfigurasie';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive Konfigurasie';

  @override
  String get onlineCallerIdSubscription => 'Aanlyn oproeper-ID-intekening';

  @override
  String get openAppSettings => 'Maak programinstellings oop';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Kon nie programinstellings oopmaak nie: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operasie het misluk: $error';
  }

  @override
  String get operationFailure => 'Operasie het misluk';

  @override
  String get operationSuccess => 'Operasie het geslaag';

  @override
  String get other => 'Anders';

  @override
  String get ourOtherApps => 'Ons Ander Programme';

  @override
  String get overlayMode => 'Drijwende venster';

  @override
  String get overlayModeDescription =>
      'Wys oproeperinligting in \'n drywende venster';

  @override
  String get overlayPermission => 'Oorleg toestemming';

  @override
  String get overlayPermissionDescription =>
      'Gebruik om inkomende oproep-oorleg te vertoon.';

  @override
  String get overview => 'Oorsig';

  @override
  String get password => 'Wagwoord';

  @override
  String get passwordCannotBeEmpty => 'Wagwoord kan nie leeg wees nie';

  @override
  String get passwordLabel => 'Wagwoord';

  @override
  String get passwordsDoNotMatch => 'Wagwoorde stem nie ooreen nie';

  @override
  String get passwordSetSuccessfully => 'Wagwoord suksesvol gestel';

  @override
  String get pattern => 'Patroon';

  @override
  String get pendingSync => 'Hangende sinkronisering';

  @override
  String get periodMonth => 'Maand';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodYear => 'Jaar';

  @override
  String get permissionDenied => 'Toestemming versoek geweier';

  @override
  String get permissionGranted => 'Toestemming toegestaan';

  @override
  String get permissionManagement => 'Toestemmingsbestuur';

  @override
  String get phoneCallsTab => 'Telefoon';

  @override
  String get phoneNumber => 'Telefoonnommer';

  @override
  String get phoneNumberCannotBeEmpty => 'Telefoonnommer kan nie leeg wees nie';

  @override
  String get phoneNumberHint => 'Voer telefoonnommer in';

  @override
  String get phoneNumberHintText => 'Voer telefoonnommer in om reël by te voeg';

  @override
  String get phoneNumberLabel => 'Telefoonnommer';

  @override
  String get phoneNumberRegexRequired =>
      'Voer asseblief beide telefoonnommer en regex-patroon in';

  @override
  String get phoneNumberRequired => 'Telefoonnommer word vereis';

  @override
  String get phoneNumberTypeFixedLine => 'Vaste lyn';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Vaste lyn of mobiel';

  @override
  String get phoneNumberTypeMobile => 'Mobiel';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Persoonlike nommer';

  @override
  String get phoneNumberTypePremiumRate => 'Premium koers';

  @override
  String get phoneNumberTypeSharedCost => 'Gedeelde koste';

  @override
  String get phoneNumberTypeTollFree => 'Gratis';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Onbekend';

  @override
  String get phoneNumberTypeVoicemail => 'Gelyktoon';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Telefoontoestemming';

  @override
  String get phonePermissionDescription =>
      'Gebruik om inkomende oproepe te identifiseer en te blokkeer.';

  @override
  String get phoneRule => 'Telefoonreël';

  @override
  String get phoneRuleEditDialog => 'Telefoonreël Redigeer dialoog';

  @override
  String get phoneRuleManagement => 'Telefoonreëlbestuur';

  @override
  String get phoneRuleSubscription => 'Telefoonreël-intekening';

  @override
  String get phoneSubscription => 'Telefoon-intekening';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Teken in op telefoonreël lyste via URL om witlys en swartlys reëls outomaties op te dateer. Ondersteun JSON-formaat reël lêers.';

  @override
  String get phoneSubscriptionTitle => 'Telefoonreël-intekeninge';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Kies asseblief \'n etiket en voer \'n geldige telefoonnommer in';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" suksesvol bygevoeg';
  }

  @override
  String get pluginDeleted => 'Plugin uitgevee';

  @override
  String get pluginLatestVersion => 'Plugin is reeds die nuutste weergawe';

  @override
  String get pluginListExportSuccess => 'Plugin lys suksesvol uitgevoer';

  @override
  String get pluginLoadedSuccessfully => 'Plugin suksesvol gelaai';

  @override
  String get pluginManagement => 'Plugin bestuur';

  @override
  String get pluginManagementSubtitle =>
      'Bestuur en konfigureer derdeparty-plugins';

  @override
  String get pluginManagementTitle => 'Plugin bestuur';

  @override
  String get pluginName => 'Plugin Naam';

  @override
  String get pluginNotLoaded =>
      'Plugin is nog nie gelaai nie. Laai asseblief eers die plugin.';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugins suksesvol uitgevee.';
  }

  @override
  String get pluginService => 'Plugin diens';

  @override
  String get pluginTestPageTitle => 'Plugin toets';

  @override
  String get pluginUpdateSuccess => 'Plugin suksesvol opgedateer';

  @override
  String get pluginUrl => 'Plugin URL';

  @override
  String get pluginUrlCannotBeEmpty => 'Plugin URL kan nie leeg wees nie';

  @override
  String get pluginUrlHint => 'Voer plugin URL in';

  @override
  String get pluginUrlLabel => 'Plugin URL';

  @override
  String get pluginVersion => 'Plugin weergawe';

  @override
  String get political => 'Politiek';

  @override
  String get powerfulSpamBlocking => 'Kragtige strooiposblokkering';

  @override
  String get previousStep => 'Vorige';

  @override
  String get prioritizeRemoteAction => 'Prioritiseer afgeleë aksie-instellings';

  @override
  String get prioritizeRemoteActionDescription =>
      'Prioritiseer aksie-instellings vanaf die afgeleë databasis';

  @override
  String get processing => 'Verwerking...';

  @override
  String get processingOperation => 'Verwerking...';

  @override
  String get purchase => 'Aankoop';

  @override
  String get quarterlyMembership => 'Kwartaallikse lidmaatskap';

  @override
  String get quarterlyMembershipDescription =>
      'Ontsluit alle premium funksies, outomatiese hernuwing kwartaalliks';

  @override
  String get queryButton => 'Navraag';

  @override
  String get queryFailed => 'Navraag het misluk';

  @override
  String get queryFailedLog => 'Navraag het misluk';

  @override
  String get querying => 'Navraag doen...';

  @override
  String get queryingPhoneNumber => 'Navraag doen oor telefoonnommer';

  @override
  String get queryResultTitle => 'Navraagresultaat';

  @override
  String get ready => 'Gereed!';

  @override
  String get receiveWeeklyStatistics => 'Ontvang weeklikse statistieke';

  @override
  String get recruiter => 'Rekruteerder';

  @override
  String get reEnterPasswordHint => 'Voer asseblief wagwoord weer in';

  @override
  String get refresh => 'Verfris';

  @override
  String get refreshPermissionStatus => 'Verfris toestemmingstatus';

  @override
  String get refreshTooltip => 'Verfris';

  @override
  String regexError(Object error) {
    return 'Regex fout: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex fout: $error';
  }

  @override
  String get regexPattern => 'Regex Patroon';

  @override
  String get regexPatternExplanation => 'Regex Patroon Verduideliking';

  @override
  String get regexPatternExplanationButton => 'Regex Patroon Verduideliking';

  @override
  String get regexPatternLabel => 'Regex Patroon';

  @override
  String get regexPatternsExamples =>
      'Gebruik standaard regex-sintaks om patrone te definieer. Voorbeelde:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Regex Patrone vir Telefoonnommer Passing';

  @override
  String get regexRule => 'Regex Reël';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Kon nie regex-reël byvoeg nie: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex-reël suksesvol bygevoeg';

  @override
  String get regexRuleManagement => 'Regex-reëlbestuur';

  @override
  String get regexRuleNamePatternRequired =>
      'Reëlnaam en regex-patroon kan nie leeg wees nie';

  @override
  String get regexRules => 'Regex Reëls';

  @override
  String get regexTesterTitle => 'Regex Toetser';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex-validering het misluk: $error';
  }

  @override
  String get regexValidationSuccess => 'Regex-validering suksesvol';

  @override
  String get region => 'Streek';

  @override
  String get registeredDevicesTitle => 'Geregistreerde Toestelle';

  @override
  String get rejectAllCalls => 'Verwerp Alle Oproepe';

  @override
  String get rejectAllCallsDescription =>
      'Wanneer geaktiveer, sal alle oproepe met die hoogste prioriteit verwerp word';

  @override
  String get rejectAllNumbers => 'Verwerp Alle Nommers';

  @override
  String get rejectAllNumbersDesc =>
      'Verwerp alle inkomende oproepe wanneer geaktiveer';

  @override
  String get rejectExceededNumbers => 'Verwerp Oorskryde Nommers';

  @override
  String get rejectExceededNumbersDescription =>
      'Verwerp nommers wat die drempelgetal oorskry outomaties';

  @override
  String get remoteFilterSettings => 'Afstand Filter Instellings';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Afstand Nommer Filter Instellings';

  @override
  String get remoteNumberFilter => 'Afstand Nommer Filter';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Hierdie filter gebruik \'n onafhanklike afstanddatabasis om die nuutste nommerinligting te verkry.';

  @override
  String get remoteNumberFilterDescription =>
      'onderskeplastige oproepe gebaseer op afstand databasisinligting';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Die afstand nommer filter identifiseer en blokkeer strooipos oproepe deur \'n afstand databasis te navraag doen gebaseer op nommer getal.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Afstand Nommer Filter Verduideliking';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Getal Drempel: Bepaal gebaseer op nommer voorkomsfrekwensie';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Filter Aksies: Konfigureer hoe om nommers te hanteer wat drempel oorskry';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Prioriteit Instellings: Stel prioriteit vir afstand aksies';

  @override
  String get remoteNumberFilterFeatures => 'Kenmerke:';

  @override
  String get remoteNumberFiltering => 'Afstand Nommer Filtering';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Afstand Nommer Filtering: Filter reëls gebaseer op afstand databasisinligting';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identifiseer strooipos oproepe met behulp van wolk databasis en gemeenskapsverslae';

  @override
  String get removeAdsDescription =>
      'Verwyder alle advertensies permanent in die app vir \'n gladder ervaring';

  @override
  String get removeAdsTitle => 'Verwyder Advertensies';

  @override
  String get removedFromFavoriteContacts => 'Verwyder uit gunsteling kontakte';

  @override
  String get removedFromFavorites => 'Verwyder uit gunstelinge';

  @override
  String get removeFavorite => 'Verwyder Gunsteling';

  @override
  String get removeFromFavorites => 'Verwyder uit Gunstelinge';

  @override
  String get renameButton => 'Hernoem';

  @override
  String get renameDeviceDialogTitle => 'Hernoem Toestel';

  @override
  String get renameDeviceTitle => 'Hernoem Toestel';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Dit sal al jou huidige instellings vervang. Is jy seker jy wil voortgaan?';

  @override
  String get requestAllPermissions => 'Versoek Alle Toestemmings';

  @override
  String get requestPermission => 'Versoek Toestemming';

  @override
  String requestPermissionFailed(Object error) {
    return 'Kon nie toestemming versoek nie: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Merke';
  }

  @override
  String get reset => 'Herstel';

  @override
  String get restore => 'Herstel';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Herstel Toepassing Instellings vanaf Rugsteun';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Herstel toepassing instellings vanaf rugsteun';

  @override
  String get restoreButton => 'Herstel';

  @override
  String restoreFailedWithError(Object error) {
    return 'Herstel vanaf wolk het misluk: $error';
  }

  @override
  String get restoreFromCloud => 'Herstel vanaf Wolk';

  @override
  String get restoreFromCloudDescription =>
      'Herstel instellings en reëls vanaf wolkberging';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Kon nie vanaf wolk herstel nie: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Herstel vanaf Wolk';

  @override
  String get restoreFromCloudSuccess => 'Suksesvol herstel vanaf wolk';

  @override
  String get restoreFromCloudTitle => 'Herstel vanaf Wolk';

  @override
  String get restoreFromLocal => 'Herstel vanaf Plaaslik';

  @override
  String get restorePurchases => 'Herstel Aankope';

  @override
  String get restoreSectionTitle => 'Herstel';

  @override
  String get restoreSettings => 'Herstel Instellings';

  @override
  String get restoreSettingsConfirmation =>
      'Dit sal al jou huidige instellings vervang. Is jy seker jy wil voortgaan?';

  @override
  String get restoreSettingsDialogTitle => 'Herstel Instellings';

  @override
  String get restoreSettingsTitle => 'Herstel Instellings';

  @override
  String get restoreSuccessFromLocal => 'Suksesvol herstel vanaf plaaslik';

  @override
  String get restoreSuccessMessage => 'Suksesvol herstel vanaf wolk';

  @override
  String get retry => 'Probeer weer';

  @override
  String get ridesharing => 'Rydeling';

  @override
  String get risk => 'Risiko';

  @override
  String get robocall => 'Robo-oproep';

  @override
  String get ruleAction => 'Reël Aksie';

  @override
  String get ruleAddButton => 'Voeg Reël By';

  @override
  String get ruleAddedSuccess => 'Reël bygevoeg suksesvol';

  @override
  String ruleAddFailure(Object error) {
    return 'Kon nie reël byvoeg nie: $error';
  }

  @override
  String get ruleAddSuccess => 'Reël bygevoeg suksesvol';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Is jy seker jy wil hierdie $ruleType uitvee?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Vee Reël Uit';

  @override
  String get ruleDeletedSuccess => 'Reël suksesvol uitgevee';

  @override
  String get ruleDeletedSuccessfully => 'Reël suksesvol uitgevee';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Kon nie reël uitvee nie: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Kon nie reël uitvee nie: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Reël suksesvol uitgevee';

  @override
  String get ruleDisabledSuccessfully => 'Reël suksesvol gedeaktiveer';

  @override
  String get ruleEnabledSuccessfully => 'Reël suksesvol geaktiveer';

  @override
  String ruleLoadFailed(Object error) {
    return 'Kon nie reëls laai nie: $error';
  }

  @override
  String get ruleManagement => 'Reël Bestuur';

  @override
  String get ruleManagementTitle => 'Reël Bestuur';

  @override
  String get ruleName => 'Reël Naam';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Reël naam en inhoud regex kan nie leeg wees nie';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Reël naam en telefoonnommer kan nie leeg wees nie';

  @override
  String get ruleNameHint => 'bv., Familie, Vriende, ens.';

  @override
  String get ruleNameLabel => 'Reël Naam';

  @override
  String get ruleNamePatternRequired =>
      'Voer asseblief reël naam en patroon in';

  @override
  String get ruleNameRequired =>
      'Reël naam en telefoonnommer kan nie leeg wees nie';

  @override
  String get ruleNotExist => 'Reël bestaan ​​nie of is uitgevee nie';

  @override
  String ruleNotFound(Object error) {
    return 'Reël nie gevind nie: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Reël suksesvol gestoor!';

  @override
  String get ruleSavedSuccessMessage => 'Reël suksesvol gestoor!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Stoor het misluk: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Stoor het misluk: $error';
  }

  @override
  String get ruleSaveSuccess => 'Reël suksesvol gestoor!';

  @override
  String get rulesExportedSuccessfully => 'Reëls suksesvol uitgevoer';

  @override
  String rulesExportedTo(Object path) {
    return 'Reëls uitgevoer na: $path';
  }

  @override
  String get rulesImported => 'Reëls suksesvol ingevoer';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count reëls suksesvol ingevoer';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Het misluk om reëls in te voer: $error';
  }

  @override
  String get ruleStatistics => 'Reëlstatistieke';

  @override
  String ruleStatusChanged(Object status) {
    return 'Reël $status suksesvol';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operasie het misluk: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Reël $status suksesvol';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Het misluk om reël op te dateer: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Reël suksesvol opgedateer';

  @override
  String get ruleVerification => 'Reëlverifikasie';

  @override
  String get save => 'Stoor';

  @override
  String get saveButton => 'Stoor';

  @override
  String get saveButtonLabel => 'STOOR';

  @override
  String get saveButtonText => 'Stoor';

  @override
  String saveFailed(Object error) {
    return 'Stoor het misluk: $error';
  }

  @override
  String get saveFilter => 'Stoor Filter';

  @override
  String get saveSettings => 'Stoor Instellings';

  @override
  String saveSettingsFailed(Object error) {
    return 'Het misluk om instellings te stoor: $error';
  }

  @override
  String get scamsLikely => 'Inskrywings Waarskynlik';

  @override
  String get search => 'Soek';

  @override
  String get searchContacts => 'Soek Kontakte';

  @override
  String searchError(Object error) {
    return 'Soekfout: $error';
  }

  @override
  String get searchFilters => 'Soek Filters';

  @override
  String get searchForContacts => 'Soek na kontakte';

  @override
  String get searchHint => 'Soek...';

  @override
  String get searchSettingsSubtitle =>
      'Soek kontakte, etikette, swartlyste, witlyste, ens.';

  @override
  String get searchSettingsTitle => 'Soek Instellings';

  @override
  String get securityMessage =>
      'Moenie enige telefoonoproepe vertrou nie. Verifieer kliëntediensnommers altytyd onafhanklik. Moet nooit wagwoorde, verifikasiekodes, kaartnommers of persoonlike inligting deel nie.';

  @override
  String get selectActionToPerform =>
      'Kies die aksie om uit te voer wanneer die reël pas';

  @override
  String get selectActionWhenBlockingCalls =>
      'Kies aksie wanneer oproepe geblokkeer word';

  @override
  String get selectActionWhenRuleMatches => 'Kies aksie wanneer reël pas';

  @override
  String get selectAll => 'Kies Alle';

  @override
  String get selectCountry => 'Kies Land';

  @override
  String get selectDateRange => 'Kies Datumbereik';

  @override
  String get selectedDateRange => 'Gekose datumbereik';

  @override
  String selectedItems(Object count) {
    return '$count items gekies';
  }

  @override
  String get selectedLabel => 'Gekies:';

  @override
  String get selectExportFormat => 'Kies Uitvoerformaat';

  @override
  String get selectLabel => 'Kies Etiket';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Kies asseblief \'n etiket en voer \'n geldige telefoonnommer in';

  @override
  String get selectLanguage => 'Kies Taal';

  @override
  String get selectMultiple => 'Kies Veelvuldige';

  @override
  String get selectPeriod => 'Kies Periode';

  @override
  String get selectSimCard => 'Kies SIM-kaart';

  @override
  String get selectSimSlot => 'Kies SIM-gleuf';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Kies die spesifieke aksie om uit te voer wanneer oproepe geblokkeer word';

  @override
  String get selectTag => 'Kies Etiket';

  @override
  String get selectTags => 'Kies Etikette';

  @override
  String get selectTrustedDataSource => 'Kies asseblief betroubare databronne';

  @override
  String get selectYourLanguage => 'Kies Jou Taal';

  @override
  String get sender => 'Sender';

  @override
  String get senderRegexOptional => 'Sender Regex (Opsioneel)';

  @override
  String get serverAddressLabel => 'Bedienadres';

  @override
  String get serviceTypeContact => 'Kontak Inskrywing';

  @override
  String get serviceTypeLabel => 'Diens Tipe';

  @override
  String get serviceTypePhone => 'Telefoon Inskrywing';

  @override
  String get serviceTypePlugin => 'Plugin Opdatering';

  @override
  String get serviceTypeSms => 'SMS Inskrywing';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Stel';

  @override
  String get setEncryptionPassword => 'Stel Enkripsie Wagwoord';

  @override
  String get setEncryptionPasswordDescription =>
      'Stel enkripsie wagwoord vir rugsteun en herstel';

  @override
  String get setEncryptionPasswordLabel => 'Stel Enkripsie Wagwoord';

  @override
  String get setEncryptionPasswordTitle => 'Stel Enkripsie Wagwoord';

  @override
  String get setPasswordButton => 'Stel';

  @override
  String get settings => 'Instellings';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Instellings gerugsteun na: $path';
  }

  @override
  String get settingsLoaded => 'Instellings gelaai';

  @override
  String settingsLoadFailed(Object error) {
    return 'Het misluk om instellings te laai: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Instellings suksesvol herstel. Herbegin asseblief die toepassing sodat veranderinge in werking tree.';

  @override
  String get settingsSaved => 'Instellings gestoor';

  @override
  String settingsSaveFailed(Object error) {
    return 'Het misluk om instellings te stoor: $error';
  }

  @override
  String get settingsTab => 'Instellings';

  @override
  String get settingsTitle => 'Instellings';

  @override
  String get setup => 'Opstelling';

  @override
  String get showContactEditDialogStaticMethod =>
      'Statiese metode om kontak redigeerdialoog te wys';

  @override
  String get showExplanation => 'Wys Verklaring';

  @override
  String get silence => 'Stilte';

  @override
  String get silenceAndNoAnswer => 'Stilte en Geen Antwoord Nie';

  @override
  String get silenceNoAnswer => 'Stilte Geen Antwoord Nie';

  @override
  String get silentCallVoiceClone => 'Stil Oproep Stem Kloning';

  @override
  String get silentRules => 'Stil Reëls';

  @override
  String simCard(Object simNumber) {
    return 'SIM-kaart $simNumber';
  }

  @override
  String get simCardColor => 'SIM-kaart Kleur';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM-kaart Konfigurasie: Stel onafhanklike filterreëls vir elke SIM-kaart';

  @override
  String get simCardFilterRules => 'SIM-kaart Filter Reëls';

  @override
  String get simCardFilterRulesDescription =>
      'Stel verskillende filterreëls gebaseer op SIM-kaartgleuwe';

  @override
  String get simCardFontSize => 'SIM-kaart Lettergrootte';

  @override
  String get simCardPosition => 'SIM-kaart Positiewe';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Het misluk om SIM-kaartinligting te laai: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM-gleufreëls laat jou toe om onafhanklike filterreëls vir elke SIM-gleuf te konfigureer.';

  @override
  String get simRuleInstructionsTitle => 'SIM-gleufreëls';

  @override
  String get simRuleManagement => 'SIM-gleufreëlbestuur';

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
    return 'Kon nie SIM-data laai nie: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM-gleuffilterkonfigurasie';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Maak dit moontlik om filterreëls per SIM-gleuf te stel';

  @override
  String get simSlotFilterDescription =>
      'Konfigureer onafhanklike filterreëls vir elke SIM-kaart:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM-gleuf $slotNumber filterinstellings';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Kon nie SIM-gleuwe laai nie: $error';
  }

  @override
  String get simSlotManagement => 'SIM-gleufbestuur';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM-gleufoperasie het misluk: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM-gleufposisie $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM-gleufreëls: Onafhanklike filterstrategieë per SIM';

  @override
  String get simSlotRuleListTitle => 'SIM-gleufreëllys';

  @override
  String get simSlotRuleManagement => 'SIM-gleufreëls';

  @override
  String get simSlotRuleManagementTitle => 'Reëlbestuur';

  @override
  String get simSlotSettings => 'SIM-gleufinstellings';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM-gleuf $slotNumber';
  }

  @override
  String get skip => 'Wys oor';

  @override
  String get smartCallerId => 'Slim oproeper-ID-identifikasie';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS-filtering help jou om strooiposboodskappe outomaties te filter en jou boodskapslys skoon te hou. Jy kan filterreëls en kennisgewingsmetodes stel.';

  @override
  String get smsFilterDisabled => 'SMS-filtering gedeaktiveer';

  @override
  String get smsFilterEnabled => 'SMS-filtering geaktiveer';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'SMS-filterreël suksesvol bygevoeg';

  @override
  String get smsFilterRules => 'SMS-filterreëls';

  @override
  String get smsFilterSettings => 'SMS-filterinstellings';

  @override
  String get smsHistory => 'SMS-geskiedenis';

  @override
  String get smsManagement => 'SMS-bestuur';

  @override
  String get smsPermission => 'SMS-toestemming';

  @override
  String get smsPermissionDescription =>
      'Word gebruik om strooiposboodskappe te filter.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS-reël suksesvol bygevoeg';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS-reël suksesvol uitgevee';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Kon nie SMS-reëls laai nie: $error';
  }

  @override
  String get smsRuleManagement => 'SMS-reëlbestuur';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS-reëls suksesvol uitgevoer na $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS-reëls suksesvol ingevoer';

  @override
  String get smsRuleSubscription => 'SMS-reëlinskrywing';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS-reël suksesvol opgedateer';

  @override
  String get smsSettingsSubtitle => 'SMS-filtering en sleutelwoordblokkering';

  @override
  String get smsSettingsTitle => 'SMS-instellings';

  @override
  String get smsSubscription => 'SMS-inskrywing';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'SMS-inskrywing suksesvol bygevoeg';

  @override
  String get smsSubscriptionRulesDescription =>
      'Teken in op SMS-reëllyste via URL, ondersteun gereelde uitdrukkingspassing. Jy kan blokkeer- of toelaat-aksies stel.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Sommige toestemmingsversoeke geweier';

  @override
  String get spamLikely => 'Waarskynlik strooipos';

  @override
  String get startColor => 'Beginkleur';

  @override
  String get startDate => 'Begin Datum';

  @override
  String get startUsing => 'Begin Gebruik';

  @override
  String get statAnswered => 'Beantwoord';

  @override
  String get statBlocked => 'Geblokkeer';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Statiese metode om die Oproeper ID Inligting Dialoog te wys';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Statiese metode om landkeuse-dialoog te vertoon';

  @override
  String get staticMethodToDisplayDialog =>
      'Statiese metode om dialoog te vertoon';

  @override
  String get statistics => 'Statistieke';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Statistiekuitvoer-funksie kom binnekort';

  @override
  String get statisticsGrid => 'Statistiekrooster';

  @override
  String get statisticsPageTitle => 'Data-analise';

  @override
  String get stirColor => 'STIR Kleur';

  @override
  String get stirFontSize => 'STIR Lettergrootte';

  @override
  String get stirPosition => 'STIR Posisie';

  @override
  String get storagePermission => 'Bergingstoestemming';

  @override
  String get storagePermissionDescription =>
      'Word gebruik om instellings en reëls te stoor.';

  @override
  String get subscribe => 'Teken In';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Inskrywing \"$name\" suksesvol bygevoeg';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Is jy seker jy wil hierdie inskrywing uitvee?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Vee Inskrywing uit';

  @override
  String get subscriptionDeleted => 'Inskrywing uitgevee';

  @override
  String get subscriptionDeletedSuccessfully => 'Inskrywing suksesvol uitgevee';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Kon nie inskrywing uitvee nie: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Inskrywing uitgevee';

  @override
  String get subscriptionEmptyState => 'Geen inskrywings beskikbaar nie';

  @override
  String get subscriptionEmptyText => 'Nog geen inskrywings nie';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Kon nie inskrywings laai nie: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Kon nie inskrywings laai nie: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Inskrywingbestuur';

  @override
  String get subscriptionName => 'Inskrywing Naam';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Inskrywing naam en URL kan nie leeg wees nie';

  @override
  String get subscriptionNameHint => 'Voer inskrywing naam in';

  @override
  String get subscriptionPageTitle => 'Inskrywingbestuur';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Kon nie inskrywingstatus verander nie: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Kon nie inskrywingstatus wissel nie: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Kon nie inskrywing opdateer nie: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Inskrywing suksesvol opgedateer';

  @override
  String get subscriptionUrl => 'Inskrywing URL';

  @override
  String get subscriptionUrlHint => 'Voer inskrywing URL in';

  @override
  String successfullyImportedRules(Object count) {
    return 'Suksesvol $count reëls ingevoer';
  }

  @override
  String get supportSync => 'Ondersteun Sinkronisasie';

  @override
  String get survey => 'Opname';

  @override
  String get syncDevicesButton => 'Sinkroniseer toestelle';

  @override
  String get syncFailed => 'Sinkronisasie het misluk';

  @override
  String get syncFailedMessage => 'Sinkronisasie het misluk';

  @override
  String get syncFolderNameHint =>
      'Voer asseblief sinkronisasie-vouer naam in (verstek: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Sinkronisasie-vouer Naam';

  @override
  String get synchronized => 'Gesinkroniseer';

  @override
  String get syncing => 'Sinkroniseer...';

  @override
  String get syncNow => 'Sinkroniseer Nou';

  @override
  String get syncNowButton => 'Sink Nou';

  @override
  String get syncStatusTitle => 'Sink Status';

  @override
  String get syncStatusUpdatedMessage => 'Sink status opgedateer';

  @override
  String get syncSuccessful => 'Sink suksesvol';

  @override
  String get syncSuccessMessage => 'Sink suksesvol';

  @override
  String get syncWithCloudStorage => 'Sink met Wolkberging';

  @override
  String get syncWithCloudStorageSubtitle => 'Sink met wolkhuring';

  @override
  String get systemFeatures => 'Stelselkenmerke:';

  @override
  String get systemSettingsTitle => 'Stelselinstellings';

  @override
  String get tabAll => 'Alles';

  @override
  String get tabAnswered => 'Beantwoord';

  @override
  String get tabBlocked => 'Geblokkeer';

  @override
  String get tabMissed => 'Gemis';

  @override
  String get tabOutgoing => 'Uitgaande';

  @override
  String tagLabel(String tag) {
    return 'Etiket: $tag';
  }

  @override
  String get tagsUpdated => 'Etikette opgedateer';

  @override
  String get takeaway => 'Uitneem';

  @override
  String get telecommunication => 'Telekommunikasie';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telebemarking';

  @override
  String get testButton => 'TOETS';

  @override
  String get testButtonLabel => 'TOETS';

  @override
  String get testConnectionButton => 'Toets Verbinding';

  @override
  String get textColorsSetting => 'Teks & Etiket Kleure';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Hierdie app is \'n kragtige oproeper-ID-instrument wat jou toelaat om ongewenste oproepe te identifiseer en te blokkeer.';

  @override
  String get thisWeek => 'Hierdie Week';

  @override
  String get timeInterceptor => 'Tyd Interseptoer';

  @override
  String get timeInterceptorDescription =>
      'Onderskep/laat potensiële oproepe outomaties toe op grond van oproepfrekwensie';

  @override
  String get timeInterceptorExplanation =>
      '• Tyd Interseptoer: Onderskep/laat herhaalde oproepe binne \'n kort tyd toe';

  @override
  String get timeInterceptorExplanationContent =>
      'Die oproepfrekwensie onderskep-funksie ontleed oproepfrekwensie om gereelde strooiposoproepe outomaties te identifiseer en te onderskep/toe te laat.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Verduideliking van Oproepfrekwensie Onderskep';

  @override
  String get timeInterceptorSettingsTitle =>
      'Instellings vir Oproepfrekwensie Onderskep';

  @override
  String get timeInterceptorSubtitle =>
      'Onderskep potensiële strooiposoproepe outomaties op grond van oproepfrekwensie';

  @override
  String get timeInterceptorTitle => 'Aktiveer Oproepfrekwensie Onderskep';

  @override
  String get timeWindowDescription =>
      'Stel die tydvenstergrootte vir die toelaat van herhaalde oproepe. Oproepe van dieselfde nommer binne hierdie venster sal toegelaat word';

  @override
  String timeWindowLabel(int minutes) {
    return 'Onderskep Tydvenster (minute): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Stel die tydvenstergrootte vir die toelaat van herhaalde oproepe. Oproepe van dieselfde nommer binne hierdie venster sal toegelaat word';

  @override
  String get today => 'Vandag';

  @override
  String get total => 'Totaal';

  @override
  String get totalBlocked => 'Totaal Geblokkeer';

  @override
  String get totalFiltered => 'Totaal Gefiltreer';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Dra data oor tussen toestelle of platforms';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Dra data oor tussen toestelle of platforms';

  @override
  String get travelTicketing => 'Reiskaartjies';

  @override
  String get trend => 'Tendens';

  @override
  String get trendChart => 'Tendensgrafiek';

  @override
  String get tutorial => 'Lesing';

  @override
  String get type => 'Tipe';

  @override
  String get unassignedSIMCard => 'Ongebonde SIM-kaart';

  @override
  String get unknown => 'Onbekend';

  @override
  String get unknownLabel => 'Onbekende Etiket';

  @override
  String get unknownTag => 'Etiket: Onbekend';

  @override
  String get unregisterButton => 'Ont registreer';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Is jy seker jy wil $deviceName ont registreer?';
  }

  @override
  String get unregisterDeviceTitle => 'Ont registreer Toestel';

  @override
  String get unsupportedFileFormat => 'Ongeldige lêerformaat';

  @override
  String get update => 'Opdateer';

  @override
  String get updateAllNow => 'Opdateer Alles Nou';

  @override
  String get updateCallFilterConfig => 'Opdateer Oproepfilter Konfigurasie';

  @override
  String updateContactFailed(Object error) {
    return 'Kon nie kontak opdateer nie: $error';
  }

  @override
  String get updateFavoriteStatus => 'Opdateer Gunsteling Status';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Kon nie gunsteling status opdateer nie: $error';
  }

  @override
  String get updateInterval => 'Opdateringsinterval';

  @override
  String get updateLabelFailed => 'Kon nie etiket opdateer nie';

  @override
  String get updateNow => 'Opdateer Nou';

  @override
  String get updatePlugin => 'Opdateer Plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'Kon nie plugin opdateer nie: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Kon nie reël opdateer nie: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Kon nie intekening opdateer nie: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service suksesvol opgedateer ($count reëls)';
  }

  @override
  String get updateTags => 'Opdateer Etikette';

  @override
  String get useCasesPoint1 => '• Identifiseer outo-heroproep strooipos';

  @override
  String get useCasesPoint2 =>
      '• Onderskep bemarkingsoproepe wat veelvuldig in \'n kort tyd bel';

  @override
  String get useCasesPoint3 => '• Voorkom telefoonbomaanvalle en teistering';

  @override
  String get useCasesTitle => 'Gebruik Sake:';

  @override
  String get useGlobalSettings => 'Gebruik Globale Instellings';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Gebruikersnaam';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Gebruik standaard regex-sintaks om patrone te definieer. Voorbeelde:';

  @override
  String get validateRegex => 'Valideer Regex';

  @override
  String get verificationFailedText => 'Misluk';

  @override
  String get verifiedText => 'Geverifieer';

  @override
  String get verify => 'Verifieer';

  @override
  String version(Object version) {
    return 'Weergawe: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Ruil VIP-lidmaatskap met telefoonnommer merk tellings';

  @override
  String get vipExchangeTitle => 'Merk Uitruil VIP';

  @override
  String get watchAd => 'Kyk Advertensie';

  @override
  String get watchAdForTemp => 'Kyk Advertensie vir Tydelike Privilegies';

  @override
  String get watchAdForTempDescription =>
      'Kyk \'n kort advertensie om tydelik van die premium funksies te ontsluit';

  @override
  String get webDAVConfigTitle => 'WebDAV Konfigurasie';

  @override
  String get webdavConfigurationTitle => 'WebDAV Konfigurasie';

  @override
  String get webdavPasswordHint => 'Voer asseblief WebDAV wagwoord in';

  @override
  String get webdavServerAddressHint =>
      'Voer asseblief WebDAV bediener adres in';

  @override
  String get webdavUsernameHint => 'Voer asseblief WebDAV gebruikersnaam in';

  @override
  String get week => 'Week';

  @override
  String get weekly => 'Weekliks';

  @override
  String get weeklyBlockedCallsSummary =>
      'Weeklikse Geblokkeerde Oproepe Opsomming';

  @override
  String get weeklyChartTitle => 'Weeklikse Geblokkeerde Oproepe';

  @override
  String get weeklyReport => 'Weeklikse Verslag';

  @override
  String get weeklyReportDesc =>
      'Ontvang weeklikse opsommingsverslag van oproepblokkeringsaktiwiteit';

  @override
  String get welcome => 'Welkom';

  @override
  String get whitelist => 'Witlys';

  @override
  String get whitelistLabel => 'Witlys';

  @override
  String get width => 'Breedte';

  @override
  String get wildcardMatchingDescription =>
      'Gebruik \'.\' om enige karakter te pas, (bv. \'123.456\' pas 123-456)';

  @override
  String get wildcardMatchingTitle => 'Wildcard pasmaat:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Wildcard Ondersteuning vir Buigsame Filtering';

  @override
  String get windowSizeSetting => 'Venster Grootte';

  @override
  String get year => 'Jaar';

  @override
  String get yearly => 'Jaarliks';

  @override
  String get yearlyChartTitle => 'Jaarlikse Geblokkeerde Oproepe';

  @override
  String get noSimCardsDetected => 'Geen SIM-kaarte opgespoor nie';

  @override
  String get filterManagementDescription => 'Stel Oproep Filters';

  @override
  String get callerIdCustomizationSubtitle => 'Pas Beller ID Uitleg Aan';

  @override
  String get fraudAlerSettingTitle => 'Bedrogwaarskuwing Instelling';

  @override
  String get fraudAlerSettingSubtitle => 'Om Bedrogwaarskuwing te Stel';

  @override
  String get enableFraudAlert => 'Aktiveer Bedrogwaarskuwing';

  @override
  String get enableFraudAlertDescription =>
      'Waarskuwing vir vermoedelike bedrogoproepe';

  @override
  String get enableVibration => 'Aktiveer Vibrasie';

  @override
  String get enableVibrationDescription =>
      'Vibreer wanneer oproep vermoedelike bedrogoproepe is';

  @override
  String get notificationSettingsTitle => 'Kennisgewing Instellings';

  @override
  String get useLocalNotification => 'Gebruik Plaaslike Kennisgewings';

  @override
  String get useLocalNotificationDescription =>
      'Aktiveer plaaslike kennisgewings vir inkomende oproepe';

  @override
  String get cancelLocalNotification => 'Maak Plaaslike Kennisgewings Toe';

  @override
  String get useStirNotification => 'Gebruik Kennisgewing van STIR';

  @override
  String get useStirNotificationDescription =>
      'Aktiveer STIR kennisgewings vir inkomende oproepe';

  @override
  String get cancelLocalNotificationDescription =>
      'Maak Plaaslike Kennisgewings Outomaties Toe';

  @override
  String get callerIdSettingsTitle => 'Beller ID Instellings';

  @override
  String get callerIdSettingsSubtitle =>
      'Om Inkomende Oproep Kennisgewing & Vertoonmodus op te Stel';

  @override
  String get purchaseTitle => 'Aankoop';

  @override
  String get purchaseSubtitle => 'Om die Diens aan te skaf';

  @override
  String get callerIdNotificationTitle => 'Inkomende Oproepinligting';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Nommer: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Geblokkeerde Oproep';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Geblokkeerde oproep van $phoneNumber';
  }

  @override
  String get stirVerified => 'Geverifieer';

  @override
  String get stirNotVerified => 'Nie Geverifieer nie';

  @override
  String get stirFailed => 'Verifikasie Misluk';

  @override
  String get stirUnknown => 'Onbekende Verifikasie Status';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN Verifikasie';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage vir nommer $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Rolboodskap Veiligheidsinstellings';

  @override
  String get messageColor => 'Boodskap Kleur';

  @override
  String get messageFontSize => 'Boodskap Lettergrootte';

  @override
  String get messagePosition => 'Boodskap Pos';

  @override
  String get containerWidth => 'Houer Breedte';

  @override
  String get scrollSpeed => 'Rol Spoed';

  @override
  String get enableSecurityMessage => 'Aktiveer Veiligheidsboodskap';

  @override
  String get fraudAlertTitle => 'Bedrogwaarskuwing';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Potensiële bedrogoproep van $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Kon nie reëls laai nie: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Kon nie oproep logboek laai nie: $error';
  }

  @override
  String get noBlockedTypeData => 'Geen geblokkeerde tipe data beskikbaar nie';

  @override
  String importEntity(Object entityTypeName) {
    return 'Voer in $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName suksesvol ingevoer, totaal $count rekords ingevoer';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Kon nie $entityTypeName invoer nie: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Voer uit $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName suksesvol uitgevoer';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Kon nie $entityTypeName uitvoer nie: $error';
  }

  @override
  String get cloudSyncService => 'Wolk Sinkronisering Diens';

  @override
  String get membershipCenter => 'Lidmaatskap Sentrum';

  @override
  String get redeemVipWithMarks => 'Verlos VIP met Merke';

  @override
  String get currentMarkCount => 'Huidige Merk Aantal';

  @override
  String get markMoreNumbersForMore => 'Merk meer nommers vir meer merke';

  @override
  String get noAds => 'Geen Advertensies nie';

  @override
  String get cloudBackup => 'Wolk Rugsteun';

  @override
  String get callerIdEnhancement => 'Beller ID Verbetering';

  @override
  String get voiceRecognition => 'Stemherkenning';

  @override
  String get feature => 'Funksie';

  @override
  String get normalUser => 'Normale Gebruiker';

  @override
  String get vipUser => 'VIP Gebruiker';

  @override
  String get temporaryVip => 'Tydelike VIP';

  @override
  String get removeAds => 'Verwyder Advertensies';

  @override
  String get unknownAction => 'Onbekende Aksie';

  @override
  String get settingsBackup => 'Instellings Rugsteun ';

  @override
  String get allServicesStatusTitle => 'Huidige Diensstatus';

  @override
  String get allServicesStatusSubtitle => 'Huidige Status van Elke Wolkdiens';

  @override
  String get redirect => 'Herlei';

  @override
  String get notify => 'Stel in kennis';

  @override
  String get log => 'Logboek';

  @override
  String get custom => 'Pasgemaak';

  @override
  String get allowActionDescription =>
      'Oproepe sal toegelaat word, selfs al is die nommer op die bloklys.';

  @override
  String get blockActionDescription =>
      'Oproepe sal geblokkeer word en in die oproep logboek gewys word.';

  @override
  String get silenceActionDescription =>
      'Oproepe sal stilgemaak word maar in die oproep logboek gewys word.';

  @override
  String get noneActionDescription =>
      'Geen spesiale aksie sal vir die oproep geneem word nie.';

  @override
  String get redirectActionDescription =>
      'Herlei die oproep na \'n gespesifiseerde nommer.';

  @override
  String get labelActionDescription =>
      'Voeg \'n etiket by die oproep vir maklike identifikasie.';

  @override
  String get notifyActionDescription =>
      'Stuur \'n kennisgewing wanneer \'n oproep ontvang word.';

  @override
  String get logActionDescription =>
      'Log die oproepinligting sonder om enige ander aksie te neem.';

  @override
  String get customActionDescription => 'Voer \'n pasgemaakte aksie uit.';

  @override
  String get synced => 'Gesinkroniseer';

  @override
  String get needVipAccess =>
      'Jy benodig VIP toegang om hierdie funksie te gebruik';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Voer $entityTypeName data in of uit';
  }

  @override
  String get importExportTitle => 'Invoer/Uitvoer';

  @override
  String get noPhoneRules => 'Geen telefoonreëls gevind nie';

  @override
  String get noRegexRules => 'Geen regex reëls gevind nie';

  @override
  String get noAllowedBlockedRules =>
      'Geen toegelate/geblokkeerde reëls gevind nie';

  @override
  String get importExport => 'Invoer/Uitvoer';

  @override
  String get filterByAction => 'Filter volgens Aksie';

  @override
  String get upgradeToVip => 'Gradeer op na VIP';

  @override
  String get batteryOptimizationPermission => 'Battery Optimization';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Laat die toepassing in die agtergrond toe om dienste soos oproeper-ID te verskaf.';

  @override
  String get permissionTitle => 'Spesiale Toestemmings';

  @override
  String get permissionSubtitle =>
      'Bestuur oorleg en battery-optimaliseringstoestemmings';

  @override
  String get themeSettingsTitle => 'Tema-instellings';

  @override
  String get themeSettingsSubtitle => 'Kies jou gunsteling tema';

  @override
  String get databaseSyncTitle => 'Databasis Sinkronisering';

  @override
  String get countrySyncSettingsTitle =>
      'Landgebaseerde Databasis Sinkronisering Instellings';

  @override
  String get countrySyncSettingsSubtitle =>
      'Kies lande vir data sinchronisasie';

  @override
  String get countryDataDisclaimer =>
      'Neem asseblief kennis: Die databasis mag nie data vir alle spesifieke lande of streke insluit nie.';

  @override
  String get editSubscription => 'Wysig Inskrywing';

  @override
  String get searchByNameOrPhoneNumber => 'Soek volgens Naam of Telefoonnommer';

  @override
  String get allowedBlockedRulesInfo =>
      'Toegelate/geblokkeerde reëls word gebruik om oproepe met spesifieke telefoonnommers te pas, wat die hoogste prioriteit het.';

  @override
  String get searchPhoneRulesHint => 'Soek telefoonreëls';

  @override
  String get phoneRulesInfo =>
      'Telefoonreëls word gebruik om oproepe met spesifieke telefoonnommers te pas, wat \'n laer prioriteit het. Sommige kom van die telefoonreël-inskrywings.';

  @override
  String get searchSubscriptionsHint => 'Soek inskrywings';

  @override
  String get searchPluginsHint => 'Soek plugins';

  @override
  String get searchLabelsHint => 'Soek etikette';

  @override
  String get pluginDescription => 'Plugin beskrywing';

  @override
  String get enterPluginDescription => 'Voer plugin beskrywing in';

  @override
  String get searchRegexRulesHint => 'Soek regex reëls';

  @override
  String get regexRulesInfo =>
      'Regex reëls word gebruik om oproepe te filter gebaseer op die Regex Patrone.';

  @override
  String get searchMarkedPhonesHint => 'Soek gemerkte nommers';

  @override
  String get searchContactSubscriptionsHint => 'Soek kontak inskrywings';

  @override
  String get showAllContacts => 'Wys Alle Kontakte';

  @override
  String get showFavorites => 'Wys Gunstelinge';

  @override
  String get manualEntry => 'Handleiding Invoer Inligting';

  @override
  String get scriptSaved => 'Skrif gestoor';

  @override
  String editScriptFor(String pluginName) {
    return 'Wysig skrif vir $pluginName';
  }

  @override
  String get saveScript => 'Stoor Skrif';

  @override
  String get testPlugin => 'Toets Plugin';

  @override
  String get description => 'Beskrywing';

  @override
  String get accessTargetUrl => 'Toegang tot Teiken URL';

  @override
  String get result => 'Resultaat';

  @override
  String get editScript => 'Wysig Skrif';

  @override
  String get numberFormat => 'Nommer Formaat';

  @override
  String get nationalNumber => 'Nasionale Nommer';

  @override
  String get e164Number => 'E164 Nommer';

  @override
  String get pluginRulesInfo =>
      'Vir veiligheid, gebruik asseblief slegs plugins van betroubare bronne. Voel vry om ons templates te gebruik om jou eie pasgemaakte plugins te skep!';

  @override
  String get advancedMode => 'Gevorderde Modus';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Voer asseblief ten minste een nommer in.';

  @override
  String get openInWebView => 'Maak oop in WebView';

  @override
  String get pluginLabel => 'Plugin Etiket';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Boodskap Agtergrond Kleur';

  @override
  String get clearAllCallLogs => 'Vee Alle Oproep Logs Uit';

  @override
  String get clearAllCallLogsConfirmation =>
      'Bevestig om alle oproep logs uit te vee';

  @override
  String get allCallLogsCleared => 'Alle oproep logs is uitgevee';

  @override
  String get unblocked => 'Ongeblokkeer';

  @override
  String get blockNumber => 'Blokkeer Nommer';

  @override
  String get blockNumberSuccess => 'Nommer suksesvol geblokkeer';

  @override
  String get blockNumberFailed => 'Blokkering van nommer het misluk';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Is jy seker jy wil $phoneNumber onblokkeer?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Roep $phoneNumber...';
  }

  @override
  String get viewDetails => 'Bekyk Besonderhede';

  @override
  String get unblock => 'Onblokkeer';

  @override
  String get unblockNumber => 'Onblokkeer Nommer';

  @override
  String get unblockNumberSuccess => 'Nommer suksesvol onblokkeer';

  @override
  String get unblockNumberFailed => 'Ontblokkering van nommer het misluk';

  @override
  String get serviceNotAvailable => 'Diens nie beskikbaar nie';

  @override
  String get callingNumberFailed => 'Roeping van nommer het misluk';

  @override
  String get listView => 'Lys Uitsig';

  @override
  String get timelineView => 'Tydlyn Uitsig';

  @override
  String get nameCannotBeEmpty => 'Naam kan nie leeg wees nie';

  @override
  String get selectAction => 'Kies die aksie';

  @override
  String get selectTargetService => 'Kies die teiken diens';

  @override
  String get callDetails => 'Oproep Besonderhede';

  @override
  String get callType => 'Oproep Tipe';

  @override
  String get callTime => 'Oproep Tyd';

  @override
  String get numberInvalidFormat => 'Nommer ongeldige formaat';

  @override
  String get membershipFeature => 'Lidmaatskap Funksie';

  @override
  String get medium => 'Medium';

  @override
  String get verificationReport => 'Verifikasie Verslag';

  @override
  String get finalRisk => 'Finale Risiko';

  @override
  String get simState => 'SIM Staat';

  @override
  String get ipCountry => 'IP Land';

  @override
  String get simCountry => 'SIM Land';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Nommer Pas';

  @override
  String get support => 'Ondersteuning';

  @override
  String get rewardedAdService => 'Beloonde Advertensie Diens';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Jy het reeds VIP voorregte (behalwe vir advertensies)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Jy het reeds tydelike voorregte, vervaldatum: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Jy moet nog $count advertensies kyk om tydelike VIP voorregte te kry';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Jy is toegeken $days dae van tydelike aankoop voorregte. Verval datum: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Tydelike aankoop voorreg het verval';

  @override
  String get loadingAd => 'Laai advertensie...';

  @override
  String get earnedTempVip => 'Verdien tydelike VIP';

  @override
  String get vipExchangeService => 'VIP Wissel Diens';

  @override
  String get marksInsufficient => 'Onvoldoende punte om te wissel';

  @override
  String get invalidExchangeRule => 'Ongeldige wisselreël';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Suksesvol gewissel vir $description, vervaldatum: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Wisseling het misluk: $error';
  }

  @override
  String get vip3DaysWithAds =>
      '3-dae VIP met advertensies (slegs sinkronisering)';

  @override
  String get vip5DaysNoAds => '5-dae vol-funksie advertensievrye VIP';

  @override
  String get vip7DaysNoAds => '7-dae vol-funksie advertensievrye VIP';

  @override
  String get noNotifications => 'Geen kennisgewings nie';

  @override
  String get clearAllNotifications => 'Vee Alle Kennisgewings Uit';

  @override
  String get clearAllNotificationsConfirmation =>
      'Bevestig om alle kennisgewings uit te vee';

  @override
  String get allNotificationsCleared => 'Alle kennisgewings skoongemaak';

  @override
  String get clearButton => 'Vee uit';

  @override
  String get justNow => 'Netnou';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minute gelede',
      one: '1 minuut gelede',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ure gelede',
      one: '1 uur gelede',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dae gelede',
      one: '1 dag gelede',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Gister';

  @override
  String get deletionProposal => 'Verwyderingsvoorstel';

  @override
  String get deletionProposals => 'Verwyderingsvoorstelle';

  @override
  String get createProposal => 'Skep Voorstel';

  @override
  String get createProposalTitle => 'Skep Verwyderingsvoorstel';

  @override
  String get reason => 'Rede';

  @override
  String get reasonOutdated => 'Verouderde Nommer';

  @override
  String get reasonPrivacy => 'Privaatheidskwessie';

  @override
  String get reasonNotInService => 'Nie in Diens nie';

  @override
  String get reasonWronglyIdentified => 'Verkeerdelik Geïdentifiseer';

  @override
  String get reasonInaccurateInfo => 'Onakkurate Inligting';

  @override
  String get reasonWrongMarked => 'Verkeerdelik Gemerk';

  @override
  String get reasonOther => 'Ander';

  @override
  String get submit => 'Dien in';

  @override
  String get cancel => 'Kanselleer';

  @override
  String get proposalStatus => 'Status';

  @override
  String get statusPending => 'Hangende';

  @override
  String get statusActive => 'Aktief';

  @override
  String get statusCompleted => 'Voltooi';

  @override
  String get statusExpired => 'Verval';

  @override
  String get riskLevel => 'Risikovlak';

  @override
  String get riskLevelVerified => 'Geverifieer';

  @override
  String get riskLevelLow => 'Laag';

  @override
  String get riskLevelHigh => 'Hoog';

  @override
  String get riskLevelUnknown => 'Onbekend';

  @override
  String get votingProgress => 'Stemprogressie';

  @override
  String agreeVotes(int count) {
    return 'Stemme saam: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Stemme teen: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Totaal: $count';
  }

  @override
  String get voteAgree => 'Stem saam';

  @override
  String get voteDisagree => 'Stem teen';

  @override
  String createdAt(String date) {
    return 'Geskep: $date';
  }

  @override
  String get showReport => 'Wys Verslag';

  @override
  String get hideReport => 'Versteek Verslag';

  @override
  String get proposalStatistics => 'Voorstellingstatistieke';

  @override
  String get totalProposals => 'Totaal Voorstelle';

  @override
  String get activeProposals => 'Aktiewe Voorstelle';

  @override
  String get completedProposals => 'Voltooide Voorstelle';

  @override
  String get myVotes => 'My Stemme';

  @override
  String get proposalCreated => 'Voorstel suksesvol geskep';

  @override
  String get proposalCreateFailed => 'Kon nie voorstel skep nie';

  @override
  String get voteSubmitted => 'Stem suksesvol ingedien';

  @override
  String get voteSubmitFailed => 'Kon nie stem indien nie';

  @override
  String get noProposalsFound => 'Geen voorstelle gevind nie';

  @override
  String get loadingProposals => 'Laai voorstelle...';

  @override
  String get refreshProposals => 'Verfris Voorstelle';

  @override
  String get totalPendingProposals => 'Totale Hangende Voorstelle';

  @override
  String get highRisk => 'Hoë Risiko';

  @override
  String get mediumRisk => 'Medium Risiko';

  @override
  String get lowRisk => 'Lae Risiko';

  @override
  String get communityImpact => 'Gemeenskapsimpak';

  @override
  String get criticalIssues => 'Kritiese Kwessies';

  @override
  String get communityParticipation => 'Gemeenskapsdeelname';

  @override
  String get noActivity => 'Geen Aktiwiteit nie';

  @override
  String get low => 'Laag';

  @override
  String get moderate => 'Matig';

  @override
  String get high => 'Hoog';

  @override
  String get veryHigh => 'Baie Hoog';

  @override
  String get voted => 'Gestem';

  @override
  String get communityVotes => 'Gemeenskapsstemme';

  @override
  String get waitingForMoreVotes => 'Wag vir meer gemeenskapsstemme';

  @override
  String get proposalProcessed => 'Hierdie voorstel is verwerk';

  @override
  String get supported => 'GESTEUEN';

  @override
  String get opposed => 'GEANTISEN';

  @override
  String get approved => 'GOEDGEKEUR';

  @override
  String get rejected => 'VERWERP';

  @override
  String get completed => 'VOLTOOI';

  @override
  String get pending => 'HANGENDE';

  @override
  String get critical => 'Krities';

  @override
  String get oppose => 'Teenstand';

  @override
  String get veryLow => 'Baie Laag';

  @override
  String get deletionProposalNotificationDescription =>
      'Kennisgewings oor verwyderingsvoorstel-stemresultate en opdaterings.';

  @override
  String get deletionProposalCreated => 'Verwyderingsvoorstel Geskep';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Jou verwyderingsvoorstel vir $phoneNumber is vir gemeenskapsbeoordeling ingedien.';
  }

  @override
  String get proposalApproved => 'Voorstel Goedgekeur ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Die verwyderingsvoorstel vir $phoneNumber is deur die gemeenskap goedgekeur ($supportPercentage% steun, $totalVotes stemme).';
  }

  @override
  String get proposalRejected => 'Voorstel Verwerp ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Die verwyderingsvoorstel vir $phoneNumber is deur die gemeenskap verwerp ($supportPercentage% steun, $totalVotes stemme).';
  }

  @override
  String get communityVotingStarted => 'Gemeenskapsstemming het Begin';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '\'n Nuwe verwyderingsvoorstel vir $phoneNumber is nou oop vir gemeenskapsstemming.';
  }

  @override
  String get votingCompleted => 'Stemming Voltooi';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Gemeenskapsstemming vir $phoneNumber het geëindig. Resultaat: $result ($supportPercentage% steun).';
  }

  @override
  String get newVoteReceived => 'Nuwe Stem Ontvang';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Iemand het gestem om $phoneNumber se verwydering te $voteType. Huidige stemme: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Kon nie stemtelling laai nie';

  @override
  String get voteCount => 'Stemtelling';

  @override
  String get deletionProposalInfo => 'Verwyderingsvoorstel Inligting';

  @override
  String get deletionProposalDescription =>
      'Stel nommers voor vir verwydering wat gemeenskapsriglyne oortree. Jou deelname help om die platform veilig te hou.';

  @override
  String get voteToEarnVip => 'Stem op voorstelle om VIP-voorregte te verdien!';

  @override
  String get voteFailed => 'Stem het misluk';

  @override
  String get searchProposals => 'Soek Voorstelle';

  @override
  String get defaultNotifications => 'Verstek Kennisgewings';

  @override
  String get defaultNotificationsDescription =>
      'Verstek kennisgewingskanaal vir die toepassing.';

  @override
  String get blockedCallNotifications => 'Geblokkeerde Bel Kennisgewings';

  @override
  String get blockedCallNotificationsDescription =>
      'Vertoon inligting oor geblokkeerde oproepe.';

  @override
  String get stirVerification => 'STIR/SHAKEN Verifikasie';

  @override
  String get stirVerificationDescription =>
      'Vertoon STIR/SHAKEN verifikasieresultate vir nommers.';

  @override
  String get fraudAlerts => 'Bedrogwaarskuwings';

  @override
  String get fraudAlertsDescription =>
      'Vertoon waarskuwings vir moontlike bedrieglike oproepe.';

  @override
  String get notificationFrequencyDescription =>
      'Kies hoe gereeld jy kennisgewings oor nuwe skrapingsvoorstelle ontvang. Jy kan dit onmiddellik, in bondels, of teen \'n pasgemaakte interval ontvang.';

  @override
  String get immediateNotifications => 'Onmiddellik';

  @override
  String get immediateNotificationsDescription =>
      'Ontvang \'n kennisgewing sodra \'n voorstel geskep word.';

  @override
  String get batchNotifications => 'Bondels';

  @override
  String get batchNotificationsDescription =>
      'Ontvang \'n opsomming van kennisgewings periodiek.';

  @override
  String get customNotifications => 'Pasgemaak';

  @override
  String get customNotificationsDescription =>
      'Definieer jou eie interval vir die ontvangs van kennisgewings.';

  @override
  String get customFrequency => 'Pasgemaakte Frekwensie';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours h';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get pendingProposals => 'Hangende Voorstelle';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hangende voorstelle',
      one: '1 hangende voorstel',
      zero: 'geen hangende voorstelle',
    );
    return 'Jy het $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Riglyne';

  @override
  String get reportingGuidelines =>
      '• Rapporteer slegs nommers wat werklik problematies is\n• Verskaf akkurate en gedetailleerde redes\n• Kies die toepaslike risikovlak gebaseer op erns\n• Vals verslae kan lei tot rekeningbeperkings';

  @override
  String get riskLevelLabel => 'Risikovlak';

  @override
  String get riskLevelDescription => 'Risikovlak van die nommer';

  @override
  String get phoneNumberMinDigits =>
      'Telefoonnommer moet ten minste 7 syfers lank wees';

  @override
  String get provideDetailedExplanation =>
      'Verskaf \'n gedetailleerde verduideliking (minimum 10 karakters)';

  @override
  String get reasonMinCharacters =>
      'Rede moet ten minste 10 karakters lank wees';

  @override
  String get countryCodeTwoLetters => 'Landkode (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Landkode (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'bv. VS, CN, GB';

  @override
  String get countryCodeRequired => 'Landkode is verpligtend';

  @override
  String get countryCodeLengthError => 'Landkode moet 2 letters lank wees';

  @override
  String get phoneNumberLengthError =>
      'Telefoonnommer moet ten minste 7 syfers lank wees';

  @override
  String get reasonHint =>
      'Verskaf gedetailleerde verduideliking (minimum 10 karakters)';

  @override
  String get reasonRequired => 'Rede is verpligtend';

  @override
  String get reasonLengthError => 'Rede moet ten minste 10 karakters lank wees';

  @override
  String get guidelinesTitle => 'Riglyne';

  @override
  String get guidelinesText =>
      '• Rapporteer slegs nommers wat werklik problematies is\n• Verskaf akkurate en gedetailleerde redes\n• Kies die toepaslike risikovlak gebaseer op erns\n• Vals verslae kan lei tot rekeningbeperkings';

  @override
  String get riskLevelCritical => 'Krities';

  @override
  String get riskLevelMedium => 'Medium';

  @override
  String get riskLevelVeryLow => 'Baie Laag';

  @override
  String get riskDescriptionVeryLow =>
      'Baie Laag - Klein ergernis, seldsame oproepe';

  @override
  String get riskDescriptionLow => 'Laag - Af en toe ongewenste oproepe';

  @override
  String get riskDescriptionMedium =>
      'Medium - Gereelde strooipos of telebemarking';

  @override
  String get riskDescriptionHigh =>
      'Hoog - Aanhoudende teistering of bedrogpogings';

  @override
  String get riskDescriptionCritical =>
      'Krities - Gevaarlike bedrogspulle of dreigemente';

  @override
  String get notificationFrequencyTitle => 'Kennisgewingfrekwensie';

  @override
  String get notificationFrequencyLabel => 'Kennisgewingfrekwensie (ure)';

  @override
  String errorMessage(String error) {
    return 'Fout: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Stemme: $totalVotes ($supportPercentage% ondersteuning)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Ondersteuning ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Teenkanting ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Netnou';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m gelede';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}h gelede';
  }

  @override
  String timeDaysAgo(int days) {
    return '${days}d gelede';
  }

  @override
  String get notificationFrequencyHours => 'Kennisgewingfrekwensie (Ure)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes stemme ($supportPercentage% ondersteuning)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ure',
      one: '1 uur',
      zero: '0 ure',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Belangrike Kennisgewing';

  @override
  String get dataSourceDisclaimer =>
      'Nommers word verkry uit die internet en gebruikerinskrywings. Ons kan nie waarborg dat \'n nommer, sodra dit geskrap is, nie deur ander gebruikers of bronne weer ingedien sal word nie. Soek asseblief aktief en verifieer inligting.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Ligging';

  @override
  String get simCardTitle => 'SIM-kaart';

  @override
  String get liveActivitiesSettingsTitle =>
      'Regstreekse Aktiwiteite-instellings';

  @override
  String get elementsSettingsTitle => 'Elemente-instellings';

  @override
  String get liveActivityMode => 'Regstreekse Aktiwiteit';

  @override
  String get liveActivityModeDescription =>
      'Vertoon oproepinligting as \'n aanhoudende kennisgewing op die sluitskerm en in die Dinamiese Eiland (iOS).';

  @override
  String get phoneNumberType => 'Telefoonnommertipe';

  @override
  String get liveActivitiesTestEndActivity => 'Beëindig Aktiwiteit';

  @override
  String get liveActivitiesTestSendNewActivity => 'Stuur Nuwe Aktiwiteit';

  @override
  String get liveActivitiesTestUpdateActivity => 'Dateer Aktiwiteit Op';

  @override
  String get liveActivityControlsTitle => 'Regstreekse Aktiwiteitkontroles';

  @override
  String get liveActivitiesTestTitle => 'Regstreekse Aktiwiteite Toets';

  @override
  String get liveActivitiesTestSubtitle =>
      'Toets die regstreekse aktiwiteit Kennisgewing.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Regstreekse Kennisgewingaanpassing';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Pas die voorkoms van regstreekse kennisgewings aan.';

  @override
  String get notification_instructions =>
      'Instruksies:\n1. Tik \"STUUR\" om \'n kennisgewing te skep of op te dateer.\n2. Gaan na jou tuisskerm of trek die kennisgewinglaai af om die resultaat te sien.\n3. Tik \"BEËINDIG\" om die kennisgewing weg te wys.';

  @override
  String get autoCancelNotification => 'Outo Kanselleer Kennisgewing';

  @override
  String get autoCancelNotificationDescription =>
      'Indien gemerk, sal die kennisgewing outomaties weggewys word wanneer die gebruiker daarop tik.';

  @override
  String get setDelayTime => 'Stel Vertragingstyd';

  @override
  String get proposalDetails => 'Voorstelbesonderhede';

  @override
  String get filterByStatus => 'Filter volgens Status';

  @override
  String get proposalNotFound => 'Voorstel nie gevind nie';

  @override
  String get processed => 'Verwerk';

  @override
  String get showAll => 'Wys Alles';

  @override
  String get filterAndSortTitle => 'Filter en Sorteer';

  @override
  String get filterVerifiedOwner => 'Filter Geverifieerde Eienaar';

  @override
  String get filterBy => 'Filter Volgens';

  @override
  String get sortOldest => 'Sorteer Oudste';

  @override
  String get sortNewest => 'Sorteer Nuutste';

  @override
  String get sortMostPopular => 'Sorteer Mees Populêre';

  @override
  String get sortLeastPopular => 'Sorteer Minste Populêre';

  @override
  String get sortBy => 'Sorteer Volgens';

  @override
  String get simRulesNotFound => 'SIM-reëls nie gevind nie';

  @override
  String get simSlotRules => 'SIM-gleufreëls';

  @override
  String get noSimCardDetected => 'Geen SIM-kaart opgespoor nie';

  @override
  String get invalidSimData => 'Ongeldige SIM-data';

  @override
  String get simCardData => 'SIM-kaartdata';

  @override
  String get simSlot => 'SIM-gleuf';

  @override
  String get enableFiltering => 'Aktiveer Filtering';

  @override
  String get detailedSettingsTitle => 'Gedetailleerde Instellings';

  @override
  String get entryPointViewTitle => 'Ingangspunt Uitsig';

  @override
  String get callTypeRejected => 'Verwerp';

  @override
  String get callTypeSilenced => 'Gedemp';

  @override
  String get callTypeVoicemail => 'Stemboodskap';

  @override
  String get callTypeUnknownIntercept => 'Onbekende onderskep';

  @override
  String andMoreItems(int count) {
    return 'en $count meer items';
  }

  @override
  String get ruleType => 'Rule Type';
}
