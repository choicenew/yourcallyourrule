// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get aboutContactSubscription => 'O předplatném kontaktů';

  @override
  String get aboutLabels => 'O štítcích';

  @override
  String get aboutPhoneSubscriptionRules =>
      'O pravidlech pro předplatná telefonů';

  @override
  String get aboutPhoneSubscriptions => 'O předplatných telefonů';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Přihlaste se k odběru seznamů pravidel pro telefony přes URL, automaticky aktualizujte pravidla. Podporuje soubory pravidel ve formátu JSON, CSV.';

  @override
  String get aboutSmsFilter => 'O filtrování SMS';

  @override
  String get aboutSmsSubscriptionRules => 'O pravidlech pro předplatná SMS';

  @override
  String get aboutSubtitle => 'Informace o verzi aplikace a právní informace';

  @override
  String get aboutTitle => 'O aplikaci';

  @override
  String get action => 'Akce';

  @override
  String get actionAll => 'Všechny';

  @override
  String get actionAllow => 'Povolit';

  @override
  String get actionBlock => 'Blokovat';

  @override
  String get actionFilterAll => 'Všechny filtry';

  @override
  String get actionFilterTitle => 'Filtrovat podle typu akce';

  @override
  String get actionFilterTooltip => 'Filtr akcí';

  @override
  String get actionNone => 'Žádná akce';

  @override
  String get actionSilence => 'Ticho';

  @override
  String actionTag(Object actionType) {
    return 'Akce: $actionType';
  }

  @override
  String get actionType => 'Typ akce';

  @override
  String get actionUnknown => 'Neznámé';

  @override
  String get add => 'Přidat';

  @override
  String get addAllowedBlockedRule => 'Přidat pravidlo Povolit/Blokovat';

  @override
  String get addAllowSubscription => 'Přidat předplatné Povolit';

  @override
  String get addBlockSubscription => 'Přidat předplatné Blokovat';

  @override
  String get addContactButton => 'Přidat kontakt';

  @override
  String addContactFailed(Object error) {
    return 'Nepodařilo se přidat kontakt: $error';
  }

  @override
  String get addedToAllowedRules => 'Přidáno do povolených pravidel';

  @override
  String get addedToBlacklist => 'Přidáno na černou listinu';

  @override
  String get addedToBlockedRules => 'Přidáno do blokovaných pravidel';

  @override
  String get addedToFavoriteContacts => 'Přidáno mezi oblíbené kontakty';

  @override
  String get addedToFavorites => 'Přidáno mezi oblíbené';

  @override
  String get addedToWhitelist => 'Přidáno na bílou listinu';

  @override
  String get addFavorite => 'Přidat oblíbený';

  @override
  String get addFilter => 'Přidat filtr';

  @override
  String get addLabel => 'Přidat štítek';

  @override
  String get addLabelButton => 'Přidat štítek';

  @override
  String addLabelFailed(Object error) {
    return 'Nepodařilo se přidat štítek: $error';
  }

  @override
  String get addLabelToCall => 'Přidat štítek k záznamu hovoru';

  @override
  String get addName => 'Přidat jméno';

  @override
  String get addNoneSubscription => 'Přidat předplatné Žádné';

  @override
  String get addOrEditContactInfo =>
      'Slouží k přidání nebo úpravě informací o kontaktu';

  @override
  String get addPhoneMark => 'Přidat značku telefonu';

  @override
  String get addPhoneNumberRule => 'Přidat pravidlo pro telefonní číslo';

  @override
  String get addPlugin => 'Přidat plugin';

  @override
  String get addPluginFailed => 'Nepodařilo se přidat plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Nepodařilo se přidat plugin: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Přidat plugin z lokálního souboru';

  @override
  String get addPluginFromUrl => 'Přidat plugin z URL';

  @override
  String get addRegexRule => 'Přidat regulární pravidlo';

  @override
  String get addRule => 'Přidat pravidlo';

  @override
  String get addRuleButton => 'Přidat pravidlo';

  @override
  String addRuleFailed(Object error) {
    return 'Nepodařilo se přidat pravidlo: $error';
  }

  @override
  String get addRuleTooltip => 'Přidat pravidlo';

  @override
  String get addSilenceSubscription => 'Přidat předplatné Ticho';

  @override
  String get addSimRuleButton => 'Přidat pravidlo SIM';

  @override
  String get addSmsFilterRule => 'Přidat pravidlo filtru SMS';

  @override
  String get addSmsRule => 'Přidat pravidlo SMS';

  @override
  String get addSmsSubscription => 'Přidat předplatné SMS';

  @override
  String get addSubscription => 'Přidat předplatné';

  @override
  String get addSubscriptionButton => 'Přidat předplatné';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Nepodařilo se přidat předplatné: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Přidat předplatné';

  @override
  String get addToAllowedRules => 'Přidat do povolených pravidel';

  @override
  String get addToBlacklist => 'Přidat na černou listinu';

  @override
  String get addToBlockedRules => 'Přidat do blokovaných pravidel';

  @override
  String get addToFavoriteContacts => 'Přidat mezi oblíbené kontakty';

  @override
  String get addToFavorites => 'Přidat mezi oblíbené';

  @override
  String get addToRules => 'Přidat do pravidel';

  @override
  String get addToWhitelist => 'Přidat na bílou listinu';

  @override
  String get adPlaceholder => 'Zástupný text reklamy';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Všechny';

  @override
  String get allCallsTab => 'Všechny';

  @override
  String get allDataClearedSuccessfully => 'Všechna data byla úspěšně vymazána';

  @override
  String get allow => 'Povolit';

  @override
  String get allowAllAllowRules => 'Povolit všechna povolovací pravidla';

  @override
  String get allowAllAllowRulesDesc => 'Povolit hovory z povolených pravidel';

  @override
  String get allowAllBlacklistedNumbers =>
      'Povolit všechna čísla na černé listině';

  @override
  String get allowAllBlacklistedNumbersDesc => 'Povolit hovory z černé listiny';

  @override
  String get allowAllBlockRules => 'Povolit všechna blokovací pravidla';

  @override
  String get allowAllBlockRulesDesc => 'Povolit hovory z blokovacích pravidel';

  @override
  String get allowAllowedNumbers => 'Povolit povolená čísla';

  @override
  String get allowAllowedNumbersDesc => 'Povolit hovory z bílé listiny';

  @override
  String get allowBlock => 'Povolit/Blokovat';

  @override
  String get allowBlockedNumbers => 'Povolit blokovaná čísla';

  @override
  String get allowBlockedNumbersDesc => 'Povolit hovory z černé listiny';

  @override
  String get allowedBlockedRule => 'Pravidlo Povolit/Blokovat';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Upravit pravidlo Povolit/Blokovat';

  @override
  String get allowedBlockedRuleManagement => 'Správa pravidel Povolit/Blokovat';

  @override
  String get allowNonExceededNumbers => 'Povolit čísla, která nepřesáhla limit';

  @override
  String get allowNonExceededNumbersDescription =>
      'Automaticky povolit čísla, která nepřesáhla prahovou hodnotu počtu';

  @override
  String get allowRegexAllowRules =>
      'Povolit povolovací pravidla s regulárními výrazy';

  @override
  String get allowRegexAllowRulesDesc =>
      'Povolit porovnávání vzorů regulárních výrazů pro povolovací pravidla';

  @override
  String get allowRegexAllowRulesDescription =>
      'Povolit povolovací pravidla založená na regulárních výrazech';

  @override
  String get allowRegexBlockRules =>
      'Povolit blokovací pravidla s regulárními výrazy';

  @override
  String get allowRegexBlockRulesDesc =>
      'Povolit porovnávání vzorů regulárních výrazů pro blokovací pravidla';

  @override
  String get allowRegexBlockRulesDescription =>
      'Povolit blokovací pravidla založená na regulárních výrazech';

  @override
  String get allowRule => 'Povolovací pravidlo';

  @override
  String get allowRules => 'Povolovací pravidla';

  @override
  String get allowWhitelistedNumbers => 'Povolit povolená čísla';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Povolit všechna čísla na povoleném seznamu';

  @override
  String get allPermissionsGranted => 'Všechna oprávnění udělena';

  @override
  String get allSettingsCompleted => 'Všechna nastavení dokončena.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Všechny aktualizace dokončeny ($count pravidel)';
  }

  @override
  String get answerThenHangup => 'Odpovědět a poté zavěsit';

  @override
  String get appLegalese =>
      '© 2023 Vaše volání Vaše pravidla. Všechna práva vyhrazena.';

  @override
  String get applicationSoftware => 'Aplikační software';

  @override
  String get apply => 'Použít';

  @override
  String get appName => 'Vaše volání Vaše pravidla';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Autorizace selhala: Zkontrolujte prosím klientské ID a klíč';

  @override
  String get authorizationFailedMessage => 'Autorizace selhala';

  @override
  String get authorizationSuccessMessage => 'Autorizace úspěšná';

  @override
  String get authorizeLoginButton => 'Autorizovat přihlášení';

  @override
  String get automotiveIndustry => 'Automobilový průmysl';

  @override
  String get autoSyncLabel => 'Automatická synchronizace';

  @override
  String get autoUpdate => 'Automatická aktualizace';

  @override
  String get autoUpdateDescription =>
      'Nastavit intervaly automatických aktualizací pro předplatná nebo aktualizovat ručně';

  @override
  String get autoUpdateSettings => 'Nastavení automatické aktualizace';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Spravovat automatické aktualizace pravidel a pluginů';

  @override
  String get autoUpdateSettingsTitle => 'Nastavení automatické aktualizace';

  @override
  String get autoUpdateSubtitle =>
      'Spravovat automatické aktualizace pravidel a pluginů';

  @override
  String get autoUpdateTitle => 'Automatická aktualizace';

  @override
  String get avatarBorderColor => 'Barva ohraničení avatara';

  @override
  String get avatarBorderSize => 'Velikost ohraničení avatara';

  @override
  String get avatarIconSizesSetting => 'Velikosti avatarů a ikon';

  @override
  String get avatarPosition => 'Pozice avatara';

  @override
  String get avatarSize => 'Velikost avatara';

  @override
  String axisPosition(Object axis) {
    return 'Pozice $axis';
  }

  @override
  String get backgroundGradientSetting => 'Gradient pozadí';

  @override
  String get backup => 'Zálohovat';

  @override
  String get backupAndRestore => 'Zálohování a obnovení';

  @override
  String get backupAndRestoreSubtitle => 'Zálohovat nebo obnovit data aplikace';

  @override
  String get backupAndRestoreTitle => 'Zálohování a obnovení';

  @override
  String get backupFailed => 'Zálohování selhalo';

  @override
  String get backupFailedMessage => 'Zálohování selhalo';

  @override
  String backupFailedWithError(Object error) {
    return 'Zálohování selhalo: $error';
  }

  @override
  String get backupRestoreSubtitle => 'Zálohovat nebo obnovit data aplikace';

  @override
  String get backupRestoreTitle => 'Zálohování a obnovení';

  @override
  String get backupSectionTitle => 'Zálohování';

  @override
  String get backupSettings => 'Nastavení zálohování';

  @override
  String get backupSettingsDialogTitle => 'Nastavení zálohování';

  @override
  String get backupSettingsTitle => 'Nastavení zálohování';

  @override
  String get backupSuccessMessage => 'Úspěšně zálohováno do cloudu';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Zálohování úspěšné do: $path';
  }

  @override
  String get backupToCloud => 'Zálohovat do cloudu';

  @override
  String get backupToCloudDescription =>
      'Zálohovat nastavení a pravidla do cloudového úložiště';

  @override
  String backupToCloudFailed(Object error) {
    return 'Zálohování do cloudu selhalo: $error';
  }

  @override
  String get backupToCloudLabel => 'Zálohovat do cloudu';

  @override
  String get backupToCloudSuccess => 'Úspěšně zálohováno do cloudu';

  @override
  String get backupToCloudTitle => 'Zálohování do cloudu';

  @override
  String get backupToLocalLabel => 'Zálohovat lokálně';

  @override
  String get bank => 'Banka';

  @override
  String get basicInfo => 'Základní informace';

  @override
  String get basicRuleFilter => 'Základní filtr pravidel';

  @override
  String get basicRuleFiltering => 'Základní filtrování pravidel';

  @override
  String get basicRuleFilteringExplanation =>
      '• Základní filtrování pravidel: filtrování pravidel na základě černé listiny, bílé listiny a regulárních výrazů';

  @override
  String get basicRuleFilterSettings => 'Nastavení základního filtru pravidel';

  @override
  String get basicRuleFilterSubtitle =>
      'Filtrovat hovory pomocí černé/bílé listiny a regulárních výrazů';

  @override
  String get batchDeleteContacts => 'Hromadné smazání kontaktů';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Opravdu chcete smazat $count vybraných kontaktů?';
  }

  @override
  String get batchDeleteFailed => 'Hromadné smazání selhalo';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Opravdu chcete smazat $count štítků?';
  }

  @override
  String get blacklist => 'Černá listina';

  @override
  String get blacklistingAndWhitelisting => 'Blokování a povolování';

  @override
  String get blacklistLabel => 'Černá listina';

  @override
  String get blackWhiteList => 'Černá/Bílá listina';

  @override
  String get block => 'Blokovat';

  @override
  String get blockCalls => 'Blokovat hovory';

  @override
  String get blocked => 'Blokováno';

  @override
  String get blockedCallAction => 'Akce blokovaného hovoru';

  @override
  String get blockedCalls => 'Blokované hovory';

  @override
  String get blockedCallsTitle => 'Blokované hovory';

  @override
  String get blockedCommunications => 'Blokovaná komunikace';

  @override
  String get blockedPhoneLabel => 'Blokované hovory';

  @override
  String get blockedSpamCalls => 'Blokované spamové hovory';

  @override
  String get blockingTrend => 'Trend blokování';

  @override
  String get blockInternationalCalls =>
      'odpovídá číslům, která nezačínají na + nebo 00';

  @override
  String get blockInternationalCallsTitle => 'Blokovat mezinárodní hovory';

  @override
  String get blockLandlineNumbersTitle => 'Blokovat pevné linky';

  @override
  String get blockMobileNumbers => 'odpovídá číslům, která nezačínají na 13-19';

  @override
  String get blockMobileNumbersTitle => 'Blokovat mobilní čísla';

  @override
  String get blockPremiumRateNumbers =>
      'odpovídá číslům, která nezačínají na 118 nebo 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Blokovat čísla s prémiovou sazbou';

  @override
  String get blockRule => 'Pravidlo blokování';

  @override
  String get blockRules => 'Pravidla blokování';

  @override
  String get blockSpecificAreaCodes =>
      'odpovídá číslům začínajícím na 0 + 2-3 číslice';

  @override
  String get blockSpecificAreaCodesTitle => 'Blokovat specifické předvolby:';

  @override
  String get blockTypeAnalysisTitle => 'Analýza typů blokování';

  @override
  String get both => 'Oba';

  @override
  String get bulkDelete => 'Hromadné smazání kontaktů';

  @override
  String get bulkDeleteContacts => 'Hromadné smazání kontaktů';

  @override
  String get bulkDeleteLabels => 'Hromadné smazání štítků';

  @override
  String get call => 'Volat';

  @override
  String get callback => 'Zavolat zpět';

  @override
  String callbackTo(String number) {
    return 'Zavolat zpět na $number';
  }

  @override
  String get callBlocking => 'Blokování hovorů';

  @override
  String get callerIdApp => 'Aplikace ID volajícího';

  @override
  String get callerIdCustomizationTitle => 'Přizpůsobit ID volajícího';

  @override
  String get callerIdDialogTitle => 'Informace o ID volajícího';

  @override
  String get callerIdDisplayMode => 'Režim zobrazení ID volajícího';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Označeno $count';
  }

  @override
  String get callerIdPreview => 'Náhled ID volajícího';

  @override
  String get callFilter => 'Filtr hovorů';

  @override
  String get callFilterDescription =>
      'Když je povoleno, příchozí hovory jsou kontrolovány proti níže uvedenému seznamu pravidel. Pravidla filtrování hovorů se standardně nesynchronizují mezi zařízeními.';

  @override
  String get callFilterRules => 'Pravidla filtru hovorů';

  @override
  String get callFilterRulesDescription =>
      'Nastavte základní pravidla pro filtrování hovorů';

  @override
  String get callFilterSettings => 'Nastavení filtru hovorů';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Nastavte limity frekvence hovorů a pravidla blokování';

  @override
  String get callFrequencyInterceptionTitle => 'Zachytávání frekvence hovorů';

  @override
  String get callHistory => 'Historie hovorů';

  @override
  String get callHistoryInfoDesc =>
      'Zde se zobrazuje historie vašich hovorů, včetně příchozích, odchozích a zmeškaných hovorů.';

  @override
  String get callHistoryInfoTitle => 'Historie hovorů';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Inicializace historie hovorů selhala: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Obnovení historie hovorů selhalo: $error';
  }

  @override
  String get callHistoryTab => 'Historie hovorů';

  @override
  String get callHistoryTimelineEarlier => 'Dříve';

  @override
  String get callHistoryTimelineToday => 'Dnes';

  @override
  String get callHistoryTimelineYesterday => 'Včera';

  @override
  String get callScreeningPermission => 'Oprávnění pro filtrování hovorů';

  @override
  String get callScreeningPermissionDescription =>
      'Používá se k filtrování a blokování spamových hovorů.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Oprávnění pro filtrování hovorů není uděleno, což může ovlivnit funkčnost aplikace.';

  @override
  String get callSettingsSubtitle =>
      'Nastavení ID volajícího, filtrování a blokování';

  @override
  String get callSettingsTitle => 'Nastavení hovorů';

  @override
  String get callStatistics => 'Statistiky hovorů';

  @override
  String get callTypeAnswered => 'Přijato';

  @override
  String get callTypeBlocked => 'Blokováno';

  @override
  String get callTypeIconColor => 'Barva ikony typu hovoru';

  @override
  String get callTypeMissed => 'Zmeškaný hovor';

  @override
  String get callTypeOutgoing => 'Odchozí';

  @override
  String get callTypePosition => 'Pozice typu hovoru';

  @override
  String get callTypeUnknown => 'Neznámý';

  @override
  String get cancelButton => 'Zrušit';

  @override
  String get carRental => 'Půjčení auta';

  @override
  String get carrier => 'Operátor';

  @override
  String get carrierColor => 'Barva operátora';

  @override
  String get carrierFontSize => 'Velikost písma operátora';

  @override
  String get carrierPosition => 'Pozice operátora';

  @override
  String get changeLabel => 'Změnit popisek';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Změna stavu pluginu selhala: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Změna stavu předplatného selhala: $error';
  }

  @override
  String get changeTag => 'Změnit značku';

  @override
  String get charity => 'Charita';

  @override
  String chartMonthFormat(int month) {
    return 'Měsíc $month';
  }

  @override
  String get chartOneDayAgo => '1 den zpět';

  @override
  String get chartOneMonthAgo => '1 měsíc zpět';

  @override
  String get chartOneWeekAgo => '1 týden zpět';

  @override
  String get chartTenDaysAgo => '10 dní zpět';

  @override
  String get chartThreeDaysAgo => '3 dny zpět';

  @override
  String get chartToday => 'Dnes';

  @override
  String get checkFileFormat =>
      'Zkontrolujte prosím formát souboru nebo oprávnění';

  @override
  String checkPermissionFailed(Object error) {
    return 'Kontrola oprávnění selhala: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'Vyberte výchozí akci zachycení';

  @override
  String get clearAllData => 'Vymazat všechna data';

  @override
  String get clearAllDataConfirmation =>
      'Opravdu chcete vymazat všechna data aplikace? Tuto akci nelze vrátit zpět.';

  @override
  String get clearAllDataDescription => 'Vymazat všechna data aplikace';

  @override
  String get clearAllDataLabel => 'Vymazat všechna data';

  @override
  String get clearFilter => 'Vymazat filtr';

  @override
  String get clearLabelFilter => 'Vymazat filtr popisků';

  @override
  String get clearLabelFilterButton => 'Vymazat filtr popisků';

  @override
  String get closeButton => 'Zavřít';

  @override
  String get cloudSync => 'Synchronizace v cloudu';

  @override
  String get cloudSyncAndBackupTitle => 'Synchronizace a zálohování v cloudu';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Konfigurace WebDAV, OneDrive a Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Nastavení synchronizace v cloudu';

  @override
  String get cloudSyncTitle => 'Synchronizace v cloudu';

  @override
  String get collapseLabelSelector => 'Sbalit výběr popisků';

  @override
  String get collection => 'Vymáhání dluhu';

  @override
  String get colorPickerTitle => 'Vyberte barvu';

  @override
  String get configManagement => 'Správa konfigurace';

  @override
  String get configUpdated => 'Konfigurace aktualizována';

  @override
  String get configurationAdvice =>
      'Správnou konfigurací můžete nastavit různé strategie filtrování pro pracovní a osobní SIM karty.';

  @override
  String get configureBackupOptions => 'Konfigurovat možnosti zálohování';

  @override
  String get configureBackupOptionsSubtitle =>
      'Konfigurujte možnosti zálohování';

  @override
  String get configureCloudSyncService =>
      'Konfigurujte službu synchronizace v cloudu';

  @override
  String get configureCloudSyncServiceHint =>
      'Nakonfigurujte prosím službu synchronizace v cloudu, abyste povolili synchronizaci mezi více zařízeními.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Nakonfigurujte prosím službu synchronizace v cloudu, abyste povolili synchronizaci mezi více zařízeními.';

  @override
  String get configureSimCardFilterRules =>
      'Konfigurovat pravidla filtru SIM karty';

  @override
  String get configureSyncServiceHint =>
      'Nejprve prosím nakonfigurujte synchronizační službu v nastavení synchronizace v cloudu';

  @override
  String get confirm => 'Potvrdit';

  @override
  String get confirmBatchDeleteContacts => 'Opravdu chcete odstranit vybrané';

  @override
  String get confirmButton => 'Potvrdit';

  @override
  String get confirmDelete => 'Potvrdit smazání';

  @override
  String get confirmDeleteContact => 'Opravdu chcete odstranit';

  @override
  String get confirmDeleteContactName => 'Potvrdit smazání?';

  @override
  String get confirmDeleteFilter => 'Opravdu chcete smazat tento filtr?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Opravdu chcete smazat popisek \"$name\"?';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Opravdu chcete smazat plugin \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Opravdu chcete smazat $count pluginů?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Opravdu chcete smazat toto pravidlo? Tuto akci nelze vrátit zpět.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Opravdu chcete smazat vybrané kontakty?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Opravdu chcete smazat toto pravidlo SMS filtru?';

  @override
  String get confirmDeleteSmsRule => 'Opravdu chcete smazat toto SMS pravidlo?';

  @override
  String get confirmDeleteSubscription =>
      'Opravdu chcete smazat toto předplatné?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Opravdu chcete smazat $name?';
  }

  @override
  String get confirmPassword => 'Potvrdit heslo';

  @override
  String get confirmPasswordLabel => 'Potvrdit heslo';

  @override
  String get connectedStatus => 'Připojeno';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Připojení selhalo: Zkontrolujte prosím adresu serveru, uživatelské jméno a heslo';

  @override
  String get connectionFailedMessage => 'Připojení selhalo';

  @override
  String get connectionStatusLabel => 'Stav připojení';

  @override
  String get connectionSuccessMessage => 'Připojení úspěšné';

  @override
  String get contactAddSuccess => 'Kontakt úspěšně přidán';

  @override
  String get contactDeleted => 'Kontakt odstraněn';

  @override
  String get contactEditDialog => 'Dialog pro úpravu kontaktu';

  @override
  String get contactNameHint => 'Zadejte jméno kontaktu (nepovinné)';

  @override
  String get contactNameLabel => 'Jméno';

  @override
  String get contactNameOptional => 'Jméno kontaktu (nepovinné)';

  @override
  String get contactNotFound => 'Kontakt nenalezen';

  @override
  String get contacts => 'Kontakty';

  @override
  String contactsDeleted(Object count) {
    return 'Odstraněno $count kontaktů';
  }

  @override
  String get contactSettingsSubtitle => 'Správa kontaktů a nastavení popisků';

  @override
  String get contactSettingsTitle => 'Nastavení kontaktů';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Načítání kontaktů selhalo: $error';
  }

  @override
  String get contactsManagement => 'Správa kontaktů';

  @override
  String get contactsManagementPageTitle => 'Stránka správy kontaktů';

  @override
  String get contactsPageTitle => 'Správa kontaktů';

  @override
  String get contactsPermission => 'Povolení kontaktů';

  @override
  String get contactsPermissionDescription =>
      'Používá se k identifikaci hovorů z kontaktů.';

  @override
  String get contactsTab => 'Kontakty';

  @override
  String get contactSubscriptionDescription =>
      'Přihlaste se k odběru seznamů kontaktů prostřednictvím URL, automaticky aktualizujte informace o kontaktech a popisky. Podporuje data ve formátu JSON.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Načítání odběrů kontaktů selhalo: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Odběry kontaktů';

  @override
  String get contactUpdateSuccess => 'Kontakt úspěšně aktualizován';

  @override
  String get contactUs => 'Kontaktujte nás';

  @override
  String get content => 'Obsah';

  @override
  String get contentRegex => 'Regulární výraz obsahu';

  @override
  String get countColor => 'Barva počtu';

  @override
  String get countFontSize => 'Velikost písma počtu';

  @override
  String get countPosition => 'Pozice počtu';

  @override
  String get country => 'Země';

  @override
  String get countryNameColor => 'Barva názvu země';

  @override
  String get countryNameFontSize => 'Velikost písma názvu země';

  @override
  String get countryRegionNamePosition => 'Pozice názvu země/regionu';

  @override
  String get countrySelectionDialog => 'Dialog pro výběr země';

  @override
  String get countrySelectionDialogDescription =>
      'Používá se k výběru země pro dotaz na informace o ID volajícího';

  @override
  String get countThresholdDescription =>
      'Nastavte minimální prahovou hodnotu počtu požadovanou pro spuštění akcí filtrování';

  @override
  String get countThresholdLabel => 'Prahová hodnota počtu';

  @override
  String get countThresholdSettings => 'Nastavení prahové hodnoty počtu';

  @override
  String countThresholdValue(Object count) {
    return 'Prahová hodnota počtu: $count';
  }

  @override
  String get createdRules => 'Vytvořená pravidla';

  @override
  String get csvFormat => 'Formát CSV';

  @override
  String get currentDeviceChip => 'Aktuální';

  @override
  String get currentDeviceLabel => 'Popisek aktuálního zařízení';

  @override
  String get currentDeviceTitle => 'Aktuální zařízení';

  @override
  String get currentLabels => 'Aktuální popisky:';

  @override
  String get currentLanguage => 'Aktuální jazyk';

  @override
  String get currentPasswordLabel => 'Aktuální heslo';

  @override
  String get customerService => 'Zákaznický servis';

  @override
  String get customRange => 'Vlastní rozsah';

  @override
  String get dailyStatistics => 'Denní statistiky';

  @override
  String get dailyStatisticsDesc =>
      'Přijímat denní statistiky o blokovaných hovorech a zprávách';

  @override
  String get dashboardTab => 'Přehled';

  @override
  String get dataAnalysis => 'Analýza dat';

  @override
  String get dataAnalysisDashboardPage => 'Stránka přehledu analýzy dat';

  @override
  String get dataExport => 'Export dat';

  @override
  String dataLoadFailure(Object error) {
    return 'Načítání dat selhalo: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Načítání dat selhalo: $error';
  }

  @override
  String get dataMigration => 'Migrace dat';

  @override
  String get dataMigrationDescription =>
      'Tato funkce vám umožňuje přenášet všechna vaše data mezi zařízeními. V současné době můžete k ruční migraci dat použít funkce zálohování a obnovení.';

  @override
  String get dataMigrationDialogContent =>
      'Tato funkce vám umožňuje přenášet všechna vaše data mezi zařízeními. V současné době můžete k ruční migraci dat použít funkce zálohování a obnovení.';

  @override
  String get dataMigrationDialogTitle => 'Migrace dat';

  @override
  String get dataMigrationSectionTitle => 'Migrace dat';

  @override
  String get dataSourceReminder => 'Připomenutí zdroje dat';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dnů',
      one: '1 den',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days dnů VIP';
  }

  @override
  String get debtCollection => 'Vymáhání dluhu';

  @override
  String get defaultPeriod => 'Týden';

  @override
  String get delete => 'Smazat';

  @override
  String get deleteButton => 'Smazat';

  @override
  String get deleteContact => 'Smazat kontakt';

  @override
  String deleteContactConfirm(Object name) {
    return 'Jste si jisti, že chcete smazat $name?';
  }

  @override
  String get deleteContactConfirmation =>
      'Jste si jisti, že chcete smazat kontakt';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Jste si jisti, že chcete smazat $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Smazat zařízení';

  @override
  String deleteFailed(Object error) {
    return 'Smazání selhalo: $error';
  }

  @override
  String get deleteFilter => 'Smazat filtr';

  @override
  String get deleteLabel => 'Smazat popisek';

  @override
  String deleteLabelFailed(Object error) {
    return 'Smazání popisku selhalo: $error';
  }

  @override
  String get deletePlugin => 'Smazat plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Smazání pluginu selhalo: $error';
  }

  @override
  String get deletePlugins => 'Smazat pluginy';

  @override
  String deletePluginsFailed(Object error) {
    return 'Smazání pluginů selhalo: $error';
  }

  @override
  String get deleteRule => 'Smazat pravidlo';

  @override
  String deleteRuleFailed(Object error) {
    return 'Smazání selhalo: $error';
  }

  @override
  String get deleteSelected => 'Smazat vybrané';

  @override
  String get deleteSmsRule => 'Smazat pravidlo SMS';

  @override
  String get deleteSubscription => 'Smazat odběr';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Jste si jisti, že chcete smazat odběr \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Smazání odběru selhalo: $error';
  }

  @override
  String get deleteSuccess => 'Smazání úspěšné';

  @override
  String get delivery => 'Doručení';

  @override
  String get deviceDeletedSuccessfully => 'Zařízení bylo úspěšně smazáno';

  @override
  String get deviceDeletedSuccessfullyMessage =>
      'Zařízení bylo úspěšně smazáno';

  @override
  String get deviceIdLabel => 'ID zařízení';

  @override
  String get deviceIDLabel => 'ID zařízení';

  @override
  String get deviceManagementSubtitle =>
      'Spravujte synchronizaci více zařízení';

  @override
  String get deviceManagementTitle => 'Správa zařízení';

  @override
  String get deviceModelLabel => 'Model zařízení';

  @override
  String get deviceName => 'Název zařízení';

  @override
  String get deviceNameCannotBeEmpty => 'Název zařízení nesmí být prázdný';

  @override
  String get deviceNameHint => 'Zadejte prosím název zařízení';

  @override
  String get deviceNameLabel => 'Název zařízení';

  @override
  String get deviceRenamedSuccessfully => 'Zařízení bylo úspěšně přejmenováno';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Zařízení bylo úspěšně přejmenováno';

  @override
  String get devicesSyncedSuccessfully =>
      'Zařízení byla úspěšně synchronizována';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Zařízení byla úspěšně synchronizována';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Zařízení byla úspěšně synchronizována';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Zařízení bylo úspěšně odregistrováno';

  @override
  String get dialogTitle => 'Vysvětlení Regex Vzoru';

  @override
  String get differentFromLocalCounter =>
      'Tato funkce se liší od lokálního filtru počítadla, protože se zaměřuje na opakované vzory volání v krátkém čase, nikoli na dlouhodobé počítání označení.';

  @override
  String get disabled => 'Zakázáno';

  @override
  String get disabledStatus => 'Zakázáno';

  @override
  String get disableGlobalPlugins => 'Zakázat globální pluginy';

  @override
  String get disableSubscriptionSuccessfully =>
      'Předplatné bylo úspěšně zakázáno';

  @override
  String get disconnectButton => 'Odpojit';

  @override
  String get disconnectedMessage => 'Odpojeno';

  @override
  String get disconnectedStatus => 'Odpojeno';

  @override
  String get disconnectFailedMessage => 'Odpojení se nezdařilo';

  @override
  String get done => 'Hotovo';

  @override
  String get dualSimAdvice =>
      'Tato funkce je zvláště užitečná pro telefony s duální SIM kartou, aby bylo možné nastavit různé strategie filtrování pro pracovní a osobní SIM karty.';

  @override
  String get earlier => 'Dříve';

  @override
  String get ecommerce => 'Elektronický obchod';

  @override
  String get edit => 'Upravit';

  @override
  String get editContact => 'Upravit kontakt';

  @override
  String get editFilter => 'Upravit filtr';

  @override
  String get editLabel => 'Upravit štítek';

  @override
  String get editPhoneRule => 'Upravit pravidlo pro telefonní čísla';

  @override
  String get editPhoneRules =>
      'Používá se k úpravě pravidel pro telefonní čísla';

  @override
  String get editPhoneRuleTitle => 'Upravit pravidlo pro telefonní čísla';

  @override
  String get editRule => 'Upravit pravidlo';

  @override
  String get editSmsRule => 'Upravit pravidlo pro SMS';

  @override
  String get education => 'Vzdělání';

  @override
  String get elementPositionsSetting => 'Pozice prvků';

  @override
  String get email => 'E-mail';

  @override
  String get emailOptional => 'E-mail (volitelné)';

  @override
  String get enableCallFilter => 'Povolit filtr volání';

  @override
  String get enableCallFilterDescription =>
      'Když je povoleno, příchozí hovory jsou kontrolovány proti níže uvedenému seznamu pravidel. Pravidla filtrování hovorů nejsou ve výchozím stavu synchronizována mezi zařízeními.';

  @override
  String get enabled => 'Povoleno';

  @override
  String get enabledStatus => 'Povoleno';

  @override
  String get enableEncryption => 'Povolit šifrování';

  @override
  String get enableEncryptionDescription => 'Šifrovat záložní soubory';

  @override
  String get enableEncryptionLabel => 'Povolit šifrování';

  @override
  String get enableEncryptionSubtitle => 'Záložní soubory budou zašifrovány';

  @override
  String get enableEncryptionTitle => 'Povolit šifrování';

  @override
  String get enableGlobalPlugins => 'Povolit globální pluginy';

  @override
  String get enableLocalCountFilter => 'Povolit lokální filtr počítadla';

  @override
  String get enableLocalCountFilterDescription =>
      'Automaticky filtrovat spamové hovory na základě počtu označení hovorů';

  @override
  String get enableLocalNotification => 'Použít lokální upozornění';

  @override
  String get enableLocalNotificationDescription =>
      'Když je povoleno, oznámení pro filtrované zprávy se zobrazí na zařízení';

  @override
  String get enableLocationSummary => 'Umístění';

  @override
  String get enableMuteRules => 'Povolit pravidla ztlumení';

  @override
  String get enableMuteRulesDesc =>
      'Aplikovat konfiguraci pravidel pro přerušení ztlumení';

  @override
  String get enableNoneActionRules => 'Povolit pravidla bez akce';

  @override
  String get enableNoneActionRulesDesc =>
      'Umožnit konfigurace pravidel bez akcí přerušení';

  @override
  String get enableNotifications => 'Povolit oznámení';

  @override
  String get enableRemoteNumberFilter => 'Povolit vzdálený filtr čísel';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Použít vzdálenou databázi k filtrování čísel';

  @override
  String get enableRule => 'Povolit pravidlo';

  @override
  String get enableSmsFilter => 'Povolit filtrování SMS';

  @override
  String get enableSmsFilterDescription =>
      'Když je povoleno, zprávy budou automaticky filtrovány podle pravidel';

  @override
  String get enableStatisticsNotifications => 'Povolit oznámení o statistikách';

  @override
  String get enableSubscriptionSuccessfully =>
      'Předplatné bylo úspěšně povoleno';

  @override
  String get enableTimeInterception => 'Povolit časové přerušení';

  @override
  String get enableTimeInterceptionDescription =>
      'Přerušit opakovaná volání v krátkém časovém intervalu';

  @override
  String get enableTimeInterceptor => 'Povolit časový přerušovač';

  @override
  String get endCallImmediately => 'Ukončit hovor okamžitě';

  @override
  String get endColor => 'Koncová barva';

  @override
  String get endDate => 'Datum ukončení';

  @override
  String get enhancedFilterInstructionsTitle => 'Systém rozšířeného filtrování';

  @override
  String get enhancedFilterSettings => 'Nastavení rozšířeného filtrování';

  @override
  String get enhancedFilterSettingsTitle => 'Nastavení rozšířeného filtrování';

  @override
  String get enhancedFilterSystemDescription =>
      'Systém rozšířeného filtrování podporuje globální pravidla i konfiguraci filtrování pro jednotlivé SIM karty.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Zadejte prosím telefonní číslo i regex vzor';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Zadejte prosím telefonní číslo i regex vzor.';

  @override
  String get enterContactName => 'Zadejte prosím název kontaktu';

  @override
  String get enterCurrentPasswordHint => 'Zadejte prosím aktuální heslo';

  @override
  String get enterDeviceName => 'Zadejte název zařízení';

  @override
  String get enterDeviceNameHint => 'Zadejte prosím název zařízení';

  @override
  String get enterEmail => 'Zadejte e-mail';

  @override
  String get enterEmailOptional => 'Zadejte e-mail (volitelné)';

  @override
  String get enterEncryptionPasswordHint => 'Zadejte šifrovací heslo';

  @override
  String get enterEncryptionPasswordTitle => 'Zadejte šifrovací heslo';

  @override
  String get enterFilterName => 'Zadejte název filtru';

  @override
  String get enterFilterPattern => 'Zadejte vzor filtru';

  @override
  String get enterIconCode => 'Zadejte kód ikony';

  @override
  String get enterName => 'Zadejte název kontaktu';

  @override
  String get enterNewDeviceNameHint => 'Zadejte nový název pro toto zařízení';

  @override
  String get enterNewPasswordHint => 'Zadejte prosím nové heslo';

  @override
  String get enterPasswordAgain => 'Zadejte heslo znovu';

  @override
  String get enterPasswordHint => 'Zadejte prosím heslo';

  @override
  String get enterPhoneNumber => 'Zadejte telefonní číslo';

  @override
  String get enterPhoneNumberHint => 'Zadejte telefonní číslo k otestování';

  @override
  String get enterPhoneNumberMultiple =>
      'Zadejte telefonní číslo, více čísel oddělených čárkami';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Zadejte telefonní číslo pro zahájení hledání';

  @override
  String get enterPhoneNumberToVerify => 'Zadejte telefonní číslo k ověření';

  @override
  String get enterPluginName => 'Zadejte název pluginu';

  @override
  String get enterPluginUrl => 'Zadejte adresu URL pluginu';

  @override
  String get enterRegexHint => 'Zadejte regex vzor';

  @override
  String get enterRuleNameAndPattern => 'Zadejte prosím název pravidla a vzor';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Prosím zadejte název pravidla i vzor regulárního výrazu.';

  @override
  String get enterRuleNameHint => 'Zadejte název pravidla';

  @override
  String get enterSearchContent => 'Prosím zadejte obsah vyhledávání';

  @override
  String get enterSubscriptionName => 'Zadejte název odběru';

  @override
  String get enterSubscriptionUrl => 'Zadejte URL odběru';

  @override
  String get enterSyncFolderNameHint =>
      'Prosím zadejte název složky pro synchronizaci (výchozí: NotificationManager)';

  @override
  String get entertainment => 'Zábava';

  @override
  String get enterValidNameAndUrl => 'Prosím zadejte platný název a URL';

  @override
  String get enterValidUrl => 'Prosím zadejte platnou URL';

  @override
  String get enterVersion => 'Zadejte verzi';

  @override
  String get enterWebDAVPasswordHint => 'Prosím zadejte heslo WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Prosím zadejte adresu serveru WebDAV';

  @override
  String get enterWebDAVUsernameHint =>
      'Prosím zadejte uživatelské jméno WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Chyba při mazání zařízení: $error';
  }

  @override
  String get errorLoadingPlugin => 'Chyba při načítání pluginu';

  @override
  String errorOccurredMessage(Object error) {
    return 'Došlo k chybě: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Chyba při přejmenovávání zařízení: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Chyba při synchronizaci zařízení: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Chyba při synchronizaci zařízení: $error';
  }

  @override
  String get errorText => 'Chyba';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Chyba při odhlášení zařízení: $error';
  }

  @override
  String get exampleBlock400Prefix => 'např. Blokovat předčíslí čísel 400';

  @override
  String get exampleBlockMarketingSms => 'např. Blokovat marketingové SMS';

  @override
  String get exampleContentRegex => 'např. .*nabídka.*';

  @override
  String get exampleContentRegexHint => 'Příklad regulárního výrazu pro obsah';

  @override
  String get exampleCouponPromotionDiscount => 'např. .*(kupón|akce|sleva).*';

  @override
  String get exampleFamilyFriends => 'např. Rodina, přátelé atd.';

  @override
  String get examplePhoneNumber => 'např. 10086, 12345 atd.';

  @override
  String get exampleRegex400Prefix =>
      'Příklad regulárního výrazu pro předčíslí 400';

  @override
  String get exampleRegexFormat => 'Příklad: formát ^10086\$';

  @override
  String get exampleSenderRegexHint => 'Příklad';

  @override
  String get exchange => 'Výměna';

  @override
  String get exchangeNow => 'Vyměnit nyní';

  @override
  String get exchangeVip => 'Vyměnit VIP';

  @override
  String get expandLabelSelector => 'Rozbalit výběr štítků';

  @override
  String expiryTime(Object time) {
    return 'Čas vypršení platnosti: $time';
  }

  @override
  String get export => 'Exportovat';

  @override
  String get exportAllApplicationSettings =>
      'Exportovat všechna nastavení aplikace';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Exportovat všechna nastavení aplikace';

  @override
  String get exportAllRuleConfigurations =>
      'Exportovat všechny konfigurace pravidel';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Exportovat všechny konfigurace pravidel';

  @override
  String get exportComplete => 'Export dokončen';

  @override
  String get exportConfig => 'Exportovat konfiguraci';

  @override
  String get exportContacts => 'Exportovat kontakty';

  @override
  String get exportData => 'Exportovat data';

  @override
  String get exportError => 'Chyba exportu';

  @override
  String get exportFailed => 'Export selhal';

  @override
  String get exportFailure => 'Nepodařilo se exportovat konfiguraci';

  @override
  String get exportFeatureComingSoon => 'Funkce exportu bude brzy přidána';

  @override
  String get exporting => 'Exportuje se...';

  @override
  String get exportLabels => 'Exportovat štítky';

  @override
  String exportLabelsFailed(Object error) {
    return 'Nepodařilo se exportovat štítky: $error';
  }

  @override
  String get exportPluginList => 'Exportovat seznam pluginů';

  @override
  String exportPluginListFailed(Object error) {
    return 'Nepodařilo se exportovat seznam pluginů: $error';
  }

  @override
  String get exportRules => 'Exportovat pravidla';

  @override
  String get exportRulesDialogTitle => 'Exportovat pravidla';

  @override
  String get exportRulesTitle => 'Exportovat pravidla';

  @override
  String get exportSmsRules => 'Exportovat pravidla SMS';

  @override
  String get exportStatisticsData => 'Exportovat statistická data';

  @override
  String get exportSuccess => 'Export úspěšný';

  @override
  String get exportSuccesslly => 'Konfigurace úspěšně exportována';

  @override
  String get failedToAddContact => 'Nepodařilo se přidat kontakt';

  @override
  String failedToAddRule(Object error) {
    return 'Nepodařilo se přidat pravidlo: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'Nepodařilo se přidat pravidlo SMS: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Nepodařilo se přidat odběr SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Nepodařilo se zálohovat nastavení: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Nepodařilo se dešifrovat záložní soubor';

  @override
  String get failedToDeleteDevice => 'Nepodařilo se smazat zařízení';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Nepodařilo se smazat pravidlo SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Nepodařilo se exportovat pravidla: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Nepodařilo se exportovat pravidla SMS: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Nepodařilo se získat informace o ID volajícího: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Nepodařilo se importovat pravidla: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'Nepodařilo se importovat pravidla SMS: $error';
  }

  @override
  String get failedToLoadContacts => 'Nepodařilo se načíst kontakty';

  @override
  String get failedToLoadPlugin => 'Nepodařilo se načíst plugin';

  @override
  String get failedToRenameDevice => 'Nepodařilo se přejmenovat zařízení';

  @override
  String get failedToRestoreSettings => 'Nepodařilo se obnovit nastavení';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Nepodařilo se obnovit nastavení: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Nepodařilo se nastavit heslo: $error';
  }

  @override
  String get failedToSyncDevices => 'Nepodařilo se synchronizovat zařízení';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Nepodařilo se přepnout stav pravidla: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Nepodařilo se přepnout stav odběru';

  @override
  String get failedToUpdateContact => 'Nepodařilo se aktualizovat kontakt';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Nepodařilo se aktualizovat pravidlo SMS: $error';
  }

  @override
  String get failure => 'Chyba';

  @override
  String get favoriteContacts => 'Oblíbené kontakty';

  @override
  String get featureAddRules =>
      '• Přidat specifická pravidla pro telefonní čísla';

  @override
  String get featureCenter => 'Centrum funkcí';

  @override
  String get featureEnableDisable =>
      '• Povolit/zakázat různé filtry na SIM kartu';

  @override
  String get featureListTitle => 'Funkce:';

  @override
  String get featureManageRules => '• Spravovat seznamy pravidel na SIM kartu';

  @override
  String get features => 'Funkce';

  @override
  String get fetchingCallerIdInfo => 'Načítají se informace o ID volajícího...';

  @override
  String fileSavedTo(Object path) {
    return 'Soubor uložen do: $path';
  }

  @override
  String get filter => 'Filtr';

  @override
  String get filterByLabel => 'Filtrovat podle štítku';

  @override
  String get filterClear => 'Vymazat filtr';

  @override
  String get filterControlPanelTitle => 'Ovládací panel filtrů';

  @override
  String get filterControlSubtitle =>
      'Spravujte stav zapnutí/vypnutí všech filtrů';

  @override
  String get filterControlTitle => 'Ovládací panel filtrů';

  @override
  String get filterDeleteFailed => 'Odstranění filtru selhalo';

  @override
  String get filterDeleteSuccess => 'Filtr úspěšně odstraněn';

  @override
  String get filterDetails => 'Podrobnosti filtru';

  @override
  String get filtered => 'Filtrováno';

  @override
  String get filteredSms => 'Filtrované SMS';

  @override
  String get filteredSmsLabel => 'Filtrované SMS';

  @override
  String get filterExplanation => 'Vysvětlení filtru';

  @override
  String get filterManagement => 'Správa filtrů';

  @override
  String get filterName => 'Název filtru';

  @override
  String get filterPattern => 'Vzor filtru';

  @override
  String get filterPriorityNote =>
      'Poznámka: Mezi filtry existují prioritní vztahy, podrobnosti naleznete v dokumentaci nápovědy';

  @override
  String get filterSaveFailed => 'Uložení filtru selhalo';

  @override
  String get filterSaveSuccess => 'Filtr úspěšně uložen';

  @override
  String get filterSettings => 'Nastavení filtrů';

  @override
  String get filterSettingsTitle => 'Nastavení filtrů';

  @override
  String get filterSMS => 'Filtrovat SMS';

  @override
  String get filterToggleInstructions =>
      'Povolte nebo zakažte filtry pro tento slot SIM karty:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Filtr $status: $filterName';
  }

  @override
  String get filterType => 'Typ filtru';

  @override
  String get financial => 'Finanční';

  @override
  String get flexibleCombinationFeature =>
      '• Flexibilní kombinace: Povolit/zakázat filtry na slot SIM karty';

  @override
  String get fontSizesSetting => 'Velikost písma';

  @override
  String foundRules(Object count) {
    return 'Nalezeno $count pravidel';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Nalezeno $count pravidel. Chcete je importovat?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Nalezeno $count pravidel. Chcete je importovat?';
  }

  @override
  String get fraudAlert => 'POZOR NA PODVOD – Ukončete hovor';

  @override
  String get fraudScamLikely => 'Pravděpodobně podvodný hovor';

  @override
  String get free => 'Zdarma';

  @override
  String get functionSettingsTitle => 'Nastavení funkcí';

  @override
  String generalUpdateFailure(Object error) {
    return 'Aktualizace selhala: $error';
  }

  @override
  String get getFree => 'Získat zdarma';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Konfigurujte globální filtry pro všechny SIM karty:';

  @override
  String get globalFilterFeature =>
      '• Globální filtry: Základní pravidla pro všechny příchozí hovory';

  @override
  String get globalFilterSettings => 'Nastavení globálního filtru';

  @override
  String get globalFilterToggleInstructions =>
      'Konfigurujte nastavení globálního filtru, které platí pro všechny sloty SIM karty:';

  @override
  String get globalSearchSubtitle =>
      'Vyhledávejte kontakty, štítky, blokované seznamy, povolené seznamy atd.';

  @override
  String get globalSearchTitle => 'Globální vyhledávání';

  @override
  String get globalSettings => 'Globální nastavení';

  @override
  String get googleAdDisplayPosition => 'Pozice zobrazení reklamy Google';

  @override
  String get googleAdMobIntegrationText =>
      'Zde lze integrovat reklamy Google AdMob';

  @override
  String get googleDriveAuthDescription =>
      'Autorizujte pomocí systémově nakonfigurovaného ID klienta a klíče služby Google Drive';

  @override
  String get googleDriveAuthorizationHint =>
      'Autorizujte pomocí systémově nakonfigurovaného ID klienta a klíče služby Google Drive';

  @override
  String get googleDriveConfigTitle => 'Konfigurace Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'Konfigurace Google Drive';

  @override
  String get government => 'Vládní';

  @override
  String get granted => 'Udělena';

  @override
  String get grantNecessaryPermissions => 'Udělit potřebná oprávnění';

  @override
  String get grantPermissions => 'Udělit oprávnění';

  @override
  String get headhunter => 'Lovec lebek';

  @override
  String get height => 'Výška';

  @override
  String get homePageTitle => 'Domovská stránka';

  @override
  String get homeTab => 'Domů';

  @override
  String get howItWorksPoint1 =>
      '• Systém automaticky povolí hovory ze stejného čísla v nastaveném časovém okně';

  @override
  String get howItWorksPoint2 =>
      '• Kratší časová okna znamenají přísnější zachycení; delší časová okna znamenají volnější zachycení';

  @override
  String get howItWorksPoint3 =>
      '• Systém kontroluje historii hovorů, aby určil, zda jde o opakovaný hovor';

  @override
  String get howItWorksTitle => 'Jak to funguje:';

  @override
  String get iconCodeOptional => 'Kód ikony (volitelné)';

  @override
  String get iconSize => 'Velikost ikony';

  @override
  String get import => 'Importovat';

  @override
  String get important => 'Důležité';

  @override
  String get importButton => 'Importovat';

  @override
  String get importConfig => 'Importovat konfiguraci';

  @override
  String get importContacts => 'Importovat kontakty';

  @override
  String get importExportContacts => 'Import/Export kontaktů';

  @override
  String get importExportContactsTooltip => 'Import/Export kontaktů';

  @override
  String get importExportRules => 'Import/Export pravidel';

  @override
  String importFailed(Object error) {
    return 'Import selhal: $error';
  }

  @override
  String get importFailure => 'Nepodařilo se importovat konfiguraci';

  @override
  String get importFeatureComingSoon => 'Funkce importu bude brzy k dispozici';

  @override
  String get importLabels => 'Importovat štítky';

  @override
  String importLabelsFailed(Object error) {
    return 'Nepodařilo se importovat štítky: $error';
  }

  @override
  String get importPluginList => 'Importovat seznam pluginů';

  @override
  String importPluginListFailed(Object error) {
    return 'Nepodařilo se importovat seznam pluginů: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Úspěšně importováno $count pluginů';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Importovat konfigurace pravidel ze souboru';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Importovat konfigurace pravidel ze souboru';

  @override
  String get importRules => 'Importovat pravidla';

  @override
  String get importRulesButton => 'Importovat pravidla';

  @override
  String get importRulesDialogTitle => 'Importovat pravidla';

  @override
  String importRulesError(Object error) {
    return 'Nepodařilo se importovat pravidla: $error';
  }

  @override
  String get importRulesInstructions => 'Importovat pravidla ze souboru CSV';

  @override
  String get importRulesSuccess => 'Pravidla úspěšně importována';

  @override
  String get importRulesTitle => 'Importovat pravidla';

  @override
  String get importSuccess => 'Import úspěšný';

  @override
  String get incomingCallInterceptAction => 'Akce zachycení příchozího hovoru';

  @override
  String get incomingCallNotification => 'Oznámení o příchozím hovoru';

  @override
  String get incorrectPassword => 'Nesprávné heslo';

  @override
  String get initializing => 'Inicializace';

  @override
  String get installed => 'Nainstalováno';

  @override
  String get insufficientMarks => 'Nedostatek bodů';

  @override
  String get insurance => 'Pojištění';

  @override
  String get interceptAction => 'Akce zachycení';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Nastavte, jak se zachází s blokovanými hovory';

  @override
  String get interceptionActionSettingsTitle => 'Nastavení akce zachycení';

  @override
  String get interceptionTimeInterval => 'Časový interval zachycení';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Interval aktualizací $service nastaven na $days dní';
  }

  @override
  String get invalidContentRegex => 'Neplatný regulární výraz obsahu';

  @override
  String get invalidLabel => 'Neplatný popisek';

  @override
  String get invalidRegexPattern => 'Neplatný vzor regulárního výrazu';

  @override
  String get invalidSenderRegex => 'Neplatný regulární výraz pro odesílatele';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Připojte se k Telegram kanálu a skupině pro více informací';

  @override
  String get jsLogsTitle => 'JS protokoly';

  @override
  String get jsonFormat => 'Formát JSON';

  @override
  String get keepAllVersions => 'Ponechat všechny verze';

  @override
  String get keepAllVersionsDescription =>
      'Ponechat všechny historické verze každého zálohování';

  @override
  String get keepAllVersionsLabel => 'Ponechat všechny verze';

  @override
  String get keepAllVersionsSubtitle =>
      'Ponechat historické verze každého zálohování';

  @override
  String get keepAllVersionsTitle => 'Ponechat všechny verze';

  @override
  String get label => 'Popisek';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Popisek \"$name\" byl úspěšně přidán';
  }

  @override
  String get labelCategories => 'Kategorie popisků';

  @override
  String get labelDeleted => 'Popisek byl smazán';

  @override
  String get labelDescription =>
      'Popisky vám pomohou lépe spravovat kontakty, přidávejte vlastní popisky k telefonním číslům pro snadnou identifikaci hovorů a zpráv.';

  @override
  String get labelFilter => 'Filtr popisků';

  @override
  String get labelFilterTooltip => 'Filtr popisků';

  @override
  String get labelIconColor => 'Barva ikony popisku';

  @override
  String get labelManagement => 'Správa popisků';

  @override
  String get labelNotFound => 'Popisek nebyl nalezen';

  @override
  String get labelRemoved => 'Popisek byl odstraněn';

  @override
  String labelRemoveFailed(Object error) {
    return 'Nepodařilo se odstranit popisek: $error';
  }

  @override
  String get labels => 'Popisky';

  @override
  String get labelsColor => 'Barva popisků';

  @override
  String labelsDeleted(Object count) {
    return '$count popisků bylo smazáno';
  }

  @override
  String get labelsExportedSuccessfully => 'Popisky byly úspěšně exportovány';

  @override
  String get labelsFontSize => 'Velikost písma popisků';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Úspěšně importováno $count popisků';
  }

  @override
  String get labelsPosition => 'Pozice popisků';

  @override
  String labelTag(Object labelId) {
    return 'Popisek: $labelId';
  }

  @override
  String get labelUpdated => 'Popisek byl aktualizován';

  @override
  String labelUpdateFailed(Object error) {
    return 'Nepodařilo se aktualizovat popisek: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Popisek \"\$labelText\" byl úspěšně aktualizován';

  @override
  String get languageSettings => 'Nastavení jazyka';

  @override
  String get languageSettingsSubtitle => 'Změnit jazyk zobrazení aplikace';

  @override
  String get languageSettingsTitle => 'Nastavení jazyka';

  @override
  String get last30Days => 'Posledních 30 dní';

  @override
  String get last7Days => 'Posledních 7 dní';

  @override
  String get lastSyncLabel => 'Poslední synchronizace';

  @override
  String lastUpdated(Object date) {
    return 'Poslední aktualizace: $date';
  }

  @override
  String get lifetimeMembership => 'Doživotní členství';

  @override
  String get lifetimeMembershipDescription =>
      'Jednorázový nákup, trvale odemkne všechny prémiové funkce a budoucí aktualizace';

  @override
  String loadContactsFailed(Object error) {
    return 'Nepodařilo se načíst kontakty: $error';
  }

  @override
  String get loadDataFailed => 'Nepodařilo se načíst data';

  @override
  String get loadFailed => 'Načtení selhalo';

  @override
  String get loading => 'Načítání...';

  @override
  String get loadingData => 'Načítání dat...';

  @override
  String get loadingTags => 'Načítání značek...';

  @override
  String loadLabelFailed(Object error) {
    return 'Nepodařilo se načíst popisky: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Nepodařilo se načíst popisky: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Nepodařilo se načíst označená telefonní čísla: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Nepodařilo se načíst označená čísla: $error';
  }

  @override
  String get loadMore => 'Načíst více';

  @override
  String get loadPluginButton => 'Načíst plugin';

  @override
  String loadPluginsFailed(Object error) {
    return 'Nepodařilo se načíst pluginy: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Nepodařilo se načíst nastavení: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Nepodařilo se načíst pravidla SMS: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Nepodařilo se načíst stav';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Nepodařilo se načíst předplatná: $error';
  }

  @override
  String get loan => 'Půjčka';

  @override
  String get localBackupTitle => 'Lokální záloha';

  @override
  String get localCounterFilter => 'Filtr lokálního počtu';

  @override
  String get localCounterFilterSubtitle =>
      'Automaticky filtrovat spamové hovory na základě frekvence hovorů';

  @override
  String get localCountFilter => 'Filtr lokálního počtu';

  @override
  String get localCountFilterDescription =>
      'Zachytávat časté hovory na základě lokálních počtů čísel';

  @override
  String get localCountFilterExplanationContent =>
      'Filtr lokálního počtu analyzuje záznamy historie hovorů k automatickému identifikaci a blokování častých spamových hovorů.';

  @override
  String get localCountFilterExplanationTitle =>
      'Vysvětlení filtru lokálního počtu';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Určit, zda blokovat na základě hodnoty počtu čísla';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Když počet čísla překročí nastavený limit, můžete jej automaticky zablokovat';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Můžete selektivně povolit čísla, která nepřekračují limit';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Můžete zvolit, zda zaznamenávat všechny protokoly dotazů';

  @override
  String get localCountFiltering => 'Filtrování lokálního počtu';

  @override
  String get localCountFilteringExplanation =>
      '• Filtrování lokálního počtu: Pravidla filtrování založená na lokálním počtu označení';

  @override
  String get localCountFilterSettings => 'Nastavení filtru lokálního počtu';

  @override
  String get localCountFilterUseCases =>
      'Tento filtr je obzvláště vhodný pro identifikaci automaticky vytáčených spamových hovorů a marketingových hovorů.';

  @override
  String get localFilterSettings => 'Nastavení lokálního filtru';

  @override
  String get localNotificationDisabled => 'Lokální oznámení zakázáno';

  @override
  String get localNotificationEnabled => 'Lokální oznámení povoleno';

  @override
  String get localServices => 'Lokální služby';

  @override
  String get locationColor => 'Barva umístění';

  @override
  String get locationFontSize => 'Velikost písma umístění';

  @override
  String get locationIconColor => 'Barva ikony umístění';

  @override
  String get locationPosition => 'Pozice umístění';

  @override
  String get logAllLocalQueries => 'Zaznamenat všechny lokální dotazy';

  @override
  String get logAllLocalQueriesDescription =>
      'Zaznamenat protokoly všech lokálních dotazů na čísla';

  @override
  String get logAllRemoteQueries => 'Zaznamenat všechny vzdálené dotazy';

  @override
  String get logAllRemoteQueriesDescription =>
      'Zaznamenat všechny operace vzdálených dotazů na čísla';

  @override
  String get manage => 'Spravovat kontakty';

  @override
  String get manageContacts => 'Správa';

  @override
  String get manageFavoriteContacts => 'Správa oblíbených kontaktů';

  @override
  String get manageFilterRules => 'Správa pravidel filtru';

  @override
  String get manageFilterRulesDescription =>
      'Přidat, upravit nebo smazat pravidla filtru SMS';

  @override
  String get manageFrequentContacts => 'Správa častých kontaktů';

  @override
  String get markCounts => 'Počty označení';

  @override
  String get markCount => 'Počet označení';

  @override
  String markedByCount(Object count) {
    return 'Označeno $count';
  }

  @override
  String get markedPhonesList => 'Seznam označených telefonních čísel';

  @override
  String get markExchange => 'Výměna značky';

  @override
  String get markPhone => 'Označit telefonní číslo';

  @override
  String markPhoneFailed(Object error) {
    return 'Nepodařilo se označit telefonní číslo: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'Označit telefonní čísla';

  @override
  String get markPhoneManagementTitle => 'Správa označování telefonů';

  @override
  String get markPhoneSuccess => 'Telefonní číslo úspěšně označeno';

  @override
  String get matchFailed => 'Shoda selhala!';

  @override
  String get matchFailedMessage => 'Shoda selhala.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'odpovídá specifickému formátu čísla';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Shoda čísel se speciálními znaky:';

  @override
  String get matchSpecificDigitPatterns => 'odpovídá formátu XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Shoda specifických vzorů číslic:';

  @override
  String get matchSuccessful => 'Shoda úspěšná!';

  @override
  String get matchSuccessfulMessage => 'Shoda úspěšná!';

  @override
  String get medical => 'Zdravotní';

  @override
  String get membershipPrivileges => 'Výhody členství';

  @override
  String get migrationTool => 'Nástroj pro migraci';

  @override
  String get migrationToolTitle => 'Nástroj pro migraci';

  @override
  String get minutes => 'minuty';

  @override
  String get month => 'Měsíc';

  @override
  String get monthly => 'Měsíčně';

  @override
  String get monthlyCallCount => 'Měsíční hovory';

  @override
  String get monthlyChartTitle => 'Měsíční zablokované hovory';

  @override
  String get monthlyMembership => 'Měsíční členství';

  @override
  String get monthlyMembershipDescription =>
      'Odemkněte všechny prémiové funkce, automatické obnovení měsíčně';

  @override
  String get monthlyTotal => 'Měsíční celkem';

  @override
  String get monthlyTotalLabel => 'Měsíční celkem';

  @override
  String get moreOptions => 'Další možnosti';

  @override
  String get mute => 'Ztlumit';

  @override
  String get name => 'Jméno';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Jméno a telefonní číslo nemohou být prázdné';

  @override
  String get nameAndPhoneNumberRequired =>
      'Jméno a telefonní číslo nemohou být prázdné';

  @override
  String get nameColor => 'Barva jména';

  @override
  String get nameFontSize => 'Velikost písma jména';

  @override
  String nameLabel(Object name) {
    return 'Jméno: $name';
  }

  @override
  String get namePosition => 'Pozice jména';

  @override
  String get nameUnknown => 'Jméno: Neznámé';

  @override
  String nameWithValue(String name) {
    return 'Jméno: $name';
  }

  @override
  String get newPasswordLabel => 'Nové heslo';

  @override
  String get nextStep => 'Další';

  @override
  String get noAction => 'Žádná akce';

  @override
  String get noActionRules => 'Pravidla pro žádnou akci';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Žádná aktivní služba synchronizace cloudu';

  @override
  String get noCallLogs => 'Žádné protokoly hovorů';

  @override
  String get noCallRecords => 'Žádné záznamy o hovorech';

  @override
  String get noContacts => 'Zatím žádné kontakty';

  @override
  String get noContactsYet => 'Zatím žádné kontakty';

  @override
  String get noData => 'Žádná data';

  @override
  String get noDevicesRegisteredMessage => 'Žádná registrovaná zařízení';

  @override
  String get noDevicesRegisteredYet => 'Zatím žádná registrovaná zařízení.';

  @override
  String get noFilters => 'Zatím žádné filtry';

  @override
  String get noLabels => 'Zatím žádné štítky';

  @override
  String get noMarkedPhones => 'Žádná označená telefonní čísla';

  @override
  String get noMatchingContacts => 'Žádné shodné kontakty';

  @override
  String get noMatchingContactsFound => 'Nebyly nalezeny žádné shodné kontakty';

  @override
  String get noMatchingNumbersFound => 'Nebyly nalezeny žádná shodná čísla';

  @override
  String get noMatchingRecords => 'Žádné shodné záznamy o hovorech';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Žádná shodná $ruleType';
  }

  @override
  String get none => 'Žádný';

  @override
  String get noneServiceType => 'Žádný';

  @override
  String get noPlugins => 'Zatím žádné pluginy';

  @override
  String get noRecords => 'Žádné záznamy o hovorech';

  @override
  String get noResultReturned => 'Nebyl vrácen žádný výsledek';

  @override
  String get noResultReturnedLog => 'Nebyl vrácen žádný výsledek z pluginu';

  @override
  String noRules(Object ruleType) {
    return 'Žádná $ruleType zatím';
  }

  @override
  String get noRulesPrompt =>
      'Nebyly nalezeny žádné pravidla, přidejte pravidla';

  @override
  String get noRulesToExport => 'Žádná pravidla k exportu';

  @override
  String get noSmsFilterRulesYet => 'Zatím žádná pravidla pro filtrování SMS';

  @override
  String get noSmsRulesYet => 'Zatím žádná pravidla pro SMS';

  @override
  String get noSubscriptions => 'Žádná předplatná';

  @override
  String get noSubscriptionsYet => 'Zatím žádná předplatná';

  @override
  String get notGranted => 'Není uděleno';

  @override
  String get notificationMode => 'Režim oznámení';

  @override
  String get notificationModeDescription =>
      'Zobrazit informace o volajícím v notifikační liště';

  @override
  String get notificationPermission => 'Povolení oznámení';

  @override
  String get notificationPermissionDescription =>
      'Používá se k zobrazování oznámení o příchozích hovorech a zprávách.';

  @override
  String get notifications => 'Oznámení';

  @override
  String get notificationSettings => 'Nastavení oznámení';

  @override
  String get notificationSettingsSaved =>
      'Nastavení oznámení bylo úspěšně uloženo';

  @override
  String get notSet => 'Není nastaveno';

  @override
  String get notVerifiedText => 'Není ověřeno';

  @override
  String get noValidSmsRulesFoundInFile =>
      'V souboru nebyly nalezeny žádná platná pravidla pro SMS';

  @override
  String get number => 'Číslo';

  @override
  String get numberColor => 'Barva čísla';

  @override
  String get numberFontSize => 'Velikost písma čísla';

  @override
  String get numberPosition => 'Pozice čísla';

  @override
  String get numberSearch => 'Vyhledávání čísel';

  @override
  String get numberTypeColor => 'Barva typu čísla';

  @override
  String get numberTypeFontSize => 'Velikost písma typu čísla';

  @override
  String get numberTypePosition => 'Pozice typu čísla';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Váš správce zabezpečení hovorů je připraven, začněte si užívat zabezpečenou telefonickou komunikaci!';

  @override
  String get onboardingLanguageDescription =>
      'Vyberte si preferovaný jazyk pro nejlepší zážitek.';

  @override
  String get onboardingPermissionsDescription =>
      'Pro poskytování plných služeb potřebujeme následující oprávnění:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Jedno-klikové blokování spamových hovorů a zpráv, přizpůsobení pravidel blokování a poskytnutí klidného prostředí.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Automaticky identifikujte neznámé hovory, označte podezřelá čísla a chraňte bezpečnost vašich hovorů.';

  @override
  String get onboardingWelcomeDescription =>
      'Váš odborník na správu hovorů, poskytující komplexní služby identifikace a blokování hovorů.';

  @override
  String get oneDriveAuthDescription =>
      'Autorizujte pomocí klientského ID a klíče OneDrive nakonfigurovaného systémem';

  @override
  String get oneDriveAuthorizationHint =>
      'Autorizujte pomocí klientského ID a klíče OneDrive nakonfigurovaného systémem';

  @override
  String get oneDriveConfigTitle => 'Konfigurace OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'Konfigurace OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'Předplatné online identifikace volajícího';

  @override
  String get openAppSettings => 'Otevřít nastavení aplikace';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Nepodařilo se otevřít nastavení aplikace: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operace se nezdařila: $error';
  }

  @override
  String get operationFailure => 'Operace se nezdařila';

  @override
  String get operationSuccess => 'Operace byla úspěšná';

  @override
  String get other => 'Jiné';

  @override
  String get ourOtherApps => 'Naše další aplikace';

  @override
  String get overlayMode => 'Plovoucí okno';

  @override
  String get overlayModeDescription =>
      'Zobrazit informace o volajícím v plovoucím okně';

  @override
  String get overlayPermission => 'Povolení plovoucího okna';

  @override
  String get overlayPermissionDescription =>
      'Používá se k zobrazení překryvu příchozího hovoru.';

  @override
  String get overview => 'Přehled';

  @override
  String get password => 'Heslo';

  @override
  String get passwordCannotBeEmpty => 'Heslo nemůže být prázdné';

  @override
  String get passwordLabel => 'Heslo';

  @override
  String get passwordsDoNotMatch => 'Hesla se neshodují';

  @override
  String get passwordSetSuccessfully => 'Heslo bylo úspěšně nastaveno';

  @override
  String get pattern => 'Vzor';

  @override
  String get pendingSync => 'Čeká na synchronizaci';

  @override
  String get periodMonth => 'Měsíc';

  @override
  String get periodWeek => 'Týden';

  @override
  String get periodYear => 'Rok';

  @override
  String get permissionDenied => 'Žádost o oprávnění byla zamítnuta';

  @override
  String get permissionGranted => 'Oprávnění bylo uděleno';

  @override
  String get permissionManagement => 'Správa oprávnění';

  @override
  String get phoneCallsTab => 'Telefon';

  @override
  String get phoneNumber => 'Telefonní číslo';

  @override
  String get phoneNumberCannotBeEmpty => 'Telefonní číslo nemůže být prázdné';

  @override
  String get phoneNumberHint => 'Zadejte telefonní číslo';

  @override
  String get phoneNumberHintText =>
      'Zadejte telefonní číslo pro přidání pravidla';

  @override
  String get phoneNumberLabel => 'Telefonní číslo';

  @override
  String get phoneNumberRegexRequired =>
      'Zadejte prosím telefonní číslo i vzor regex';

  @override
  String get phoneNumberRequired => 'Telefonní číslo je vyžadováno';

  @override
  String get phoneNumberTypeFixedLine => 'Pevná linka';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Pevná linka nebo mobil';

  @override
  String get phoneNumberTypeMobile => 'Mobilní';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Osobní číslo';

  @override
  String get phoneNumberTypePremiumRate => 'Prémiová sazba';

  @override
  String get phoneNumberTypeSharedCost => 'Sdílené náklady';

  @override
  String get phoneNumberTypeTollFree => 'Bezplatné';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Neznámé';

  @override
  String get phoneNumberTypeVoicemail => 'Hlasová schránka';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Oprávnění k telefonu';

  @override
  String get phonePermissionDescription =>
      'Používá se k identifikaci a blokování příchozích hovorů.';

  @override
  String get phoneRule => 'Pravidlo pro telefon';

  @override
  String get phoneRuleEditDialog => 'Dialog pro úpravu pravidla pro telefon';

  @override
  String get phoneRuleManagement => 'Správa pravidel pro telefon';

  @override
  String get phoneRuleSubscription => 'Předplatné pravidel pro telefon';

  @override
  String get phoneSubscription => 'Předplatné telefonu';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Přihlaste se k odběru seznamů pravidel pro telefony přes URL a automaticky aktualizujte seznamy povolených a zakázaných pravidel. Podporuje soubory pravidel ve formátu JSON.';

  @override
  String get phoneSubscriptionTitle => 'Předplatná pravidel pro telefon';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Vyberte prosím popisek a zadejte platné telefonní číslo';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Zásuvný modul „$name“ byl úspěšně přidán';
  }

  @override
  String get pluginDeleted => 'Zásuvný modul byl odstraněn';

  @override
  String get pluginLatestVersion => 'Zásuvný modul je již nejnovější verze';

  @override
  String get pluginListExportSuccess =>
      'Seznam zásuvných modulů byl úspěšně exportován';

  @override
  String get pluginLoadedSuccessfully => 'Zásuvný modul byl úspěšně načten';

  @override
  String get pluginManagement => 'Správa zásuvných modulů';

  @override
  String get pluginManagementSubtitle =>
      'Spravujte a konfigurujte zásuvné moduly třetích stran';

  @override
  String get pluginManagementTitle => 'Správa zásuvných modulů';

  @override
  String get pluginName => 'Název zásuvného modulu';

  @override
  String get pluginNotLoaded =>
      'Zásuvný modul ještě není načten. Nejprve jej prosím načtěte.';

  @override
  String pluginsDeleted(Object count) {
    return '$count zásuvných modulů bylo úspěšně odstraněno.';
  }

  @override
  String get pluginService => 'Služba zásuvných modulů';

  @override
  String get pluginTestPageTitle => 'Test zásuvných modulů';

  @override
  String get pluginUpdateSuccess => 'Zásuvný modul byl úspěšně aktualizován';

  @override
  String get pluginUrl => 'URL zásuvného modulu';

  @override
  String get pluginUrlCannotBeEmpty =>
      'URL zásuvného modulu nemůže být prázdné';

  @override
  String get pluginUrlHint => 'Zadejte URL zásuvného modulu';

  @override
  String get pluginUrlLabel => 'URL zásuvného modulu';

  @override
  String get pluginVersion => 'Verze zásuvného modulu';

  @override
  String get political => 'Politické';

  @override
  String get powerfulSpamBlocking => 'Silné blokování spamu';

  @override
  String get previousStep => 'Předchozí';

  @override
  String get prioritizeRemoteAction => 'Upřednostnit nastavení vzdálených akcí';

  @override
  String get prioritizeRemoteActionDescription =>
      'Upřednostnit nastavení akcí ze vzdálené databáze';

  @override
  String get processing => 'Zpracovává se...';

  @override
  String get processingOperation => 'Zpracovává se...';

  @override
  String get purchase => 'Nákup';

  @override
  String get quarterlyMembership => 'Čtvrtletní členství';

  @override
  String get quarterlyMembershipDescription =>
      'Odemkněte všechny prémiové funkce, automatické obnovení čtvrtletně';

  @override
  String get queryButton => 'Dotaz';

  @override
  String get queryFailed => 'Dotaz selhal';

  @override
  String get queryFailedLog => 'Dotaz selhal';

  @override
  String get querying => 'Dotazuje se...';

  @override
  String get queryingPhoneNumber => 'Dotazuje se telefonní číslo';

  @override
  String get queryResultTitle => 'Výsledek dotazu';

  @override
  String get ready => 'Připraveno!';

  @override
  String get receiveWeeklyStatistics => 'Přijímat týdenní statistiky';

  @override
  String get recruiter => 'Náborář';

  @override
  String get reEnterPasswordHint => 'Znovu zadejte heslo';

  @override
  String get refresh => 'Obnovit';

  @override
  String get refreshPermissionStatus => 'Obnovit stav oprávnění';

  @override
  String get refreshTooltip => 'Obnovit';

  @override
  String regexError(Object error) {
    return 'Chyba regulárního výrazu: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Chyba regulárního výrazu: $error';
  }

  @override
  String get regexPattern => 'Vzor regulárního výrazu';

  @override
  String get regexPatternExplanation => 'Vysvětlení regulárního výrazu';

  @override
  String get regexPatternExplanationButton => 'Vysvětlení regulárního výrazu';

  @override
  String get regexPatternLabel => 'Vzor regulárního výrazu';

  @override
  String get regexPatternsExamples =>
      'Použijte standardní syntaxi regulárních výrazů k definování vzorů. Příklady:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Vzory regulárních výrazů pro shodu telefonních čísel';

  @override
  String get regexRule => 'Pravidlo regulárního výrazu';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Nepodařilo se přidat pravidlo regulárního výrazu: $error';
  }

  @override
  String get regexRuleAddSuccess =>
      'Pravidlo regulárního výrazu bylo úspěšně přidáno';

  @override
  String get regexRuleManagement => 'Správa pravidel regulárních výrazů';

  @override
  String get regexRuleNamePatternRequired =>
      'Název pravidla a vzor regulárního výrazu nemohou být prázdné';

  @override
  String get regexRules => 'Pravidla regulárních výrazů';

  @override
  String get regexTesterTitle => 'Tester regulárních výrazů';

  @override
  String regexValidationFailed(Object error) {
    return 'Validace regulárního výrazu selhala: $error';
  }

  @override
  String get regexValidationSuccess =>
      'Validace regulárního výrazu proběhla úspěšně';

  @override
  String get region => 'Region';

  @override
  String get registeredDevicesTitle => 'Registrovaná zařízení';

  @override
  String get rejectAllCalls => 'Odmítnout všechny hovory';

  @override
  String get rejectAllCallsDescription =>
      'Pokud je povoleno, všechny hovory budou odmítnuty s nejvyšší prioritou';

  @override
  String get rejectAllNumbers => 'Odmítnout všechna čísla';

  @override
  String get rejectAllNumbersDesc =>
      'Při povolení odmítnout všechny příchozí hovory';

  @override
  String get rejectExceededNumbers => 'Odmítnout překročená čísla';

  @override
  String get rejectExceededNumbersDescription =>
      'Automaticky odmítat čísla přesahující prahovou hodnotu počtu';

  @override
  String get remoteFilterSettings => 'Nastavení vzdáleného filtru';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Nastavení vzdáleného filtru čísel';

  @override
  String get remoteNumberFilter => 'Vzdálený filtr čísel';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Tento filtr používá nezávislou vzdálenou databázi k získání nejnovějších informací o číslech.';

  @override
  String get remoteNumberFilterDescription =>
      'Zachytávat obtěžující hovory na základě informací ze vzdálené databáze';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Vzdálený filtr čísel identifikuje a blokuje spamové hovory dotazováním vzdálené databáze na základě počtu čísel.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Vysvětlení vzdáleného filtru čísel';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Prahová hodnota počtu: Určete na základě frekvence výskytu čísla';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Akce filtru: Nakonfigurujte, jak nakládat s čísly přesahujícími prahovou hodnotu';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Nastavení priority: Nastavte prioritu pro vzdálené akce';

  @override
  String get remoteNumberFilterFeatures => 'Funkce:';

  @override
  String get remoteNumberFiltering => 'Vzdálené filtrování čísel';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Vzdálené filtrování čísel: Filtrační pravidla založená na informacích ze vzdálené databáze';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identifikujte spamové hovory pomocí cloudové databáze a komunitních hlášení';

  @override
  String get removeAdsDescription =>
      'Trvale odstraňte veškerou reklamu v aplikaci pro plynulejší zážitek';

  @override
  String get removeAdsTitle => 'Odstranit reklamy';

  @override
  String get removedFromFavoriteContacts => 'Odstraněno z oblíbených kontaktů';

  @override
  String get removedFromFavorites => 'Odstraněno z oblíbených';

  @override
  String get removeFavorite => 'Odstranit oblíbený';

  @override
  String get removeFromFavorites => 'Odstranit z oblíbených';

  @override
  String get renameButton => 'Přejmenovat';

  @override
  String get renameDeviceDialogTitle => 'Přejmenovat zařízení';

  @override
  String get renameDeviceTitle => 'Přejmenovat zařízení';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Toto nahradí všechna vaše aktuální nastavení. Jste si jisti, že chcete pokračovat?';

  @override
  String get requestAllPermissions => 'Požádat o všechna oprávnění';

  @override
  String get requestPermission => 'Požádat o oprávnění';

  @override
  String requestPermissionFailed(Object error) {
    return 'Nepodařilo se vyžádat oprávnění: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Značek';
  }

  @override
  String get reset => 'Resetovat';

  @override
  String get restore => 'Obnovit';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Obnovit nastavení aplikace ze zálohy';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Obnovit nastavení aplikace ze zálohy';

  @override
  String get restoreButton => 'Obnovit';

  @override
  String restoreFailedWithError(Object error) {
    return 'Obnovení z cloudu selhalo: $error';
  }

  @override
  String get restoreFromCloud => 'Obnovit z cloudu';

  @override
  String get restoreFromCloudDescription =>
      'Obnovit nastavení a pravidla z cloudového úložiště';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Nepodařilo se obnovit z cloudu: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Obnovit z cloudu';

  @override
  String get restoreFromCloudSuccess => 'Úspěšně obnoveno z cloudu';

  @override
  String get restoreFromCloudTitle => 'Obnovit z cloudu';

  @override
  String get restoreFromLocal => 'Obnovit z místního zdroje';

  @override
  String get restorePurchases => 'Obnovit nákupy';

  @override
  String get restoreSectionTitle => 'Obnovit';

  @override
  String get restoreSettings => 'Obnovit nastavení';

  @override
  String get restoreSettingsConfirmation =>
      'Toto nahradí všechna vaše aktuální nastavení. Jste si jisti, že chcete pokračovat?';

  @override
  String get restoreSettingsDialogTitle => 'Obnovit nastavení';

  @override
  String get restoreSettingsTitle => 'Obnovit nastavení';

  @override
  String get restoreSuccessFromLocal => 'Úspěšně obnoveno z místního zdroje';

  @override
  String get restoreSuccessMessage => 'Úspěšně obnoveno z cloudu';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get ridesharing => 'Sdílení jízd';

  @override
  String get risk => 'Riziko';

  @override
  String get robocall => 'Robohovor';

  @override
  String get ruleAction => 'Akce pravidla';

  @override
  String get ruleAddButton => 'Přidat pravidlo';

  @override
  String get ruleAddedSuccess => 'Pravidlo bylo přidáno úspěšně';

  @override
  String ruleAddFailure(Object error) {
    return 'Nepodařilo se přidat pravidlo: $error';
  }

  @override
  String get ruleAddSuccess => 'Pravidlo bylo přidáno úspěšně';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Jste si jisti, že chcete smazat tento $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Smazat pravidlo';

  @override
  String get ruleDeletedSuccess => 'Pravidlo bylo úspěšně smazáno';

  @override
  String get ruleDeletedSuccessfully => 'Pravidlo bylo úspěšně smazáno';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Nepodařilo se smazat pravidlo: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Nepodařilo se smazat pravidlo: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Pravidlo bylo úspěšně smazáno';

  @override
  String get ruleDisabledSuccessfully => 'Pravidlo bylo úspěšně zakázáno';

  @override
  String get ruleEnabledSuccessfully => 'Pravidlo bylo úspěšně povoleno';

  @override
  String ruleLoadFailed(Object error) {
    return 'Nepodařilo se načíst pravidla: $error';
  }

  @override
  String get ruleManagement => 'Správa pravidel';

  @override
  String get ruleManagementTitle => 'Správa pravidel';

  @override
  String get ruleName => 'Název pravidla';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Název pravidla a regulární výraz obsahu nemohou být prázdné';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Název pravidla a telefonní číslo nemohou být prázdné';

  @override
  String get ruleNameHint => 'např. Rodina, Přátelé atd.';

  @override
  String get ruleNameLabel => 'Název pravidla';

  @override
  String get ruleNamePatternRequired => 'Zadejte název pravidla a vzor';

  @override
  String get ruleNameRequired =>
      'Název pravidla a telefonní číslo nemohou být prázdné';

  @override
  String get ruleNotExist => 'Pravidlo neexistuje nebo bylo smazáno';

  @override
  String ruleNotFound(Object error) {
    return 'Pravidlo nenalezeno: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Pravidlo bylo úspěšně uloženo!';

  @override
  String get ruleSavedSuccessMessage => 'Pravidlo bylo úspěšně uloženo!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Uložení selhalo: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Uložení selhalo: $error';
  }

  @override
  String get ruleSaveSuccess => 'Pravidlo bylo úspěšně uloženo!';

  @override
  String get rulesExportedSuccessfully => 'Pravidla byla úspěšně exportována';

  @override
  String rulesExportedTo(Object path) {
    return 'Pravidla byla exportována do: $path';
  }

  @override
  String get rulesImported => 'Pravidla byla úspěšně importována';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count pravidel bylo úspěšně importováno';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Nepodařilo se importovat pravidla: $error';
  }

  @override
  String get ruleStatistics => 'Statistiky pravidel';

  @override
  String ruleStatusChanged(Object status) {
    return 'Pravidlo bylo úspěšně $status';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operace selhala: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Pravidlo bylo úspěšně $status';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Nepodařilo se aktualizovat pravidlo: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Pravidlo bylo úspěšně aktualizováno';

  @override
  String get ruleVerification => 'Ověření pravidla';

  @override
  String get save => 'Uložit';

  @override
  String get saveButton => 'Uložit';

  @override
  String get saveButtonLabel => 'ULOŽIT';

  @override
  String get saveButtonText => 'Uložit';

  @override
  String saveFailed(Object error) {
    return 'Uložení selhalo: $error';
  }

  @override
  String get saveFilter => 'Uložit filtr';

  @override
  String get saveSettings => 'Uložit nastavení';

  @override
  String saveSettingsFailed(Object error) {
    return 'Nepodařilo se uložit nastavení: $error';
  }

  @override
  String get scamsLikely => 'Pravděpodobně podvod';

  @override
  String get search => 'Hledat';

  @override
  String get searchContacts => 'Vyhledat kontakty';

  @override
  String searchError(Object error) {
    return 'Chyba vyhledávání: $error';
  }

  @override
  String get searchFilters => 'Filtry vyhledávání';

  @override
  String get searchForContacts => 'Hledat kontakty';

  @override
  String get searchHint => 'Hledat...';

  @override
  String get searchSettingsSubtitle =>
      'Vyhledávat kontakty, štítky, blokované seznamy, povolené seznamy atd.';

  @override
  String get searchSettingsTitle => 'Nastavení vyhledávání';

  @override
  String get securityMessage =>
      'Nevěřte žádným telefonním hovorům. Čísla zákaznických služeb si vždy ověřujte nezávisle. Nikdy nesdílejte hesla, ověřovací kódy, čísla karet ani osobní údaje.';

  @override
  String get selectActionToPerform =>
      'Vyberte akci, kterou chcete provést, když pravidlo odpovídá';

  @override
  String get selectActionWhenBlockingCalls =>
      'Vyberte akci při blokování hovorů';

  @override
  String get selectActionWhenRuleMatches =>
      'Vyberte akci, když pravidlo odpovídá';

  @override
  String get selectAll => 'Vybrat vše';

  @override
  String get selectCountry => 'Vybrat zemi';

  @override
  String get selectDateRange => 'Vybrat časové období';

  @override
  String get selectedDateRange => 'Vybrané časové období';

  @override
  String selectedItems(Object count) {
    return 'Vybráno $count položek';
  }

  @override
  String get selectedLabel => 'Vybráno:';

  @override
  String get selectExportFormat => 'Vybrat formát exportu';

  @override
  String get selectLabel => 'Vybrat štítek';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Vyberte prosím štítek a zadejte platné telefonní číslo';

  @override
  String get selectLanguage => 'Vybrat jazyk';

  @override
  String get selectMultiple => 'Vybrat více';

  @override
  String get selectPeriod => 'Vybrat období';

  @override
  String get selectSimCard => 'Vybrat SIM kartu';

  @override
  String get selectSimSlot => 'Vybrat slot SIM';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Vyberte konkrétní akci pro blokované hovory';

  @override
  String get selectTag => 'Vybrat značku';

  @override
  String get selectTags => 'Vybrat značky';

  @override
  String get selectTrustedDataSource => 'Vyberte důvěryhodné zdroje dat';

  @override
  String get selectYourLanguage => 'Vybrat svůj jazyk';

  @override
  String get sender => 'Odesílatel';

  @override
  String get senderRegexOptional => 'Odesílatel Regex (volitelné)';

  @override
  String get serverAddressLabel => 'Adresa serveru';

  @override
  String get serviceTypeContact => 'Předplatné kontaktu';

  @override
  String get serviceTypeLabel => 'Typ služby';

  @override
  String get serviceTypePhone => 'Předplatné telefonu';

  @override
  String get serviceTypePlugin => 'Aktualizace zásuvného modulu';

  @override
  String get serviceTypeSms => 'Předplatné SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Nastavit';

  @override
  String get setEncryptionPassword => 'Nastavit heslo pro šifrování';

  @override
  String get setEncryptionPasswordDescription =>
      'Nastavte heslo pro šifrování pro zálohování a obnovení';

  @override
  String get setEncryptionPasswordLabel => 'Nastavit heslo pro šifrování';

  @override
  String get setEncryptionPasswordTitle => 'Nastavit heslo pro šifrování';

  @override
  String get setPasswordButton => 'Nastavit';

  @override
  String get settings => 'Nastavení';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Nastavení zálohováno do: $path';
  }

  @override
  String get settingsLoaded => 'Nastavení načteno';

  @override
  String settingsLoadFailed(Object error) {
    return 'Nepodařilo se načíst nastavení: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Nastavení bylo úspěšně obnoveno. Restartujte prosím aplikaci, aby se změny projevily.';

  @override
  String get settingsSaved => 'Nastavení uloženo';

  @override
  String settingsSaveFailed(Object error) {
    return 'Nepodařilo se uložit nastavení: $error';
  }

  @override
  String get settingsTab => 'Nastavení';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get setup => 'Nastavení';

  @override
  String get showContactEditDialogStaticMethod =>
      'Statická metoda pro zobrazení dialogového okna pro úpravu kontaktu';

  @override
  String get showExplanation => 'Zobrazit vysvětlení';

  @override
  String get silence => 'Ticho';

  @override
  String get silenceAndNoAnswer => 'Ticho a žádná odpověď';

  @override
  String get silenceNoAnswer => 'Ticho bez odpovědi';

  @override
  String get silentCallVoiceClone => 'Tichý telefonní klon hlasu';

  @override
  String get silentRules => 'Tichá pravidla';

  @override
  String simCard(Object simNumber) {
    return 'SIM karta $simNumber';
  }

  @override
  String get simCardColor => 'Barva SIM karty';

  @override
  String get simCardConfigurationExplanation =>
      '• Konfigurace SIM karty: Nastavte nezávislá pravidla filtrování pro každou SIM kartu';

  @override
  String get simCardFilterRules => 'Pravidla filtrování SIM karty';

  @override
  String get simCardFilterRulesDescription =>
      'Nastavte různá pravidla filtrování na základě slotů SIM karty';

  @override
  String get simCardFontSize => 'Velikost písma SIM karty';

  @override
  String get simCardPosition => 'Pozice SIM karty';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Nepodařilo se načíst informace o SIM kartě: $error';
  }

  @override
  String get simRuleInstructions =>
      'Pravidla pro sloty SIM vám umožňují konfigurovat nezávislá pravidla filtrování pro každý slot SIM.';

  @override
  String get simRuleInstructionsTitle => 'Pravidla slotů SIM';

  @override
  String get simRuleManagement => 'Správa pravidel slotů SIM';

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
    return 'Nepodařilo se načíst data SIM: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'Konfigurace filtru slotu SIM';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Umožňuje nastavit pravidla filtrování podle slotu SIM';

  @override
  String get simSlotFilterDescription =>
      'Konfigurujte nezávislá pravidla filtrování pro každou SIM kartu:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Nastavení filtru slotu SIM $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Nepodařilo se načíst sloty SIM: $error';
  }

  @override
  String get simSlotManagement => 'Správa slotů SIM';

  @override
  String simSlotOperationFailed(Object error) {
    return 'Operace se slotem SIM se nezdařila: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Pozice slotu SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Pravidla slotů SIM: Nezávislé strategie filtrování na SIM';

  @override
  String get simSlotRuleListTitle => 'Seznam pravidel slotů SIM';

  @override
  String get simSlotRuleManagement => 'Pravidla slotů SIM';

  @override
  String get simSlotRuleManagementTitle => 'Správa pravidel';

  @override
  String get simSlotSettings => 'Nastavení slotu SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Slot SIM $slotNumber';
  }

  @override
  String get skip => 'Přeskočit';

  @override
  String get smartCallerId => 'Chytrá identifikace volajícího';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Filtrování SMS vám pomůže automaticky filtrovat spamové zprávy a udržovat váš seznam zpráv čistý. Můžete nastavit pravidla filtrování a metody upozornění.';

  @override
  String get smsFilterDisabled => 'Filtrování SMS zakázáno';

  @override
  String get smsFilterEnabled => 'Filtrování SMS povoleno';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Pravidlo filtru SMS bylo úspěšně přidáno';

  @override
  String get smsFilterRules => 'Pravidla filtru SMS';

  @override
  String get smsFilterSettings => 'Nastavení filtru SMS';

  @override
  String get smsHistory => 'Historie SMS';

  @override
  String get smsManagement => 'Správa SMS';

  @override
  String get smsPermission => 'Povolení SMS';

  @override
  String get smsPermissionDescription =>
      'Používá se k filtrování spamových zpráv.';

  @override
  String get smsRuleAddedSuccessfully => 'Pravidlo SMS bylo úspěšně přidáno';

  @override
  String get smsRuleDeletedSuccessfully => 'Pravidlo SMS bylo úspěšně smazáno';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Nepodařilo se načíst pravidla SMS: $error';
  }

  @override
  String get smsRuleManagement => 'Správa pravidel SMS';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'Pravidla SMS byla úspěšně exportována do $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'Pravidla SMS byla úspěšně importována';

  @override
  String get smsRuleSubscription => 'Předplatné pravidel SMS';

  @override
  String get smsRuleUpdatedSuccessfully =>
      'Pravidlo SMS bylo úspěšně aktualizováno';

  @override
  String get smsSettingsSubtitle => 'Filtrování SMS a blokování klíčových slov';

  @override
  String get smsSettingsTitle => 'Nastavení SMS';

  @override
  String get smsSubscription => 'Předplatné SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Předplatné SMS bylo úspěšně přidáno';

  @override
  String get smsSubscriptionRulesDescription =>
      'Přihlaste se k odběru seznamů pravidel SMS prostřednictvím URL, podporuje shodu s regulárními výrazy. Můžete nastavit akce blokování nebo povolení.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied =>
      'Některé žádosti o povolení byly zamítnuty';

  @override
  String get spamLikely => 'Pravděpodobně spam';

  @override
  String get startColor => 'Počáteční barva';

  @override
  String get startDate => 'Počáteční datum';

  @override
  String get startUsing => 'Začít používat';

  @override
  String get statAnswered => 'Odpovězeno';

  @override
  String get statBlocked => 'Blokováno';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Statická metoda pro zobrazení dialogu s informacemi o volajícím';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Statická metoda pro zobrazení dialogu pro výběr země';

  @override
  String get staticMethodToDisplayDialog =>
      'Statická metoda pro zobrazení dialogu';

  @override
  String get statistics => 'Statistiky';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Funkce exportu statistik bude brzy k dispozici';

  @override
  String get statisticsGrid => 'Mřížka statistik';

  @override
  String get statisticsPageTitle => 'Analýza dat';

  @override
  String get stirColor => 'Barva STIR';

  @override
  String get stirFontSize => 'Velikost písma STIR';

  @override
  String get stirPosition => 'Pozice STIR';

  @override
  String get storagePermission => 'Povolení úložiště';

  @override
  String get storagePermissionDescription =>
      'Používá se k ukládání nastavení a pravidel.';

  @override
  String get subscribe => 'Přihlásit se k odběru';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Předplatné \"$name\" bylo úspěšně přidáno';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Opravdu chcete toto předplatné smazat?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Smazat předplatné';

  @override
  String get subscriptionDeleted => 'Předplatné smazáno';

  @override
  String get subscriptionDeletedSuccessfully =>
      'Předplatné bylo úspěšně smazáno';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Nepodařilo se smazat předplatné: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Předplatné smazáno';

  @override
  String get subscriptionEmptyState => 'Žádná předplatná nejsou k dispozici';

  @override
  String get subscriptionEmptyText => 'Zatím žádná předplatná';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Nepodařilo se načíst předplatná: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Nepodařilo se načíst předplatná: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Správa předplatného';

  @override
  String get subscriptionName => 'Název předplatného';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Název a URL předplatného nemohou být prázdné';

  @override
  String get subscriptionNameHint => 'Zadejte název předplatného';

  @override
  String get subscriptionPageTitle => 'Správa předplatného';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Nepodařilo se změnit stav předplatného: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Nepodařilo se přepnout stav předplatného: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Nepodařilo se aktualizovat předplatné: $error';
  }

  @override
  String get subscriptionUpdateSuccess =>
      'Předplatné bylo úspěšně aktualizováno';

  @override
  String get subscriptionUrl => 'URL předplatného';

  @override
  String get subscriptionUrlHint => 'Zadejte URL předplatného';

  @override
  String successfullyImportedRules(Object count) {
    return 'Úspěšně importováno $count pravidel';
  }

  @override
  String get supportSync => 'Podpora synchronizace';

  @override
  String get survey => 'Průzkum';

  @override
  String get syncDevicesButton => 'Synchronizovat zařízení';

  @override
  String get syncFailed => 'Synchronizace selhala';

  @override
  String get syncFailedMessage => 'Synchronizace selhala';

  @override
  String get syncFolderNameHint =>
      'Zadejte název složky pro synchronizaci (výchozí: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Název složky pro synchronizaci';

  @override
  String get synchronized => 'Synchronizováno';

  @override
  String get syncing => 'Synchronizuje se...';

  @override
  String get syncNow => 'Synchronizovat nyní';

  @override
  String get syncNowButton => 'Synchronizovat nyní';

  @override
  String get syncStatusTitle => 'Stav synchronizace';

  @override
  String get syncStatusUpdatedMessage => 'Stav synchronizace byl aktualizován';

  @override
  String get syncSuccessful => 'Synchronizace úspěšná';

  @override
  String get syncSuccessMessage => 'Synchronizace úspěšná';

  @override
  String get syncWithCloudStorage => 'Synchronizovat s cloudovým úložištěm';

  @override
  String get syncWithCloudStorageSubtitle =>
      'Synchronizovat s cloudovým úložištěm';

  @override
  String get systemFeatures => 'Systémové funkce:';

  @override
  String get systemSettingsTitle => 'Nastavení systému';

  @override
  String get tabAll => 'Vše';

  @override
  String get tabAnswered => 'Odpovězeno';

  @override
  String get tabBlocked => 'Blokováno';

  @override
  String get tabMissed => 'Zmeškano';

  @override
  String get tabOutgoing => 'Odchozí';

  @override
  String tagLabel(String tag) {
    return 'Štítek: $tag';
  }

  @override
  String get tagsUpdated => 'Štítky aktualizovány';

  @override
  String get takeaway => 'S sebou';

  @override
  String get telecommunication => 'Telekomunikace';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get testConnectionButton => 'Otestovat připojení';

  @override
  String get textColorsSetting => 'Barvy textu a štítků';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Tato aplikace je výkonný nástroj pro identifikaci volajícího, který vám umožňuje identifikovat a blokovat nechtěná volání.';

  @override
  String get thisWeek => 'Tento týden';

  @override
  String get timeInterceptor => 'Časový zachycovač';

  @override
  String get timeInterceptorDescription =>
      'Automaticky zachytávat/povolovat potenciální volání na základě frekvence volání';

  @override
  String get timeInterceptorExplanation =>
      '• Časový zachycovač: Zachytávat/povolovat opakovaná volání v krátkém časovém období';

  @override
  String get timeInterceptorExplanationContent =>
      'Funkce zachycování frekvence volání analyzuje frekvenci volání k automatické identifikaci a zachycení/povolení častých spamových volání.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Vysvětlení zachycování frekvence volání';

  @override
  String get timeInterceptorSettingsTitle =>
      'Nastavení zachycování frekvence volání';

  @override
  String get timeInterceptorSubtitle =>
      'Automaticky zachytávat potenciální spamová volání na základě frekvence volání';

  @override
  String get timeInterceptorTitle => 'Povolit zachycování frekvence volání';

  @override
  String get timeWindowDescription =>
      'Nastavte velikost časového okna pro povolování opakovaných volání. Volání ze stejného čísla v tomto okně budou povolena';

  @override
  String timeWindowLabel(int minutes) {
    return 'Časové okno pro zachycení (minuty): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Nastavte velikost časového okna pro povolování opakovaných volání. Volání ze stejného čísla v tomto okně budou povolena';

  @override
  String get today => 'Dnes';

  @override
  String get total => 'Celkem';

  @override
  String get totalBlocked => 'Celkem zablokováno';

  @override
  String get totalFiltered => 'Celkem filtrováno';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Přenos dat mezi zařízeními nebo platformami';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Přenos dat mezi zařízeními nebo platformami';

  @override
  String get travelTicketing => 'Cestovní jízdenky';

  @override
  String get trend => 'Trend';

  @override
  String get trendChart => 'Graf trendu';

  @override
  String get tutorial => 'Návod';

  @override
  String get type => 'Typ';

  @override
  String get unassignedSIMCard => 'Nepřiřazená SIM karta';

  @override
  String get unknown => 'Neznámé';

  @override
  String get unknownLabel => 'Neznámý štítek';

  @override
  String get unknownTag => 'Štítek: Neznámý';

  @override
  String get unregisterButton => 'Odhlásit registraci';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Opravdu chcete odhlásit registraci zařízení $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Odhlásit registraci zařízení';

  @override
  String get unsupportedFileFormat => 'Nepodporovaný formát souboru';

  @override
  String get update => 'Aktualizovat';

  @override
  String get updateAllNow => 'Aktualizovat vše nyní';

  @override
  String get updateCallFilterConfig => 'Aktualizovat konfiguraci filtru hovorů';

  @override
  String updateContactFailed(Object error) {
    return 'Nepodařilo se aktualizovat kontakt: $error';
  }

  @override
  String get updateFavoriteStatus => 'Aktualizovat stav oblíbených položek';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Nepodařilo se aktualizovat stav oblíbených položek: $error';
  }

  @override
  String get updateInterval => 'Interval aktualizace';

  @override
  String get updateLabelFailed => 'Nepodařilo se aktualizovat štítek';

  @override
  String get updateNow => 'Aktualizovat nyní';

  @override
  String get updatePlugin => 'Aktualizovat modul';

  @override
  String updatePluginFailed(Object error) {
    return 'Nepodařilo se aktualizovat modul: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Nepodařilo se aktualizovat pravidlo: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Nepodařilo se aktualizovat předplatné: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service úspěšně aktualizováno ($count pravidel)';
  }

  @override
  String get updateTags => 'Aktualizovat štítky';

  @override
  String get useCasesPoint1 =>
      '• Identifikovat spamová volání s automatickým opakovaným vytáčením';

  @override
  String get useCasesPoint2 =>
      '• Zachytávat marketingová volání, která volají vícekrát v krátkém období';

  @override
  String get useCasesPoint3 => '• Předcházet telefonním bombám a obtěžování';

  @override
  String get useCasesTitle => 'Případy použití:';

  @override
  String get useGlobalSettings => 'Použít globální nastavení';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Uživatelské jméno';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Použijte standardní syntaxi regulárních výrazů k definování vzorů. Příklady:';

  @override
  String get validateRegex => 'Ověřit regulární výraz';

  @override
  String get verificationFailedText => 'Selhalo';

  @override
  String get verifiedText => 'Ověřeno';

  @override
  String get verify => 'Ověřit';

  @override
  String version(Object version) {
    return 'Verze: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Vyměňte VIP členství za počty označení telefonního čísla';

  @override
  String get vipExchangeTitle => 'Vyměnit VIP značky';

  @override
  String get watchAd => 'Sledovat reklamu';

  @override
  String get watchAdForTemp => 'Sledovat reklamu pro dočasné privilegium';

  @override
  String get watchAdForTempDescription =>
      'Sledujte krátkou reklamu a dočasně odemkněte některé prémiové funkce';

  @override
  String get webDAVConfigTitle => 'Konfigurace WebDAV';

  @override
  String get webdavConfigurationTitle => 'Konfigurace WebDAV';

  @override
  String get webdavPasswordHint => 'Zadejte prosím heslo WebDAV';

  @override
  String get webdavServerAddressHint => 'Zadejte prosím adresu serveru WebDAV';

  @override
  String get webdavUsernameHint => 'Zadejte prosím uživatelské jméno WebDAV';

  @override
  String get week => 'Týden';

  @override
  String get weekly => 'Týdenní';

  @override
  String get weeklyBlockedCallsSummary => 'Souhrn týdenních blokovaných hovorů';

  @override
  String get weeklyChartTitle => 'Týdenní blokované hovory';

  @override
  String get weeklyReport => 'Týdenní zpráva';

  @override
  String get weeklyReportDesc =>
      'Obdržíte týdenní souhrnnou zprávu o aktivitě blokování hovorů';

  @override
  String get welcome => 'Vítejte';

  @override
  String get whitelist => 'Seznam povolených';

  @override
  String get whitelistLabel => 'Seznam povolených';

  @override
  String get width => 'Šířka';

  @override
  String get wildcardMatchingDescription =>
      'Použijte \'.\' k nahrazení libovolného znaku (např. \'123.456\' odpovídá 123-456)';

  @override
  String get wildcardMatchingTitle => 'Porovnání s divokou kartou:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Podpora divokých karet pro flexibilní filtrování';

  @override
  String get windowSizeSetting => 'Velikost okna';

  @override
  String get year => 'Rok';

  @override
  String get yearly => 'Ročně';

  @override
  String get yearlyChartTitle => 'Roční zablokovaná volání';

  @override
  String get noSimCardsDetected => 'Nebyly detekovány žádné SIM karty';

  @override
  String get filterManagementDescription => 'Nastavit filtry hovorů';

  @override
  String get callerIdCustomizationSubtitle =>
      'Přizpůsobit rozložení ID volajícího';

  @override
  String get fraudAlerSettingTitle => 'Nastavení upozornění na podvod';

  @override
  String get fraudAlerSettingSubtitle => 'Nastavit upozornění na podvod';

  @override
  String get enableFraudAlert => 'Povolit upozornění na podvod';

  @override
  String get enableFraudAlertDescription =>
      'Upozornění na podezřelé podvodné hovory';

  @override
  String get enableVibration => 'Povolit vibrace';

  @override
  String get enableVibrationDescription =>
      'Vibrovat, když jsou hovory podezřelé podvodné hovory';

  @override
  String get notificationSettingsTitle => 'Nastavení upozornění';

  @override
  String get useLocalNotification => 'Použít místní upozornění';

  @override
  String get useLocalNotificationDescription =>
      'Povolit místní upozornění na příchozí hovory';

  @override
  String get cancelLocalNotification => 'Zavřít místní upozornění';

  @override
  String get useStirNotification => 'Použít upozornění z STIR';

  @override
  String get useStirNotificationDescription =>
      'Povolit upozornění STIR pro příchozí hovory';

  @override
  String get cancelLocalNotificationDescription =>
      'Automaticky zavřít místní upozornění';

  @override
  String get callerIdSettingsTitle => 'Nastavení ID volajícího';

  @override
  String get callerIdSettingsSubtitle =>
      'Nastavit upozornění na příchozí hovory a režim zobrazení';

  @override
  String get purchaseTitle => 'Nákup';

  @override
  String get purchaseSubtitle => 'Zakoupit službu';

  @override
  String get callerIdNotificationTitle => 'Informace o příchozím hovoru';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Číslo: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Zablokované volání';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Zablokované volání z $phoneNumber';
  }

  @override
  String get stirVerified => 'Ověřeno';

  @override
  String get stirNotVerified => 'Neověřeno';

  @override
  String get stirFailed => 'Ověření selhalo';

  @override
  String get stirUnknown => 'Neznámý stav ověření';

  @override
  String get stirVerificationTitle => 'Ověření STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage pro číslo $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Nastavení posuvných bezpečnostních zpráv';

  @override
  String get messageColor => 'Barva zprávy';

  @override
  String get messageFontSize => 'Velikost písma zprávy';

  @override
  String get messagePosition => 'Pozice zprávy';

  @override
  String get containerWidth => 'Šířka kontejneru';

  @override
  String get scrollSpeed => 'Rychlost posouvání';

  @override
  String get enableSecurityMessage => 'Povolit bezpečnostní zprávu';

  @override
  String get fraudAlertTitle => 'Upozornění na podvod';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Potenciální podvodný hovor z $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Nepodařilo se načíst pravidla: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Nepodařilo se načíst historii volání: $error';
  }

  @override
  String get noBlockedTypeData =>
      'Žádná data typu blokovaného hovoru nejsou k dispozici';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importovat $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName úspěšně importováno, celkem importováno $count záznamů';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Nepodařilo se importovat $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Exportovat $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName úspěšně exportováno';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Nepodařilo se exportovat $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Cloudová synchronizační služba';

  @override
  String get membershipCenter => 'Centrum členství';

  @override
  String get redeemVipWithMarks => 'Vykoupit VIP za body';

  @override
  String get currentMarkCount => 'Aktuální počet bodů';

  @override
  String get markMoreNumbersForMore =>
      'Označte více čísel pro získání více bodů';

  @override
  String get noAds => 'Žádné reklamy';

  @override
  String get cloudBackup => 'Záloha v cloudu';

  @override
  String get callerIdEnhancement => 'Vylepšení ID volajícího';

  @override
  String get voiceRecognition => 'Rozpoznávání hlasu';

  @override
  String get feature => 'Funkce';

  @override
  String get normalUser => 'Běžný uživatel';

  @override
  String get vipUser => 'VIP uživatel';

  @override
  String get temporaryVip => 'Dočasný VIP';

  @override
  String get removeAds => 'Odstranit reklamy';

  @override
  String get unknownAction => 'Neznámá akce';

  @override
  String get settingsBackup => 'Záloha nastavení ';

  @override
  String get allServicesStatusTitle => 'Aktuální stav služeb';

  @override
  String get allServicesStatusSubtitle => 'Aktuální stav každé cloudové služby';

  @override
  String get redirect => 'Přesměrovat';

  @override
  String get notify => 'Upozornit';

  @override
  String get log => 'Záznam';

  @override
  String get custom => 'Vlastní';

  @override
  String get allowActionDescription =>
      'Hovory budou povoleny, i když je číslo na seznamu blokovaných.';

  @override
  String get blockActionDescription =>
      'Hovory budou zablokovány a zobrazeny v historii volání.';

  @override
  String get silenceActionDescription =>
      'Hovory budou umlčeny, ale zobrazeny v historii volání.';

  @override
  String get noneActionDescription =>
      'Pro hovor nebudou provedeny žádné speciální akce.';

  @override
  String get redirectActionDescription => 'Přesměrovat hovor na zadané číslo.';

  @override
  String get labelActionDescription =>
      'Přidat k hovoru popisek pro snadnou identifikaci.';

  @override
  String get notifyActionDescription =>
      'Odeslat upozornění při přijetí hovoru.';

  @override
  String get logActionDescription =>
      'Zaznamenat informace o hovoru bez provedení jakékoli jiné akce.';

  @override
  String get customActionDescription => 'Provést vlastní akci.';

  @override
  String get synced => 'Synchronizováno';

  @override
  String get needVipAccess => 'K použití této funkce potřebujete VIP přístup';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importovat nebo exportovat data $entityTypeName';
  }

  @override
  String get importExportTitle => 'Import/Export';

  @override
  String get noPhoneRules => 'Nenalezeny žádná telefonní pravidla';

  @override
  String get noRegexRules => 'Nenalezena žádná pravidla regulárních výrazů';

  @override
  String get noAllowedBlockedRules =>
      'Nenalezena žádná povolená/zablokovaná pravidla';

  @override
  String get importExport => 'Import/Export';

  @override
  String get filterByAction => 'Filtrovat podle akce';

  @override
  String get upgradeToVip => 'Upgradovat na VIP';

  @override
  String get batteryOptimizationPermission => 'Optimalizace baterie';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Umožněte aplikaci běžet na pozadí a poskytovat služby, jako je identifikace volajícího.';

  @override
  String get permissionTitle => 'Speciální oprávnění';

  @override
  String get permissionSubtitle =>
      'Spravovat oprávnění pro překryvná okna a optimalizaci baterie';

  @override
  String get themeSettingsTitle => 'Nastavení motivu';

  @override
  String get themeSettingsSubtitle => 'Vyberte si svůj oblíbený motiv';

  @override
  String get databaseSyncTitle => 'Synchronizace databáze';

  @override
  String get countrySyncSettingsTitle =>
      'Nastavení synchronizace databáze podle země';

  @override
  String get countrySyncSettingsSubtitle =>
      'Vyberte země pro synchronizaci dat';

  @override
  String get countryDataDisclaimer =>
      'Upozornění: Databáze nemusí obsahovat data pro všechny konkrétní země nebo regiony.';

  @override
  String get editSubscription => 'Upravit předplatné';

  @override
  String get searchByNameOrPhoneNumber =>
      'Hledat podle jména nebo telefonního čísla';

  @override
  String get allowedBlockedRulesInfo =>
      'Pravidla povolených/blokovaných čísel se používají k přiřazení hovorů konkrétním telefonním číslům, která mají nejvyšší prioritu.';

  @override
  String get searchPhoneRulesHint => 'Hledat telefonní pravidla';

  @override
  String get phoneRulesInfo =>
      'Telefonní pravidla se používají k přiřazení hovorů konkrétním telefonním číslům, která mají nižší prioritu. Některá pocházejí z předplatného telefonních pravidel';

  @override
  String get searchSubscriptionsHint => 'Hledat předplatná';

  @override
  String get searchPluginsHint => 'Hledat pluginy';

  @override
  String get searchLabelsHint => 'Hledat štítky';

  @override
  String get pluginDescription => 'Popis pluginu';

  @override
  String get enterPluginDescription => 'Zadejte popis pluginu';

  @override
  String get searchRegexRulesHint => 'Hledat pravidla regulárních výrazů';

  @override
  String get regexRulesInfo =>
      'Pravidla regulárních výrazů se používají k filtrování hovorů na základě vzorů regulárních výrazů.';

  @override
  String get searchMarkedPhonesHint => 'Hledat označená čísla';

  @override
  String get searchContactSubscriptionsHint => 'Hledat předplatná kontaktů';

  @override
  String get showAllContacts => 'Zobrazit všechny kontakty';

  @override
  String get showFavorites => 'Zobrazit oblíbené';

  @override
  String get manualEntry => 'Informace o ručním zadání';

  @override
  String get scriptSaved => 'Skript uložen';

  @override
  String editScriptFor(String pluginName) {
    return 'Upravit skript pro $pluginName';
  }

  @override
  String get saveScript => 'Uložit skript';

  @override
  String get testPlugin => 'Testovat plugin';

  @override
  String get description => 'Popis';

  @override
  String get accessTargetUrl => 'Přístup k cílové adrese URL';

  @override
  String get result => 'Výsledek';

  @override
  String get editScript => 'Upravit skript';

  @override
  String get numberFormat => 'Formát čísla';

  @override
  String get nationalNumber => 'Národní číslo';

  @override
  String get e164Number => 'Číslo E.164';

  @override
  String get pluginRulesInfo =>
      'Z bezpečnostních důvodů používejte pluginy pouze z důvěryhodných zdrojů. Neváhejte použít naše šablony k vytvoření vlastních pluginů!';

  @override
  String get advancedMode => 'Pokročilý režim';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Zadejte prosím alespoň jedno číslo.';

  @override
  String get openInWebView => 'Otevřít ve webovém prohlížeči';

  @override
  String get pluginLabel => 'Štítek pluginu';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Barva pozadí zprávy';

  @override
  String get clearAllCallLogs => 'Vymazat všechny protokoly hovorů';

  @override
  String get clearAllCallLogsConfirmation =>
      'Potvrdit vymazání všech protokolů hovorů';

  @override
  String get allCallLogsCleared => 'Všechny protokoly hovorů vymazány';

  @override
  String get unblocked => 'Odblokováno';

  @override
  String get blockNumber => 'Blokovat číslo';

  @override
  String get blockNumberSuccess => 'Číslo úspěšně zablokováno';

  @override
  String get blockNumberFailed => 'Blokování čísla selhalo';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Opravdu chcete odblokovat číslo $phoneNumber?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Volám na číslo $phoneNumber...';
  }

  @override
  String get viewDetails => 'Zobrazit podrobnosti';

  @override
  String get unblock => 'Odblokovat';

  @override
  String get unblockNumber => 'Odblokovat číslo';

  @override
  String get unblockNumberSuccess => 'Číslo úspěšně odblokováno';

  @override
  String get unblockNumberFailed => 'Odblokování čísla selhalo';

  @override
  String get serviceNotAvailable => 'Služba není dostupná';

  @override
  String get callingNumberFailed => 'Volání čísla selhalo';

  @override
  String get listView => 'Zobrazení seznamu';

  @override
  String get timelineView => 'Časová osa';

  @override
  String get nameCannotBeEmpty => 'Jméno nemůže být prázdné';

  @override
  String get selectAction => 'Vyberte akci';

  @override
  String get selectTargetService => 'Vyberte cílovou službu';

  @override
  String get callDetails => 'Podrobnosti o hovoru';

  @override
  String get callType => 'Typ hovoru';

  @override
  String get callTime => 'Čas hovoru';

  @override
  String get numberInvalidFormat => 'Neplatný formát čísla';

  @override
  String get membershipFeature => 'Funkce členství';

  @override
  String get medium => 'Médium';

  @override
  String get verificationReport => 'Zpráva o ověření';

  @override
  String get finalRisk => 'Konečné riziko';

  @override
  String get simState => 'Stav SIM karty';

  @override
  String get ipCountry => 'Země IP adresy';

  @override
  String get simCountry => 'Země SIM karty';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Shoda čísla';

  @override
  String get support => 'Podpora';

  @override
  String get rewardedAdService => 'Služba reklam s odměnou';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Již máte VIP privilegia (kromě reklam)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Již máte dočasná privilegia s datem vypršení platnosti: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Musíte zhlédnout ještě $count reklam, abyste získali dočasná VIP privilegia';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Byla vám udělena dočasná privilegia nákupu na $days dní. Datum vypršení platnosti: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Dočasné privilegium nákupu vypršelo';

  @override
  String get loadingAd => 'Načítání reklamy...';

  @override
  String get earnedTempVip => 'Získané dočasné VIP';

  @override
  String get vipExchangeService => 'Služba výměny VIP';

  @override
  String get marksInsufficient => 'Nedostatek bodů pro výměnu';

  @override
  String get invalidExchangeRule => 'Neplatné pravidlo výměny';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Úspěšně vyměněno za $description, datum vypršení platnosti: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Výměna selhala: $error';
  }

  @override
  String get vip3DaysWithAds => '3denní VIP s reklamami (pouze synchronizace)';

  @override
  String get vip5DaysNoAds => '5denní plnohodnotné VIP bez reklam';

  @override
  String get vip7DaysNoAds => '7denní plnohodnotné VIP bez reklam';

  @override
  String get noNotifications => 'Žádná oznámení';

  @override
  String get clearAllNotifications => 'Vymazat všechna oznámení';

  @override
  String get clearAllNotificationsConfirmation =>
      'Potvrdit vymazání všech oznámení';

  @override
  String get allNotificationsCleared => 'Všechna oznámení byla vymazána';

  @override
  String get clearButton => 'Vymazat';

  @override
  String get justNow => 'Právě teď';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'před $count minutami',
      one: 'před 1 minutou',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'před $count hodinami',
      one: 'před 1 hodinou',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'před $count dny',
      one: 'před 1 dnem',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Včera';

  @override
  String get deletionProposal => 'Návrh na smazání';

  @override
  String get deletionProposals => 'Návrhy na smazání';

  @override
  String get createProposal => 'Vytvořit návrh';

  @override
  String get createProposalTitle => 'Vytvořit návrh na smazání';

  @override
  String get reason => 'Důvod';

  @override
  String get reasonOutdated => 'Neaktuální číslo';

  @override
  String get reasonPrivacy => 'Obava o soukromí';

  @override
  String get reasonNotInService => 'Není ve službě';

  @override
  String get reasonWronglyIdentified => 'Nesprávně identifikováno';

  @override
  String get reasonInaccurateInfo => 'Nepřesné informace';

  @override
  String get reasonWrongMarked => 'Nesprávně označeno';

  @override
  String get reasonOther => 'Jiné';

  @override
  String get submit => 'Odeslat';

  @override
  String get cancel => 'Zrušit';

  @override
  String get proposalStatus => 'Stav';

  @override
  String get statusPending => 'Čeká se';

  @override
  String get statusActive => 'Aktivní';

  @override
  String get statusCompleted => 'Dokončeno';

  @override
  String get statusExpired => 'Expirováno';

  @override
  String get riskLevel => 'Úroveň rizika';

  @override
  String get riskLevelVerified => 'Ověřeno';

  @override
  String get riskLevelLow => 'Nízká';

  @override
  String get riskLevelHigh => 'Vysoká';

  @override
  String get riskLevelUnknown => 'Neznámá';

  @override
  String get votingProgress => 'Průběh hlasování';

  @override
  String agreeVotes(int count) {
    return 'Souhlas: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Nesouhlas: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Celkem: $count';
  }

  @override
  String get voteAgree => 'Souhlasit';

  @override
  String get voteDisagree => 'Nesouhlasit';

  @override
  String createdAt(String date) {
    return 'Vytvořeno: $date';
  }

  @override
  String get showReport => 'Zobrazit zprávu';

  @override
  String get hideReport => 'Skrýt zprávu';

  @override
  String get proposalStatistics => 'Statistiky návrhů';

  @override
  String get totalProposals => 'Celkem návrhů';

  @override
  String get activeProposals => 'Aktivní návrhy';

  @override
  String get completedProposals => 'Dokončené návrhy';

  @override
  String get myVotes => 'Moje hlasy';

  @override
  String get proposalCreated => 'Návrh byl úspěšně vytvořen';

  @override
  String get proposalCreateFailed => 'Nepodařilo se vytvořit návrh';

  @override
  String get voteSubmitted => 'Hlas byl úspěšně odeslán';

  @override
  String get voteSubmitFailed => 'Nepodařilo se odeslat hlas';

  @override
  String get noProposalsFound => 'Nebyly nalezeny žádné návrhy';

  @override
  String get loadingProposals => 'Načítání návrhů...';

  @override
  String get refreshProposals => 'Obnovit návrhy';

  @override
  String get totalPendingProposals => 'Celkem čekajících návrhů';

  @override
  String get highRisk => 'Vysoké riziko';

  @override
  String get mediumRisk => 'Střední riziko';

  @override
  String get lowRisk => 'Nízké riziko';

  @override
  String get communityImpact => 'Dopad na komunitu';

  @override
  String get criticalIssues => 'Kritické problémy';

  @override
  String get communityParticipation => 'Účast komunity';

  @override
  String get noActivity => 'Žádná aktivita';

  @override
  String get low => 'Nízká';

  @override
  String get moderate => 'Střední';

  @override
  String get high => 'Vysoká';

  @override
  String get veryHigh => 'Velmi vysoká';

  @override
  String get voted => 'Hlasováno';

  @override
  String get communityVotes => 'Hlasy komunity';

  @override
  String get waitingForMoreVotes => 'Čeká se na další hlasy komunity';

  @override
  String get proposalProcessed => 'Tento návrh byl zpracován';

  @override
  String get supported => 'PODPOŘENO';

  @override
  String get opposed => 'PROTI';

  @override
  String get approved => 'SCHVÁLENO';

  @override
  String get rejected => 'ZAMÍTNUTO';

  @override
  String get completed => 'DOKONČENO';

  @override
  String get pending => 'ČEKAJÍCÍ';

  @override
  String get critical => 'Kritické';

  @override
  String get oppose => 'Proti';

  @override
  String get veryLow => 'Velmi nízká';

  @override
  String get deletionProposalNotificationDescription =>
      'Oznámení o výsledcích hlasování o návrzích na smazání a aktualizacích.';

  @override
  String get deletionProposalCreated => 'Návrh na smazání vytvořen';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Váš návrh na smazání čísla $phoneNumber byl předložen ke zvážení komunitě.';
  }

  @override
  String get proposalApproved => 'Návrh schválen ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Návrh na smazání čísla $phoneNumber byl schválen komunitou ($supportPercentage% podpory, $totalVotes hlasů).';
  }

  @override
  String get proposalRejected => 'Návrh zamítnut ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Návrh na smazání čísla $phoneNumber byl zamítnut komunitou ($supportPercentage% podpory, $totalVotes hlasů).';
  }

  @override
  String get communityVotingStarted => 'Hlasování komunity zahájeno';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Nový návrh na smazání čísla $phoneNumber je nyní otevřen pro hlasování komunity.';
  }

  @override
  String get votingCompleted => 'Hlasování ukončeno';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Hlasování komunity pro $phoneNumber skončilo. Výsledek: $result ($supportPercentage% podpory).';
  }

  @override
  String get newVoteReceived => 'Přijat nový hlas';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Někdo hlasoval pro $voteType smazání čísla $phoneNumber. Aktuální počet hlasů: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Nepodařilo se načíst počet hlasů';

  @override
  String get voteCount => 'Počet hlasů';

  @override
  String get deletionProposalInfo => 'Informace o návrhu na smazání';

  @override
  String get deletionProposalDescription =>
      'Navrhujte čísla ke smazání, která porušují komunitní pravidla. Vaše účast pomáhá udržovat platformu bezpečnou.';

  @override
  String get voteToEarnVip => 'Hlasujte o návrzích a získejte VIP privilegia!';

  @override
  String get voteFailed => 'Hlasování selhalo';

  @override
  String get searchProposals => 'Vyhledat návrhy';

  @override
  String get defaultNotifications => 'Výchozí oznámení';

  @override
  String get defaultNotificationsDescription =>
      'Výchozí kanál oznámení pro aplikaci.';

  @override
  String get blockedCallNotifications => 'Oznámení o zablokovaných hovorech';

  @override
  String get blockedCallNotificationsDescription =>
      'Zobrazuje informace o blokovaných hovorech.';

  @override
  String get stirVerification => 'Ověření STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Zobrazuje výsledky ověření STIR/SHAKEN pro čísla.';

  @override
  String get fraudAlerts => 'Upozornění na podvody';

  @override
  String get fraudAlertsDescription =>
      'Zobrazuje varování před potenciálně podvodnými hovory.';

  @override
  String get notificationFrequencyDescription =>
      'Vyberte, jak často chcete dostávat oznámení o nových návrzích na smazání. Můžete je dostávat okamžitě, v dávkách nebo v intervalu na míru.';

  @override
  String get immediateNotifications => 'Okamžitě';

  @override
  String get immediateNotificationsDescription =>
      'Obdržíte oznámení ihned po vytvoření návrhu.';

  @override
  String get batchNotifications => 'V dávkách';

  @override
  String get batchNotificationsDescription =>
      'Periodicky obdržíte souhrn oznámení.';

  @override
  String get customNotifications => 'Vlastní';

  @override
  String get customNotificationsDescription =>
      'Definujte si vlastní interval pro příjem oznámení.';

  @override
  String get customFrequency => 'Vlastní frekvence';

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
  String get pendingProposals => 'Čekající návrhy';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count čekajících návrhů',
      one: '1 čekající návrh',
      zero: 'žádné čekající návrhy',
    );
    return 'Máte $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Pokyny';

  @override
  String get reportingGuidelines =>
      '• Hlasujte pouze pro čísla, která jsou skutečně problematická\n• Uvádějte přesné a podrobné důvody\n• Zvolte odpovídající úroveň rizika na základě závažnosti\n• Falešná hlášení mohou vést k omezení účtu';

  @override
  String get riskLevelLabel => 'Úroveň rizika';

  @override
  String get riskLevelDescription => 'Úroveň rizika čísla';

  @override
  String get phoneNumberMinDigits =>
      'Telefonní číslo musí mít minimálně 7 číslic';

  @override
  String get provideDetailedExplanation =>
      'Uveďte podrobné vysvětlení (minimálně 10 znaků)';

  @override
  String get reasonMinCharacters => 'Důvod musí mít minimálně 10 znaků';

  @override
  String get countryCodeTwoLetters => 'Kód země (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Kód země (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'např. CZ, DE, GB';

  @override
  String get countryCodeRequired => 'Kód země je vyžadován';

  @override
  String get countryCodeLengthError => 'Kód země musí mít 2 písmena';

  @override
  String get phoneNumberLengthError =>
      'Telefonní číslo musí mít minimálně 7 číslic';

  @override
  String get reasonHint => 'Uveďte podrobné vysvětlení (minimálně 10 znaků)';

  @override
  String get reasonRequired => 'Důvod je vyžadován';

  @override
  String get reasonLengthError => 'Důvod musí mít minimálně 10 znaků';

  @override
  String get guidelinesTitle => 'Pokyny';

  @override
  String get guidelinesText =>
      '• Hlasujte pouze pro čísla, která jsou skutečně problematická\n• Uvádějte přesné a podrobné důvody\n• Zvolte odpovídající úroveň rizika na základě závažnosti\n• Falešná hlášení mohou vést k omezení účtu';

  @override
  String get riskLevelCritical => 'Kritické';

  @override
  String get riskLevelMedium => 'Střední';

  @override
  String get riskLevelVeryLow => 'Velmi nízké';

  @override
  String get riskDescriptionVeryLow =>
      'Velmi nízké - Menší obtěžování, občasné hovory';

  @override
  String get riskDescriptionLow => 'Nízké - Občasné nevyžádané hovory';

  @override
  String get riskDescriptionMedium =>
      'Střední - Pravidelný spam nebo telemarketing';

  @override
  String get riskDescriptionHigh =>
      'Vysoké - Vytrvalé obtěžování nebo pokusy o podvod';

  @override
  String get riskDescriptionCritical =>
      'Kritické - Nebezpečné podvody nebo hrozby';

  @override
  String get notificationFrequencyTitle => 'Frekvence oznámení';

  @override
  String get notificationFrequencyLabel => 'Frekvence oznámení (hodiny)';

  @override
  String errorMessage(String error) {
    return 'Chyba: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Hlasy: $totalVotes ($supportPercentage% podpora)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Podpora ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Proti ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Právě teď';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m zpět';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}h zpět';
  }

  @override
  String timeDaysAgo(int days) {
    return '${days}d zpět';
  }

  @override
  String get notificationFrequencyHours => 'Frekvence oznámení (hodiny)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes hlasů ($supportPercentage% podpora)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hodin',
      one: '1 hodina',
      zero: '0 hodin',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Důležité upozornění';

  @override
  String get dataSourceDisclaimer =>
      'Čísla pocházejí z internetu a od uživatelů. Nemůžeme zaručit, že číslo, které bylo jednou smazáno, nebude znovu odesláno jinými uživateli nebo zdroji. Aktivně prosím vyhledávejte a ověřujte informace.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Umístění';

  @override
  String get simCardTitle => 'SIM karta';

  @override
  String get liveActivitiesSettingsTitle => 'Nastavení živých aktivit';

  @override
  String get elementsSettingsTitle => 'Nastavení prvků';

  @override
  String get liveActivityMode => 'Živá aktivita';

  @override
  String get liveActivityModeDescription =>
      'Zobrazuje informace o hovoru jako trvalé oznámení na zamykací obrazovce a v Dynamickém ostrově (iOS).';

  @override
  String get phoneNumberType => 'Typ telefonního čísla';

  @override
  String get liveActivitiesTestEndActivity => 'Ukončit aktivitu';

  @override
  String get liveActivitiesTestSendNewActivity => 'Odeslat novou aktivitu';

  @override
  String get liveActivitiesTestUpdateActivity => 'Aktualizovat aktivitu';

  @override
  String get liveActivityControlsTitle => 'Ovládací prvky živé aktivity';

  @override
  String get liveActivitiesTestTitle => 'Test živých aktivit';

  @override
  String get liveActivitiesTestSubtitle => 'Otestujte oznámení živé aktivity.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Přizpůsobení živých oznámení';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Přizpůsobte vzhled živých oznámení.';

  @override
  String get notification_instructions =>
      'Instrukce:\n1. Klepnutím na „ODESLAT“ vytvořte nebo aktualizujte oznámení.\n2. Přejděte na domovskou obrazovku nebo stáhněte dolů lištu oznámení, abyste viděli výsledek.\n3. Klepnutím na „UKONČIT“ oznámení zavřete.';

  @override
  String get autoCancelNotification => 'Automaticky zrušit oznámení';

  @override
  String get autoCancelNotificationDescription =>
      'Pokud je zaškrtnuto, oznámení se automaticky zavře, když na něj uživatel klepne.';

  @override
  String get setDelayTime => 'Nastavit čas zpoždění';

  @override
  String get proposalDetails => 'Podrobnosti návrhu';

  @override
  String get filterByStatus => 'Filtrovat podle stavu';

  @override
  String get proposalNotFound => 'Návrh nebyl nalezen';

  @override
  String get processed => 'Zpracováno';

  @override
  String get showAll => 'Zobrazit vše';

  @override
  String get filterAndSortTitle => 'Filtrovat a řadit';

  @override
  String get filterVerifiedOwner => 'Filtrovat ověřeného vlastníka';

  @override
  String get filterBy => 'Filtrovat podle';

  @override
  String get sortOldest => 'Seřadit nejstarší';

  @override
  String get sortNewest => 'Seřadit nejnovější';

  @override
  String get sortMostPopular => 'Seřadit nejpopulárnější';

  @override
  String get sortLeastPopular => 'Seřadit nejméně populární';

  @override
  String get sortBy => 'Seřadit podle';

  @override
  String get simRulesNotFound => 'Pravidla pro SIM karty nenalezena';

  @override
  String get simSlotRules => 'Pravidla pro sloty SIM karty';

  @override
  String get noSimCardDetected => 'Nebyla detekována žádná SIM karta';

  @override
  String get invalidSimData => 'Neplatná data SIM karty';

  @override
  String get simCardData => 'Data SIM karty';

  @override
  String get simSlot => 'Slot pro SIM kartu';

  @override
  String get enableFiltering => 'Povolit filtrování';

  @override
  String get detailedSettingsTitle => 'Podrobná nastavení';

  @override
  String get entryPointViewTitle => 'Vstupní pohled';

  @override
  String get callTypeRejected => 'Odmítnuto';

  @override
  String get callTypeSilenced => 'Ztišeno';

  @override
  String get callTypeVoicemail => 'Hlasová schránka';

  @override
  String get callTypeUnknownIntercept => 'Neznámé zachycení';

  @override
  String andMoreItems(int count) {
    return 'a dalších $count položek';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

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
  String get lastSync => 'Last Sync';
}
