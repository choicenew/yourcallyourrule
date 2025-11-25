// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get aboutContactSubscription => 'Teave kontaktide tellimuse kohta';

  @override
  String get aboutLabels => 'Teave siltide kohta';

  @override
  String get aboutPhoneSubscriptionRules =>
      'Teave telefoni tellimuse reeglite kohta';

  @override
  String get aboutPhoneSubscriptions => 'Teave telefoni tellimuste kohta';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Telli URL-i kaudu telefonireeglite loendeid, värskenda reegleid automaatselt. Toetab JSON, CSV vormingus reeglifaile.';

  @override
  String get aboutSmsFilter => 'Teave SMS-i filtreerimise kohta';

  @override
  String get aboutSmsSubscriptionRules =>
      'Teave SMS-i tellimuse reeglite kohta';

  @override
  String get aboutSubtitle => 'Rakenduse versioon ja juriidiline teave';

  @override
  String get aboutTitle => 'Teave';

  @override
  String get action => 'Toiming';

  @override
  String get actionAll => 'Kõik';

  @override
  String get actionAllow => 'Luba';

  @override
  String get actionBlock => 'Blokeeri';

  @override
  String get actionFilterAll => 'Kõik filtrid';

  @override
  String get actionFilterTitle => 'Filtreeri toimingu tüübi järgi';

  @override
  String get actionFilterTooltip => 'Toimingu filter';

  @override
  String get actionNone => 'Märkus';

  @override
  String get actionSilence => 'Vaigista';

  @override
  String actionTag(Object actionType) {
    return 'Toiming: $actionType';
  }

  @override
  String get actionType => 'Toimingu tüüp';

  @override
  String get actionUnknown => 'Tundmatu';

  @override
  String get add => 'Lisa';

  @override
  String get addAllowedBlockedRule => 'Lisa lubamis-/blokeerimisreegel';

  @override
  String get addAllowSubscription => 'Lisa lubamisrežiimi tellimus';

  @override
  String get addBlockSubscription => 'Lisa blokeerimisrežiimi tellimus';

  @override
  String get addContactButton => 'Lisa kontakt';

  @override
  String addContactFailed(Object error) {
    return 'Kontakti lisamine ebaõnnestus: $error';
  }

  @override
  String get addedToAllowedRules => 'Lisatud lubatud reeglitesse';

  @override
  String get addedToBlacklist => 'Lisatud musta nimekirja';

  @override
  String get addedToBlockedRules => 'Lisatud blokeeritud reeglitesse';

  @override
  String get addedToFavoriteContacts => 'Lisatud lemmikkontaktidesse';

  @override
  String get addedToFavorites => 'Lisatud lemmikutesse';

  @override
  String get addedToWhitelist => 'Lisatud valgesse nimekirja';

  @override
  String get addFavorite => 'Lisa lemmik';

  @override
  String get addFilter => 'Lisa filter';

  @override
  String get addLabel => 'Lisa silt';

  @override
  String get addLabelButton => 'Lisa silt';

  @override
  String addLabelFailed(Object error) {
    return 'Sildi lisamine ebaõnnestus: $error';
  }

  @override
  String get addLabelToCall => 'Lisa silt kõnekirjeldusse';

  @override
  String get addName => 'Lisa nimi';

  @override
  String get addNoneSubscription => 'Lisa ükski tellimus';

  @override
  String get addOrEditContactInfo =>
      'Kasutatakse kontaktteabe lisamiseks või muutmiseks';

  @override
  String get addPhoneMark => 'Lisa telefoni märge';

  @override
  String get addPhoneNumberRule => 'Lisa telefoninumbri reegel';

  @override
  String get addPlugin => 'Lisa pistikprogramm';

  @override
  String get addPluginFailed => 'Pistikprogrammi lisamine ebaõnnestus';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Pistikprogrammi lisamine ebaõnnestus: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Lisa pistikprogramm kohalikust failist';

  @override
  String get addPluginFromUrl => 'Lisa pistikprogramm URL-ist';

  @override
  String get addRegexRule => 'Lisa regulaaravaldisreegel';

  @override
  String get addRule => 'Lisa reegel';

  @override
  String get addRuleButton => 'Lisa reegel';

  @override
  String addRuleFailed(Object error) {
    return 'Reegli lisamine ebaõnnestus: $error';
  }

  @override
  String get addRuleTooltip => 'Lisa reegel';

  @override
  String get addSilenceSubscription => 'Lisa vaikimisi tellimus';

  @override
  String get addSimRuleButton => 'Lisa SIM-reegel';

  @override
  String get addSmsFilterRule => 'Lisa SMS-i filterreegel';

  @override
  String get addSmsRule => 'Lisa SMS-reegel';

  @override
  String get addSmsSubscription => 'Lisa SMS-tellimus';

  @override
  String get addSubscription => 'Lisa tellimus';

  @override
  String get addSubscriptionButton => 'Lisa tellimus';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Tellimuse lisamine ebaõnnestus: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Lisa tellimus';

  @override
  String get addToAllowedRules => 'Lisa lubatud reeglitesse';

  @override
  String get addToBlacklist => 'Lisa musta nimekirja';

  @override
  String get addToBlockedRules => 'Lisa blokeeritud reeglitesse';

  @override
  String get addToFavoriteContacts => 'Lisa lemmikkontaktidesse';

  @override
  String get addToFavorites => 'Lisa lemmikutesse';

  @override
  String get addToRules => 'Lisa reeglitesse';

  @override
  String get addToWhitelist => 'Lisa valgesse nimekirja';

  @override
  String get adPlaceholder => 'Reklaami koht';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Kõik';

  @override
  String get allCallsTab => 'Kõik';

  @override
  String get allDataClearedSuccessfully => 'Kõik andmed kustutati edukalt';

  @override
  String get allow => 'Luba';

  @override
  String get allowAllAllowRules => 'Luba kõik lubamisreeglid';

  @override
  String get allowAllAllowRulesDesc => 'Luba kõnesid lubamisreeglitest';

  @override
  String get allowAllBlacklistedNumbers => 'Luba kõik blokeeritud numbrid';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'Luba kõnesid mustast nimekirjast';

  @override
  String get allowAllBlockRules => 'Luba kõik blokeerimisreeglid';

  @override
  String get allowAllBlockRulesDesc => 'Luba kõnesid blokeerimisreeglitest';

  @override
  String get allowAllowedNumbers => 'Luba lubatud numbrid';

  @override
  String get allowAllowedNumbersDesc => 'Luba kõnesid valgest nimekirjast';

  @override
  String get allowBlock => 'Luba/Blokeeri';

  @override
  String get allowBlockedNumbers => 'Luba blokeeritud numbrid';

  @override
  String get allowBlockedNumbersDesc => 'Luba kõnesid mustast nimekirjast';

  @override
  String get allowedBlockedRule => 'Lubamis-/blokeerimisreegel';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Muuda lubamis-/blokeerimisreeglit';

  @override
  String get allowedBlockedRuleManagement =>
      'Lubamis-/blokeerimisreeglite haldamine';

  @override
  String get allowNonExceededNumbers => 'Luba ületamata numbrid';

  @override
  String get allowNonExceededNumbersDescription =>
      'Luba automaatselt numbrid, mis ei ületa loenduse piirmäära';

  @override
  String get allowRegexAllowRules => 'Luba regulaaravaldislubamise reeglid';

  @override
  String get allowRegexAllowRulesDesc =>
      'Luba regulaaravaldiseregistrite töötlemine lubamisreeglitele';

  @override
  String get allowRegexAllowRulesDescription =>
      'Luba regulaaravaldisepõhised lubamisreeglid';

  @override
  String get allowRegexBlockRules =>
      'Luba regulaaravaldiseblokeerimise reeglid';

  @override
  String get allowRegexBlockRulesDesc =>
      'Luba regulaaravaldiseregistrite töötlemine blokeerimisreeglitele';

  @override
  String get allowRegexBlockRulesDescription =>
      'Luba regulaaravaldisepõhised blokeerimisreeglid';

  @override
  String get allowRule => 'Lubamisreegel';

  @override
  String get allowRules => 'Lubamisreeglid';

  @override
  String get allowWhitelistedNumbers => 'Luba valitud numbrid';

  @override
  String get allowWhitelistedNumbersDescription => 'Luba kõik valitud numbrid';

  @override
  String get allPermissionsGranted => 'Kõik load on antud';

  @override
  String get allSettingsCompleted => 'Kõik seaded on täidetud.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Kõik värskendused lõpetatud ($count reeglit)';
  }

  @override
  String get answerThenHangup => 'Vasta ja siis riputa';

  @override
  String get appLegalese =>
      '© 2023 Sinu kõne Sinu reegel. Kõik õigused kaitstud.';

  @override
  String get applicationSoftware => 'Rakenduse tarkvara';

  @override
  String get apply => 'Rakenda';

  @override
  String get appName => 'Sinu kõne Sinu reegel';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Volitus nurjus: Palun kontrollige kliendi ID-d ja võtit';

  @override
  String get authorizationFailedMessage => 'Volitus nurjus';

  @override
  String get authorizationSuccessMessage => 'Volitus õnnestus';

  @override
  String get authorizeLoginButton => 'Volita sisselogimine';

  @override
  String get automotiveIndustry => 'Autotööstus';

  @override
  String get autoSyncLabel => 'Automaatne sünkronimine';

  @override
  String get autoUpdate => 'Automaatne värskendus';

  @override
  String get autoUpdateDescription =>
      'Määrake tellimuste automaatse värskendamise intervallid või värskendage käsitsi';

  @override
  String get autoUpdateSettings => 'Automaatse värskenduse seaded';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Hallake reeglite ja pistikprogrammide automaatseid värskendusi';

  @override
  String get autoUpdateSettingsTitle => 'Automaatse värskenduse seaded';

  @override
  String get autoUpdateSubtitle =>
      'Hallake reeglite ja pistikprogrammide automaatseid värskendusi';

  @override
  String get autoUpdateTitle => 'Automaatne värskendus';

  @override
  String get avatarBorderColor => 'Avatari piirjooni värv';

  @override
  String get avatarBorderSize => 'Avatari piirjooni suurus';

  @override
  String get avatarIconSizesSetting => 'Avatari ja ikooni suurused';

  @override
  String get avatarPosition => 'Avatari asukoht';

  @override
  String get avatarSize => 'Avatari suurus';

  @override
  String axisPosition(Object axis) {
    return '$axis asukoht';
  }

  @override
  String get backgroundGradientSetting => 'Tausta gradient';

  @override
  String get backup => 'Varundus';

  @override
  String get backupAndRestore => 'Varundus ja taastamine';

  @override
  String get backupAndRestoreSubtitle =>
      'Varundage või taastage rakenduse andmed';

  @override
  String get backupAndRestoreTitle => 'Varundus ja taastamine';

  @override
  String get backupFailed => 'Varundus nurjus';

  @override
  String get backupFailedMessage => 'Varundus nurjus';

  @override
  String backupFailedWithError(Object error) {
    return 'Varundus nurjus: $error';
  }

  @override
  String get backupRestoreSubtitle => 'Varundage või taastage rakenduse andmed';

  @override
  String get backupRestoreTitle => 'Varundus ja taastamine';

  @override
  String get backupSectionTitle => 'Varundus';

  @override
  String get backupSettings => 'Varundusseaded';

  @override
  String get backupSettingsDialogTitle => 'Varundusseaded';

  @override
  String get backupSettingsTitle => 'Varundusseaded';

  @override
  String get backupSuccessMessage => 'Edualt varundatud pilve';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Varundus õnnestus: $path';
  }

  @override
  String get backupToCloud => 'Varundus pilve';

  @override
  String get backupToCloudDescription =>
      'Varundage seaded ja reeglid pilvesalvestusse';

  @override
  String backupToCloudFailed(Object error) {
    return 'Varundamine pilve nurjus: $error';
  }

  @override
  String get backupToCloudLabel => 'Varundus pilve';

  @override
  String get backupToCloudSuccess => 'Edualt varundatud pilve';

  @override
  String get backupToCloudTitle => 'Varundus pilve';

  @override
  String get backupToLocalLabel => 'Varundus kohalikku';

  @override
  String get bank => 'Pank';

  @override
  String get basicInfo => 'Põhiteave';

  @override
  String get basicRuleFilter => 'Põhiline reeglifilter';

  @override
  String get basicRuleFiltering => 'Põhiline reeglifiltratsioon';

  @override
  String get basicRuleFilteringExplanation =>
      '• Põhiline reeglifiltratsioon: Filtreerib reegleid musta nimekirja, valge nimekirja ja regexi põhjal';

  @override
  String get basicRuleFilterSettings => 'Põhilise reeglifiltri seaded';

  @override
  String get basicRuleFilterSubtitle =>
      'Filtreerige kõnesid musta/valge nimekirja ja regulaaravaldiste abil';

  @override
  String get batchDeleteContacts => 'Massiline kontaktide kustutamine';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Kas olete kindel, et soovite kustutada $count valitud kontakti?';
  }

  @override
  String get batchDeleteFailed => 'Massiline kustutamine nurjus';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Kas olete kindel, et soovite kustutada $count silti?';
  }

  @override
  String get blacklist => 'Must nimekiri';

  @override
  String get blacklistingAndWhitelisting =>
      'Musta ja valge nimekirja koostamine';

  @override
  String get blacklistLabel => 'Must nimekiri';

  @override
  String get blackWhiteList => 'Must/valge nimekiri';

  @override
  String get block => 'Blokeeri';

  @override
  String get blockCalls => 'Blokeeri kõned';

  @override
  String get blocked => 'Blokeeritud';

  @override
  String get blockedCallAction => 'Blokeeritud kõne tegevus';

  @override
  String get blockedCalls => 'Blokeeritud kõned';

  @override
  String get blockedCallsTitle => 'Blokeeritud kõned';

  @override
  String get blockedCommunications => 'Blokeeritud sides';

  @override
  String get blockedPhoneLabel => 'Blokeeritud kõned';

  @override
  String get blockedSpamCalls => 'Blokeeritud rämpskõned';

  @override
  String get blockingTrend => 'Blokeerimise trend';

  @override
  String get blockInternationalCalls =>
      'vastab numbritele, mis ei alga + või 00-ga';

  @override
  String get blockInternationalCallsTitle => 'Blokeeri rahvusvahelised kõned';

  @override
  String get blockLandlineNumbersTitle => 'Blokeeri lauatelefoni numbrid';

  @override
  String get blockMobileNumbers => 'vastab numbritele, mis ei alga 13-19-ga';

  @override
  String get blockMobileNumbersTitle => 'Blokeeri mobiiltelefoninumbrid';

  @override
  String get blockPremiumRateNumbers =>
      'vastab numbritele, mis ei alga 118 või 120-190-ga';

  @override
  String get blockPremiumRateNumbersTitle => 'Blokeeri tasulised numbrid';

  @override
  String get blockRule => 'Blokeerimisreegel';

  @override
  String get blockRules => 'Blokeerimisreeglid';

  @override
  String get blockSpecificAreaCodes =>
      'vastab numbritele, mis algavad 0-ga + 2-3 numbrit';

  @override
  String get blockSpecificAreaCodesTitle =>
      'Blokeeri kindlad piirkonna koodid:';

  @override
  String get blockTypeAnalysisTitle => 'Blokeerimise tüübi analüüs';

  @override
  String get both => 'Mõlemad';

  @override
  String get bulkDelete => 'Massiline kontaktide kustutamine';

  @override
  String get bulkDeleteContacts => 'Massiline kontaktide kustutamine';

  @override
  String get bulkDeleteLabels => 'Massiline siltide kustutamine';

  @override
  String get call => 'Kõne';

  @override
  String get callback => 'Tagasihelistamine';

  @override
  String callbackTo(String number) {
    return 'Tagasihelistamine $number-le';
  }

  @override
  String get callBlocking => 'Kõnede blokeerimine';

  @override
  String get callerIdApp => 'Helistaja ID rakendus';

  @override
  String get callerIdCustomizationTitle => 'Helistaja ID kohandamine';

  @override
  String get callerIdDialogTitle => 'Helistaja ID teave';

  @override
  String get callerIdDisplayMode => 'Kõneaja näidikurežiim';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Märkinud $count';
  }

  @override
  String get callerIdPreview => 'Kõneaja eelvaade';

  @override
  String get callFilter => 'Kõnefilter';

  @override
  String get callFilterDescription =>
      'Kui see on lubatud, kontrollitakse sissetulevaid kõnesid allpool olevate reeglite loendi alusel. Kõne filtreerimise reeglid ei sünkroonita vaikimisi seadmete vahel.';

  @override
  String get callFilterRules => 'Kõnefiltri reeglid';

  @override
  String get callFilterRulesDescription =>
      'Määrake kõne filtreerimise põhireeglid';

  @override
  String get callFilterSettings => 'Kõnefiltri sätted';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Määrake kõnesageduse piirangud ja blokeerimisreeglid';

  @override
  String get callFrequencyInterceptionTitle => 'Kõnesageduse pealtkuulamine';

  @override
  String get callHistory => 'Kõneajalugu';

  @override
  String get callHistoryInfoDesc =>
      'Siin kuvatakse teie kõneajalugu, sealhulgas vastuvõetud, väljahelistatud ja vastamata kõned.';

  @override
  String get callHistoryInfoTitle => 'Kõneajalugu';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Kõneajaloo lähtestamine ebaõnnestus: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Kõneajaloo värskendamine ebaõnnestus: $error';
  }

  @override
  String get callHistoryTab => 'Kõneajalugu';

  @override
  String get callHistoryTimelineEarlier => 'Varasemad';

  @override
  String get callHistoryTimelineToday => 'Täna';

  @override
  String get callHistoryTimelineYesterday => 'Eile';

  @override
  String get callScreeningPermission => 'Kõne läbivaatuse luba';

  @override
  String get callScreeningPermissionDescription =>
      'Kasutatakse rämpskõnede läbivaatamiseks ja blokeerimiseks.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Kõne läbivaatuse luba pole antud, võib mõjutada rakenduse funktsionaalsust.';

  @override
  String get callSettingsSubtitle =>
      'Kõneaja näidik, filtreerimine ja blokeerimise sätted';

  @override
  String get callSettingsTitle => 'Kõne sätted';

  @override
  String get callStatistics => 'Kõne statistika';

  @override
  String get callTypeAnswered => 'Vastatud';

  @override
  String get callTypeBlocked => 'Blokeeritud';

  @override
  String get callTypeIconColor => 'Kõne tüübi ikooni värv';

  @override
  String get callTypeMissed => 'Vastamata kõne';

  @override
  String get callTypeOutgoing => 'Väljahelistatud';

  @override
  String get callTypePosition => 'Kõne tüübi asukoht';

  @override
  String get callTypeUnknown => 'Teadmata';

  @override
  String get cancelButton => 'Tühista';

  @override
  String get carRental => 'Autorent';

  @override
  String get carrier => 'Operaator';

  @override
  String get carrierColor => 'Operaatori värv';

  @override
  String get carrierFontSize => 'Operaatori kirjasuurus';

  @override
  String get carrierPosition => 'Operaatori asukoht';

  @override
  String get changeLabel => 'Muuda silti';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Pistikprogrammi oleku muutmine ebaõnnestus: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Tellimuse oleku muutmine ebaõnnestus: $error';
  }

  @override
  String get changeTag => 'Muuda märgendit';

  @override
  String get charity => 'Heategevus';

  @override
  String chartMonthFormat(int month) {
    return 'Kuu $month';
  }

  @override
  String get chartOneDayAgo => '1 päev tagasi';

  @override
  String get chartOneMonthAgo => '1 kuu tagasi';

  @override
  String get chartOneWeekAgo => '1 nädal tagasi';

  @override
  String get chartTenDaysAgo => '10 päeva tagasi';

  @override
  String get chartThreeDaysAgo => '3 päeva tagasi';

  @override
  String get chartToday => 'Täna';

  @override
  String get checkFileFormat => 'Palun kontrollige failivormingut või õigusi';

  @override
  String checkPermissionFailed(Object error) {
    return 'Lubade kontrollimine ebaõnnestus: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Valige vaikimisi pealtkuulamise toiming';

  @override
  String get clearAllData => 'Kustuta kõik andmed';

  @override
  String get clearAllDataConfirmation =>
      'Kas olete kindel, et soovite kustutada kõik rakenduse andmed? Seda toimingut ei saa tühistada.';

  @override
  String get clearAllDataDescription => 'Kustuta kõik rakenduse andmed';

  @override
  String get clearAllDataLabel => 'Kustuta kõik andmed';

  @override
  String get clearFilter => 'Tühjenda filter';

  @override
  String get clearLabelFilter => 'Tühjenda sildifilter';

  @override
  String get clearLabelFilterButton => 'Tühjenda sildifilter';

  @override
  String get closeButton => 'Sulge';

  @override
  String get cloudSync => 'Pilvsünkroniseerimine';

  @override
  String get cloudSyncAndBackupTitle => 'Pilvsünkroniseerimine ja varundus';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Konfigureerige WebDAV, OneDrive ja Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Pilvsünkroniseerimise sätted';

  @override
  String get cloudSyncTitle => 'Pilvsünkroniseerimine';

  @override
  String get collapseLabelSelector => 'Sildivalija kokkuklapimine';

  @override
  String get collection => 'Võlanõue';

  @override
  String get colorPickerTitle => 'Vali värv';

  @override
  String get configManagement => 'Konfiguratsiooni haldamine';

  @override
  String get configUpdated => 'Konfiguratsioon on värskendatud';

  @override
  String get configurationAdvice =>
      'Nõuetekohase konfiguratsiooni abil saate määrata erinevad filtreerimisstrateegiad töö- ja isiklike SIM-kaartide jaoks.';

  @override
  String get configureBackupOptions => 'Konfigureerige varuvõimalused';

  @override
  String get configureBackupOptionsSubtitle => 'Konfigureerige varuvõimalused';

  @override
  String get configureCloudSyncService =>
      'Konfigureerige pilvsünkroniseerimise teenus';

  @override
  String get configureCloudSyncServiceHint =>
      'Palun konfigureerige pilvsünkroniseerimise teenus mitme seadme sünkroonimise lubamiseks.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Palun konfigureerige pilvsünkroniseerimise teenus mitme seadme sünkroonimise lubamiseks.';

  @override
  String get configureSimCardFilterRules =>
      'Konfigureerige SIM-kaardi filtri reeglid';

  @override
  String get configureSyncServiceHint =>
      'Palun konfigureerige sünkroonimisteenus pilvsünkroniseerimise sätetes esmalt';

  @override
  String get confirm => 'Kinnita';

  @override
  String get confirmBatchDeleteContacts =>
      'Kas olete kindel, et soovite kustutada valitud';

  @override
  String get confirmButton => 'Kinnita';

  @override
  String get confirmDelete => 'Kinnita kustutamine';

  @override
  String get confirmDeleteContact => 'Kas olete kindel, et soovite kustutada';

  @override
  String get confirmDeleteContactName => 'Kustutamise kinnitus?';

  @override
  String get confirmDeleteFilter =>
      'Kas olete kindel, et soovite selle filtri kustutada?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Kas olete kindel, et soovite kustutada sildi \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Kas olete kindel, et soovite kustutada pistikprogrammi \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Kas olete kindel, et soovite kustutada $count pistikprogrammi?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Kas olete kindel, et soovite selle reegli kustutada? Seda toimingut ei saa tühistada.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Kas olete kindel, et soovite kustutada valitud kontaktid?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Kas olete kindel, et soovite selle SMS-filtri reegli kustutada?';

  @override
  String get confirmDeleteSmsRule =>
      'Kas olete kindel, et soovite selle SMS-reegli kustutada?';

  @override
  String get confirmDeleteSubscription =>
      'Kas olete kindel, et soovite selle tellimuse kustutada?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Kas olete kindel, et soovite kustutada $name?';
  }

  @override
  String get confirmPassword => 'Kinnitage salasõna';

  @override
  String get confirmPasswordLabel => 'Kinnitage salasõna';

  @override
  String get connectedStatus => 'Ühendatud';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Ühendus nurjus: Palun kontrollige serveri aadressi, kasutajanime ja parooli';

  @override
  String get connectionFailedMessage => 'Ühendus nurjus';

  @override
  String get connectionStatusLabel => 'Ühenduse olek';

  @override
  String get connectionSuccessMessage => 'Ühendus õnnestus';

  @override
  String get contactAddSuccess => 'Kontakt lisati edukalt';

  @override
  String get contactDeleted => 'Kontakt kustutatud';

  @override
  String get contactEditDialog => 'Kontakti redigeerimise dialoog';

  @override
  String get contactNameHint => 'Sisesta kontakti nimi (valikuline)';

  @override
  String get contactNameLabel => 'Nimi';

  @override
  String get contactNameOptional => 'Kontakti nimi (valikuline)';

  @override
  String get contactNotFound => 'Kontakti ei leitud';

  @override
  String get contacts => 'kontaktid';

  @override
  String contactsDeleted(Object count) {
    return 'Kustutati $count kontakti';
  }

  @override
  String get contactSettingsSubtitle => 'Kontakti haldamine ja siltide seaded';

  @override
  String get contactSettingsTitle => 'Kontakti sätted';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Kontaktide laadimine ebaõnnestus: $error';
  }

  @override
  String get contactsManagement => 'Kontaktide haldus';

  @override
  String get contactsManagementPageTitle => 'Kontaktide halduse leht';

  @override
  String get contactsPageTitle => 'Kontaktide haldus';

  @override
  String get contactsPermission => 'Kontaktide luba';

  @override
  String get contactsPermissionDescription =>
      'Kasutatakse kontaktkõnede tuvastamiseks.';

  @override
  String get contactsTab => 'Kontaktid';

  @override
  String get contactSubscriptionDescription =>
      'Telli kontaktiloendeid URL-i kaudu, uuendage automaatselt kontaktteavet ja silte. Toetab JSON-vormingus andmeid.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Kontaktitellimuste laadimine ebaõnnestus: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Kontaktitellimused';

  @override
  String get contactUpdateSuccess => 'Kontakt värskendati edukalt';

  @override
  String get contactUs => 'Võta meiega ühendust';

  @override
  String get content => 'Sisu';

  @override
  String get contentRegex => 'Sisu regex';

  @override
  String get countColor => 'Loendamise värv';

  @override
  String get countFontSize => 'Loendamise fondi suurus';

  @override
  String get countPosition => 'Loendamise asukoht';

  @override
  String get country => 'Riik';

  @override
  String get countryNameColor => 'Riigi nime värv';

  @override
  String get countryNameFontSize => 'Riigi nime fondi suurus';

  @override
  String get countryRegionNamePosition => 'Riigi/regiooni nime asukoht';

  @override
  String get countrySelectionDialog => 'Riigi valimise dialoog';

  @override
  String get countrySelectionDialogDescription =>
      'Kasutatakse riigi valimiseks helistaja ID teabe päringuks';

  @override
  String get countThresholdDescription =>
      'Määrake filtreerimis toimingute käivitamiseks vajalik minimaalne loendamise lävend';

  @override
  String get countThresholdLabel => 'Loendamise lävend';

  @override
  String get countThresholdSettings => 'Loendamise läve seaded';

  @override
  String countThresholdValue(Object count) {
    return 'Loendamise lävend: $count';
  }

  @override
  String get createdRules => 'Loodud reeglid';

  @override
  String get csvFormat => 'CSV-vorming';

  @override
  String get currentDeviceChip => 'Praegune';

  @override
  String get currentDeviceLabel => 'Praegase seadme silt';

  @override
  String get currentDeviceTitle => 'Praegune seade';

  @override
  String get currentLabels => 'Praegused sildid:';

  @override
  String get currentLanguage => 'Praegune keel';

  @override
  String get currentPasswordLabel => 'Praegune parool';

  @override
  String get customerService => 'Klienditeenindus';

  @override
  String get customRange => 'Kohandatud vahemik';

  @override
  String get dailyStatistics => 'Päevastatistika';

  @override
  String get dailyStatisticsDesc =>
      'Saate igapäevast statistikat blokeeritud kõnede ja sõnumite kohta';

  @override
  String get dashboardTab => 'Armatuurlaud';

  @override
  String get dataAnalysis => 'Andmeanalüüs';

  @override
  String get dataAnalysisDashboardPage => 'Andmeanalüüsi armatuurlaua leht';

  @override
  String get dataExport => 'Andmete eksport';

  @override
  String dataLoadFailure(Object error) {
    return 'Andmete laadimine ebaõnnestus: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Andmete laadimine ebaõnnestus: $error';
  }

  @override
  String get dataMigration => 'Andmete migreerimine';

  @override
  String get dataMigrationDescription =>
      'See funktsioon võimaldab teil edastada kogu oma andmeid seadmete vahel. Praegu saate oma andmete käsitsi migreerimiseks kasutada varundamis- ja taastamisfunktsioone.';

  @override
  String get dataMigrationDialogContent =>
      'See funktsioon võimaldab teil edastada kogu oma andmeid seadmete vahel. Praegu saate oma andmete käsitsi migreerimiseks kasutada varundamis- ja taastamisfunktsioone.';

  @override
  String get dataMigrationDialogTitle => 'Andmete migreerimine';

  @override
  String get dataMigrationSectionTitle => 'Andmete migreerimine';

  @override
  String get dataSourceReminder => 'Andmeallika meeldetuletus';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count päeva',
      one: '1 päev',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days päeva VIP';
  }

  @override
  String get debtCollection => 'Võlgade sissenõudmine';

  @override
  String get defaultPeriod => 'Nädal';

  @override
  String get delete => 'Kustuta';

  @override
  String get deleteButton => 'Kustuta';

  @override
  String get deleteContact => 'Kustuta kontakt';

  @override
  String deleteContactConfirm(Object name) {
    return 'Kas olete kindel, et soovite kustutada $name?';
  }

  @override
  String get deleteContactConfirmation =>
      'Kas olete kindel, et soovite kontakti kustutada';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Kas olete kindel, et soovite seadet $deviceName kustutada?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Seadme kustutamine';

  @override
  String deleteFailed(Object error) {
    return 'Kustutamine ebaõnnestus: $error';
  }

  @override
  String get deleteFilter => 'Kustuta filter';

  @override
  String get deleteLabel => 'Kustuta silt';

  @override
  String deleteLabelFailed(Object error) {
    return 'Sildi kustutamine ebaõnnestus: $error';
  }

  @override
  String get deletePlugin => 'Kustuta pistikprogramm';

  @override
  String deletePluginFailed(Object error) {
    return 'Pistikprogrammi kustutamine ebaõnnestus: $error';
  }

  @override
  String get deletePlugins => 'Kustuta pistikprogrammid';

  @override
  String deletePluginsFailed(Object error) {
    return 'Pistikprogrammide kustutamine ebaõnnestus: $error';
  }

  @override
  String get deleteRule => 'Kustuta reegel';

  @override
  String deleteRuleFailed(Object error) {
    return 'Kustutamine ebaõnnestus: $error';
  }

  @override
  String get deleteSelected => 'Kustuta valitud';

  @override
  String get deleteSmsRule => 'Kustuta SMS reegel';

  @override
  String get deleteSubscription => 'Kustuta tellimus';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Kas olete kindel, et soovite tellimuse \"$name\" kustutada?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Tellimuse kustutamine ebaõnnestus: $error';
  }

  @override
  String get deleteSuccess => 'Kustutamine õnnestus';

  @override
  String get delivery => 'Kohaletoimetamine';

  @override
  String get deviceDeletedSuccessfully => 'Seade kustutati edukalt';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Seade kustutati edukalt';

  @override
  String get deviceIdLabel => 'Seadme ID';

  @override
  String get deviceIDLabel => 'Seadme ID';

  @override
  String get deviceManagementSubtitle => 'Hallake mitme seadme sünkroonimist';

  @override
  String get deviceManagementTitle => 'Seadmete haldus';

  @override
  String get deviceModelLabel => 'Seadme mudel';

  @override
  String get deviceName => 'Seadme nimi';

  @override
  String get deviceNameCannotBeEmpty => 'Seadme nimi ei saa olla tühi';

  @override
  String get deviceNameHint => 'Sisestage seadme nimi';

  @override
  String get deviceNameLabel => 'Seadme nimi';

  @override
  String get deviceRenamedSuccessfully => 'Seade edukalt ümber nimetatud';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Seade edukalt ümber nimetatud';

  @override
  String get devicesSyncedSuccessfully => 'Seadmed edukalt sünkroonitud';

  @override
  String get devicesSyncedSuccessfullyMessage => 'Seadmed edukalt sünkroonitud';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Seadmed edukalt sünkroonitud';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Seade edukalt de registreeritud';

  @override
  String get dialogTitle => 'Regulaaravaldise selgitus';

  @override
  String get differentFromLocalCounter =>
      'See funktsioon erineb kohalikust loenduri filtrist, kuna see keskendub lühikese aja jooksul korduvatele kõnemustritele, mitte pikaajalisele märgistamise arvule.';

  @override
  String get disabled => 'Keelatud';

  @override
  String get disabledStatus => 'Keelatud';

  @override
  String get disableGlobalPlugins => 'Globaalsete pistikprogrammide keelamine';

  @override
  String get disableSubscriptionSuccessfully => 'Tellimus edukalt keelatud';

  @override
  String get disconnectButton => 'Katkesta ühendus';

  @override
  String get disconnectedMessage => 'Ühendus katkestatud';

  @override
  String get disconnectedStatus => 'Katkenud';

  @override
  String get disconnectFailedMessage => 'Ühenduse katkestamine nurjus';

  @override
  String get done => 'Valmis';

  @override
  String get dualSimAdvice =>
      'See funktsioon on eriti kasulik kahe SIM-kaardiga telefonide puhul, et määrata töö- ja isiklike SIM-kaartide jaoks erinevad filtreerimisstrateegiad.';

  @override
  String get earlier => 'Varasem';

  @override
  String get ecommerce => 'E-kaubandus';

  @override
  String get edit => 'Muuda';

  @override
  String get editContact => 'Muuda kontakti';

  @override
  String get editFilter => 'Muuda filtrit';

  @override
  String get editLabel => 'Muuda silti';

  @override
  String get editPhoneRule => 'Muuda kõne reeglit';

  @override
  String get editPhoneRules => 'Kasutatakse kõnede reeglite muutmiseks';

  @override
  String get editPhoneRuleTitle => 'Muuda kõne reeglit';

  @override
  String get editRule => 'Muuda reeglit';

  @override
  String get editSmsRule => 'Muuda SMS-i reeglit';

  @override
  String get education => 'Haridus';

  @override
  String get elementPositionsSetting => 'Elementide asukohad';

  @override
  String get email => 'E-post';

  @override
  String get emailOptional => 'E-post (valikuline)';

  @override
  String get enableCallFilter => 'Luba kõne filter';

  @override
  String get enableCallFilterDescription =>
      'Kui see on lubatud, kontrollitakse sissetulevaid kõnesid alloleva reeglite loendi alusel. Kõne filtreerimise reeglid ei sünkroonita vaikimisi seadmete vahel.';

  @override
  String get enabled => 'Lubatud';

  @override
  String get enabledStatus => 'Lubatud';

  @override
  String get enableEncryption => 'Luba krüptimine';

  @override
  String get enableEncryptionDescription => 'Krüpti varukoopia failid';

  @override
  String get enableEncryptionLabel => 'Luba krüptimine';

  @override
  String get enableEncryptionSubtitle => 'Varukoopia failid krüpteeritakse';

  @override
  String get enableEncryptionTitle => 'Luba krüptimine';

  @override
  String get enableGlobalPlugins => 'Globaalsete pistikprogrammide lubamine';

  @override
  String get enableLocalCountFilter => 'Luba kohalik loenduri filter';

  @override
  String get enableLocalCountFilterDescription =>
      'Spämmi kõnede automaatne filtreerimine kõne märkimise arvu alusel';

  @override
  String get enableLocalNotification => 'Kasuta kohalikku teatist';

  @override
  String get enableLocalNotificationDescription =>
      'Kui see on lubatud, kuvatakse seadmes filtreeritud sõnumite kohta teateid';

  @override
  String get enableLocationSummary => 'Asukoht';

  @override
  String get enableMuteRules => 'Luba vaigistamisreeglid';

  @override
  String get enableMuteRulesDesc =>
      'Rakenda vaigistamise pealtkuulamise reeglite konfiguratsioon';

  @override
  String get enableNoneActionRules => 'Luba mingeid tegevusreegleid';

  @override
  String get enableNoneActionRulesDesc =>
      'Luba reeglite konfiguratsioonid ilma pealtkuulamise toiminguteta';

  @override
  String get enableNotifications => 'Luba teated';

  @override
  String get enableRemoteNumberFilter => 'Luba kaug numbri filter';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Kasuta numbrite filtreerimiseks kaug andmebaasi';

  @override
  String get enableRule => 'Luba reegel';

  @override
  String get enableSmsFilter => 'Luba SMS filtreerimine';

  @override
  String get enableSmsFilterDescription =>
      'Kui see on lubatud, filtreeritakse sõnumid automaatselt reeglite järgi';

  @override
  String get enableStatisticsNotifications => 'Luba statistika teated';

  @override
  String get enableSubscriptionSuccessfully => 'Tellimus edukalt lubatud';

  @override
  String get enableTimeInterception => 'Luba aja pealtkuulamine';

  @override
  String get enableTimeInterceptionDescription =>
      'Pealtkuula korduvaid kõnesid lühikese aja jooksul';

  @override
  String get enableTimeInterceptor => 'Luba aja pealtkuulaja';

  @override
  String get endCallImmediately => 'Lõpeta kõne kohe';

  @override
  String get endColor => 'Lõppvärv';

  @override
  String get endDate => 'Lõppkuupäev';

  @override
  String get enhancedFilterInstructionsTitle =>
      'Täiustatud filtrisüsteemi juhised';

  @override
  String get enhancedFilterSettings => 'Täiustatud filtrisüsteemi sätted';

  @override
  String get enhancedFilterSettingsTitle => 'Täiustatud filtrisüsteemi sätted';

  @override
  String get enhancedFilterSystemDescription =>
      'Täiustatud filtrisüsteem toetab nii globaalseid reegleid kui ka SIM-kaardi kohta käivaid filtreerimiskonfiguratsioone.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Palun sisestage nii telefoninumber kui ka regulaaravaldise muster';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Palun sisestage nii telefoninumber kui ka regulaaravaldise muster.';

  @override
  String get enterContactName => 'Palun sisestage kontakti nimi';

  @override
  String get enterCurrentPasswordHint => 'Palun sisestage praegune parool';

  @override
  String get enterDeviceName => 'Sisesta seadme nimi';

  @override
  String get enterDeviceNameHint => 'Sisestage seadme nimi';

  @override
  String get enterEmail => 'Sisesta e-post';

  @override
  String get enterEmailOptional => 'Sisesta e-post (valikuline)';

  @override
  String get enterEncryptionPasswordHint => 'Sisesta krüpteerimisparool';

  @override
  String get enterEncryptionPasswordTitle => 'Sisesta krüpteerimisparool';

  @override
  String get enterFilterName => 'Palun sisestage filtri nimi';

  @override
  String get enterFilterPattern => 'Palun sisestage filtri muster';

  @override
  String get enterIconCode => 'Sisesta ikooni kood';

  @override
  String get enterName => 'Sisesta kontakti nimi';

  @override
  String get enterNewDeviceNameHint => 'Sisestage sellele seadmele uus nimi';

  @override
  String get enterNewPasswordHint => 'Palun sisestage uus parool';

  @override
  String get enterPasswordAgain => 'Sisesta parool uuesti';

  @override
  String get enterPasswordHint => 'Palun sisestage parool';

  @override
  String get enterPhoneNumber => 'Sisesta telefoninumber';

  @override
  String get enterPhoneNumberHint => 'Sisesta telefoninumber testimiseks';

  @override
  String get enterPhoneNumberMultiple =>
      'Palun sisestage telefoninumber, mitu numbrit eraldatud komadega';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Sisestage telefoninumber otsingu alustamiseks';

  @override
  String get enterPhoneNumberToVerify =>
      'Sisesta telefoninumber kontrollimiseks';

  @override
  String get enterPluginName => 'Sisesta pistikprogrammi nimi';

  @override
  String get enterPluginUrl => 'Sisesta pistikprogrammi URL-i aadress';

  @override
  String get enterRegexHint => 'Sisesta regulaaravaldise muster';

  @override
  String get enterRuleNameAndPattern => 'Palun sisestage reegli nimi ja muster';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Palun sisestage reegli nimi ja regex muster.';

  @override
  String get enterRuleNameHint => 'Sisesta reegli nimi';

  @override
  String get enterSearchContent => 'Palun sisesta otsingusisu';

  @override
  String get enterSubscriptionName => 'Sisesta tellimuse nimi';

  @override
  String get enterSubscriptionUrl => 'Sisesta tellimuse URL';

  @override
  String get enterSyncFolderNameHint =>
      'Palun sisesta sünkroonimiskausta nimi (vaikimisi: NotificationManager)';

  @override
  String get entertainment => 'Meelelahutus';

  @override
  String get enterValidNameAndUrl => 'Palun sisesta kehtiv nimi ja URL';

  @override
  String get enterValidUrl => 'Palun sisesta kehtiv URL';

  @override
  String get enterVersion => 'Sisesta versioon';

  @override
  String get enterWebDAVPasswordHint => 'Palun sisesta WebDAV parool';

  @override
  String get enterWebDAVServerAddressHint =>
      'Palun sisesta WebDAV serveri aadress';

  @override
  String get enterWebDAVUsernameHint => 'Palun sisesta WebDAV kasutajanimi';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Seadme kustutamisel tekkis viga: $error';
  }

  @override
  String get errorLoadingPlugin => 'Plugina laadimisel tekkis viga';

  @override
  String errorOccurredMessage(Object error) {
    return 'Tekkis viga: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Seadme ümbernimetamisel tekkis viga: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Seadmete sünkroonimisel tekkis viga: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Seadmete sünkroniseerimisel tekkis viga: $error';
  }

  @override
  String get errorText => 'Viga';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Seadme tühistamisel tekkis viga: $error';
  }

  @override
  String get exampleBlock400Prefix => 'nt. Blokeeri 400 prefiksiga numbrid';

  @override
  String get exampleBlockMarketingSms => 'nt. Blokeeri turundus-SMSid';

  @override
  String get exampleContentRegex => 'nt., .*pakkumine.*';

  @override
  String get exampleContentRegexHint => 'Näide sisu regex';

  @override
  String get exampleCouponPromotionDiscount =>
      'nt. .*(kupong|pakkumine|soodustus).*';

  @override
  String get exampleFamilyFriends => 'nt. Pere, Sõbrad jne.';

  @override
  String get examplePhoneNumber => 'nt. 10086, 12345 jne.';

  @override
  String get exampleRegex400Prefix => 'Näide regex 400 prefiksile';

  @override
  String get exampleRegexFormat => 'Näide: ^10086\$ formaat';

  @override
  String get exampleSenderRegexHint => 'Example';

  @override
  String get exchange => 'Vahetus';

  @override
  String get exchangeNow => 'Vaheta kohe';

  @override
  String get exchangeVip => 'Vaheta VIP';

  @override
  String get expandLabelSelector => 'Laienda sildivalikut';

  @override
  String expiryTime(Object time) {
    return 'Aegub: $time';
  }

  @override
  String get export => 'Ekspordi';

  @override
  String get exportAllApplicationSettings => 'Ekspordi kõik rakenduse sätted';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Ekspordi kõik rakenduse sätted';

  @override
  String get exportAllRuleConfigurations =>
      'Ekspordi kõik reeglite konfiguratsioonid';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Ekspordi kõik reeglite konfiguratsioonid';

  @override
  String get exportComplete => 'Eksportimine lõpetatud';

  @override
  String get exportConfig => 'Ekspordi konfiguratsioon';

  @override
  String get exportContacts => 'Ekspordi kontaktid';

  @override
  String get exportData => 'Ekspordi andmed';

  @override
  String get exportError => 'Ekspordi viga';

  @override
  String get exportFailed => 'Eksport ebaõnnestus';

  @override
  String get exportFailure => 'Konfiguratsiooni eksportimine ebaõnnestus';

  @override
  String get exportFeatureComingSoon =>
      'Eksportimise funktsioon peagi saadaval';

  @override
  String get exporting => 'Ekspordin...';

  @override
  String get exportLabels => 'Ekspordi sildid';

  @override
  String exportLabelsFailed(Object error) {
    return 'Siltide eksportimine ebaõnnestus: $error';
  }

  @override
  String get exportPluginList => 'Ekspordi pluginate loend';

  @override
  String exportPluginListFailed(Object error) {
    return 'Pluginate loendi eksportimine ebaõnnestus: $error';
  }

  @override
  String get exportRules => 'Ekspordi reeglid';

  @override
  String get exportRulesDialogTitle => 'Ekspordi reeglid';

  @override
  String get exportRulesTitle => 'Ekspordi reeglid';

  @override
  String get exportSmsRules => 'Ekspordi SMS-reeglid';

  @override
  String get exportStatisticsData => 'Ekspordi statistikaandmed';

  @override
  String get exportSuccess => 'Eksporditud edukalt';

  @override
  String get exportSuccesslly => 'Konfiguratsioon eksporditud edukalt';

  @override
  String get failedToAddContact => 'Kontakti lisamine ebaõnnestus';

  @override
  String failedToAddRule(Object error) {
    return 'Reegli lisamine ebaõnnestus: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMS-reegli lisamine ebaõnnestus: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS-tellimuse lisamine ebaõnnestus: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Sätete varundamine ebaõnnestus: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Varukoopiafaili dekrüpteerimine ebaõnnestus';

  @override
  String get failedToDeleteDevice => 'Seadme kustutamine ebaõnnestus';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS-reegli kustutamine ebaõnnestus: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Reeglite eksportimine ebaõnnestus: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'SMS-reeglite eksportimine ebaõnnestus: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Helistaja ID teabe hankimine ebaõnnestus: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Reeglite importimine ebaõnnestus: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'SMS-reeglite importimine ebaõnnestus: $error';
  }

  @override
  String get failedToLoadContacts => 'Kontaktide laadimine ebaõnnestus';

  @override
  String get failedToLoadPlugin => 'Plugina laadimine ebaõnnestus';

  @override
  String get failedToRenameDevice => 'Seadme ümbernimetamine ebaõnnestus';

  @override
  String get failedToRestoreSettings => 'Sätete taastamine ebaõnnestus';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Sätete taastamine ebaõnnestus: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Parooli määramine ebaõnnestus: $error';
  }

  @override
  String get failedToSyncDevices => 'Seadmete sünkroonimine ebaõnnestus';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Reegli oleku lülitamine ebaõnnestus: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Tellimuse oleku lülitamine ebaõnnestus';

  @override
  String get failedToUpdateContact => 'Kontakti värskendamine ebaõnnestus';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'SMS-reegli värskendamine ebaõnnestus: $error';
  }

  @override
  String get failure => 'Ebaõnnestumine';

  @override
  String get favoriteContacts => 'Lemmik kontaktid';

  @override
  String get featureAddRules => '• Lisa numbripõhised reeglid';

  @override
  String get featureCenter => 'Funktsioonide keskus';

  @override
  String get featureEnableDisable =>
      '• Lülita erinevaid filtreid SIM-kaardi kohta sisse/välja';

  @override
  String get featureListTitle => 'Funktsioonid:';

  @override
  String get featureManageRules =>
      '• Hallake reeglite loendeid SIM-kaardi kohta';

  @override
  String get features => 'Funktsioonid';

  @override
  String get fetchingCallerIdInfo => 'Helistaja ID teabe hankimine...';

  @override
  String fileSavedTo(Object path) {
    return 'Fail salvestatud asukohta: $path';
  }

  @override
  String get filter => 'Filter';

  @override
  String get filterByLabel => 'Filtreeri sildi järgi';

  @override
  String get filterClear => 'Tühista filter';

  @override
  String get filterControlPanelTitle => 'Filtri juhtpaneel';

  @override
  String get filterControlSubtitle =>
      'Hallake kõigi filtrite sisse/välja olekut';

  @override
  String get filterControlTitle => 'Filtri juhtimine';

  @override
  String get filterDeleteFailed => 'Filtri kustutamine ebaõnnestus';

  @override
  String get filterDeleteSuccess => 'Filter kustutati edukalt';

  @override
  String get filterDetails => 'Filtri üksikasjad';

  @override
  String get filtered => 'Filtreeritud';

  @override
  String get filteredSms => 'Filtreeritud SMS';

  @override
  String get filteredSmsLabel => 'Filtreeritud SMS';

  @override
  String get filterExplanation => 'Filtri selgitus';

  @override
  String get filterManagement => 'Filtri haldus';

  @override
  String get filterName => 'Filtri nimi';

  @override
  String get filterPattern => 'Filtri muster';

  @override
  String get filterPriorityNote =>
      'Märkus: Filtrite vahel on prioriteedisuhted, üksikasjade saamiseks tutvuge abidokumentatsiooniga';

  @override
  String get filterSaveFailed => 'Filtri salvestamine ebaõnnestus';

  @override
  String get filterSaveSuccess => 'Filter salvestati edukalt';

  @override
  String get filterSettings => 'Filtri sätted';

  @override
  String get filterSettingsTitle => 'Filtri sätted';

  @override
  String get filterSMS => 'Filtreeri SMS';

  @override
  String get filterToggleInstructions =>
      'Luba või keela filtrid selle SIM-pesa jaoks:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Lülita $status filter: $filterName';
  }

  @override
  String get filterType => 'Filtri tüüp';

  @override
  String get financial => 'Finants';

  @override
  String get flexibleCombinationFeature =>
      '• Paindlikud kombinatsioonid: lubage/keelake filtrid SIM-pesa kohta';

  @override
  String get fontSizesSetting => 'Fondi suurused';

  @override
  String foundRules(Object count) {
    return 'Leiti $count reeglit';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Leiti $count reeglit. Kas soovite need importida?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Leiti $count reeglit. Kas soovite need importida?';
  }

  @override
  String get fraudAlert => 'PETISHOIATUS - Lõpetage kõne';

  @override
  String get fraudScamLikely => 'Petuskeemi tõenäosus';

  @override
  String get free => 'Tasuta';

  @override
  String get functionSettingsTitle => 'Funktsioonide sätted';

  @override
  String generalUpdateFailure(Object error) {
    return 'Värskendus ebaõnnestus: $error';
  }

  @override
  String get getFree => 'Saada tasuta';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Konfigureerige globaalseid filtreid kõigile SIM-kaartidele:';

  @override
  String get globalFilterFeature =>
      '• Globaalsed filtrid: põhireeglid kõigile sissetulevatele kõnedele';

  @override
  String get globalFilterSettings => 'Globaalsed filtri sätted';

  @override
  String get globalFilterToggleInstructions =>
      'Konfigureerige globaalsed filtri sätted, mis kehtivad kõigile SIM-pesadele:';

  @override
  String get globalSearchSubtitle =>
      'Otsige kontakte, silte, mustnimekirju, valgenimekirju jne.';

  @override
  String get globalSearchTitle => 'Globaalne otsing';

  @override
  String get globalSettings => 'Globaalsed sätted';

  @override
  String get googleAdDisplayPosition => 'Google Ad Display Position';

  @override
  String get googleAdMobIntegrationText =>
      'Siia saab integreerida Google AdMob reklaame';

  @override
  String get googleDriveAuthDescription =>
      'Volitage, kasutades süsteemis konfigureeritud Google Drive\'i kliendi ID-d ja võtit';

  @override
  String get googleDriveAuthorizationHint =>
      'Volitage, kasutades süsteemis konfigureeritud Google Drive\'i kliendi ID-d ja võtit';

  @override
  String get googleDriveConfigTitle => 'Google Drive\'i konfiguratsioon';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive\'i konfiguratsioon';

  @override
  String get government => 'Valitsus';

  @override
  String get granted => 'Antud';

  @override
  String get grantNecessaryPermissions => 'Andke vajalikud load';

  @override
  String get grantPermissions => 'Andke load';

  @override
  String get headhunter => 'Värbaja';

  @override
  String get height => 'Kõrgus';

  @override
  String get homePageTitle => 'Avakuva';

  @override
  String get homeTab => 'Avaleht';

  @override
  String get howItWorksPoint1 =>
      '• Süsteem lubab automaatselt kõnesid samalt numbrilt määratud aja jooksul';

  @override
  String get howItWorksPoint2 =>
      '• Lühemad ajad tähendavad rangemat tõkestamist; pikemad ajad tähendavad leebemat tõkestamist';

  @override
  String get howItWorksPoint3 =>
      '• Süsteem kontrollib kõnelogisid, et tuvastada korduv kõne';

  @override
  String get howItWorksTitle => 'Kuidas see töötab:';

  @override
  String get iconCodeOptional => 'Ikooni kood (valikuline)';

  @override
  String get iconSize => 'Ikooni suurus';

  @override
  String get import => 'Import';

  @override
  String get important => 'Tähtis';

  @override
  String get importButton => 'Import';

  @override
  String get importConfig => 'Impordi konfiguratsioon';

  @override
  String get importContacts => 'Impordi kontaktid';

  @override
  String get importExportContacts => 'Impordi/Ekspordi kontaktid';

  @override
  String get importExportContactsTooltip => 'Impordi/Ekspordi kontaktid';

  @override
  String get importExportRules => 'Impordi/Ekspordi reeglid';

  @override
  String importFailed(Object error) {
    return 'Importimine ebaõnnestus: $error';
  }

  @override
  String get importFailure => 'Konfiguratsiooni importimine ebaõnnestus';

  @override
  String get importFeatureComingSoon => 'Importimisfunktsioon peagi saadaval';

  @override
  String get importLabels => 'Impordi sildid';

  @override
  String importLabelsFailed(Object error) {
    return 'Siltide importimine ebaõnnestus: $error';
  }

  @override
  String get importPluginList => 'Impordi pistikprogrammi loend';

  @override
  String importPluginListFailed(Object error) {
    return 'Pistikprogrammi loendi importimine ebaõnnestus: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Edukalt imporditud $count pistikprogrammi';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Impordi reeglite konfiguratsioonid failist';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Impordi reeglite konfiguratsioonid failist';

  @override
  String get importRules => 'Impordi reeglid';

  @override
  String get importRulesButton => 'Impordi reeglid';

  @override
  String get importRulesDialogTitle => 'Impordi reeglid';

  @override
  String importRulesError(Object error) {
    return 'Reeglite importimine ebaõnnestus: $error';
  }

  @override
  String get importRulesInstructions => 'Impordi reeglid CSV-failist';

  @override
  String get importRulesSuccess => 'Reeglid imporditi edukalt';

  @override
  String get importRulesTitle => 'Impordi reeglid';

  @override
  String get importSuccess => 'Importimine õnnestus';

  @override
  String get incomingCallInterceptAction =>
      'Sissetuleva kõne tõkestamise toiming';

  @override
  String get incomingCallNotification => 'Sissetuleva kõne teavitus';

  @override
  String get incorrectPassword => 'Vale parool';

  @override
  String get initializing => 'Initialiseerimine';

  @override
  String get installed => 'Installitud';

  @override
  String get insufficientMarks => 'Ebapiisavad märgid';

  @override
  String get insurance => 'Kindlustus';

  @override
  String get interceptAction => 'Tõkestamise toiming';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Määrake, kuidas blokeeritud kõnedega toimida';

  @override
  String get interceptionActionSettingsTitle => 'Tõkestamise toimingute sätted';

  @override
  String get interceptionTimeInterval => 'Tõkestamise ajaintervall';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service värskendusintervalliks määratud $days päeva';
  }

  @override
  String get invalidContentRegex => 'Kehtetu sisukood Regex';

  @override
  String get invalidLabel => 'Kehtetu silt';

  @override
  String get invalidRegexPattern => 'Kehtetu regulaaravaldise muster';

  @override
  String get invalidSenderRegex => 'Kehtetu saatja regulaaravaldise muster';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Liituge Telegrami kanaliga ja grupiga lisateabe saamiseks';

  @override
  String get jsLogsTitle => 'JS logid';

  @override
  String get jsonFormat => 'JSON-vorming';

  @override
  String get keepAllVersions => 'Säilita kõik versioonid';

  @override
  String get keepAllVersionsDescription =>
      'Säilita iga varukoopia ajaloolised versioonid';

  @override
  String get keepAllVersionsLabel => 'Säilita kõik versioonid';

  @override
  String get keepAllVersionsSubtitle =>
      'Säilita iga varukoopia ajaloolised versioonid';

  @override
  String get keepAllVersionsTitle => 'Säilita kõik versioonid';

  @override
  String get label => 'Silt';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Silt \"$name\" lisati edukalt';
  }

  @override
  String get labelCategories => 'Siltide kategooriad';

  @override
  String get labelDeleted => 'Silt kustutati';

  @override
  String get labelDescription =>
      'Sildid aitavad teil paremini hallata kontakte, lisada telefoninumbritele kohandatud silte kõnede ja sõnumite hõlpsaks tuvastamiseks.';

  @override
  String get labelFilter => 'Siltide filter';

  @override
  String get labelFilterTooltip => 'Siltide filter';

  @override
  String get labelIconColor => 'Sildi ikooni värv';

  @override
  String get labelManagement => 'Siltide haldamine';

  @override
  String get labelNotFound => 'Silt ei leidnud';

  @override
  String get labelRemoved => 'Silt eemaldati';

  @override
  String labelRemoveFailed(Object error) {
    return 'Sildi eemaldamine ebaõnnestus: $error';
  }

  @override
  String get labels => 'Sildid';

  @override
  String get labelsColor => 'Siltide värv';

  @override
  String labelsDeleted(Object count) {
    return '$count silti kustutati';
  }

  @override
  String get labelsExportedSuccessfully => 'Sildid eksporditi edukalt';

  @override
  String get labelsFontSize => 'Siltide fondi suurus';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Imporditi edukalt $count silti';
  }

  @override
  String get labelsPosition => 'Siltide asukoht';

  @override
  String labelTag(Object labelId) {
    return 'Silt: $labelId';
  }

  @override
  String get labelUpdated => 'Silti värskendati';

  @override
  String labelUpdateFailed(Object error) {
    return 'Sildi värskendamine ebaõnnestus: $error';
  }

  @override
  String get labelUpdateSuccess => 'Silt \"\$labelText\" värskendati edukalt';

  @override
  String get languageSettings => 'Keele sätted';

  @override
  String get languageSettingsSubtitle => 'Muutke rakenduse kuvakeelt';

  @override
  String get languageSettingsTitle => 'Keele sätted';

  @override
  String get last30Days => 'Viimased 30 päeva';

  @override
  String get last7Days => 'Viimased 7 päeva';

  @override
  String get lastSyncLabel => 'Viimane sünkroniseerimine';

  @override
  String lastUpdated(Object date) {
    return 'Viimati värskendatud: $date';
  }

  @override
  String get lifetimeMembership => 'Eluaegne liikmelisus';

  @override
  String get lifetimeMembershipDescription =>
      'Ühekordne ost, avab püsivalt kõik premium-funktsioonid ja tulevased värskendused';

  @override
  String loadContactsFailed(Object error) {
    return 'Kontaktide laadimine ebaõnnestus: $error';
  }

  @override
  String get loadDataFailed => 'Andmete laadimine ebaõnnestus';

  @override
  String get loadFailed => 'Laadimine ebaõnnestus';

  @override
  String get loading => 'Laadin...';

  @override
  String get loadingData => 'Laadin andmeid...';

  @override
  String get loadingTags => 'Laadin silte...';

  @override
  String loadLabelFailed(Object error) {
    return 'Siltide laadimine ebaõnnestus: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Siltide laadimine ebaõnnestus: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Märgitud telefoninumbrite laadimine ebaõnnestus: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Märgitud telefonide laadimine ebaõnnestus: $error';
  }

  @override
  String get loadMore => 'Laadi rohkem';

  @override
  String get loadPluginButton => 'Laadi pistikprogramm';

  @override
  String loadPluginsFailed(Object error) {
    return 'Pistikprogrammide laadimine ebaõnnestus: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Sätete laadimine ebaõnnestus: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'SMS-reeglite laadimine ebaõnnestus: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Olekulaadimine ebaõnnestus';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Tellimuste laadimine ebaõnnestus: $error';
  }

  @override
  String get loan => 'Laen';

  @override
  String get localBackupTitle => 'Kohalik varundus';

  @override
  String get localCounterFilter => 'Kohaliku loenduri filter';

  @override
  String get localCounterFilterSubtitle =>
      'Filtreerige automaatselt rämpskõnesid kõnesageduse põhjal';

  @override
  String get localCountFilter => 'Kohaliku loenduri filter';

  @override
  String get localCountFilterDescription =>
      'Hoidke sagedasi kõnesid kinni kohalike numbrite loendurite põhjal';

  @override
  String get localCountFilterExplanationContent =>
      'Kohaliku loenduri filter analüüsib kõneajaloo kirjeid, et automaatselt tuvastada ja blokeerida sagedased rämpskõned.';

  @override
  String get localCountFilterExplanationTitle =>
      'Kohaliku loenduri filtri selgitus';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Otsustage, kas blokeerida numbri loenduri väärtuse põhjal';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Kui numbri loendur ületab määratud künnise, saate selle automaatselt blokeerida';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Saate valida numbrid, mis ei ületa künnist';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Saate valida, kas salvestada kõik päringute logid';

  @override
  String get localCountFiltering => 'Kohaliku loenduri filtreerimine';

  @override
  String get localCountFilteringExplanation =>
      '• Kohaliku loenduri filtreerimine: filtreerimisreeglid kohaliku märgistamise loenduri põhjal';

  @override
  String get localCountFilterSettings => 'Kohaliku loenduri filtri sätted';

  @override
  String get localCountFilterUseCases =>
      'See filter sobib eriti hästi automaatkõnede ja turunduskõnede tuvastamiseks.';

  @override
  String get localFilterSettings => 'Kohaliku filtri sätted';

  @override
  String get localNotificationDisabled => 'Kohalik teatamine keelatud';

  @override
  String get localNotificationEnabled => 'Kohalik teatamine lubatud';

  @override
  String get localServices => 'Kohalikud teenused';

  @override
  String get locationColor => 'Asukoha värv';

  @override
  String get locationFontSize => 'Asukoha fondi suurus';

  @override
  String get locationIconColor => 'Asukoha ikooni värv';

  @override
  String get locationPosition => 'Asukoha asukoht';

  @override
  String get logAllLocalQueries => 'Logi kõik kohalikud päringud';

  @override
  String get logAllLocalQueriesDescription =>
      'Salvestage logid kõikide kohalike numbrite päringute kohta';

  @override
  String get logAllRemoteQueries => 'Logi kõik kaugpäringud';

  @override
  String get logAllRemoteQueriesDescription =>
      'Salvestage kõik kaugnumbrite päringu toimingud';

  @override
  String get manage => 'Hallake kontakte';

  @override
  String get manageContacts => 'Halda';

  @override
  String get manageFavoriteContacts => 'Hallake lemmikkontakte';

  @override
  String get manageFilterRules => 'Halda filtreerimisreegleid';

  @override
  String get manageFilterRulesDescription =>
      'Lisage, muutke või kustutage SMS-filtri reegleid';

  @override
  String get manageFrequentContacts => 'Hallake sagedasi kontakte';

  @override
  String get markCounts => 'Märgistamise loendurid';

  @override
  String get markCount => 'Märgistamise loendur';

  @override
  String markedByCount(Object count) {
    return 'Märkinud $count';
  }

  @override
  String get markedPhonesList => 'Märgitud telefoninumbrid';

  @override
  String get markExchange => 'Märgistuse vahetus';

  @override
  String get markPhone => 'Märgista telefoninumber';

  @override
  String markPhoneFailed(Object error) {
    return 'Telefoni numbri märkimine ebaõnnestus: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'Telefoninumbrite märkimiseks';

  @override
  String get markPhoneManagementTitle => 'Telefoni numbri märkimise haldus';

  @override
  String get markPhoneSuccess => 'Telefoni number märgiti edukalt';

  @override
  String get matchFailed => 'Sobitus ebaõnnestus!';

  @override
  String get matchFailedMessage => 'Sobitus ebaõnnestus.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'sobib numbri erimärkidega vormingusse';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Sobita numbrid erimärkidega:';

  @override
  String get matchSpecificDigitPatterns => 'sobib XXX-XXXX-XXXX vormingusse';

  @override
  String get matchSpecificDigitPatternsTitle => 'Sobita kindlad numbrimustrid:';

  @override
  String get matchSuccessful => 'Sobitus õnnestus!';

  @override
  String get matchSuccessfulMessage => 'Sobitus õnnestus!';

  @override
  String get medical => 'Meditsiiniline';

  @override
  String get membershipPrivileges => 'Liikmelisuse eelised';

  @override
  String get migrationTool => 'Migratsioonitööriist';

  @override
  String get migrationToolTitle => 'Migratsioonitööriist';

  @override
  String get minutes => 'minutit';

  @override
  String get month => 'Kuu';

  @override
  String get monthly => 'Kuu';

  @override
  String get monthlyCallCount => 'Kuuväljakutsed';

  @override
  String get monthlyChartTitle => 'Kuuväljakutsed blokeeritud';

  @override
  String get monthlyMembership => 'Kuuliikmelisus';

  @override
  String get monthlyMembershipDescription =>
      'Avage kõik premium-funktsioonid, uuendatakse automaatselt kord kuus';

  @override
  String get monthlyTotal => 'Kuukokku';

  @override
  String get monthlyTotalLabel => 'Kuukokku';

  @override
  String get moreOptions => 'Rohkem valikuid';

  @override
  String get mute => 'Vaikne';

  @override
  String get name => 'Nimi';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Nimi ja telefoninumber ei saa olla tühjad';

  @override
  String get nameAndPhoneNumberRequired =>
      'Nimi ja telefoninumber peavad olema täidetud';

  @override
  String get nameColor => 'Nime värv';

  @override
  String get nameFontSize => 'Nime fondisuurus';

  @override
  String nameLabel(Object name) {
    return 'Nimi: $name';
  }

  @override
  String get namePosition => 'Nime asukoht';

  @override
  String get nameUnknown => 'Nimi: Tundmatu';

  @override
  String nameWithValue(String name) {
    return 'Nimi: $name';
  }

  @override
  String get newPasswordLabel => 'Uus parool';

  @override
  String get nextStep => 'Järgmine';

  @override
  String get noAction => 'Ei mingit tegevust';

  @override
  String get noActionRules => 'Ei mingit tegevust reegleid';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Ühtegi aktiivset pilvesünkroniseerimisteenust pole';

  @override
  String get noCallLogs => 'Kõnelogisid pole';

  @override
  String get noCallRecords => 'Kõnekirjeid pole';

  @override
  String get noContacts => 'Kontaktid puuduvad veel';

  @override
  String get noContactsYet => 'Kontakte pole veel';

  @override
  String get noData => 'Andmeid pole';

  @override
  String get noDevicesRegisteredMessage => 'Seadmeid pole registreeritud';

  @override
  String get noDevicesRegisteredYet => 'Registreeritud seadmeid pole veel';

  @override
  String get noFilters => 'Filtreid pole veel';

  @override
  String get noLabels => 'Silte pole veel';

  @override
  String get noMarkedPhones => 'Märgitud telefone pole';

  @override
  String get noMatchingContacts => 'Sobivaid kontakte pole';

  @override
  String get noMatchingContactsFound => 'Sobivaid kontakte ei leitud';

  @override
  String get noMatchingNumbersFound => 'Sobivaid numbreid ei leitud';

  @override
  String get noMatchingRecords => 'Sobivaid kõnekirjeid pole';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Sobivaid $ruleType pole';
  }

  @override
  String get none => 'Puudub';

  @override
  String get noneServiceType => 'Puudub';

  @override
  String get noPlugins => 'Pistikprogramme pole veel';

  @override
  String get noRecords => 'Kõnekirjeid pole';

  @override
  String get noResultReturned => 'Tulemust ei tagastatud';

  @override
  String get noResultReturnedLog => 'Pistikprogrammist tulemust ei tagastatud';

  @override
  String noRules(Object ruleType) {
    return '$ruleType pole veel';
  }

  @override
  String get noRulesPrompt => 'Reegleid pole leitud, lisage reeglid';

  @override
  String get noRulesToExport => 'Reegleid pole eksportimiseks';

  @override
  String get noSmsFilterRulesYet => 'SMS-i filtreerimisreegleid pole veel';

  @override
  String get noSmsRulesYet => 'SMS-reegleid pole veel';

  @override
  String get noSubscriptions => 'Tellimusi pole';

  @override
  String get noSubscriptionsYet => 'Tellimusi pole veel';

  @override
  String get notGranted => 'Pole antud';

  @override
  String get notificationMode => 'Teavituste režiim';

  @override
  String get notificationModeDescription =>
      'Näita helistaja teavet teavitusribal';

  @override
  String get notificationPermission => 'Teavituste luba';

  @override
  String get notificationPermissionDescription =>
      'Kasutatakse sissetulevate kõne- ja sõnumiteatiste kuvamiseks.';

  @override
  String get notifications => 'Teavitused';

  @override
  String get notificationSettings => 'Teavituste seaded';

  @override
  String get notificationSettingsSaved =>
      'Teavituste seaded salvestati edukalt';

  @override
  String get notSet => 'Pole määratud';

  @override
  String get notVerifiedText => 'Pole kinnitatud';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Failist ei leitud ühtegi kehtivat SMS-reeglit';

  @override
  String get number => 'Number';

  @override
  String get numberColor => 'Numbri värv';

  @override
  String get numberFontSize => 'Numbri fondisuurus';

  @override
  String get numberPosition => 'Numbri asukoht';

  @override
  String get numberSearch => 'Numbriotsing';

  @override
  String get numberTypeColor => 'Numbritüübi värv';

  @override
  String get numberTypeFontSize => 'Numbritüübi fondisuurus';

  @override
  String get numberTypePosition => 'Numbritüübi asukoht';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Teie kõneturbehaldur on valmis, alustage turvalise kõnekogemusega!';

  @override
  String get onboardingLanguageDescription =>
      'Valige oma eelistatud keel parima kogemuse saamiseks.';

  @override
  String get onboardingPermissionsDescription =>
      'Täieliku teenuse osutamiseks vajame järgmisi lubasid:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Ühe klõpsuga rämpskõnede ja sõnumite blokeerimine, blokeerimisreeglite kohandamine ja teile vaikse keskkonna loomine.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Tundmatute kõnede automaatne tuvastamine, kahtlaste numbrite märkimine ja teie kõneturvalisuse tagamine.';

  @override
  String get onboardingWelcomeDescription =>
      'Teie kõnehalduse ekspert, pakkudes kõikehõlmavaid kõnetuvastus- ja blokeerimisteenuseid.';

  @override
  String get oneDriveAuthDescription =>
      'Volitage süsteemi konfigureeritud OneDrive\'i kliendi ID ja võtme abil';

  @override
  String get oneDriveAuthorizationHint =>
      'Volitage süsteemi konfigureeritud OneDrive\'i kliendi ID ja võtme abil';

  @override
  String get oneDriveConfigTitle => 'OneDrive konfiguratsioon';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive konfiguratsioon';

  @override
  String get onlineCallerIdSubscription => 'Online helistaja ID tellimus';

  @override
  String get openAppSettings => 'Ava rakenduse sätted';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Rakenduse sätete avamine nurjus: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Toiming nurjus: $error';
  }

  @override
  String get operationFailure => 'Toiming nurjus';

  @override
  String get operationSuccess => 'Toiming õnnestus';

  @override
  String get other => 'Muu';

  @override
  String get ourOtherApps => 'Meie teised rakendused';

  @override
  String get overlayMode => 'Ujuvaken';

  @override
  String get overlayModeDescription => 'Näita helistaja teavet ujuvas aknas';

  @override
  String get overlayPermission => 'Ujuva akna luba';

  @override
  String get overlayPermissionDescription =>
      'Kasutatakse sissetuleva kõne ujuva akna kuvamiseks.';

  @override
  String get overview => 'Ülevaade';

  @override
  String get password => 'Parool';

  @override
  String get passwordCannotBeEmpty => 'Parool ei saa olla tühi';

  @override
  String get passwordLabel => 'Parool';

  @override
  String get passwordsDoNotMatch => 'Paroolid ei vasta';

  @override
  String get passwordSetSuccessfully => 'Parool on edukalt seatud';

  @override
  String get pattern => 'Muster';

  @override
  String get pendingSync => 'Ootel sünkroonimine';

  @override
  String get periodMonth => 'Kuu';

  @override
  String get periodWeek => 'Nädal';

  @override
  String get periodYear => 'Aasta';

  @override
  String get permissionDenied => 'Loa taotlus on keelatud';

  @override
  String get permissionGranted => 'Luba on antud';

  @override
  String get permissionManagement => 'Lubade haldus';

  @override
  String get phoneCallsTab => 'Telefon';

  @override
  String get phoneNumber => 'Telefoninumber';

  @override
  String get phoneNumberCannotBeEmpty => 'Telefoninumber ei saa olla tühi';

  @override
  String get phoneNumberHint => 'Sisesta telefoninumber';

  @override
  String get phoneNumberHintText => 'Sisesta telefoninumber reegli lisamiseks';

  @override
  String get phoneNumberLabel => 'Telefoninumber';

  @override
  String get phoneNumberRegexRequired =>
      'Palun sisesta nii telefoninumber kui ka regex-muster';

  @override
  String get phoneNumberRequired => 'Telefoninumber on nõutav';

  @override
  String get phoneNumberTypeFixedLine => 'Lauatelefon';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Lauatelefon või mobiil';

  @override
  String get phoneNumberTypeMobile => 'Mobiil';

  @override
  String get phoneNumberTypePager => 'Paging-seade';

  @override
  String get phoneNumberTypePersonalNumber => 'Isiklik number';

  @override
  String get phoneNumberTypePremiumRate => 'Eritariifiga number';

  @override
  String get phoneNumberTypeSharedCost => 'Jagatud maksumusega number';

  @override
  String get phoneNumberTypeTollFree => 'Tasuta number';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Teadmata';

  @override
  String get phoneNumberTypeVoicemail => 'Kõnepost';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Telefoni luba';

  @override
  String get phonePermissionDescription =>
      'Kasutatakse sissetulevate kõnede tuvastamiseks ja blokeerimiseks.';

  @override
  String get phoneRule => 'Telefonireegel';

  @override
  String get phoneRuleEditDialog => 'Telefonireegli redigeerimise dialoog';

  @override
  String get phoneRuleManagement => 'Telefonireeglite haldus';

  @override
  String get phoneRuleSubscription => 'Telefonireegli tellimus';

  @override
  String get phoneSubscription => 'Telefoni tellimus';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Telli telefonireeglite loendeid URL-i kaudu, et automaatselt värskendada valge ja musta nimekirja reegleid. Toetab JSON-vormingus reeglifaile.';

  @override
  String get phoneSubscriptionTitle => 'Telefonireeglite tellimused';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Palun vali silt ja sisesta kehtiv telefoninumber';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Pistikprogramm \"$name\" lisati edukalt';
  }

  @override
  String get pluginDeleted => 'Pistikprogramm kustutati';

  @override
  String get pluginLatestVersion => 'Pistikprogramm on juba uusim versioon';

  @override
  String get pluginListExportSuccess =>
      'Pistikprogrammide loend eksporditi edukalt';

  @override
  String get pluginLoadedSuccessfully => 'Pistikprogramm laaditi edukalt';

  @override
  String get pluginManagement => 'Pistikprogrammide haldus';

  @override
  String get pluginManagementSubtitle =>
      'Hallake ja konfigureerige kolmanda osapoole pistikprogramme';

  @override
  String get pluginManagementTitle => 'Pistikprogrammide haldus';

  @override
  String get pluginName => 'Pistikprogrammi nimi';

  @override
  String get pluginNotLoaded =>
      'Pistikprogrammi pole veel laaditud. Palun laadi pistikprogramm kõigepealt.';

  @override
  String pluginsDeleted(Object count) {
    return '$count pistikprogrammi kustutati edukalt.';
  }

  @override
  String get pluginService => 'Pistikprogrammiteenus';

  @override
  String get pluginTestPageTitle => 'Pistikprogrammide testimine';

  @override
  String get pluginUpdateSuccess => 'Pistikprogramm värskendati edukalt';

  @override
  String get pluginUrl => 'Pistikprogrammi URL';

  @override
  String get pluginUrlCannotBeEmpty => 'Pistikprogrammi URL ei saa olla tühi';

  @override
  String get pluginUrlHint => 'Sisesta pistikprogrammi URL';

  @override
  String get pluginUrlLabel => 'Pistikprogrammi URL';

  @override
  String get pluginVersion => 'Pistikprogrammi versioon';

  @override
  String get political => 'Poliitiline';

  @override
  String get powerfulSpamBlocking => 'Tugev rämbrata tõkestus';

  @override
  String get previousStep => 'Eelmine';

  @override
  String get prioritizeRemoteAction => 'Prioriteedi kaugtoimingute sätted';

  @override
  String get prioritizeRemoteActionDescription =>
      'Prioriteedi toimingute sätted kaugandmebaasist';

  @override
  String get processing => 'Töötlemine...';

  @override
  String get processingOperation => 'Töötlemine...';

  @override
  String get purchase => 'Osta';

  @override
  String get quarterlyMembership => 'Kvartali liikmelisus';

  @override
  String get quarterlyMembershipDescription =>
      'Ava kõik esmaklassilised funktsioonid, automaatne uuendamine kvartaalselt';

  @override
  String get queryButton => 'Päring';

  @override
  String get queryFailed => 'Päring nurjus';

  @override
  String get queryFailedLog => 'Päring nurjus';

  @override
  String get querying => 'Päring...';

  @override
  String get queryingPhoneNumber => 'Telefoninumbri päring';

  @override
  String get queryResultTitle => 'Päringu tulemus';

  @override
  String get ready => 'Valmis!';

  @override
  String get receiveWeeklyStatistics =>
      'Vastuvõtmiseks iganädalased statistika';

  @override
  String get recruiter => 'Värbaja';

  @override
  String get reEnterPasswordHint => 'Palun sisesta parool uuesti';

  @override
  String get refresh => 'Värskenda';

  @override
  String get refreshPermissionStatus => 'Värskenda loa olekut';

  @override
  String get refreshTooltip => 'Värskenda';

  @override
  String regexError(Object error) {
    return 'Regex viga: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex viga: $error';
  }

  @override
  String get regexPattern => 'RegEx-muster';

  @override
  String get regexPatternExplanation => 'RegEx-mustri selgitus';

  @override
  String get regexPatternExplanationButton => 'RegEx-mustri selgitus';

  @override
  String get regexPatternLabel => 'RegEx-muster';

  @override
  String get regexPatternsExamples =>
      'Kasutage mustrite määramiseks standardset RegEx-süntaksit. Näited:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'RegEx-mustrid telefoninumbrite sobitamiseks';

  @override
  String get regexRule => 'RegEx-reegel';

  @override
  String regexRuleAddFailed(Object error) {
    return 'RegEx-reegli lisamine ebaõnnestus: $error';
  }

  @override
  String get regexRuleAddSuccess => 'RegEx-reegel lisati edukalt';

  @override
  String get regexRuleManagement => 'RegEx-reegli haldus';

  @override
  String get regexRuleNamePatternRequired =>
      'Reegli nimi ja RegEx-muster ei saa olla tühjad';

  @override
  String get regexRules => 'RegEx-reeglid';

  @override
  String get regexTesterTitle => 'RegEx-testija';

  @override
  String regexValidationFailed(Object error) {
    return 'RegEx-i valideerimine ebaõnnestus: $error';
  }

  @override
  String get regexValidationSuccess => 'RegEx-i valideerimine õnnestus';

  @override
  String get region => 'Regioon';

  @override
  String get registeredDevicesTitle => 'Registreeritud seadmed';

  @override
  String get rejectAllCalls => 'Keeldu kõigist kõnedest';

  @override
  String get rejectAllCallsDescription =>
      'Kui see on lubatud, keelduvad kõik kõned kõrgeima prioriteediga';

  @override
  String get rejectAllNumbers => 'Keeldu kõigist numbritest';

  @override
  String get rejectAllNumbersDesc =>
      'Keeldu kõigist sissetulevatest kõnedest, kui see on lubatud';

  @override
  String get rejectExceededNumbers => 'Keeldu ületanud numbritest';

  @override
  String get rejectExceededNumbersDescription =>
      'Keeldu automaatselt numbritest, mis ületavad loenduse lävepiiri';

  @override
  String get remoteFilterSettings => 'Eemaldatavad filtrisätted';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Eemaldatavad numbrifiltri sätted';

  @override
  String get remoteNumberFilter => 'Eemaldatav numbrifilter';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'See filter kasutab sõltumatut eemaldatavat andmebaasi, et saada uusimat numbriinformatsiooni.';

  @override
  String get remoteNumberFilterDescription =>
      'Häirivate kõnede pealtkuulamine eemaldatava andmebaasi info põhjal';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Eemaldatav numbrifilter tuvastab ja blokeerib rämpskõned, päringutega eemaldatava andmebaasi poole numbri loenduse põhjal.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Eemaldatava numbrifiltri selgitus';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Loenduse lävepiir: Määrake numbri esinemissageduse põhjal';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Filtri toimingud: Konfigureerige, kuidas ületanud numbreid käsitleda';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Prioriteedi sätted: Määrake eemaldatavate toimingute prioriteet';

  @override
  String get remoteNumberFilterFeatures => 'Funktsioonid:';

  @override
  String get remoteNumberFiltering => 'Eemaldatav numbri filtreerimine';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Eemaldatav numbri filtreerimine: Filtreerimisreeglid eemaldatava andmebaasi info põhjal';

  @override
  String get remoteNumberFilterSubtitle =>
      'Tuvastage rämpskõned pilvandmebaasi ja kogukonnaaruannete abil';

  @override
  String get removeAdsDescription =>
      'Eemaldage kõik reklaamid rakendusest püsivalt, et kogemus oleks sujuvam';

  @override
  String get removeAdsTitle => 'Eemalda reklaamid';

  @override
  String get removedFromFavoriteContacts => 'Eemaldatud lemmikkontaktidest';

  @override
  String get removedFromFavorites => 'Eemaldatud lemmikutest';

  @override
  String get removeFavorite => 'Eemalda lemmik';

  @override
  String get removeFromFavorites => 'Eemalda lemmikutest';

  @override
  String get renameButton => 'Nimeta ümber';

  @override
  String get renameDeviceDialogTitle => 'Nimeta seade ümber';

  @override
  String get renameDeviceTitle => 'Nimeta seade ümber';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'See asendab kõik teie praegused sätted. Kas olete kindel, et soovite jätkata?';

  @override
  String get requestAllPermissions => 'Taotlege kõiki õigusi';

  @override
  String get requestPermission => 'Taotlege luba';

  @override
  String requestPermissionFailed(Object error) {
    return 'Loa taotlemine ebaõnnestus: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count märk(i)';
  }

  @override
  String get reset => 'Lähtesta';

  @override
  String get restore => 'Taasta';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Taasta rakenduse sätted varukoopiast';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Taasta rakenduse sätted varukoopiast';

  @override
  String get restoreButton => 'Taasta';

  @override
  String restoreFailedWithError(Object error) {
    return 'Taastamine pilvest ebaõnnestus: $error';
  }

  @override
  String get restoreFromCloud => 'Taasta pilvest';

  @override
  String get restoreFromCloudDescription =>
      'Taasta sätted ja reeglid pilvesalvestusest';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Taastamine pilvest ebaõnnestus: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Taasta pilvest';

  @override
  String get restoreFromCloudSuccess => 'Taastati edukalt pilvest';

  @override
  String get restoreFromCloudTitle => 'Taasta pilvest';

  @override
  String get restoreFromLocal => 'Taasta lokaalselt';

  @override
  String get restorePurchases => 'Taasta ostud';

  @override
  String get restoreSectionTitle => 'Taasta';

  @override
  String get restoreSettings => 'Taasta sätted';

  @override
  String get restoreSettingsConfirmation =>
      'See asendab kõik teie praegused sätted. Kas olete kindel, et soovite jätkata?';

  @override
  String get restoreSettingsDialogTitle => 'Taasta sätted';

  @override
  String get restoreSettingsTitle => 'Taasta sätted';

  @override
  String get restoreSuccessFromLocal => 'Taastati edukalt lokaalselt';

  @override
  String get restoreSuccessMessage => 'Taastati edukalt pilvest';

  @override
  String get retry => 'Proovi uuesti';

  @override
  String get ridesharing => 'Sõidujagamine';

  @override
  String get risk => 'Risk';

  @override
  String get robocall => 'Robokõne';

  @override
  String get ruleAction => 'Reegli toiming';

  @override
  String get ruleAddButton => 'Lisa reegel';

  @override
  String get ruleAddedSuccess => 'Reegel lisati edukalt';

  @override
  String ruleAddFailure(Object error) {
    return 'Reegli lisamine ebaõnnestus: $error';
  }

  @override
  String get ruleAddSuccess => 'Reegel lisati edukalt';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Kas olete kindel, et soovite selle $ruleType kustutada?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Kustuta reegel';

  @override
  String get ruleDeletedSuccess => 'Reegel kustutati edukalt';

  @override
  String get ruleDeletedSuccessfully => 'Reegel kustutati edukalt';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Reegli kustutamine ebaõnnestus: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Reegli kustutamine ebaõnnestus: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Reegel kustutati edukalt';

  @override
  String get ruleDisabledSuccessfully => 'Reegel keelati edukalt';

  @override
  String get ruleEnabledSuccessfully => 'Reegel lubati edukalt';

  @override
  String ruleLoadFailed(Object error) {
    return 'Reeglite laadimine ebaõnnestus: $error';
  }

  @override
  String get ruleManagement => 'Reeglite haldus';

  @override
  String get ruleManagementTitle => 'Reeglite haldus';

  @override
  String get ruleName => 'Reegli nimi';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Reegli nimi ja sisumuster ei saa olla tühjad';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Reegli nimi ja telefoninumber ei saa olla tühjad';

  @override
  String get ruleNameHint => 'nt Family, Friends jne.';

  @override
  String get ruleNameLabel => 'Reegli nimi';

  @override
  String get ruleNamePatternRequired => 'Palun sisestage reegli nimi ja muster';

  @override
  String get ruleNameRequired =>
      'Reegli nimi ja telefoninumber ei saa olla tühjad';

  @override
  String get ruleNotExist => 'Reegel ei eksisteeri või on kustutatud';

  @override
  String ruleNotFound(Object error) {
    return 'Reeglit ei leitud: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Reegel salvestatud edukalt!';

  @override
  String get ruleSavedSuccessMessage => 'Reegel salvestatud edukalt!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Salvestamine ebaõnnestus: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Salvestamine ebaõnnestus: $error';
  }

  @override
  String get ruleSaveSuccess => 'Reegel salvestatud edukalt!';

  @override
  String get rulesExportedSuccessfully => 'Reeglid eksporditud edukalt';

  @override
  String rulesExportedTo(Object path) {
    return 'Reeglid eksporditud: $path';
  }

  @override
  String get rulesImported => 'Reeglid imporditud edukalt';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count reeglit imporditud edukalt';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Reeglite importimine ebaõnnestus: $error';
  }

  @override
  String get ruleStatistics => 'Reeglite statistika';

  @override
  String ruleStatusChanged(Object status) {
    return 'Reegel $status edukalt';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Toiming ebaõnnestus: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Reegel $status edukalt';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Reegli värskendamine ebaõnnestus: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Reegel värskendatud edukalt';

  @override
  String get ruleVerification => 'Reegli kontroll';

  @override
  String get save => 'Salvesta';

  @override
  String get saveButton => 'Salvesta';

  @override
  String get saveButtonLabel => 'SALVESTA';

  @override
  String get saveButtonText => 'Salvesta';

  @override
  String saveFailed(Object error) {
    return 'Salvestamine ebaõnnestus: $error';
  }

  @override
  String get saveFilter => 'Salvesta filter';

  @override
  String get saveSettings => 'Salvesta seaded';

  @override
  String saveSettingsFailed(Object error) {
    return 'Seadete salvestamine ebaõnnestus: $error';
  }

  @override
  String get scamsLikely => 'Tõenäoliselt pettus';

  @override
  String get search => 'Otsi';

  @override
  String get searchContacts => 'Otsi kontakte';

  @override
  String searchError(Object error) {
    return 'Otsingu viga: $error';
  }

  @override
  String get searchFilters => 'Otsingufiltrid';

  @override
  String get searchForContacts => 'Otsi kontakte';

  @override
  String get searchHint => 'Otsi...';

  @override
  String get searchSettingsSubtitle =>
      'Otsi kontakte, silte, musti nimekirju, valgeid nimekirju jne.';

  @override
  String get searchSettingsTitle => 'Otsinguseaded';

  @override
  String get securityMessage =>
      'Ära usalda ühtegi telefonikõnet. Kontrolli klienditeeninduse numbreid alati iseseisvalt. Ära kunagi jaga paroole, kinnituskoodi, kaardi numbreid ega isiklikku teavet.';

  @override
  String get selectActionToPerform =>
      'Valige toiming, mida teha reegli sobimisel';

  @override
  String get selectActionWhenBlockingCalls =>
      'Valige toiming kõnede blokeerimisel';

  @override
  String get selectActionWhenRuleMatches => 'Valige toiming, kui reegel sobib';

  @override
  String get selectAll => 'Vali kõik';

  @override
  String get selectCountry => 'Vali riik';

  @override
  String get selectDateRange => 'Vali kuupäeva vahemik';

  @override
  String get selectedDateRange => 'Valitud kuupäeva vahemik';

  @override
  String selectedItems(Object count) {
    return '$count elementi valitud';
  }

  @override
  String get selectedLabel => 'Valitud:';

  @override
  String get selectExportFormat => 'Vali ekspordi vorming';

  @override
  String get selectLabel => 'Vali silt';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Palun valige silt ja sisestage kehtiv telefoninumber';

  @override
  String get selectLanguage => 'Vali keel';

  @override
  String get selectMultiple => 'Vali mitu';

  @override
  String get selectPeriod => 'Vali periood';

  @override
  String get selectSimCard => 'Vali SIM-kaart';

  @override
  String get selectSimSlot => 'Vali SIM-pesa';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Valige konkreetne toiming blokeeritud kõnede korral';

  @override
  String get selectTag => 'Vali silt';

  @override
  String get selectTags => 'Vali sildid';

  @override
  String get selectTrustedDataSource =>
      'Palun valige usaldusväärsed andmeallikad';

  @override
  String get selectYourLanguage => 'Vali oma keel';

  @override
  String get sender => 'Saatja';

  @override
  String get senderRegexOptional => 'Saatja Regex (valikuline)';

  @override
  String get serverAddressLabel => 'Serveri aadress';

  @override
  String get serviceTypeContact => 'Kontakti tellimus';

  @override
  String get serviceTypeLabel => 'Teenusetüüp';

  @override
  String get serviceTypePhone => 'Telefoni tellimus';

  @override
  String get serviceTypePlugin => 'Pistikprogrammi värskendus';

  @override
  String get serviceTypeSms => 'SMS-tellimus';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Määra';

  @override
  String get setEncryptionPassword => 'Määra krüptimisparool';

  @override
  String get setEncryptionPasswordDescription =>
      'Määrake krüptimisparool varundamiseks ja taastamiseks';

  @override
  String get setEncryptionPasswordLabel => 'Määra krüptimisparool';

  @override
  String get setEncryptionPasswordTitle => 'Määra krüptimisparool';

  @override
  String get setPasswordButton => 'Määra';

  @override
  String get settings => 'Seaded';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Seaded varundatud: $path';
  }

  @override
  String get settingsLoaded => 'Seaded laaditud';

  @override
  String settingsLoadFailed(Object error) {
    return 'Seadete laadimine ebaõnnestus: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Seaded taastati edukalt. Muudatuste jõustumiseks taaskäivitage rakendus.';

  @override
  String get settingsSaved => 'Seaded salvestatud';

  @override
  String settingsSaveFailed(Object error) {
    return 'Seadete salvestamine ebaõnnestus: $error';
  }

  @override
  String get settingsTab => 'Seaded';

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get setup => 'Seadistamine';

  @override
  String get showContactEditDialogStaticMethod =>
      'Staatiline meetod kontakti redigeerimise dialoogi kuvamiseks';

  @override
  String get showExplanation => 'Näita selgitust';

  @override
  String get silence => 'Vaikus';

  @override
  String get silenceAndNoAnswer => 'Vaikus ja vastuseta';

  @override
  String get silenceNoAnswer => 'Vaikus vastuseta';

  @override
  String get silentCallVoiceClone => 'Hääleklooniga vaikne kõne';

  @override
  String get silentRules => 'Vaiksed reeglid';

  @override
  String simCard(Object simNumber) {
    return 'SIM-kaart $simNumber';
  }

  @override
  String get simCardColor => 'SIM-kaardi värv';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM-kaardi konfiguratsioon: määrake igale SIM-kaardile sõltumatud filtreerimisreeglid';

  @override
  String get simCardFilterRules => 'SIM-kaardi filtreerimisreeglid';

  @override
  String get simCardFilterRulesDescription =>
      'Määrake erinevad filtreerimisreeglid SIM-kaardi pesade alusel';

  @override
  String get simCardFontSize => 'SIM-kaardi fondi suurus';

  @override
  String get simCardPosition => 'SIM-kaardi asukoht';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'SIM-kaardi teabe laadimine ebaõnnestus: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM-kaardi reeglid võimaldavad teil konfigureerida sõltumatud filtreerimisreeglid iga SIM-kaardi pesa kohta.';

  @override
  String get simRuleInstructionsTitle => 'SIM-kaardi pesa reeglid';

  @override
  String get simRuleManagement => 'SIM-kaardi pesa reeglite haldus';

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
    return 'SIM-andmete laadimine ebaõnnestus: $error';
  }

  @override
  String get simSlotFilterConfiguration =>
      'SIM-kaardi pesa filtri konfiguratsioon';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Võimaldab seadistada filtreerimisreegleid SIM-kaardi pesa järgi';

  @override
  String get simSlotFilterDescription =>
      'Konfigureerige sõltumatud filtreerimisreeglid iga SIM-kaardi jaoks:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM-kaardi pesa $slotNumber filtri sätted';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIM-kaartide laadimine ebaõnnestus: $error';
  }

  @override
  String get simSlotManagement => 'SIM-kaardi pesa haldus';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM-kaardi pesa toiming ebaõnnestus: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM-kaardi pesa $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM-kaardi pesa reeglid: sõltumatud filtreerimisstrateegiad SIM-kaardi kohta';

  @override
  String get simSlotRuleListTitle => 'SIM-kaardi pesa reeglite loend';

  @override
  String get simSlotRuleManagement => 'SIM-kaardi pesa reeglid';

  @override
  String get simSlotRuleManagementTitle => 'Reeglite haldus';

  @override
  String get simSlotSettings => 'SIM-kaardi pesa sätted';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM-kaardi pesa $slotNumber';
  }

  @override
  String get skip => 'Jäta vahele';

  @override
  String get smartCallerId => 'Nutikas helistaja ID tuvastus';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS-filtratsioon aitab teil automaatselt rämpspostisõnumeid filtreerida ja hoida oma sõnumiloend puhtana. Saate seadistada filtreerimisreegleid ja teatise meetodeid.';

  @override
  String get smsFilterDisabled => 'SMS-filtratsioon keelatud';

  @override
  String get smsFilterEnabled => 'SMS-filtratsioon lubatud';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'SMS-filtri reegel lisati edukalt';

  @override
  String get smsFilterRules => 'SMS-filtri reeglid';

  @override
  String get smsFilterSettings => 'SMS-filtri sätted';

  @override
  String get smsHistory => 'SMS-i ajalugu';

  @override
  String get smsManagement => 'SMS-halduse';

  @override
  String get smsPermission => 'SMS-luba';

  @override
  String get smsPermissionDescription =>
      'Kasutatakse rämpspostisõnumite filtreerimiseks.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS-reegel lisati edukalt';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS-reegel kustutati edukalt';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'SMS-reeglite laadimine ebaõnnestus: $error';
  }

  @override
  String get smsRuleManagement => 'SMS-reeglite haldus';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS-reeglid eksporditi edukalt faili $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS-reeglid imporditi edukalt';

  @override
  String get smsRuleSubscription => 'SMS-reegli tellimus';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS-reegel värskendati edukalt';

  @override
  String get smsSettingsSubtitle =>
      'SMS-filtratsioon ja märksõnade blokeerimine';

  @override
  String get smsSettingsTitle => 'SMS-i sätted';

  @override
  String get smsSubscription => 'SMS-i tellimus';

  @override
  String get smsSubscriptionAddedSuccessfully => 'SMS-tellimus lisati edukalt';

  @override
  String get smsSubscriptionRulesDescription =>
      'Telli SMS-reeglite loendeid URL-i kaudu, toetades tavaliste avaldiste sobitamist. Saate seadistada blokeerimise või lubamise toimingud.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Mõned õigustaotlused keelatud';

  @override
  String get spamLikely => 'Tõenäoline rämpspost';

  @override
  String get startColor => 'Algusvärv';

  @override
  String get startDate => 'Alguskuupäev';

  @override
  String get startUsing => 'Alusta kasutamist';

  @override
  String get statAnswered => 'Vastatud';

  @override
  String get statBlocked => 'Blokeeritud';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Staatiline meetod helistaja ID teabedialoogi kuvamiseks';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Staatiline meetod riigi valiku dialoogi kuvamiseks';

  @override
  String get staticMethodToDisplayDialog =>
      'Staatiline meetod dialoogi kuvamiseks';

  @override
  String get statistics => 'Statistika';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Statistika eksportimine peatselt saadaval';

  @override
  String get statisticsGrid => 'Statistikavõrk';

  @override
  String get statisticsPageTitle => 'Andmeanalüüs';

  @override
  String get stirColor => 'STIR värv';

  @override
  String get stirFontSize => 'STIR fondi suurus';

  @override
  String get stirPosition => 'STIR positsioon';

  @override
  String get storagePermission => 'Salvestusruumi luba';

  @override
  String get storagePermissionDescription =>
      'Kasutatakse sätete ja reeglite salvestamiseks.';

  @override
  String get subscribe => 'Telli';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Tellimus \"$name\" lisati edukalt';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Kas olete kindel, et soovite selle tellimuse kustutada?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Kustuta tellimus';

  @override
  String get subscriptionDeleted => 'Tellimus kustutatud';

  @override
  String get subscriptionDeletedSuccessfully => 'Tellimus kustutati edukalt';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Tellimuse kustutamine ebaõnnestus: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Tellimus kustutatud';

  @override
  String get subscriptionEmptyState => 'Tellimusi pole saadaval';

  @override
  String get subscriptionEmptyText => 'Tellimusi veel pole';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Tellimuste laadimine ebaõnnestus: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Tellimuste laadimine ebaõnnestus: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Tellimuste haldus';

  @override
  String get subscriptionName => 'Tellimuse nimi';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Tellimuse nimi ja URL ei saa tühjad olla';

  @override
  String get subscriptionNameHint => 'Sisestage tellimuse nimi';

  @override
  String get subscriptionPageTitle => 'Tellimuste haldus';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Tellimuse oleku muutmine ebaõnnestus: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Tellimuse oleku lülitamine ebaõnnestus: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Tellimuse värskendamine ebaõnnestus: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Tellimus värskendati edukalt';

  @override
  String get subscriptionUrl => 'Tellimuse URL';

  @override
  String get subscriptionUrlHint => 'Sisestage tellimuse URL';

  @override
  String successfullyImportedRules(Object count) {
    return 'Edukalt imporditud $count reeglit';
  }

  @override
  String get supportSync => 'Toetage sünkroonimist';

  @override
  String get survey => 'Küsitlus';

  @override
  String get syncDevicesButton => 'Sünkroniseeri seadmed';

  @override
  String get syncFailed => 'Sünkroonimine ebaõnnestus';

  @override
  String get syncFailedMessage => 'Sünkroonimine ebaõnnestus';

  @override
  String get syncFolderNameHint =>
      'Sisestage sünkroonimiskausta nimi (vaikimisi: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Sünkroonimiskausta nimi';

  @override
  String get synchronized => 'Sünkroniseeritud';

  @override
  String get syncing => 'Sünkroniseerimine...';

  @override
  String get syncNow => 'Sünkroniseeri kohe';

  @override
  String get syncNowButton => 'Sünkroniseeri kohe';

  @override
  String get syncStatusTitle => 'Sünkroonimise olek';

  @override
  String get syncStatusUpdatedMessage => 'Sünkroonimise olek värskendatud';

  @override
  String get syncSuccessful => 'Sünkroonimine õnnestus';

  @override
  String get syncSuccessMessage => 'Sünkroonimine õnnestus';

  @override
  String get syncWithCloudStorage => 'Sünkroniseeri pilveserveriga';

  @override
  String get syncWithCloudStorageSubtitle => 'Sünkroniseeri pilveserveriga';

  @override
  String get systemFeatures => 'Süsteemi funktsioonid:';

  @override
  String get systemSettingsTitle => 'Süsteemi seaded';

  @override
  String get tabAll => 'Kõik';

  @override
  String get tabAnswered => 'Vastatud';

  @override
  String get tabBlocked => 'Blokeeritud';

  @override
  String get tabMissed => 'Vastamata';

  @override
  String get tabOutgoing => 'Väljuvad';

  @override
  String tagLabel(String tag) {
    return 'Silt: $tag';
  }

  @override
  String get tagsUpdated => 'Sildid värskendatud';

  @override
  String get takeaway => 'Kaasavõetav';

  @override
  String get telecommunication => 'Telekommunikatsioon';

  @override
  String get telegram => 'Telegramm';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get testConnectionButton => 'Testi ühendust';

  @override
  String get textColorsSetting => 'Teksti ja märgiste värvid';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'See rakendus on võimas helistaja tuvastamise tööriist, mis võimaldab teil tuvastada ja blokeerida soovimatuid kõnesid.';

  @override
  String get thisWeek => 'Sel nädalal';

  @override
  String get timeInterceptor => 'Aja intervalliga blokeerija';

  @override
  String get timeInterceptorDescription =>
      'Hoiatage/lubage kõnesid automaatselt kõnesageduse põhjal';

  @override
  String get timeInterceptorExplanation =>
      '• Aja intervalliga blokeerija: Hoiatage/lubage korduvaid kõnesid lühikese aja jooksul';

  @override
  String get timeInterceptorExplanationContent =>
      'Kõnesageduse blokeerimise funktsioon analüüsib kõnesagedust, et automaatselt tuvastada ja blokeerida/lubada korduvaid rämpskõnesid.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Kõnesageduse blokeerimise selgitus';

  @override
  String get timeInterceptorSettingsTitle => 'Kõnesageduse blokeerimise seaded';

  @override
  String get timeInterceptorSubtitle =>
      'Hoiatage rämpskõnesid automaatselt kõnesageduse põhjal';

  @override
  String get timeInterceptorTitle => 'Luba kõnesageduse blokeerimine';

  @override
  String get timeWindowDescription =>
      'Määrake korduvate kõnede lubamise ajavahemik. Kõned samalt numbrilt selle akna jooksul lubatakse.';

  @override
  String timeWindowLabel(int minutes) {
    return 'Blokeerimise ajavahemik (minutites): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Määrake korduvate kõnede lubamise ajavahemik. Kõned samalt numbrilt selle akna jooksul lubatakse.';

  @override
  String get today => 'Täna';

  @override
  String get total => 'Kokku';

  @override
  String get totalBlocked => 'Kokku blokeeritud';

  @override
  String get totalFiltered => 'Kokku filtreeritud';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Edastage andmeid seadmete või platvormide vahel';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Edastage andmeid seadmete või platvormide vahel';

  @override
  String get travelTicketing => 'Reisipiletid';

  @override
  String get trend => 'Trend';

  @override
  String get trendChart => 'Trendigraafik';

  @override
  String get tutorial => 'Õpetus';

  @override
  String get type => 'Tüüp';

  @override
  String get unassignedSIMCard => 'Määramata SIM-kaart';

  @override
  String get unknown => 'Tundmatu';

  @override
  String get unknownLabel => 'Tundmatu silt';

  @override
  String get unknownTag => 'Silt: Tundmatu';

  @override
  String get unregisterButton => 'De-registreeri';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Kas olete kindel, et soovite seadme $deviceName de-registreerida?';
  }

  @override
  String get unregisterDeviceTitle => 'Seadme de-registreerimine';

  @override
  String get unsupportedFileFormat => 'Toetamata failivorming';

  @override
  String get update => 'Värskenda';

  @override
  String get updateAllNow => 'Värskenda kõike kohe';

  @override
  String get updateCallFilterConfig => 'Värskenda kõnefiltri konfiguratsiooni';

  @override
  String updateContactFailed(Object error) {
    return 'Kontakti värskendamine ebaõnnestus: $error';
  }

  @override
  String get updateFavoriteStatus => 'Värskenda lemmikstaatust';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Lemmikstaatuse värskendamine ebaõnnestus: $error';
  }

  @override
  String get updateInterval => 'Värskendusintervall';

  @override
  String get updateLabelFailed => 'Sildi värskendamine ebaõnnestus';

  @override
  String get updateNow => 'Värskenda kohe';

  @override
  String get updatePlugin => 'Värskenda pistikprogrammi';

  @override
  String updatePluginFailed(Object error) {
    return 'Pistikprogrammi värskendamine ebaõnnestus: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Reegli värskendamine ebaõnnestus: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Tellimuse värskendamine ebaõnnestus: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service värskendatud edukalt ($count reeglit)';
  }

  @override
  String get updateTags => 'Värskenda silte';

  @override
  String get useCasesPoint1 =>
      '• Tuvastage automaatselt uuesti valivad rämpskõned';

  @override
  String get useCasesPoint2 =>
      '• Hoiatage turunduskõnesid, mis helistavad lühikese aja jooksul mitu korda';

  @override
  String get useCasesPoint3 => '• Vältige telefoniga pommitamist ja ahistamist';

  @override
  String get useCasesTitle => 'Kasutusalad:';

  @override
  String get useGlobalSettings => 'Kasuta globaalseid sätteid';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Kasutajanimi';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Kasutage mustrite määratlemiseks standardset regex-süntaksit. Näited:';

  @override
  String get validateRegex => 'Valideeri Regex';

  @override
  String get verificationFailedText => 'Ebaõnnestunud';

  @override
  String get verifiedText => 'Kinnitatud';

  @override
  String get verify => 'Kinnita';

  @override
  String version(Object version) {
    return 'Versioon: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Vahetage VIP-liikmelisust telefoninumbri märgistamise arvude vastu';

  @override
  String get vipExchangeTitle => 'Vaheta VIP-i märgis';

  @override
  String get watchAd => 'Vaata reklaami';

  @override
  String get watchAdForTemp => 'Vaata reklaami ajutiste privileegide saamiseks';

  @override
  String get watchAdForTempDescription =>
      'Vaadake lühike reklaam, et ajutiselt mõned premium-funktsioonid avada';

  @override
  String get webDAVConfigTitle => 'WebDAVi konfiguratsioon';

  @override
  String get webdavConfigurationTitle => 'WebDAVi konfiguratsioon';

  @override
  String get webdavPasswordHint => 'Palun sisestage WebDAVi parool';

  @override
  String get webdavServerAddressHint =>
      'Palun sisestage WebDAVi serveri aadress';

  @override
  String get webdavUsernameHint => 'Palun sisestage WebDAVi kasutajanimi';

  @override
  String get week => 'Nädal';

  @override
  String get weekly => 'Iganädalane';

  @override
  String get weeklyBlockedCallsSummary =>
      'Iganädalane blokeeritud kõnede kokkuvõte';

  @override
  String get weeklyChartTitle => 'Iganädalased blokeeritud kõned';

  @override
  String get weeklyReport => 'Iganädalane aruanne';

  @override
  String get weeklyReportDesc =>
      'Saate iganädalase kokkuvõtliku aruande kõnede blokeerimise tegevusest';

  @override
  String get welcome => 'Tere tulemast';

  @override
  String get whitelist => 'Valge nimekiri';

  @override
  String get whitelistLabel => 'Valge nimekiri';

  @override
  String get width => 'Laius';

  @override
  String get wildcardMatchingDescription =>
      'Kasutage \'.\' mis tahes märgi sobitamiseks (nt \'123.456\' sobib 123-456-ga)';

  @override
  String get wildcardMatchingTitle => 'Jokkerimärkide sobitamine:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Jokkerimärkide tugi paindlikuks filtreerimiseks';

  @override
  String get windowSizeSetting => 'Aken suurus';

  @override
  String get year => 'Aasta';

  @override
  String get yearly => 'Aastane';

  @override
  String get yearlyChartTitle => 'Aastased blokeeritud kõned';

  @override
  String get noSimCardsDetected => 'SIM-kaarte ei leitud';

  @override
  String get filterManagementDescription => 'Seadistage kõnefiltrid';

  @override
  String get callerIdCustomizationSubtitle =>
      'Kohandage helistaja numbri kuvamispaigutust';

  @override
  String get fraudAlerSettingTitle => 'Pettusehoiatuse seadistus';

  @override
  String get fraudAlerSettingSubtitle => 'Pettusehoiatuse seadistamiseks';

  @override
  String get enableFraudAlert => 'Luba pettusehojatus';

  @override
  String get enableFraudAlertDescription =>
      'Hoiatus kahtlaste pettuskõnede kohta';

  @override
  String get enableVibration => 'Luba vibratsioon';

  @override
  String get enableVibrationDescription =>
      'Vibreerib kahtlaste pettuskõnede korral';

  @override
  String get notificationSettingsTitle => 'Teavitussätted';

  @override
  String get useLocalNotification => 'Kasutage kohalikke teavitusi';

  @override
  String get useLocalNotificationDescription =>
      'Luba kohalikke teavitusi sissetulevate kõnede jaoks';

  @override
  String get cancelLocalNotification => 'Sulge kohalikud teavitused';

  @override
  String get useStirNotification => 'Kasutage STIRilt teavitust';

  @override
  String get useStirNotificationDescription =>
      'Luba STIR-teavitusi sissetulevate kõnede jaoks';

  @override
  String get cancelLocalNotificationDescription =>
      'Sulge kohalikud teavitused automaatselt';

  @override
  String get callerIdSettingsTitle => 'Helistaja numbri sätted';

  @override
  String get callerIdSettingsSubtitle =>
      'Sissetuleva kõne teavituse ja kuvamisrežiimi seadistamiseks';

  @override
  String get purchaseTitle => 'Ost';

  @override
  String get purchaseSubtitle => 'Teenuse ostmiseks';

  @override
  String get callerIdNotificationTitle => 'Sissetuleva kõne teave';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Number: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Blokeeritud kõne';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Blokeeritud kõne $phoneNumber';
  }

  @override
  String get stirVerified => 'Kinnitatud';

  @override
  String get stirNotVerified => 'Pole kinnitatud';

  @override
  String get stirFailed => 'Kinnitamine ebaõnnestus';

  @override
  String get stirUnknown => 'Teadmata kinnitusolek';

  @override
  String get stirVerificationTitle => 'STIR/SHAKENi kinnitus';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage numbrile $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings => 'Keriva turvasõnumi sätted';

  @override
  String get messageColor => 'Sõnumi värv';

  @override
  String get messageFontSize => 'Sõnumi fondisuurus';

  @override
  String get messagePosition => 'Sõnumi asukoht';

  @override
  String get containerWidth => 'Konteineri laius';

  @override
  String get scrollSpeed => 'Kerimiskiirus';

  @override
  String get enableSecurityMessage => 'Luba turvasõnum';

  @override
  String get fraudAlertTitle => 'Pettusehojatus';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Potentsiaalne pettusekõne $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Reeglite laadimine ebaõnnestus: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Kõnelogi laadimine ebaõnnestus: $error';
  }

  @override
  String get noBlockedTypeData => 'Blokeeritud tüüpi andmed pole saadaval';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importige $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName imporditud edukalt, imporditud kokku $count kirjet';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName import ebaõnnestus: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Ekspordige $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName eksporditud edukalt';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName eksport ebaõnnestus: $error';
  }

  @override
  String get cloudSyncService => 'Pilvesünkroonimise teenus';

  @override
  String get membershipCenter => 'Liikmesuse keskus';

  @override
  String get redeemVipWithMarks => 'Lunastage VIP märkidega';

  @override
  String get currentMarkCount => 'Praegune märkide arv';

  @override
  String get markMoreNumbersForMore =>
      'Märkige rohkem numbreid rohkemaks märkideks';

  @override
  String get noAds => 'Pole reklaame';

  @override
  String get cloudBackup => 'Pilvevarundus';

  @override
  String get callerIdEnhancement => 'Helistaja numbri täiustamine';

  @override
  String get voiceRecognition => 'Häältuvastus';

  @override
  String get feature => 'Funktsioon';

  @override
  String get normalUser => 'Tavakasutaja';

  @override
  String get vipUser => 'VIP-kasutaja';

  @override
  String get temporaryVip => 'Ajutine VIP';

  @override
  String get removeAds => 'Eemalda reklaamid';

  @override
  String get unknownAction => 'Tundmatu toiming';

  @override
  String get settingsBackup => 'Sätete varundus ';

  @override
  String get allServicesStatusTitle => 'Praegune teenuse olek';

  @override
  String get allServicesStatusSubtitle => 'Iga pilveteenuse praegune olek';

  @override
  String get redirect => 'Edasi suunama';

  @override
  String get notify => 'Teavitama';

  @override
  String get log => 'Logi';

  @override
  String get custom => 'Kohandatud';

  @override
  String get allowActionDescription =>
      'Kõned lubatakse, isegi kui number on blokeeritud nimekirjas.';

  @override
  String get blockActionDescription =>
      'Kõned blokeeritakse ja kuvatakse kõnelogis.';

  @override
  String get silenceActionDescription =>
      'Kõned vaigistatakse, kuid kuvatakse kõnelogis.';

  @override
  String get noneActionDescription => 'Kõne jaoks eritoimingut ei tehta.';

  @override
  String get redirectActionDescription => 'Suunake kõne määratud numbrile.';

  @override
  String get labelActionDescription =>
      'Lisage kõnele silt lihtsamaks tuvastamiseks.';

  @override
  String get notifyActionDescription => 'Saate kõne saabumisel teate.';

  @override
  String get logActionDescription =>
      'Logige kõne teave ilma muid toiminguid tegemata.';

  @override
  String get customActionDescription => 'Tehke kohandatud toiming.';

  @override
  String get synced => 'Sünkroniseeritud';

  @override
  String get needVipAccess =>
      'Selle funktsiooni kasutamiseks vajate VIP-juurdepääsu';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importige või eksportige $entityTypeName andmeid';
  }

  @override
  String get importExportTitle => 'Import/eksport';

  @override
  String get noPhoneRules => 'Telefoni reeglid puuduvad';

  @override
  String get noRegexRules => 'Regulereeglid puuduvad';

  @override
  String get noAllowedBlockedRules => 'Lubatud/blokeeritud reeglid puuduvad';

  @override
  String get importExport => 'Import/eksport';

  @override
  String get filterByAction => 'Filtreerige tegevuse järgi';

  @override
  String get upgradeToVip => 'Uuenda VIP-ks';

  @override
  String get batteryOptimizationPermission => 'Aku aku aku';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Luba rakendusel töötada taustal, et pakkuda teenuseid nagu helistaja ID.';

  @override
  String get permissionTitle => 'Eriload';

  @override
  String get permissionSubtitle => 'Halda ülekatte- ja aku optimeerimise lube';

  @override
  String get themeSettingsTitle => 'Teemaseaded';

  @override
  String get themeSettingsSubtitle => 'Valige oma lemmikteema';

  @override
  String get databaseSyncTitle => 'Andmebaasi sünkroonimine';

  @override
  String get countrySyncSettingsTitle =>
      'Riigipõhised andmebaasi sünkroonimise sätted';

  @override
  String get countrySyncSettingsSubtitle =>
      'Valige andmete sünkroonimiseks riigid';

  @override
  String get countryDataDisclaimer =>
      'Pange tähele: Andmebaas ei pruugi sisaldada andmeid kõigi konkreetsete riikide või piirkondade kohta.';

  @override
  String get editSubscription => 'Muuda tellimust';

  @override
  String get searchByNameOrPhoneNumber => 'Otsi nime või telefoninumbri järgi';

  @override
  String get allowedBlockedRulesInfo =>
      'Lubatud/blokeeritud reegleid kasutatakse kõnede sobitamiseks konkreetsete telefoninumbritega, millel on kõrgeim prioriteet.';

  @override
  String get searchPhoneRulesHint => 'Otsi telefonireegleid';

  @override
  String get phoneRulesInfo =>
      'Telefonireegleid kasutatakse kõnede sobitamiseks konkreetsete telefoninumbritega, millel on madalam prioriteet. Mõned pärinevad telefonireegli tellimustest';

  @override
  String get searchSubscriptionsHint => 'Otsi tellimusi';

  @override
  String get searchPluginsHint => 'Otsi pistikprogramme';

  @override
  String get searchLabelsHint => 'Otsi silte';

  @override
  String get pluginDescription => 'Pistikprogrammi kirjeldus';

  @override
  String get enterPluginDescription => 'Sisestage pistikprogrammi kirjeldus';

  @override
  String get searchRegexRulesHint => 'Otsi regex reegleid';

  @override
  String get regexRulesInfo =>
      'Regex reegleid kasutatakse kõnede filtreerimiseks Regex mustrite põhjal.';

  @override
  String get searchMarkedPhonesHint => 'Otsi märgitud telefone';

  @override
  String get searchContactSubscriptionsHint => 'Otsi kontaktide tellimusi';

  @override
  String get showAllContacts => 'Näita kõiki kontakte';

  @override
  String get showFavorites => 'Näita lemmikuid';

  @override
  String get manualEntry => 'Käsitsi sisestamise teave';

  @override
  String get scriptSaved => 'Skript salvestatud';

  @override
  String editScriptFor(String pluginName) {
    return 'Muuda skripti $pluginName jaoks';
  }

  @override
  String get saveScript => 'Salvesta skript';

  @override
  String get testPlugin => 'Testi pistikprogrammi';

  @override
  String get description => 'Kirjeldus';

  @override
  String get accessTargetUrl => 'Juurdepääs sihtaadressile';

  @override
  String get result => 'Tulemus';

  @override
  String get editScript => 'Muuda skripti';

  @override
  String get numberFormat => 'Numbrivorming';

  @override
  String get nationalNumber => 'Rahvuslik number';

  @override
  String get e164Number => 'E164 number';

  @override
  String get pluginRulesInfo =>
      'Turvalisuse tagamiseks kasutage ainult usaldusväärsetest allikatest pärit pistikprogramme. Looge julgelt oma kohandatud pistikprogramme meie mallide abil!';

  @override
  String get advancedMode => 'Täpsem režiim';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Palun sisestage vähemalt üks number.';

  @override
  String get openInWebView => 'Ava WebView\'s';

  @override
  String get pluginLabel => 'Pistikprogrammi silt';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Sõnumi taustavärv';

  @override
  String get clearAllCallLogs => 'Tühjenda kõik kõnelogid';

  @override
  String get clearAllCallLogsConfirmation =>
      'Kinnita kõigi kõnelogide tühjendamine';

  @override
  String get allCallLogsCleared => 'Kõik kõnelogid tühjendatud';

  @override
  String get unblocked => 'Blokeering tühistatud';

  @override
  String get blockNumber => 'Blokeeri number';

  @override
  String get blockNumberSuccess => 'Numbri blokeerimine õnnestus';

  @override
  String get blockNumberFailed => 'Numbri blokeerimine ebaõnnestus';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Kas olete kindel, et soovite tühistada $phoneNumber blokeeringu?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Helistatakse $phoneNumber...';
  }

  @override
  String get viewDetails => 'Vaata üksikasju';

  @override
  String get unblock => 'Tühista blokeering';

  @override
  String get unblockNumber => 'Tühista numbri blokeering';

  @override
  String get unblockNumberSuccess => 'Number edukalt blokeeritud';

  @override
  String get unblockNumberFailed =>
      'Numbri blokeeringu tühistamine ebaõnnestus';

  @override
  String get serviceNotAvailable => 'Teenus pole saadaval';

  @override
  String get callingNumberFailed => 'Helistatava numbri tõrge';

  @override
  String get listView => 'Loendi vaade';

  @override
  String get timelineView => 'Ajajoon vaade';

  @override
  String get nameCannotBeEmpty => 'Nimi ei saa olla tühi';

  @override
  String get selectAction => 'Valige toiming';

  @override
  String get selectTargetService => 'Valige sihtteenus';

  @override
  String get callDetails => 'Kõne üksikasjad';

  @override
  String get callType => 'Kõne tüüp';

  @override
  String get callTime => 'Kõne aeg';

  @override
  String get numberInvalidFormat => 'Number vales vormingus';

  @override
  String get membershipFeature => 'Liikmelisuse funktsioon';

  @override
  String get medium => 'Keskmine';

  @override
  String get verificationReport => 'Kontrolliaruanne';

  @override
  String get finalRisk => 'Lõplik risk';

  @override
  String get simState => 'SIM olek';

  @override
  String get ipCountry => 'IP riik';

  @override
  String get simCountry => 'SIM riik';

  @override
  String get isRoaming => 'Rändlus';

  @override
  String get isNumberMatch => 'Numbri vaste';

  @override
  String get support => 'Tugi';

  @override
  String get rewardedAdService => 'Autasustatud reklaamide teenus';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Teil on juba VIP-õigused (v.a reklaamid)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Teil on juba ajutised õigused, aegumiskuupäev: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Peate vaatama veel $count reklaami, et saada ajutised VIP-õigused';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Teile on antud $days päeva ajutised ostuõigused. Aegumiskuupäev: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Ajutised ostuõigused on aegunud';

  @override
  String get loadingAd => 'Laeb reklaami...';

  @override
  String get earnedTempVip => 'Teenitud ajutine VIP';

  @override
  String get vipExchangeService => 'VIP vahetusteenus';

  @override
  String get marksInsufficient => 'Vahetuseks pole piisavalt märke';

  @override
  String get invalidExchangeRule => 'Kehtetu vahetuse reegel';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Vahetati edukalt $description, aegumiskuupäev: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Vahetus ebaõnnestus: $error';
  }

  @override
  String get vip3DaysWithAds =>
      '3-päevane VIP koos reklaamidega (ainult sünkroonimine)';

  @override
  String get vip5DaysNoAds => '5-päevane täisfunktsionaalne reklaamivaba VIP';

  @override
  String get vip7DaysNoAds => '7-päevane täisfunktsionaalne reklaamivaba VIP';

  @override
  String get noNotifications => 'Teateid pole';

  @override
  String get clearAllNotifications => 'Tühjenda kõik teated';

  @override
  String get clearAllNotificationsConfirmation =>
      'Kinnita kõigi teadete tühjendamine';

  @override
  String get allNotificationsCleared => 'Kõik teatised on tühjendatud';

  @override
  String get clearButton => 'Tühjenda';

  @override
  String get justNow => 'Just praegu';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutit tagasi',
      one: '1 minut tagasi',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tundi tagasi',
      one: '1 tund tagasi',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count päeva tagasi',
      one: '1 päev tagasi',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Eile';

  @override
  String get deletionProposal => 'Kustutamisettepanek';

  @override
  String get deletionProposals => 'Kustutamisettepanekud';

  @override
  String get createProposal => 'Loo ettepanek';

  @override
  String get createProposalTitle => 'Loo kustutamisettepanek';

  @override
  String get reason => 'Põhjus';

  @override
  String get reasonOutdated => 'Vanu andmeid';

  @override
  String get reasonPrivacy => 'Privaatsusmure';

  @override
  String get reasonNotInService => 'Ei ole teenuses';

  @override
  String get reasonWronglyIdentified => 'Valesti tuvastatud';

  @override
  String get reasonInaccurateInfo => 'Ebatäpne teave';

  @override
  String get reasonWrongMarked => 'Valesti märgitud';

  @override
  String get reasonOther => 'Muu';

  @override
  String get submit => 'Esita';

  @override
  String get cancel => 'Tühista';

  @override
  String get proposalStatus => 'Olek';

  @override
  String get statusPending => 'Ootel';

  @override
  String get statusActive => 'Aktiivne';

  @override
  String get statusCompleted => 'Lõpetatud';

  @override
  String get statusExpired => 'Aegunud';

  @override
  String get riskLevel => 'Riskitase';

  @override
  String get riskLevelVerified => 'Tuvastatud';

  @override
  String get riskLevelLow => 'Madal';

  @override
  String get riskLevelHigh => 'Kõrge';

  @override
  String get riskLevelUnknown => 'Teadmata';

  @override
  String get votingProgress => 'Hääletuse käik';

  @override
  String agreeVotes(int count) {
    return 'Poolt: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Vastu: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Kokku: $count';
  }

  @override
  String get voteAgree => 'Poolt';

  @override
  String get voteDisagree => 'Vastu';

  @override
  String createdAt(String date) {
    return 'Loodud: $date';
  }

  @override
  String get showReport => 'Näita aruannet';

  @override
  String get hideReport => 'Peida aruanne';

  @override
  String get proposalStatistics => 'Ettepanekute statistika';

  @override
  String get totalProposals => 'Ettepanekuid kokku';

  @override
  String get activeProposals => 'Aktiivsed ettepanekud';

  @override
  String get completedProposals => 'Lõpetatud ettepanekud';

  @override
  String get myVotes => 'Minu hääled';

  @override
  String get proposalCreated => 'Ettepanek loodi edukalt';

  @override
  String get proposalCreateFailed => 'Ettepaneku loomine nurjus';

  @override
  String get voteSubmitted => 'Hääl esitati edukalt';

  @override
  String get voteSubmitFailed => 'Hääle esitamine nurjus';

  @override
  String get noProposalsFound => 'Ettepanekuid ei leitud';

  @override
  String get loadingProposals => 'Ettepanekuid laetakse...';

  @override
  String get refreshProposals => 'Värskenda ettepanekud';

  @override
  String get totalPendingProposals => 'Ootel ettepanekuid kokku';

  @override
  String get highRisk => 'Kõrge risk';

  @override
  String get mediumRisk => 'Keskmine risk';

  @override
  String get lowRisk => 'Madal risk';

  @override
  String get communityImpact => 'Kogukonna mõju';

  @override
  String get criticalIssues => 'Kriitilised probleemid';

  @override
  String get communityParticipation => 'Kogukonna osalus';

  @override
  String get noActivity => 'Puudub tegevus';

  @override
  String get low => 'Madal';

  @override
  String get moderate => 'Mõõdukas';

  @override
  String get high => 'Kõrge';

  @override
  String get veryHigh => 'Väga kõrge';

  @override
  String get voted => 'Hääletatud';

  @override
  String get communityVotes => 'Kogukonna hääled';

  @override
  String get waitingForMoreVotes => 'Oodatakse rohkem kogukonna hääli';

  @override
  String get proposalProcessed => 'See ettepanek on töödeldud';

  @override
  String get supported => 'TOETATUD';

  @override
  String get opposed => 'VASTATUD';

  @override
  String get approved => 'HEAKS KIIDETUD';

  @override
  String get rejected => 'TAGASI LÜKATUD';

  @override
  String get completed => 'LÕPETATUD';

  @override
  String get pending => 'OTSELINE';

  @override
  String get critical => 'Kriitiline';

  @override
  String get oppose => 'Vastu';

  @override
  String get veryLow => 'Väga madal';

  @override
  String get deletionProposalNotificationDescription =>
      'Teated kustutamisettepanekute hääletustulemuste ja uuenduste kohta.';

  @override
  String get deletionProposalCreated => 'Kustutamisettepanek loodud';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Teie kustutamisettepanek numbrile $phoneNumber on esitatud kogukonna ülevaatamiseks.';
  }

  @override
  String get proposalApproved => 'Ettepanek heaks kiidetud ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Kogukond kiitis numbri $phoneNumber kustutamisettepaneku heaks ($supportPercentage% toetus, $totalVotes häält).';
  }

  @override
  String get proposalRejected => 'Ettepanek tagasi lükatud ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Kogukond lükkas numbri $phoneNumber kustutamisettepaneku tagasi ($supportPercentage% toetus, $totalVotes häält).';
  }

  @override
  String get communityVotingStarted => 'Kogukonna hääletus alanud';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Uus kustutamisettepanek numbrile $phoneNumber on avatud kogukonna hääletuseks.';
  }

  @override
  String get votingCompleted => 'Hääletus lõppenud';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Numbri $phoneNumber kogukonna hääletus on lõppenud. Tulemus: $result ($supportPercentage% toetus).';
  }

  @override
  String get newVoteReceived => 'Uus hääl saadud';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Keegi hääletas numbri $phoneNumber kustutamise poolt $voteType. Praegused hääled: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Häälte arvu laadimine nurjus';

  @override
  String get voteCount => 'Häälte arv';

  @override
  String get deletionProposalInfo => 'Kustutamisettepaneku teave';

  @override
  String get deletionProposalDescription =>
      'Esitage kustutamiseks numbrid, mis rikuvad kogukonna juhiseid. Teie osalus aitab platvormi turvalisena hoida.';

  @override
  String get voteToEarnVip =>
      'Hääletage ettepanekute poolt, et teenida VIP-õigusi!';

  @override
  String get voteFailed => 'Hääletamine nurjus';

  @override
  String get searchProposals => 'Otsi ettepanekuid';

  @override
  String get defaultNotifications => 'Vaiketeated';

  @override
  String get defaultNotificationsDescription => 'Rakenduse vaiketeatekanal.';

  @override
  String get blockedCallNotifications => 'Blokeeritud kõneteated';

  @override
  String get blockedCallNotificationsDescription =>
      'Kuvab teavet blokeeritud kõnede kohta.';

  @override
  String get stirVerification => 'STIR/SHAKENi verifitseerimine';

  @override
  String get stirVerificationDescription =>
      'Kuvab STIR/SHAKENi verifitseerimistulemused numbrite jaoks.';

  @override
  String get fraudAlerts => 'Pettusehoiatused';

  @override
  String get fraudAlertsDescription =>
      'Kuvab hoiatusi potentsiaalsete pettuslike kõnede kohta.';

  @override
  String get notificationFrequencyDescription =>
      'Valige, kui tihti teile uute kustutamisettepanekute kohta teateid saadetakse. Saate neid saada kohe, partiidena või kohandatud ajavahemiku järel.';

  @override
  String get immediateNotifications => 'Kohe';

  @override
  String get immediateNotificationsDescription =>
      'Saate teate niipea, kui ettepanek luuakse.';

  @override
  String get batchNotifications => 'Partiina';

  @override
  String get batchNotificationsDescription =>
      'Saate perioodiliselt teadete kokkuvõtte.';

  @override
  String get customNotifications => 'Kohandatud';

  @override
  String get customNotificationsDescription =>
      'Määrake oma ajavahemik teadete saamiseks.';

  @override
  String get customFrequency => 'Kohandatud sagedus';

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
  String get pendingProposals => 'Ootel ettepanekud';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ootel ettepanekut',
      one: '1 ootel ettepanek',
      zero: 'ootel ettepanekuid ei ole',
    );
    return 'Teil on $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Juhised';

  @override
  String get reportingGuidelines =>
      '• Raporteerige ainult numbreid, mis on tõeliselt problemaatilised\n• Esitage täpsed ja üksikasjalikud põhjendused\n• Valige sobiv riskitase sõltuvalt tõsidusest\n• Valeraportid võivad põhjustada konto piiramist';

  @override
  String get riskLevelLabel => 'Riskitase';

  @override
  String get riskLevelDescription => 'Numbrite riskitase';

  @override
  String get phoneNumberMinDigits =>
      'Telefoninumber peab olema vähemalt 7 numbrit pikk';

  @override
  String get provideDetailedExplanation =>
      'Esitage üksikasjalik selgitus (miinimunm 10 tähemärki)';

  @override
  String get reasonMinCharacters =>
      'Põhjendus peab olema vähemalt 10 tähemärki pikk';

  @override
  String get countryCodeTwoLetters => 'Riigikood (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Riigikood (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'nt. US, CN, GB';

  @override
  String get countryCodeRequired => 'Riigikood on kohustuslik';

  @override
  String get countryCodeLengthError => 'Riigikood peab olema 2 tähte pikk';

  @override
  String get phoneNumberLengthError =>
      'Telefoninumber peab olema vähemalt 7 numbrit pikk';

  @override
  String get reasonHint =>
      'Esitage üksikasjalik selgitus (miinimunm 10 tähemärki)';

  @override
  String get reasonRequired => 'Põhjendus on kohustuslik';

  @override
  String get reasonLengthError =>
      'Põhjendus peab olema vähemalt 10 tähemärki pikk';

  @override
  String get guidelinesTitle => 'Juhised';

  @override
  String get guidelinesText =>
      '• Raporteerige ainult numbreid, mis on tõeliselt problemaatilised\n• Esitage täpsed ja üksikasjalikud põhjendused\n• Valige sobiv riskitase sõltuvalt tõsidusest\n• Valeraportid võivad põhjustada konto piiramist';

  @override
  String get riskLevelCritical => 'Kriitiline';

  @override
  String get riskLevelMedium => 'Keskmine';

  @override
  String get riskLevelVeryLow => 'Väga madal';

  @override
  String get riskDescriptionVeryLow => 'Väga madal - väike tüli, harvad kõned';

  @override
  String get riskDescriptionLow => 'Madal - aeg-ajalt soovimatud kõned';

  @override
  String get riskDescriptionMedium =>
      'Keskmine - tavaline rämpspost või telemarketing';

  @override
  String get riskDescriptionHigh =>
      'Kõrge - pidev ahistamine või pettusekatsed';

  @override
  String get riskDescriptionCritical =>
      'Kriitiline - ohtlikud pettused või ähvardused';

  @override
  String get notificationFrequencyTitle => 'Teavitussagedus';

  @override
  String get notificationFrequencyLabel => 'Teavitussagedus (tunnid)';

  @override
  String errorMessage(String error) {
    return 'Viga: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Hääled: $totalVotes ($supportPercentage%) toetust';
  }

  @override
  String supportCount(int supportCount) {
    return 'Toetus ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Vastuseis ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Äsja';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m tagasi';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}t tagasi';
  }

  @override
  String timeDaysAgo(int days) {
    return '${days}p tagasi';
  }

  @override
  String get notificationFrequencyHours => 'Teavitussagedus (tunnid)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes häält ($supportPercentage% toetust)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tundi',
      one: '1 tund',
      zero: '0 tundi',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Tähtis teadaanne';

  @override
  String get dataSourceDisclaimer =>
      'Numbrid pärinevad internetist ja kasutajate esitatud andmetest. Me ei saa garanteerida, et number pärast kustutamist ei esitata uuesti teiste kasutajate või allikate poolt. Palun otsige ja kontrollige teavet aktiivselt.';

  @override
  String get avatar => 'Avatari';

  @override
  String get location => 'Asukoht';

  @override
  String get simCardTitle => 'SIM-kaart';

  @override
  String get liveActivitiesSettingsTitle => 'Reaalajas tegevuste seaded';

  @override
  String get elementsSettingsTitle => 'Elementide seaded';

  @override
  String get liveActivityMode => 'Reaalajas tegevus';

  @override
  String get liveActivityModeDescription =>
      'Kuvab kõneinfot lukustusekraanil ja dünaamilisel saarel (iOS) püsiva teatisena.';

  @override
  String get phoneNumberType => 'Telefoninumbri tüüp';

  @override
  String get liveActivitiesTestEndActivity => 'Lõpeta tegevus';

  @override
  String get liveActivitiesTestSendNewActivity => 'Saada uus tegevus';

  @override
  String get liveActivitiesTestUpdateActivity => 'Värskenda tegevust';

  @override
  String get liveActivityControlsTitle => 'Reaalajas tegevuse juhtnupud';

  @override
  String get liveActivitiesTestTitle => 'Reaalajas tegevuste test';

  @override
  String get liveActivitiesTestSubtitle =>
      'Testige reaalajas tegevuse teatist.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Reaalajas teate kohandamine';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Kohandage reaalajas teadete välimust.';

  @override
  String get notification_instructions =>
      'Juhised:\n1. Puudutage \"SAADA\", et luua või värskendada teatist.\n2. Minge oma avaekraanile või tõmmake teavitusriba alla, et näha tulemust.\n3. Puudutage \"LÕPETA\", et teatis sulgeda.';

  @override
  String get autoCancelNotification => 'Automaatne tühistamine';

  @override
  String get autoCancelNotificationDescription =>
      'Kui on märgitud, tühistatakse teatis automaatselt, kui kasutaja sellele puudutab.';

  @override
  String get setDelayTime => 'Määra viivitusaeg';

  @override
  String get proposalDetails => 'Ettepaneku üksikasjad';

  @override
  String get filterByStatus => 'Filtreeri oleku järgi';

  @override
  String get proposalNotFound => 'Ettepanekut ei leitud';

  @override
  String get processed => 'Töödeldud';

  @override
  String get showAll => 'Näita kõiki';

  @override
  String get filterAndSortTitle => 'Filtreeri ja sorteeri';

  @override
  String get filterVerifiedOwner => 'Filtreeri kinnitatud omaniku järgi';

  @override
  String get filterBy => 'Filtreeri';

  @override
  String get sortOldest => 'Sorteeri vanemate järgi';

  @override
  String get sortNewest => 'Sorteeri uuemate järgi';

  @override
  String get sortMostPopular => 'Sorteeri kõige populaarsemate järgi';

  @override
  String get sortLeastPopular => 'Sorteeri kõige vähem populaarsete järgi';

  @override
  String get sortBy => 'Sorteeri';

  @override
  String get simRulesNotFound => 'SIM-reegleid ei leitud';

  @override
  String get simSlotRules => 'SIM-pesa reeglid';

  @override
  String get noSimCardDetected => 'SIM-kaarti ei tuvastatud';

  @override
  String get invalidSimData => 'Kehtetud SIM-andmed';

  @override
  String get simCardData => 'SIM-kaardi andmed';

  @override
  String get simSlot => 'SIM-pesa';

  @override
  String get enableFiltering => 'Luba filtreerimine';

  @override
  String get detailedSettingsTitle => 'Üksikasjalikud seaded';

  @override
  String get entryPointViewTitle => 'Sisenemispunkti vaade';

  @override
  String get callTypeRejected => 'Tagasi lükatud';

  @override
  String get callTypeSilenced => 'Vaigistatud';

  @override
  String get callTypeVoicemail => 'Kõnepost';

  @override
  String get callTypeUnknownIntercept => 'Tundmatu vahelesekkumine';

  @override
  String andMoreItems(int count) {
    return 'ja veel $count üksust';
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
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';
}
