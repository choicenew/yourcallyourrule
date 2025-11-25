// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get aboutContactSubscription => 'Tietoja yhteystietotilauksesta';

  @override
  String get aboutLabels => 'Tietoja tunnisteista';

  @override
  String get aboutPhoneSubscriptionRules => 'Tietoja puhelintilaussäännöistä';

  @override
  String get aboutPhoneSubscriptions => 'Tietoja puhelintilauksista';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Tilaa puhelinsääntöluetteloita URL-osoitteen kautta, päivitä sääntöjä automaattisesti. Tukee JSON-, CSV-muotoisia sääntötiedostoja.';

  @override
  String get aboutSmsFilter => 'Tietoja tekstiviestisuodatuksesta';

  @override
  String get aboutSmsSubscriptionRules =>
      'Tietoja tekstiviestitilaussäännöistä';

  @override
  String get aboutSubtitle => 'Sovelluksen versio ja lakitiedot';

  @override
  String get aboutTitle => 'Tietoja';

  @override
  String get action => 'Toiminto';

  @override
  String get actionAll => 'Kaikki';

  @override
  String get actionAllow => 'Salli';

  @override
  String get actionBlock => 'Estä';

  @override
  String get actionFilterAll => 'Kaikki suodattimet';

  @override
  String get actionFilterTitle => 'Suodata toimintatyypin mukaan';

  @override
  String get actionFilterTooltip => 'Toimintosuodatin';

  @override
  String get actionNone => 'Ei toimintoa';

  @override
  String get actionSilence => 'Hiljennä';

  @override
  String actionTag(Object actionType) {
    return 'Toiminto: $actionType';
  }

  @override
  String get actionType => 'Toimintatyyppi';

  @override
  String get actionUnknown => 'Tuntematon';

  @override
  String get add => 'Lisää';

  @override
  String get addAllowedBlockedRule => 'Lisää sallitut/estetyt sääntö';

  @override
  String get addAllowSubscription => 'Lisää sallitut tilaus';

  @override
  String get addBlockSubscription => 'Lisää estetyt tilaus';

  @override
  String get addContactButton => 'Lisää yhteystieto';

  @override
  String addContactFailed(Object error) {
    return 'Yhteystiedon lisäys epäonnistui: $error';
  }

  @override
  String get addedToAllowedRules => 'Lisätty sallittuihin sääntöihin';

  @override
  String get addedToBlacklist => 'Lisätty estolistalle';

  @override
  String get addedToBlockedRules => 'Lisätty estettyihin sääntöihin';

  @override
  String get addedToFavoriteContacts => 'Lisätty suosikk yhteystietoihin';

  @override
  String get addedToFavorites => 'Lisätty suosikkeihin';

  @override
  String get addedToWhitelist => 'Lisätty sallittujen luetteloon';

  @override
  String get addFavorite => 'Lisää suosikki';

  @override
  String get addFilter => 'Lisää suodatin';

  @override
  String get addLabel => 'Lisää tunniste';

  @override
  String get addLabelButton => 'Lisää tunniste';

  @override
  String addLabelFailed(Object error) {
    return 'Tunnisteen lisäys epäonnistui: $error';
  }

  @override
  String get addLabelToCall => 'Lisää tunniste puhelutietoihin';

  @override
  String get addName => 'Lisää nimi';

  @override
  String get addNoneSubscription => 'Lisää ei mitään tilausta';

  @override
  String get addOrEditContactInfo =>
      'Käytetään yhteystietojen lisäämiseen tai muokkaamiseen';

  @override
  String get addPhoneMark => 'Lisää puhelinmerkki';

  @override
  String get addPhoneNumberRule => 'Lisää puhelinnumerosääntö';

  @override
  String get addPlugin => 'Lisää lisäosa';

  @override
  String get addPluginFailed => 'Lisäosan lisäys epäonnistui';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Lisäosan lisäys epäonnistui: $error';
  }

  @override
  String get addPluginFromLocalFile =>
      'Lisää lisäosa paikallisesta tiedostosta';

  @override
  String get addPluginFromUrl => 'Lisää lisäosa URL-osoitteesta';

  @override
  String get addRegexRule => 'Lisää säännöllinen lausekesääntö';

  @override
  String get addRule => 'Lisää sääntö';

  @override
  String get addRuleButton => 'Lisää sääntö';

  @override
  String addRuleFailed(Object error) {
    return 'Säännön lisäys epäonnistui: $error';
  }

  @override
  String get addRuleTooltip => 'Lisää sääntö';

  @override
  String get addSilenceSubscription => 'Lisää hiljentävä tilaus';

  @override
  String get addSimRuleButton => 'Lisää SIM-sääntö';

  @override
  String get addSmsFilterRule => 'Lisää tekstiviestisuodatus sääntö';

  @override
  String get addSmsRule => 'Lisää tekstiviestisääntö';

  @override
  String get addSmsSubscription => 'Lisää tekstiviestitilaus';

  @override
  String get addSubscription => 'Lisää tilaus';

  @override
  String get addSubscriptionButton => 'Lisää tilaus';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Tilauksen lisäys epäonnistui: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Lisää tilaus';

  @override
  String get addToAllowedRules => 'Lisää sallittuihin sääntöihin';

  @override
  String get addToBlacklist => 'Lisää estolistalle';

  @override
  String get addToBlockedRules => 'Lisää estettyihin sääntöihin';

  @override
  String get addToFavoriteContacts => 'Lisää suosikki yhteystietoihin';

  @override
  String get addToFavorites => 'Lisää suosikkeihin';

  @override
  String get addToRules => 'Lisää sääntöihin';

  @override
  String get addToWhitelist => 'Lisää sallittujen luetteloon';

  @override
  String get adPlaceholder => 'Mainos paikkamerkki';

  @override
  String get agent => 'Agentti';

  @override
  String get all => 'Kaikki';

  @override
  String get allCallsTab => 'Kaikki';

  @override
  String get allDataClearedSuccessfully =>
      'Kaikki tiedot tyhjennetty onnistuneesti';

  @override
  String get allow => 'Salli';

  @override
  String get allowAllAllowRules => 'Salli kaikki sallitut säännöt';

  @override
  String get allowAllAllowRulesDesc => 'Salli puhelut sallituista säännöistä';

  @override
  String get allowAllBlacklistedNumbers =>
      'Salli kaikki estolistalla olevat numerot';

  @override
  String get allowAllBlacklistedNumbersDesc => 'Salli puhelut estolistalta';

  @override
  String get allowAllBlockRules => 'Salli kaikki estetyt säännöt';

  @override
  String get allowAllBlockRulesDesc => 'Salli puhelut estetyistä säännöistä';

  @override
  String get allowAllowedNumbers => 'Salli sallitut numerot';

  @override
  String get allowAllowedNumbersDesc =>
      'Salli puhelut sallituista luetteloista';

  @override
  String get allowBlock => 'Salli/Estä';

  @override
  String get allowBlockedNumbers => 'Salli estetyt numerot';

  @override
  String get allowBlockedNumbersDesc => 'Salli puhelut estolistalta';

  @override
  String get allowedBlockedRule => 'Salli/Estä sääntö';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Muokkaa sallittu/estetty sääntöä';

  @override
  String get allowedBlockedRuleManagement => 'Salli/Estä sääntöjen hallinta';

  @override
  String get allowNonExceededNumbers => 'Salli rajat ylittämättömät numerot';

  @override
  String get allowNonExceededNumbersDescription =>
      'Salli automaattisesti numerot, jotka eivät ylitä raja-arvoa';

  @override
  String get allowRegexAllowRules =>
      'Salli säännöllisten lausekkeiden sallitut säännöt';

  @override
  String get allowRegexAllowRulesDesc =>
      'Ota käyttöön säännöllisten lausekkeiden vastaavuus sallituissa säännöissä';

  @override
  String get allowRegexAllowRulesDescription =>
      'Ota käyttöön säännöllisiin lausekkeisiin perustuvat sallitut säännöt';

  @override
  String get allowRegexBlockRules =>
      'Salli säännöllisten lausekkeiden estetyt säännöt';

  @override
  String get allowRegexBlockRulesDesc =>
      'Ota käyttöön säännöllisten lausekkeiden vastaavuus estetyissä säännöissä';

  @override
  String get allowRegexBlockRulesDescription =>
      'Ota käyttöön säännöllisiin lausekkeisiin perustuvat estetyt säännöt';

  @override
  String get allowRule => 'Salli sääntö';

  @override
  String get allowRules => 'Salli säännöt';

  @override
  String get allowWhitelistedNumbers =>
      'Salli valkoisten numeroiden salliminen';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Salli kaikki valkoisella listalla olevat numerot';

  @override
  String get allPermissionsGranted => 'Kaikki käyttöoikeudet myönnetty';

  @override
  String get allSettingsCompleted => 'Kaikki asetukset suoritettu.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Kaikki päivitykset suoritettu ($count sääntöä)';
  }

  @override
  String get answerThenHangup => 'Vastaa ja katkaise puhelu';

  @override
  String get appLegalese =>
      '© 2023 Sinun Puhelusi Sinun Sääntösi. Kaikki oikeudet pidätetään.';

  @override
  String get applicationSoftware => 'Sovellusohjelmisto';

  @override
  String get apply => 'Käytä';

  @override
  String get appName => 'Sinun Puhelusi Sinun Sääntösi';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Valtuutus epäonnistui: Tarkista asiakastunnus ja avain';

  @override
  String get authorizationFailedMessage => 'Valtuutus epäonnistui';

  @override
  String get authorizationSuccessMessage => 'Valtuutus onnistui';

  @override
  String get authorizeLoginButton => 'Valtuuta kirjautuminen';

  @override
  String get automotiveIndustry => 'Autoteollisuus';

  @override
  String get autoSyncLabel => 'Automaattinen synkronointi';

  @override
  String get autoUpdate => 'Automaattinen päivitys';

  @override
  String get autoUpdateDescription =>
      'Aseta automaattiset päivitysvälit tilauksille tai päivitä manuaalisesti';

  @override
  String get autoUpdateSettings => 'Automaattisen päivityksen asetukset';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Hallitse sääntöjen ja lisäosien automaattisia päivityksiä';

  @override
  String get autoUpdateSettingsTitle => 'Automaattisen päivityksen asetukset';

  @override
  String get autoUpdateSubtitle =>
      'Hallitse sääntöjen ja lisäosien automaattisia päivityksiä';

  @override
  String get autoUpdateTitle => 'Automaattinen päivitys';

  @override
  String get avatarBorderColor => 'Avatarin reunaväri';

  @override
  String get avatarBorderSize => 'Avatarin reunaviivan koko';

  @override
  String get avatarIconSizesSetting => 'Avatarin ja kuvakkeen koot';

  @override
  String get avatarPosition => 'Avatarin sijainti';

  @override
  String get avatarSize => 'Avatarin koko';

  @override
  String axisPosition(Object axis) {
    return '$axis-sijainti';
  }

  @override
  String get backgroundGradientSetting => 'Taustagradientin asetus';

  @override
  String get backup => 'Varmuuskopiointi';

  @override
  String get backupAndRestore => 'Varmuuskopiointi ja palautus';

  @override
  String get backupAndRestoreSubtitle =>
      'Varmuuskopioi tai palauta sovelluksen tiedot';

  @override
  String get backupAndRestoreTitle => 'Varmuuskopiointi ja palautus';

  @override
  String get backupFailed => 'Varmuuskopiointi epäonnistui';

  @override
  String get backupFailedMessage => 'Varmuuskopiointi epäonnistui';

  @override
  String backupFailedWithError(Object error) {
    return 'Varmuuskopiointi epäonnistui: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'Varmuuskopioi tai palauta sovelluksen tiedot';

  @override
  String get backupRestoreTitle => 'Varmuuskopiointi ja palautus';

  @override
  String get backupSectionTitle => 'Varmuuskopiointi';

  @override
  String get backupSettings => 'Varmuuskopiointiasetukset';

  @override
  String get backupSettingsDialogTitle => 'Varmuuskopiointiasetukset';

  @override
  String get backupSettingsTitle => 'Varmuuskopiointiasetukset';

  @override
  String get backupSuccessMessage =>
      'Varmuuskopiointi pilveen onnistui onnistuneesti';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Varmuuskopiointi onnistui sijaintiin: $path';
  }

  @override
  String get backupToCloud => 'Varmuuskopiointi pilveen';

  @override
  String get backupToCloudDescription =>
      'Varmuuskopioi asetukset ja säännöt pilvitallennustilaan';

  @override
  String backupToCloudFailed(Object error) {
    return 'Varmuuskopiointi pilveen epäonnistui: $error';
  }

  @override
  String get backupToCloudLabel => 'Varmuuskopiointi pilveen';

  @override
  String get backupToCloudSuccess =>
      'Varmuuskopiointi pilveen onnistui onnistuneesti';

  @override
  String get backupToCloudTitle => 'Varmuuskopiointi pilveen';

  @override
  String get backupToLocalLabel => 'Varmuuskopiointi paikallisesti';

  @override
  String get bank => 'Pankki';

  @override
  String get basicInfo => 'Perustiedot';

  @override
  String get basicRuleFilter => 'Perussääntösuodatin';

  @override
  String get basicRuleFiltering => 'Perussääntöjen suodatus';

  @override
  String get basicRuleFilteringExplanation =>
      '• Perussääntöjen suodatus: Sääntöjen suodatus mustan listan, valkoisen listan ja säännöllisten lausekkeiden perusteella';

  @override
  String get basicRuleFilterSettings => 'Perussääntösuodattimen asetukset';

  @override
  String get basicRuleFilterSubtitle =>
      'Suodata puheluita mustan/valkoisen listan ja säännöllisten lausekkeiden avulla';

  @override
  String get batchDeleteContacts => 'Useamman kontaktin poisto';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Haluatko varmasti poistaa $count valittua kontaktia?';
  }

  @override
  String get batchDeleteFailed => 'Useamman poisto epäonnistui';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Haluatko varmasti poistaa $count valittua tunnusta?';
  }

  @override
  String get blacklist => 'Musta lista';

  @override
  String get blacklistingAndWhitelisting =>
      'Mustalle listalle lisääminen ja valkoiselle listalle lisääminen';

  @override
  String get blacklistLabel => 'Musta lista';

  @override
  String get blackWhiteList => 'Musta/valkoinen lista';

  @override
  String get block => 'Estä';

  @override
  String get blockCalls => 'Estä puhelut';

  @override
  String get blocked => 'Estetty';

  @override
  String get blockedCallAction => 'Estetty puhelun toiminto';

  @override
  String get blockedCalls => 'Estetyt puhelut';

  @override
  String get blockedCallsTitle => 'Estetyt puhelut';

  @override
  String get blockedCommunications => 'Estetyt yhteydenotot';

  @override
  String get blockedPhoneLabel => 'Estetyt puhelut';

  @override
  String get blockedSpamCalls => 'Estetyt roskapuhelut';

  @override
  String get blockingTrend => 'Estotrendi';

  @override
  String get blockInternationalCalls =>
      'vastaa numeroita, jotka eivät ala + tai 00';

  @override
  String get blockInternationalCallsTitle => 'Estä kansainväliset puhelut';

  @override
  String get blockLandlineNumbersTitle => 'Estä lankapuhelinnumerot';

  @override
  String get blockMobileNumbers => 'vastaa numeroita, jotka eivät ala 13-19';

  @override
  String get blockMobileNumbersTitle => 'Estä matkapuhelinnumerot';

  @override
  String get blockPremiumRateNumbers =>
      'vastaa numeroita, jotka eivät ala 118 tai 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Estä numerot, joilla on korkea hintaluokka';

  @override
  String get blockRule => 'Estosääntö';

  @override
  String get blockRules => 'Estosäännöt';

  @override
  String get blockSpecificAreaCodes =>
      'vastaa numeroita, jotka alkavat 0 + 2-3 numeroa';

  @override
  String get blockSpecificAreaCodesTitle => 'Estä tietyt suuntanumerot:';

  @override
  String get blockTypeAnalysisTitle => 'Estotyypin analyysi';

  @override
  String get both => 'Molempia';

  @override
  String get bulkDelete => 'Useamman kontaktin poisto';

  @override
  String get bulkDeleteContacts => 'Useamman kontaktin poisto';

  @override
  String get bulkDeleteLabels => 'Useamman tunnuksen poisto';

  @override
  String get call => 'Puhelu';

  @override
  String get callback => 'Takaisinsoitto';

  @override
  String callbackTo(String number) {
    return 'Soita takaisin numeroon $number';
  }

  @override
  String get callBlocking => 'Puheluiden esto';

  @override
  String get callerIdApp => 'Soittajan tunnuksen sovellus';

  @override
  String get callerIdCustomizationTitle => 'Soittajan tunnuksen mukauttaminen';

  @override
  String get callerIdDialogTitle => 'Soittajan tunnuksen tiedot';

  @override
  String get callerIdDisplayMode => 'Puhelun tunnuksen näyttötila';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Merkitty $count kertaa';
  }

  @override
  String get callerIdPreview => 'Puhelun tunnuksen esikatselu';

  @override
  String get callFilter => 'Puhelusuodatus';

  @override
  String get callFilterDescription =>
      'Kun tämä on käytössä, saapuvat puhelut tarkistetaan alla olevan sääntölistan perusteella. Puhelusuodatussääntöjä ei oletusarvoisesti synkronoida laitteiden välillä.';

  @override
  String get callFilterRules => 'Puhelusuodatussäännöt';

  @override
  String get callFilterRulesDescription =>
      'Aseta perussäännöt puhelusuodatukselle';

  @override
  String get callFilterSettings => 'Puhelusuodatusasetukset';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Aseta puhelutiheysrajat ja esto-säännöt';

  @override
  String get callFrequencyInterceptionTitle => 'Puhelutiheyden sieppaus';

  @override
  String get callHistory => 'Puheluhistoria';

  @override
  String get callHistoryInfoDesc =>
      'Tässä näkyy puheluhistoriasi, mukaan lukien saapuneet, lähteneet ja vastaamattomat puhelut.';

  @override
  String get callHistoryInfoTitle => 'Puheluhistoria';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Puheluhistorian alustus epäonnistui: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Puheluhistorian päivitys epäonnistui: $error';
  }

  @override
  String get callHistoryTab => 'Puheluhistoria';

  @override
  String get callHistoryTimelineEarlier => 'Aikaisemmin';

  @override
  String get callHistoryTimelineToday => 'Tänään';

  @override
  String get callHistoryTimelineYesterday => 'Eilen';

  @override
  String get callScreeningPermission => 'Puhelun seulontaoikeus';

  @override
  String get callScreeningPermissionDescription =>
      'Käytetään roskapuheluiden seulontaan ja estämiseen.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Puhelun seulontaoikeutta ei ole myönnetty, mikä voi vaikuttaa sovelluksen toimintaan.';

  @override
  String get callSettingsSubtitle =>
      'Puhelun tunnuksen, suodatuksen ja eston asetukset';

  @override
  String get callSettingsTitle => 'Puhelun asetukset';

  @override
  String get callStatistics => 'Puhelutilastot';

  @override
  String get callTypeAnswered => 'Vastattu';

  @override
  String get callTypeBlocked => 'Estetty';

  @override
  String get callTypeIconColor => 'Puhelutyypin kuvakkeen väri';

  @override
  String get callTypeMissed => 'Vastaamaton puhelu';

  @override
  String get callTypeOutgoing => 'Lähteneet';

  @override
  String get callTypePosition => 'Puhelutyypin sijainti';

  @override
  String get callTypeUnknown => 'Tuntematon';

  @override
  String get cancelButton => 'Peruuta';

  @override
  String get carRental => 'Autonvuokraus';

  @override
  String get carrier => 'Operaattori';

  @override
  String get carrierColor => 'Operaattorin väri';

  @override
  String get carrierFontSize => 'Operaattorin fonttikoko';

  @override
  String get carrierPosition => 'Operaattorin sijainti';

  @override
  String get changeLabel => 'Vaihda tunniste';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Liitännäisen tilan muuttaminen epäonnistui: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Tilauksen tilan muuttaminen epäonnistui: $error';
  }

  @override
  String get changeTag => 'Vaihda merkintä';

  @override
  String get charity => 'Hyväntekeväisyys';

  @override
  String chartMonthFormat(int month) {
    return 'Kuukausi $month';
  }

  @override
  String get chartOneDayAgo => '1 päivä sitten';

  @override
  String get chartOneMonthAgo => '1 kuukausi sitten';

  @override
  String get chartOneWeekAgo => '1 viikko sitten';

  @override
  String get chartTenDaysAgo => '10 päivää sitten';

  @override
  String get chartThreeDaysAgo => '3 päivää sitten';

  @override
  String get chartToday => 'Tänään';

  @override
  String get checkFileFormat => 'Tarkista tiedostomuoto tai käyttöoikeudet';

  @override
  String checkPermissionFailed(Object error) {
    return 'Käyttöoikeuksien tarkistus epäonnistui: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'Valitse oletus sieppaustoiminto';

  @override
  String get clearAllData => 'Tyhjennä kaikki tiedot';

  @override
  String get clearAllDataConfirmation =>
      'Oletko varma, että haluat tyhjentää kaikki sovelluksen tiedot? Tätä toimenpidettä ei voi peruuttaa.';

  @override
  String get clearAllDataDescription => 'Tyhjennä kaikki sovelluksen tiedot';

  @override
  String get clearAllDataLabel => 'Tyhjennä kaikki tiedot';

  @override
  String get clearFilter => 'Tyhjennä suodatin';

  @override
  String get clearLabelFilter => 'Tyhjennä tunnistesuodatin';

  @override
  String get clearLabelFilterButton => 'Tyhjennä tunnistesuodatin';

  @override
  String get closeButton => 'Sulje';

  @override
  String get cloudSync => 'Pilvisynkronointi';

  @override
  String get cloudSyncAndBackupTitle => 'Pilvisynkronointi & Varmuuskopiointi';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Määritä WebDAV, OneDrive ja Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Pilvisynkronoinnin asetukset';

  @override
  String get cloudSyncTitle => 'Pilvisynkronointi';

  @override
  String get collapseLabelSelector => 'Kokoa tunnisteen valitsin';

  @override
  String get collection => 'Velanperintä';

  @override
  String get colorPickerTitle => 'Valitse väri';

  @override
  String get configManagement => 'Konfiguraationhallinta';

  @override
  String get configUpdated => 'Konfiguraatio päivitetty';

  @override
  String get configurationAdvice =>
      'Asianmukaisella konfiguraatiolla voit asettaa erilaisia suodatusstrategioita työ- ja henkilökohtaisille SIM-korteille.';

  @override
  String get configureBackupOptions => 'Määritä varmuuskopiointivaihtoehdot';

  @override
  String get configureBackupOptionsSubtitle =>
      'Määritä varmuuskopiointivaihtoehdot';

  @override
  String get configureCloudSyncService => 'Määritä pilvisynkronointipalvelu';

  @override
  String get configureCloudSyncServiceHint =>
      'Määritä pilvisynkronointipalvelu monilaitteisen synkronoinnin mahdollistamiseksi.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Määritä pilvisynkronointipalvelu monilaitteisen synkronoinnin mahdollistamiseksi.';

  @override
  String get configureSimCardFilterRules =>
      'Määritä SIM-kortin suodatussäännöt';

  @override
  String get configureSyncServiceHint =>
      'Määritä ensin synkronointipalvelu pilvisynkronoinnin asetuksissa';

  @override
  String get confirm => 'Vahvista';

  @override
  String get confirmBatchDeleteContacts =>
      'Oletko varma, että haluat poistaa valitut';

  @override
  String get confirmButton => 'Vahvista';

  @override
  String get confirmDelete => 'Vahvista poisto';

  @override
  String get confirmDeleteContact => 'Oletko varma, että haluat poistaa';

  @override
  String get confirmDeleteContactName => 'Vahvista poisto?';

  @override
  String get confirmDeleteFilter =>
      'Oletko varma, että haluat poistaa tämän suodattimen?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Oletko varma, että haluat poistaa tunnisteen \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Oletko varma, että haluat poistaa liitännäisen \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Oletko varma, että haluat poistaa $count liitännäistä?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Oletko varma, että haluat poistaa tämän säännön? Tätä toimenpidettä ei voi peruuttaa.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Oletko varma, että haluat poistaa valitut yhteystiedot?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Oletko varma, että haluat poistaa tämän tekstiviestisuodatussäännön?';

  @override
  String get confirmDeleteSmsRule =>
      'Oletko varma, että haluat poistaa tämän tekstiviestin säännön?';

  @override
  String get confirmDeleteSubscription =>
      'Oletko varma, että haluat poistaa tämän tilauksen?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Oletko varma, että haluat poistaa $name?';
  }

  @override
  String get confirmPassword => 'Vahvista salasana';

  @override
  String get confirmPasswordLabel => 'Vahvista salasana';

  @override
  String get connectedStatus => 'Yhdistetty';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Yhteys epäonnistui: Tarkista palvelimen osoite, käyttäjänimi ja salasana';

  @override
  String get connectionFailedMessage => 'Yhteys epäonnistui';

  @override
  String get connectionStatusLabel => 'Yhteyden tila';

  @override
  String get connectionSuccessMessage => 'Yhteys onnistui';

  @override
  String get contactAddSuccess => 'Yhteyshenkilö lisätty onnistuneesti';

  @override
  String get contactDeleted => 'Yhteyshenkilö poistettu';

  @override
  String get contactEditDialog => 'Yhteyshenkilön muokkausikkuna';

  @override
  String get contactNameHint => 'Syötä yhteyshenkilön nimi (valinnainen)';

  @override
  String get contactNameLabel => 'Nimi';

  @override
  String get contactNameOptional => 'Yhteyshenkilön nimi (valinnainen)';

  @override
  String get contactNotFound => 'Yhteyshenkilöä ei löydy';

  @override
  String get contacts => 'Yhteystiedot';

  @override
  String contactsDeleted(Object count) {
    return 'Poistettu $count yhteystietoa';
  }

  @override
  String get contactSettingsSubtitle => 'Yhteystietojen ja tarrojen hallinta';

  @override
  String get contactSettingsTitle => 'Yhteystietojen asetukset';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Yhteystietojen lataus epäonnistui: $error';
  }

  @override
  String get contactsManagement => 'Yhteystietojen hallinta';

  @override
  String get contactsManagementPageTitle => 'Yhteystietojen hallintasivu';

  @override
  String get contactsPageTitle => 'Yhteystietojen hallinta';

  @override
  String get contactsPermission => 'Yhteystietojen käyttöoikeus';

  @override
  String get contactsPermissionDescription =>
      'Käytetään tunnistamaan yhteystietoihin liittyviä puheluita.';

  @override
  String get contactsTab => 'Yhteystiedot';

  @override
  String get contactSubscriptionDescription =>
      'Tilaa yhteystietoluetteloita URL-osoitteen kautta, päivitä yhteystietoja ja tarroja automaattisesti. Tukee JSON-muotoista dataa.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Yhteystietotilausten lataus epäonnistui: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Yhteystietotilaukset';

  @override
  String get contactUpdateSuccess => 'Yhteystieto päivitetty onnistuneesti';

  @override
  String get contactUs => 'Ota yhteyttä';

  @override
  String get content => 'Sisältö';

  @override
  String get contentRegex => 'Sisällön säännöllinen lauseke';

  @override
  String get countColor => 'Määrän väri';

  @override
  String get countFontSize => 'Määrän fonttikoko';

  @override
  String get countPosition => 'Määrän sijainti';

  @override
  String get country => 'Maa';

  @override
  String get countryNameColor => 'Maan nimen väri';

  @override
  String get countryNameFontSize => 'Maan nimen fonttikoko';

  @override
  String get countryRegionNamePosition => 'Maan/alueen nimen sijainti';

  @override
  String get countrySelectionDialog => 'Maavalintaikkuna';

  @override
  String get countrySelectionDialogDescription =>
      'Käytetään maan valintaan puhelinnumerotietojen hakemiseksi';

  @override
  String get countThresholdDescription =>
      'Aseta vähimmäismääräraja, joka vaaditaan suodatustoimintojen käynnistämiseksi';

  @override
  String get countThresholdLabel => 'Määräraja';

  @override
  String get countThresholdSettings => 'Määrärajan asetukset';

  @override
  String countThresholdValue(Object count) {
    return 'Määräraja: $count';
  }

  @override
  String get createdRules => 'Luodut säännöt';

  @override
  String get csvFormat => 'CSV-muoto';

  @override
  String get currentDeviceChip => 'Nykyinen';

  @override
  String get currentDeviceLabel => 'Nykyisen laitteen tarra';

  @override
  String get currentDeviceTitle => 'Nykyinen laite';

  @override
  String get currentLabels => 'Nykyiset tarrat:';

  @override
  String get currentLanguage => 'Nykyinen kieli';

  @override
  String get currentPasswordLabel => 'Nykyinen salasana';

  @override
  String get customerService => 'Asiakaspalvelu';

  @override
  String get customRange => 'Mukautettu alue';

  @override
  String get dailyStatistics => 'Päivittäiset tilastot';

  @override
  String get dailyStatisticsDesc =>
      'Vastaanota päivittäisiä tilastoja estetyistä puheluista ja viesteistä';

  @override
  String get dashboardTab => 'Kojelauta';

  @override
  String get dataAnalysis => 'Data-analyysi';

  @override
  String get dataAnalysisDashboardPage => 'Data-analyysin kojelautasivu';

  @override
  String get dataExport => 'Datan vienti';

  @override
  String dataLoadFailure(Object error) {
    return 'Datan lataus epäonnistui: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Datan lataus epäonnistui: $error';
  }

  @override
  String get dataMigration => 'Datan siirto';

  @override
  String get dataMigrationDescription =>
      'Tämän ominaisuuden avulla voit siirtää kaiken datasi laitteiden välillä. Tällä hetkellä voit käyttää varmuuskopiointi- ja palautustoimintoja datan manuaaliseen siirtämiseen.';

  @override
  String get dataMigrationDialogContent =>
      'Tämän ominaisuuden avulla voit siirtää kaiken datasi laitteiden välillä. Tällä hetkellä voit käyttää varmuuskopiointi- ja palautustoimintoja datan manuaaliseen siirtämiseen.';

  @override
  String get dataMigrationDialogTitle => 'Datan siirto';

  @override
  String get dataMigrationSectionTitle => 'Datan siirto';

  @override
  String get dataSourceReminder => 'Datalähteen muistutus';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count päivää',
      one: '1 päivä',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Päivää VIP';
  }

  @override
  String get debtCollection => 'Velkojen perintä';

  @override
  String get defaultPeriod => 'Viikko';

  @override
  String get delete => 'Poista';

  @override
  String get deleteButton => 'Poista';

  @override
  String get deleteContact => 'Poista yhteyshenkilö';

  @override
  String deleteContactConfirm(Object name) {
    return 'Haluatko varmasti poistaa $name?';
  }

  @override
  String get deleteContactConfirmation =>
      'Haluatko varmasti poistaa yhteyshenkilön';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Haluatko varmasti poistaa laitteen $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Laitteen poisto';

  @override
  String deleteFailed(Object error) {
    return 'Poisto epäonnistui: $error';
  }

  @override
  String get deleteFilter => 'Poista suodatin';

  @override
  String get deleteLabel => 'Poista tarra';

  @override
  String deleteLabelFailed(Object error) {
    return 'Tarran poisto epäonnistui: $error';
  }

  @override
  String get deletePlugin => 'Poista liitännäinen';

  @override
  String deletePluginFailed(Object error) {
    return 'Liitännäisen poisto epäonnistui: $error';
  }

  @override
  String get deletePlugins => 'Poista liitännäiset';

  @override
  String deletePluginsFailed(Object error) {
    return 'Liitännäisten poisto epäonnistui: $error';
  }

  @override
  String get deleteRule => 'Poista sääntö';

  @override
  String deleteRuleFailed(Object error) {
    return 'Poisto epäonnistui: $error';
  }

  @override
  String get deleteSelected => 'Poista valitut';

  @override
  String get deleteSmsRule => 'Poista tekstiviestiasetus';

  @override
  String get deleteSubscription => 'Poista tilaus';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Haluatko varmasti poistaa tilauksen \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Tilauksen poisto epäonnistui: $error';
  }

  @override
  String get deleteSuccess => 'Poisto onnistui';

  @override
  String get delivery => 'Toimitus';

  @override
  String get deviceDeletedSuccessfully => 'Laite poistettu onnistuneesti';

  @override
  String get deviceDeletedSuccessfullyMessage =>
      'Laite poistettu onnistuneesti';

  @override
  String get deviceIdLabel => 'Laitetunnus';

  @override
  String get deviceIDLabel => 'Laitetunnus';

  @override
  String get deviceManagementSubtitle =>
      'Hallitse monilaitetason synkronointia';

  @override
  String get deviceManagementTitle => 'Laitteiston hallinta';

  @override
  String get deviceModelLabel => 'Laitteen malli';

  @override
  String get deviceName => 'Laitteen nimi';

  @override
  String get deviceNameCannotBeEmpty => 'Laite nimeä ei voi jättää tyhjäksi';

  @override
  String get deviceNameHint => 'Syötä laitteen nimi';

  @override
  String get deviceNameLabel => 'Laitteen nimi';

  @override
  String get deviceRenamedSuccessfully =>
      'Laite nimettiin uudelleen onnistuneesti';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Laite nimettiin uudelleen onnistuneesti';

  @override
  String get devicesSyncedSuccessfully =>
      'Laitteet synkronoitiin onnistuneesti';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Laitteet synkronoitiin onnistuneesti';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Laitteet synkronoitiin onnistuneesti';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Laite poistettiin rekisteröinnistä onnistuneesti';

  @override
  String get dialogTitle => 'Säännöllisen lausekkeen kuvio selitys';

  @override
  String get differentFromLocalCounter =>
      'Tämä ominaisuus eroaa paikallisesta laskurisuodattimesta, koska se keskittyy lyhyen ajan sisällä toistuviin puhekuvioihin pitkäaikaisen merkitsemismäärien sijaan.';

  @override
  String get disabled => 'Poistettu käytöstä';

  @override
  String get disabledStatus => 'Poistettu käytöstä';

  @override
  String get disableGlobalPlugins => 'Poista globaalit laajennukset käytöstä';

  @override
  String get disableSubscriptionSuccessfully =>
      'Tilaus poistettiin käytöstä onnistuneesti';

  @override
  String get disconnectButton => 'Katkaise yhteys';

  @override
  String get disconnectedMessage => 'Yhteys katkaistu';

  @override
  String get disconnectedStatus => 'Yhteys katkaistu';

  @override
  String get disconnectFailedMessage => 'Yhteyden katkaisu epäonnistui';

  @override
  String get done => 'Valmis';

  @override
  String get dualSimAdvice =>
      'Tämä ominaisuus on erityisen hyödyllinen dual-SIM-puhelimille, jotta voit määrittää erilaisia suodatusstrategioita työ- ja henkilökohtaisille SIM-korteille.';

  @override
  String get earlier => 'Aiemmin';

  @override
  String get ecommerce => 'Verkkokauppa';

  @override
  String get edit => 'Muokkaa';

  @override
  String get editContact => 'Muokkaa yhteystietoa';

  @override
  String get editFilter => 'Muokkaa suodatinta';

  @override
  String get editLabel => 'Muokkaa etikettiä';

  @override
  String get editPhoneRule => 'Muokkaa puhelusääntöä';

  @override
  String get editPhoneRules => 'Käytetään puhelusääntöjen muokkaamiseen';

  @override
  String get editPhoneRuleTitle => 'Muokkaa puhelusääntöä';

  @override
  String get editRule => 'Muokkaa sääntöä';

  @override
  String get editSmsRule => 'Muokkaa tekstiviestin sääntöä';

  @override
  String get education => 'Koulutus';

  @override
  String get elementPositionsSetting => 'Elementtien sijainnit';

  @override
  String get email => 'Sähköposti';

  @override
  String get emailOptional => 'Sähköposti (valinnainen)';

  @override
  String get enableCallFilter => 'Ota puhelusuodatus käyttöön';

  @override
  String get enableCallFilterDescription =>
      'Kun tämä on käytössä, saapuvat puhelut tarkistetaan alla olevan sääntölistan perusteella. Puhelun suodatussääntöjä ei synkronoida laitteiden välillä oletusarvoisesti.';

  @override
  String get enabled => 'Käytössä';

  @override
  String get enabledStatus => 'Käytössä';

  @override
  String get enableEncryption => 'Ota salaus käyttöön';

  @override
  String get enableEncryptionDescription => 'Salaa varmuuskopiotiedostot';

  @override
  String get enableEncryptionLabel => 'Ota salaus käyttöön';

  @override
  String get enableEncryptionSubtitle => 'Varmuuskopiotiedostot salataan';

  @override
  String get enableEncryptionTitle => 'Ota salaus käyttöön';

  @override
  String get enableGlobalPlugins => 'Ota globaalit laajennukset käyttöön';

  @override
  String get enableLocalCountFilter =>
      'Ota paikallinen laskurisuodatin käyttöön';

  @override
  String get enableLocalCountFilterDescription =>
      'Suodata roskapuhelut automaattisesti puheluiden merkitsemismäärien perusteella';

  @override
  String get enableLocalNotification => 'Käytä paikallista ilmoitusta';

  @override
  String get enableLocalNotificationDescription =>
      'Kun tämä on käytössä, suodatettujen viestien ilmoitukset näytetään laitteessa';

  @override
  String get enableLocationSummary => 'Sijainti';

  @override
  String get enableMuteRules => 'Ota mykistyssäännöt käyttöön';

  @override
  String get enableMuteRulesDesc =>
      'Ota käyttöön mykistyksen sieppaussääntöjen määritys';

  @override
  String get enableNoneActionRules => 'Ota käyttöön ei-toimintosäännöt';

  @override
  String get enableNoneActionRulesDesc =>
      'Salli sääntökonfiguraatiot ilman sieppaustoimintoja';

  @override
  String get enableNotifications => 'Ota ilmoitukset käyttöön';

  @override
  String get enableRemoteNumberFilter => 'Ota etänumero suodatus käyttöön';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Käytä etätietokantaa numeroiden suodattamiseen';

  @override
  String get enableRule => 'Ota sääntö käyttöön';

  @override
  String get enableSmsFilter => 'Ota tekstiviestien suodatus käyttöön';

  @override
  String get enableSmsFilterDescription =>
      'Kun tämä on käytössä, viestit suodatetaan automaattisesti sääntöjen mukaisesti';

  @override
  String get enableStatisticsNotifications =>
      'Ota tilasto ilmoitukset käyttöön';

  @override
  String get enableSubscriptionSuccessfully =>
      'Tilaus otettiin käyttöön onnistuneesti';

  @override
  String get enableTimeInterception => 'Ota aikapoiminta käyttöön';

  @override
  String get enableTimeInterceptionDescription =>
      'Sieppaa toistuvat puhelut lyhyen ajan sisällä';

  @override
  String get enableTimeInterceptor => 'Ota aikapoimija käyttöön';

  @override
  String get endCallImmediately => 'Lopeta puhelu välittömästi';

  @override
  String get endColor => 'Loppuväri';

  @override
  String get endDate => 'Päättymispäivä';

  @override
  String get enhancedFilterInstructionsTitle =>
      'Tehostettu suodatusjärjestelmä ohjeet';

  @override
  String get enhancedFilterSettings => 'Tehostetut suodatusasetukset';

  @override
  String get enhancedFilterSettingsTitle => 'Tehostetut suodatusasetukset';

  @override
  String get enhancedFilterSystemDescription =>
      'Tehostettu suodatusjärjestelmä tukee sekä globaaleja sääntöjä että SIM-korttikohtaisia suodatuskonfiguraatioita.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Syötä sekä puhelinnumero että säännöllisen lausekkeen kuvio';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Syötä sekä puhelinnumero että säännöllisen lausekkeen kuvio.';

  @override
  String get enterContactName => 'Syötä yhteystiedon nimi';

  @override
  String get enterCurrentPasswordHint => 'Syötä nykyinen salasana';

  @override
  String get enterDeviceName => 'Syötä laitteen nimi';

  @override
  String get enterDeviceNameHint => 'Syötä laitteen nimi';

  @override
  String get enterEmail => 'Syötä sähköposti';

  @override
  String get enterEmailOptional => 'Syötä sähköposti (valinnainen)';

  @override
  String get enterEncryptionPasswordHint => 'Syötä salaus salasana';

  @override
  String get enterEncryptionPasswordTitle => 'Syötä salaus salasana';

  @override
  String get enterFilterName => 'Syötä suodattimen nimi';

  @override
  String get enterFilterPattern => 'Syötä suodattimen kuvio';

  @override
  String get enterIconCode => 'Syötä kuvakekoodi';

  @override
  String get enterName => 'Syötä yhteystiedon nimi';

  @override
  String get enterNewDeviceNameHint => 'Syötä uusi nimi tälle laitteelle';

  @override
  String get enterNewPasswordHint => 'Syötä uusi salasana';

  @override
  String get enterPasswordAgain => 'Syötä salasana uudelleen';

  @override
  String get enterPasswordHint => 'Syötä salasana';

  @override
  String get enterPhoneNumber => 'Syötä puhelinnumero';

  @override
  String get enterPhoneNumberHint => 'Syötä puhelinnumero testattavaksi';

  @override
  String get enterPhoneNumberMultiple =>
      'Syötä puhelinnumero, useita numeroita pilkuilla erotettuna';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Syötä puhelinnumero haun aloittamiseksi';

  @override
  String get enterPhoneNumberToVerify => 'Syötä puhelinnumero varmistettavaksi';

  @override
  String get enterPluginName => 'Syötä laajennuksen nimi';

  @override
  String get enterPluginUrl => 'Syötä laajennuksen URL-osoite';

  @override
  String get enterRegexHint => 'Syötä säännöllisen lausekkeen kuvio';

  @override
  String get enterRuleNameAndPattern => 'Syötä säännön nimi ja kuvio';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Anna sekä säännön nimi että säännön malli.';

  @override
  String get enterRuleNameHint => 'Anna säännön nimi';

  @override
  String get enterSearchContent => 'Anna hakusisältö';

  @override
  String get enterSubscriptionName => 'Anna tilausnimi';

  @override
  String get enterSubscriptionUrl => 'Anna tilauksen URL';

  @override
  String get enterSyncFolderNameHint =>
      'Anna synkronointikansion nimi (oletus: NotificationManager)';

  @override
  String get entertainment => 'Viihde';

  @override
  String get enterValidNameAndUrl => 'Anna kelvollinen nimi ja URL';

  @override
  String get enterValidUrl => 'Anna kelvollinen URL';

  @override
  String get enterVersion => 'Anna versio';

  @override
  String get enterWebDAVPasswordHint => 'Anna WebDAV-salasana';

  @override
  String get enterWebDAVServerAddressHint => 'Anna WebDAV-palvelimen osoite';

  @override
  String get enterWebDAVUsernameHint => 'Anna WebDAV-käyttäjänimi';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Virhe poistettaessa laitetta: $error';
  }

  @override
  String get errorLoadingPlugin => 'Virhe ladattaessa lisäosaa';

  @override
  String errorOccurredMessage(Object error) {
    return 'Tapahtui virhe: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Virhe nimetäessä laitetta uudelleen: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Virhe synkronoidessa laitteita: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Virhe synkronoidessa laitteita: $error';
  }

  @override
  String get errorText => 'Virhe';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Virhe poistettaessa laitteen rekisteröintiä: $error';
  }

  @override
  String get exampleBlock400Prefix => 'esim. 400-alkuisten numeroiden esto';

  @override
  String get exampleBlockMarketingSms => 'esim. Markkinointi-SMS:ien esto';

  @override
  String get exampleContentRegex => 'esim. .*tarjous.*';

  @override
  String get exampleContentRegexHint => 'Esimerkkisisällön malli';

  @override
  String get exampleCouponPromotionDiscount =>
      'esim. .*(kuponki|tarjous|alennus).*';

  @override
  String get exampleFamilyFriends => 'esim. Perhe, Ystävät, jne.';

  @override
  String get examplePhoneNumber => 'esim. 10086, 12345, jne.';

  @override
  String get exampleRegex400Prefix =>
      'Esimerkkimalli 400-alkuisille numeroille';

  @override
  String get exampleRegexFormat => 'Esimerkki: ^10086\$ muoto';

  @override
  String get exampleSenderRegexHint => 'Esimerkki';

  @override
  String get exchange => 'Vaihto';

  @override
  String get exchangeNow => 'Vaihda nyt';

  @override
  String get exchangeVip => 'Vaihda VIP';

  @override
  String get expandLabelSelector => 'Laajenna tunnistevalitsin';

  @override
  String expiryTime(Object time) {
    return 'Vanhenemisaika: $time';
  }

  @override
  String get export => 'Vie';

  @override
  String get exportAllApplicationSettings => 'Vie kaikki sovellusasetukset';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Vie kaikki sovellusasetukset';

  @override
  String get exportAllRuleConfigurations => 'Vie kaikki sääntömääritykset';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Vie kaikki sääntömääritykset';

  @override
  String get exportComplete => 'Vienti valmis';

  @override
  String get exportConfig => 'Vie määritykset';

  @override
  String get exportContacts => 'Vie yhteystiedot';

  @override
  String get exportData => 'Vie tiedot';

  @override
  String get exportError => 'Vientivirhe';

  @override
  String get exportFailed => 'Vienti epäonnistui';

  @override
  String get exportFailure => 'Määritysten vienti epäonnistui';

  @override
  String get exportFeatureComingSoon => 'Vientitoiminto tulossa pian';

  @override
  String get exporting => 'Viedään...';

  @override
  String get exportLabels => 'Vie tunnisteet';

  @override
  String exportLabelsFailed(Object error) {
    return 'Tunnisteiden vienti epäonnistui: $error';
  }

  @override
  String get exportPluginList => 'Vie lisäosaluettelo';

  @override
  String exportPluginListFailed(Object error) {
    return 'Lisäosaluettelon vienti epäonnistui: $error';
  }

  @override
  String get exportRules => 'Vie säännöt';

  @override
  String get exportRulesDialogTitle => 'Vie säännöt';

  @override
  String get exportRulesTitle => 'Vie säännöt';

  @override
  String get exportSmsRules => 'Vie SMS-säännöt';

  @override
  String get exportStatisticsData => 'Vie tilastotiedot';

  @override
  String get exportSuccess => 'Vienti onnistui';

  @override
  String get exportSuccesslly => 'Määritykset viety onnistuneesti';

  @override
  String get failedToAddContact => 'Yhteystiedon lisääminen epäonnistui';

  @override
  String failedToAddRule(Object error) {
    return 'Säännön lisääminen epäonnistui: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMS-säännön lisääminen epäonnistui: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS-tilauksen lisääminen epäonnistui: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Asetusten varmuuskopiointi epäonnistui: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Varmuuskopiotiedoston purkaminen epäonnistui';

  @override
  String get failedToDeleteDevice => 'Laitteen poistaminen epäonnistui';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS-säännön poistaminen epäonnistui: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Sääntöjen vienti epäonnistui: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'SMS-sääntöjen vienti epäonnistui: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Soittajan tunnustietojen hakeminen epäonnistui: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Sääntöjen tuonti epäonnistui: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'SMS-sääntöjen tuonti epäonnistui: $error';
  }

  @override
  String get failedToLoadContacts => 'Yhteystietojen lataaminen epäonnistui';

  @override
  String get failedToLoadPlugin => 'Lisäosan lataaminen epäonnistui';

  @override
  String get failedToRenameDevice => 'Laitteen uudelleennimeäminen epäonnistui';

  @override
  String get failedToRestoreSettings => 'Asetusten palauttaminen epäonnistui';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Asetusten palauttaminen epäonnistui: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Salasanan asettaminen epäonnistui: $error';
  }

  @override
  String get failedToSyncDevices => 'Laitteiden synkronointi epäonnistui';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Säännön tilan vaihtaminen epäonnistui: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Tilauksen tilan vaihtaminen epäonnistui';

  @override
  String get failedToUpdateContact => 'Yhteystiedon päivittäminen epäonnistui';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'SMS-säännön päivittäminen epäonnistui: $error';
  }

  @override
  String get failure => 'Epäonnistuminen';

  @override
  String get favoriteContacts => 'Suosikkiyhteystiedot';

  @override
  String get featureAddRules => '• Lisää puhelinnumerokohtaisia sääntöjä';

  @override
  String get featureCenter => 'Ominaisuuskeskus';

  @override
  String get featureEnableDisable =>
      '• Ota käyttöön/poista käytöstä eri suodattimet SIM-korttia kohden';

  @override
  String get featureListTitle => 'Ominaisuudet:';

  @override
  String get featureManageRules =>
      '• Hallitse sääntölistoja SIM-korttia kohden';

  @override
  String get features => 'Ominaisuudet';

  @override
  String get fetchingCallerIdInfo => 'Haetaan soittajan tunnustietoja...';

  @override
  String fileSavedTo(Object path) {
    return 'Tiedosto tallennettu: $path';
  }

  @override
  String get filter => 'Suodata';

  @override
  String get filterByLabel => 'Suodata tunnisteen mukaan';

  @override
  String get filterClear => 'Tyhjennä suodatin';

  @override
  String get filterControlPanelTitle => 'Suodattimen ohjauspaneeli';

  @override
  String get filterControlSubtitle =>
      'Hallitse kaikkien suodattimien tilaa (päällä/pois)';

  @override
  String get filterControlTitle => 'Suodatusohjaus';

  @override
  String get filterDeleteFailed => 'Suodatuksen poisto epäonnistui';

  @override
  String get filterDeleteSuccess => 'Suodatus poistettu onnistuneesti';

  @override
  String get filterDetails => 'Suodatuksen tiedot';

  @override
  String get filtered => 'Suodatettu';

  @override
  String get filteredSms => 'Suodatettu tekstiviesti';

  @override
  String get filteredSmsLabel => 'Suodatettu tekstiviesti';

  @override
  String get filterExplanation => 'Suodatusselitys';

  @override
  String get filterManagement => 'Suodatuksen hallinta';

  @override
  String get filterName => 'Suodattimen nimi';

  @override
  String get filterPattern => 'Suodatusmallinnus';

  @override
  String get filterPriorityNote =>
      'Huom: Suodattimilla on prioriteettisuhteita, katso lisätietoja ohjedokumentaatiosta';

  @override
  String get filterSaveFailed => 'Suodatuksen tallennus epäonnistui';

  @override
  String get filterSaveSuccess => 'Suodatus tallennettu onnistuneesti';

  @override
  String get filterSettings => 'Suodatusasetukset';

  @override
  String get filterSettingsTitle => 'Suodatusasetukset';

  @override
  String get filterSMS => 'Suodata tekstiviestit';

  @override
  String get filterToggleInstructions =>
      'Ota käyttöön tai poista käytöstä suodattimet tälle SIM-paikalle:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Ota $status suodatin käyttöön: $filterName';
  }

  @override
  String get filterType => 'Suodatintyyppi';

  @override
  String get financial => 'Taloudellinen';

  @override
  String get flexibleCombinationFeature =>
      '• Joustavat yhdistelmät: Ota käyttöön/poista käytöstä suodattimet SIM-paikkaa kohden';

  @override
  String get fontSizesSetting => 'Fonttikoot';

  @override
  String foundRules(Object count) {
    return 'Löytyi $count sääntöä';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Löytyi $count sääntöä. Haluatko tuoda ne?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Löytyi $count sääntöä. Haluatko tuoda ne?';
  }

  @override
  String get fraudAlert => 'PETOSVAROITUS - Katkaise puhelu';

  @override
  String get fraudScamLikely => 'Petollinen huijaus todennäköinen';

  @override
  String get free => 'Ilmainen';

  @override
  String get functionSettingsTitle => 'Toimintoasetukset';

  @override
  String generalUpdateFailure(Object error) {
    return 'Päivitys epäonnistui: $error';
  }

  @override
  String get getFree => 'Hanki ilmainen';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Määritä globaalit suodattimet kaikille SIM-korteille:';

  @override
  String get globalFilterFeature =>
      '• Globaalit suodattimet: Perussäännöt kaikille saapuville puheluille';

  @override
  String get globalFilterSettings => 'Globaalit suodatusasetukset';

  @override
  String get globalFilterToggleInstructions =>
      'Määritä globaalit suodatusasetukset, jotka koskevat kaikkia SIM-paikkoja:';

  @override
  String get globalSearchSubtitle =>
      'Etsi yhteystietoja, tunnisteita, mustia listoja, valkoisia listoja jne.';

  @override
  String get globalSearchTitle => 'Globaali haku';

  @override
  String get globalSettings => 'Globaalit asetukset';

  @override
  String get googleAdDisplayPosition => 'Google-mainoksen näyttöpaikka';

  @override
  String get googleAdMobIntegrationText =>
      'Google AdMob -mainokset voidaan integroida tähän';

  @override
  String get googleDriveAuthDescription =>
      'Valtuuta käyttämällä järjestelmään määritettyä Google Drive -asiakastunnusta ja avainta';

  @override
  String get googleDriveAuthorizationHint =>
      'Valtuuta käyttämällä järjestelmään määritettyä Google Drive -asiakastunnusta ja avainta';

  @override
  String get googleDriveConfigTitle => 'Google Drive -määritys';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive -määritys';

  @override
  String get government => 'Hallitus';

  @override
  String get granted => 'Myönnetty';

  @override
  String get grantNecessaryPermissions => 'Myönnä tarvittavat luvat';

  @override
  String get grantPermissions => 'Myönnä luvat';

  @override
  String get headhunter => 'Rekrytoija';

  @override
  String get height => 'Korkeus';

  @override
  String get homePageTitle => 'Aloitusnäyttö';

  @override
  String get homeTab => 'Aloitus';

  @override
  String get howItWorksPoint1 =>
      '• Järjestelmä sallii automaattisesti puhelut samasta numerosta asetetun aikarajan sisällä';

  @override
  String get howItWorksPoint2 =>
      '• Lyhyemmät aikarajat johtavat tiukempaan estoon; pidemmät aikarajat johtavat löysempään estoon';

  @override
  String get howItWorksPoint3 =>
      '• Järjestelmä tarkistaa puhelulokit määrittääkseen, onko kyseessä toistuva puhelu';

  @override
  String get howItWorksTitle => 'Kuinka se toimii:';

  @override
  String get iconCodeOptional => 'Kuvakkeen koodi (valinnainen)';

  @override
  String get iconSize => 'Kuvakkeen koko';

  @override
  String get import => 'Tuo';

  @override
  String get important => 'Tärkeää';

  @override
  String get importButton => 'Tuo';

  @override
  String get importConfig => 'Tuo määritys';

  @override
  String get importContacts => 'Tuo yhteystiedot';

  @override
  String get importExportContacts => 'Tuo/vie yhteystiedot';

  @override
  String get importExportContactsTooltip => 'Tuo/vie yhteystiedot';

  @override
  String get importExportRules => 'Tuo/vie säännöt';

  @override
  String importFailed(Object error) {
    return 'Tuonti epäonnistui: $error';
  }

  @override
  String get importFailure => 'Määrityksen tuonti epäonnistui';

  @override
  String get importFeatureComingSoon => 'Tuontitoiminto tulossa pian';

  @override
  String get importLabels => 'Tuo tunnisteet';

  @override
  String importLabelsFailed(Object error) {
    return 'Tunnisteiden tuonti epäonnistui: $error';
  }

  @override
  String get importPluginList => 'Tuo liitännäisluettelo';

  @override
  String importPluginListFailed(Object error) {
    return 'Liitännäisluettelon tuonti epäonnistui: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Onnistuneesti tuotu $count liitännäistä';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Tuo sääntömääritykset tiedostosta';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Tuo sääntömääritykset tiedostosta';

  @override
  String get importRules => 'Tuo säännöt';

  @override
  String get importRulesButton => 'Tuo säännöt';

  @override
  String get importRulesDialogTitle => 'Tuo säännöt';

  @override
  String importRulesError(Object error) {
    return 'Sääntöjen tuonti epäonnistui: $error';
  }

  @override
  String get importRulesInstructions => 'Tuo säännöt CSV-tiedostosta';

  @override
  String get importRulesSuccess => 'Säännöt tuotu onnistuneesti';

  @override
  String get importRulesTitle => 'Tuo säännöt';

  @override
  String get importSuccess => 'Tuonti onnistui';

  @override
  String get incomingCallInterceptAction => 'Saapuvan puhelun esto-toiminto';

  @override
  String get incomingCallNotification => 'Saapuvan puhelun ilmoitus';

  @override
  String get incorrectPassword => 'Väärä salasana';

  @override
  String get initializing => 'Alustetaan';

  @override
  String get installed => 'Asennettu';

  @override
  String get insufficientMarks => 'Riittämätön merkintöjä';

  @override
  String get insurance => 'Vakuutus';

  @override
  String get interceptAction => 'Estotoiminto';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Määritä, miten estetyt puhelut käsitellään';

  @override
  String get interceptionActionSettingsTitle => 'Estotoiminnon asetukset';

  @override
  String get interceptionTimeInterval => 'Estoväli';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service päivitysväliksi asetettu $days päivää';
  }

  @override
  String get invalidContentRegex => 'Virheellinen sisältö-regex';

  @override
  String get invalidLabel => 'Virheellinen merkintä';

  @override
  String get invalidRegexPattern => 'Virheellinen säännöllinen lauseke';

  @override
  String get invalidSenderRegex =>
      'Virheellinen lähettäjän säännöllinen lauseke';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Liity Telegram-kanavalle ja ryhmään saadaksesi lisätietoja';

  @override
  String get jsLogsTitle => 'JS-lokit';

  @override
  String get jsonFormat => 'JSON-muoto';

  @override
  String get keepAllVersions => 'Säilytä kaikki versiot';

  @override
  String get keepAllVersionsDescription =>
      'Säilytä jokaisen varmuuskopion kaikki historialliset versiot';

  @override
  String get keepAllVersionsLabel => 'Säilytä kaikki versiot';

  @override
  String get keepAllVersionsSubtitle =>
      'Säilytä jokaisen varmuuskopion historialliset versiot';

  @override
  String get keepAllVersionsTitle => 'Säilytä kaikki versiot';

  @override
  String get label => 'Merkintä';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Merkintä \"$name\" lisätty onnistuneesti';
  }

  @override
  String get labelCategories => 'Merkintäkategoriat';

  @override
  String get labelDeleted => 'Merkintä poistettu';

  @override
  String get labelDescription =>
      'Merkinnät auttavat sinua hallitsemaan yhteystietojasi paremmin. Lisää mukautettuja merkintöjä puhelinnumeroihin puheluiden ja viestien helppoa tunnistamista varten.';

  @override
  String get labelFilter => 'Merkintäsuodatin';

  @override
  String get labelFilterTooltip => 'Merkintäsuodatin';

  @override
  String get labelIconColor => 'Merkinnän kuvakkeen väri';

  @override
  String get labelManagement => 'Merkinnän hallinta';

  @override
  String get labelNotFound => 'Merkintää ei löytynyt';

  @override
  String get labelRemoved => 'Merkintä poistettu';

  @override
  String labelRemoveFailed(Object error) {
    return 'Merkinnän poistaminen epäonnistui: $error';
  }

  @override
  String get labels => 'Merkinnät';

  @override
  String get labelsColor => 'Merkintöjen väri';

  @override
  String labelsDeleted(Object count) {
    return '$count merkintää poistettu';
  }

  @override
  String get labelsExportedSuccessfully => 'Merkinnät viety onnistuneesti';

  @override
  String get labelsFontSize => 'Merkintöjen fonttikoko';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count merkintää tuotu onnistuneesti';
  }

  @override
  String get labelsPosition => 'Merkintöjen sijainti';

  @override
  String labelTag(Object labelId) {
    return 'Merkintä: $labelId';
  }

  @override
  String get labelUpdated => 'Merkintä päivitetty';

  @override
  String labelUpdateFailed(Object error) {
    return 'Merkinnän päivittäminen epäonnistui: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Merkintä \"\$labelText\" päivitetty onnistuneesti';

  @override
  String get languageSettings => 'Kieliasetukset';

  @override
  String get languageSettingsSubtitle => 'Muuta sovelluksen näyttökieltä';

  @override
  String get languageSettingsTitle => 'Kieliasetukset';

  @override
  String get last30Days => 'Viimeiset 30 päivää';

  @override
  String get last7Days => 'Viimeiset 7 päivää';

  @override
  String get lastSyncLabel => 'Viimeisin synkronointi';

  @override
  String lastUpdated(Object date) {
    return 'Viimeksi päivitetty: $date';
  }

  @override
  String get lifetimeMembership => 'Elinikäinen jäsenyys';

  @override
  String get lifetimeMembershipDescription =>
      'Ein-kertainen ostos, avaa pysyvästi kaikki premium-ominaisuudet ja tulevat päivitykset';

  @override
  String loadContactsFailed(Object error) {
    return 'Yhteystietojen lataaminen epäonnistui: $error';
  }

  @override
  String get loadDataFailed => 'Tietojen lataaminen epäonnistui';

  @override
  String get loadFailed => 'Lataaminen epäonnistui';

  @override
  String get loading => 'Ladataan...';

  @override
  String get loadingData => 'Ladataan tietoja...';

  @override
  String get loadingTags => 'Ladataan tunnisteita...';

  @override
  String loadLabelFailed(Object error) {
    return 'Merkintöjen lataaminen epäonnistui: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Merkintöjen lataaminen epäonnistui: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Merkittyjen puhelinnumeroiden lataaminen epäonnistui: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Merkittyjen puhelimien lataaminen epäonnistui: $error';
  }

  @override
  String get loadMore => 'Lataa lisää';

  @override
  String get loadPluginButton => 'Lataa lisäosa';

  @override
  String loadPluginsFailed(Object error) {
    return 'Lisäosien lataaminen epäonnistui: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Asetusten lataaminen epäonnistui: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'SMS-sääntöjen lataaminen epäonnistui: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Tilan lataaminen epäonnistui';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Tilausten lataaminen epäonnistui: $error';
  }

  @override
  String get loan => 'Laina';

  @override
  String get localBackupTitle => 'Paikallinen varmuuskopiointi';

  @override
  String get localCounterFilter => 'Paikallinen laskurisuodatin';

  @override
  String get localCounterFilterSubtitle =>
      'Suodata roskapuhelut automaattisesti puhelutiheyden perusteella';

  @override
  String get localCountFilter => 'Paikallinen lukumääräsuodatin';

  @override
  String get localCountFilterDescription =>
      'Katkaise usein toistuvat puhelut paikallisten numerolukemien perusteella';

  @override
  String get localCountFilterExplanationContent =>
      'Paikallinen lukumääräsuodatin analysoi puheluhistorian tietueita tunnistaakseen ja estääkseen automaattisesti usein toistuvat roskapuhelut.';

  @override
  String get localCountFilterExplanationTitle =>
      'Paikallinen lukumääräsuodattimen selitys';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Määritä, estetäänkö perustuen numeron lukemien arvoon';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Kun numeron lukema ylittää asetetun kynnyksen, voit valita sen estämisen automaattisesti';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Voit valikoivasti sallia numerot, jotka eivät ylitä kynnystä';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Voit valita, tallennetaanko kaikki kyselylokit';

  @override
  String get localCountFiltering => 'Paikallinen lukumääräsuodatus';

  @override
  String get localCountFilteringExplanation =>
      '• Paikallinen lukumääräsuodatus: Suodatussäännöt perustuvat paikalliseen merkintöjen määrään';

  @override
  String get localCountFilterSettings =>
      'Paikallisen lukumääräsuodattimen asetukset';

  @override
  String get localCountFilterUseCases =>
      'Tämä suodatin sopii erityisesti automaattivalintaisten roskapuheluiden ja markkinointipuheluiden tunnistamiseen.';

  @override
  String get localFilterSettings => 'Paikallisten suodattimien asetukset';

  @override
  String get localNotificationDisabled =>
      'Paikallinen ilmoitus poistettu käytöstä';

  @override
  String get localNotificationEnabled => 'Paikallinen ilmoitus käytössä';

  @override
  String get localServices => 'Paikalliset palvelut';

  @override
  String get locationColor => 'Sijainnin väri';

  @override
  String get locationFontSize => 'Sijainnin fonttikoko';

  @override
  String get locationIconColor => 'Sijainnin kuvakkeen väri';

  @override
  String get locationPosition => 'Sijainnin sijainti';

  @override
  String get logAllLocalQueries => 'Kirjaa kaikki paikalliset kyselyt';

  @override
  String get logAllLocalQueriesDescription =>
      'Tallenna lokit kaikista paikallisista numerokyselyistä';

  @override
  String get logAllRemoteQueries => 'Kirjaa kaikki etäkyselyt';

  @override
  String get logAllRemoteQueriesDescription =>
      'Tallenna kaikki etänumeroitua koskevat kyselytoiminnot';

  @override
  String get manage => 'Hallitse yhteystietoja';

  @override
  String get manageContacts => 'Hallitse';

  @override
  String get manageFavoriteContacts => 'Hallitse suosikkikontakteja';

  @override
  String get manageFilterRules => 'Hallitse suodatussääntöjä';

  @override
  String get manageFilterRulesDescription =>
      'Lisää, muokkaa tai poista SMS-suodatussääntöjä';

  @override
  String get manageFrequentContacts => 'Hallitse usein käytettyjä kontakteja';

  @override
  String get markCounts => 'Merkittyjen lukumäärät';

  @override
  String get markCount => 'Merkitty lukumäärä';

  @override
  String markedByCount(Object count) {
    return 'Merkitty $count kertaa';
  }

  @override
  String get markedPhonesList => 'Merkityt puhelinnumerot';

  @override
  String get markExchange => 'Merkinnän vaihto';

  @override
  String get markPhone => 'Merkkaa puhelinnumero';

  @override
  String markPhoneFailed(Object error) {
    return 'Puhelinnumeron merkitseminen epäonnistui: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'Puhelinnumeroiden merkitseminen';

  @override
  String get markPhoneManagementTitle => 'Puhelinnumeroiden hallinta';

  @override
  String get markPhoneSuccess => 'Puhelinnumero merkitty onnistuneesti';

  @override
  String get matchFailed => 'Täsmäytys epäonnistui!';

  @override
  String get matchFailedMessage => 'Täsmäytys epäonnistui.';

  @override
  String get matchNumbersWithSpecialCharacters => 'täsmää tiettyä numeromuotoa';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Täsmäytä numerot erikoismerkeillä:';

  @override
  String get matchSpecificDigitPatterns => 'täsmää XXX-XXXX-XXXX-muotoa';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Täsmäytä tiettyjä numerokuvioita:';

  @override
  String get matchSuccessful => 'Täsmäytys onnistui!';

  @override
  String get matchSuccessfulMessage => 'Täsmäytys onnistui!';

  @override
  String get medical => 'Lääketieteellinen';

  @override
  String get membershipPrivileges => 'Jäsenyyden edut';

  @override
  String get migrationTool => 'Siirtotyökalu';

  @override
  String get migrationToolTitle => 'Siirtotyökalu';

  @override
  String get minutes => 'minuuttia';

  @override
  String get month => 'Kuukausi';

  @override
  String get monthly => 'Kuukausittainen';

  @override
  String get monthlyCallCount => 'Kuukausittaiset puhelut';

  @override
  String get monthlyChartTitle => 'Kuukausittaiset estetyt puhelut';

  @override
  String get monthlyMembership => 'Kuukausijäsenyys';

  @override
  String get monthlyMembershipDescription =>
      'Avaa kaikki premium-ominaisuudet, uusiutuu automaattisesti kuukausittain';

  @override
  String get monthlyTotal => 'Kuukausisumma';

  @override
  String get monthlyTotalLabel => 'Kuukausisumma';

  @override
  String get moreOptions => 'Lisää asetuksia';

  @override
  String get mute => 'Mykistää';

  @override
  String get name => 'Nimi';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Nimi ja puhelinnumero eivät voi olla tyhjiä';

  @override
  String get nameAndPhoneNumberRequired => 'Nimi ja puhelinnumero vaaditaan';

  @override
  String get nameColor => 'Nimen väri';

  @override
  String get nameFontSize => 'Nimen fonttikoko';

  @override
  String nameLabel(Object name) {
    return 'Nimi: $name';
  }

  @override
  String get namePosition => 'Nimen sijainti';

  @override
  String get nameUnknown => 'Nimi: Tuntematon';

  @override
  String nameWithValue(String name) {
    return 'Nimi: $name';
  }

  @override
  String get newPasswordLabel => 'Uusi salasana';

  @override
  String get nextStep => 'Seuraava';

  @override
  String get noAction => 'Ei toimintoa';

  @override
  String get noActionRules => 'Ei toimintosääntöjä';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Ei aktiivista pilvisynkronointipalvelua';

  @override
  String get noCallLogs => 'Ei puhelulokeja';

  @override
  String get noCallRecords => 'Ei puhelutietueita';

  @override
  String get noContacts => 'Ei yhteystietoja';

  @override
  String get noContactsYet => 'Ei yhteystietoja vielä';

  @override
  String get noData => 'Ei tietoja';

  @override
  String get noDevicesRegisteredMessage => 'Ei rekisteröityjä laitteita';

  @override
  String get noDevicesRegisteredYet => 'Ei rekisteröityjä laitteita vielä.';

  @override
  String get noFilters => 'Ei suodattimia vielä';

  @override
  String get noLabels => 'Ei tunnisteita vielä';

  @override
  String get noMarkedPhones => 'Ei merkittyjä puhelinnumeroita';

  @override
  String get noMatchingContacts => 'Ei vastaavia yhteystietoja';

  @override
  String get noMatchingContactsFound => 'Ei vastaavia yhteystietoja löytynyt';

  @override
  String get noMatchingNumbersFound => 'Ei vastaavia numeroita löytynyt';

  @override
  String get noMatchingRecords => 'Ei vastaavia puhelutietueita';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Ei vastaavia $ruleType';
  }

  @override
  String get none => 'Ei mitään';

  @override
  String get noneServiceType => 'Ei mitään';

  @override
  String get noPlugins => 'Ei laajennuksia vielä';

  @override
  String get noRecords => 'Ei puhelutietueita';

  @override
  String get noResultReturned => 'Ei tulosta palautettu';

  @override
  String get noResultReturnedLog => 'Ei tulosta palautettu laajennuksesta';

  @override
  String noRules(Object ruleType) {
    return 'Ei $ruleType vielä';
  }

  @override
  String get noRulesPrompt => 'Ei sääntöjä löydy, lisää sääntöjä';

  @override
  String get noRulesToExport => 'Ei sääntöjä vietäväksi';

  @override
  String get noSmsFilterRulesYet => 'Ei SMS-suodatussääntöjä vielä';

  @override
  String get noSmsRulesYet => 'Ei SMS-sääntöjä vielä';

  @override
  String get noSubscriptions => 'Ei tilauksia';

  @override
  String get noSubscriptionsYet => 'Ei tilauksia vielä';

  @override
  String get notGranted => 'Ei myönnetty';

  @override
  String get notificationMode => 'Ilmoitustila';

  @override
  String get notificationModeDescription =>
      'Näytä soittajan tiedot ilmoituspalkissa';

  @override
  String get notificationPermission => 'Ilmoituslupa';

  @override
  String get notificationPermissionDescription =>
      'Käytetään saapuvien puhelu- ja viesti-ilmoitusten näyttämiseen.';

  @override
  String get notifications => 'Ilmoitukset';

  @override
  String get notificationSettings => 'Ilmoitusasetukset';

  @override
  String get notificationSettingsSaved =>
      'Ilmoitusasetukset tallennettu onnistuneesti';

  @override
  String get notSet => 'Ei asetettu';

  @override
  String get notVerifiedText => 'Ei varmistettu';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Ei kelvollisia SMS-sääntöjä löytynyt tiedostosta';

  @override
  String get number => 'Numero';

  @override
  String get numberColor => 'Numeron väri';

  @override
  String get numberFontSize => 'Numeron fonttikoko';

  @override
  String get numberPosition => 'Numeron sijainti';

  @override
  String get numberSearch => 'Numerohaku';

  @override
  String get numberTypeColor => 'Numerotyypin väri';

  @override
  String get numberTypeFontSize => 'Numerotyypin fonttikoko';

  @override
  String get numberTypePosition => 'Numerotyypin sijainti';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Puheluturvallisuushallintasi on valmis, nauti turvallisesta puhelukokemuksesta!';

  @override
  String get onboardingLanguageDescription =>
      'Valitse haluamasi kieli parhaan kokemuksen saavuttamiseksi.';

  @override
  String get onboardingPermissionsDescription =>
      'Tarjotaksemme täyden palvelun tarvitsemme seuraavat luvat:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Yhden napsautuksen roskapostipuheluiden ja -viestien estäminen, estosääntöjen mukauttaminen ja hiljaisen ympäristön tarjoaminen sinulle.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Tunnista tuntemattomat puhelut automaattisesti, merkitse epäilyttävät numerot ja suojaa puhelusi.';

  @override
  String get onboardingWelcomeDescription =>
      'Puhelunhallinta-asiantuntijasi tarjoaa kattavat puheluiden tunnistus- ja estopalvelut.';

  @override
  String get oneDriveAuthDescription =>
      'Valtuuta järjestelmän määrittämää OneDrive-asiakasohjelman tunnusta ja avainta käyttäen';

  @override
  String get oneDriveAuthorizationHint =>
      'Valtuuta järjestelmän määrittämää OneDrive-asiakasohjelman tunnusta ja avainta käyttäen';

  @override
  String get oneDriveConfigTitle => 'OneDrive-asetukset';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive-asetukset';

  @override
  String get onlineCallerIdSubscription => 'Online Caller ID -tilaus';

  @override
  String get openAppSettings => 'Avaa sovellusasetukset';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Sovellusasetusten avaaminen epäonnistui: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operaatio epäonnistui: $error';
  }

  @override
  String get operationFailure => 'Operaatio epäonnistui';

  @override
  String get operationSuccess => 'Operaatio onnistui';

  @override
  String get other => 'Muu';

  @override
  String get ourOtherApps => 'Muut sovelluksemme';

  @override
  String get overlayMode => 'Kelluva ikkuna';

  @override
  String get overlayModeDescription =>
      'Näytä soittajan tiedot kelluvassa ikkunassa';

  @override
  String get overlayPermission => 'Käyttöliittymän lupa';

  @override
  String get overlayPermissionDescription =>
      'Käytetään saapuvien puheluiden näyttöikkunan näyttämiseen.';

  @override
  String get overview => 'Yleiskatsaus';

  @override
  String get password => 'Salasana';

  @override
  String get passwordCannotBeEmpty => 'Salasana ei voi olla tyhjä';

  @override
  String get passwordLabel => 'Salasana';

  @override
  String get passwordsDoNotMatch => 'Salasanat eivät täsmää';

  @override
  String get passwordSetSuccessfully => 'Salasana asetettu onnistuneesti';

  @override
  String get pattern => 'Kuvio';

  @override
  String get pendingSync => 'Odottaa synkronointia';

  @override
  String get periodMonth => 'Kuukausi';

  @override
  String get periodWeek => 'Viikko';

  @override
  String get periodYear => 'Vuosi';

  @override
  String get permissionDenied => 'Lupapyyntö evätty';

  @override
  String get permissionGranted => 'Lupa myönnetty';

  @override
  String get permissionManagement => 'Lupien hallinta';

  @override
  String get phoneCallsTab => 'Puhelut';

  @override
  String get phoneNumber => 'Puhelinnumero';

  @override
  String get phoneNumberCannotBeEmpty => 'Puhelinnumero ei voi olla tyhjä';

  @override
  String get phoneNumberHint => 'Syötä puhelinnumero';

  @override
  String get phoneNumberHintText => 'Syötä puhelinnumero säännön lisäämiseksi';

  @override
  String get phoneNumberLabel => 'Puhelinnumero';

  @override
  String get phoneNumberRegexRequired =>
      'Syötä sekä puhelinnumero että säännöllinen lauseke';

  @override
  String get phoneNumberRequired => 'Puhelinnumero vaaditaan';

  @override
  String get phoneNumberTypeFixedLine => 'Lankapuhelin';

  @override
  String get phoneNumberTypeFixedLineOrMobile =>
      'Lankapuhelin tai matkapuhelin';

  @override
  String get phoneNumberTypeMobile => 'Matkapuhelin';

  @override
  String get phoneNumberTypePager => 'Hakulaite';

  @override
  String get phoneNumberTypePersonalNumber => 'Henkilökohtainen numero';

  @override
  String get phoneNumberTypePremiumRate => 'Pricemail-numero';

  @override
  String get phoneNumberTypeSharedCost => 'Jaettu kustannusnumero';

  @override
  String get phoneNumberTypeTollFree => 'Maksuton numero';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Tuntematon';

  @override
  String get phoneNumberTypeVoicemail => 'Vastaaja';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Puhelimen käyttöoikeus';

  @override
  String get phonePermissionDescription =>
      'Käytetään saapuvien puheluiden tunnistamiseen ja estämiseen.';

  @override
  String get phoneRule => 'Puhelusääntö';

  @override
  String get phoneRuleEditDialog => 'Puhelusäännön muokkausikkuna';

  @override
  String get phoneRuleManagement => 'Puhelusääntöjen hallinta';

  @override
  String get phoneRuleSubscription => 'Puhelusääntöjen tilaus';

  @override
  String get phoneSubscription => 'Puhelutilaus';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Tilaa puhelusääntölistoja URL-osoitteesta päivittääksesi automaattisesti sallittujen ja estettyjen listojen säännöt. Tukee JSON-muotoisia sääntötiedostoja.';

  @override
  String get phoneSubscriptionTitle => 'Puhelusääntötilaukset';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Valitse merkintä ja syötä kelvollinen puhelinnumero';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Lisäosa \"$name\" lisätty onnistuneesti';
  }

  @override
  String get pluginDeleted => 'Lisäosa poistettu';

  @override
  String get pluginLatestVersion => 'Lisäosa on jo uusimmassa versiossa';

  @override
  String get pluginListExportSuccess => 'Lisäosaluettelo viety onnistuneesti';

  @override
  String get pluginLoadedSuccessfully => 'Lisäosa ladattu onnistuneesti';

  @override
  String get pluginManagement => 'Lisäosien hallinta';

  @override
  String get pluginManagementSubtitle =>
      'Hallitse ja konfiguroi kolmannen osapuolen lisäosia';

  @override
  String get pluginManagementTitle => 'Lisäosien hallinta';

  @override
  String get pluginName => 'Lisäosan nimi';

  @override
  String get pluginNotLoaded =>
      'Lisäosaa ei ole vielä ladattu. Lataa lisäosa ensin.';

  @override
  String pluginsDeleted(Object count) {
    return '$count lisäosaa poistettu onnistuneesti.';
  }

  @override
  String get pluginService => 'Lisäosapalvelu';

  @override
  String get pluginTestPageTitle => 'Lisäosan testi';

  @override
  String get pluginUpdateSuccess => 'Lisäosa päivitetty onnistuneesti';

  @override
  String get pluginUrl => 'Lisäosan URL';

  @override
  String get pluginUrlCannotBeEmpty => 'Lisäosan URL ei voi olla tyhjä';

  @override
  String get pluginUrlHint => 'Syötä lisäosan URL';

  @override
  String get pluginUrlLabel => 'Lisäosan URL';

  @override
  String get pluginVersion => 'Lisäosan versio';

  @override
  String get political => 'Poliittinen';

  @override
  String get powerfulSpamBlocking => 'Tehokas roskapostin esto';

  @override
  String get previousStep => 'Edellinen';

  @override
  String get prioritizeRemoteAction => 'Aseta etätoimintojen etusijalle';

  @override
  String get prioritizeRemoteActionDescription =>
      'Aseta toimintojen etusijalle etädatabasesta';

  @override
  String get processing => 'Käsitellään...';

  @override
  String get processingOperation => 'Käsitellään...';

  @override
  String get purchase => 'Osta';

  @override
  String get quarterlyMembership => 'Neljännesvuosijäsenyys';

  @override
  String get quarterlyMembershipDescription =>
      'Avaa kaikki premium-ominaisuudet, automaattinen uusinta neljännesvuosittain';

  @override
  String get queryButton => 'Kysely';

  @override
  String get queryFailed => 'Kysely epäonnistui';

  @override
  String get queryFailedLog => 'Kysely epäonnistui';

  @override
  String get querying => 'Kysellään...';

  @override
  String get queryingPhoneNumber => 'Kysellään puhelinnumeroa';

  @override
  String get queryResultTitle => 'Kyselyn tulos';

  @override
  String get ready => 'Valmis!';

  @override
  String get receiveWeeklyStatistics => 'Vastaanota viikoittaisia tilastoja';

  @override
  String get recruiter => 'Rekrytoija';

  @override
  String get reEnterPasswordHint => 'Syötä salasana uudelleen';

  @override
  String get refresh => 'Päivitä';

  @override
  String get refreshPermissionStatus => 'Päivitä lupatila';

  @override
  String get refreshTooltip => 'Päivitä';

  @override
  String regexError(Object error) {
    return 'Säännöllisen lausekkeen virhe: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Säännöllisen lausekkeen virhe: $error';
  }

  @override
  String get regexPattern => 'Säännön kuvio';

  @override
  String get regexPatternExplanation => 'Säännön kuvion selitys';

  @override
  String get regexPatternExplanationButton => 'Säännön kuvion selitys';

  @override
  String get regexPatternLabel => 'Säännön kuvio';

  @override
  String get regexPatternsExamples =>
      'Käytä tavallista regex-syntaksia kuvioiden määrittämiseen. Esimerkkejä:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Puhelinnumeroiden vastaavuussäännöt';

  @override
  String get regexRule => 'Sääntö';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Säännön lisääminen epäonnistui: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Sääntö lisätty onnistuneesti';

  @override
  String get regexRuleManagement => 'Sääntöjen hallinta';

  @override
  String get regexRuleNamePatternRequired =>
      'Säännön nimi ja kuvio eivät saa olla tyhjiä';

  @override
  String get regexRules => 'Säännöt';

  @override
  String get regexTesterTitle => 'Regex-testausohjelma';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex-validointi epäonnistui: $error';
  }

  @override
  String get regexValidationSuccess => 'Regex-validointi onnistui';

  @override
  String get region => 'Alue';

  @override
  String get registeredDevicesTitle => 'Rekisteröidyt laitteet';

  @override
  String get rejectAllCalls => 'Hylkää kaikki puhelut';

  @override
  String get rejectAllCallsDescription =>
      'Kun tämä on käytössä, kaikki puhelut hylätään korkeimmalla prioriteetilla';

  @override
  String get rejectAllNumbers => 'Hylkää kaikki numerot';

  @override
  String get rejectAllNumbersDesc =>
      'Hylkää kaikki saapuvat puhelut, kun tämä on käytössä';

  @override
  String get rejectExceededNumbers => 'Hylkää ylittyneet numerot';

  @override
  String get rejectExceededNumbersDescription =>
      'Hylkää automaattisesti numerot, jotka ylittävät määrärajan';

  @override
  String get remoteFilterSettings => 'Etäsuodatusasetukset';

  @override
  String get remoteFilterSettingsPageTitle => 'Etänumerosuodattimen asetukset';

  @override
  String get remoteNumberFilter => 'Etänumerosuodatin';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Tämä suodatin käyttää itsenäistä etä-tietokantaa saadakseen uusimmat numerotiedot.';

  @override
  String get remoteNumberFilterDescription =>
      'Estä häiritsevät puhelut etä-tietokannan tietojen perusteella';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Etänumerosuodatin tunnistaa ja estää roskapostipuhelut kysymällä etä-tietokantaa numeroiden määrän perusteella.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Etänumerosuodattimen selitys';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Määräraja: Määritä numeron esiintymistiheyden perusteella';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Suodatus toiminnot: Määritä, miten käsitellään raja-arvon ylittäviä numeroita';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Prioriteettiasetukset: Määritä etätoimintojen prioriteetti';

  @override
  String get remoteNumberFilterFeatures => 'Ominaisuudet:';

  @override
  String get remoteNumberFiltering => 'Etäpuhelusuodatus';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Etäpuhelusuodatus: Suodatus säännöt perustuen etä-tietokannan tietoihin';

  @override
  String get remoteNumberFilterSubtitle =>
      'Tunnista roskapostipuhelut käyttämällä pilvitietokantaa ja yhteisöraportteja';

  @override
  String get removeAdsDescription =>
      'Poista kaikki mainokset sovelluksesta pysyvästi sujuvampaa käyttökokemusta varten';

  @override
  String get removeAdsTitle => 'Poista mainokset';

  @override
  String get removedFromFavoriteContacts => 'Poistettu suosikkikontakteista';

  @override
  String get removedFromFavorites => 'Poistettu suosikeista';

  @override
  String get removeFavorite => 'Poista suosikki';

  @override
  String get removeFromFavorites => 'Poista suosikeista';

  @override
  String get renameButton => 'Nimeä uudelleen';

  @override
  String get renameDeviceDialogTitle => 'Nimeä laite uudelleen';

  @override
  String get renameDeviceTitle => 'Nimeä laite uudelleen';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Tämä korvaa kaikki nykyiset asetuksesi. Haluatko varmasti jatkaa?';

  @override
  String get requestAllPermissions => 'Pyydä kaikki käyttöoikeudet';

  @override
  String get requestPermission => 'Pyydä käyttöoikeus';

  @override
  String requestPermissionFailed(Object error) {
    return 'Käyttöoikeuden pyytäminen epäonnistui: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Merkkiä';
  }

  @override
  String get reset => 'Nollaa';

  @override
  String get restore => 'Palauta';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Palauta sovelluksen asetukset varmuuskopiosta';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Palauta sovelluksen asetukset varmuuskopiosta';

  @override
  String get restoreButton => 'Palauta';

  @override
  String restoreFailedWithError(Object error) {
    return 'Palauttaminen pilvestä epäonnistui: $error';
  }

  @override
  String get restoreFromCloud => 'Palauta pilvestä';

  @override
  String get restoreFromCloudDescription =>
      'Palauta asetukset ja säännöt pilvitallennustilasta';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Palauttaminen pilvestä epäonnistui: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Palauta pilvestä';

  @override
  String get restoreFromCloudSuccess => 'Onnistuneesti palautettu pilvestä';

  @override
  String get restoreFromCloudTitle => 'Palauta pilvestä';

  @override
  String get restoreFromLocal => 'Palauta paikallisesti';

  @override
  String get restorePurchases => 'Palauta ostokset';

  @override
  String get restoreSectionTitle => 'Palauta';

  @override
  String get restoreSettings => 'Palauta asetukset';

  @override
  String get restoreSettingsConfirmation =>
      'Tämä korvaa kaikki nykyiset asetuksesi. Haluatko varmasti jatkaa?';

  @override
  String get restoreSettingsDialogTitle => 'Palauta asetukset';

  @override
  String get restoreSettingsTitle => 'Palauta asetukset';

  @override
  String get restoreSuccessFromLocal =>
      'Onnistuneesti palautettu paikallisesti';

  @override
  String get restoreSuccessMessage => 'Onnistuneesti palautettu pilvestä';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get ridesharing => 'Kyydinjakaminen';

  @override
  String get risk => 'Riski';

  @override
  String get robocall => 'Robopuhelu';

  @override
  String get ruleAction => 'Säännön toiminto';

  @override
  String get ruleAddButton => 'Lisää sääntö';

  @override
  String get ruleAddedSuccess => 'Sääntö lisätty onnistuneesti';

  @override
  String ruleAddFailure(Object error) {
    return 'Säännön lisääminen epäonnistui: $error';
  }

  @override
  String get ruleAddSuccess => 'Sääntö lisätty onnistuneesti';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Haluatko varmasti poistaa tämän $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Poista sääntö';

  @override
  String get ruleDeletedSuccess => 'Sääntö poistettu onnistuneesti';

  @override
  String get ruleDeletedSuccessfully => 'Sääntö poistettu onnistuneesti';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Säännön poistaminen epäonnistui: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Säännön poistaminen epäonnistui: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Sääntö poistettu onnistuneesti';

  @override
  String get ruleDisabledSuccessfully =>
      'Sääntö poistettu käytöstä onnistuneesti';

  @override
  String get ruleEnabledSuccessfully => 'Sääntö otettu käyttöön onnistuneesti';

  @override
  String ruleLoadFailed(Object error) {
    return 'Sääntöjen lataaminen epäonnistui: $error';
  }

  @override
  String get ruleManagement => 'Sääntöjen hallinta';

  @override
  String get ruleManagementTitle => 'Sääntöjen hallinta';

  @override
  String get ruleName => 'Säännön nimi';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Säännön nimi ja sisältö regex eivät saa olla tyhjiä';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Säännön nimi ja puhelinnumero eivät saa olla tyhjiä';

  @override
  String get ruleNameHint => 'esim. Perhe, Ystävät, jne.';

  @override
  String get ruleNameLabel => 'Säännön nimi';

  @override
  String get ruleNamePatternRequired => 'Syötä säännön nimi ja kuvio';

  @override
  String get ruleNameRequired =>
      'Säännön nimi ja puhelinnumero eivät saa olla tyhjiä';

  @override
  String get ruleNotExist => 'Sääntöä ei löydy tai se on poistettu';

  @override
  String ruleNotFound(Object error) {
    return 'Sääntöä ei löydy: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Sääntö tallennettu onnistuneesti!';

  @override
  String get ruleSavedSuccessMessage => 'Sääntö tallennettu onnistuneesti!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Tallennus epäonnistui: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Tallennus epäonnistui: $error';
  }

  @override
  String get ruleSaveSuccess => 'Sääntö tallennettu onnistuneesti!';

  @override
  String get rulesExportedSuccessfully => 'Säännöt viety onnistuneesti';

  @override
  String rulesExportedTo(Object path) {
    return 'Säännöt viety kohteeseen: $path';
  }

  @override
  String get rulesImported => 'Säännöt tuotu onnistuneesti';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count sääntöä tuotu onnistuneesti';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Sääntöjen tuonti epäonnistui: $error';
  }

  @override
  String get ruleStatistics => 'Sääntötilastot';

  @override
  String ruleStatusChanged(Object status) {
    return 'Sääntö $status onnistuneesti';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Toiminto epäonnistui: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Sääntö $status onnistuneesti';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Säännön päivittäminen epäonnistui: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Sääntö päivitetty onnistuneesti';

  @override
  String get ruleVerification => 'Säännön vahvistus';

  @override
  String get save => 'Tallenna';

  @override
  String get saveButton => 'Tallenna';

  @override
  String get saveButtonLabel => 'TALLENNA';

  @override
  String get saveButtonText => 'Tallenna';

  @override
  String saveFailed(Object error) {
    return 'Tallennus epäonnistui: $error';
  }

  @override
  String get saveFilter => 'Tallenna suodatin';

  @override
  String get saveSettings => 'Tallenna asetukset';

  @override
  String saveSettingsFailed(Object error) {
    return 'Asetusten tallennus epäonnistui: $error';
  }

  @override
  String get scamsLikely => 'Todennäköisesti huijaus';

  @override
  String get search => 'Hae';

  @override
  String get searchContacts => 'Etsi yhteystietoja';

  @override
  String searchError(Object error) {
    return 'Hakuvirhe: $error';
  }

  @override
  String get searchFilters => 'Hakusuodattimet';

  @override
  String get searchForContacts => 'Etsi yhteystietoja';

  @override
  String get searchHint => 'Hae...';

  @override
  String get searchSettingsSubtitle =>
      'Etsi yhteystietoja, luokkia, mustia listoja, valkoisia listoja jne.';

  @override
  String get searchSettingsTitle => 'Hakuaikasetukset';

  @override
  String get securityMessage =>
      'Älä luota puheluihin. Varmista asiakaspalvelun numerot aina itsenäisesti. Älä koskaan jaa salasanoja, vahvistuskoodeja, korttinumeroita tai henkilökohtaisia tietoja.';

  @override
  String get selectActionToPerform =>
      'Valitse suoritettava toiminto, kun sääntö täsmää';

  @override
  String get selectActionWhenBlockingCalls =>
      'Valitse toiminto puheluita estettäessä';

  @override
  String get selectActionWhenRuleMatches =>
      'Valitse toiminto, kun sääntö täsmää';

  @override
  String get selectAll => 'Valitse kaikki';

  @override
  String get selectCountry => 'Valitse maa';

  @override
  String get selectDateRange => 'Valitse päivämääräalue';

  @override
  String get selectedDateRange => 'Valittu päivämääräalue';

  @override
  String selectedItems(Object count) {
    return '$count kohdetta valittu';
  }

  @override
  String get selectedLabel => 'Valittu:';

  @override
  String get selectExportFormat => 'Valitse vientimuoto';

  @override
  String get selectLabel => 'Valitse luokka';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Valitse luokka ja anna kelvollinen puhelinnumero';

  @override
  String get selectLanguage => 'Valitse kieli';

  @override
  String get selectMultiple => 'Valitse useita';

  @override
  String get selectPeriod => 'Valitse ajanjakso';

  @override
  String get selectSimCard => 'Valitse SIM-kortti';

  @override
  String get selectSimSlot => 'Valitse SIM-paikka';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Valitse tietty toiminto estetyille puheluille';

  @override
  String get selectTag => 'Valitse tunniste';

  @override
  String get selectTags => 'Valitse tunnisteet';

  @override
  String get selectTrustedDataSource => 'Valitse luotettavat tietolähteet';

  @override
  String get selectYourLanguage => 'Valitse kielesi';

  @override
  String get sender => 'Lähettäjä';

  @override
  String get senderRegexOptional =>
      'Lähettäjän säännöllinen lauseke (valinnainen)';

  @override
  String get serverAddressLabel => 'Palvelimen osoite';

  @override
  String get serviceTypeContact => 'Yhteystilaus';

  @override
  String get serviceTypeLabel => 'Palvelutyyppi';

  @override
  String get serviceTypePhone => 'Puhelintilaus';

  @override
  String get serviceTypePlugin => 'Lisäosapäivitys';

  @override
  String get serviceTypeSms => 'SMS-tilaus';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Aseta';

  @override
  String get setEncryptionPassword => 'Aseta salaus salasana';

  @override
  String get setEncryptionPasswordDescription =>
      'Aseta salaus salasana varmuuskopiointia ja palautusta varten';

  @override
  String get setEncryptionPasswordLabel => 'Aseta salaus salasana';

  @override
  String get setEncryptionPasswordTitle => 'Aseta salaus salasana';

  @override
  String get setPasswordButton => 'Aseta';

  @override
  String get settings => 'Asetukset';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Asetukset varmuuskopioitu kohteeseen: $path';
  }

  @override
  String get settingsLoaded => 'Asetukset ladattu';

  @override
  String settingsLoadFailed(Object error) {
    return 'Asetusten lataus epäonnistui: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Asetukset palautettu onnistuneesti. Käynnistä sovellus uudelleen, jotta muutokset tulevat voimaan.';

  @override
  String get settingsSaved => 'Asetukset tallennettu';

  @override
  String settingsSaveFailed(Object error) {
    return 'Asetusten tallennus epäonnistui: $error';
  }

  @override
  String get settingsTab => 'Asetukset';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get setup => 'Asennus';

  @override
  String get showContactEditDialogStaticMethod =>
      'Staattinen metodi yhteystietojen muokkausikkunan näyttämiseen';

  @override
  String get showExplanation => 'Näytä selitys';

  @override
  String get silence => 'Hiljennä';

  @override
  String get silenceAndNoAnswer => 'Hiljennä ja ei vastausta';

  @override
  String get silenceNoAnswer => 'Hiljennä, ei vastausta';

  @override
  String get silentCallVoiceClone => 'Hiljaisen puhelun ääniklooni';

  @override
  String get silentRules => 'Hiljaiset säännöt';

  @override
  String simCard(Object simNumber) {
    return 'SIM-kortti $simNumber';
  }

  @override
  String get simCardColor => 'SIM-kortin väri';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM-kortin kokoonpano: Aseta itsenäiset suodatussäännöt kullekin SIM-kortille';

  @override
  String get simCardFilterRules => 'SIM-kortin suodatussäännöt';

  @override
  String get simCardFilterRulesDescription =>
      'Aseta erilaiset suodatussäännöt SIM-korttipaikkojen perusteella';

  @override
  String get simCardFontSize => 'SIM-kortin fonttikoko';

  @override
  String get simCardPosition => 'SIM-kortin sijainti';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'SIM-korttitietojen lataus epäonnistui: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM-paikkasäännöt antavat sinulle mahdollisuuden määrittää itsenäiset suodatussäännöt kullekin SIM-paikalle.';

  @override
  String get simRuleInstructionsTitle => 'SIM-paikkasäännöt';

  @override
  String get simRuleManagement => 'SIM-paikkasääntöjen hallinta';

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
    return 'SIM-tietojen lataaminen epäonnistui: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM-paikan suodatuksen määritys';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Mahdollistaa suodatussääntöjen asettamisen SIM-paikan mukaan';

  @override
  String get simSlotFilterDescription =>
      'Määritä itsenäiset suodatussäännöt kullekin SIM-kortille:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM-paikan $slotNumber suodatusasetukset';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIM-paikkojen lataaminen epäonnistui: $error';
  }

  @override
  String get simSlotManagement => 'SIM-paikkojen hallinta';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM-paikan toiminto epäonnistui: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM-paikan sijainti $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM-paikkasäännöt: Itsenäiset suodatusstrategiat per SIM';

  @override
  String get simSlotRuleListTitle => 'SIM-paikkasääntöjen luettelo';

  @override
  String get simSlotRuleManagement => 'SIM-paikkasäännöt';

  @override
  String get simSlotRuleManagementTitle => 'Sääntöjen hallinta';

  @override
  String get simSlotSettings => 'SIM-paikan asetukset';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM-paikka $slotNumber';
  }

  @override
  String get skip => 'Ohita';

  @override
  String get smartCallerId => 'Älykäs puhelun tunnistus';

  @override
  String get sms => 'Tekstiviesti';

  @override
  String get smsFilterDescription =>
      'Tekstiviestien suodatus auttaa sinua suodattamaan roskapostiviestit automaattisesti ja pitämään viestiluettelosi puhtaana. Voit asettaa suodatussääntöjä ja ilmoitusmenetelmiä.';

  @override
  String get smsFilterDisabled => 'Tekstiviestien suodatus pois käytöstä';

  @override
  String get smsFilterEnabled => 'Tekstiviestien suodatus käytössä';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Tekstiviestien suodatussääntö lisätty onnistuneesti';

  @override
  String get smsFilterRules => 'Tekstiviestien suodatussäännöt';

  @override
  String get smsFilterSettings => 'Tekstiviestien suodatusasetukset';

  @override
  String get smsHistory => 'Tekstiviestihistoria';

  @override
  String get smsManagement => 'Tekstiviestien hallinta';

  @override
  String get smsPermission => 'Tekstiviestilupa';

  @override
  String get smsPermissionDescription =>
      'Käytetään roskapostiviestien suodattamiseen.';

  @override
  String get smsRuleAddedSuccessfully =>
      'Tekstiviestisääntö lisätty onnistuneesti';

  @override
  String get smsRuleDeletedSuccessfully =>
      'Tekstiviestisääntö poistettu onnistuneesti';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Tekstiviestisääntöjen lataaminen epäonnistui: $error';
  }

  @override
  String get smsRuleManagement => 'Tekstiviestisääntöjen hallinta';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'Tekstiviestisäännöt viety onnistuneesti kohteeseen $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'Tekstiviestisäännöt tuotu onnistuneesti';

  @override
  String get smsRuleSubscription => 'Tekstiviestisääntöjen tilaus';

  @override
  String get smsRuleUpdatedSuccessfully =>
      'Tekstiviestisääntö päivitetty onnistuneesti';

  @override
  String get smsSettingsSubtitle =>
      'Tekstiviestien suodatus ja avainsanojen esto';

  @override
  String get smsSettingsTitle => 'Tekstiviestiasetukset';

  @override
  String get smsSubscription => 'Tekstiviestitilaus';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Tekstiviestitilaus lisätty onnistuneesti';

  @override
  String get smsSubscriptionRulesDescription =>
      'Tilaa tekstiviestisääntölistoja URL-osoitteen kautta, tukee säännöllisiä lausekkeita. Voit asettaa esto- tai sallimistoimintoja.';

  @override
  String get smsTab => 'Tekstiviestit';

  @override
  String get somePermissionsDenied => 'Joitakin käyttöoikeuspyyntöjä evätty';

  @override
  String get spamLikely => 'Todennäköisesti roskapostia';

  @override
  String get startColor => 'Aloitusväri';

  @override
  String get startDate => 'Aloituspäivämäärä';

  @override
  String get startUsing => 'Aloita käyttö';

  @override
  String get statAnswered => 'Vastattu';

  @override
  String get statBlocked => 'Estetty';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Staattinen menetelmä puhelun tunnuksen tietojen näyttämiseksi';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Staattinen menetelmä maanvalintavalintaikkunan näyttämiseksi';

  @override
  String get staticMethodToDisplayDialog =>
      'Staattinen menetelmä valintaikkunan näyttämiseksi';

  @override
  String get statistics => 'Tilastot';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Tilastojen vientiominaisuus tulossa pian';

  @override
  String get statisticsGrid => 'Tilastotaulukko';

  @override
  String get statisticsPageTitle => 'Data-analyysi';

  @override
  String get stirColor => 'STIR-väri';

  @override
  String get stirFontSize => 'STIR-fonttikoko';

  @override
  String get stirPosition => 'STIR-sijainti';

  @override
  String get storagePermission => 'Tallennuslupa';

  @override
  String get storagePermissionDescription =>
      'Käytetään asetusten ja sääntöjen tallentamiseen.';

  @override
  String get subscribe => 'Tilaa';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Tilaus \"$name\" lisätty onnistuneesti';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Haluatko varmasti poistaa tämän tilauksen?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Poista tilaus';

  @override
  String get subscriptionDeleted => 'Tilaus poistettu';

  @override
  String get subscriptionDeletedSuccessfully =>
      'Tilaus poistettu onnistuneesti';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Tilauksen poistaminen epäonnistui: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Tilaus poistettu';

  @override
  String get subscriptionEmptyState => 'Ei tilauksia saatavilla';

  @override
  String get subscriptionEmptyText => 'Ei vielä tilauksia';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Tilausten lataaminen epäonnistui: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Tilausten lataaminen epäonnistui: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Tilausten hallinta';

  @override
  String get subscriptionName => 'Tilauksen nimi';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Tilauksen nimi ja URL eivät voi olla tyhjiä';

  @override
  String get subscriptionNameHint => 'Syötä tilauksen nimi';

  @override
  String get subscriptionPageTitle => 'Tilausten hallinta';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Tilauksen tilan muuttaminen epäonnistui: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Tilauksen tilan vaihtaminen epäonnistui: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Tilauksen päivittäminen epäonnistui: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Tilaus päivitetty onnistuneesti';

  @override
  String get subscriptionUrl => 'Tilauksen URL-osoite';

  @override
  String get subscriptionUrlHint => 'Syötä tilauksen URL-osoite';

  @override
  String successfullyImportedRules(Object count) {
    return 'Onnistuneesti tuotu $count sääntöä';
  }

  @override
  String get supportSync => 'Tuki synkronoinnille';

  @override
  String get survey => 'Kysely';

  @override
  String get syncDevicesButton => 'Synkronoi laitteet';

  @override
  String get syncFailed => 'Synkronointi epäonnistui';

  @override
  String get syncFailedMessage => 'Synkronointi epäonnistui';

  @override
  String get syncFolderNameHint =>
      'Syötä synkronointikansion nimi (oletus: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Synkronointikansion nimi';

  @override
  String get synchronized => 'Synkronoitu';

  @override
  String get syncing => 'Synkronoidaan...';

  @override
  String get syncNow => 'Synkronoi nyt';

  @override
  String get syncNowButton => 'Synkronoi nyt';

  @override
  String get syncStatusTitle => 'Synkronointitila';

  @override
  String get syncStatusUpdatedMessage => 'Synkronointitila päivitetty';

  @override
  String get syncSuccessful => 'Synkronointi onnistui';

  @override
  String get syncSuccessMessage => 'Synkronointi onnistui';

  @override
  String get syncWithCloudStorage => 'Synkronoi pilvitallennustilan kanssa';

  @override
  String get syncWithCloudStorageSubtitle =>
      'Synkronoi pilvitallennustilan kanssa';

  @override
  String get systemFeatures => 'Järjestelmän ominaisuudet:';

  @override
  String get systemSettingsTitle => 'Järjestelmäasetukset';

  @override
  String get tabAll => 'Kaikki';

  @override
  String get tabAnswered => 'Vastatut';

  @override
  String get tabBlocked => 'Estetyt';

  @override
  String get tabMissed => 'Vastaamattomat';

  @override
  String get tabOutgoing => 'Lähtevät';

  @override
  String tagLabel(String tag) {
    return 'Tunniste: $tag';
  }

  @override
  String get tagsUpdated => 'Tunnisteet päivitetty';

  @override
  String get takeaway => 'Noutoruoka';

  @override
  String get telecommunication => 'Tietoliikenne';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Puhelinmarkkinointi';

  @override
  String get testButton => 'TESTAA';

  @override
  String get testButtonLabel => 'TESTAA';

  @override
  String get testConnectionButton => 'Testaa yhteys';

  @override
  String get textColorsSetting => 'Tekstin ja tunnisteiden värit';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Tämä sovellus on tehokas soittajan tunnistustyökalu, jonka avulla voit tunnistaa ja estää ei-toivottuja puheluita.';

  @override
  String get thisWeek => 'Tällä viikolla';

  @override
  String get timeInterceptor => 'Aikapysäytin';

  @override
  String get timeInterceptorDescription =>
      'Sieppaa/salli automaattisesti potentiaaliset puhelut puhelutiheyden perusteella';

  @override
  String get timeInterceptorExplanation =>
      '• Aikapysäytin: Sieppaa/salli toistuvat puhelut lyhyen ajan sisällä';

  @override
  String get timeInterceptorExplanationContent =>
      'Puhelutiheyden sieppaustoiminto analysoi puhelutiheyttä tunnistaakseen ja siepatakseen/salliakseen automaattisesti toistuvat roskapuhelut.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Puhelutiheyden sieppauksen selitys';

  @override
  String get timeInterceptorSettingsTitle =>
      'Puhelutiheyden sieppausten asetukset';

  @override
  String get timeInterceptorSubtitle =>
      'Sieppaa automaattisesti potentiaaliset roskapuhelut puhelutiheyden perusteella';

  @override
  String get timeInterceptorTitle => 'Ota käyttöön puhelutiheyden sieppaus';

  @override
  String get timeWindowDescription =>
      'Aseta sallittujen toistuvien puheluiden aikavälivalinta. Puhelut samasta numerosta tämän ikkunan sisällä sallitaan.';

  @override
  String timeWindowLabel(int minutes) {
    return 'Sieppausaikaväli (minuuttia): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Aseta sallittujen toistuvien puheluiden aikavälivalinta. Puhelut samasta numerosta tämän ikkunan sisällä sallitaan';

  @override
  String get today => 'Tänään';

  @override
  String get total => 'Yhteensä';

  @override
  String get totalBlocked => 'Yhteensä estetty';

  @override
  String get totalFiltered => 'Yhteensä suodatettu';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Siirrä dataa laitteiden tai alustojen välillä';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Siirrä dataa laitteiden tai alustojen välillä';

  @override
  String get travelTicketing => 'Matkalippujen myynti';

  @override
  String get trend => 'Trendi';

  @override
  String get trendChart => 'Trendikaavio';

  @override
  String get tutorial => 'Tutoriaali';

  @override
  String get type => 'Tyyppi';

  @override
  String get unassignedSIMCard => 'Määrittämätön SIM-kortti';

  @override
  String get unknown => 'Tuntematon';

  @override
  String get unknownLabel => 'Tuntematon tunniste';

  @override
  String get unknownTag => 'Tunniste: Tuntematon';

  @override
  String get unregisterButton => 'Poistu rekisteröinnistä';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Oletko varma, että haluat poistaa laitteen rekisteröinnin $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Poista laitteen rekisteröinti';

  @override
  String get unsupportedFileFormat => 'Tiedostomuotoa ei tueta';

  @override
  String get update => 'Päivitä';

  @override
  String get updateAllNow => 'Päivitä kaikki nyt';

  @override
  String get updateCallFilterConfig => 'Päivitä puhelusuodattimen määritykset';

  @override
  String updateContactFailed(Object error) {
    return 'Yhteystiedon päivitys epäonnistui: $error';
  }

  @override
  String get updateFavoriteStatus => 'Päivitä suosikkitila';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Suosikkitilan päivitys epäonnistui: $error';
  }

  @override
  String get updateInterval => 'Päivitysväli';

  @override
  String get updateLabelFailed => 'Tunnisteen päivitys epäonnistui';

  @override
  String get updateNow => 'Päivitä nyt';

  @override
  String get updatePlugin => 'Päivitä lisäosa';

  @override
  String updatePluginFailed(Object error) {
    return 'Lisäosan päivitys epäonnistui: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Säännön päivitys epäonnistui: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Tilauksen päivitys epäonnistui: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service päivitetty onnistuneesti ($count sääntöä)';
  }

  @override
  String get updateTags => 'Päivitä tunnisteet';

  @override
  String get useCasesPoint1 =>
      '• Tunnista automaattisesti uudelleenvalitsevat roskapuhelut';

  @override
  String get useCasesPoint2 =>
      '• Sieppaa markkinointipuhelut, jotka soittavat useita kertoja lyhyen ajan sisällä';

  @override
  String get useCasesPoint3 => '• Estä puhelinpommitus ja häirintä';

  @override
  String get useCasesTitle => 'Käyttötapaukset:';

  @override
  String get useGlobalSettings => 'Käytä globaaleja asetuksia';

  @override
  String get userEmail => 'kayttaja@esimerkki.com';

  @override
  String get usernameLabel => 'Käyttäjänimi';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Käytä tavallista regex-syntaksia kuvioiden määrittelyyn. Esimerkkejä:';

  @override
  String get validateRegex => 'Validoi Regex';

  @override
  String get verificationFailedText => 'Epäonnistui';

  @override
  String get verifiedText => 'Vahvistettu';

  @override
  String get verify => 'Vahvista';

  @override
  String version(Object version) {
    return 'Versio: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Vaihda VIP-jäsenyyttä puhelinnumeron merkintälaskureihin';

  @override
  String get vipExchangeTitle => 'Vaihda VIP-merkintöjä';

  @override
  String get watchAd => 'Katso mainos';

  @override
  String get watchAdForTemp => 'Katso mainos väliaikaisia etuja varten';

  @override
  String get watchAdForTempDescription =>
      'Katso lyhyt mainos avataksesi väliaikaisesti joitakin premium-ominaisuuksia';

  @override
  String get webDAVConfigTitle => 'WebDAV-määritykset';

  @override
  String get webdavConfigurationTitle => 'WebDAV-määritykset';

  @override
  String get webdavPasswordHint => 'Syötä WebDAV-salasana';

  @override
  String get webdavServerAddressHint => 'Syötä WebDAV-palvelimen osoite';

  @override
  String get webdavUsernameHint => 'Syötä WebDAV-käyttäjänimi';

  @override
  String get week => 'Viikko';

  @override
  String get weekly => 'Viikoittain';

  @override
  String get weeklyBlockedCallsSummary =>
      'Viikoittainen estettyjen puheluiden yhteenveto';

  @override
  String get weeklyChartTitle => 'Viikoittainen estettyjen puheluiden kaavio';

  @override
  String get weeklyReport => 'Viikoittainen raportti';

  @override
  String get weeklyReportDesc =>
      'Vastaanota viikoittainen yhteenvetoraportti puhelujen estotoiminnasta';

  @override
  String get welcome => 'Tervetuloa';

  @override
  String get whitelist => 'Valkoinen lista';

  @override
  String get whitelistLabel => 'Valkoinen lista';

  @override
  String get width => 'Leveys';

  @override
  String get wildcardMatchingDescription =>
      'Käytä \'.\' vastaamaan mitä tahansa merkkiä (esim. \'123.456\' vastaa 123-456)';

  @override
  String get wildcardMatchingTitle => 'Vapaakuvioiden täsmäytys:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Vapaakuvioiden tuki joustavalle suodatukselle';

  @override
  String get windowSizeSetting => 'Ikkunan koko';

  @override
  String get year => 'Vuosi';

  @override
  String get yearly => 'Vuosittain';

  @override
  String get yearlyChartTitle => 'Vuosittaiset estetyt puhelut';

  @override
  String get noSimCardsDetected => 'SIM-kortteja ei löydy';

  @override
  String get filterManagementDescription => 'Aseta puhelusuodattimet';

  @override
  String get callerIdCustomizationSubtitle =>
      'Mukauta soittajan tunnistetietojen asettelua';

  @override
  String get fraudAlerSettingTitle => 'Petosvaroitusasetus';

  @override
  String get fraudAlerSettingSubtitle => 'Aseta petosvaroitus';

  @override
  String get enableFraudAlert => 'Ota petosvaroitus käyttöön';

  @override
  String get enableFraudAlertDescription =>
      'Hälytys epäillyistä huijauspuheluista';

  @override
  String get enableVibration => 'Ota värinä käyttöön';

  @override
  String get enableVibrationDescription =>
      'Värise, kun puhelu on epäilty huijauspuhelu';

  @override
  String get notificationSettingsTitle => 'Ilmoitusasetukset';

  @override
  String get useLocalNotification => 'Käytä paikallisia ilmoituksia';

  @override
  String get useLocalNotificationDescription =>
      'Ota paikalliset ilmoitukset saapuville puheluille käyttöön';

  @override
  String get cancelLocalNotification => 'Sulje paikalliset ilmoitukset';

  @override
  String get useStirNotification => 'Käytä STIR-ilmoitusta';

  @override
  String get useStirNotificationDescription =>
      'Ota STIR-ilmoitukset saapuville puheluille käyttöön';

  @override
  String get cancelLocalNotificationDescription =>
      'Sulje paikalliset ilmoitukset automaattisesti';

  @override
  String get callerIdSettingsTitle => 'Soittajan tunnistetietojen asetukset';

  @override
  String get callerIdSettingsSubtitle =>
      'Saapuvan puhelun ilmoituksen ja näyttötilan määrittämiseksi';

  @override
  String get purchaseTitle => 'Osto';

  @override
  String get purchaseSubtitle => 'Palvelun ostamiseksi';

  @override
  String get callerIdNotificationTitle => 'Saapuvan puhelun tiedot';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Numero: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Estetty puhelu';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Estetty puhelu numerosta $phoneNumber';
  }

  @override
  String get stirVerified => 'Vahvistettu';

  @override
  String get stirNotVerified => 'Ei vahvistettu';

  @override
  String get stirFailed => 'Vahvistus epäonnistui';

  @override
  String get stirUnknown => 'Tuntematon vahvistustila';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN-vahvistus';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage numerolle $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Vierivän turvallisuusviestin asetukset';

  @override
  String get messageColor => 'Viestin väri';

  @override
  String get messageFontSize => 'Viestin fonttikoko';

  @override
  String get messagePosition => 'Viestin sijainti';

  @override
  String get containerWidth => 'Säiliön leveys';

  @override
  String get scrollSpeed => 'Vieritysnopeus';

  @override
  String get enableSecurityMessage => 'Ota turvallisuusviesti käyttöön';

  @override
  String get fraudAlertTitle => 'Petosvaroitus';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Mahdollinen huijauspuhelu numerosta $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Sääntöjen lataus epäonnistui: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Puhelulokin lataus epäonnistui: $error';
  }

  @override
  String get noBlockedTypeData => 'Estettyjä tyyppitietoja ei saatavilla';

  @override
  String importEntity(Object entityTypeName) {
    return 'Tuo $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName tuotu onnistuneesti, yhteensä $count tietue tuotu';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName tuonti epäonnistui: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Vie $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName viety onnistuneesti';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName vienti epäonnistui: $error';
  }

  @override
  String get cloudSyncService => 'Pilvisynkronointipalvelu';

  @override
  String get membershipCenter => 'Jäsenkeskus';

  @override
  String get redeemVipWithMarks => 'Lunasta VIP pisteillä';

  @override
  String get currentMarkCount => 'Nykyinen pisteiden määrä';

  @override
  String get markMoreNumbersForMore =>
      'Merkitse lisää numeroita saadaksesi lisää pisteitä';

  @override
  String get noAds => 'Ei mainoksia';

  @override
  String get cloudBackup => 'Pilvivarmuuskopiointi';

  @override
  String get callerIdEnhancement => 'Soittajan tunnistetietojen parannus';

  @override
  String get voiceRecognition => 'Puheentunnistus';

  @override
  String get feature => 'Ominaisuus';

  @override
  String get normalUser => 'Normaali käyttäjä';

  @override
  String get vipUser => 'VIP-käyttäjä';

  @override
  String get temporaryVip => 'Tilapäinen VIP';

  @override
  String get removeAds => 'Poista mainokset';

  @override
  String get unknownAction => 'Tuntematon toiminto';

  @override
  String get settingsBackup => 'Asetusten varmuuskopiointi ';

  @override
  String get allServicesStatusTitle => 'Nykyinen palvelutila';

  @override
  String get allServicesStatusSubtitle =>
      'Pilvipalveluiden kunkin tilan nykytila';

  @override
  String get redirect => 'Ohjaa';

  @override
  String get notify => 'Ilmoita';

  @override
  String get log => 'Lokita';

  @override
  String get custom => 'Mukautettu';

  @override
  String get allowActionDescription =>
      'Puhelut sallitaan, vaikka numero olisi esto-listalla.';

  @override
  String get blockActionDescription =>
      'Puhelut estetään ja näytetään puhelulokissa.';

  @override
  String get silenceActionDescription =>
      'Puhelut vaimennetaan, mutta näytetään puhelulokissa.';

  @override
  String get noneActionDescription =>
      'Puhelulle ei tehdä erityistoimenpiteitä.';

  @override
  String get redirectActionDescription => 'Ohjaa puhelu määritettyyn numeroon.';

  @override
  String get labelActionDescription =>
      'Lisää puheluun tunniste helppoa tunnistusta varten.';

  @override
  String get notifyActionDescription =>
      'Lähetä ilmoitus, kun puhelu vastaanotetaan.';

  @override
  String get logActionDescription =>
      'Tallenna puhelun tiedot lokiin ilman muita toimenpiteitä.';

  @override
  String get customActionDescription => 'Suorita mukautettu toimenpide.';

  @override
  String get synced => 'Synkronoitu';

  @override
  String get needVipAccess =>
      'Tarvitset VIP-pääsyn käyttääksesi tätä ominaisuutta';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Tuo tai vie $entityTypeName tietoja';
  }

  @override
  String get importExportTitle => 'Tuo/Vie';

  @override
  String get noPhoneRules => 'Puhelin sääntöjä ei löydy';

  @override
  String get noRegexRules => 'Regex sääntöjä ei löydy';

  @override
  String get noAllowedBlockedRules => 'Sallittuja/estettyjä sääntöjä ei löydy';

  @override
  String get importExport => 'Tuo/Vie';

  @override
  String get filterByAction => 'Suodata toiminnon mukaan';

  @override
  String get upgradeToVip => 'Päivitä VIP-jäsenyyteen';

  @override
  String get batteryOptimizationPermission => 'Akun optimointi';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Salli sovelluksen toimia taustalla tarjotakseen palveluita, kuten soittajan tunnistusta.';

  @override
  String get permissionTitle => 'Erikoisluvat';

  @override
  String get permissionSubtitle => 'Hallitse ylikalvo- ja akun optimointilupia';

  @override
  String get themeSettingsTitle => 'Teema-asetukset';

  @override
  String get themeSettingsSubtitle => 'Valitse suosikkiteemasi';

  @override
  String get databaseSyncTitle => 'Tietokannan synkronointi';

  @override
  String get countrySyncSettingsTitle =>
      'Maakohtaiset tietokannan synkronointiasetukset';

  @override
  String get countrySyncSettingsSubtitle => 'Valitse maat datan synkronointiin';

  @override
  String get countryDataDisclaimer =>
      'Huomaa: Tietokanta ei välttämättä sisällä tietoja kaikista tietyistä maista tai alueista.';

  @override
  String get editSubscription => 'Muokkaa tilausta';

  @override
  String get searchByNameOrPhoneNumber =>
      'Hae nimen tai puhelinnumeron perusteella';

  @override
  String get allowedBlockedRulesInfo =>
      'Sallitut/estetyt säännöt vastaavat puheluita tiettyihin puhelinnumeroihin, joilla on korkein prioriteetti.';

  @override
  String get searchPhoneRulesHint => 'Hae puhelinsääntöjä';

  @override
  String get phoneRulesInfo =>
      'Puhelinsääntöjä käytetään vastaamaan puheluita tiettyihin puhelinnumeroihin, joilla on matalampi prioriteetti. Jotkut tulevat puhelinsääntötilauksista.';

  @override
  String get searchSubscriptionsHint => 'Hae tilauksia';

  @override
  String get searchPluginsHint => 'Hae lisäosia';

  @override
  String get searchLabelsHint => 'Hae tunnisteita';

  @override
  String get pluginDescription => 'Lisäosan kuvaus';

  @override
  String get enterPluginDescription => 'Syötä lisäosan kuvaus';

  @override
  String get searchRegexRulesHint => 'Hae säännöllisten lausekkeiden sääntöjä';

  @override
  String get regexRulesInfo =>
      'Säännöllisiä lausekkeita käytetään puheluiden suodattamiseen Regex-mallien perusteella.';

  @override
  String get searchMarkedPhonesHint => 'Hae merkittyjä puhelimia';

  @override
  String get searchContactSubscriptionsHint => 'Hae yhteystilaus';

  @override
  String get showAllContacts => 'Näytä kaikki yhteystiedot';

  @override
  String get showFavorites => 'Näytä suosikit';

  @override
  String get manualEntry => 'Manuaalinen syöttöinfo';

  @override
  String get scriptSaved => 'Skripti tallennettu';

  @override
  String editScriptFor(String pluginName) {
    return 'Muokkaa skriptiä kohteelle $pluginName';
  }

  @override
  String get saveScript => 'Tallenna skripti';

  @override
  String get testPlugin => 'Testaa lisäosaa';

  @override
  String get description => 'Kuvaus';

  @override
  String get accessTargetUrl => 'Käytä kohde-URL-osoitetta';

  @override
  String get result => 'Tulos';

  @override
  String get editScript => 'Muokkaa skriptiä';

  @override
  String get numberFormat => 'Numeromuoto';

  @override
  String get nationalNumber => 'Kansallinen numero';

  @override
  String get e164Number => 'E164-numero';

  @override
  String get pluginRulesInfo =>
      'Turvallisuussyistä käytä vain luotetuista lähteistä peräisin olevia lisäosia. Luo vapaasti omia mukautettuja lisäosia malleillamme!';

  @override
  String get advancedMode => 'Lisäasetustila';

  @override
  String get pleaseEnterAtLeastOneNumber => 'Syötä vähintään yksi numero.';

  @override
  String get openInWebView => 'Avaa WebView-näkymässä';

  @override
  String get pluginLabel => 'Lisäosan tunniste';

  @override
  String get pluginID => 'Tunnus';

  @override
  String get pluginURL => 'URL-osoite';

  @override
  String get messageBackgroundColor => 'Viestin taustaväri';

  @override
  String get clearAllCallLogs => 'Tyhjennä kaikki puhelulokit';

  @override
  String get clearAllCallLogsConfirmation =>
      'Vahvista tyhjentää kaikki puhelulokit';

  @override
  String get allCallLogsCleared => 'Kaikki puhelulokit tyhjennetty';

  @override
  String get unblocked => 'Estetty';

  @override
  String get blockNumber => 'Estä numero';

  @override
  String get blockNumberSuccess => 'Numeron esto onnistui';

  @override
  String get blockNumberFailed => 'Numeron esto epäonnistui';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Haluatko varmasti poistaa numeron $phoneNumber eston?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Soitetaan numeroon $phoneNumber...';
  }

  @override
  String get viewDetails => 'Näytä tiedot';

  @override
  String get unblock => 'Poista esto';

  @override
  String get unblockNumber => 'Poista numeron esto';

  @override
  String get unblockNumberSuccess => 'Numeron esto poistettu onnistuneesti';

  @override
  String get unblockNumberFailed => 'Numeron esto epäonnistui';

  @override
  String get serviceNotAvailable => 'Palvelua ei saatavilla';

  @override
  String get callingNumberFailed => 'Soitto numeroon epäonnistui';

  @override
  String get listView => 'Luettelonäkymä';

  @override
  String get timelineView => 'Aikajananäkymä';

  @override
  String get nameCannotBeEmpty => 'Nimi ei voi olla tyhjä';

  @override
  String get selectAction => 'Valitse toiminto';

  @override
  String get selectTargetService => 'Valitse kohdepalvelu';

  @override
  String get callDetails => 'Puhelun tiedot';

  @override
  String get callType => 'Puhelutyyppi';

  @override
  String get callTime => 'Puheluaika';

  @override
  String get numberInvalidFormat => 'Virheellinen numeromuoto';

  @override
  String get membershipFeature => 'Jäsenyysominaisuus';

  @override
  String get medium => 'Media';

  @override
  String get verificationReport => 'Vahvinnusraportti';

  @override
  String get finalRisk => 'Lopullinen riski';

  @override
  String get simState => 'SIM-tila';

  @override
  String get ipCountry => 'IP-maa';

  @override
  String get simCountry => 'SIM-maa';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Numeron osuma';

  @override
  String get support => 'Tuki';

  @override
  String get rewardedAdService => 'Palkittu mainospalvelu';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Sinulla on jo VIP-oikeudet (mainoksia lukuun ottamatta)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Sinulla on jo väliaikaiset oikeudet, vanhenee: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Sinun on katsottava $count mainosta lisää saadaksesi väliaikaiset VIP-oikeudet';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Sinulle on myönnetty $days päivän väliaikaiset ostooikeudet. Vanhenee: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Väliaikainen ostooikeus on vanhentunut';

  @override
  String get loadingAd => 'Ladataan mainosta...';

  @override
  String get earnedTempVip => 'Ansaittu väliaikainen VIP';

  @override
  String get vipExchangeService => 'VIP-vaihtopalvelu';

  @override
  String get marksInsufficient => 'Liian vähän pisteitä vaihdettavaksi';

  @override
  String get invalidExchangeRule => 'Virheellinen vaihtosääntö';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Vaihdetty onnistuneesti kohteeseen $description, vanhenee: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Vaihto epäonnistui: $error';
  }

  @override
  String get vip3DaysWithAds => '3 päivän VIP mainoksilla (vain synkronointi)';

  @override
  String get vip5DaysNoAds => '5 päivän täydellisesti toimiva mainokseton VIP';

  @override
  String get vip7DaysNoAds => '7 päivän täydellisesti toimiva mainokseton VIP';

  @override
  String get noNotifications => 'Ei ilmoituksia';

  @override
  String get clearAllNotifications => 'Tyhjennä kaikki ilmoitukset';

  @override
  String get clearAllNotificationsConfirmation =>
      'Vahvista tyhjentää kaikki ilmoitukset';

  @override
  String get allNotificationsCleared => 'Kaikki ilmoitukset tyhjennetty';

  @override
  String get clearButton => 'Tyhjennä';

  @override
  String get justNow => 'Juuri nyt';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuuttia sitten',
      one: '1 minuutti sitten',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuntia sitten',
      one: '1 tunti sitten',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count päivää sitten',
      one: '1 päivä sitten',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Eilen';

  @override
  String get deletionProposal => 'Poistoesitys';

  @override
  String get deletionProposals => 'Poistoesitykset';

  @override
  String get createProposal => 'Luo esitys';

  @override
  String get createProposalTitle => 'Luo poistoesitys';

  @override
  String get reason => 'Syy';

  @override
  String get reasonOutdated => 'Vanhentunut numero';

  @override
  String get reasonPrivacy => 'Yksityisyyskysymys';

  @override
  String get reasonNotInService => 'Ei palvelussa';

  @override
  String get reasonWronglyIdentified => 'Väärin tunnistettu';

  @override
  String get reasonInaccurateInfo => 'Virheellistä tietoa';

  @override
  String get reasonWrongMarked => 'Väärin merkitty';

  @override
  String get reasonOther => 'Muu';

  @override
  String get submit => 'Lähetä';

  @override
  String get cancel => 'Peruuta';

  @override
  String get proposalStatus => 'Tila';

  @override
  String get statusPending => 'Odottaa';

  @override
  String get statusActive => 'Aktiivinen';

  @override
  String get statusCompleted => 'Valmis';

  @override
  String get statusExpired => 'Vanhentunut';

  @override
  String get riskLevel => 'Riskitaso';

  @override
  String get riskLevelVerified => 'Vahvistettu';

  @override
  String get riskLevelLow => 'Matala';

  @override
  String get riskLevelHigh => 'Korkea';

  @override
  String get riskLevelUnknown => 'Tuntematon';

  @override
  String get votingProgress => 'Äänestyksen eteneminen';

  @override
  String agreeVotes(int count) {
    return 'Kyllä: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Ei: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Yhteensä: $count';
  }

  @override
  String get voteAgree => 'Kyllä';

  @override
  String get voteDisagree => 'Ei';

  @override
  String createdAt(String date) {
    return 'Luotu: $date';
  }

  @override
  String get showReport => 'Näytä raportti';

  @override
  String get hideReport => 'Piilota raportti';

  @override
  String get proposalStatistics => 'Esitystilastot';

  @override
  String get totalProposals => 'Esityksiä yhteensä';

  @override
  String get activeProposals => 'Aktiivisia esityksiä';

  @override
  String get completedProposals => 'Valmiita esityksiä';

  @override
  String get myVotes => 'Omat ääneni';

  @override
  String get proposalCreated => 'Esitys luotu onnistuneesti';

  @override
  String get proposalCreateFailed => 'Esityksen luominen epäonnistui';

  @override
  String get voteSubmitted => 'Ääni annettu onnistuneesti';

  @override
  String get voteSubmitFailed => 'Äänen antaminen epäonnistui';

  @override
  String get noProposalsFound => 'Esityksiä ei löytynyt';

  @override
  String get loadingProposals => 'Ladataan esityksiä...';

  @override
  String get refreshProposals => 'Päivitä esitykset';

  @override
  String get totalPendingProposals => 'Odotettavissa olevia esityksiä yhteensä';

  @override
  String get highRisk => 'Korkea riski';

  @override
  String get mediumRisk => 'Keskitason riski';

  @override
  String get lowRisk => 'Matala riski';

  @override
  String get communityImpact => 'Yhteisövaikutus';

  @override
  String get criticalIssues => 'Kriittiset ongelmat';

  @override
  String get communityParticipation => 'Yhteisön osallistuminen';

  @override
  String get noActivity => 'Ei toimintaa';

  @override
  String get low => 'Matala';

  @override
  String get moderate => 'Kohtalainen';

  @override
  String get high => 'Korkea';

  @override
  String get veryHigh => 'Erittäin korkea';

  @override
  String get voted => 'Äänestetty';

  @override
  String get communityVotes => 'Yhteisön äänet';

  @override
  String get waitingForMoreVotes => 'Odotetaan lisää yhteisön ääniä';

  @override
  String get proposalProcessed => 'Tämä esitys on käsitelty';

  @override
  String get supported => 'TUETTU';

  @override
  String get opposed => 'VASTUSTETTU';

  @override
  String get approved => 'HYVÄKSYTTY';

  @override
  String get rejected => 'Hylätty';

  @override
  String get completed => 'VALMIS';

  @override
  String get pending => 'ODOTTAA';

  @override
  String get critical => 'Kriittinen';

  @override
  String get oppose => 'Vastusta';

  @override
  String get veryLow => 'Erittäin matala';

  @override
  String get deletionProposalNotificationDescription =>
      'Ilmoitukset poistoesitysten äänestystuloksista ja päivityksistä.';

  @override
  String get deletionProposalCreated => 'Poistoesitys luotu';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Poistoesityksesi numerolle $phoneNumber on jätetty yhteisön tarkistettavaksi.';
  }

  @override
  String get proposalApproved => 'Esitys hyväksytty ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Yhteisö on hyväksynyt poistoesityksen numerolle $phoneNumber ($supportPercentage% kannatus, $totalVotes ääntä).';
  }

  @override
  String get proposalRejected => 'Esitys hylätty ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Yhteisö on hylännyt poistoesityksen numerolle $phoneNumber ($supportPercentage% kannatus, $totalVotes ääntä).';
  }

  @override
  String get communityVotingStarted => 'Yhteisöäänestys aloitettu';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Uusi poistoesitys numerolle $phoneNumber on nyt avoinna yhteisön äänestykselle.';
  }

  @override
  String get votingCompleted => 'Äänestys päättynyt';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Yhteisön äänestys numerolle $phoneNumber on päättynyt. Tulos: $result ($supportPercentage% kannatus).';
  }

  @override
  String get newVoteReceived => 'Uusi ääni vastaanotettu';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Joku äänesti numeron $phoneNumber poiston puolesta $voteType. Nykyiset äänet: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Äänten määrän lataaminen epäonnistui';

  @override
  String get voteCount => 'Äänten määrä';

  @override
  String get deletionProposalInfo => 'Poistoesityksen tiedot';

  @override
  String get deletionProposalDescription =>
      'Ehdottele numeroita poistettavaksi, jotka rikkovat yhteisön sääntöjä. Osallistumisesi auttaa pitämään alustan turvallisena.';

  @override
  String get voteToEarnVip => 'Äänestä esityksiä ansaitaksesi VIP-oikeuksia!';

  @override
  String get voteFailed => 'Äänestäminen epäonnistui';

  @override
  String get searchProposals => 'Etsi esityksiä';

  @override
  String get defaultNotifications => 'Oletusilmoitukset';

  @override
  String get defaultNotificationsDescription =>
      'Oletusilmoituskanava sovellukselle.';

  @override
  String get blockedCallNotifications => 'Estettyjen puheluiden ilmoitukset';

  @override
  String get blockedCallNotificationsDescription =>
      'Näyttää tiedot estetyistä puheluista.';

  @override
  String get stirVerification => 'STIR/SHAKEN-varmennus';

  @override
  String get stirVerificationDescription =>
      'Näyttää STIR/SHAKEN-varmennustulokset numeroille.';

  @override
  String get fraudAlerts => 'Petosvaroitukset';

  @override
  String get fraudAlertsDescription =>
      'Näyttää varoituksia mahdollisista petollisista puheluista.';

  @override
  String get notificationFrequencyDescription =>
      'Valitse, kuinka usein saat ilmoituksia uusista poistoehdotuksista. Voit saada ne välittömästi, erissä tai mukautetulla aikavälillä.';

  @override
  String get immediateNotifications => 'Välitön';

  @override
  String get immediateNotificationsDescription =>
      'Saat ilmoituksen heti, kun ehdotus luodaan.';

  @override
  String get batchNotifications => 'Erissä';

  @override
  String get batchNotificationsDescription =>
      'Saat yhteenvedon ilmoituksista ajoittain.';

  @override
  String get customNotifications => 'Mukautettu';

  @override
  String get customNotificationsDescription =>
      'Määritä oma aikavälisi ilmoitusten vastaanottamiselle.';

  @override
  String get customFrequency => 'Mukautettu tiheys';

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
  String get pendingProposals => 'Odottaa ehdotuksia';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count odottavaa ehdotusta',
      one: '1 odottava ehdotus',
      zero: 'ei odottavia ehdotuksia',
    );
    return 'Sinulla on $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Ohjeet';

  @override
  String get reportingGuidelines =>
      '• Raportoi vain todella ongelmallisia numeroita\n• Anna tarkat ja yksityiskohtaiset syyt\n• Valitse asianmukainen riskitaso vakavuuden perusteella\n• Vääristä raportoinnista voi seurata tilin rajoituksia';

  @override
  String get riskLevelLabel => 'Riskitaso';

  @override
  String get riskLevelDescription => 'Numeron riskitaso';

  @override
  String get phoneNumberMinDigits =>
      'Puhelinnumerossa on oltava vähintään 7 numeroa';

  @override
  String get provideDetailedExplanation =>
      'Anna yksityiskohtainen selitys (vähintään 10 merkkiä)';

  @override
  String get reasonMinCharacters => 'Syyn on oltava vähintään 10 merkkiä pitkä';

  @override
  String get countryCodeTwoLetters => 'Maakoodi (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Maakoodi (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'esim. FI, DE, SE';

  @override
  String get countryCodeRequired => 'Maakoodi on pakollinen';

  @override
  String get countryCodeLengthError => 'Maakoodin on oltava 2 kirjainta pitkä';

  @override
  String get phoneNumberLengthError =>
      'Puhelinnumerossa on oltava vähintään 7 numeroa';

  @override
  String get reasonHint =>
      'Anna yksityiskohtainen selitys (vähintään 10 merkkiä)';

  @override
  String get reasonRequired => 'Syy on pakollinen';

  @override
  String get reasonLengthError => 'Syy on oltava vähintään 10 merkkiä pitkä';

  @override
  String get guidelinesTitle => 'Ohjeet';

  @override
  String get guidelinesText =>
      '• Raportoi vain todella ongelmallisia numeroita\n• Anna tarkat ja yksityiskohtaiset syyt\n• Valitse asianmukainen riskitaso vakavuuden perusteella\n• Vääristä raportoinnista voi seurata tilin rajoituksia';

  @override
  String get riskLevelCritical => 'Kriittinen';

  @override
  String get riskLevelMedium => 'Keskisuuri';

  @override
  String get riskLevelVeryLow => 'Erittäin matala';

  @override
  String get riskDescriptionVeryLow =>
      'Erittäin matala - Vähäinen häiriö, harvinaiset puhelut';

  @override
  String get riskDescriptionLow => 'Matala - Satunnaiset ei-toivotut puhelut';

  @override
  String get riskDescriptionMedium =>
      'Keskisuuri - Säännöllinen roskaposti tai puhelinmyynti';

  @override
  String get riskDescriptionHigh =>
      'Korkea - Jatkuva häirintä tai huijausyritykset';

  @override
  String get riskDescriptionCritical =>
      'Kriittinen - Vaaralliset huijaukset tai uhkaukset';

  @override
  String get notificationFrequencyTitle => 'Ilmoitustiheys';

  @override
  String get notificationFrequencyLabel => 'Ilmoitustiheys (tuntia)';

  @override
  String errorMessage(String error) {
    return 'Virhe: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Äänet: $totalVotes ($supportPercentage% tukee)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Tukee ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Vastustaa ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Juuri nyt';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m sitten';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}h sitten';
  }

  @override
  String timeDaysAgo(int days) {
    return '${days}d sitten';
  }

  @override
  String get notificationFrequencyHours => 'Ilmoitustiheys (Tuntia)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes ääntä ($supportPercentage% tukee)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuntia',
      one: '1 tunti',
      zero: '0 tuntia',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Tärkeä huomautus';

  @override
  String get dataSourceDisclaimer =>
      'Numerot on hankittu internetistä ja käyttäjien lähettämistä tiedoista. Emme voi taata, että poistettua numeroa eivät muut käyttäjät tai lähteet lähetä uudelleen. Hae ja tarkista tietoja aktiivisesti.';

  @override
  String get avatar => 'Profiilikuva';

  @override
  String get location => 'Sijainti';

  @override
  String get simCardTitle => 'SIM-kortti';

  @override
  String get liveActivitiesSettingsTitle => 'Live-aktiviteettien asetukset';

  @override
  String get elementsSettingsTitle => 'Elementtien asetukset';

  @override
  String get liveActivityMode => 'Live-aktiviteetti';

  @override
  String get liveActivityModeDescription =>
      'Näyttää puhelutiedot pysyvänä ilmoituksena lukitusnäytössä ja Dynamic Islandissa (iOS).';

  @override
  String get phoneNumberType => 'Puhelintyyppi';

  @override
  String get liveActivitiesTestEndActivity => 'Lopeta aktiviteetti';

  @override
  String get liveActivitiesTestSendNewActivity => 'Lähetä uusi aktiviteetti';

  @override
  String get liveActivitiesTestUpdateActivity => 'Päivitä aktiviteetti';

  @override
  String get liveActivityControlsTitle => 'Live-aktiviteetin hallinta';

  @override
  String get liveActivitiesTestTitle => 'Live-aktiviteettien testi';

  @override
  String get liveActivitiesTestSubtitle =>
      'Testaa live-aktiviteetti-ilmoitusta.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Live-ilmoituksen mukauttaminen';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Mukauta live-ilmoitusten ulkoasua.';

  @override
  String get notification_instructions =>
      'Ohjeet:\n1. Napauta \"LÄHETÄ\" luodaksesi tai päivittääksesi ilmoituksen.\n2. Siirry aloitusnäyttöön tai vedä ilmoituskeskus alas nähdäksesi tuloksen.\n3. Napauta \"LOPETA\" hylätäksesi ilmoituksen.';

  @override
  String get autoCancelNotification => 'Automaattinen ilmoituksen peruutus';

  @override
  String get autoCancelNotificationDescription =>
      'Jos valittuna, ilmoitus hylätään automaattisesti, kun käyttäjä napauttaa sitä.';

  @override
  String get setDelayTime => 'Aseta viiveaika';

  @override
  String get proposalDetails => 'Ehdotuksen tiedot';

  @override
  String get filterByStatus => 'Suodata tilan mukaan';

  @override
  String get proposalNotFound => 'Ehdotusta ei löytynyt';

  @override
  String get processed => 'Käsitelty';

  @override
  String get showAll => 'Näytä kaikki';

  @override
  String get filterAndSortTitle => 'Suodata ja järjestä';

  @override
  String get filterVerifiedOwner => 'Suodata vahvistettu omistaja';

  @override
  String get filterBy => 'Suodata';

  @override
  String get sortOldest => 'Järjestä vanhin';

  @override
  String get sortNewest => 'Järjestä uusin';

  @override
  String get sortMostPopular => 'Järjestä suosituin';

  @override
  String get sortLeastPopular => 'Järjestä vähiten suosittu';

  @override
  String get sortBy => 'Järjestä';

  @override
  String get simRulesNotFound => 'SIM-sääntöjä ei löytynyt';

  @override
  String get simSlotRules => 'SIM-paikan säännöt';

  @override
  String get noSimCardDetected => 'SIM-korttia ei havaittu';

  @override
  String get invalidSimData => 'Virheelliset SIM-tiedot';

  @override
  String get simCardData => 'SIM-kortin tiedot';

  @override
  String get simSlot => 'SIM-paikka';

  @override
  String get enableFiltering => 'Ota suodatus käyttöön';

  @override
  String get detailedSettingsTitle => 'Yksityiskohtaiset asetukset';

  @override
  String get entryPointViewTitle => 'Aloitusnäkymä';

  @override
  String get callTypeRejected => 'Hylätty';

  @override
  String get callTypeSilenced => 'Mykistetty';

  @override
  String get callTypeVoicemail => 'Äänipuhelin';

  @override
  String get callTypeUnknownIntercept => 'Tuntematon katkaisu';

  @override
  String andMoreItems(int count) {
    return 'ja $count muuta kohdetta';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Cloud Sync Settings';

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
