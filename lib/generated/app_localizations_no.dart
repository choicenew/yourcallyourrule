// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get aboutContactSubscription => 'Om kontaktabonnement';

  @override
  String get aboutLabels => 'Om etiketter';

  @override
  String get aboutPhoneSubscriptionRules => 'Om telefonabonnementsregler';

  @override
  String get aboutPhoneSubscriptions => 'Om telefonabonnementer';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Abonner på telefonregelister via URL, oppdater regler automatisk. Støtter JSON, CSV-format regel-filer.';

  @override
  String get aboutSmsFilter => 'Om SMS-filtrering';

  @override
  String get aboutSmsSubscriptionRules => 'Om SMS-abonnementsregler';

  @override
  String get aboutSubtitle => 'Applikasjonsversjon og juridisk informasjon';

  @override
  String get aboutTitle => 'Om';

  @override
  String get action => 'Handling';

  @override
  String get actionAll => 'Alle';

  @override
  String get actionAllow => 'Tillat';

  @override
  String get actionBlock => 'Blokker';

  @override
  String get actionFilterAll => 'Alle filtre';

  @override
  String get actionFilterTitle => 'Filtrer etter handlingstype';

  @override
  String get actionFilterTooltip => 'Handlingsfilter';

  @override
  String get actionNone => 'Ingen handling';

  @override
  String get actionSilence => 'Stillhet';

  @override
  String actionTag(Object actionType) {
    return 'Handling: $actionType';
  }

  @override
  String get actionType => 'Handlingstype';

  @override
  String get actionUnknown => 'Ukjent';

  @override
  String get add => 'Legg til';

  @override
  String get addAllowedBlockedRule => 'Legg til tillat/blokker-regel';

  @override
  String get addAllowSubscription => 'Legg til tillat-abonnement';

  @override
  String get addBlockSubscription => 'Legg til blokker-abonnement';

  @override
  String get addContactButton => 'Legg til kontakt';

  @override
  String addContactFailed(Object error) {
    return 'Kunne ikke legge til kontakt: $error';
  }

  @override
  String get addedToAllowedRules => 'Lagt til i tillatte regler';

  @override
  String get addedToBlacklist => 'Lagt til i svartelisten';

  @override
  String get addedToBlockedRules => 'Lagt til i blokkerte regler';

  @override
  String get addedToFavoriteContacts => 'Lagt til i favorittkontakter';

  @override
  String get addedToFavorites => 'Lagt til i favoritter';

  @override
  String get addedToWhitelist => 'Lagt til i hvitelisten';

  @override
  String get addFavorite => 'Legg til favoritt';

  @override
  String get addFilter => 'Legg til filter';

  @override
  String get addLabel => 'Legg til etikett';

  @override
  String get addLabelButton => 'Legg til etikett';

  @override
  String addLabelFailed(Object error) {
    return 'Kunne ikke legge til etikett: $error';
  }

  @override
  String get addLabelToCall => 'Legg til etikett i samtaleoppføring';

  @override
  String get addName => 'Legg til navn';

  @override
  String get addNoneSubscription => 'Legg til ingen-abonnement';

  @override
  String get addOrEditContactInfo =>
      'Brukes til å legge til eller redigere kontaktinformasjon';

  @override
  String get addPhoneMark => 'Legg til telefonmerke';

  @override
  String get addPhoneNumberRule => 'Legg til telefonnummerregel';

  @override
  String get addPlugin => 'Legg til plugin';

  @override
  String get addPluginFailed => 'Kunne ikke legge til plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Kunne ikke legge til plugin: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Legg til plugin fra lokal fil';

  @override
  String get addPluginFromUrl => 'Legg til plugin fra URL';

  @override
  String get addRegexRule => 'Legg til Regex-regel';

  @override
  String get addRule => 'Legg til regel';

  @override
  String get addRuleButton => 'Legg til regel';

  @override
  String addRuleFailed(Object error) {
    return 'Kunne ikke legge til regel: $error';
  }

  @override
  String get addRuleTooltip => 'Legg til regel';

  @override
  String get addSilenceSubscription => 'Legg til stillhets-abonnement';

  @override
  String get addSimRuleButton => 'Legg til SIM-regel';

  @override
  String get addSmsFilterRule => 'Legg til SMS-filterregel';

  @override
  String get addSmsRule => 'Legg til SMS-regel';

  @override
  String get addSmsSubscription => 'Legg til SMS-abonnement';

  @override
  String get addSubscription => 'Legg til abonnement';

  @override
  String get addSubscriptionButton => 'Legg til abonnement';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Kunne ikke legge til abonnement: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Legg til abonnement';

  @override
  String get addToAllowedRules => 'Legg til i tillatte regler';

  @override
  String get addToBlacklist => 'Legg til i svartelisten';

  @override
  String get addToBlockedRules => 'Legg til i blokkerte regler';

  @override
  String get addToFavoriteContacts => 'Legg til i favorittkontakter';

  @override
  String get addToFavorites => 'Legg til i favoritter';

  @override
  String get addToRules => 'Legg til i regler';

  @override
  String get addToWhitelist => 'Legg til i hvitelisten';

  @override
  String get adPlaceholder => 'Annonsesplassholder';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Alle';

  @override
  String get allCallsTab => 'Alle';

  @override
  String get allDataClearedSuccessfully => 'Alle data er slettet vellykket';

  @override
  String get allow => 'Tillat';

  @override
  String get allowAllAllowRules => 'Tillat alle tillat-regler';

  @override
  String get allowAllAllowRulesDesc => 'Tillat samtaler fra tillat-regler';

  @override
  String get allowAllBlacklistedNumbers => 'Tillat alle svartelistede numre';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'Tillat samtaler fra svartelisten';

  @override
  String get allowAllBlockRules => 'Tillat alle blokker-regler';

  @override
  String get allowAllBlockRulesDesc => 'Tillat samtaler fra blokkeringsregler';

  @override
  String get allowAllowedNumbers => 'Tillat tillatte numre';

  @override
  String get allowAllowedNumbersDesc => 'Tillat samtaler fra tillat-listen';

  @override
  String get allowBlock => 'Tillat/blokker';

  @override
  String get allowBlockedNumbers => 'Tillat blokkerte numre';

  @override
  String get allowBlockedNumbersDesc => 'Tillat samtaler fra blokkeringslisten';

  @override
  String get allowedBlockedRule => 'Tillat/blokker-regel';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Rediger tillat/blokker-regel';

  @override
  String get allowedBlockedRuleManagement =>
      'Håndtering av tillat/blokker-regler';

  @override
  String get allowNonExceededNumbers =>
      'Tillat numre som ikke overskrider grensen';

  @override
  String get allowNonExceededNumbersDescription =>
      'Tillat automatisk numre som ikke overskrider antallgrensen';

  @override
  String get allowRegexAllowRules => 'Tillat Regex-tillat-regler';

  @override
  String get allowRegexAllowRulesDesc =>
      'Aktiver regulære uttrykk for tillat-regler';

  @override
  String get allowRegexAllowRulesDescription =>
      'Aktiver regulære uttrykk-baserte tillat-regler';

  @override
  String get allowRegexBlockRules => 'Tillat Regex-blokker-regler';

  @override
  String get allowRegexBlockRulesDesc =>
      'Aktiver regulære uttrykk for blokker-regler';

  @override
  String get allowRegexBlockRulesDescription =>
      'Aktiver regulære uttrykk-baserte blokker-regler';

  @override
  String get allowRule => 'Tillat-regel';

  @override
  String get allowRules => 'Tillat-regler';

  @override
  String get allowWhitelistedNumbers => 'Tillat hviteliste-numre';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Tillat alle numre på hvitelisten';

  @override
  String get allPermissionsGranted => 'Alle tillatelser er gitt';

  @override
  String get allSettingsCompleted => 'Alle innstillinger er fullført.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Alle oppdateringer fullført ($count regler)';
  }

  @override
  String get answerThenHangup => 'Svar og legg på';

  @override
  String get appLegalese =>
      '© 2023 Your Call Your Rule. Alle rettigheter reservert.';

  @override
  String get applicationSoftware => 'Applikasjonsprogramvare';

  @override
  String get apply => 'Bruk';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Autorisasjon mislyktes: Vennligst sjekk klient-ID og nøkkel';

  @override
  String get authorizationFailedMessage => 'Autorisasjon mislyktes';

  @override
  String get authorizationSuccessMessage => 'Autorisasjon vellykket';

  @override
  String get authorizeLoginButton => 'Autoriser innlogging';

  @override
  String get automotiveIndustry => 'Bilindustrien';

  @override
  String get autoSyncLabel => 'Automatisk synkronisering';

  @override
  String get autoUpdate => 'Automatisk oppdatering';

  @override
  String get autoUpdateDescription =>
      'Sett intervaller for automatisk oppdatering av abonnementer eller oppdater manuelt';

  @override
  String get autoUpdateSettings => 'Innstillinger for automatisk oppdatering';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Administrer automatiske oppdateringer for regler og tillegg';

  @override
  String get autoUpdateSettingsTitle =>
      'Innstillinger for automatisk oppdatering';

  @override
  String get autoUpdateSubtitle =>
      'Administrer automatiske oppdateringer for regler og tillegg';

  @override
  String get autoUpdateTitle => 'Automatisk oppdatering';

  @override
  String get avatarBorderColor => 'Farge på avatar-kantlinje';

  @override
  String get avatarBorderSize => 'Tykkelse på avatar-kantlinje';

  @override
  String get avatarIconSizesSetting => 'Størrelser på avatar og ikoner';

  @override
  String get avatarPosition => 'Posisjon på avatar';

  @override
  String get avatarSize => 'Størrelse på avatar';

  @override
  String axisPosition(Object axis) {
    return 'Posisjon for $axis';
  }

  @override
  String get backgroundGradientSetting => 'Bakgrunnsgradient';

  @override
  String get backup => 'Sikkerhetskopiering';

  @override
  String get backupAndRestore => 'Sikkerhetskopiering og gjenoppretting';

  @override
  String get backupAndRestoreSubtitle =>
      'Sikkerhetskopier eller gjenopprett applikasjonsdata';

  @override
  String get backupAndRestoreTitle => 'Sikkerhetskopiering og gjenoppretting';

  @override
  String get backupFailed => 'Sikkerhetskopiering mislyktes';

  @override
  String get backupFailedMessage => 'Sikkerhetskopiering mislyktes';

  @override
  String backupFailedWithError(Object error) {
    return 'Sikkerhetskopiering mislyktes: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'Sikkerhetskopier eller gjenopprett applikasjonsdata';

  @override
  String get backupRestoreTitle => 'Sikkerhetskopiering og gjenoppretting';

  @override
  String get backupSectionTitle => 'Sikkerhetskopiering';

  @override
  String get backupSettings => 'Innstillinger for sikkerhetskopiering';

  @override
  String get backupSettingsDialogTitle =>
      'Innstillinger for sikkerhetskopiering';

  @override
  String get backupSettingsTitle => 'Innstillinger for sikkerhetskopiering';

  @override
  String get backupSuccessMessage => 'Vellykket sikkerhetskopiert til skyen';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Sikkerhetskopiering vellykket til: $path';
  }

  @override
  String get backupToCloud => 'Sikkerhetskopier til skyen';

  @override
  String get backupToCloudDescription =>
      'Sikkerhetskopier innstillinger og regler til skylagring';

  @override
  String backupToCloudFailed(Object error) {
    return 'Kunne ikke sikkerhetskopiere til skyen: $error';
  }

  @override
  String get backupToCloudLabel => 'Sikkerhetskopier til skyen';

  @override
  String get backupToCloudSuccess => 'Vellykket sikkerhetskopiert til skyen';

  @override
  String get backupToCloudTitle => 'Sikkerhetskopier til skyen';

  @override
  String get backupToLocalLabel => 'Sikkerhetskopier lokalt';

  @override
  String get bank => 'Bank';

  @override
  String get basicInfo => 'Grunnleggende informasjon';

  @override
  String get basicRuleFilter => 'Grunnleggende regel-filter';

  @override
  String get basicRuleFiltering => 'Grunnleggende regel-filtrering';

  @override
  String get basicRuleFilteringExplanation =>
      '• Grunnleggende regel-filtrering: Filtrer regler basert på svarteliste, hviteliste og regulære uttrykk';

  @override
  String get basicRuleFilterSettings =>
      'Innstillinger for grunnleggende regel-filter';

  @override
  String get basicRuleFilterSubtitle =>
      'Filtrer samtaler ved hjelp av svarteliste/hviteliste og regulære uttrykk';

  @override
  String get batchDeleteContacts => 'Masse sletting av kontakter';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Er du sikker på at du vil slette $count valgte kontakter?';
  }

  @override
  String get batchDeleteFailed => 'Masse sletting mislyktes';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Er du sikker på at du vil slette $count etiketter?';
  }

  @override
  String get blacklist => 'Svarteliste';

  @override
  String get blacklistingAndWhitelisting => 'Svartelisting og hvitelisting';

  @override
  String get blacklistLabel => 'Svarteliste';

  @override
  String get blackWhiteList => 'Svart-/hviteliste';

  @override
  String get block => 'Blokker';

  @override
  String get blockCalls => 'Blokker samtaler';

  @override
  String get blocked => 'Blokkert';

  @override
  String get blockedCallAction => 'Handlinger ved blokkert samtale';

  @override
  String get blockedCalls => 'Blokkerte samtaler';

  @override
  String get blockedCallsTitle => 'Blokkerte samtaler';

  @override
  String get blockedCommunications => 'Blokkert kommunikasjon';

  @override
  String get blockedPhoneLabel => 'Blokkerte samtaler';

  @override
  String get blockedSpamCalls => 'Blokkerte spam-samtaler';

  @override
  String get blockingTrend => 'Blokkerings-trend';

  @override
  String get blockInternationalCalls =>
      'matcher numre som ikke starter med + eller 00';

  @override
  String get blockInternationalCallsTitle => 'Blokker internasjonale numre';

  @override
  String get blockLandlineNumbersTitle => 'Blokker fasttelefon-numre';

  @override
  String get blockMobileNumbers => 'matcher numre som ikke starter med 13-19';

  @override
  String get blockMobileNumbersTitle => 'Blokker mobil-numre';

  @override
  String get blockPremiumRateNumbers =>
      'matcher numre som ikke starter med 118 eller 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'Blokker numre med spesialpriser';

  @override
  String get blockRule => 'Blokkeringsregel';

  @override
  String get blockRules => 'Blokkeringsregler';

  @override
  String get blockSpecificAreaCodes =>
      'matcher numre som starter med 0 + 2-3 sifre';

  @override
  String get blockSpecificAreaCodesTitle => 'Blokker spesifikke retningsnumre:';

  @override
  String get blockTypeAnalysisTitle => 'Analyse av blokkeringstype';

  @override
  String get both => 'Begge';

  @override
  String get bulkDelete => 'Masse sletting av kontakter';

  @override
  String get bulkDeleteContacts => 'Masse sletting av kontakter';

  @override
  String get bulkDeleteLabels => 'Masse sletting av etiketter';

  @override
  String get call => 'Samtale';

  @override
  String get callback => 'Tilbake-ring';

  @override
  String callbackTo(String number) {
    return 'Ring tilbake til $number';
  }

  @override
  String get callBlocking => 'Samtaleblokkering';

  @override
  String get callerIdApp => 'Oppringer-ID-app';

  @override
  String get callerIdCustomizationTitle => 'Tilpass oppringer-ID';

  @override
  String get callerIdDialogTitle => 'Oppringer-ID-informasjon';

  @override
  String get callerIdDisplayMode => 'Visningsmodus for anrops-ID';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Markert av $count';
  }

  @override
  String get callerIdPreview => 'Forhåndsvisning av anrops-ID';

  @override
  String get callFilter => 'Anropsfilter';

  @override
  String get callFilterDescription =>
      'Når aktivert, sjekkes innkommende anrop mot regelisten nedenfor. Anropsfiltreringsregler synkroniseres ikke mellom enheter som standard.';

  @override
  String get callFilterRules => 'Anropsfilterregler';

  @override
  String get callFilterRulesDescription =>
      'Sett grunnleggende regler for anropsfiltrering';

  @override
  String get callFilterSettings => 'Anropsfilterinnstillinger';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Still inn grenser for anropsfrekvens og blokkeringsregler';

  @override
  String get callFrequencyInterceptionTitle => 'Oppfangning av anropsfrekvens';

  @override
  String get callHistory => 'Anropshistorikk';

  @override
  String get callHistoryInfoDesc =>
      'Her vises anropshistorikken din, inkludert innkommende, utgående og tapte anrop.';

  @override
  String get callHistoryInfoTitle => 'Anropshistorikk';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Kunne ikke initialisere anropshistorikk: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Kunne ikke oppdatere anropshistorikk: $error';
  }

  @override
  String get callHistoryTab => 'Anropshistorikk';

  @override
  String get callHistoryTimelineEarlier => 'Tidligere';

  @override
  String get callHistoryTimelineToday => 'I dag';

  @override
  String get callHistoryTimelineYesterday => 'I går';

  @override
  String get callScreeningPermission => 'Tillatelse for anropsscreening';

  @override
  String get callScreeningPermissionDescription =>
      'Brukes til å screene og blokkere spam-anrop.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Tillatelse for anropsscreening ikke gitt, kan påvirke app-funksjonalitet.';

  @override
  String get callSettingsSubtitle =>
      'Innstillinger for anrops-ID, filtrering og blokkering';

  @override
  String get callSettingsTitle => 'Anropsinnstillinger';

  @override
  String get callStatistics => 'Anropsstatistikk';

  @override
  String get callTypeAnswered => 'Besvart';

  @override
  String get callTypeBlocked => 'Blokkert';

  @override
  String get callTypeIconColor => 'Farge på anropstypeikon';

  @override
  String get callTypeMissed => 'Tapt anrop';

  @override
  String get callTypeOutgoing => 'Utgående';

  @override
  String get callTypePosition => 'Posisjon for anropstype';

  @override
  String get callTypeUnknown => 'Ukjent';

  @override
  String get cancelButton => 'Avbryt';

  @override
  String get carRental => 'Leiebil';

  @override
  String get carrier => 'Operatør';

  @override
  String get carrierColor => 'Operatørfarge';

  @override
  String get carrierFontSize => 'Operatør skriftstørrelse';

  @override
  String get carrierPosition => 'Operatørposisjon';

  @override
  String get changeLabel => 'Endre etikett';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Kunne ikke endre plugin-status: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Kunne ikke endre abonnementsstatus: $error';
  }

  @override
  String get changeTag => 'Endre tagg';

  @override
  String get charity => 'Veldedighet';

  @override
  String chartMonthFormat(int month) {
    return 'Måned $month';
  }

  @override
  String get chartOneDayAgo => '1 dag siden';

  @override
  String get chartOneMonthAgo => '1 måned siden';

  @override
  String get chartOneWeekAgo => '1 uke siden';

  @override
  String get chartTenDaysAgo => '10 dager siden';

  @override
  String get chartThreeDaysAgo => '3 dager siden';

  @override
  String get chartToday => 'I dag';

  @override
  String get checkFileFormat => 'Vennligst sjekk filformat eller tillatelser';

  @override
  String checkPermissionFailed(Object error) {
    return 'Kunne ikke sjekke tillatelser: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Velg standard oppfangningshandling';

  @override
  String get clearAllData => 'Slett alle data';

  @override
  String get clearAllDataConfirmation =>
      'Er du sikker på at du vil slette alle applikasjonsdata? Denne handlingen kan ikke angres.';

  @override
  String get clearAllDataDescription => 'Slett alle applikasjonsdata';

  @override
  String get clearAllDataLabel => 'Slett alle data';

  @override
  String get clearFilter => 'Fjern filter';

  @override
  String get clearLabelFilter => 'Fjern etikettfilter';

  @override
  String get clearLabelFilterButton => 'Fjern etikettfilter';

  @override
  String get closeButton => 'Lukk';

  @override
  String get cloudSync => 'Skysynkronisering';

  @override
  String get cloudSyncAndBackupTitle =>
      'Skysynkronisering og sikkerhetskopiering';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Konfigurer WebDAV, OneDrive og Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Innstillinger for skysynkronisering';

  @override
  String get cloudSyncTitle => 'Skysynkronisering';

  @override
  String get collapseLabelSelector => 'Lukk etikettvelger';

  @override
  String get collection => 'Inkasso';

  @override
  String get colorPickerTitle => 'Velg farge';

  @override
  String get configManagement => 'Konfigurasjonsadministrasjon';

  @override
  String get configUpdated => 'Konfigurasjon oppdatert';

  @override
  String get configurationAdvice =>
      'Gjennom riktig konfigurasjon kan du sette forskjellige filtreringsstrategier for jobb- og personlige SIM-kort.';

  @override
  String get configureBackupOptions =>
      'Konfigurer sikkerhetskopieringsalternativer';

  @override
  String get configureBackupOptionsSubtitle =>
      'Konfigurer sikkerhetskopieringsalternativer';

  @override
  String get configureCloudSyncService =>
      'Konfigurer skysynkroniseringstjeneste';

  @override
  String get configureCloudSyncServiceHint =>
      'Vennligst konfigurer en skysynkroniseringstjeneste for å aktivere synkronisering mellom flere enheter.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Vennligst konfigurer en skysynkroniseringstjeneste for å aktivere synkronisering mellom flere enheter.';

  @override
  String get configureSimCardFilterRules => 'Konfigurer SIM-kortfilterregler';

  @override
  String get configureSyncServiceHint =>
      'Vennligst konfigurer synkroniseringstjeneste i skysynkroniseringsinnstillinger først';

  @override
  String get confirm => 'Bekreft';

  @override
  String get confirmBatchDeleteContacts =>
      'Er du sikker på at du vil slette de valgte';

  @override
  String get confirmButton => 'Bekreft';

  @override
  String get confirmDelete => 'Bekreft sletting';

  @override
  String get confirmDeleteContact => 'Er du sikker på at du vil slette';

  @override
  String get confirmDeleteContactName => 'Bekreft sletting?';

  @override
  String get confirmDeleteFilter =>
      'Er du sikker på at du vil slette dette filteret?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Er du sikker på at du vil slette etiketten \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Er du sikker på at du vil slette plugin-en \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Er du sikker på at du vil slette $count plugins?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Er du sikker på at du vil slette denne regelen? Denne handlingen kan ikke angres.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Er du sikker på at du vil slette de valgte kontaktene?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Er du sikker på at du vil slette denne SMS-filterregelen?';

  @override
  String get confirmDeleteSmsRule =>
      'Er du sikker på at du vil slette denne SMS-regelen?';

  @override
  String get confirmDeleteSubscription =>
      'Er du sikker på at du vil slette dette abonnementet?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Er du sikker på at du vil slette $name?';
  }

  @override
  String get confirmPassword => 'Bekreft passord';

  @override
  String get confirmPasswordLabel => 'Bekreft passord';

  @override
  String get connectedStatus => 'Tilkoblet';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Tilkobling mislyktes: Vennligst sjekk serveradresse, brukernavn og passord';

  @override
  String get connectionFailedMessage => 'Tilkobling mislyktes';

  @override
  String get connectionStatusLabel => 'Tilkoblingsstatus';

  @override
  String get connectionSuccessMessage => 'Tilkobling vellykket';

  @override
  String get contactAddSuccess => 'Kontakt lagt til vellykket';

  @override
  String get contactDeleted => 'Kontakt slettet';

  @override
  String get contactEditDialog => 'Redigeringsdialog for kontakt';

  @override
  String get contactNameHint => 'Skriv inn kontaktnavn (valgfritt)';

  @override
  String get contactNameLabel => 'Navn';

  @override
  String get contactNameOptional => 'Kontaktnavn (valgfritt)';

  @override
  String get contactNotFound => 'Kontakt ikke funnet';

  @override
  String get contacts => 'Kontakter';

  @override
  String contactsDeleted(Object count) {
    return 'Slettet $count kontakter';
  }

  @override
  String get contactSettingsSubtitle =>
      'Kontaktadministrasjon og etikettinnstillinger';

  @override
  String get contactSettingsTitle => 'Kontaktinnstillinger';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Kunne ikke laste kontakter: $error';
  }

  @override
  String get contactsManagement => 'Kontaktadministrasjon';

  @override
  String get contactsManagementPageTitle => 'Kontakter Administrasjonsside';

  @override
  String get contactsPageTitle => 'Kontakter Administrasjonsside';

  @override
  String get contactsPermission => 'Kontakttillatelse';

  @override
  String get contactsPermissionDescription =>
      'Brukes til å identifisere kontaktanrop.';

  @override
  String get contactsTab => 'Kontakter';

  @override
  String get contactSubscriptionDescription =>
      'Abonner på kontaktlister via URL, oppdater kontaktinformasjon og etiketter automatisk. Støtter data i JSON-format.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Kunne ikke laste kontaktabonnementer: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Kontaktabonnementer';

  @override
  String get contactUpdateSuccess => 'Kontakt oppdatert vellykket';

  @override
  String get contactUs => 'Kontakt oss';

  @override
  String get content => 'Innhold';

  @override
  String get contentRegex => 'Innholds-regex';

  @override
  String get countColor => 'Antall farge';

  @override
  String get countFontSize => 'Antall skriftstørrelse';

  @override
  String get countPosition => 'Antall posisjon';

  @override
  String get country => 'Land';

  @override
  String get countryNameColor => 'Landnavnfarge';

  @override
  String get countryNameFontSize => 'Landnavnskriftstørrelse';

  @override
  String get countryRegionNamePosition => 'Land/Region-navn posisjon';

  @override
  String get countrySelectionDialog => 'Landvalgdialog';

  @override
  String get countrySelectionDialogDescription =>
      'Brukes til å velge et land for å spørre om oppringer-ID-informasjon';

  @override
  String get countThresholdDescription =>
      'Still inn minimum antall terskel som kreves for å utløse filtreringshandlinger';

  @override
  String get countThresholdLabel => 'Antall terskel';

  @override
  String get countThresholdSettings => 'Antall terskelinnstillinger';

  @override
  String countThresholdValue(Object count) {
    return 'Antall terskel: $count';
  }

  @override
  String get createdRules => 'Opprettede regler';

  @override
  String get csvFormat => 'CSV-format';

  @override
  String get currentDeviceChip => 'Nåværende';

  @override
  String get currentDeviceLabel => 'Nåværende enhets etikett';

  @override
  String get currentDeviceTitle => 'Nåværende enhet';

  @override
  String get currentLabels => 'Nåværende etiketter:';

  @override
  String get currentLanguage => 'Nåværende språk';

  @override
  String get currentPasswordLabel => 'Nåværende passord';

  @override
  String get customerService => 'Kundeservice';

  @override
  String get customRange => 'Egendefinert område';

  @override
  String get dailyStatistics => 'Daglige statistikker';

  @override
  String get dailyStatisticsDesc =>
      'Motta daglige statistikker om blokkerte samtaler og meldinger';

  @override
  String get dashboardTab => 'Dashbord';

  @override
  String get dataAnalysis => 'Dataanalyse';

  @override
  String get dataAnalysisDashboardPage => 'Dataanalyse Dashbordside';

  @override
  String get dataExport => 'Dataeksport';

  @override
  String dataLoadFailure(Object error) {
    return 'Data lasting mislyktes: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Kunne ikke laste data: $error';
  }

  @override
  String get dataMigration => 'Datamigrering';

  @override
  String get dataMigrationDescription =>
      'Denne funksjonen lar deg overføre alle dataene dine mellom enheter. For øyeblikket kan du bruke backup- og gjenopprettingsfunksjonene til å manuelt migrere dataene dine.';

  @override
  String get dataMigrationDialogContent =>
      'Denne funksjonen lar deg overføre alle dataene dine mellom enheter. For øyeblikket kan du bruke backup- og gjenopprettingsfunksjonene til å manuelt migrere dataene dine.';

  @override
  String get dataMigrationDialogTitle => 'Datamigrering';

  @override
  String get dataMigrationSectionTitle => 'Datamigrering';

  @override
  String get dataSourceReminder => 'Datakilde påminnelse';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dager',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Dager VIP';
  }

  @override
  String get debtCollection => 'Inkasso';

  @override
  String get defaultPeriod => 'Uke';

  @override
  String get delete => 'Slett';

  @override
  String get deleteButton => 'Slett';

  @override
  String get deleteContact => 'Slett kontakt';

  @override
  String deleteContactConfirm(Object name) {
    return 'Er du sikker på at du vil slette $name?';
  }

  @override
  String get deleteContactConfirmation =>
      'Er du sikker på at du vil slette kontakt';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Er du sikker på at du vil slette $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Slett enhet';

  @override
  String deleteFailed(Object error) {
    return 'Sletting mislyktes: $error';
  }

  @override
  String get deleteFilter => 'Slett filter';

  @override
  String get deleteLabel => 'Slett etikett';

  @override
  String deleteLabelFailed(Object error) {
    return 'Kunne ikke slette etikett: $error';
  }

  @override
  String get deletePlugin => 'Slett plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Kunne ikke slette plugin: $error';
  }

  @override
  String get deletePlugins => 'Slett plugins';

  @override
  String deletePluginsFailed(Object error) {
    return 'Kunne ikke slette plugins: $error';
  }

  @override
  String get deleteRule => 'Slett regel';

  @override
  String deleteRuleFailed(Object error) {
    return 'Sletting mislyktes: $error';
  }

  @override
  String get deleteSelected => 'Slett valgte';

  @override
  String get deleteSmsRule => 'Slett SMS-regel';

  @override
  String get deleteSubscription => 'Slett abonnement';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Er du sikker på at du vil slette abonnementet \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Kunne ikke slette abonnement: $error';
  }

  @override
  String get deleteSuccess => 'Sletting vellykket';

  @override
  String get delivery => 'Levering';

  @override
  String get deviceDeletedSuccessfully => 'Enhet slettet vellykket';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Enhet slettet vellykket';

  @override
  String get deviceIdLabel => 'Enhets-ID';

  @override
  String get deviceIDLabel => 'Enhets-ID';

  @override
  String get deviceManagementSubtitle =>
      'Administrer synkronisering av flere enheter';

  @override
  String get deviceManagementTitle => 'Enhetsadministrasjon';

  @override
  String get deviceModelLabel => 'Enhetsmodell';

  @override
  String get deviceName => 'Enhetsnavn';

  @override
  String get deviceNameCannotBeEmpty => 'Enhetsnavn kan ikke være tomt';

  @override
  String get deviceNameHint => 'Vennligst oppgi enhetsnavn';

  @override
  String get deviceNameLabel => 'Enhetsnavn';

  @override
  String get deviceRenamedSuccessfully => 'Enhet omdøpt vellykket';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Enhet omdøpt vellykket';

  @override
  String get devicesSyncedSuccessfully => 'Enheter synkronisert vellykket';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Enheter synkronisert vellykket';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Enheter synkronisert vellykket';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Enhet avregistrert vellykket';

  @override
  String get dialogTitle => 'Forklaring av Regex-mønster';

  @override
  String get differentFromLocalCounter =>
      'Denne funksjonen er forskjellig fra den lokale telleren, da den fokuserer på gjentatte anropsmønstre på kort tid, i stedet for langsiktig markering av antall.';

  @override
  String get disabled => 'Deaktivert';

  @override
  String get disabledStatus => 'Deaktivert';

  @override
  String get disableGlobalPlugins => 'Deaktiver globale plugins';

  @override
  String get disableSubscriptionSuccessfully =>
      'Abonnement deaktivert vellykket';

  @override
  String get disconnectButton => 'Koble fra';

  @override
  String get disconnectedMessage => 'Frakoblet';

  @override
  String get disconnectedStatus => 'Frakoblet';

  @override
  String get disconnectFailedMessage => 'Tilkobling feilet';

  @override
  String get done => 'Ferdig';

  @override
  String get dualSimAdvice =>
      'Denne funksjonen er spesielt nyttig for telefoner med to SIM-kort for å sette forskjellige filtreringsstrategier for jobb- og private SIM-kort.';

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
  String get editLabel => 'Rediger etikett';

  @override
  String get editPhoneRule => 'Rediger telefonregel';

  @override
  String get editPhoneRules => 'Brukes til å redigere telefonregler';

  @override
  String get editPhoneRuleTitle => 'Rediger telefonregel';

  @override
  String get editRule => 'Rediger regel';

  @override
  String get editSmsRule => 'Rediger SMS-regel';

  @override
  String get education => 'Utdanning';

  @override
  String get elementPositionsSetting => 'Posisjoner for elementer';

  @override
  String get email => 'E-post';

  @override
  String get emailOptional => 'E-post (valgfritt)';

  @override
  String get enableCallFilter => 'Aktiver anropsfilter';

  @override
  String get enableCallFilterDescription =>
      'Når aktivert, sjekkes innkommende anrop mot regelisten nedenfor. Anropsfiltreringsregler synkroniseres ikke mellom enheter som standard.';

  @override
  String get enabled => 'Aktivert';

  @override
  String get enabledStatus => 'Aktivert';

  @override
  String get enableEncryption => 'Aktiver kryptering';

  @override
  String get enableEncryptionDescription => 'Krypter sikkerhetskopifiler';

  @override
  String get enableEncryptionLabel => 'Aktiver kryptering';

  @override
  String get enableEncryptionSubtitle => 'Sikkerhetskopifiler vil bli kryptert';

  @override
  String get enableEncryptionTitle => 'Aktiver kryptering';

  @override
  String get enableGlobalPlugins => 'Aktiver globale plugins';

  @override
  String get enableLocalCountFilter => 'Aktiver lokalt tellerverktøy';

  @override
  String get enableLocalCountFilterDescription =>
      'Filtrer spam-anrop automatisk basert på antall markeringer av anrop';

  @override
  String get enableLocalNotification => 'Bruk lokal varsling';

  @override
  String get enableLocalNotificationDescription =>
      'Når aktivert, vil varsler for filtrerte meldinger vises på enheten';

  @override
  String get enableLocationSummary => 'Sted';

  @override
  String get enableMuteRules => 'Aktiver dempingsregler';

  @override
  String get enableMuteRulesDesc =>
      'Bruk konfigurasjon for dempingsavskjæringsregler';

  @override
  String get enableNoneActionRules => 'Aktiver ingen handlingsregler';

  @override
  String get enableNoneActionRulesDesc =>
      'Tillat regelkonfigurasjoner uten avskjæringsaksjoner';

  @override
  String get enableNotifications => 'Aktiver varsler';

  @override
  String get enableRemoteNumberFilter => 'Aktiver fjernnummerfilter';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Bruk fjern database for å filtrere numre';

  @override
  String get enableRule => 'Aktiver regel';

  @override
  String get enableSmsFilter => 'Aktiver SMS-filtrering';

  @override
  String get enableSmsFilterDescription =>
      'Når aktivert, vil meldinger bli automatisk filtrert i henhold til reglene';

  @override
  String get enableStatisticsNotifications => 'Aktiver statistikkvarsler';

  @override
  String get enableSubscriptionSuccessfully => 'Abonnement aktivert vellykket';

  @override
  String get enableTimeInterception => 'Aktiver tidsavskjæring';

  @override
  String get enableTimeInterceptionDescription =>
      'Avskjær gjentatte anrop innen kort tid';

  @override
  String get enableTimeInterceptor => 'Aktiver tidsavskjærer';

  @override
  String get endCallImmediately => 'Avslutt anrop umiddelbart';

  @override
  String get endColor => 'Sluttfarge';

  @override
  String get endDate => 'Sluttdato';

  @override
  String get enhancedFilterInstructionsTitle =>
      'Instruksjoner for forbedret filtersystem';

  @override
  String get enhancedFilterSettings => 'Innstillinger for forbedret filter';

  @override
  String get enhancedFilterSettingsTitle =>
      'Innstillinger for forbedret filter';

  @override
  String get enhancedFilterSystemDescription =>
      'Det forbedrede filtersystemet støtter både globale regler og konfigurasjoner for filtrering per SIM-kort.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Vennligst oppgi både telefonnummer og regex-mønster';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Vennligst oppgi både telefonnummer og regex-mønster.';

  @override
  String get enterContactName => 'Vennligst oppgi kontaktnavn';

  @override
  String get enterCurrentPasswordHint => 'Vennligst oppgi gjeldende passord';

  @override
  String get enterDeviceName => 'Oppgi enhetsnavn';

  @override
  String get enterDeviceNameHint => 'Vennligst oppgi enhetsnavn';

  @override
  String get enterEmail => 'Vennligst oppgi e-post';

  @override
  String get enterEmailOptional => 'Vennligst oppgi e-post (valgfritt)';

  @override
  String get enterEncryptionPasswordHint => 'Oppgi krypteringspassord';

  @override
  String get enterEncryptionPasswordTitle => 'Oppgi krypteringspassord';

  @override
  String get enterFilterName => 'Vennligst oppgi filternavn';

  @override
  String get enterFilterPattern => 'Vennligst oppgi filtermønster';

  @override
  String get enterIconCode => 'Oppgi ikonkode';

  @override
  String get enterName => 'Oppgi kontaktnavn';

  @override
  String get enterNewDeviceNameHint => 'Oppgi et nytt navn for denne enheten';

  @override
  String get enterNewPasswordHint => 'Vennligst oppgi nytt passord';

  @override
  String get enterPasswordAgain => 'Oppgi passord igjen';

  @override
  String get enterPasswordHint => 'Vennligst oppgi passord';

  @override
  String get enterPhoneNumber => 'Oppgi telefonnummer';

  @override
  String get enterPhoneNumberHint => 'Oppgi telefonnummer for å teste';

  @override
  String get enterPhoneNumberMultiple =>
      'Vennligst oppgi telefonnummer, flere numre adskilt med komma';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Oppgi telefonnummer for å starte søk';

  @override
  String get enterPhoneNumberToVerify => 'Oppgi telefonnummer for å verifisere';

  @override
  String get enterPluginName => 'Oppgi plugin-navn';

  @override
  String get enterPluginUrl => 'Oppgi plugin-adresse';

  @override
  String get enterRegexHint => 'Oppgi regex-mønster';

  @override
  String get enterRuleNameAndPattern => 'Vennligst oppgi regelnavn og mønster';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Vennligst oppgi både regelnavn og regulært uttrykk-mønster.';

  @override
  String get enterRuleNameHint => 'Skriv inn regelnavn';

  @override
  String get enterSearchContent => 'Vennligst oppgi søkeinnhold';

  @override
  String get enterSubscriptionName => 'Skriv inn abonnementsnavn';

  @override
  String get enterSubscriptionUrl => 'Skriv inn abonnements-URL';

  @override
  String get enterSyncFolderNameHint =>
      'Vennligst oppgi synkroniseringsmappenavn (standard: NotificationManager)';

  @override
  String get entertainment => 'Underholdning';

  @override
  String get enterValidNameAndUrl => 'Vennligst oppgi gyldig navn og URL';

  @override
  String get enterValidUrl => 'Vennligst oppgi en gyldig URL';

  @override
  String get enterVersion => 'Skriv inn versjon';

  @override
  String get enterWebDAVPasswordHint => 'Vennligst oppgi WebDAV-passord';

  @override
  String get enterWebDAVServerAddressHint =>
      'Vennligst oppgi WebDAV-serveradresse';

  @override
  String get enterWebDAVUsernameHint => 'Vennligst oppgi WebDAV-brukernavn';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Feil ved sletting av enhet: $error';
  }

  @override
  String get errorLoadingPlugin => 'Feil ved lasting av plugin';

  @override
  String errorOccurredMessage(Object error) {
    return 'En feil oppstod: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Feil ved endring av navn på enhet: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Feil ved synkronisering av enheter: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Feil ved synkronisering av enheter: $error';
  }

  @override
  String get errorText => 'Feil';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Feil ved avregistrering av enhet: $error';
  }

  @override
  String get exampleBlock400Prefix => 'f.eks. Blokker 400 prefiksnummer';

  @override
  String get exampleBlockMarketingSms => 'f.eks. Blokker markedsførings-SMS';

  @override
  String get exampleContentRegex => 'f.eks., .*tilbud.*';

  @override
  String get exampleContentRegexHint => 'Eksempel på innholdsmønster';

  @override
  String get exampleCouponPromotionDiscount =>
      'f.eks. .*(kupong|kampanje|rabatt).*';

  @override
  String get exampleFamilyFriends => 'f.eks. Familie, Venner, etc.';

  @override
  String get examplePhoneNumber => 'f.eks. 10086, 12345, etc.';

  @override
  String get exampleRegex400Prefix =>
      'Eksempel på regulært uttrykk for 400 prefiks';

  @override
  String get exampleRegexFormat => 'Eksempel: ^10086\$ format';

  @override
  String get exampleSenderRegexHint => 'Eksempel';

  @override
  String get exchange => 'Bytte';

  @override
  String get exchangeNow => 'Bytt nå';

  @override
  String get exchangeVip => 'Bytt VIP';

  @override
  String get expandLabelSelector => 'Utvid etikettvelger';

  @override
  String expiryTime(Object time) {
    return 'Utløpstid: $time';
  }

  @override
  String get export => 'Eksporter';

  @override
  String get exportAllApplicationSettings =>
      'Eksporter alle applikasjonsinnstillinger';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Eksporter alle applikasjonsinnstillinger';

  @override
  String get exportAllRuleConfigurations =>
      'Eksporter alle regelkonfigurasjoner';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Eksporter alle regelkonfigurasjoner';

  @override
  String get exportComplete => 'Eksportering fullført';

  @override
  String get exportConfig => 'Eksporter konfigurasjon';

  @override
  String get exportContacts => 'Eksporter kontakter';

  @override
  String get exportData => 'Eksporter data';

  @override
  String get exportError => 'Eksporteringsfeil';

  @override
  String get exportFailed => 'Eksportering mislyktes';

  @override
  String get exportFailure => 'Kunne ikke eksportere konfigurasjon';

  @override
  String get exportFeatureComingSoon => 'Eksportfunksjon kommer snart';

  @override
  String get exporting => 'Eksporterer...';

  @override
  String get exportLabels => 'Eksporter etiketter';

  @override
  String exportLabelsFailed(Object error) {
    return 'Kunne ikke eksportere etiketter: $error';
  }

  @override
  String get exportPluginList => 'Eksporter plugin-liste';

  @override
  String exportPluginListFailed(Object error) {
    return 'Kunne ikke eksportere plugin-liste: $error';
  }

  @override
  String get exportRules => 'Eksporter regler';

  @override
  String get exportRulesDialogTitle => 'Eksporter regler';

  @override
  String get exportRulesTitle => 'Eksporter regler';

  @override
  String get exportSmsRules => 'Eksporter SMS-regler';

  @override
  String get exportStatisticsData => 'Eksporter statistikkdata';

  @override
  String get exportSuccess => 'Eksportering vellykket';

  @override
  String get exportSuccesslly => 'Konfigurasjon eksportert vellykket';

  @override
  String get failedToAddContact => 'Kunne ikke legge til kontakt';

  @override
  String failedToAddRule(Object error) {
    return 'Kunne ikke legge til regel: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'Kunne ikke legge til SMS-regel: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Kunne ikke legge til SMS-abonnement: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Kunne ikke sikkerhetskopiere innstillinger: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Kunne ikke dekryptere sikkerhetskoffertfilen';

  @override
  String get failedToDeleteDevice => 'Kunne ikke slette enhet';

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
    return 'Kunne ikke hente nummeropplysningsinformasjon: $error';
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
  String get failedToLoadContacts => 'Kunne ikke laste inn kontakter';

  @override
  String get failedToLoadPlugin => 'Kunne ikke laste inn plugin';

  @override
  String get failedToRenameDevice => 'Kunne ikke endre navn på enhet';

  @override
  String get failedToRestoreSettings => 'Kunne ikke gjenopprette innstillinger';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Kunne ikke gjenopprette innstillinger: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Kunne ikke angi passord: $error';
  }

  @override
  String get failedToSyncDevices => 'Kunne ikke synkronisere enheter';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Kunne ikke veksle regelstatus: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Kunne ikke veksle abonnementsstatus';

  @override
  String get failedToUpdateContact => 'Kunne ikke oppdatere kontakt';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Kunne ikke oppdatere SMS-regel: $error';
  }

  @override
  String get failure => 'Feil';

  @override
  String get favoriteContacts => 'Favorittkontakter';

  @override
  String get featureAddRules =>
      '• Legg til spesifikke regler for telefonnummer';

  @override
  String get featureCenter => 'Funksjonssenter';

  @override
  String get featureEnableDisable =>
      '• Aktiver/deaktiver forskjellige filtre per SIM';

  @override
  String get featureListTitle => 'Funksjoner:';

  @override
  String get featureManageRules => '• Administrer regelsett per SIM';

  @override
  String get features => 'Funksjoner';

  @override
  String get fetchingCallerIdInfo => 'Henter nummeropplysningsinformasjon...';

  @override
  String fileSavedTo(Object path) {
    return 'Fil lagret til: $path';
  }

  @override
  String get filter => 'Filtrer';

  @override
  String get filterByLabel => 'Filtrer etter etikett';

  @override
  String get filterClear => 'Fjern filter';

  @override
  String get filterControlPanelTitle => 'Filterkontrollpanel';

  @override
  String get filterControlSubtitle =>
      'Administrer av/på-status for alle filtre';

  @override
  String get filterControlTitle => 'Kontroll for filtre';

  @override
  String get filterDeleteFailed => 'Kunne ikke slette filter';

  @override
  String get filterDeleteSuccess => 'Filter slettet vellykket';

  @override
  String get filterDetails => 'Filterdetaljer';

  @override
  String get filtered => 'Filtrert';

  @override
  String get filteredSms => 'Filtrert SMS';

  @override
  String get filteredSmsLabel => 'Filtrert SMS';

  @override
  String get filterExplanation => 'Forklaring av filter';

  @override
  String get filterManagement => 'Filteradministrasjon';

  @override
  String get filterName => 'Filter navn';

  @override
  String get filterPattern => 'Filtermønster';

  @override
  String get filterPriorityNote =>
      'Merk: Det er prioriteringsforhold mellom filtre, vennligst se hjelpedokumentasjonen for detaljer';

  @override
  String get filterSaveFailed => 'Kunne ikke lagre filter';

  @override
  String get filterSaveSuccess => 'Filter lagret vellykket';

  @override
  String get filterSettings => 'Filterinnstillinger';

  @override
  String get filterSettingsTitle => 'Filterinnstillinger';

  @override
  String get filterSMS => 'Filtrer SMS';

  @override
  String get filterToggleInstructions =>
      'Aktiver eller deaktiver filtre for denne SIM-kortplassen:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filter: $filterName';
  }

  @override
  String get filterType => 'Filtertype';

  @override
  String get financial => 'Finansiell';

  @override
  String get flexibleCombinationFeature =>
      '• Fleksible kombinasjoner: Aktiver/deaktiver filtre per SIM-kortplass';

  @override
  String get fontSizesSetting => 'Skriftstørrelser';

  @override
  String foundRules(Object count) {
    return 'Fant $count regler';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Fant $count regler. Vil du importere dem?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Fant $count regler. Vil du importere dem?';
  }

  @override
  String get fraudAlert => 'SVINDELALARM - Legg på samtalen';

  @override
  String get fraudScamLikely => 'Svindel, sannsynlig svindel';

  @override
  String get free => 'Gratis';

  @override
  String get functionSettingsTitle => 'Funksjonsinnstillinger';

  @override
  String generalUpdateFailure(Object error) {
    return 'Oppdatering mislyktes: $error';
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
      '• Globale filtre: Grunnleggende regler for alle innkommende anrop';

  @override
  String get globalFilterSettings => 'Globale filterinnstillinger';

  @override
  String get globalFilterToggleInstructions =>
      'Konfigurer globale filterinnstillinger som gjelder for alle SIM-kortplasser:';

  @override
  String get globalSearchSubtitle =>
      'Søk i kontakter, etiketter, svartelister, hvitelister, osv.';

  @override
  String get globalSearchTitle => 'Globalt søk';

  @override
  String get globalSettings => 'Globale innstillinger';

  @override
  String get googleAdDisplayPosition => 'Google annonsevisningsposisjon';

  @override
  String get googleAdMobIntegrationText =>
      'Google AdMob-annonser kan integreres her';

  @override
  String get googleDriveAuthDescription =>
      'Autoriser ved bruk av systemkonfigurert Google Drive-klient-ID og nøkkel';

  @override
  String get googleDriveAuthorizationHint =>
      'Autoriser ved bruk av systemkonfigurert Google Drive-klient-ID og nøkkel';

  @override
  String get googleDriveConfigTitle => 'Google Drive-konfigurasjon';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive-konfigurasjon';

  @override
  String get government => 'Myndigheter';

  @override
  String get granted => 'Innrømmet';

  @override
  String get grantNecessaryPermissions => 'Gi nødvendige tillatelser';

  @override
  String get grantPermissions => 'Gi tillatelser';

  @override
  String get headhunter => 'Rekrutterer';

  @override
  String get height => 'Høyde';

  @override
  String get homePageTitle => 'Hjemmeside';

  @override
  String get homeTab => 'Hjem';

  @override
  String get howItWorksPoint1 =>
      '• Systemet vil automatisk tillate anrop fra samme nummer innenfor det angitte tidsvinduet';

  @override
  String get howItWorksPoint2 =>
      '• Kortere tidsvinduer gir strengere avskjæring; lengre tidsvinduer gir løsere avskjæring';

  @override
  String get howItWorksPoint3 =>
      '• Systemet sjekker anropslogger for å avgjøre om det er et gjentatt anrop';

  @override
  String get howItWorksTitle => 'Slik fungerer det:';

  @override
  String get iconCodeOptional => 'Ikonkode (valgfritt)';

  @override
  String get iconSize => 'Ikonstørrelse';

  @override
  String get import => 'Importer';

  @override
  String get important => 'Viktig';

  @override
  String get importButton => 'Importer';

  @override
  String get importConfig => 'Importer konfigurasjon';

  @override
  String get importContacts => 'Importer kontakter';

  @override
  String get importExportContacts => 'Importer/eksporter kontakter';

  @override
  String get importExportContactsTooltip => 'Importer/eksporter kontakter';

  @override
  String get importExportRules => 'Importer/eksporter regler';

  @override
  String importFailed(Object error) {
    return 'Import mislyktes: $error';
  }

  @override
  String get importFailure => 'Kunne ikke importere konfigurasjon';

  @override
  String get importFeatureComingSoon => 'Importfunksjon kommer snart';

  @override
  String get importLabels => 'Importer etiketter';

  @override
  String importLabelsFailed(Object error) {
    return 'Kunne ikke importere etiketter: $error';
  }

  @override
  String get importPluginList => 'Importer plugin-liste';

  @override
  String importPluginListFailed(Object error) {
    return 'Kunne ikke importere plugin-liste: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Vellykket importert $count plugins';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Importer regelkonfigurasjoner fra fil';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Importer regelkonfigurasjoner fra fil';

  @override
  String get importRules => 'Importer regler';

  @override
  String get importRulesButton => 'Importer regler';

  @override
  String get importRulesDialogTitle => 'Importer regler';

  @override
  String importRulesError(Object error) {
    return 'Kunne ikke importere regler: $error';
  }

  @override
  String get importRulesInstructions => 'Importer regler fra en CSV-fil';

  @override
  String get importRulesSuccess => 'Regler importert vellykket';

  @override
  String get importRulesTitle => 'Importer regler';

  @override
  String get importSuccess => 'Import vellykket';

  @override
  String get incomingCallInterceptAction =>
      'Handling ved avskjæring av innkommende anrop';

  @override
  String get incomingCallNotification => 'Innkommende anropsvarsel';

  @override
  String get incorrectPassword => 'Feil passord';

  @override
  String get initializing => 'Initialiserer';

  @override
  String get installed => 'Installert';

  @override
  String get insufficientMarks => 'Utililstrekkelige poeng';

  @override
  String get insurance => 'Forsikring';

  @override
  String get interceptAction => 'Avskjærings handling';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Still inn hvordan blokkerte anrop håndteres';

  @override
  String get interceptionActionSettingsTitle =>
      'Innstillinger for avskjærings handling';

  @override
  String get interceptionTimeInterval => 'Avskjæring tidsintervall';

  @override
  String get internet => 'Internett';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service oppdateringsintervall satt til $days dager';
  }

  @override
  String get invalidContentRegex => 'Ugyldig innholdsregEx';

  @override
  String get invalidLabel => 'Ugyldig etikett';

  @override
  String get invalidRegexPattern => 'Ugyldig regex-mønster';

  @override
  String get invalidSenderRegex => 'Ugyldig avsender-regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Bli med i Telegram-kanalen og gruppen for mer informasjon';

  @override
  String get jsLogsTitle => 'JS-logger';

  @override
  String get jsonFormat => 'JSON-format';

  @override
  String get keepAllVersions => 'Behold alle versjoner';

  @override
  String get keepAllVersionsDescription =>
      'Behold alle historiske versjoner av hver sikkerhetskopi';

  @override
  String get keepAllVersionsLabel => 'Behold alle versjoner';

  @override
  String get keepAllVersionsSubtitle =>
      'Behold historiske versjoner av hver sikkerhetskopi';

  @override
  String get keepAllVersionsTitle => 'Behold alle versjoner';

  @override
  String get label => 'Etikett';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Etiketten \"$name\" ble lagt til vellykket';
  }

  @override
  String get labelCategories => 'Etikettkategorier';

  @override
  String get labelDeleted => 'Etikett slettet';

  @override
  String get labelDescription =>
      'Etiketter hjelper deg med å administrere kontakter bedre, legg til egendefinerte etiketter på telefonnumre for enkel identifisering av anrop og meldinger.';

  @override
  String get labelFilter => 'Etikettfilter';

  @override
  String get labelFilterTooltip => 'Etikettfilter';

  @override
  String get labelIconColor => 'Etikettikonfarge';

  @override
  String get labelManagement => 'Etiketthåndtering';

  @override
  String get labelNotFound => 'Etikett ikke funnet';

  @override
  String get labelRemoved => 'Etikett fjernet';

  @override
  String labelRemoveFailed(Object error) {
    return 'Kunne ikke fjerne etikett: $error';
  }

  @override
  String get labels => 'Etiketter';

  @override
  String get labelsColor => 'Etiketter farge';

  @override
  String labelsDeleted(Object count) {
    return '$count etiketter slettet';
  }

  @override
  String get labelsExportedSuccessfully => 'Etiketter eksportert vellykket';

  @override
  String get labelsFontSize => 'Etiketter skriftstørrelse';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Vellykket importert $count etiketter';
  }

  @override
  String get labelsPosition => 'Etiketter posisjon';

  @override
  String labelTag(Object labelId) {
    return 'Etikett: $labelId';
  }

  @override
  String get labelUpdated => 'Etikett oppdatert';

  @override
  String labelUpdateFailed(Object error) {
    return 'Kunne ikke oppdatere etikett: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Etiketten \"\$labelText\" ble oppdatert vellykket';

  @override
  String get languageSettings => 'Språkinnstillinger';

  @override
  String get languageSettingsSubtitle => 'Endre appens visningsspråk';

  @override
  String get languageSettingsTitle => 'Språkinnstillinger';

  @override
  String get last30Days => 'Siste 30 dager';

  @override
  String get last7Days => 'Siste 7 dager';

  @override
  String get lastSyncLabel => 'Siste synkronisering';

  @override
  String lastUpdated(Object date) {
    return 'Sist oppdatert: $date';
  }

  @override
  String get lifetimeMembership => 'Livstidsmedlemskap';

  @override
  String get lifetimeMembershipDescription =>
      'Engangskjøp, lås opp permanent alle premiumfunksjoner og fremtidige oppdateringer';

  @override
  String loadContactsFailed(Object error) {
    return 'Kunne ikke laste inn kontakter: $error';
  }

  @override
  String get loadDataFailed => 'Kunne ikke laste inn data';

  @override
  String get loadFailed => 'Lasting mislyktes';

  @override
  String get loading => 'Laster inn...';

  @override
  String get loadingData => 'Laster inn data...';

  @override
  String get loadingTags => 'Laster inn merkelapper...';

  @override
  String loadLabelFailed(Object error) {
    return 'Kunne ikke laste inn etiketter: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Kunne ikke laste inn etiketter: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Kunne ikke laste inn merkede telefonnumre: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Kunne ikke laste inn merkede telefonnumre: $error';
  }

  @override
  String get loadMore => 'Last inn mer';

  @override
  String get loadPluginButton => 'Last inn plugin';

  @override
  String loadPluginsFailed(Object error) {
    return 'Kunne ikke laste inn plugins: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Kunne ikke laste inn innstillinger: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Kunne ikke laste inn SMS-regler: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Kunne ikke laste inn status';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Kunne ikke laste inn abonnementer: $error';
  }

  @override
  String get loan => 'Lån';

  @override
  String get localBackupTitle => 'Lokal sikkerhetskopi';

  @override
  String get localCounterFilter => 'Lokal tellerfilter';

  @override
  String get localCounterFilterSubtitle =>
      'Filtrer automatisk spam-anrop basert på anropsfrekvens';

  @override
  String get localCountFilter => 'Lokal antallsfilter';

  @override
  String get localCountFilterDescription =>
      'Avskjær hyppige anrop basert på lokale nummertall';

  @override
  String get localCountFilterExplanationContent =>
      'Det lokale antallsfilteret analyserer samtalehistorikk for å automatisk identifisere og blokkere hyppige spam-anrop.';

  @override
  String get localCountFilterExplanationTitle =>
      'Forklaring av lokalt antallsfilter';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Bestem om du vil blokkere basert på nummers antallsverdi';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Når et nummers antall overstiger den innstilte terskelen, kan du velge å blokkere det automatisk';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Du kan selektivt tillate numre som ikke overskrider terskelen';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Du kan velge om du vil registrere alle spørringslogger';

  @override
  String get localCountFiltering => 'Lokal antallsfiltrering';

  @override
  String get localCountFilteringExplanation =>
      '• Lokal antallsfiltrering: Filtreringsregler basert på lokal merket antall';

  @override
  String get localCountFilterSettings =>
      'Innstillinger for lokalt antallsfilter';

  @override
  String get localCountFilterUseCases =>
      'Dette filteret er spesielt egnet for å identifisere automatiserte spam-anrop og markedsføringsanrop.';

  @override
  String get localFilterSettings => 'Innstillinger for lokalt filter';

  @override
  String get localNotificationDisabled => 'Lokal varsling deaktivert';

  @override
  String get localNotificationEnabled => 'Lokal varsling aktivert';

  @override
  String get localServices => 'Lokale tjenester';

  @override
  String get locationColor => 'Plassering farge';

  @override
  String get locationFontSize => 'Plassering skriftstørrelse';

  @override
  String get locationIconColor => 'Plassering ikonfarge';

  @override
  String get locationPosition => 'Plassering posisjon';

  @override
  String get logAllLocalQueries => 'Logg alle lokale spørringer';

  @override
  String get logAllLocalQueriesDescription =>
      'Registrer logger for alle lokale nummerspørringer';

  @override
  String get logAllRemoteQueries => 'Logg alle eksterne spørringer';

  @override
  String get logAllRemoteQueriesDescription =>
      'Registrer alle eksterne nummerspørringsoperasjoner';

  @override
  String get manage => 'Administrer kontakter';

  @override
  String get manageContacts => 'Administrer';

  @override
  String get manageFavoriteContacts => 'Administrer favorittkontakter';

  @override
  String get manageFilterRules => 'Administrer filterregler';

  @override
  String get manageFilterRulesDescription =>
      'Legg til, rediger eller slett SMS-filterregler';

  @override
  String get manageFrequentContacts => 'Administrer hyppige kontakter';

  @override
  String get markCounts => 'Merk antall';

  @override
  String get markCount => 'Merk antall';

  @override
  String markedByCount(Object count) {
    return 'Merke av $count';
  }

  @override
  String get markedPhonesList => 'Merkede telefonnumre';

  @override
  String get markExchange => 'Merk utveksling';

  @override
  String get markPhone => 'Merk telefonnummer';

  @override
  String markPhoneFailed(Object error) {
    return 'Kunne ikke merke telefonnummer: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'For å merke telefonnumre';

  @override
  String get markPhoneManagementTitle => 'Håndtering av merkede telefonnumre';

  @override
  String get markPhoneSuccess => 'Telefonnummer merket vellykket';

  @override
  String get matchFailed => 'Treff mislyktes!';

  @override
  String get matchFailedMessage => 'Treff mislyktes.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'matcher spesifikt nummerformat';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Matcher tall med spesialtegn:';

  @override
  String get matchSpecificDigitPatterns => 'matcher XXX-XXXX-XXXX format';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Matcher spesifikke sifermønstre:';

  @override
  String get matchSuccessful => 'Treff vellykket!';

  @override
  String get matchSuccessfulMessage => 'Treff vellykket!';

  @override
  String get medical => 'Medisinsk';

  @override
  String get membershipPrivileges => 'Medlemskapsfordeler';

  @override
  String get migrationTool => 'Migreringsverktøy';

  @override
  String get migrationToolTitle => 'Migreringsverktøy';

  @override
  String get minutes => 'minutter';

  @override
  String get month => 'Måned';

  @override
  String get monthly => 'Månedlig';

  @override
  String get monthlyCallCount => 'Månedlige anrop';

  @override
  String get monthlyChartTitle => 'Månedlige blokkerte anrop';

  @override
  String get monthlyMembership => 'Månedlig medlemskap';

  @override
  String get monthlyMembershipDescription =>
      'Lås opp alle premiumfunksjoner, fornyes automatisk månedlig';

  @override
  String get monthlyTotal => 'Månedlig totalt';

  @override
  String get monthlyTotalLabel => 'Månedlig totalt';

  @override
  String get moreOptions => 'Flere alternativer';

  @override
  String get mute => ' Demp';

  @override
  String get name => 'Navn';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Navn og telefonnummer kan ikke være tomme';

  @override
  String get nameAndPhoneNumberRequired =>
      'Navn og telefonnummer kan ikke være tomme';

  @override
  String get nameColor => 'Navnfarge';

  @override
  String get nameFontSize => 'Navn skriftstørrelse';

  @override
  String nameLabel(Object name) {
    return 'Navn: $name';
  }

  @override
  String get namePosition => 'Navn posisjon';

  @override
  String get nameUnknown => 'Navn: Ukjent';

  @override
  String nameWithValue(String name) {
    return 'Navn: $name';
  }

  @override
  String get newPasswordLabel => 'Nytt passord';

  @override
  String get nextStep => 'Neste';

  @override
  String get noAction => 'Ingen handling';

  @override
  String get noActionRules => 'Ingen handling-regler';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Ingen aktiv skysynkroniseringstjeneste';

  @override
  String get noCallLogs => 'Ingen samtalehistorikk';

  @override
  String get noCallRecords => 'Ingen samtaleoppføringer';

  @override
  String get noContacts => 'Ingen kontakter ennå';

  @override
  String get noContactsYet => 'Ingen kontakter ennå';

  @override
  String get noData => 'Ingen data';

  @override
  String get noDevicesRegisteredMessage => 'Ingen enheter registrert';

  @override
  String get noDevicesRegisteredYet => 'Ingen enheter registrert ennå.';

  @override
  String get noFilters => 'Ingen filtre ennå';

  @override
  String get noLabels => 'Ingen etiketter ennå';

  @override
  String get noMarkedPhones => 'Ingen merkede telefonnumre';

  @override
  String get noMatchingContacts => 'Ingen matchende kontakter';

  @override
  String get noMatchingContactsFound => 'Ingen matchende kontakter funnet';

  @override
  String get noMatchingNumbersFound => 'Ingen matchende numre funnet';

  @override
  String get noMatchingRecords => 'Ingen matchende samtaleoppføringer';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Ingen matchende $ruleType';
  }

  @override
  String get none => 'Ingen';

  @override
  String get noneServiceType => 'Ingen';

  @override
  String get noPlugins => 'Ingen plugins ennå';

  @override
  String get noRecords => 'Ingen samtaleoppføringer';

  @override
  String get noResultReturned => 'Ingen resultat returnert';

  @override
  String get noResultReturnedLog => 'Intet resultat returnert fra plugin';

  @override
  String noRules(Object ruleType) {
    return 'Ingen $ruleType ennå';
  }

  @override
  String get noRulesPrompt => 'Ingen regler funnet, legg til regler';

  @override
  String get noRulesToExport => 'Ingen regler å eksportere';

  @override
  String get noSmsFilterRulesYet => 'Ingen SMS-filterregler ennå';

  @override
  String get noSmsRulesYet => 'Ingen SMS-regler ennå';

  @override
  String get noSubscriptions => 'Ingen abonnementer';

  @override
  String get noSubscriptionsYet => 'Ingen abonnementer ennå';

  @override
  String get notGranted => 'Ikke gitt';

  @override
  String get notificationMode => 'Varslingsmodus';

  @override
  String get notificationModeDescription =>
      'Vis oppringerinformasjon i varslingsfeltet';

  @override
  String get notificationPermission => 'Varslingsrettighet';

  @override
  String get notificationPermissionDescription =>
      'Brukes til å vise varsler om innkommende anrop og meldinger.';

  @override
  String get notifications => 'Varsler';

  @override
  String get notificationSettings => 'Varslingsinnstillinger';

  @override
  String get notificationSettingsSaved =>
      'Varslingsinnstillinger lagret vellykket';

  @override
  String get notSet => 'Ikke satt';

  @override
  String get notVerifiedText => 'Ikke verifisert';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Ingen gyldige SMS-regler funnet i fil';

  @override
  String get number => 'Nummer';

  @override
  String get numberColor => 'Nummerfarge';

  @override
  String get numberFontSize => 'Nummer skriftstørrelse';

  @override
  String get numberPosition => 'Nummer posisjon';

  @override
  String get numberSearch => 'Nummersøk';

  @override
  String get numberTypeColor => 'Nummertypefarge';

  @override
  String get numberTypeFontSize => 'Nummertype skriftstørrelse';

  @override
  String get numberTypePosition => 'Nummertype posisjon';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Din samtalestyringsverktøy er klar, begynn å nyte en trygg samtaleopplevelse!';

  @override
  String get onboardingLanguageDescription =>
      'Velg ditt foretrukne språk for best mulig opplevelse.';

  @override
  String get onboardingPermissionsDescription =>
      'For å gi full service trenger vi følgende tillatelser:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Ettklikksblokkering av spam-anrop og meldinger, tilpass blokkeringsregler og gi deg et rolig miljø.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Identifiser ukjente anrop automatisk, merk mistenkelige numre og beskytt samtaletryggheten din.';

  @override
  String get onboardingWelcomeDescription =>
      'Din samtalestyringsekspert, som tilbyr omfattende samtaleidentifikasjon og blokkeringstjenester.';

  @override
  String get oneDriveAuthDescription =>
      'Autoriser ved å bruke systemkonfigurert OneDrive-klient-ID og nøkkel';

  @override
  String get oneDriveAuthorizationHint =>
      'Autoriser ved å bruke systemkonfigurert OneDrive-klient-ID og nøkkel';

  @override
  String get oneDriveConfigTitle => 'OneDrive Konfigurasjon';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive Konfigurasjon';

  @override
  String get onlineCallerIdSubscription => 'Online Anrops-ID Abonnement';

  @override
  String get openAppSettings => 'Åpne appinnstillinger';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Kunne ikke åpne appinnstillinger: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operasjon mislyktes: $error';
  }

  @override
  String get operationFailure => 'Operasjon mislyktes';

  @override
  String get operationSuccess => 'Operasjon fullført';

  @override
  String get other => 'Annen';

  @override
  String get ourOtherApps => 'Våre Andre Apper';

  @override
  String get overlayMode => 'Flytende Vindu';

  @override
  String get overlayModeDescription =>
      'Vis anropsinformasjon i et flytende vindu';

  @override
  String get overlayPermission => 'Overleggstillatelse';

  @override
  String get overlayPermissionDescription =>
      'Brukes til å vise innkommende anrops-overlay.';

  @override
  String get overview => 'Oversikt';

  @override
  String get password => 'Passord';

  @override
  String get passwordCannotBeEmpty => 'Passord kan ikke være tomt';

  @override
  String get passwordLabel => 'Passord';

  @override
  String get passwordsDoNotMatch => 'Passordene stemmer ikke overens';

  @override
  String get passwordSetSuccessfully => 'Passord satt vellykket';

  @override
  String get pattern => 'Mønster';

  @override
  String get pendingSync => 'Venter på synkronisering';

  @override
  String get periodMonth => 'Måned';

  @override
  String get periodWeek => 'Uke';

  @override
  String get periodYear => 'År';

  @override
  String get permissionDenied => 'Tillatelsesforespørsel nektet';

  @override
  String get permissionGranted => 'Tillatelse gitt';

  @override
  String get permissionManagement => 'Tillatelsesadministrasjon';

  @override
  String get phoneCallsTab => 'Telefon';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get phoneNumberCannotBeEmpty => 'Telefonnummer kan ikke være tomt';

  @override
  String get phoneNumberHint => 'Skriv inn telefonnummer';

  @override
  String get phoneNumberHintText =>
      'Skriv inn telefonnummer for å legge til regel';

  @override
  String get phoneNumberLabel => 'Telefonnummer';

  @override
  String get phoneNumberRegexRequired =>
      'Vennligst skriv inn både telefonnummer og regex-mønster';

  @override
  String get phoneNumberRequired => 'Telefonnummer er påkrevd';

  @override
  String get phoneNumberTypeFixedLine => 'Fasttelefon';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Fasttelefon eller mobil';

  @override
  String get phoneNumberTypeMobile => 'Mobil';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Personlig nummer';

  @override
  String get phoneNumberTypePremiumRate => 'Premium-sats';

  @override
  String get phoneNumberTypeSharedCost => 'Delt kostnad';

  @override
  String get phoneNumberTypeTollFree => 'Tollfri';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Ukjent';

  @override
  String get phoneNumberTypeVoicemail => 'Talepost';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Telefontillatelse';

  @override
  String get phonePermissionDescription =>
      'Brukes til å identifisere og blokkere innkommende anrop.';

  @override
  String get phoneRule => 'Telefonregel';

  @override
  String get phoneRuleEditDialog => 'Redigeringsdialog for telefonregel';

  @override
  String get phoneRuleManagement => 'Administrasjon av telefonregler';

  @override
  String get phoneRuleSubscription => 'Abonnement på telefonregler';

  @override
  String get phoneSubscription => 'Telefonsubskripsjon';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Abonner på lister over telefonregler via URL for automatisk oppdatering av hviteliste- og svartelister. Støtter regel-filer i JSON-format.';

  @override
  String get phoneSubscriptionTitle => 'Abonnement på telefonregler';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Vennligst velg en etikett og skriv inn et gyldig telefonnummer';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" lagt til vellykket';
  }

  @override
  String get pluginDeleted => 'Plugin slettet';

  @override
  String get pluginLatestVersion => 'Plugin er allerede den nyeste versjonen';

  @override
  String get pluginListExportSuccess => 'Plugin-liste eksportert vellykket';

  @override
  String get pluginLoadedSuccessfully => 'Plugin lastet vellykket';

  @override
  String get pluginManagement => 'Pluginadministrasjon';

  @override
  String get pluginManagementSubtitle =>
      'Administrer og konfigurer tredjeparts plugins';

  @override
  String get pluginManagementTitle => 'Pluginadministrasjon';

  @override
  String get pluginName => 'Pluginnavn';

  @override
  String get pluginNotLoaded =>
      'Plugin er ikke lastet ennå. Vennligst last plugin først.';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugins slettet vellykket.';
  }

  @override
  String get pluginService => 'Plugin-tjeneste';

  @override
  String get pluginTestPageTitle => 'Plugin-test';

  @override
  String get pluginUpdateSuccess => 'Plugin oppdatert vellykket';

  @override
  String get pluginUrl => 'Plugin-URL';

  @override
  String get pluginUrlCannotBeEmpty => 'Plugin-URL kan ikke være tomt';

  @override
  String get pluginUrlHint => 'Skriv inn plugin-URL';

  @override
  String get pluginUrlLabel => 'Plugin-URL';

  @override
  String get pluginVersion => 'Plugin-versjon';

  @override
  String get political => 'Politisk';

  @override
  String get powerfulSpamBlocking => 'Kraftig Spam-blokkering';

  @override
  String get previousStep => 'Forrige';

  @override
  String get prioritizeRemoteAction =>
      'Prioriter Innstillinger for fjernhandling';

  @override
  String get prioritizeRemoteActionDescription =>
      'Prioriter innstillinger fra fjernbasen';

  @override
  String get processing => 'Behandler...';

  @override
  String get processingOperation => 'Behandler...';

  @override
  String get purchase => 'Kjøp';

  @override
  String get quarterlyMembership => 'Kvartalsmedlemskap';

  @override
  String get quarterlyMembershipDescription =>
      'Lås opp alle premium-funksjoner, fornyes automatisk kvartalsvis';

  @override
  String get queryButton => 'Spørring';

  @override
  String get queryFailed => 'Spørring mislyktes';

  @override
  String get queryFailedLog => 'Spørring mislyktes';

  @override
  String get querying => 'Spør...';

  @override
  String get queryingPhoneNumber => 'Spør etter telefonnummer';

  @override
  String get queryResultTitle => 'Spørringsresultat';

  @override
  String get ready => 'Klar!';

  @override
  String get receiveWeeklyStatistics => 'Motta ukentlig statistikk';

  @override
  String get recruiter => 'Rekrutterer';

  @override
  String get reEnterPasswordHint => 'Vennligst skriv inn passordet på nytt';

  @override
  String get refresh => 'Oppdater';

  @override
  String get refreshPermissionStatus => 'Oppdater tillatelsesstatus';

  @override
  String get refreshTooltip => 'Oppdater';

  @override
  String regexError(Object error) {
    return 'Regex-feil: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex-feil: $error';
  }

  @override
  String get regexPattern => 'Regex-mønster';

  @override
  String get regexPatternExplanation => 'Forklaring til regex-mønster';

  @override
  String get regexPatternExplanationButton => 'Forklaring til regex-mønster';

  @override
  String get regexPatternLabel => 'Regex-mønster';

  @override
  String get regexPatternsExamples =>
      'Bruk standard regex-syntaks for å definere mønstre. Eksempler:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Regex-mønstre for telefonskattmatching';

  @override
  String get regexRule => 'Regex-regel';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Kunne ikke legge til regex-regel: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex-regel lagt til vellykket';

  @override
  String get regexRuleManagement => 'Regex-regeladministrasjon';

  @override
  String get regexRuleNamePatternRequired =>
      'Regelnavn og regex-mønster kan ikke være tomme';

  @override
  String get regexRules => 'Regex-regler';

  @override
  String get regexTesterTitle => 'Regex-tester';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex-validering mislyktes: $error';
  }

  @override
  String get regexValidationSuccess => 'Regex-validering vellykket';

  @override
  String get region => 'Region';

  @override
  String get registeredDevicesTitle => 'Registrerte enheter';

  @override
  String get rejectAllCalls => 'Avvis alle anrop';

  @override
  String get rejectAllCallsDescription =>
      'Når aktivert, vil alle anrop bli avvist med høyeste prioritet';

  @override
  String get rejectAllNumbers => 'Avvis alle numre';

  @override
  String get rejectAllNumbersDesc =>
      'Avvis alle innkommende anrop når aktivert';

  @override
  String get rejectExceededNumbers => 'Avvis overskredne numre';

  @override
  String get rejectExceededNumbersDescription =>
      'Avvis automatisk numre som overskrider terskelverdien';

  @override
  String get remoteFilterSettings => 'Fjernfiltermuligheter';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Innstillinger for ekstern nummerfilter';

  @override
  String get remoteNumberFilter => 'Ekstern nummerfilter';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Dette filteret bruker en uavhengig ekstern database for å få den nyeste nummerinformasjonen.';

  @override
  String get remoteNumberFilterDescription =>
      'Avskjær plagsomme anrop basert på ekstern databasinformasjon';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Det eksterne nummerfilteret identifiserer og blokkerer spam-anrop ved å spørre en ekstern database basert på nummerantall.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Forklaring på eksternt nummerfilter';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Antallsterskel: Bestem basert på hyppigheten av nummerforekomster';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Filterhandlinger: Konfigurer hvordan numre som overskrider terskelverdien skal håndteres';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Prioritetsinnstillinger: Angi prioritet for eksterne handlinger';

  @override
  String get remoteNumberFilterFeatures => 'Funksjoner:';

  @override
  String get remoteNumberFiltering => 'Ekstern nummerfiltrering';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Ekstern nummerfiltrering: Filtreringsregler basert på informasjon fra ekstern database';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identifiser spam-anrop ved hjelp av skybasert database og fellesskapsrapporter';

  @override
  String get removeAdsDescription =>
      'Fjern permanent alle annonser i appen for en jevnere opplevelse';

  @override
  String get removeAdsTitle => 'Fjern annonser';

  @override
  String get removedFromFavoriteContacts => 'Fjernet fra favorittkontakter';

  @override
  String get removedFromFavorites => 'Fjernet fra favoritter';

  @override
  String get removeFavorite => 'Fjern favoritt';

  @override
  String get removeFromFavorites => 'Fjern fra favoritter';

  @override
  String get renameButton => 'Gi nytt navn';

  @override
  String get renameDeviceDialogTitle => 'Gi nytt navn til enhet';

  @override
  String get renameDeviceTitle => 'Gi nytt navn til enhet';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Dette vil erstatte alle dine gjeldende innstillinger. Er du sikker på at du vil fortsette?';

  @override
  String get requestAllPermissions => 'Be om alle tillatelser';

  @override
  String get requestPermission => 'Be om tillatelse';

  @override
  String requestPermissionFailed(Object error) {
    return 'Kunne ikke be om tillatelse: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count merker';
  }

  @override
  String get reset => 'Tilbakestill';

  @override
  String get restore => 'Gjenopprett';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Gjenopprett applikasjonsinnstillinger fra sikkerhetskopi';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Gjenopprett applikasjonsinnstillinger fra sikkerhetskopi';

  @override
  String get restoreButton => 'Gjenopprett';

  @override
  String restoreFailedWithError(Object error) {
    return 'Gjenoppretting fra sky mislyktes: $error';
  }

  @override
  String get restoreFromCloud => 'Gjenopprett fra sky';

  @override
  String get restoreFromCloudDescription =>
      'Gjenopprett innstillinger og regler fra skylagring';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Kunne ikke gjenopprette fra sky: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Gjenopprett fra sky';

  @override
  String get restoreFromCloudSuccess => 'Vellykket gjenoppretting fra sky';

  @override
  String get restoreFromCloudTitle => 'Gjenopprett fra sky';

  @override
  String get restoreFromLocal => 'Gjenopprett fra lokalt';

  @override
  String get restorePurchases => 'Gjenopprett kjøp';

  @override
  String get restoreSectionTitle => 'Gjenopprett';

  @override
  String get restoreSettings => 'Gjenopprett innstillinger';

  @override
  String get restoreSettingsConfirmation =>
      'Dette vil erstatte alle dine gjeldende innstillinger. Er du sikker på at du vil fortsette?';

  @override
  String get restoreSettingsDialogTitle => 'Gjenopprett innstillinger';

  @override
  String get restoreSettingsTitle => 'Gjenopprett innstillinger';

  @override
  String get restoreSuccessFromLocal => 'Vellykket gjenoppretting fra lokalt';

  @override
  String get restoreSuccessMessage => 'Vellykket gjenoppretting fra sky';

  @override
  String get retry => 'Prøv igjen';

  @override
  String get ridesharing => 'Samkjøring';

  @override
  String get risk => 'Risiko';

  @override
  String get robocall => 'Robocall';

  @override
  String get ruleAction => 'Regelhandling';

  @override
  String get ruleAddButton => 'Legg til regel';

  @override
  String get ruleAddedSuccess => 'Regel lagt til vellykket';

  @override
  String ruleAddFailure(Object error) {
    return 'Kunne ikke legge til regel: $error';
  }

  @override
  String get ruleAddSuccess => 'Regel lagt til vellykket';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Er du sikker på at du vil slette denne $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Slett regel';

  @override
  String get ruleDeletedSuccess => 'Regel slettet vellykket';

  @override
  String get ruleDeletedSuccessfully => 'Regel slettet vellykket';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Kunne ikke slette regel: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Kunne ikke slette regel: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Regel slettet vellykket';

  @override
  String get ruleDisabledSuccessfully => 'Regel deaktivert vellykket';

  @override
  String get ruleEnabledSuccessfully => 'Regel aktivert vellykket';

  @override
  String ruleLoadFailed(Object error) {
    return 'Kunne ikke laste regler: $error';
  }

  @override
  String get ruleManagement => 'Regeladministrasjon';

  @override
  String get ruleManagementTitle => 'Regeladministrasjon';

  @override
  String get ruleName => 'Regelnavn';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Regelnavn og innholdsregex kan ikke være tomme';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Regelnavn og telefonnummer kan ikke være tomme';

  @override
  String get ruleNameHint => 'f.eks. Familie, Venner, osv.';

  @override
  String get ruleNameLabel => 'Regelnavn';

  @override
  String get ruleNamePatternRequired => 'Vennligst oppgi regelnavn og mønster';

  @override
  String get ruleNameRequired =>
      'Regelnavn og telefonnummer kan ikke være tomme';

  @override
  String get ruleNotExist => 'Regel finnes ikke eller er slettet';

  @override
  String ruleNotFound(Object error) {
    return 'Regel ikke funnet: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Regel lagret vellykket!';

  @override
  String get ruleSavedSuccessMessage => 'Regel lagret vellykket!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Lagring mislyktes: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Lagring mislyktes: $error';
  }

  @override
  String get ruleSaveSuccess => 'Regel lagret vellykket!';

  @override
  String get rulesExportedSuccessfully => 'Regler eksportert vellykket';

  @override
  String rulesExportedTo(Object path) {
    return 'Regler eksportert til: $path';
  }

  @override
  String get rulesImported => 'Regler importert vellykket';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count regler importert vellykket';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Kunne ikke importere regler: $error';
  }

  @override
  String get ruleStatistics => 'Regelstatistikk';

  @override
  String ruleStatusChanged(Object status) {
    return 'Regel $status vellykket';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operasjon mislyktes: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Regel $status vellykket';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Kunne ikke oppdatere regel: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Regel oppdatert vellykket';

  @override
  String get ruleVerification => 'Regelverifisering';

  @override
  String get save => 'Lagre';

  @override
  String get saveButton => 'Lagre';

  @override
  String get saveButtonLabel => 'LAGRE';

  @override
  String get saveButtonText => 'Lagre';

  @override
  String saveFailed(Object error) {
    return 'Lagring mislyktes: $error';
  }

  @override
  String get saveFilter => 'Lagre filter';

  @override
  String get saveSettings => 'Lagre innstillinger';

  @override
  String saveSettingsFailed(Object error) {
    return 'Kunne ikke lagre innstillinger: $error';
  }

  @override
  String get scamsLikely => 'Sannsynlig svindel';

  @override
  String get search => 'Søk';

  @override
  String get searchContacts => 'Søk i kontakter';

  @override
  String searchError(Object error) {
    return 'Søker feil: $error';
  }

  @override
  String get searchFilters => 'Søke filtre';

  @override
  String get searchForContacts => 'Søk etter kontakter';

  @override
  String get searchHint => 'Søk...';

  @override
  String get searchSettingsSubtitle =>
      'Søk i kontakter, etiketter, svartelister, hvitelister osv.';

  @override
  String get searchSettingsTitle => 'Søkeinnstillinger';

  @override
  String get securityMessage =>
      'Ikke stol på telefonsamtaler. Verifiser alltid kundeservicenummer uavhengig. Aldri del passord, verifiseringskoder, kortnummer eller personlig informasjon.';

  @override
  String get selectActionToPerform =>
      'Velg handlingen som skal utføres når regelen matcher';

  @override
  String get selectActionWhenBlockingCalls =>
      'Velg handling ved blokkering av anrop';

  @override
  String get selectActionWhenRuleMatches => 'Velg handling når regelen matcher';

  @override
  String get selectAll => 'Velg alle';

  @override
  String get selectCountry => 'Velg land';

  @override
  String get selectDateRange => 'Velg datointervall';

  @override
  String get selectedDateRange => 'Valgt datointervall';

  @override
  String selectedItems(Object count) {
    return '$count elementer valgt';
  }

  @override
  String get selectedLabel => 'Valgt:';

  @override
  String get selectExportFormat => 'Velg eksportformat';

  @override
  String get selectLabel => 'Velg etikett';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Vennligst velg en etikett og oppgi et gyldig telefonnummer';

  @override
  String get selectLanguage => 'Velg språk';

  @override
  String get selectMultiple => 'Velg flere';

  @override
  String get selectPeriod => 'Velg periode';

  @override
  String get selectSimCard => 'Velg SIM-kort';

  @override
  String get selectSimSlot => 'Velg SIM-spor';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Velg den spesifikke handlingen som skal utføres når anrop blokkeres';

  @override
  String get selectTag => 'Velg etikett';

  @override
  String get selectTags => 'Velg etiketter';

  @override
  String get selectTrustedDataSource => 'Vennligst velg klarerte datakilder';

  @override
  String get selectYourLanguage => 'Velg ditt språk';

  @override
  String get sender => 'Avsender';

  @override
  String get senderRegexOptional => 'Avsender Regex (valgfritt)';

  @override
  String get serverAddressLabel => 'Serveradresse';

  @override
  String get serviceTypeContact => 'Kontokontakt';

  @override
  String get serviceTypeLabel => 'Tjenestetype';

  @override
  String get serviceTypePhone => 'Telefonabonnement';

  @override
  String get serviceTypePlugin => 'Plugin-oppdatering';

  @override
  String get serviceTypeSms => 'SMS-abonnement';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Sett';

  @override
  String get setEncryptionPassword => 'Angi krypteringspassord';

  @override
  String get setEncryptionPasswordDescription =>
      'Angi krypteringspassord for sikkerhetskopiering og gjenoppretting';

  @override
  String get setEncryptionPasswordLabel => 'Angi krypteringspassord';

  @override
  String get setEncryptionPasswordTitle => 'Angi krypteringspassord';

  @override
  String get setPasswordButton => 'Angi';

  @override
  String get settings => 'Innstillinger';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Innstillinger sikkerhetskopiert til: $path';
  }

  @override
  String get settingsLoaded => 'Innstillinger lastet';

  @override
  String settingsLoadFailed(Object error) {
    return 'Kunne ikke laste innstillinger: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Innstillinger gjenopprettet vellykket. Vennligst start appen på nytt for at endringene skal tre i kraft.';

  @override
  String get settingsSaved => 'Innstillinger lagret';

  @override
  String settingsSaveFailed(Object error) {
    return 'Kunne ikke lagre innstillinger: $error';
  }

  @override
  String get settingsTab => 'Innstillinger';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get setup => 'Oppsett';

  @override
  String get showContactEditDialogStaticMethod =>
      'Statisk metode for å vise kontaktredigeringsdialog';

  @override
  String get showExplanation => 'Vis forklaring';

  @override
  String get silence => 'Stillhet';

  @override
  String get silenceAndNoAnswer => 'Stillhet og ingen svar';

  @override
  String get silenceNoAnswer => 'Stillhet ingen svar';

  @override
  String get silentCallVoiceClone => 'Still anrop stemmekloning';

  @override
  String get silentRules => 'Stille regler';

  @override
  String simCard(Object simNumber) {
    return 'SIM-kort $simNumber';
  }

  @override
  String get simCardColor => 'SIM-kortfarge';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM-kortkonfigurasjon: Angi uavhengige filtreringsregler for hvert SIM-kort';

  @override
  String get simCardFilterRules => 'SIM-kort filterregler';

  @override
  String get simCardFilterRulesDescription =>
      'Angi forskjellige filtreringsregler basert på SIM-kortspor';

  @override
  String get simCardFontSize => 'SIM-kort skriftstørrelse';

  @override
  String get simCardPosition => 'SIM-kort plassering';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Kunne ikke laste SIM-kortinformasjon: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM-regelregler lar deg konfigurere uavhengige filtreringsregler for hvert SIM-spor.';

  @override
  String get simRuleInstructionsTitle => 'SIM-sporregler';

  @override
  String get simRuleManagement => 'Administrasjon av SIM-sporregler';

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
    return 'Kunne ikke laste SIM-data: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'Konfigurasjon av SIM-sporfelt';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Tillater innstilling av filtreringsregler etter SIM-spor';

  @override
  String get simSlotFilterDescription =>
      'Konfigurer uavhengige filtreringsregler for hvert SIM-kort:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM-spor $slotNumber filterinnstillinger';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Kunne ikke laste SIM-spor: $error';
  }

  @override
  String get simSlotManagement => 'Administrasjon av SIM-spor';

  @override
  String simSlotOperationFailed(Object error) {
    return 'Operasjon for SIM-spor mislyktes: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM-sporets posisjon $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM-sporregler: Uavhengige filtreringsstrategier per SIM';

  @override
  String get simSlotRuleListTitle => 'Liste over SIM-sporregler';

  @override
  String get simSlotRuleManagement => 'SIM-sporregler';

  @override
  String get simSlotRuleManagementTitle => 'Regeladministrasjon';

  @override
  String get simSlotSettings => 'SIM-sporinnstillinger';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM-spor $slotNumber';
  }

  @override
  String get skip => 'Hopp over';

  @override
  String get smartCallerId => 'Smart samtaleidentifikasjon';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS-filtrering hjelper deg med å automatisk filtrere søppelpostmeldinger og holde meldingslisten din ren. Du kan sette opp filtreringsregler og varslingsmetoder.';

  @override
  String get smsFilterDisabled => 'SMS-filtrering deaktivert';

  @override
  String get smsFilterEnabled => 'SMS-filtrering aktivert';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'SMS-filterregel lagt til vellykket';

  @override
  String get smsFilterRules => 'SMS-filterregler';

  @override
  String get smsFilterSettings => 'SMS-filterinnstillinger';

  @override
  String get smsHistory => 'SMS-historikk';

  @override
  String get smsManagement => 'SMS-administrasjon';

  @override
  String get smsPermission => 'SMS-tillatelse';

  @override
  String get smsPermissionDescription =>
      'Brukes til å filtrere søppelpostmeldinger.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS-regel lagt til vellykket';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS-regel slettet vellykket';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Kunne ikke laste SMS-regler: $error';
  }

  @override
  String get smsRuleManagement => 'Administrasjon av SMS-regler';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS-regler eksportert vellykket til $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS-regler importert vellykket';

  @override
  String get smsRuleSubscription => 'SMS-regelabonnement';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS-regel oppdatert vellykket';

  @override
  String get smsSettingsSubtitle => 'SMS-filtrering og blokkering av nøkkelord';

  @override
  String get smsSettingsTitle => 'SMS-innstillinger';

  @override
  String get smsSubscription => 'SMS-abonnement';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'SMS-abonnement lagt til vellykket';

  @override
  String get smsSubscriptionRulesDescription =>
      'Abonner på SMS-regel-lister via URL, med støtte for regulære uttrykk. Du kan sette blokkerings- eller tillatelseshandlinger.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Noen tillatelsesforespørsler avslått';

  @override
  String get spamLikely => 'Sannsynligvis søppelpost';

  @override
  String get startColor => 'Startfarge';

  @override
  String get startDate => 'Startdato';

  @override
  String get startUsing => 'Kom i gang';

  @override
  String get statAnswered => 'Besvart';

  @override
  String get statBlocked => 'Blokkert';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Statisk metode for å vise dialogen for samtaleidentifikasjonsinformasjon';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Statisk metode for å vise dialogen for landvalg';

  @override
  String get staticMethodToDisplayDialog =>
      'Statisk metode for å vise dialogen';

  @override
  String get statistics => 'Statistikk';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Eksportfunksjon for statistikk kommer snart';

  @override
  String get statisticsGrid => 'Statistikkrutenett';

  @override
  String get statisticsPageTitle => 'Dataanalyse';

  @override
  String get stirColor => 'STIR-farge';

  @override
  String get stirFontSize => 'STIR skriftstørrelse';

  @override
  String get stirPosition => 'STIR-posisjon';

  @override
  String get storagePermission => 'Lagringstillatelse';

  @override
  String get storagePermissionDescription =>
      'Brukes til å lagre innstillinger og regler.';

  @override
  String get subscribe => 'Abonner';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Abonnement \"$name\" lagt til vellykket';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Er du sikker på at du vil slette dette abonnementet?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Slett abonnement';

  @override
  String get subscriptionDeleted => 'Abonnement slettet';

  @override
  String get subscriptionDeletedSuccessfully => 'Abonnement slettet vellykket';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Kunne ikke slette abonnement: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Abonnement slettet';

  @override
  String get subscriptionEmptyState => 'Ingen abonnementer tilgjengelig';

  @override
  String get subscriptionEmptyText => 'Ingen abonnementer ennå';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Kunne ikke laste abonnementer: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Kunne ikke laste abonnementer: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Administrasjon av abonnementer';

  @override
  String get subscriptionName => 'Abonnementsnavn';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Abonnementsnavn og URL kan ikke være tomme';

  @override
  String get subscriptionNameHint => 'Skriv inn abonnementsnavn';

  @override
  String get subscriptionPageTitle => 'Administrasjon av abonnementer';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Kunne ikke endre abonnementsstatus: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Kunne ikke veksle abonnementsstatus: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Kunne ikke oppdatere abonnement: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Abonnement oppdatert vellykket';

  @override
  String get subscriptionUrl => 'Abonnements-URL';

  @override
  String get subscriptionUrlHint => 'Skriv inn abonnements-URL';

  @override
  String successfullyImportedRules(Object count) {
    return 'Vellykket importert $count regler';
  }

  @override
  String get supportSync => 'Støtt synkronisering';

  @override
  String get survey => 'Undersøkelse';

  @override
  String get syncDevicesButton => 'Synkroniser enheter';

  @override
  String get syncFailed => 'Synkronisering mislyktes';

  @override
  String get syncFailedMessage => 'Synkronisering mislyktes';

  @override
  String get syncFolderNameHint =>
      'Vennligst skriv inn synkroniseringsmappenavn (standard: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Synkroniseringsmappenavn';

  @override
  String get synchronized => 'Synkronisert';

  @override
  String get syncing => 'Synkroniserer...';

  @override
  String get syncNow => 'Synkroniser nå';

  @override
  String get syncNowButton => 'Synk nå';

  @override
  String get syncStatusTitle => 'Synkroniseringsstatus';

  @override
  String get syncStatusUpdatedMessage => 'Synkroniseringsstatus oppdatert';

  @override
  String get syncSuccessful => 'Synkronisering vellykket';

  @override
  String get syncSuccessMessage => 'Synkronisering vellykket';

  @override
  String get syncWithCloudStorage => 'Synkroniser med skytjenester';

  @override
  String get syncWithCloudStorageSubtitle => 'Synkroniser med skytjenester';

  @override
  String get systemFeatures => 'Systemfunksjoner:';

  @override
  String get systemSettingsTitle => 'Systeminnstillinger';

  @override
  String get tabAll => 'Alle';

  @override
  String get tabAnswered => 'Besvart';

  @override
  String get tabBlocked => 'Blokkert';

  @override
  String get tabMissed => 'Ubesvart';

  @override
  String get tabOutgoing => 'Utgående';

  @override
  String tagLabel(String tag) {
    return 'Etikett: $tag';
  }

  @override
  String get tagsUpdated => 'Etiketter oppdatert';

  @override
  String get takeaway => 'Takeaway';

  @override
  String get telecommunication => 'Telekommunikasjon';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get testConnectionButton => 'Test Tilkobling';

  @override
  String get textColorsSetting => 'Tekst- og etikettfarger';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Denne appen er et kraftig verktøy for oppringing-ID som lar deg identifisere og blokkere uønskede anrop.';

  @override
  String get thisWeek => 'Denne Uken';

  @override
  String get timeInterceptor => 'Tidsavskjæring';

  @override
  String get timeInterceptorDescription =>
      'Avskjær/tillat automatisk potensielle anrop basert på anropsfrekvens';

  @override
  String get timeInterceptorExplanation =>
      '• Tidsavskjæring: Avskjær/tillat gjentatte anrop innen kort tid';

  @override
  String get timeInterceptorExplanationContent =>
      'Funksjonen for avskjæring av anropsfrekvens analyserer anropsfrekvensen for å automatisk identifisere og avskjære/tillate hyppige spam-anrop.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Forklaring av avskjæring av anropsfrekvens';

  @override
  String get timeInterceptorSettingsTitle =>
      'Innstillinger for avskjæring av anropsfrekvens';

  @override
  String get timeInterceptorSubtitle =>
      'Avskjær automatisk potensielle spam-anrop basert på anropsfrekvens';

  @override
  String get timeInterceptorTitle => 'Aktiver avskjæring av anropsfrekvens';

  @override
  String get timeWindowDescription =>
      'Still inn tidsvindusstørrelsen for å tillate gjentatte anrop. Anrop fra samme nummer innenfor dette vinduet vil bli tillatt';

  @override
  String timeWindowLabel(int minutes) {
    return 'Avskjæringstid (minutter): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Still inn tidsvindusstørrelsen for å tillate gjentatte anrop. Anrop fra samme nummer innenfor dette vinduet vil bli tillatt';

  @override
  String get today => 'I Dag';

  @override
  String get total => 'Totalt';

  @override
  String get totalBlocked => 'Totalt blokkert';

  @override
  String get totalFiltered => 'Totalt filtrert';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Overfør data mellom enheter eller plattformer';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Overfør data mellom enheter eller plattformer';

  @override
  String get travelTicketing => 'Reisebilletter';

  @override
  String get trend => 'Trend';

  @override
  String get trendChart => 'Trenddiagram';

  @override
  String get tutorial => 'Veiledning';

  @override
  String get type => 'Type';

  @override
  String get unassignedSIMCard => 'Utdelt SIM-kort';

  @override
  String get unknown => 'Ukjent';

  @override
  String get unknownLabel => 'Ukjent Etikett';

  @override
  String get unknownTag => 'Etikett: Ukjent';

  @override
  String get unregisterButton => 'Avregistrer';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Er du sikker på at du vil avregistrere $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Avregistrer enhet';

  @override
  String get unsupportedFileFormat => 'Ugyldig filformat';

  @override
  String get update => 'Oppdater';

  @override
  String get updateAllNow => 'Oppdater alle nå';

  @override
  String get updateCallFilterConfig => 'Oppdater anropsfilterkonfigurasjon';

  @override
  String updateContactFailed(Object error) {
    return 'Kunne ikke oppdatere kontakt: $error';
  }

  @override
  String get updateFavoriteStatus => 'Oppdater favorittstatus';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Kunne ikke oppdatere favorittstatus: $error';
  }

  @override
  String get updateInterval => 'Oppdateringsintervall';

  @override
  String get updateLabelFailed => 'Kunne ikke oppdatere etikett';

  @override
  String get updateNow => 'Oppdater nå';

  @override
  String get updatePlugin => 'Oppdater tillegg';

  @override
  String updatePluginFailed(Object error) {
    return 'Kunne ikke oppdatere tillegg: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Kunne ikke oppdatere regel: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Kunne ikke oppdatere abonnement: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service oppdatert vellykket ($count regler)';
  }

  @override
  String get updateTags => 'Oppdater etiketter';

  @override
  String get useCasesPoint1 =>
      '• Identifiser spam-anrop som ringes på nytt automatisk';

  @override
  String get useCasesPoint2 =>
      '• Avskjær markedsføringsanrop som ringer flere ganger på kort tid';

  @override
  String get useCasesPoint3 => '• Forhindre telefonbombing og trakassering';

  @override
  String get useCasesTitle => 'Bruksområder:';

  @override
  String get useGlobalSettings => 'Bruk globale innstillinger';

  @override
  String get userEmail => 'bruker@eksempel.no';

  @override
  String get usernameLabel => 'Brukernavn';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Bruk standard regex-syntaks for å definere mønstre. Eksempler:';

  @override
  String get validateRegex => 'Valider Regex';

  @override
  String get verificationFailedText => 'Feilet';

  @override
  String get verifiedText => 'Verifisert';

  @override
  String get verify => 'Bekreft';

  @override
  String version(Object version) {
    return 'Versjon: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Bytt VIP-medlemskap med antall markeringer av telefonnummer';

  @override
  String get vipExchangeTitle => 'Bytt VIP-markering';

  @override
  String get watchAd => 'Se annonse';

  @override
  String get watchAdForTemp => 'Se annonse for midlertidige privilegier';

  @override
  String get watchAdForTempDescription =>
      'Se en kort annonse for å midlertidig låse opp noen premiumfunksjoner';

  @override
  String get webDAVConfigTitle => 'WebDAV-konfigurasjon';

  @override
  String get webdavConfigurationTitle => 'WebDAV-konfigurasjon';

  @override
  String get webdavPasswordHint => 'Vennligst oppgi WebDAV-passord';

  @override
  String get webdavServerAddressHint => 'Vennligst oppgi WebDAV-serveradresse';

  @override
  String get webdavUsernameHint => 'Vennligst oppgi WebDAV-brukernavn';

  @override
  String get week => 'Uke';

  @override
  String get weekly => 'Ukentlig';

  @override
  String get weeklyBlockedCallsSummary =>
      'Ukentlig oversikt over blokkerte anrop';

  @override
  String get weeklyChartTitle => 'Ukentlig blokkerte anrop';

  @override
  String get weeklyReport => 'Ukentlig rapport';

  @override
  String get weeklyReportDesc =>
      'Motta ukentlig oppsummeringsrapport over blokkeringsaktivitet';

  @override
  String get welcome => 'Velkommen';

  @override
  String get whitelist => 'Hvitliste';

  @override
  String get whitelistLabel => 'Hvitliste';

  @override
  String get width => 'Bredde';

  @override
  String get wildcardMatchingDescription =>
      'Bruk \'.\' for å matche et hvilket som helst tegn (f.eks. \'123.456\' matcher 123-456)';

  @override
  String get wildcardMatchingTitle => 'Wildcard-matching:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Wildcard-støtte for fleksibel filtrering';

  @override
  String get windowSizeSetting => 'Vindusstørrelse';

  @override
  String get year => 'År';

  @override
  String get yearly => 'Årlig';

  @override
  String get yearlyChartTitle => 'Årlige blokkerte samtaler';

  @override
  String get noSimCardsDetected => 'Ingen SIM-kort oppdaget';

  @override
  String get filterManagementDescription => 'Sett anropsfiltre';

  @override
  String get callerIdCustomizationSubtitle =>
      'Tilpass utseendet på nummerpresentasjon';

  @override
  String get fraudAlerSettingTitle => 'Innstillinger for svindelvarsling';

  @override
  String get fraudAlerSettingSubtitle => 'For å sette opp svindelvarsling';

  @override
  String get enableFraudAlert => 'Aktiver svindelvarsling';

  @override
  String get enableFraudAlertDescription =>
      'Varsel for mistenkelige svindelsamtaler';

  @override
  String get enableVibration => 'Aktiver vibrasjon';

  @override
  String get enableVibrationDescription =>
      'Vibrer når samtalen mistenkes å være svindel';

  @override
  String get notificationSettingsTitle => 'Varslingsinnstillinger';

  @override
  String get useLocalNotification => 'Bruk lokale varsler';

  @override
  String get useLocalNotificationDescription =>
      'Aktiver lokale varsler for innkommende samtaler';

  @override
  String get cancelLocalNotification => 'Lukk lokale varsler';

  @override
  String get useStirNotification => 'Bruk varsel fra STIR';

  @override
  String get useStirNotificationDescription =>
      'Aktiver STIR-varsler for innkommende samtaler';

  @override
  String get cancelLocalNotificationDescription =>
      'Lukk lokale varsler automatisk';

  @override
  String get callerIdSettingsTitle => 'Innstillinger for nummerpresentasjon';

  @override
  String get callerIdSettingsSubtitle =>
      'For å sette opp varsler og visningsmodus for innkommende samtaler';

  @override
  String get purchaseTitle => 'Kjøp';

  @override
  String get purchaseSubtitle => 'For å kjøpe tjenesten';

  @override
  String get callerIdNotificationTitle => 'Informasjon om innkommende samtale';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Nummer: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Blokkert samtale';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Blokkert samtale fra $phoneNumber';
  }

  @override
  String get stirVerified => 'Verifisert';

  @override
  String get stirNotVerified => 'Ikke verifisert';

  @override
  String get stirFailed => 'Verifisering mislyktes';

  @override
  String get stirUnknown => 'Ukjent verifiseringsstatus';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN-verifisering';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage for nummer $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Innstillinger for rullende sikkerhetsmelding';

  @override
  String get messageColor => 'Meldingens farge';

  @override
  String get messageFontSize => 'Meldingens skriftstørrelse';

  @override
  String get messagePosition => 'Meldingens posisjon';

  @override
  String get containerWidth => 'Beholderens bredde';

  @override
  String get scrollSpeed => 'Rullehastighet';

  @override
  String get enableSecurityMessage => 'Aktiver sikkerhetsmelding';

  @override
  String get fraudAlertTitle => 'Svindelvarsling';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Potensiell svindelsamtale fra $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Kunne ikke laste regler: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Kunne ikke laste anropslogg: $error';
  }

  @override
  String get noBlockedTypeData => 'Ingen data tilgjengelig for blokkert type';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importer $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName importert vellykket, totalt $count poster importert';
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
    return '$entityTypeName eksportert vellykket';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Kunne ikke eksportere $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Skysynkroniseringstjeneste';

  @override
  String get membershipCenter => 'Medlemsenter';

  @override
  String get redeemVipWithMarks => 'Løs inn VIP med poeng';

  @override
  String get currentMarkCount => 'Nåværende poengsum';

  @override
  String get markMoreNumbersForMore => 'Merk flere numre for flere poeng';

  @override
  String get noAds => 'Ingen reklame';

  @override
  String get cloudBackup => 'Skylagring';

  @override
  String get callerIdEnhancement => 'Forbedring av nummerpresentasjon';

  @override
  String get voiceRecognition => 'Talegjenkjenning';

  @override
  String get feature => 'Funksjon';

  @override
  String get normalUser => 'Vanlig bruker';

  @override
  String get vipUser => 'VIP-bruker';

  @override
  String get temporaryVip => 'Midlertidig VIP';

  @override
  String get removeAds => 'Fjern reklame';

  @override
  String get unknownAction => 'Ukjent handling';

  @override
  String get settingsBackup => 'Sikkerhetskopi av innstillinger ';

  @override
  String get allServicesStatusTitle => 'Nåværende tjenestestatus';

  @override
  String get allServicesStatusSubtitle =>
      'Nåværende status for hver skytjeneste';

  @override
  String get redirect => 'Omdiriger';

  @override
  String get notify => 'Varsle';

  @override
  String get log => 'Logg';

  @override
  String get custom => 'Egendefinert';

  @override
  String get allowActionDescription =>
      'Samtaler vil bli tillatt, selv om nummeret er på blokkeringslisten.';

  @override
  String get blockActionDescription =>
      'Samtaler vil bli blokkert og vist i anropsloggen.';

  @override
  String get silenceActionDescription =>
      'Samtaler vil bli dempet, men vist i anropsloggen.';

  @override
  String get noneActionDescription =>
      'Ingen spesiell handling vil bli utført for samtalen.';

  @override
  String get redirectActionDescription =>
      'Omdiriger samtalen til et spesifisert nummer.';

  @override
  String get labelActionDescription =>
      'Legg til en etikett på samtalen for enkel identifikasjon.';

  @override
  String get notifyActionDescription => 'Send et varsel når en samtale mottas.';

  @override
  String get logActionDescription =>
      'Loggfør samtalens informasjon uten å utføre andre handlinger.';

  @override
  String get customActionDescription => 'Utfør en egendefinert handling.';

  @override
  String get synced => 'Synkronisert';

  @override
  String get needVipAccess =>
      'Du trenger VIP-tilgang for å bruke denne funksjonen';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importer eller eksporter $entityTypeName-data';
  }

  @override
  String get importExportTitle => 'Import/Eksport';

  @override
  String get noPhoneRules => 'Ingen telefonregler funnet';

  @override
  String get noRegexRules => 'Ingen regex-regler funnet';

  @override
  String get noAllowedBlockedRules => 'Ingen tillatte/blokkerte regler funnet';

  @override
  String get importExport => 'Import/Eksport';

  @override
  String get filterByAction => 'Filtrer etter handling';

  @override
  String get upgradeToVip => 'Oppgrader til VIP';

  @override
  String get batteryOptimizationPermission => 'Batterioptimalisering';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Tillat appen å kjøre i bakgrunnen for å tilby tjenester som anrops-ID.';

  @override
  String get permissionTitle => 'Spesialtillatelser';

  @override
  String get permissionSubtitle =>
      'Administrer overlegg- og batterioptimaliseringstillatelser';

  @override
  String get themeSettingsTitle => 'Temainnstillinger';

  @override
  String get themeSettingsSubtitle => 'Velg ditt favorittema';

  @override
  String get databaseSyncTitle => 'Databasesynkronisering';

  @override
  String get countrySyncSettingsTitle =>
      'Landbaserte databasesynkroniseringsinnstillinger';

  @override
  String get countrySyncSettingsSubtitle => 'Velg land for datasynkronisering';

  @override
  String get countryDataDisclaimer =>
      'Vær oppmerksom på: Databasen kan mangle data for alle spesifikke land eller regioner.';

  @override
  String get editSubscription => 'Rediger abonnement';

  @override
  String get searchByNameOrPhoneNumber => 'Søk etter navn eller telefonnummer';

  @override
  String get allowedBlockedRulesInfo =>
      'Tillatte/blokkerte regler brukes til å matche anrop mot spesifikke telefonnumre, som har høyest prioritet.';

  @override
  String get searchPhoneRulesHint => 'Søk etter telefonregler';

  @override
  String get phoneRulesInfo =>
      'Telefonregler brukes til å matche anrop mot spesifikke telefonnumre, som har lavere prioritet. Noen kommer fra telefonregelabonnementene.';

  @override
  String get searchSubscriptionsHint => 'Søk etter abonnementer';

  @override
  String get searchPluginsHint => 'Søk etter plugins';

  @override
  String get searchLabelsHint => 'Søk etter etiketter';

  @override
  String get pluginDescription => 'Pluginbeskrivelse';

  @override
  String get enterPluginDescription => 'Skriv inn pluginbeskrivelse';

  @override
  String get searchRegexRulesHint => 'Søk etter regex-regler';

  @override
  String get regexRulesInfo =>
      'Regex-regler brukes til å filtrere anrop basert på Regex-mønstre.';

  @override
  String get searchMarkedPhonesHint => 'Søk etter markerte telefoner';

  @override
  String get searchContactSubscriptionsHint => 'Søk etter kontaktabonnementer';

  @override
  String get showAllContacts => 'Vis alle kontakter';

  @override
  String get showFavorites => 'Vis favoritter';

  @override
  String get manualEntry => 'Manuell oppføring info';

  @override
  String get scriptSaved => 'Skript lagret';

  @override
  String editScriptFor(String pluginName) {
    return 'Rediger skript for $pluginName';
  }

  @override
  String get saveScript => 'Lagre skript';

  @override
  String get testPlugin => 'Test plugin';

  @override
  String get description => 'Beskrivelse';

  @override
  String get accessTargetUrl => 'Tilgang til målenettadresse';

  @override
  String get result => 'Resultat';

  @override
  String get editScript => 'Rediger skript';

  @override
  String get numberFormat => 'Nummerformat';

  @override
  String get nationalNumber => 'Nasjonalt nummer';

  @override
  String get e164Number => 'E164-nummer';

  @override
  String get pluginRulesInfo =>
      'Av sikkerhetshensyn, vennligst bruk plugins fra pålitelige kilder. Bruk gjerne malene våre for å lage dine egne egendefinerte plugins!';

  @override
  String get advancedMode => 'Avansert modus';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Vennligst skriv inn minst ett nummer.';

  @override
  String get openInWebView => 'Åpne i WebView';

  @override
  String get pluginLabel => 'Plugin-etikett';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Bakgrunnsfarge for melding';

  @override
  String get clearAllCallLogs => 'Slett alle anropslogger';

  @override
  String get clearAllCallLogsConfirmation =>
      'Bekreft for å slette alle anropslogger';

  @override
  String get allCallLogsCleared => 'Alle anropslogger er slettet';

  @override
  String get unblocked => 'Fjernet blokkering';

  @override
  String get blockNumber => 'Blokker nummer';

  @override
  String get blockNumberSuccess => 'Nummer blokkert med suksess';

  @override
  String get blockNumberFailed => 'Nummerblokkering mislyktes';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Er du sikker på at du vil fjerne blokkeringen av $phoneNumber?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Ringer $phoneNumber...';
  }

  @override
  String get viewDetails => 'Vis detaljer';

  @override
  String get unblock => 'Fjern blokkering';

  @override
  String get unblockNumber => 'Fjern blokkering av nummer';

  @override
  String get unblockNumberSuccess => 'Nummer fjernet blokkering med suksess';

  @override
  String get unblockNumberFailed => 'Fjerning av nummerblokkering mislyktes';

  @override
  String get serviceNotAvailable => 'Tjeneste ikke tilgjengelig';

  @override
  String get callingNumberFailed => 'Nummerpåringing mislyktes';

  @override
  String get listView => 'Listevisning';

  @override
  String get timelineView => 'Tidslinjevisning';

  @override
  String get nameCannotBeEmpty => 'Navn kan ikke være tomt';

  @override
  String get selectAction => 'Velg handling';

  @override
  String get selectTargetService => 'Velg måltjeneste';

  @override
  String get callDetails => 'Anropsdetaljer';

  @override
  String get callType => 'Anropstype';

  @override
  String get callTime => 'Anropstid';

  @override
  String get numberInvalidFormat => 'Nummer i ugyldig format';

  @override
  String get membershipFeature => 'Medlemskapsfunksjon';

  @override
  String get medium => 'Medium';

  @override
  String get verificationReport => 'Verifikasjonsrapport';

  @override
  String get finalRisk => 'Endelig risiko';

  @override
  String get simState => 'SIM-tilstand';

  @override
  String get ipCountry => 'IP-land';

  @override
  String get simCountry => 'SIM-land';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Nummermatch';

  @override
  String get support => 'Støtte';

  @override
  String get rewardedAdService => 'Belønnede annonsertjenester';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Du har allerede VIP-privilegier (unntatt annonser)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Du har allerede midlertidige privilegier, utløpsdato: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Du må se $count flere annonser for å få midlertidige VIP-privilegier';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Du har fått $days dagers midlertidige kjøpsprivilegier. Utløpsdato: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Midlertidig kjøpsprivilegium har utløpt';

  @override
  String get loadingAd => 'Laster annonse...';

  @override
  String get earnedTempVip => 'Opptjent midlertidig VIP';

  @override
  String get vipExchangeService => 'VIP-utvekslingstjeneste';

  @override
  String get marksInsufficient => 'Utilstrekkelig antall merker for utveksling';

  @override
  String get invalidExchangeRule => 'Ugyldig utvekslingsregel';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Vellykket utvekslet for $description, utløpsdato: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Utveksling mislyktes: $error';
  }

  @override
  String get vip3DaysWithAds =>
      '3-dagers VIP med annonser (kun synkronisering)';

  @override
  String get vip5DaysNoAds => '5-dagers fullt utstyrt annonsefri VIP';

  @override
  String get vip7DaysNoAds => '7-dagers fullt utstyrt annonsefri VIP';

  @override
  String get noNotifications => 'Ingen varsler';

  @override
  String get clearAllNotifications => 'Slett alle varsler';

  @override
  String get clearAllNotificationsConfirmation =>
      'Bekreft for å slette alle varsler';

  @override
  String get allNotificationsCleared => 'Alle varsler er slettet';

  @override
  String get clearButton => 'Tøm';

  @override
  String get justNow => 'Nettopp';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutter siden',
      one: '1 minutt siden',
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
      other: '$count dager siden',
      one: '1 dag siden',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'I går';

  @override
  String get deletionProposal => 'Slettingsforslag';

  @override
  String get deletionProposals => 'Slettingsforslag';

  @override
  String get createProposal => 'Opprett forslag';

  @override
  String get createProposalTitle => 'Opprett slettingsforslag';

  @override
  String get reason => 'Årsak';

  @override
  String get reasonOutdated => 'Utdatert nummer';

  @override
  String get reasonPrivacy => 'Personvernhensyn';

  @override
  String get reasonNotInService => 'Ikke i bruk';

  @override
  String get reasonWronglyIdentified => 'Feilidentifisert';

  @override
  String get reasonInaccurateInfo => 'Unøyaktig informasjon';

  @override
  String get reasonWrongMarked => 'Feilaktig merket';

  @override
  String get reasonOther => 'Annet';

  @override
  String get submit => 'Send inn';

  @override
  String get cancel => 'Avbryt';

  @override
  String get proposalStatus => 'Status';

  @override
  String get statusPending => 'Venter';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusCompleted => 'Fullført';

  @override
  String get statusExpired => 'Utløpt';

  @override
  String get riskLevel => 'Risikonivå';

  @override
  String get riskLevelVerified => 'Verifisert';

  @override
  String get riskLevelLow => 'Lav';

  @override
  String get riskLevelHigh => 'Høy';

  @override
  String get riskLevelUnknown => 'Ukjent';

  @override
  String get votingProgress => 'Avstemningsprogresjon';

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
    return 'Totalt: $count';
  }

  @override
  String get voteAgree => 'Enig';

  @override
  String get voteDisagree => 'Uenig';

  @override
  String createdAt(String date) {
    return 'Opprettet: $date';
  }

  @override
  String get showReport => 'Vis rapport';

  @override
  String get hideReport => 'Skjul rapport';

  @override
  String get proposalStatistics => 'Forslagsstatistikk';

  @override
  String get totalProposals => 'Totalt antall forslag';

  @override
  String get activeProposals => 'Aktive forslag';

  @override
  String get completedProposals => 'Fullførte forslag';

  @override
  String get myVotes => 'Mine stemmer';

  @override
  String get proposalCreated => 'Forslag opprettet vellykket';

  @override
  String get proposalCreateFailed => 'Kunne ikke opprette forslag';

  @override
  String get voteSubmitted => 'Stemme sendt inn vellykket';

  @override
  String get voteSubmitFailed => 'Kunne ikke sende inn stemme';

  @override
  String get noProposalsFound => 'Ingen forslag funnet';

  @override
  String get loadingProposals => 'Laster forslag...';

  @override
  String get refreshProposals => 'Oppdater forslag';

  @override
  String get totalPendingProposals => 'Totalt antall ventende forslag';

  @override
  String get highRisk => 'Høy risiko';

  @override
  String get mediumRisk => 'Middels risiko';

  @override
  String get lowRisk => 'Lav risiko';

  @override
  String get communityImpact => 'Samfunnspåvirkning';

  @override
  String get criticalIssues => 'Kritiske problemer';

  @override
  String get communityParticipation => 'Samfunnsdeltakelse';

  @override
  String get noActivity => 'Ingen aktivitet';

  @override
  String get low => 'Lav';

  @override
  String get moderate => 'Moderat';

  @override
  String get high => 'Høy';

  @override
  String get veryHigh => 'Veldig høy';

  @override
  String get voted => 'Stemte';

  @override
  String get communityVotes => 'Samfunnsstemmer';

  @override
  String get waitingForMoreVotes => 'Venter på flere samfunnsstemmer';

  @override
  String get proposalProcessed => 'Dette forslaget er behandlet';

  @override
  String get supported => 'STØTTET';

  @override
  String get opposed => 'IMOT';

  @override
  String get approved => 'GODKJENT';

  @override
  String get rejected => 'AVSLÅTT';

  @override
  String get completed => 'FULLFØRT';

  @override
  String get pending => 'VENTER';

  @override
  String get critical => 'Kritisk';

  @override
  String get oppose => 'Motsett deg';

  @override
  String get veryLow => 'Veldig lav';

  @override
  String get deletionProposalNotificationDescription =>
      'Varsler om resultater og oppdateringer fra avstemning om slettingsforslag.';

  @override
  String get deletionProposalCreated => 'Slettingsforslag opprettet';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Ditt slettingsforslag for $phoneNumber er sendt inn for gjennomgang av samfunnet.';
  }

  @override
  String get proposalApproved => 'Forslag godkjent ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Slettingsforslaget for $phoneNumber er godkjent av samfunnet ($supportPercentage% støtte, $totalVotes stemmer).';
  }

  @override
  String get proposalRejected => 'Forslag avvist ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Slettingsforslaget for $phoneNumber er avvist av samfunnet ($supportPercentage% støtte, $totalVotes stemmer).';
  }

  @override
  String get communityVotingStarted => 'Samfunnsavstemning startet';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Et nytt slettingsforslag for $phoneNumber er nå åpent for samfunnsavstemning.';
  }

  @override
  String get votingCompleted => 'Avstemning fullført';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Samfunnsavstemning for $phoneNumber er avsluttet. Resultat: $result ($supportPercentage% støtte).';
  }

  @override
  String get newVoteReceived => 'Ny stemme mottatt';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Noen stemte for å $voteType sletting av $phoneNumber. Nåværende stemmer: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Kunne ikke laste antall stemmer';

  @override
  String get voteCount => 'Antall stemmer';

  @override
  String get deletionProposalInfo => 'Informasjon om slettingsforslag';

  @override
  String get deletionProposalDescription =>
      'Forslå numre for sletting som bryter med samfunnets retningslinjer. Din deltakelse bidrar til å holde plattformen trygg.';

  @override
  String get voteToEarnVip => 'Stem på forslag for å tjene VIP-privilegier!';

  @override
  String get voteFailed => 'Stemming mislyktes';

  @override
  String get searchProposals => 'Søk i forslag';

  @override
  String get defaultNotifications => 'Standardvarsler';

  @override
  String get defaultNotificationsDescription =>
      'Standard varslingskanal for appen.';

  @override
  String get blockedCallNotifications => 'Blokkerte anropsvarsler';

  @override
  String get blockedCallNotificationsDescription =>
      'Viser informasjon om blokkerte samtaler.';

  @override
  String get stirVerification => 'STIR/SHAKEN-bekreftelse';

  @override
  String get stirVerificationDescription =>
      'Viser STIR/SHAKEN-bekreftelsesresultater for numre.';

  @override
  String get fraudAlerts => 'Svindelvarsler';

  @override
  String get fraudAlertsDescription =>
      'Viser advarsler for potensielt svindelaktige samtaler.';

  @override
  String get notificationFrequencyDescription =>
      'Velg hvor ofte du mottar varsler om nye sletteforslag. Du kan motta dem umiddelbart, i samlinger, eller med et egendefinert intervall.';

  @override
  String get immediateNotifications => 'Umiddelbart';

  @override
  String get immediateNotificationsDescription =>
      'Motta et varsel så snart et forslag er opprettet.';

  @override
  String get batchNotifications => 'I samlinger';

  @override
  String get batchNotificationsDescription =>
      'Motta en oppsummering av varsler periodisk.';

  @override
  String get customNotifications => 'Egendefinert';

  @override
  String get customNotificationsDescription =>
      'Definer ditt eget intervall for mottak av varsler.';

  @override
  String get customFrequency => 'Egendefinert frekvens';

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
  String get pendingProposals => 'Avventende forslag';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count avventende forslag',
      one: '1 avventende forslag',
      zero: 'ingen avventende forslag',
    );
    return 'Du har $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Retningslinjer';

  @override
  String get reportingGuidelines =>
      '• Rapporter kun numre som er genuint problematiske\n• Oppgi nøyaktige og detaljerte årsaker\n• Velg passende risikonivå basert på alvorlighetsgrad\n• Falske rapporter kan føre til kontobegrensninger';

  @override
  String get riskLevelLabel => 'Risikonivå';

  @override
  String get riskLevelDescription => 'Risikonivå for nummeret';

  @override
  String get phoneNumberMinDigits => 'Telefonnummer må være minst 7 sifre';

  @override
  String get provideDetailedExplanation =>
      'Gi en detaljert forklaring (minimum 10 tegn)';

  @override
  String get reasonMinCharacters => 'Årsak må være minst 10 tegn';

  @override
  String get countryCodeTwoLetters => 'Landskode (ISO 3166-1 alfa-2) *';

  @override
  String get countryCodeLabel => 'Landskode (ISO 3166-1 alfa-2) *';

  @override
  String get countryCodeHint => 'f.eks. NO, US, CN';

  @override
  String get countryCodeRequired => 'Landskode er påkrevd';

  @override
  String get countryCodeLengthError => 'Landskode må være 2 bokstaver';

  @override
  String get phoneNumberLengthError => 'Telefonnummer må være minst 7 sifre';

  @override
  String get reasonHint => 'Gi en detaljert forklaring (minimum 10 tegn)';

  @override
  String get reasonRequired => 'Årsak er påkrevd';

  @override
  String get reasonLengthError => 'Årsak må være minst 10 tegn';

  @override
  String get guidelinesTitle => 'Retningslinjer';

  @override
  String get guidelinesText =>
      '• Rapporter kun numre som er genuint problematiske\n• Oppgi nøyaktige og detaljerte årsaker\n• Velg passende risikonivå basert på alvorlighetsgrad\n• Falske rapporter kan føre til kontobegrensninger';

  @override
  String get riskLevelCritical => 'Kritisk';

  @override
  String get riskLevelMedium => 'Middels';

  @override
  String get riskLevelVeryLow => 'Veldig lav';

  @override
  String get riskDescriptionVeryLow =>
      'Veldig lav - Mindre irritasjon, sjeldne samtaler';

  @override
  String get riskDescriptionLow => 'Lav - Av og til uønskede samtaler';

  @override
  String get riskDescriptionMedium => 'Middels - Vanlig spam eller telefonsalg';

  @override
  String get riskDescriptionHigh =>
      'Høy - Vedvarende trakassering eller svindelforsøk';

  @override
  String get riskDescriptionCritical =>
      'Kritisk - Farlige svindel eller trusler';

  @override
  String get notificationFrequencyTitle => 'Varslingsfrekvens';

  @override
  String get notificationFrequencyLabel => 'Varslingsfrekvens (timer)';

  @override
  String errorMessage(String error) {
    return 'Feil: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Stemmer: $totalVotes ($supportPercentage% støtte)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Støtte ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Imot ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Akkurat nå';

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
  String get notificationFrequencyHours => 'Varslingsfrekvens (Timer)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes stemmer ($supportPercentage% støtte)';
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
  String get importantNoticeTitle => 'Viktig merknad';

  @override
  String get dataSourceDisclaimer =>
      'Numre hentes fra internett og brukerinnlegg. Vi kan ikke garantere at et nummer, etter å ha blitt slettet, ikke blir re-sendt av andre brukere eller kilder. Vennligst søk aktivt og verifiser informasjonen.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Sted';

  @override
  String get simCardTitle => 'SIM-kort';

  @override
  String get liveActivitiesSettingsTitle =>
      'Innstillinger for Live Aktiviteter';

  @override
  String get elementsSettingsTitle => 'Innstillinger for Elementer';

  @override
  String get liveActivityMode => 'Live Aktivitet';

  @override
  String get liveActivityModeDescription =>
      'Viser samtaleinformasjon som et vedvarende varsel på låseskjermen og i Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'Telefonnummer Type';

  @override
  String get liveActivitiesTestEndActivity => 'Avslutt aktivitet';

  @override
  String get liveActivitiesTestSendNewActivity => 'Send ny aktivitet';

  @override
  String get liveActivitiesTestUpdateActivity => 'Oppdater aktivitet';

  @override
  String get liveActivityControlsTitle => 'Kontroller for Live Aktivitet';

  @override
  String get liveActivitiesTestTitle => 'Live Aktiviteter Test';

  @override
  String get liveActivitiesTestSubtitle => 'Test Live Aktivitet-varselet.';

  @override
  String get liveNotificationCustomizationTitle => 'Tilpasning av Live Varsler';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Tilpass utseendet til live varsler.';

  @override
  String get notification_instructions =>
      'Instruksjoner:\n1. Trykk på \"SEND\" for å opprette eller oppdatere et varsel.\n2. Gå til startskjermen eller dra ned varslingspanelet for å se resultatet.\n3. Trykk på \"AVSLUTT\" for å lukke varselet.';

  @override
  String get autoCancelNotification => 'Automatisk kanseller varsel';

  @override
  String get autoCancelNotificationDescription =>
      'Hvis merket, vil varselet automatisk lukkes når brukeren trykker på det.';

  @override
  String get setDelayTime => 'Sett forsinkelsestid';

  @override
  String get proposalDetails => 'Forslagsdetaljer';

  @override
  String get filterByStatus => 'Filtrer etter status';

  @override
  String get proposalNotFound => 'Forslag ikke funnet';

  @override
  String get processed => 'Behandlet';

  @override
  String get showAll => 'Vis alle';

  @override
  String get filterAndSortTitle => 'Filtrer og sorter';

  @override
  String get filterVerifiedOwner => 'Filtrer verifisert eier';

  @override
  String get filterBy => 'Filtrer etter';

  @override
  String get sortOldest => 'Sorter eldste';

  @override
  String get sortNewest => 'Sorter nyeste';

  @override
  String get sortMostPopular => 'Sorter mest populære';

  @override
  String get sortLeastPopular => 'Sorter minst populære';

  @override
  String get sortBy => 'Sorter etter';

  @override
  String get simRulesNotFound => 'SIM-regler ikke funnet';

  @override
  String get simSlotRules => 'SIM-sporet regler';

  @override
  String get noSimCardDetected => 'Ingen SIM-kort oppdaget';

  @override
  String get invalidSimData => 'Ugyldige SIM-data';

  @override
  String get simCardData => 'SIM-kortdata';

  @override
  String get simSlot => 'SIM-sporet';

  @override
  String get enableFiltering => 'Aktiver filtrering';

  @override
  String get detailedSettingsTitle => 'Detaljerte innstillinger';

  @override
  String get entryPointViewTitle => 'Inngangspunktvisning';

  @override
  String get callTypeRejected => 'Avvist';

  @override
  String get callTypeSilenced => 'Dempet';

  @override
  String get callTypeVoicemail => 'Talepost';

  @override
  String get callTypeUnknownIntercept => 'Ukjent avskjæring';

  @override
  String andMoreItems(int count) {
    return 'og $count flere elementer';
  }
}
