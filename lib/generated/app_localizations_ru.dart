// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get aboutContactSubscription => 'О подписке на контакты';

  @override
  String get aboutLabels => 'О метках';

  @override
  String get aboutPhoneSubscriptionRules => 'О правилах подписки на телефон';

  @override
  String get aboutPhoneSubscriptions => 'О подписках на телефон';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Подпишитесь на списки правил телефона по URL, автоматически обновляйте правила. Поддерживает файлы правил в формате JSON, CSV.';

  @override
  String get aboutSmsFilter => 'Об SMS фильтрации';

  @override
  String get aboutSmsSubscriptionRules => 'О правилах подписки на SMS';

  @override
  String get aboutSubtitle => 'Версия приложения и юридическая информация';

  @override
  String get aboutTitle => 'О программе';

  @override
  String get action => 'Действие';

  @override
  String get actionAll => 'Все';

  @override
  String get actionAllow => 'Разрешить';

  @override
  String get actionBlock => 'Блокировать';

  @override
  String get actionFilterAll => 'Все фильтры';

  @override
  String get actionFilterTitle => 'Фильтровать по типу действия';

  @override
  String get actionFilterTooltip => 'Фильтр действий';

  @override
  String get actionNone => 'Нет действий';

  @override
  String get actionSilence => 'Без звука';

  @override
  String actionTag(Object actionType) {
    return 'Действие: $actionType';
  }

  @override
  String get actionType => 'Тип действия';

  @override
  String get actionUnknown => 'Неизвестно';

  @override
  String get add => 'Добавить';

  @override
  String get addAllowedBlockedRule => 'Добавить правило разрешения/блокировки';

  @override
  String get addAllowSubscription => 'Добавить подписку разрешения';

  @override
  String get addBlockSubscription => 'Добавить подписку блокировки';

  @override
  String get addContactButton => 'Добавить контакт';

  @override
  String addContactFailed(Object error) {
    return 'Не удалось добавить контакт: $error';
  }

  @override
  String get addedToAllowedRules => 'Добавлено в разрешенные правила';

  @override
  String get addedToBlacklist => 'Добавлено в черный список';

  @override
  String get addedToBlockedRules => 'Добавлено в заблокированные правила';

  @override
  String get addedToFavoriteContacts => 'Добавлено в избранные контакты';

  @override
  String get addedToFavorites => 'Добавлено в избранное';

  @override
  String get addedToWhitelist => 'Добавлено в белый список';

  @override
  String get addFavorite => 'Добавить в избранное';

  @override
  String get addFilter => 'Добавить фильтр';

  @override
  String get addLabel => 'Добавить метку';

  @override
  String get addLabelButton => 'Добавить метку';

  @override
  String addLabelFailed(Object error) {
    return 'Не удалось добавить метку: $error';
  }

  @override
  String get addLabelToCall => 'Добавить метку к записи звонка';

  @override
  String get addName => 'Добавить имя';

  @override
  String get addNoneSubscription => 'Добавить подписку \"Нет\"';

  @override
  String get addOrEditContactInfo =>
      'Используется для добавления или редактирования информации о контакте';

  @override
  String get addPhoneMark => 'Добавить отметку телефона';

  @override
  String get addPhoneNumberRule => 'Добавить правило для номера телефона';

  @override
  String get addPlugin => 'Добавить плагин';

  @override
  String get addPluginFailed => 'Не удалось добавить плагин';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Не удалось добавить плагин: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Добавить плагин из локального файла';

  @override
  String get addPluginFromUrl => 'Добавить плагин из URL';

  @override
  String get addRegexRule => 'Добавить правило регулярного выражения';

  @override
  String get addRule => 'Добавить правило';

  @override
  String get addRuleButton => 'Добавить правило';

  @override
  String addRuleFailed(Object error) {
    return 'Не удалось добавить правило: $error';
  }

  @override
  String get addRuleTooltip => 'Добавить правило';

  @override
  String get addSilenceSubscription => 'Добавить подписку на тишину';

  @override
  String get addSimRuleButton => 'Добавить SIM правило';

  @override
  String get addSmsFilterRule => 'Добавить правило фильтрации SMS';

  @override
  String get addSmsRule => 'Добавить SMS правило';

  @override
  String get addSmsSubscription => 'Добавить SMS подписку';

  @override
  String get addSubscription => 'Добавить подписку';

  @override
  String get addSubscriptionButton => 'Добавить подписку';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Не удалось добавить подписку: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Добавить подписку';

  @override
  String get addToAllowedRules => 'Добавить в разрешенные правила';

  @override
  String get addToBlacklist => 'Добавить в черный список';

  @override
  String get addToBlockedRules => 'Добавить в заблокированные правила';

  @override
  String get addToFavoriteContacts => 'Добавить в избранные контакты';

  @override
  String get addToFavorites => 'Добавить в избранное';

  @override
  String get addToRules => 'Добавить в правила';

  @override
  String get addToWhitelist => 'Добавить в белый список';

  @override
  String get adPlaceholder => 'Заполнитель рекламы';

  @override
  String get agent => 'Агент';

  @override
  String get all => 'Все';

  @override
  String get allCallsTab => 'Все';

  @override
  String get allDataClearedSuccessfully => 'Все данные успешно очищены';

  @override
  String get allow => 'Разрешить';

  @override
  String get allowAllAllowRules => 'Разрешить все разрешающие правила';

  @override
  String get allowAllAllowRulesDesc => 'Разрешить звонки из разрешающих правил';

  @override
  String get allowAllBlacklistedNumbers =>
      'Разрешить все номера из черного списка';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'Разрешить звонки из черного списка';

  @override
  String get allowAllBlockRules => 'Разрешить все блокирующие правила';

  @override
  String get allowAllBlockRulesDesc => 'Разрешить звонки из блокирующих правил';

  @override
  String get allowAllowedNumbers => 'Разрешить разрешенные номера';

  @override
  String get allowAllowedNumbersDesc => 'Разрешить звонки из белого списка';

  @override
  String get allowBlock => 'Разрешить/Заблокировать';

  @override
  String get allowBlockedNumbers => 'Разрешить заблокированные номера';

  @override
  String get allowBlockedNumbersDesc => 'Разрешить звонки из черного списка';

  @override
  String get allowedBlockedRule => 'Правило разрешения/блокировки';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Редактировать правило разрешения/блокировки';

  @override
  String get allowedBlockedRuleManagement =>
      'Управление правилами разрешения/блокировки';

  @override
  String get allowNonExceededNumbers =>
      'Разрешить номера, не превышающие лимит';

  @override
  String get allowNonExceededNumbersDescription =>
      'Автоматически разрешать номера, не превышающие пороговое значение количества';

  @override
  String get allowRegexAllowRules => 'Разрешить правила regex для разрешения';

  @override
  String get allowRegexAllowRulesDesc =>
      'Включить сопоставление шаблонов regex для разрешающих правил';

  @override
  String get allowRegexAllowRulesDescription =>
      'Включить разрешающие правила на основе regex';

  @override
  String get allowRegexBlockRules => 'Разрешить правила regex для блокировки';

  @override
  String get allowRegexBlockRulesDesc =>
      'Включить сопоставление шаблонов regex для блокирующих правил';

  @override
  String get allowRegexBlockRulesDescription =>
      'Включить блокирующие правила на основе regex';

  @override
  String get allowRule => 'Разрешающее правило';

  @override
  String get allowRules => 'Разрешающие правила';

  @override
  String get allowWhitelistedNumbers => 'Разрешить номера из белого списка';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Разрешить все номера из белого списка';

  @override
  String get allPermissionsGranted => 'Все разрешения предоставлены';

  @override
  String get allSettingsCompleted => 'Все настройки завершены.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Все обновления завершены ($count правил)';
  }

  @override
  String get answerThenHangup => 'Ответить и положить трубку';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. Все права защищены.';

  @override
  String get applicationSoftware => 'Прикладное ПО';

  @override
  String get apply => 'Применить';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Ошибка авторизации: Пожалуйста, проверьте ID и ключ клиента';

  @override
  String get authorizationFailedMessage => 'Ошибка авторизации';

  @override
  String get authorizationSuccessMessage => 'Авторизация успешна';

  @override
  String get authorizeLoginButton => 'Авторизовать вход';

  @override
  String get automotiveIndustry => 'Автомобильная промышленность';

  @override
  String get autoSyncLabel => 'Автоматическая синхронизация';

  @override
  String get autoUpdate => 'Автообновление';

  @override
  String get autoUpdateDescription =>
      'Установите интервалы автоматического обновления для подписок или обновляйте вручную';

  @override
  String get autoUpdateSettings => 'Настройки автообновления';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Управление автоматическими обновлениями правил и плагинов';

  @override
  String get autoUpdateSettingsTitle => 'Настройки автообновления';

  @override
  String get autoUpdateSubtitle =>
      'Управление автоматическими обновлениями правил и плагинов';

  @override
  String get autoUpdateTitle => 'Автообновление';

  @override
  String get avatarBorderColor => 'Цвет границы аватара';

  @override
  String get avatarBorderSize => 'Размер границы аватара';

  @override
  String get avatarIconSizesSetting => 'Размеры аватаров и значков';

  @override
  String get avatarPosition => 'Положение аватара';

  @override
  String get avatarSize => 'Размер аватара';

  @override
  String axisPosition(Object axis) {
    return 'Положение $axis';
  }

  @override
  String get backgroundGradientSetting => 'Градиент фона';

  @override
  String get backup => 'Резервное копирование';

  @override
  String get backupAndRestore => 'Резервное копирование и восстановление';

  @override
  String get backupAndRestoreSubtitle =>
      'Резервное копирование или восстановление данных приложения';

  @override
  String get backupAndRestoreTitle => 'Резервное копирование и восстановление';

  @override
  String get backupFailed => 'Ошибка резервного копирования';

  @override
  String get backupFailedMessage => 'Ошибка резервного копирования';

  @override
  String backupFailedWithError(Object error) {
    return 'Ошибка резервного копирования: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'Резервное копирование или восстановление данных приложения';

  @override
  String get backupRestoreTitle => 'Резервное копирование и восстановление';

  @override
  String get backupSectionTitle => 'Резервное копирование';

  @override
  String get backupSettings => 'Настройки резервного копирования';

  @override
  String get backupSettingsDialogTitle => 'Настройки резервного копирования';

  @override
  String get backupSettingsTitle => 'Настройки резервного копирования';

  @override
  String get backupSuccessMessage => 'Успешно скопировано в облако';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Резервное копирование успешно выполнено в: $path';
  }

  @override
  String get backupToCloud => 'Резервное копирование в облако';

  @override
  String get backupToCloudDescription =>
      'Резервное копирование настроек и правил в облачное хранилище';

  @override
  String backupToCloudFailed(Object error) {
    return 'Не удалось выполнить резервное копирование в облако: $error';
  }

  @override
  String get backupToCloudLabel => 'Резервное копирование в облако';

  @override
  String get backupToCloudSuccess => 'Успешно скопировано в облако';

  @override
  String get backupToCloudTitle => 'Резервное копирование в облако';

  @override
  String get backupToLocalLabel => 'Резервное копирование на локальный диск';

  @override
  String get bank => 'Банк';

  @override
  String get basicInfo => 'Основная информация';

  @override
  String get basicRuleFilter => 'Базовый фильтр правил';

  @override
  String get basicRuleFiltering => 'Базовая фильтрация правил';

  @override
  String get basicRuleFilteringExplanation =>
      '• Базовая фильтрация правил: правила фильтрации на основе черного списка, белого списка и регулярных выражений';

  @override
  String get basicRuleFilterSettings => 'Настройки базового фильтра правил';

  @override
  String get basicRuleFilterSubtitle =>
      'Фильтрация вызовов с использованием черного/белого списков и регулярных выражений';

  @override
  String get batchDeleteContacts => 'Пакетное удаление контактов';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Вы уверены, что хотите удалить $count выбранных контактов?';
  }

  @override
  String get batchDeleteFailed => 'Не удалось выполнить пакетное удаление';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Вы уверены, что хотите удалить $count меток?';
  }

  @override
  String get blacklist => 'Черный список';

  @override
  String get blacklistingAndWhitelisting => 'Черный и белый списки';

  @override
  String get blacklistLabel => 'Черный список';

  @override
  String get blackWhiteList => 'Черный/Белый список';

  @override
  String get block => 'Блокировать';

  @override
  String get blockCalls => 'Блокировать вызовы';

  @override
  String get blocked => 'Заблокировано';

  @override
  String get blockedCallAction => 'Действие заблокированного вызова';

  @override
  String get blockedCalls => 'Заблокированные вызовы';

  @override
  String get blockedCallsTitle => 'Заблокированные вызовы';

  @override
  String get blockedCommunications => 'Заблокированные сообщения';

  @override
  String get blockedPhoneLabel => 'Заблокированные вызовы';

  @override
  String get blockedSpamCalls => 'Заблокированные спам-вызовы';

  @override
  String get blockingTrend => 'Тенденция блокировки';

  @override
  String get blockInternationalCalls =>
      'соответствует номерам, которые не начинаются с + или 00';

  @override
  String get blockInternationalCallsTitle => 'Блокировать международные звонки';

  @override
  String get blockLandlineNumbersTitle =>
      'Блокировать номера стационарных телефонов';

  @override
  String get blockMobileNumbers =>
      'соответствует номерам, которые не начинаются с 13-19';

  @override
  String get blockMobileNumbersTitle =>
      'Блокировать номера мобильных телефонов';

  @override
  String get blockPremiumRateNumbers =>
      'соответствует номерам, которые не начинаются с 118 или 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Блокировать номера с премиум-тарифом';

  @override
  String get blockRule => 'Правило блокировки';

  @override
  String get blockRules => 'Правила блокировки';

  @override
  String get blockSpecificAreaCodes =>
      'соответствует номерам, начинающимся с 0 + 2-3 цифры';

  @override
  String get blockSpecificAreaCodesTitle =>
      'Блокировать определенные коды городов:';

  @override
  String get blockTypeAnalysisTitle => 'Анализ типа блокировки';

  @override
  String get both => 'Оба';

  @override
  String get bulkDelete => 'Пакетное удаление контактов';

  @override
  String get bulkDeleteContacts => 'Пакетное удаление контактов';

  @override
  String get bulkDeleteLabels => 'Пакетное удаление меток';

  @override
  String get call => 'Вызов';

  @override
  String get callback => 'Перезвонить';

  @override
  String callbackTo(String number) {
    return 'Перезвонить на $number';
  }

  @override
  String get callBlocking => 'Блокировка вызовов';

  @override
  String get callerIdApp => 'Приложение Caller ID';

  @override
  String get callerIdCustomizationTitle => 'Настроить Caller ID';

  @override
  String get callerIdDialogTitle => 'Информация о Caller ID';

  @override
  String get callerIdDisplayMode =>
      'Режим отображения идентификатора вызывающего абонента';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Отмечено $count';
  }

  @override
  String get callerIdPreview =>
      'Предварительный просмотр идентификатора вызывающего абонента';

  @override
  String get callFilter => 'Фильтр вызовов';

  @override
  String get callFilterDescription =>
      'При включении входящие вызовы проверяются в соответствии со списком правил ниже. Правила фильтрации вызовов по умолчанию не синхронизируются между устройствами.';

  @override
  String get callFilterRules => 'Правила фильтрации вызовов';

  @override
  String get callFilterRulesDescription =>
      'Установите основные правила для фильтрации вызовов';

  @override
  String get callFilterSettings => 'Настройки фильтра вызовов';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Установите лимиты частоты вызовов и правила блокировки';

  @override
  String get callFrequencyInterceptionTitle => 'Перехват частоты вызовов';

  @override
  String get callHistory => 'История вызовов';

  @override
  String get callHistoryInfoDesc =>
      'Здесь отображается ваша история вызовов, включая входящие, исходящие и пропущенные вызовы.';

  @override
  String get callHistoryInfoTitle => 'История вызовов';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Не удалось инициализировать историю вызовов: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Не удалось обновить историю вызовов: $error';
  }

  @override
  String get callHistoryTab => 'История вызовов';

  @override
  String get callHistoryTimelineEarlier => 'Раньше';

  @override
  String get callHistoryTimelineToday => 'Сегодня';

  @override
  String get callHistoryTimelineYesterday => 'Вчера';

  @override
  String get callScreeningPermission => 'Разрешение на фильтрацию вызовов';

  @override
  String get callScreeningPermissionDescription =>
      'Используется для фильтрации и блокировки спам-звонков.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Разрешение на фильтрацию вызовов не предоставлено, может повлиять на функциональность приложения.';

  @override
  String get callSettingsSubtitle =>
      'Настройки идентификатора вызывающего абонента, фильтрации и блокировки';

  @override
  String get callSettingsTitle => 'Настройки вызовов';

  @override
  String get callStatistics => 'Статистика вызовов';

  @override
  String get callTypeAnswered => 'Ответил';

  @override
  String get callTypeBlocked => 'Заблокирован';

  @override
  String get callTypeIconColor => 'Цвет значка типа вызова';

  @override
  String get callTypeMissed => 'Пропущенный вызов';

  @override
  String get callTypeOutgoing => 'Исходящий';

  @override
  String get callTypePosition => 'Положение типа вызова';

  @override
  String get callTypeUnknown => 'Неизвестно';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get carRental => 'Аренда автомобиля';

  @override
  String get carrier => 'Оператор';

  @override
  String get carrierColor => 'Цвет оператора';

  @override
  String get carrierFontSize => 'Размер шрифта оператора';

  @override
  String get carrierPosition => 'Положение оператора';

  @override
  String get changeLabel => 'Изменить метку';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Не удалось изменить статус плагина: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Не удалось изменить статус подписки: $error';
  }

  @override
  String get changeTag => 'Изменить тег';

  @override
  String get charity => 'Благотворительность';

  @override
  String chartMonthFormat(int month) {
    return 'Месяц $month';
  }

  @override
  String get chartOneDayAgo => '1 день назад';

  @override
  String get chartOneMonthAgo => '1 месяц назад';

  @override
  String get chartOneWeekAgo => '1 неделю назад';

  @override
  String get chartTenDaysAgo => '10 дней назад';

  @override
  String get chartThreeDaysAgo => '3 дня назад';

  @override
  String get chartToday => 'Сегодня';

  @override
  String get checkFileFormat =>
      'Пожалуйста, проверьте формат файла или разрешения';

  @override
  String checkPermissionFailed(Object error) {
    return 'Не удалось проверить разрешения: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Выберите действие перехвата по умолчанию';

  @override
  String get clearAllData => 'Очистить все данные';

  @override
  String get clearAllDataConfirmation =>
      'Вы уверены, что хотите очистить все данные приложения? Это действие нельзя отменить.';

  @override
  String get clearAllDataDescription => 'Очистить все данные приложения';

  @override
  String get clearAllDataLabel => 'Очистить все данные';

  @override
  String get clearFilter => 'Очистить фильтр';

  @override
  String get clearLabelFilter => 'Очистить фильтр меток';

  @override
  String get clearLabelFilterButton => 'Очистить фильтр меток';

  @override
  String get closeButton => 'Закрыть';

  @override
  String get cloudSync => 'Синхронизация с облаком';

  @override
  String get cloudSyncAndBackupTitle =>
      'Синхронизация с облаком и резервное копирование';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Настройте WebDAV, OneDrive и Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Настройки синхронизации с облаком';

  @override
  String get cloudSyncTitle => 'Синхронизация с облаком';

  @override
  String get collapseLabelSelector => 'Свернуть выбор меток';

  @override
  String get collection => 'Сбор долгов';

  @override
  String get colorPickerTitle => 'Выбрать цвет';

  @override
  String get configManagement => 'Управление конфигурацией';

  @override
  String get configUpdated => 'Конфигурация обновлена';

  @override
  String get configurationAdvice =>
      'Благодаря правильной настройке, вы можете установить различные стратегии фильтрации для рабочих и личных SIM-карт.';

  @override
  String get configureBackupOptions =>
      'Настроить параметры резервного копирования';

  @override
  String get configureBackupOptionsSubtitle =>
      'Настроить параметры резервного копирования';

  @override
  String get configureCloudSyncService =>
      'Настроить службу синхронизации с облаком';

  @override
  String get configureCloudSyncServiceHint =>
      'Пожалуйста, настройте службу синхронизации с облаком, чтобы включить синхронизацию между несколькими устройствами.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Пожалуйста, настройте службу синхронизации с облаком, чтобы включить синхронизацию между несколькими устройствами.';

  @override
  String get configureSimCardFilterRules =>
      'Настроить правила фильтрации SIM-карт';

  @override
  String get configureSyncServiceHint =>
      'Пожалуйста, сначала настройте службу синхронизации в настройках синхронизации с облаком';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get confirmBatchDeleteContacts =>
      'Вы уверены, что хотите удалить выбранные';

  @override
  String get confirmButton => 'Подтвердить';

  @override
  String get confirmDelete => 'Подтвердить удаление';

  @override
  String get confirmDeleteContact => 'Вы уверены, что хотите удалить';

  @override
  String get confirmDeleteContactName => 'Подтвердить удаление?';

  @override
  String get confirmDeleteFilter =>
      'Вы уверены, что хотите удалить этот фильтр?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Вы уверены, что хотите удалить метку \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Вы уверены, что хотите удалить плагин \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Вы уверены, что хотите удалить $count плагинов?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Вы уверены, что хотите удалить это правило? Это действие нельзя отменить.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Вы уверены, что хотите удалить выбранные контакты?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Вы уверены, что хотите удалить это правило фильтрации SMS?';

  @override
  String get confirmDeleteSmsRule =>
      'Вы уверены, что хотите удалить это правило SMS?';

  @override
  String get confirmDeleteSubscription =>
      'Вы уверены, что хотите удалить эту подписку?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Вы уверены, что хотите удалить $name?';
  }

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get connectedStatus => 'Подключено';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Не удалось подключиться: Проверьте адрес сервера, имя пользователя и пароль';

  @override
  String get connectionFailedMessage => 'Подключение не удалось';

  @override
  String get connectionStatusLabel => 'Статус подключения';

  @override
  String get connectionSuccessMessage => 'Подключение успешно';

  @override
  String get contactAddSuccess => 'Контакт успешно добавлен';

  @override
  String get contactDeleted => 'Контакт удален';

  @override
  String get contactEditDialog => 'Диалог редактирования контакта';

  @override
  String get contactNameHint => 'Введите имя контакта (необязательно)';

  @override
  String get contactNameLabel => 'Имя';

  @override
  String get contactNameOptional => 'Имя контакта (необязательно)';

  @override
  String get contactNotFound => 'Контакт не найден';

  @override
  String get contacts => 'Контакты';

  @override
  String contactsDeleted(Object count) {
    return 'Удалено $count контактов';
  }

  @override
  String get contactSettingsSubtitle =>
      'Управление контактами и настройка меток';

  @override
  String get contactSettingsTitle => 'Настройки контактов';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Не удалось загрузить контакты: $error';
  }

  @override
  String get contactsManagement => 'Управление контактами';

  @override
  String get contactsManagementPageTitle => 'Страница управления контактами';

  @override
  String get contactsPageTitle => 'Управление контактами';

  @override
  String get contactsPermission => 'Разрешение на контакты';

  @override
  String get contactsPermissionDescription =>
      'Используется для идентификации звонков контактов.';

  @override
  String get contactsTab => 'Контакты';

  @override
  String get contactSubscriptionDescription =>
      'Подпишитесь на списки контактов по URL, автоматически обновляйте информацию о контактах и метки. Поддерживает формат данных JSON.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Не удалось загрузить подписки на контакты: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Подписки на контакты';

  @override
  String get contactUpdateSuccess => 'Контакт успешно обновлен';

  @override
  String get contactUs => 'Свяжитесь с нами';

  @override
  String get content => 'Содержание';

  @override
  String get contentRegex => 'Регулярное выражение содержимого';

  @override
  String get countColor => 'Цвет счетчика';

  @override
  String get countFontSize => 'Размер шрифта счетчика';

  @override
  String get countPosition => 'Позиция счетчика';

  @override
  String get country => 'Страна';

  @override
  String get countryNameColor => 'Цвет названия страны';

  @override
  String get countryNameFontSize => 'Размер шрифта названия страны';

  @override
  String get countryRegionNamePosition => 'Позиция названия страны/региона';

  @override
  String get countrySelectionDialog => 'Диалог выбора страны';

  @override
  String get countrySelectionDialogDescription =>
      'Используется для выбора страны для запроса информации об идентификации вызывающего абонента';

  @override
  String get countThresholdDescription =>
      'Установите минимальный порог счетчика, необходимый для запуска действий фильтрации';

  @override
  String get countThresholdLabel => 'Порог счетчика';

  @override
  String get countThresholdSettings => 'Настройки порога счетчика';

  @override
  String countThresholdValue(Object count) {
    return 'Порог счетчика: $count';
  }

  @override
  String get createdRules => 'Созданные правила';

  @override
  String get csvFormat => 'Формат CSV';

  @override
  String get currentDeviceChip => 'Текущий';

  @override
  String get currentDeviceLabel => 'Метка текущего устройства';

  @override
  String get currentDeviceTitle => 'Текущее устройство';

  @override
  String get currentLabels => 'Текущие метки:';

  @override
  String get currentLanguage => 'Текущий язык';

  @override
  String get currentPasswordLabel => 'Текущий пароль';

  @override
  String get customerService => 'Служба поддержки';

  @override
  String get customRange => 'Пользовательский диапазон';

  @override
  String get dailyStatistics => 'Ежедневная статистика';

  @override
  String get dailyStatisticsDesc =>
      'Получайте ежедневную статистику о заблокированных вызовах и сообщениях';

  @override
  String get dashboardTab => 'Панель';

  @override
  String get dataAnalysis => 'Анализ данных';

  @override
  String get dataAnalysisDashboardPage => 'Страница панели анализа данных';

  @override
  String get dataExport => 'Экспорт данных';

  @override
  String dataLoadFailure(Object error) {
    return 'Не удалось загрузить данные: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Не удалось загрузить данные: $error';
  }

  @override
  String get dataMigration => 'Миграция данных';

  @override
  String get dataMigrationDescription =>
      'Эта функция позволяет переносить все ваши данные между устройствами. В настоящее время вы можете использовать функции резервного копирования и восстановления для ручной миграции данных.';

  @override
  String get dataMigrationDialogContent =>
      'Эта функция позволяет переносить все ваши данные между устройствами. В настоящее время вы можете использовать функции резервного копирования и восстановления для ручной миграции данных.';

  @override
  String get dataMigrationDialogTitle => 'Миграция данных';

  @override
  String get dataMigrationSectionTitle => 'Миграция данных';

  @override
  String get dataSourceReminder => 'Напоминание об источнике данных';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дней',
      one: '1 день',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Дней VIP';
  }

  @override
  String get debtCollection => 'Сбор долгов';

  @override
  String get defaultPeriod => 'Неделя';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteButton => 'Удалить';

  @override
  String get deleteContact => 'Удалить контакт';

  @override
  String deleteContactConfirm(Object name) {
    return 'Вы уверены, что хотите удалить $name?';
  }

  @override
  String get deleteContactConfirmation =>
      'Вы уверены, что хотите удалить контакт';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Вы уверены, что хотите удалить $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Удалить устройство';

  @override
  String deleteFailed(Object error) {
    return 'Не удалось удалить: $error';
  }

  @override
  String get deleteFilter => 'Удалить фильтр';

  @override
  String get deleteLabel => 'Удалить метку';

  @override
  String deleteLabelFailed(Object error) {
    return 'Не удалось удалить метку: $error';
  }

  @override
  String get deletePlugin => 'Удалить плагин';

  @override
  String deletePluginFailed(Object error) {
    return 'Не удалось удалить плагин: $error';
  }

  @override
  String get deletePlugins => 'Удалить плагины';

  @override
  String deletePluginsFailed(Object error) {
    return 'Не удалось удалить плагины: $error';
  }

  @override
  String get deleteRule => 'Удалить правило';

  @override
  String deleteRuleFailed(Object error) {
    return 'Не удалось удалить: $error';
  }

  @override
  String get deleteSelected => 'Удалить выбранное';

  @override
  String get deleteSmsRule => 'Удалить SMS правило';

  @override
  String get deleteSubscription => 'Удалить подписку';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Вы уверены, что хотите удалить подписку \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Не удалось удалить подписку: $error';
  }

  @override
  String get deleteSuccess => 'Успешно удалено';

  @override
  String get delivery => 'Доставка';

  @override
  String get deviceDeletedSuccessfully => 'Устройство успешно удалено';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Устройство успешно удалено';

  @override
  String get deviceIdLabel => 'ID устройства';

  @override
  String get deviceIDLabel => 'ID устройства';

  @override
  String get deviceManagementSubtitle =>
      'Управление синхронизацией нескольких устройств';

  @override
  String get deviceManagementTitle => 'Управление устройствами';

  @override
  String get deviceModelLabel => 'Модель устройства';

  @override
  String get deviceName => 'Имя устройства';

  @override
  String get deviceNameCannotBeEmpty => 'Имя устройства не может быть пустым';

  @override
  String get deviceNameHint => 'Пожалуйста, введите имя устройства';

  @override
  String get deviceNameLabel => 'Имя устройства';

  @override
  String get deviceRenamedSuccessfully => 'Устройство переименовано успешно';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Устройство переименовано успешно';

  @override
  String get devicesSyncedSuccessfully => 'Устройства успешно синхронизированы';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Устройства успешно синхронизированы';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Устройства успешно синхронизированы';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Устройство успешно удалено';

  @override
  String get dialogTitle => 'Объяснение шаблона Regex';

  @override
  String get differentFromLocalCounter =>
      'Эта функция отличается от локального счетчика, так как она фокусируется на повторяющихся паттернах вызовов за короткое время, а не на долгосрочном подсчете пометок.';

  @override
  String get disabled => 'Отключено';

  @override
  String get disabledStatus => 'Отключено';

  @override
  String get disableGlobalPlugins => 'Отключить глобальные плагины';

  @override
  String get disableSubscriptionSuccessfully => 'Подписка успешно отключена';

  @override
  String get disconnectButton => 'Отключить';

  @override
  String get disconnectedMessage => 'Отключено';

  @override
  String get disconnectedStatus => 'Отключено';

  @override
  String get disconnectFailedMessage => 'Не удалось отключиться';

  @override
  String get done => 'Готово';

  @override
  String get dualSimAdvice =>
      'Эта функция особенно полезна для телефонов с двумя SIM-картами, чтобы установить разные стратегии фильтрации для рабочих и личных SIM-карт.';

  @override
  String get earlier => 'Ранее';

  @override
  String get ecommerce => 'Электронная коммерция';

  @override
  String get edit => 'Редактировать';

  @override
  String get editContact => 'Редактировать контакт';

  @override
  String get editFilter => 'Редактировать фильтр';

  @override
  String get editLabel => 'Редактировать метку';

  @override
  String get editPhoneRule => 'Редактировать правило для телефона';

  @override
  String get editPhoneRules =>
      'Используется для редактирования правил для телефона';

  @override
  String get editPhoneRuleTitle => 'Редактировать правило для телефона';

  @override
  String get editRule => 'Редактировать правило';

  @override
  String get editSmsRule => 'Редактировать SMS правило';

  @override
  String get education => 'Образование';

  @override
  String get elementPositionsSetting => 'Положения элементов';

  @override
  String get email => 'Электронная почта';

  @override
  String get emailOptional => 'Электронная почта (Необязательно)';

  @override
  String get enableCallFilter => 'Включить фильтр вызовов';

  @override
  String get enableCallFilterDescription =>
      'При включении входящие вызовы проверяются по списку правил ниже. Правила фильтрации вызовов по умолчанию не синхронизируются между устройствами.';

  @override
  String get enabled => 'Включено';

  @override
  String get enabledStatus => 'Включено';

  @override
  String get enableEncryption => 'Включить шифрование';

  @override
  String get enableEncryptionDescription => 'Зашифровать файлы резервных копий';

  @override
  String get enableEncryptionLabel => 'Включить шифрование';

  @override
  String get enableEncryptionSubtitle =>
      'Файлы резервных копий будут зашифрованы';

  @override
  String get enableEncryptionTitle => 'Включить шифрование';

  @override
  String get enableGlobalPlugins => 'Включить глобальные плагины';

  @override
  String get enableLocalCountFilter => 'Включить фильтр локального счетчика';

  @override
  String get enableLocalCountFilterDescription =>
      'Автоматически фильтровать спам-вызовы на основе количества отметок вызовов';

  @override
  String get enableLocalNotification => 'Использовать локальное уведомление';

  @override
  String get enableLocalNotificationDescription =>
      'При включении уведомления для отфильтрованных сообщений будут отображаться на устройстве';

  @override
  String get enableLocationSummary => 'Местоположение';

  @override
  String get enableMuteRules => 'Включить правила отключения звука';

  @override
  String get enableMuteRulesDesc =>
      'Применить конфигурацию правил перехвата отключения звука';

  @override
  String get enableNoneActionRules => 'Включить правила без действий';

  @override
  String get enableNoneActionRulesDesc =>
      'Разрешить конфигурации правил без действий перехвата';

  @override
  String get enableNotifications => 'Включить уведомления';

  @override
  String get enableRemoteNumberFilter => 'Включить фильтр удаленных номеров';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Использовать удаленную базу данных для фильтрации номеров';

  @override
  String get enableRule => 'Включить правило';

  @override
  String get enableSmsFilter => 'Включить SMS фильтрацию';

  @override
  String get enableSmsFilterDescription =>
      'При включении сообщения будут автоматически фильтроваться в соответствии с правилами';

  @override
  String get enableStatisticsNotifications => 'Включить уведомления статистики';

  @override
  String get enableSubscriptionSuccessfully => 'Подписка успешно включена';

  @override
  String get enableTimeInterception => 'Включить перехват по времени';

  @override
  String get enableTimeInterceptionDescription =>
      'Перехватывать повторяющиеся звонки за короткий промежуток времени';

  @override
  String get enableTimeInterceptor => 'Включить временной перехватчик';

  @override
  String get endCallImmediately => 'Завершить вызов немедленно';

  @override
  String get endColor => 'Конечный цвет';

  @override
  String get endDate => 'Дата окончания';

  @override
  String get enhancedFilterInstructionsTitle => 'Улучшенная система фильтрации';

  @override
  String get enhancedFilterSettings => 'Расширенные настройки фильтрации';

  @override
  String get enhancedFilterSettingsTitle => 'Расширенные настройки фильтрации';

  @override
  String get enhancedFilterSystemDescription =>
      'Улучшенная система фильтрации поддерживает как глобальные правила, так и конфигурации фильтрации для каждой SIM-карты.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Пожалуйста, введите номер телефона и шаблон регулярного выражения';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Пожалуйста, введите номер телефона и шаблон регулярного выражения.';

  @override
  String get enterContactName => 'Пожалуйста, введите имя контакта';

  @override
  String get enterCurrentPasswordHint => 'Пожалуйста, введите текущий пароль';

  @override
  String get enterDeviceName => 'Введите название устройства';

  @override
  String get enterDeviceNameHint => 'Пожалуйста, введите название устройства';

  @override
  String get enterEmail => 'Введите адрес электронной почты';

  @override
  String get enterEmailOptional =>
      'Введите адрес электронной почты (необязательно)';

  @override
  String get enterEncryptionPasswordHint => 'Введите пароль шифрования';

  @override
  String get enterEncryptionPasswordTitle => 'Введите пароль шифрования';

  @override
  String get enterFilterName => 'Пожалуйста, введите имя фильтра';

  @override
  String get enterFilterPattern => 'Введите шаблон фильтра';

  @override
  String get enterIconCode => 'Введите код значка';

  @override
  String get enterName => 'Введите имя контакта';

  @override
  String get enterNewDeviceNameHint => 'Введите новое имя для этого устройства';

  @override
  String get enterNewPasswordHint => 'Пожалуйста, введите новый пароль';

  @override
  String get enterPasswordAgain => 'Повторите пароль';

  @override
  String get enterPasswordHint => 'Введите пароль';

  @override
  String get enterPhoneNumber => 'Введите номер телефона';

  @override
  String get enterPhoneNumberHint => 'Введите номер телефона для тестирования';

  @override
  String get enterPhoneNumberMultiple =>
      'Пожалуйста, введите номер телефона, несколько номеров разделенных запятыми';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Введите номер телефона для начала поиска';

  @override
  String get enterPhoneNumberToVerify =>
      'Введите номер телефона для подтверждения';

  @override
  String get enterPluginName => 'Введите имя плагина';

  @override
  String get enterPluginUrl => 'Введите URL-адрес плагина';

  @override
  String get enterRegexHint => 'Введите шаблон регулярного выражения';

  @override
  String get enterRuleNameAndPattern =>
      'Пожалуйста, введите имя правила и шаблон';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Пожалуйста, введите название правила и шаблон регулярного выражения.';

  @override
  String get enterRuleNameHint => 'Введите название правила';

  @override
  String get enterSearchContent => 'Пожалуйста, введите поисковый запрос';

  @override
  String get enterSubscriptionName => 'Введите название подписки';

  @override
  String get enterSubscriptionUrl => 'Введите URL подписки';

  @override
  String get enterSyncFolderNameHint =>
      'Пожалуйста, введите имя папки синхронизации (по умолчанию: NotificationManager)';

  @override
  String get entertainment => 'Развлечения';

  @override
  String get enterValidNameAndUrl =>
      'Пожалуйста, введите действительное имя и URL';

  @override
  String get enterValidUrl => 'Пожалуйста, введите действительный URL';

  @override
  String get enterVersion => 'Введите версию';

  @override
  String get enterWebDAVPasswordHint => 'Пожалуйста, введите пароль WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Пожалуйста, введите адрес сервера WebDAV';

  @override
  String get enterWebDAVUsernameHint =>
      'Пожалуйста, введите имя пользователя WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Ошибка при удалении устройства: $error';
  }

  @override
  String get errorLoadingPlugin => 'Ошибка при загрузке плагина';

  @override
  String errorOccurredMessage(Object error) {
    return 'Произошла ошибка: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Ошибка при переименовании устройства: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Ошибка при синхронизации устройств: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Ошибка при синхронизации устройств: $error';
  }

  @override
  String get errorText => 'Ошибка';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Ошибка при отмене регистрации устройства: $error';
  }

  @override
  String get exampleBlock400Prefix => 'например, префиксы номеров 400';

  @override
  String get exampleBlockMarketingSms => 'например, Блокировать рекламные SMS';

  @override
  String get exampleContentRegex => 'например, .*offer.*';

  @override
  String get exampleContentRegexHint =>
      'Пример регулярного выражения для контента';

  @override
  String get exampleCouponPromotionDiscount =>
      'например, .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'например, Семья, Друзья и т. д.';

  @override
  String get examplePhoneNumber => 'например, 10086, 12345 и т. д.';

  @override
  String get exampleRegex400Prefix =>
      'Пример регулярного выражения для префикса 400';

  @override
  String get exampleRegexFormat => 'Пример: формат ^10086\$';

  @override
  String get exampleSenderRegexHint => 'Пример';

  @override
  String get exchange => 'Обмен';

  @override
  String get exchangeNow => 'Обменять сейчас';

  @override
  String get exchangeVip => 'Обмен VIP';

  @override
  String get expandLabelSelector => 'Развернуть выбор меток';

  @override
  String expiryTime(Object time) {
    return 'Время истечения срока действия: $time';
  }

  @override
  String get export => 'Экспорт';

  @override
  String get exportAllApplicationSettings =>
      'Экспортировать все настройки приложения';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Экспортировать все настройки приложения';

  @override
  String get exportAllRuleConfigurations =>
      'Экспортировать все конфигурации правил';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Экспортировать все конфигурации правил';

  @override
  String get exportComplete => 'Экспорт завершен';

  @override
  String get exportConfig => 'Экспорт конфигурации';

  @override
  String get exportContacts => 'Экспортировать контакты';

  @override
  String get exportData => 'Экспортировать данные';

  @override
  String get exportError => 'Ошибка экспорта';

  @override
  String get exportFailed => 'Экспорт не удался';

  @override
  String get exportFailure => 'Не удалось экспортировать конфигурацию';

  @override
  String get exportFeatureComingSoon => 'Функция экспорта скоро появится';

  @override
  String get exporting => 'Экспорт...';

  @override
  String get exportLabels => 'Экспорт меток';

  @override
  String exportLabelsFailed(Object error) {
    return 'Не удалось экспортировать метки: $error';
  }

  @override
  String get exportPluginList => 'Экспорт списка плагинов';

  @override
  String exportPluginListFailed(Object error) {
    return 'Не удалось экспортировать список плагинов: $error';
  }

  @override
  String get exportRules => 'Экспорт правил';

  @override
  String get exportRulesDialogTitle => 'Экспорт правил';

  @override
  String get exportRulesTitle => 'Экспорт правил';

  @override
  String get exportSmsRules => 'Экспорт SMS правил';

  @override
  String get exportStatisticsData => 'Экспорт данных статистики';

  @override
  String get exportSuccess => 'Экспорт успешен';

  @override
  String get exportSuccesslly => 'Конфигурация успешно экспортирована';

  @override
  String get failedToAddContact => 'Не удалось добавить контакт';

  @override
  String failedToAddRule(Object error) {
    return 'Не удалось добавить правило: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'Не удалось добавить SMS правило: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Не удалось добавить SMS подписку: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Не удалось создать резервную копию настроек: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Не удалось расшифровать файл резервной копии';

  @override
  String get failedToDeleteDevice => 'Не удалось удалить устройство';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Не удалось удалить SMS правило: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Не удалось экспортировать правила: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Не удалось экспортировать SMS правила: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Не удалось получить информацию об идентификаторе вызывающего абонента: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Не удалось импортировать правила: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'Не удалось импортировать SMS правила: $error';
  }

  @override
  String get failedToLoadContacts => 'Не удалось загрузить контакты';

  @override
  String get failedToLoadPlugin => 'Не удалось загрузить плагин';

  @override
  String get failedToRenameDevice => 'Не удалось переименовать устройство';

  @override
  String get failedToRestoreSettings => 'Не удалось восстановить настройки';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Не удалось восстановить настройки: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Не удалось установить пароль: $error';
  }

  @override
  String get failedToSyncDevices => 'Не удалось синхронизировать устройства';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Не удалось изменить статус правила: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Не удалось изменить статус подписки';

  @override
  String get failedToUpdateContact => 'Не удалось обновить контакт';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Не удалось обновить SMS правило: $error';
  }

  @override
  String get failure => 'Сбой';

  @override
  String get favoriteContacts => 'Избранные контакты';

  @override
  String get featureAddRules =>
      '• Добавление правил для конкретных номеров телефонов';

  @override
  String get featureCenter => 'Центр функций';

  @override
  String get featureEnableDisable =>
      '• Включение/отключение различных фильтров для каждой SIM-карты';

  @override
  String get featureListTitle => 'Функции:';

  @override
  String get featureManageRules =>
      '• Управление списками правил для каждой SIM-карты';

  @override
  String get features => 'Функции';

  @override
  String get fetchingCallerIdInfo =>
      'Получение информации об идентификаторе вызывающего абонента...';

  @override
  String fileSavedTo(Object path) {
    return 'Файл сохранен в: $path';
  }

  @override
  String get filter => 'Фильтр';

  @override
  String get filterByLabel => 'Фильтр по метке';

  @override
  String get filterClear => 'Очистить фильтр';

  @override
  String get filterControlPanelTitle => 'Панель управления фильтрами';

  @override
  String get filterControlSubtitle =>
      'Управление статусом включения/выключения всех фильтров';

  @override
  String get filterControlTitle => 'Управление фильтрами';

  @override
  String get filterDeleteFailed => 'Не удалось удалить фильтр';

  @override
  String get filterDeleteSuccess => 'Фильтр успешно удален';

  @override
  String get filterDetails => 'Детали фильтра';

  @override
  String get filtered => 'Отфильтровано';

  @override
  String get filteredSms => 'Отфильтрованные SMS';

  @override
  String get filteredSmsLabel => 'Отфильтрованные SMS';

  @override
  String get filterExplanation => 'Объяснение фильтра';

  @override
  String get filterManagement => 'Управление фильтрами';

  @override
  String get filterName => 'Имя фильтра';

  @override
  String get filterPattern => 'Шаблон фильтра';

  @override
  String get filterPriorityNote =>
      'Примечание: между фильтрами существуют приоритетные отношения, подробности см. в документации.';

  @override
  String get filterSaveFailed => 'Не удалось сохранить фильтр';

  @override
  String get filterSaveSuccess => 'Фильтр успешно сохранен';

  @override
  String get filterSettings => 'Настройки фильтра';

  @override
  String get filterSettingsTitle => 'Настройки фильтра';

  @override
  String get filterSMS => 'Фильтр SMS';

  @override
  String get filterToggleInstructions =>
      'Включить или отключить фильтры для этого слота SIM-карты:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Фильтр $status: $filterName';
  }

  @override
  String get filterType => 'Тип фильтра';

  @override
  String get financial => 'Финансовый';

  @override
  String get flexibleCombinationFeature =>
      '• Гибкие комбинации: Включение/отключение фильтров для каждого слота SIM-карты';

  @override
  String get fontSizesSetting => 'Размеры шрифта';

  @override
  String foundRules(Object count) {
    return 'Найдено $count правил';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Найдено $count правил. Хотите импортировать их?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Найдено $count правил. Хотите импортировать их?';
  }

  @override
  String get fraudAlert => 'ПРЕДУПРЕЖДЕНИЕ О МОШЕННИЧЕСТВЕ - Положите трубку';

  @override
  String get fraudScamLikely => 'Вероятно мошенничество';

  @override
  String get free => 'Бесплатно';

  @override
  String get functionSettingsTitle => 'Настройки функций';

  @override
  String generalUpdateFailure(Object error) {
    return 'Ошибка обновления: $error';
  }

  @override
  String get getFree => 'Получить бесплатно';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Настройте глобальные фильтры для всех SIM-карт:';

  @override
  String get globalFilterFeature =>
      '• Глобальные фильтры: Основные правила для всех входящих вызовов';

  @override
  String get globalFilterSettings => 'Настройки глобальных фильтров';

  @override
  String get globalFilterToggleInstructions =>
      'Настройте параметры глобального фильтра, которые применяются ко всем слотам SIM-карт:';

  @override
  String get globalSearchSubtitle =>
      'Поиск контактов, меток, черных списков, белых списков и т. д.';

  @override
  String get globalSearchTitle => 'Глобальный поиск';

  @override
  String get globalSettings => 'Глобальные настройки';

  @override
  String get googleAdDisplayPosition => 'Положение отображения рекламы Google';

  @override
  String get googleAdMobIntegrationText =>
      'Реклама Google AdMob может быть интегрирована здесь';

  @override
  String get googleDriveAuthDescription =>
      'Авторизуйтесь, используя настроенные в системе идентификатор и ключ клиента Google Drive';

  @override
  String get googleDriveAuthorizationHint =>
      'Авторизуйтесь, используя настроенные в системе идентификатор и ключ клиента Google Drive';

  @override
  String get googleDriveConfigTitle => 'Конфигурация Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'Конфигурация Google Drive';

  @override
  String get government => 'Правительство';

  @override
  String get granted => 'Предоставлено';

  @override
  String get grantNecessaryPermissions => 'Предоставить необходимые разрешения';

  @override
  String get grantPermissions => 'Предоставить разрешения';

  @override
  String get headhunter => 'Headhunter';

  @override
  String get height => 'Рост';

  @override
  String get homePageTitle => 'Домашняя страница';

  @override
  String get homeTab => 'Главная';

  @override
  String get howItWorksPoint1 =>
      '• Система автоматически разрешит звонки с того же номера в течение установленного временного окна';

  @override
  String get howItWorksPoint2 =>
      '• Более короткие временные окна приводят к более строгой перехвату; более длинные временные окна приводят к более слабому перехвату';

  @override
  String get howItWorksPoint3 =>
      '• Система проверяет журналы вызовов, чтобы определить, является ли это повторным вызовом';

  @override
  String get howItWorksTitle => 'Как это работает:';

  @override
  String get iconCodeOptional => 'Код значка (Необязательно)';

  @override
  String get iconSize => 'Размер значка';

  @override
  String get import => 'Импорт';

  @override
  String get important => 'Важно';

  @override
  String get importButton => 'Импорт';

  @override
  String get importConfig => 'Импорт конфигурации';

  @override
  String get importContacts => 'Импорт контактов';

  @override
  String get importExportContacts => 'Импорт/Экспорт контактов';

  @override
  String get importExportContactsTooltip => 'Импорт/Экспорт контактов';

  @override
  String get importExportRules => 'Импорт/Экспорт правил';

  @override
  String importFailed(Object error) {
    return 'Импорт не удался: $error';
  }

  @override
  String get importFailure => 'Не удалось импортировать конфигурацию';

  @override
  String get importFeatureComingSoon => 'Функция импорта скоро появится';

  @override
  String get importLabels => 'Импорт меток';

  @override
  String importLabelsFailed(Object error) {
    return 'Не удалось импортировать метки: $error';
  }

  @override
  String get importPluginList => 'Импорт списка плагинов';

  @override
  String importPluginListFailed(Object error) {
    return 'Не удалось импортировать список плагинов: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Успешно импортировано $count плагинов';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Импортировать конфигурации правил из файла';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Импортировать конфигурации правил из файла';

  @override
  String get importRules => 'Импорт правил';

  @override
  String get importRulesButton => 'Импорт правил';

  @override
  String get importRulesDialogTitle => 'Импорт правил';

  @override
  String importRulesError(Object error) {
    return 'Не удалось импортировать правила: $error';
  }

  @override
  String get importRulesInstructions => 'Импортировать правила из CSV-файла';

  @override
  String get importRulesSuccess => 'Правила успешно импортированы';

  @override
  String get importRulesTitle => 'Импорт правил';

  @override
  String get importSuccess => 'Импорт выполнен успешно';

  @override
  String get incomingCallInterceptAction =>
      'Действие перехвата входящего вызова';

  @override
  String get incomingCallNotification => 'Уведомление о входящем вызове';

  @override
  String get incorrectPassword => 'Неверный пароль';

  @override
  String get initializing => 'Инициализация';

  @override
  String get installed => 'Установлено';

  @override
  String get insufficientMarks => 'Недостаточно баллов';

  @override
  String get insurance => 'Страхование';

  @override
  String get interceptAction => 'Действие перехвата';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Установите, как обрабатываются заблокированные вызовы';

  @override
  String get interceptionActionSettingsTitle => 'Настройки действия перехвата';

  @override
  String get interceptionTimeInterval => 'Интервал времени перехвата';

  @override
  String get internet => 'Интернет';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Интервал обновления $service установлен на $days дней';
  }

  @override
  String get invalidContentRegex =>
      'Недопустимое регулярное выражение контента';

  @override
  String get invalidLabel => 'Неверная метка';

  @override
  String get invalidRegexPattern => 'Неверный шаблон регулярного выражения';

  @override
  String get invalidSenderRegex => 'Неверный regex отправителя';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Присоединяйтесь к каналу и группе Telegram для получения дополнительной информации';

  @override
  String get jsLogsTitle => 'Журналы JS';

  @override
  String get jsonFormat => 'Формат JSON';

  @override
  String get keepAllVersions => 'Сохранять все версии';

  @override
  String get keepAllVersionsDescription =>
      'Сохранять все исторические версии каждой резервной копии';

  @override
  String get keepAllVersionsLabel => 'Сохранять все версии';

  @override
  String get keepAllVersionsSubtitle =>
      'Сохранение исторических версий каждой резервной копии';

  @override
  String get keepAllVersionsTitle => 'Сохранять все версии';

  @override
  String get label => 'Метка';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Метка \"$name\" успешно добавлена';
  }

  @override
  String get labelCategories => 'Категории меток';

  @override
  String get labelDeleted => 'Метка удалена';

  @override
  String get labelDescription =>
      'Метки помогают вам лучше управлять контактами, добавлять пользовательские метки к номерам телефонов для упрощения идентификации звонков и сообщений.';

  @override
  String get labelFilter => 'Фильтр меток';

  @override
  String get labelFilterTooltip => 'Фильтр меток';

  @override
  String get labelIconColor => 'Цвет значка метки';

  @override
  String get labelManagement => 'Управление метками';

  @override
  String get labelNotFound => 'Метка не найдена';

  @override
  String get labelRemoved => 'Метка удалена';

  @override
  String labelRemoveFailed(Object error) {
    return 'Не удалось удалить метку: $error';
  }

  @override
  String get labels => 'Метки';

  @override
  String get labelsColor => 'Цвет меток';

  @override
  String labelsDeleted(Object count) {
    return 'Удалено меток: $count';
  }

  @override
  String get labelsExportedSuccessfully => 'Метки успешно экспортированы';

  @override
  String get labelsFontSize => 'Размер шрифта меток';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Успешно импортировано $count меток';
  }

  @override
  String get labelsPosition => 'Положение меток';

  @override
  String labelTag(Object labelId) {
    return 'Метка: $labelId';
  }

  @override
  String get labelUpdated => 'Метка обновлена';

  @override
  String labelUpdateFailed(Object error) {
    return 'Не удалось обновить метку: $error';
  }

  @override
  String get labelUpdateSuccess => 'Метка \"\$labelText\" успешно обновлена';

  @override
  String get languageSettings => 'Настройки языка';

  @override
  String get languageSettingsSubtitle => 'Изменить язык отображения приложения';

  @override
  String get languageSettingsTitle => 'Настройки языка';

  @override
  String get last30Days => 'Последние 30 дней';

  @override
  String get last7Days => 'Последние 7 дней';

  @override
  String get lastSyncLabel => 'Последняя синхронизация';

  @override
  String lastUpdated(Object date) {
    return 'Последнее обновление: $date';
  }

  @override
  String get lifetimeMembership => 'Пожизненное членство';

  @override
  String get lifetimeMembershipDescription =>
      'Единовременная покупка, навсегда разблокирует все премиум-функции и будущие обновления';

  @override
  String loadContactsFailed(Object error) {
    return 'Не удалось загрузить контакты: $error';
  }

  @override
  String get loadDataFailed => 'Не удалось загрузить данные';

  @override
  String get loadFailed => 'Ошибка загрузки';

  @override
  String get loading => 'Загрузка...';

  @override
  String get loadingData => 'Загрузка данных...';

  @override
  String get loadingTags => 'Загрузка меток...';

  @override
  String loadLabelFailed(Object error) {
    return 'Не удалось загрузить метки: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Не удалось загрузить метки: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Не удалось загрузить помеченные номера телефонов: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Не удалось загрузить помеченные телефоны: $error';
  }

  @override
  String get loadMore => 'Загрузить еще';

  @override
  String get loadPluginButton => 'Загрузить плагин';

  @override
  String loadPluginsFailed(Object error) {
    return 'Не удалось загрузить плагины: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Не удалось загрузить настройки: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Не удалось загрузить правила SMS: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Не удалось загрузить статус';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Не удалось загрузить подписки: $error';
  }

  @override
  String get loan => 'Кредит';

  @override
  String get localBackupTitle => 'Локальная резервная копия';

  @override
  String get localCounterFilter => 'Локальный счетчик фильтра';

  @override
  String get localCounterFilterSubtitle =>
      'Автоматически фильтровать спам-звонки на основе частоты звонков';

  @override
  String get localCountFilter => 'Локальный счетчик фильтрации';

  @override
  String get localCountFilterDescription =>
      'Перехватывать частые звонки на основе количества локальных номеров';

  @override
  String get localCountFilterExplanationContent =>
      'Локальный счетчик фильтра анализирует записи истории звонков для автоматической идентификации и блокировки частых спам-звонков.';

  @override
  String get localCountFilterExplanationTitle =>
      'Пояснение к локальному счетчику фильтрации';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Определить, следует ли блокировать, на основе значения счетчика номера';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Когда количество номеров превышает установленный порог, вы можете выбрать автоматическую блокировку';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Вы можете выборочно разрешить номера, которые не превышают порог';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Вы можете выбрать, следует ли записывать все журналы запросов';

  @override
  String get localCountFiltering => 'Локальная фильтрация по счетчику';

  @override
  String get localCountFilteringExplanation =>
      '• Локальная фильтрация по счетчику: правила фильтрации на основе количества локальных меток';

  @override
  String get localCountFilterSettings =>
      'Настройки локального счетчика фильтрации';

  @override
  String get localCountFilterUseCases =>
      'Этот фильтр особенно подходит для выявления автодозвона и маркетинговых звонков.';

  @override
  String get localFilterSettings => 'Настройки локального фильтра';

  @override
  String get localNotificationDisabled => 'Локальное уведомление отключено';

  @override
  String get localNotificationEnabled => 'Локальное уведомление включено';

  @override
  String get localServices => 'Локальные сервисы';

  @override
  String get locationColor => 'Цвет местоположения';

  @override
  String get locationFontSize => 'Размер шрифта местоположения';

  @override
  String get locationIconColor => 'Цвет значка местоположения';

  @override
  String get locationPosition => 'Положение местоположения';

  @override
  String get logAllLocalQueries => 'Записывать все локальные запросы';

  @override
  String get logAllLocalQueriesDescription =>
      'Записывать журналы для всех локальных запросов номеров';

  @override
  String get logAllRemoteQueries => 'Записывать все удаленные запросы';

  @override
  String get logAllRemoteQueriesDescription =>
      'Записывать все операции удаленных запросов номеров';

  @override
  String get manage => 'Управление контактами';

  @override
  String get manageContacts => 'Управление';

  @override
  String get manageFavoriteContacts => 'Управление избранными контактами';

  @override
  String get manageFilterRules => 'Управление правилами фильтрации';

  @override
  String get manageFilterRulesDescription =>
      'Добавление, редактирование или удаление правил фильтрации SMS';

  @override
  String get manageFrequentContacts =>
      'Управление часто используемыми контактами';

  @override
  String get markCounts => 'Количество меток';

  @override
  String get markCount => 'Количество меток';

  @override
  String markedByCount(Object count) {
    return 'Отмечено $count';
  }

  @override
  String get markedPhonesList => 'Список отмеченных номеров телефонов';

  @override
  String get markExchange => 'Обмен метками';

  @override
  String get markPhone => 'Пометить номер телефона';

  @override
  String markPhoneFailed(Object error) {
    return 'Не удалось пометить номер телефона: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'Для пометки номеров телефонов';

  @override
  String get markPhoneManagementTitle =>
      'Управление пометкой номеров телефонов';

  @override
  String get markPhoneSuccess => 'Номер телефона успешно помечен';

  @override
  String get matchFailed => 'Совпадение не найдено!';

  @override
  String get matchFailedMessage => 'Совпадение не найдено.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'соответствует определенному формату номера';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Сопоставление номеров со специальными символами:';

  @override
  String get matchSpecificDigitPatterns =>
      'соответствует формату XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Сопоставление определенных шаблонов цифр:';

  @override
  String get matchSuccessful => 'Совпадение найдено!';

  @override
  String get matchSuccessfulMessage => 'Совпадение найдено!';

  @override
  String get medical => 'Медицинский';

  @override
  String get membershipPrivileges => 'Привилегии членства';

  @override
  String get migrationTool => 'Инструмент миграции';

  @override
  String get migrationToolTitle => 'Инструмент миграции';

  @override
  String get minutes => 'минут';

  @override
  String get month => 'Месяц';

  @override
  String get monthly => 'Ежемесячно';

  @override
  String get monthlyCallCount => 'Ежемесячные звонки';

  @override
  String get monthlyChartTitle => 'Ежемесячные заблокированные вызовы';

  @override
  String get monthlyMembership => 'Ежемесячное членство';

  @override
  String get monthlyMembershipDescription =>
      'Откройте все премиум-функции, автоматическое продление ежемесячно';

  @override
  String get monthlyTotal => 'Ежемесячная сумма';

  @override
  String get monthlyTotalLabel => 'Ежемесячная сумма';

  @override
  String get moreOptions => 'Дополнительные опции';

  @override
  String get mute => 'Отключить звук';

  @override
  String get name => 'Имя';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Имя и номер телефона не могут быть пустыми';

  @override
  String get nameAndPhoneNumberRequired => 'Имя и номер телефона обязательны';

  @override
  String get nameColor => 'Цвет имени';

  @override
  String get nameFontSize => 'Размер шрифта имени';

  @override
  String nameLabel(Object name) {
    return 'Имя: $name';
  }

  @override
  String get namePosition => 'Положение имени';

  @override
  String get nameUnknown => 'Имя: Неизвестно';

  @override
  String nameWithValue(String name) {
    return 'Имя: $name';
  }

  @override
  String get newPasswordLabel => 'Новый пароль';

  @override
  String get nextStep => 'Далее';

  @override
  String get noAction => 'Нет действия';

  @override
  String get noActionRules => 'Нет правил действия';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Нет активной службы облачной синхронизации';

  @override
  String get noCallLogs => 'Нет журналов вызовов';

  @override
  String get noCallRecords => 'Нет записей вызовов';

  @override
  String get noContacts => 'Контактов пока нет';

  @override
  String get noContactsYet => 'Контактов пока нет';

  @override
  String get noData => 'Нет данных';

  @override
  String get noDevicesRegisteredMessage => 'Устройства не зарегистрированы';

  @override
  String get noDevicesRegisteredYet => 'Устройства еще не зарегистрированы.';

  @override
  String get noFilters => 'Фильтров пока нет';

  @override
  String get noLabels => 'Нет меток';

  @override
  String get noMarkedPhones => 'Нет отмеченных номеров телефонов';

  @override
  String get noMatchingContacts => 'Нет подходящих контактов';

  @override
  String get noMatchingContactsFound => 'Не найдено подходящих контактов';

  @override
  String get noMatchingNumbersFound => 'Не найдено подходящих номеров';

  @override
  String get noMatchingRecords => 'Нет соответствующих записей о вызовах';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Нет соответствующих $ruleType';
  }

  @override
  String get none => 'Нет';

  @override
  String get noneServiceType => 'Нет';

  @override
  String get noPlugins => 'Еще нет плагинов';

  @override
  String get noRecords => 'Нет записей о вызовах';

  @override
  String get noResultReturned => 'Результат не вернулся';

  @override
  String get noResultReturnedLog => 'Результат не вернулся из плагина';

  @override
  String noRules(Object ruleType) {
    return 'Нет $ruleType';
  }

  @override
  String get noRulesPrompt => 'Правила не найдены, добавьте правила';

  @override
  String get noRulesToExport => 'Нет правил для экспорта';

  @override
  String get noSmsFilterRulesYet => 'Еще нет правил фильтрации SMS';

  @override
  String get noSmsRulesYet => 'Еще нет правил SMS';

  @override
  String get noSubscriptions => 'Нет подписок';

  @override
  String get noSubscriptionsYet => 'Нет подписок';

  @override
  String get notGranted => 'Не предоставлено';

  @override
  String get notificationMode => 'Режим уведомлений';

  @override
  String get notificationModeDescription =>
      'Показывать информацию о вызывающем абоненте в строке уведомлений';

  @override
  String get notificationPermission => 'Разрешение на уведомления';

  @override
  String get notificationPermissionDescription =>
      'Используется для отображения уведомлений о входящих вызовах и сообщениях.';

  @override
  String get notifications => 'Уведомления';

  @override
  String get notificationSettings => 'Настройки уведомлений';

  @override
  String get notificationSettingsSaved =>
      'Настройки уведомлений успешно сохранены';

  @override
  String get notSet => 'Не установлено';

  @override
  String get notVerifiedText => 'Не проверено';

  @override
  String get noValidSmsRulesFoundInFile =>
      'В файле не найдено действительных правил SMS';

  @override
  String get number => 'Номер';

  @override
  String get numberColor => 'Цвет номера';

  @override
  String get numberFontSize => 'Размер шрифта номера';

  @override
  String get numberPosition => 'Положение номера';

  @override
  String get numberSearch => 'Поиск по номеру';

  @override
  String get numberTypeColor => 'Цвет типа номера';

  @override
  String get numberTypeFontSize => 'Размер шрифта типа номера';

  @override
  String get numberTypePosition => 'Положение типа номера';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Ваш менеджер безопасности вызовов готов, начните пользоваться безопасными вызовами!';

  @override
  String get onboardingLanguageDescription =>
      'Выберите предпочитаемый язык для наилучшего опыта.';

  @override
  String get onboardingPermissionsDescription =>
      'Для предоставления полного сервиса нам необходимы следующие разрешения:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Блокировка спам-звонков и сообщений в один клик, настройка правил блокировки и создание спокойной обстановки.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Автоматическое определение неизвестных вызовов, отметка подозрительных номеров и защита вашей безопасности вызовов.';

  @override
  String get onboardingWelcomeDescription =>
      'Ваш эксперт по управлению вызовами, предоставляющий комплексные услуги по идентификации и блокировке вызовов.';

  @override
  String get oneDriveAuthDescription =>
      'Авторизоваться с использованием настроенных системой идентификатора и ключа клиента OneDrive';

  @override
  String get oneDriveAuthorizationHint =>
      'Авторизоваться с использованием настроенных системой идентификатора и ключа клиента OneDrive';

  @override
  String get oneDriveConfigTitle => 'Конфигурация OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'Конфигурация OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'Подписка на онлайн-определение номера';

  @override
  String get openAppSettings => 'Открыть настройки приложения';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Не удалось открыть настройки приложения: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Операция не удалась: $error';
  }

  @override
  String get operationFailure => 'Операция не удалась';

  @override
  String get operationSuccess => 'Операция выполнена успешно';

  @override
  String get other => 'Другое';

  @override
  String get ourOtherApps => 'Другие наши приложения';

  @override
  String get overlayMode => 'Всплывающее окно';

  @override
  String get overlayModeDescription =>
      'Показывать информацию о вызывающем абоненте во всплывающем окне';

  @override
  String get overlayPermission =>
      'Разрешение на отображение поверх других окон';

  @override
  String get overlayPermissionDescription =>
      'Используется для отображения всплывающего окна входящего вызова.';

  @override
  String get overview => 'Обзор';

  @override
  String get password => 'Пароль';

  @override
  String get passwordCannotBeEmpty => 'Пароль не может быть пустым';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get passwordSetSuccessfully => 'Пароль успешно установлен';

  @override
  String get pattern => 'Шаблон';

  @override
  String get pendingSync => 'Ожидает синхронизации';

  @override
  String get periodMonth => 'Месяц';

  @override
  String get periodWeek => 'Неделя';

  @override
  String get periodYear => 'Год';

  @override
  String get permissionDenied => 'В разрешении отказано';

  @override
  String get permissionGranted => 'Разрешение предоставлено';

  @override
  String get permissionManagement => 'Управление разрешениями';

  @override
  String get phoneCallsTab => 'Телефон';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get phoneNumberCannotBeEmpty => 'Номер телефона не может быть пустым';

  @override
  String get phoneNumberHint => 'Введите номер телефона';

  @override
  String get phoneNumberHintText =>
      'Введите номер телефона, чтобы добавить правило';

  @override
  String get phoneNumberLabel => 'Номер телефона';

  @override
  String get phoneNumberRegexRequired =>
      'Пожалуйста, введите номер телефона и шаблон регулярного выражения';

  @override
  String get phoneNumberRequired => 'Номер телефона обязателен';

  @override
  String get phoneNumberTypeFixedLine => 'Стационарный';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Стационарный или мобильный';

  @override
  String get phoneNumberTypeMobile => 'Мобильный';

  @override
  String get phoneNumberTypePager => 'Пейджер';

  @override
  String get phoneNumberTypePersonalNumber => 'Личный номер';

  @override
  String get phoneNumberTypePremiumRate => 'Премиум-тариф';

  @override
  String get phoneNumberTypeSharedCost => 'Общий тариф';

  @override
  String get phoneNumberTypeTollFree => 'Бесплатный';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Неизвестный';

  @override
  String get phoneNumberTypeVoicemail => 'Голосовая почта';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Разрешение на доступ к телефону';

  @override
  String get phonePermissionDescription =>
      'Используется для идентификации и блокировки входящих вызовов.';

  @override
  String get phoneRule => 'Правило для телефона';

  @override
  String get phoneRuleEditDialog =>
      'Диалог редактирования правила для телефона';

  @override
  String get phoneRuleManagement => 'Управление правилами телефона';

  @override
  String get phoneRuleSubscription => 'Подписка на правила телефона';

  @override
  String get phoneSubscription => 'Подписка на телефон';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Подпишитесь на списки правил телефона по URL для автоматического обновления правил белого и черного списков. Поддерживает файлы правил в формате JSON.';

  @override
  String get phoneSubscriptionTitle => 'Подписки на правила телефона';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Пожалуйста, выберите метку и введите действительный номер телефона';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Плагин \"$name\" успешно добавлен';
  }

  @override
  String get pluginDeleted => 'Плагин удален';

  @override
  String get pluginLatestVersion => 'Плагин уже последней версии';

  @override
  String get pluginListExportSuccess => 'Список плагинов успешно экспортирован';

  @override
  String get pluginLoadedSuccessfully => 'Плагин успешно загружен';

  @override
  String get pluginManagement => 'Управление плагинами';

  @override
  String get pluginManagementSubtitle =>
      'Управление и настройка сторонних плагинов';

  @override
  String get pluginManagementTitle => 'Управление плагинами';

  @override
  String get pluginName => 'Имя плагина';

  @override
  String get pluginNotLoaded =>
      'Плагин еще не загружен. Пожалуйста, сначала загрузите плагин.';

  @override
  String pluginsDeleted(Object count) {
    return 'Успешно удалено $count плагинов.';
  }

  @override
  String get pluginService => 'Сервис плагинов';

  @override
  String get pluginTestPageTitle => 'Тестирование плагина';

  @override
  String get pluginUpdateSuccess => 'Плагин успешно обновлен';

  @override
  String get pluginUrl => 'URL плагина';

  @override
  String get pluginUrlCannotBeEmpty => 'URL плагина не может быть пустым';

  @override
  String get pluginUrlHint => 'Введите URL плагина';

  @override
  String get pluginUrlLabel => 'URL плагина';

  @override
  String get pluginVersion => 'Версия плагина';

  @override
  String get political => 'Политический';

  @override
  String get powerfulSpamBlocking => 'Мощная блокировка спама';

  @override
  String get previousStep => 'Предыдущий';

  @override
  String get prioritizeRemoteAction =>
      'Приоритезировать настройки удаленного действия';

  @override
  String get prioritizeRemoteActionDescription =>
      'Приоритезировать настройки действий из удаленной базы данных';

  @override
  String get processing => 'Обработка...';

  @override
  String get processingOperation => 'Обработка...';

  @override
  String get purchase => 'Купить';

  @override
  String get quarterlyMembership => 'Ежеквартальное членство';

  @override
  String get quarterlyMembershipDescription =>
      'Разблокировать все премиум функции, автопродление ежеквартально';

  @override
  String get queryButton => 'Запрос';

  @override
  String get queryFailed => 'Ошибка запроса';

  @override
  String get queryFailedLog => 'Ошибка запроса';

  @override
  String get querying => 'Запрос...';

  @override
  String get queryingPhoneNumber => 'Запрос номера телефона';

  @override
  String get queryResultTitle => 'Результат запроса';

  @override
  String get ready => 'Готово!';

  @override
  String get receiveWeeklyStatistics => 'Получать еженедельную статистику';

  @override
  String get recruiter => 'Рекрутер';

  @override
  String get reEnterPasswordHint => 'Пожалуйста, повторите пароль';

  @override
  String get refresh => 'Обновить';

  @override
  String get refreshPermissionStatus => 'Обновить статус разрешений';

  @override
  String get refreshTooltip => 'Обновить';

  @override
  String regexError(Object error) {
    return 'Ошибка Regex: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Ошибка Regex: $error';
  }

  @override
  String get regexPattern => 'Регулярное выражение';

  @override
  String get regexPatternExplanation => 'Объяснение регулярного выражения';

  @override
  String get regexPatternExplanationButton =>
      'Объяснение регулярного выражения';

  @override
  String get regexPatternLabel => 'Регулярное выражение';

  @override
  String get regexPatternsExamples =>
      'Используйте стандартный синтаксис регулярных выражений для определения шаблонов. Примеры:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Регулярные выражения для сопоставления номеров телефонов';

  @override
  String get regexRule => 'Правило регулярного выражения';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Не удалось добавить правило регулярного выражения: $error';
  }

  @override
  String get regexRuleAddSuccess =>
      'Правило регулярного выражения успешно добавлено';

  @override
  String get regexRuleManagement => 'Управление правилами регулярных выражений';

  @override
  String get regexRuleNamePatternRequired =>
      'Имя правила и шаблон регулярного выражения не могут быть пустыми';

  @override
  String get regexRules => 'Правила регулярных выражений';

  @override
  String get regexTesterTitle => 'Тестер регулярных выражений';

  @override
  String regexValidationFailed(Object error) {
    return 'Проверка регулярного выражения не удалась: $error';
  }

  @override
  String get regexValidationSuccess => 'Проверка регулярного выражения успешна';

  @override
  String get region => 'Регион';

  @override
  String get registeredDevicesTitle => 'Зарегистрированные устройства';

  @override
  String get rejectAllCalls => 'Отклонить все вызовы';

  @override
  String get rejectAllCallsDescription =>
      'При включении все вызовы будут отклонены с наивысшим приоритетом';

  @override
  String get rejectAllNumbers => 'Отклонить все номера';

  @override
  String get rejectAllNumbersDesc =>
      'Отклонять все входящие вызовы при включении';

  @override
  String get rejectExceededNumbers => 'Отклонить превышающие номера';

  @override
  String get rejectExceededNumbersDescription =>
      'Автоматически отклонять номера, превышающие пороговое значение количества';

  @override
  String get remoteFilterSettings => 'Настройки удаленного фильтра';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Настройки удаленного фильтра номеров';

  @override
  String get remoteNumberFilter => 'Удаленный фильтр номеров';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Этот фильтр использует независимую удаленную базу данных для получения последней информации о номерах.';

  @override
  String get remoteNumberFilterDescription =>
      'Перехватывайте надоедливые вызовы на основе информации из удаленной базы данных';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Удаленный фильтр номеров идентифицирует и блокирует спам-вызовы путем запроса удаленной базы данных на основе количества номеров.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Объяснение удаленного фильтра номеров';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Пороговое значение количества: Определяется на основе частоты появления номера';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Действия фильтра: Настройте способ обработки номеров, превышающих пороговое значение';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Настройки приоритета: Установите приоритет для удаленных действий';

  @override
  String get remoteNumberFilterFeatures => 'Особенности:';

  @override
  String get remoteNumberFiltering => 'Удаленная фильтрация номеров';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Удаленная фильтрация номеров: Правила фильтрации на основе информации из удаленной базы данных';

  @override
  String get remoteNumberFilterSubtitle =>
      'Идентифицируйте спам-вызовы, используя облачную базу данных и отчеты сообщества';

  @override
  String get removeAdsDescription =>
      'Навсегда удалить всю рекламу в приложении для более плавного взаимодействия';

  @override
  String get removeAdsTitle => 'Удалить рекламу';

  @override
  String get removedFromFavoriteContacts => 'Удалено из избранных контактов';

  @override
  String get removedFromFavorites => 'Удалено из избранного';

  @override
  String get removeFavorite => 'Удалить из избранного';

  @override
  String get removeFromFavorites => 'Удалить из избранного';

  @override
  String get renameButton => 'Переименовать';

  @override
  String get renameDeviceDialogTitle => 'Переименовать устройство';

  @override
  String get renameDeviceTitle => 'Переименовать устройство';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Это заменит все ваши текущие настройки. Вы уверены, что хотите продолжить?';

  @override
  String get requestAllPermissions => 'Запросить все разрешения';

  @override
  String get requestPermission => 'Запросить разрешение';

  @override
  String requestPermissionFailed(Object error) {
    return 'Не удалось запросить разрешение: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Оценки';
  }

  @override
  String get reset => 'Сброс';

  @override
  String get restore => 'Восстановить';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Восстановить настройки приложения из резервной копии';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Восстановить настройки приложения из резервной копии';

  @override
  String get restoreButton => 'Восстановить';

  @override
  String restoreFailedWithError(Object error) {
    return 'Ошибка восстановления из облака: $error';
  }

  @override
  String get restoreFromCloud => 'Восстановить из облака';

  @override
  String get restoreFromCloudDescription =>
      'Восстановить настройки и правила из облачного хранилища';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Не удалось восстановить из облака: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Восстановить из облака';

  @override
  String get restoreFromCloudSuccess => 'Успешно восстановлено из облака';

  @override
  String get restoreFromCloudTitle => 'Восстановить из облака';

  @override
  String get restoreFromLocal => 'Восстановить из локального хранилища';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get restoreSectionTitle => 'Восстановить';

  @override
  String get restoreSettings => 'Восстановить настройки';

  @override
  String get restoreSettingsConfirmation =>
      'Это заменит все ваши текущие настройки. Вы уверены, что хотите продолжить?';

  @override
  String get restoreSettingsDialogTitle => 'Восстановление настроек';

  @override
  String get restoreSettingsTitle => 'Восстановление настроек';

  @override
  String get restoreSuccessFromLocal =>
      'Успешно восстановлено из локального хранилища';

  @override
  String get restoreSuccessMessage => 'Успешно восстановлено из облака';

  @override
  String get retry => 'Повторить';

  @override
  String get ridesharing => 'Поездки';

  @override
  String get risk => 'Риск';

  @override
  String get robocall => 'Робозвонок';

  @override
  String get ruleAction => 'Действие правила';

  @override
  String get ruleAddButton => 'Добавить правило';

  @override
  String get ruleAddedSuccess => 'Правило успешно добавлено';

  @override
  String ruleAddFailure(Object error) {
    return 'Не удалось добавить правило: $error';
  }

  @override
  String get ruleAddSuccess => 'Правило успешно добавлено';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Вы уверены, что хотите удалить это $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Удалить правило';

  @override
  String get ruleDeletedSuccess => 'Правило успешно удалено';

  @override
  String get ruleDeletedSuccessfully => 'Правило успешно удалено';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Не удалось удалить правило: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Не удалось удалить правило: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Правило успешно удалено';

  @override
  String get ruleDisabledSuccessfully => 'Правило успешно отключено';

  @override
  String get ruleEnabledSuccessfully => 'Правило успешно включено';

  @override
  String ruleLoadFailed(Object error) {
    return 'Не удалось загрузить правила: $error';
  }

  @override
  String get ruleManagement => 'Управление правилами';

  @override
  String get ruleManagementTitle => 'Управление правилами';

  @override
  String get ruleName => 'Имя правила';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Имя правила и регулярное выражение контента не могут быть пустыми';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Имя правила и номер телефона не могут быть пустыми';

  @override
  String get ruleNameHint => 'Например, Семья, Друзья и т. д.';

  @override
  String get ruleNameLabel => 'Имя правила';

  @override
  String get ruleNamePatternRequired =>
      'Пожалуйста, введите имя правила и шаблон';

  @override
  String get ruleNameRequired =>
      'Имя правила и номер телефона не могут быть пустыми';

  @override
  String get ruleNotExist => 'Правило не существует или было удалено';

  @override
  String ruleNotFound(Object error) {
    return 'Правило не найдено: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Правило успешно сохранено!';

  @override
  String get ruleSavedSuccessMessage => 'Правило успешно сохранено!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Не удалось сохранить: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Не удалось сохранить: $error';
  }

  @override
  String get ruleSaveSuccess => 'Правило успешно сохранено!';

  @override
  String get rulesExportedSuccessfully => 'Правила успешно экспортированы';

  @override
  String rulesExportedTo(Object path) {
    return 'Правила экспортированы в: $path';
  }

  @override
  String get rulesImported => 'Правила успешно импортированы';

  @override
  String rulesImportedSuccessfully(Object count) {
    return 'Успешно импортировано $count правил';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Не удалось импортировать правила: $error';
  }

  @override
  String get ruleStatistics => 'Статистика правил';

  @override
  String ruleStatusChanged(Object status) {
    return 'Статус правила $status успешно изменен';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Операция не удалась: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Статус правила $status успешно изменен';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Не удалось обновить правило: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Правило успешно обновлено';

  @override
  String get ruleVerification => 'Проверка правила';

  @override
  String get save => 'Сохранить';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get saveButtonLabel => 'СОХРАНИТЬ';

  @override
  String get saveButtonText => 'Сохранить';

  @override
  String saveFailed(Object error) {
    return 'Не удалось сохранить: $error';
  }

  @override
  String get saveFilter => 'Сохранить фильтр';

  @override
  String get saveSettings => 'Сохранить настройки';

  @override
  String saveSettingsFailed(Object error) {
    return 'Не удалось сохранить настройки: $error';
  }

  @override
  String get scamsLikely => 'Вероятно, мошенничество';

  @override
  String get search => 'Поиск';

  @override
  String get searchContacts => 'Поиск контактов';

  @override
  String searchError(Object error) {
    return 'Ошибка поиска: $error';
  }

  @override
  String get searchFilters => 'Поиск фильтров';

  @override
  String get searchForContacts => 'Поиск контактов';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get searchSettingsSubtitle =>
      'Поиск контактов, меток, черных списков, белых списков и т. д.';

  @override
  String get searchSettingsTitle => 'Настройки поиска';

  @override
  String get securityMessage =>
      'Не доверяйте телефонным звонкам. Всегда проверяйте номера служб поддержки независимо. Никогда не сообщайте пароли, коды подтверждения, номера карт или личную информацию.';

  @override
  String get selectActionToPerform =>
      'Выберите действие, которое необходимо выполнить при совпадении правила';

  @override
  String get selectActionWhenBlockingCalls =>
      'Выберите действие при блокировке вызовов';

  @override
  String get selectActionWhenRuleMatches =>
      'Выберите действие, если правило совпадает';

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get selectCountry => 'Выберите страну';

  @override
  String get selectDateRange => 'Выберите диапазон дат';

  @override
  String get selectedDateRange => 'Выбранный диапазон дат';

  @override
  String selectedItems(Object count) {
    return 'Выбрано $count элементов';
  }

  @override
  String get selectedLabel => 'Выбрано:';

  @override
  String get selectExportFormat => 'Выберите формат экспорта';

  @override
  String get selectLabel => 'Выберите метку';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Пожалуйста, выберите метку и введите действительный номер телефона';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get selectMultiple => 'Выбрать несколько';

  @override
  String get selectPeriod => 'Выбрать период';

  @override
  String get selectSimCard => 'Выбрать SIM-карту';

  @override
  String get selectSimSlot => 'Выберите слот SIM-карты';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Выберите конкретное действие для заблокированных вызовов';

  @override
  String get selectTag => 'Выбрать тег';

  @override
  String get selectTags => 'Выбрать теги';

  @override
  String get selectTrustedDataSource =>
      'Пожалуйста, выберите доверенные источники данных';

  @override
  String get selectYourLanguage => 'Выберите свой язык';

  @override
  String get sender => 'Отправитель';

  @override
  String get senderRegexOptional =>
      'Регулярное выражение отправителя (необязательно)';

  @override
  String get serverAddressLabel => 'Адрес сервера';

  @override
  String get serviceTypeContact => 'Подписка на контакт';

  @override
  String get serviceTypeLabel => 'Тип сервиса';

  @override
  String get serviceTypePhone => 'Подписка на телефон';

  @override
  String get serviceTypePlugin => 'Обновление плагина';

  @override
  String get serviceTypeSms => 'SMS-подписка';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Установить';

  @override
  String get setEncryptionPassword => 'Установить пароль шифрования';

  @override
  String get setEncryptionPasswordDescription =>
      'Установите пароль шифрования для резервного копирования и восстановления';

  @override
  String get setEncryptionPasswordLabel => 'Установить пароль шифрования';

  @override
  String get setEncryptionPasswordTitle => 'Установить пароль шифрования';

  @override
  String get setPasswordButton => 'Установить';

  @override
  String get settings => 'Настройки';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Настройки скопированы в: $path';
  }

  @override
  String get settingsLoaded => 'Настройки загружены';

  @override
  String settingsLoadFailed(Object error) {
    return 'Не удалось загрузить настройки: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Настройки успешно восстановлены. Пожалуйста, перезапустите приложение, чтобы изменения вступили в силу.';

  @override
  String get settingsSaved => 'Настройки сохранены';

  @override
  String settingsSaveFailed(Object error) {
    return 'Не удалось сохранить настройки: $error';
  }

  @override
  String get settingsTab => 'Настройки';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get setup => 'Настройка';

  @override
  String get showContactEditDialogStaticMethod =>
      'Статический метод для отображения диалога редактирования контакта';

  @override
  String get showExplanation => 'Показать пояснение';

  @override
  String get silence => 'Тишина';

  @override
  String get silenceAndNoAnswer => 'Тишина и нет ответа';

  @override
  String get silenceNoAnswer => 'Тишина без ответа';

  @override
  String get silentCallVoiceClone => 'Клонирование голоса тихого вызова';

  @override
  String get silentRules => 'Тихие правила';

  @override
  String simCard(Object simNumber) {
    return 'SIM-карта $simNumber';
  }

  @override
  String get simCardColor => 'Цвет SIM-карты';

  @override
  String get simCardConfigurationExplanation =>
      '• Конфигурация SIM-карты: установите отдельные правила фильтрации для каждой SIM-карты';

  @override
  String get simCardFilterRules => 'Правила фильтрации SIM-карты';

  @override
  String get simCardFilterRulesDescription =>
      'Установите разные правила фильтрации в зависимости от слотов SIM-карты';

  @override
  String get simCardFontSize => 'Размер шрифта SIM-карты';

  @override
  String get simCardPosition => 'Положение SIM-карты';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Не удалось загрузить информацию о SIM-карте: $error';
  }

  @override
  String get simRuleInstructions =>
      'Правила для SIM-карт позволяют настраивать независимые правила фильтрации для каждого слота SIM-карты.';

  @override
  String get simRuleInstructionsTitle => 'Правила для SIM-карт';

  @override
  String get simRuleManagement => 'Управление правилами SIM-карт';

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
    return 'Не удалось загрузить данные SIM-карты: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'Настройка фильтрации SIM-карты';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Позволяет настраивать правила фильтрации по слотам SIM-карт';

  @override
  String get simSlotFilterDescription =>
      'Настройте независимые правила фильтрации для каждой SIM-карты:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Настройки фильтра для SIM-карты $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Не удалось загрузить слоты SIM-карт: $error';
  }

  @override
  String get simSlotManagement => 'Управление слотами SIM-карт';

  @override
  String simSlotOperationFailed(Object error) {
    return 'Ошибка при работе со слотом SIM-карты: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Положение слота SIM-карты $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Правила для SIM-карт: независимые стратегии фильтрации для каждой SIM-карты';

  @override
  String get simSlotRuleListTitle => 'Список правил для SIM-карт';

  @override
  String get simSlotRuleManagement => 'Правила для SIM-карт';

  @override
  String get simSlotRuleManagementTitle => 'Управление правилами';

  @override
  String get simSlotSettings => 'Настройки SIM-карты';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Слот SIM-карты $slotNumber';
  }

  @override
  String get skip => 'Пропустить';

  @override
  String get smartCallerId => 'Интеллектуальная идентификация вызова';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Фильтрация SMS помогает автоматически фильтровать спам-сообщения и поддерживать чистоту списка сообщений. Вы можете настроить правила фильтрации и методы уведомлений.';

  @override
  String get smsFilterDisabled => 'Фильтрация SMS отключена';

  @override
  String get smsFilterEnabled => 'Фильтрация SMS включена';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Правило фильтрации SMS успешно добавлено';

  @override
  String get smsFilterRules => 'Правила фильтрации SMS';

  @override
  String get smsFilterSettings => 'Настройки фильтрации SMS';

  @override
  String get smsHistory => 'История SMS';

  @override
  String get smsManagement => 'Управление SMS';

  @override
  String get smsPermission => 'Разрешение SMS';

  @override
  String get smsPermissionDescription =>
      'Используется для фильтрации спам-сообщений.';

  @override
  String get smsRuleAddedSuccessfully => 'Правило SMS успешно добавлено';

  @override
  String get smsRuleDeletedSuccessfully => 'Правило SMS успешно удалено';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Не удалось загрузить правила SMS: $error';
  }

  @override
  String get smsRuleManagement => 'Управление правилами SMS';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'Правила SMS успешно экспортированы в $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'Правила SMS успешно импортированы';

  @override
  String get smsRuleSubscription => 'Подписка на правила SMS';

  @override
  String get smsRuleUpdatedSuccessfully => 'Правило SMS успешно обновлено';

  @override
  String get smsSettingsSubtitle =>
      'Фильтрация SMS и блокировка по ключевым словам';

  @override
  String get smsSettingsTitle => 'Настройки SMS';

  @override
  String get smsSubscription => 'Подписка SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Подписка на SMS успешно добавлена';

  @override
  String get smsSubscriptionRulesDescription =>
      'Подпишитесь на списки правил SMS по URL, поддерживается сопоставление регулярных выражений. Вы можете установить действия блокировки или разрешения.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Некоторые запросы разрешений отклонены';

  @override
  String get spamLikely => 'Вероятно спам';

  @override
  String get startColor => 'Начальный цвет';

  @override
  String get startDate => 'Дата начала';

  @override
  String get startUsing => 'Начать';

  @override
  String get statAnswered => 'Отвечено';

  @override
  String get statBlocked => 'Заблокировано';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Статический метод для отображения диалога информации об идентификаторе вызывающего абонента';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Статический метод для отображения диалога выбора страны';

  @override
  String get staticMethodToDisplayDialog =>
      'Статический метод для отображения диалога';

  @override
  String get statistics => 'Статистика';

  @override
  String get statisticsExportFeatureComingSoon =>
      'Функция экспорта статистики скоро появится';

  @override
  String get statisticsGrid => 'Таблица статистики';

  @override
  String get statisticsPageTitle => 'Анализ данных';

  @override
  String get stirColor => 'Цвет STIR';

  @override
  String get stirFontSize => 'Размер шрифта STIR';

  @override
  String get stirPosition => 'Положение STIR';

  @override
  String get storagePermission => 'Разрешение на хранение';

  @override
  String get storagePermissionDescription =>
      'Используется для сохранения настроек и правил.';

  @override
  String get subscribe => 'Подписаться';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Подписка \"$name\" успешно добавлена';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Вы уверены, что хотите удалить эту подписку?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Удалить подписку';

  @override
  String get subscriptionDeleted => 'Подписка удалена';

  @override
  String get subscriptionDeletedSuccessfully => 'Подписка успешно удалена';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Не удалось удалить подписку: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Подписка удалена';

  @override
  String get subscriptionEmptyState => 'Нет доступных подписок';

  @override
  String get subscriptionEmptyText => 'Подписок пока нет';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Не удалось загрузить подписки: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Не удалось загрузить подписки: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Управление подписками';

  @override
  String get subscriptionName => 'Название подписки';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Название и URL подписки не могут быть пустыми';

  @override
  String get subscriptionNameHint => 'Введите название подписки';

  @override
  String get subscriptionPageTitle => 'Управление подписками';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Не удалось изменить статус подписки: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Не удалось переключить статус подписки: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Не удалось обновить подписку: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Подписка успешно обновлена';

  @override
  String get subscriptionUrl => 'URL подписки';

  @override
  String get subscriptionUrlHint => 'Введите URL подписки';

  @override
  String successfullyImportedRules(Object count) {
    return 'Успешно импортировано $count правил';
  }

  @override
  String get supportSync => 'Поддержка синхронизации';

  @override
  String get survey => 'Опрос';

  @override
  String get syncDevicesButton => 'Синхронизировать устройства';

  @override
  String get syncFailed => 'Синхронизация не удалась';

  @override
  String get syncFailedMessage => 'Синхронизация не удалась';

  @override
  String get syncFolderNameHint =>
      'Пожалуйста, введите имя папки синхронизации (по умолчанию: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Имя папки синхронизации';

  @override
  String get synchronized => 'Синхронизировано';

  @override
  String get syncing => 'Синхронизация...';

  @override
  String get syncNow => 'Синхронизировать сейчас';

  @override
  String get syncNowButton => 'Синхронизировать сейчас';

  @override
  String get syncStatusTitle => 'Статус синхронизации';

  @override
  String get syncStatusUpdatedMessage => 'Статус синхронизации обновлен';

  @override
  String get syncSuccessful => 'Синхронизация успешна';

  @override
  String get syncSuccessMessage => 'Синхронизация успешна';

  @override
  String get syncWithCloudStorage => 'Синхронизация с облачным хранилищем';

  @override
  String get syncWithCloudStorageSubtitle =>
      'Синхронизация с облачным хранилищем';

  @override
  String get systemFeatures => 'Системные функции:';

  @override
  String get systemSettingsTitle => 'Настройки системы';

  @override
  String get tabAll => 'Все';

  @override
  String get tabAnswered => 'Отвеченные';

  @override
  String get tabBlocked => 'Заблокировано';

  @override
  String get tabMissed => 'Пропущенные';

  @override
  String get tabOutgoing => 'Исходящие';

  @override
  String tagLabel(String tag) {
    return 'Тег: $tag';
  }

  @override
  String get tagsUpdated => 'Теги обновлены';

  @override
  String get takeaway => 'Вывод';

  @override
  String get telecommunication => 'Телекоммуникации';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Телемаркетинг';

  @override
  String get testButton => 'ТЕСТ';

  @override
  String get testButtonLabel => 'ТЕСТ';

  @override
  String get testConnectionButton => 'Проверить соединение';

  @override
  String get textColorsSetting => 'Цвета текста и меток';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Это приложение — мощный инструмент идентификации абонентов, который позволяет идентифицировать и блокировать нежелательные вызовы.';

  @override
  String get thisWeek => 'На этой неделе';

  @override
  String get timeInterceptor => 'Временной перехватчик';

  @override
  String get timeInterceptorDescription =>
      'Автоматически перехватывать/разрешать потенциальные вызовы в зависимости от частоты вызовов';

  @override
  String get timeInterceptorExplanation =>
      '• Временной перехватчик: перехватывать/разрешать повторяющиеся вызовы за короткий промежуток времени';

  @override
  String get timeInterceptorExplanationContent =>
      'Функция перехвата частоты вызовов анализирует частоту вызовов, чтобы автоматически выявлять и перехватывать/разрешать частые спам-вызовы.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Пояснение по перехвату частоты вызовов';

  @override
  String get timeInterceptorSettingsTitle =>
      'Настройки перехвата частоты вызовов';

  @override
  String get timeInterceptorSubtitle =>
      'Автоматически перехватывать потенциальные спам-вызовы на основе частоты вызовов';

  @override
  String get timeInterceptorTitle => 'Включить перехват частоты вызовов';

  @override
  String get timeWindowDescription =>
      'Установите размер временного окна для разрешения повторяющихся вызовов. Вызовы с одного и того же номера в пределах этого окна будут разрешены';

  @override
  String timeWindowLabel(int minutes) {
    return 'Временное окно перехвата (минут): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Установите размер временного окна для разрешения повторяющихся вызовов. Вызовы с одного и того же номера в пределах этого окна будут разрешены';

  @override
  String get today => 'Сегодня';

  @override
  String get total => 'Всего';

  @override
  String get totalBlocked => 'Всего заблокировано';

  @override
  String get totalFiltered => 'Всего отфильтровано';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Перенос данных между устройствами или платформами';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Перенос данных между устройствами или платформами';

  @override
  String get travelTicketing => 'Бронирование билетов';

  @override
  String get trend => 'Тенденция';

  @override
  String get trendChart => 'График тренда';

  @override
  String get tutorial => 'Руководство';

  @override
  String get type => 'Тип';

  @override
  String get unassignedSIMCard => 'Неназначенная SIM-карта';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get unknownLabel => 'Неизвестная метка';

  @override
  String get unknownTag => 'Тег: Неизвестно';

  @override
  String get unregisterButton => 'Отменить регистрацию';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Вы уверены, что хотите отменить регистрацию $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Отмена регистрации устройства';

  @override
  String get unsupportedFileFormat => 'Неподдерживаемый формат файла';

  @override
  String get update => 'Обновить';

  @override
  String get updateAllNow => 'Обновить все сейчас';

  @override
  String get updateCallFilterConfig => 'Обновить конфигурацию фильтра вызовов';

  @override
  String updateContactFailed(Object error) {
    return 'Не удалось обновить контакт: $error';
  }

  @override
  String get updateFavoriteStatus => 'Обновить статус избранного';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Не удалось обновить статус избранного: $error';
  }

  @override
  String get updateInterval => 'Интервал обновления';

  @override
  String get updateLabelFailed => 'Не удалось обновить метку';

  @override
  String get updateNow => 'Обновить сейчас';

  @override
  String get updatePlugin => 'Обновить плагин';

  @override
  String updatePluginFailed(Object error) {
    return 'Не удалось обновить плагин: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Не удалось обновить правило: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Не удалось обновить подписку: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service успешно обновлен ($count правил)';
  }

  @override
  String get updateTags => 'Обновить теги';

  @override
  String get useCasesPoint1 => '• Определять спам-звонки с автодозвоном';

  @override
  String get useCasesPoint2 =>
      '• Перехватывать маркетинговые звонки, которые звонят несколько раз за короткий период времени';

  @override
  String get useCasesPoint3 =>
      '• Предотвращать телефонный терроризм и преследования';

  @override
  String get useCasesTitle => 'Варианты использования:';

  @override
  String get useGlobalSettings => 'Использовать глобальные настройки';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Имя пользователя';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Используйте стандартный синтаксис регулярных выражений для определения шаблонов. Примеры:';

  @override
  String get validateRegex => 'Проверить Regex';

  @override
  String get verificationFailedText => 'Не удалось';

  @override
  String get verifiedText => 'Проверено';

  @override
  String get verify => 'Проверить';

  @override
  String version(Object version) {
    return 'Версия: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Обмен VIP-членства на количество отметок номеров телефонов';

  @override
  String get vipExchangeTitle => 'Отметка Exchange VIP';

  @override
  String get watchAd => 'Смотреть рекламу';

  @override
  String get watchAdForTemp => 'Смотреть рекламу для временных привилегий';

  @override
  String get watchAdForTempDescription =>
      'Посмотрите короткую рекламу, чтобы временно разблокировать некоторые премиум-функции';

  @override
  String get webDAVConfigTitle => 'Конфигурация WebDAV';

  @override
  String get webdavConfigurationTitle => 'Конфигурация WebDAV';

  @override
  String get webdavPasswordHint => 'Пожалуйста, введите пароль WebDAV';

  @override
  String get webdavServerAddressHint =>
      'Пожалуйста, введите адрес сервера WebDAV';

  @override
  String get webdavUsernameHint =>
      'Пожалуйста, введите имя пользователя WebDAV';

  @override
  String get week => 'Неделя';

  @override
  String get weekly => 'Еженедельно';

  @override
  String get weeklyBlockedCallsSummary =>
      'Еженедельный обзор заблокированных вызовов';

  @override
  String get weeklyChartTitle => 'Еженедельные заблокированные вызовы';

  @override
  String get weeklyReport => 'Еженедельный отчет';

  @override
  String get weeklyReportDesc =>
      'Получать еженедельный сводный отчет о деятельности по блокировке вызовов';

  @override
  String get welcome => 'Добро пожаловать';

  @override
  String get whitelist => 'Белый список';

  @override
  String get whitelistLabel => 'Белый список';

  @override
  String get width => 'Ширина';

  @override
  String get wildcardMatchingDescription =>
      'Используйте \'.\' для соответствия любому символу (например, \'123.456\' соответствует 123-456)';

  @override
  String get wildcardMatchingTitle =>
      'Сопоставление с подстановочными знаками:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Поддержка подстановочных знаков для гибкой фильтрации';

  @override
  String get windowSizeSetting => 'Размер окна';

  @override
  String get year => 'Год';

  @override
  String get yearly => 'Ежегодно';

  @override
  String get yearlyChartTitle => 'Ежегодные заблокированные вызовы';

  @override
  String get noSimCardsDetected => 'SIM-карты не обнаружены';

  @override
  String get filterManagementDescription => 'Установить фильтры вызовов';

  @override
  String get callerIdCustomizationSubtitle =>
      'Настроить макет идентификатора вызывающего абонента';

  @override
  String get fraudAlerSettingTitle => 'Настройка оповещения о мошенничестве';

  @override
  String get fraudAlerSettingSubtitle =>
      'Чтобы настроить оповещение о мошенничестве';

  @override
  String get enableFraudAlert => 'Включить оповещение о мошенничестве';

  @override
  String get enableFraudAlertDescription =>
      'Оповещение о подозрительных мошеннических вызовах';

  @override
  String get enableVibration => 'Включить вибрацию';

  @override
  String get enableVibrationDescription =>
      'Вибрировать, когда вызов подозревается в мошенничестве';

  @override
  String get notificationSettingsTitle => 'Настройки уведомлений';

  @override
  String get useLocalNotification => 'Использовать локальные уведомления';

  @override
  String get useLocalNotificationDescription =>
      'Включить локальные уведомления для входящих вызовов';

  @override
  String get cancelLocalNotification => 'Закрыть локальные уведомления';

  @override
  String get useStirNotification => 'Использовать уведомления от STIR';

  @override
  String get useStirNotificationDescription =>
      'Включить уведомления STIR для входящих вызовов';

  @override
  String get cancelLocalNotificationDescription =>
      'Автоматически закрывать локальные уведомления';

  @override
  String get callerIdSettingsTitle =>
      'Настройки идентификатора вызывающего абонента';

  @override
  String get callerIdSettingsSubtitle =>
      'Чтобы настроить уведомления о входящих вызовах и режим отображения';

  @override
  String get purchaseTitle => 'Покупка';

  @override
  String get purchaseSubtitle => 'Для приобретения услуги';

  @override
  String get callerIdNotificationTitle => 'Информация о входящем вызове';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Номер: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Заблокированный вызов';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Заблокированный вызов от $phoneNumber';
  }

  @override
  String get stirVerified => 'Подтверждено';

  @override
  String get stirNotVerified => 'Не подтверждено';

  @override
  String get stirFailed => 'Сбой проверки';

  @override
  String get stirUnknown => 'Неизвестный статус проверки';

  @override
  String get stirVerificationTitle => 'Проверка STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage для номера $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Настройки прокручиваемого сообщения безопасности';

  @override
  String get messageColor => 'Цвет сообщения';

  @override
  String get messageFontSize => 'Размер шрифта сообщения';

  @override
  String get messagePosition => 'Положение сообщения';

  @override
  String get containerWidth => 'Ширина контейнера';

  @override
  String get scrollSpeed => 'Скорость прокрутки';

  @override
  String get enableSecurityMessage => 'Включить сообщение безопасности';

  @override
  String get fraudAlertTitle => 'Предупреждение о мошенничестве';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Потенциальный мошеннический вызов от $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Не удалось загрузить правила: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Не удалось загрузить журнал вызовов: $error';
  }

  @override
  String get noBlockedTypeData => 'Нет данных о заблокированных типах';

  @override
  String importEntity(Object entityTypeName) {
    return 'Импортировать $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName успешно импортирован, всего импортировано $count записей';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Не удалось импортировать $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Экспортировать $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName успешно экспортирован';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Не удалось экспортировать $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Сервис облачной синхронизации';

  @override
  String get membershipCenter => 'Центр членства';

  @override
  String get redeemVipWithMarks => 'Активировать VIP с помощью баллов';

  @override
  String get currentMarkCount => 'Текущее количество баллов';

  @override
  String get markMoreNumbersForMore =>
      'Отмечайте больше номеров для получения большего количества баллов';

  @override
  String get noAds => 'Нет рекламы';

  @override
  String get cloudBackup => 'Облачное резервное копирование';

  @override
  String get callerIdEnhancement => 'Улучшение идентификации звонящего';

  @override
  String get voiceRecognition => 'Распознавание голоса';

  @override
  String get feature => 'Функция';

  @override
  String get normalUser => 'Обычный пользователь';

  @override
  String get vipUser => 'VIP пользователь';

  @override
  String get temporaryVip => 'Временный VIP';

  @override
  String get removeAds => 'Удалить рекламу';

  @override
  String get unknownAction => 'Неизвестное действие';

  @override
  String get settingsBackup => 'Резервное копирование настроек';

  @override
  String get allServicesStatusTitle => 'Текущий статус сервисов';

  @override
  String get allServicesStatusSubtitle =>
      'Текущий статус каждого облачного сервиса';

  @override
  String get redirect => 'Переадресация';

  @override
  String get notify => 'Уведомлять';

  @override
  String get log => 'Логировать';

  @override
  String get custom => 'Пользовательский';

  @override
  String get allowActionDescription =>
      'Вызовы будут разрешены, даже если номер находится в черном списке.';

  @override
  String get blockActionDescription =>
      'Вызовы будут заблокированы и отображены в журнале вызовов.';

  @override
  String get silenceActionDescription =>
      'Вызовы будут заглушены, но отображены в журнале вызовов.';

  @override
  String get noneActionDescription =>
      'Никаких специальных действий не будет предпринято для вызова.';

  @override
  String get redirectActionDescription =>
      'Переадресуйте вызов на указанный номер.';

  @override
  String get labelActionDescription =>
      'Добавьте метку к вызову для облегчения идентификации.';

  @override
  String get notifyActionDescription =>
      'Отправьте уведомление при получении вызова.';

  @override
  String get logActionDescription =>
      'Залогируйте информацию о вызове, не предпринимая никаких других действий.';

  @override
  String get customActionDescription => 'Выполните пользовательское действие.';

  @override
  String get synced => 'Синхронизировано';

  @override
  String get needVipAccess =>
      'Вам нужен VIP доступ для использования этой функции';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Импортировать или экспортировать данные $entityTypeName';
  }

  @override
  String get importExportTitle => 'Импорт/Экспорт';

  @override
  String get noPhoneRules => 'Правила для номеров не найдены';

  @override
  String get noRegexRules => 'Правила для регулярных выражений не найдены';

  @override
  String get noAllowedBlockedRules =>
      'Правила разрешения/блокировки не найдены';

  @override
  String get importExport => 'Импорт/Экспорт';

  @override
  String get filterByAction => 'Фильтровать по действию';

  @override
  String get upgradeToVip => 'Перейти на VIP';

  @override
  String get batteryOptimizationPermission => 'Оптимизация батареи';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Разрешите приложению работать в фоновом режиме для предоставления таких сервисов, как идентификатор вызывающего абонента.';

  @override
  String get permissionTitle => 'Специальные разрешения';

  @override
  String get permissionSubtitle =>
      'Управление разрешениями на наложение и оптимизацию батареи';

  @override
  String get themeSettingsTitle => 'Настройки темы';

  @override
  String get themeSettingsSubtitle => 'Выберите свою любимую тему';

  @override
  String get databaseSyncTitle => 'Синхронизация базы данных';

  @override
  String get countrySyncSettingsTitle =>
      'Настройки синхронизации базы данных по странам';

  @override
  String get countrySyncSettingsSubtitle =>
      'Выберите страны для синхронизации данных';

  @override
  String get countryDataDisclaimer =>
      'Пожалуйста, обратите внимание: база данных может не содержать данные для всех конкретных стран или регионов.';

  @override
  String get editSubscription => 'Редактировать подписку';

  @override
  String get searchByNameOrPhoneNumber => 'Поиск по имени или номеру телефона';

  @override
  String get allowedBlockedRulesInfo =>
      'Разрешенные/заблокированные правила используются для сопоставления вызовов с определенными номерами телефонов, которые имеют наивысший приоритет.';

  @override
  String get searchPhoneRulesHint => 'Поиск правил телефона';

  @override
  String get phoneRulesInfo =>
      'Правила телефона используются для сопоставления вызовов с определенными номерами телефонов, которые имеют более низкий приоритет. Некоторые из них поступают из подписок на правила телефона.';

  @override
  String get searchSubscriptionsHint => 'Поиск подписок';

  @override
  String get searchPluginsHint => 'Поиск плагинов';

  @override
  String get searchLabelsHint => 'Поиск меток';

  @override
  String get pluginDescription => 'Описание плагина';

  @override
  String get enterPluginDescription => 'Введите описание плагина';

  @override
  String get searchRegexRulesHint => 'Поиск правил Regex';

  @override
  String get regexRulesInfo =>
      'Правила Regex используются для фильтрации вызовов на основе шаблонов Regex.';

  @override
  String get searchMarkedPhonesHint => 'Поиск помеченных телефонов';

  @override
  String get searchContactSubscriptionsHint => 'Поиск подписок контактов';

  @override
  String get showAllContacts => 'Показать все контакты';

  @override
  String get showFavorites => 'Показать избранное';

  @override
  String get manualEntry => 'Информация о ручном вводе';

  @override
  String get scriptSaved => 'Скрипт сохранен';

  @override
  String editScriptFor(String pluginName) {
    return 'Редактировать скрипт для $pluginName';
  }

  @override
  String get saveScript => 'Сохранить скрипт';

  @override
  String get testPlugin => 'Протестировать плагин';

  @override
  String get description => 'Описание';

  @override
  String get accessTargetUrl => 'Доступ к целевому URL';

  @override
  String get result => 'Результат';

  @override
  String get editScript => 'Редактировать скрипт';

  @override
  String get numberFormat => 'Формат номера';

  @override
  String get nationalNumber => 'Национальный номер';

  @override
  String get e164Number => 'Номер E164';

  @override
  String get pluginRulesInfo =>
      'В целях безопасности используйте плагины только из проверенных источников. Не стесняйтесь использовать наши шаблоны для создания собственных пользовательских плагинов!';

  @override
  String get advancedMode => 'Расширенный режим';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Пожалуйста, введите хотя бы один номер.';

  @override
  String get openInWebView => 'Открыть в WebView';

  @override
  String get pluginLabel => 'Метка плагина';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Цвет фона сообщения';

  @override
  String get clearAllCallLogs => 'Очистить все журналы вызовов';

  @override
  String get clearAllCallLogsConfirmation =>
      'Подтвердите очистку всех журналов вызовов';

  @override
  String get allCallLogsCleared => 'Все журналы вызовов очищены';

  @override
  String get unblocked => 'Разблокировано';

  @override
  String get blockNumber => 'Номер блока';

  @override
  String get blockNumberSuccess => 'Номер блока успешно';

  @override
  String get blockNumberFailed => 'Номер блока не удался';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Вы уверены, что хотите разблокировать номер $phoneNumber?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Вызов $phoneNumber...';
  }

  @override
  String get viewDetails => 'Просмотреть детали';

  @override
  String get unblock => 'Разблокировать';

  @override
  String get unblockNumber => 'Разблокировать номер';

  @override
  String get unblockNumberSuccess => 'Номер успешно разблокирован';

  @override
  String get unblockNumberFailed => 'Разблокировка номера не удалась';

  @override
  String get serviceNotAvailable => 'Сервис недоступен';

  @override
  String get callingNumberFailed => 'Вызов номера не удался';

  @override
  String get listView => 'Вид списка';

  @override
  String get timelineView => 'Вид временной шкалы';

  @override
  String get nameCannotBeEmpty => 'Имя не может быть пустым';

  @override
  String get selectAction => 'Выберите действие';

  @override
  String get selectTargetService => 'Выберите целевую службу';

  @override
  String get callDetails => 'Детали звонка';

  @override
  String get callType => 'Тип вызова';

  @override
  String get callTime => 'Время вызова';

  @override
  String get numberInvalidFormat => 'Неверный формат номера';

  @override
  String get membershipFeature => 'Функция членства';

  @override
  String get medium => 'Средний';

  @override
  String get verificationReport => 'Отчет о проверке';

  @override
  String get finalRisk => 'Конечный риск';

  @override
  String get simState => 'Состояние SIM-карты';

  @override
  String get ipCountry => 'IP-страна';

  @override
  String get simCountry => 'Страна SIM-карты';

  @override
  String get isRoaming => 'Роуминг';

  @override
  String get isNumberMatch => 'Совпадение номеров';

  @override
  String get support => 'Поддержка';

  @override
  String get rewardedAdService => 'Служба рекламы с вознаграждением';

  @override
  String get hasVipPrivilegeExceptAds =>
      'У вас уже есть VIP-привилегии (за исключением рекламы)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'У вас уже есть временные привилегии, дата истечения срока действия: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Вам нужно посмотреть еще $count реклам, чтобы получить временные VIP-привилегии';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Вам предоставлено $days дней временных привилегий на покупку. Дата истечения срока действия: $expiryDate';
  }

  @override
  String get tempPurchaseExpired =>
      'Срок действия временных привилегий на покупку истек';

  @override
  String get loadingAd => 'Загрузка рекламы...';

  @override
  String get earnedTempVip => 'Заработанный временный VIP';

  @override
  String get vipExchangeService => 'Служба обмена VIP';

  @override
  String get marksInsufficient => 'Недостаточно баллов для обмена';

  @override
  String get invalidExchangeRule => 'Неверное правило обмена';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Успешно обменено на $description, дата истечения срока действия: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Обмен не удался: $error';
  }

  @override
  String get vip3DaysWithAds =>
      '3-дневный VIP с рекламой (только синхронизация)';

  @override
  String get vip5DaysNoAds => '5-дневный полнофункциональный VIP без рекламы';

  @override
  String get vip7DaysNoAds => '7-дневный полнофункциональный VIP без рекламы';

  @override
  String get noNotifications => 'Нет уведомлений';

  @override
  String get clearAllNotifications => 'Очистить все уведомления';

  @override
  String get clearAllNotificationsConfirmation =>
      'Подтвердите очистку всех уведомлений';

  @override
  String get allNotificationsCleared => 'Все уведомления очищены';

  @override
  String get clearButton => 'Очистить';

  @override
  String get justNow => 'Только что';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минут назад',
      one: '1 минуту назад',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часов назад',
      one: '1 час назад',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дней назад',
      one: '1 день назад',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Вчера';

  @override
  String get deletionProposal => 'Предложение об удалении';

  @override
  String get deletionProposals => 'Предложения об удалении';

  @override
  String get createProposal => 'Создать предложение';

  @override
  String get createProposalTitle => 'Создать предложение об удалении';

  @override
  String get reason => 'Причина';

  @override
  String get reasonOutdated => 'Устаревший номер';

  @override
  String get reasonPrivacy => 'Проблема с конфиденциальностью';

  @override
  String get reasonNotInService => 'Не используется';

  @override
  String get reasonWronglyIdentified => 'Неправильно идентифицирован';

  @override
  String get reasonInaccurateInfo => 'Неточная информация';

  @override
  String get reasonWrongMarked => 'Отмечено неправильно';

  @override
  String get reasonOther => 'Другое';

  @override
  String get submit => 'Отправить';

  @override
  String get cancel => 'Отмена';

  @override
  String get proposalStatus => 'Статус';

  @override
  String get statusPending => 'В ожидании';

  @override
  String get statusActive => 'Активно';

  @override
  String get statusCompleted => 'Завершено';

  @override
  String get statusExpired => 'Истекло';

  @override
  String get riskLevel => 'Уровень риска';

  @override
  String get riskLevelVerified => 'Проверено';

  @override
  String get riskLevelLow => 'Низкий';

  @override
  String get riskLevelHigh => 'Высокий';

  @override
  String get riskLevelUnknown => 'Неизвестно';

  @override
  String get votingProgress => 'Прогресс голосования';

  @override
  String agreeVotes(int count) {
    return 'За: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Против: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Всего: $count';
  }

  @override
  String get voteAgree => 'За';

  @override
  String get voteDisagree => 'Против';

  @override
  String createdAt(String date) {
    return 'Создано: $date';
  }

  @override
  String get showReport => 'Показать отчет';

  @override
  String get hideReport => 'Скрыть отчет';

  @override
  String get proposalStatistics => 'Статистика предложений';

  @override
  String get totalProposals => 'Всего предложений';

  @override
  String get activeProposals => 'Активные предложения';

  @override
  String get completedProposals => 'Завершенные предложения';

  @override
  String get myVotes => 'Мои голоса';

  @override
  String get proposalCreated => 'Предложение успешно создано';

  @override
  String get proposalCreateFailed => 'Не удалось создать предложение';

  @override
  String get voteSubmitted => 'Голос успешно отправлен';

  @override
  String get voteSubmitFailed => 'Не удалось отправить голос';

  @override
  String get noProposalsFound => 'Предложения не найдены';

  @override
  String get loadingProposals => 'Загрузка предложений...';

  @override
  String get refreshProposals => 'Обновить предложения';

  @override
  String get totalPendingProposals => 'Всего ожидающих предложений';

  @override
  String get highRisk => 'Высокий риск';

  @override
  String get mediumRisk => 'Средний риск';

  @override
  String get lowRisk => 'Низкий риск';

  @override
  String get communityImpact => 'Влияние на сообщество';

  @override
  String get criticalIssues => 'Критические проблемы';

  @override
  String get communityParticipation => 'Участие сообщества';

  @override
  String get noActivity => 'Нет активности';

  @override
  String get low => 'Низкий';

  @override
  String get moderate => 'Умеренный';

  @override
  String get high => 'Высокий';

  @override
  String get veryHigh => 'Очень высокий';

  @override
  String get voted => 'Проголосовано';

  @override
  String get communityVotes => 'Голоса сообщества';

  @override
  String get waitingForMoreVotes =>
      'Ожидание дополнительных голосов сообщества';

  @override
  String get proposalProcessed => 'Это предложение было обработано';

  @override
  String get supported => 'ПОДДЕРЖАНО';

  @override
  String get opposed => 'ПРОТИВ';

  @override
  String get approved => 'ОДОБРЕНО';

  @override
  String get rejected => 'ОТКЛОНЕНО';

  @override
  String get completed => 'ЗАВЕРШЕНО';

  @override
  String get pending => 'ОЖИДАЕТСЯ';

  @override
  String get critical => 'Критический';

  @override
  String get oppose => 'Против';

  @override
  String get veryLow => 'Очень низкий';

  @override
  String get deletionProposalNotificationDescription =>
      'Уведомления о результатах голосования и обновлениях по предложениям об удалении.';

  @override
  String get deletionProposalCreated => 'Предложение об удалении создано';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Ваше предложение об удалении номера $phoneNumber было отправлено на рассмотрение сообществом.';
  }

  @override
  String get proposalApproved => 'Предложение одобрено ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Предложение об удалении номера $phoneNumber было одобрено сообществом ($supportPercentage% поддержки, $totalVotes голосов).';
  }

  @override
  String get proposalRejected => 'Предложение отклонено ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Предложение об удалении номера $phoneNumber было отклонено сообществом ($supportPercentage% поддержки, $totalVotes голосов).';
  }

  @override
  String get communityVotingStarted => 'Голосование сообщества началось';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Новое предложение об удалении номера $phoneNumber открыто для голосования сообществом.';
  }

  @override
  String get votingCompleted => 'Голосование завершено';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Голосование сообщества по $phoneNumber завершено. Результат: $result ($supportPercentage% поддержки).';
  }

  @override
  String get newVoteReceived => 'Получен новый голос';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Кто-то проголосовал $voteType удаление номера $phoneNumber. Текущие голоса: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Не удалось загрузить количество голосов';

  @override
  String get voteCount => 'Количество голосов';

  @override
  String get deletionProposalInfo => 'Информация о предложении об удалении';

  @override
  String get deletionProposalDescription =>
      'Предложите номера для удаления, которые нарушают правила сообщества. Ваше участие помогает поддерживать безопасность платформы.';

  @override
  String get voteToEarnVip =>
      'Голосуйте за предложения, чтобы получить VIP-привилегии!';

  @override
  String get voteFailed => 'Голосование не удалось';

  @override
  String get searchProposals => 'Поиск предложений';

  @override
  String get defaultNotifications => 'Уведомления по умолчанию';

  @override
  String get defaultNotificationsDescription =>
      'Канал уведомлений по умолчанию для приложения.';

  @override
  String get blockedCallNotifications =>
      'Уведомления о заблокированных вызовах';

  @override
  String get blockedCallNotificationsDescription =>
      'Отображает информацию о заблокированных вызовах.';

  @override
  String get stirVerification => 'Проверка STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Отображает результаты проверки STIR/SHAKEN для номеров.';

  @override
  String get fraudAlerts => 'Предупреждения о мошенничестве';

  @override
  String get fraudAlertsDescription =>
      'Отображает предупреждения о потенциально мошеннических вызовах.';

  @override
  String get notificationFrequencyDescription =>
      'Выберите, как часто вы будете получать уведомления о новых предложениях на удаление. Вы можете получать их немедленно, пакетами или с пользовательским интервалом.';

  @override
  String get immediateNotifications => 'Немедленно';

  @override
  String get immediateNotificationsDescription =>
      'Получать уведомление, как только предложение будет создано.';

  @override
  String get batchNotifications => 'Пакетные';

  @override
  String get batchNotificationsDescription =>
      'Получать сводку уведомлений периодически.';

  @override
  String get customNotifications => 'Пользовательский';

  @override
  String get customNotificationsDescription =>
      'Определите свой собственный интервал для получения уведомлений.';

  @override
  String get customFrequency => 'Пользовательская частота';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes мин';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours ч';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String get pendingProposals => 'Ожидающие предложения';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ожидающих предложений',
      one: '1 ожидающее предложение',
      zero: 'нет ожидающих предложений',
    );
    return 'У вас $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Рекомендации';

  @override
  String get reportingGuidelines =>
      '• Сообщайте только о номерах, которые действительно вызывают проблемы\n• Предоставляйте точные и подробные причины\n• Выбирайте соответствующий уровень риска в зависимости от серьезности\n• Ложные сообщения могут привести к ограничениям учетной записи';

  @override
  String get riskLevelLabel => 'Уровень риска';

  @override
  String get riskLevelDescription => 'Уровень риска номера';

  @override
  String get phoneNumberMinDigits =>
      'Номер телефона должен состоять как минимум из 7 цифр';

  @override
  String get provideDetailedExplanation =>
      'Предоставьте подробное объяснение (минимум 10 символов)';

  @override
  String get reasonMinCharacters =>
      'Причина должна содержать не менее 10 символов';

  @override
  String get countryCodeTwoLetters => 'Код страны (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Код страны (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'например, US, CN, GB';

  @override
  String get countryCodeRequired => 'Код страны обязателен';

  @override
  String get countryCodeLengthError => 'Код страны должен состоять из 2 букв';

  @override
  String get phoneNumberLengthError =>
      'Номер телефона должен состоять как минимум из 7 цифр';

  @override
  String get reasonHint =>
      'Предоставьте подробное объяснение (минимум 10 символов)';

  @override
  String get reasonRequired => 'Причина обязательна';

  @override
  String get reasonLengthError =>
      'Причина должна содержать не менее 10 символов';

  @override
  String get guidelinesTitle => 'Рекомендации';

  @override
  String get guidelinesText =>
      '• Сообщайте только о номерах, которые действительно вызывают проблемы\n• Предоставляйте точные и подробные причины\n• Выбирайте соответствующий уровень риска в зависимости от серьезности\n• Ложные сообщения могут привести к ограничениям учетной записи';

  @override
  String get riskLevelCritical => 'Критический';

  @override
  String get riskLevelMedium => 'Средний';

  @override
  String get riskLevelVeryLow => 'Очень низкий';

  @override
  String get riskDescriptionVeryLow =>
      'Очень низкий - Незначительное неудобство, редкие звонки';

  @override
  String get riskDescriptionLow =>
      'Низкий - Нежелательные звонки время от времени';

  @override
  String get riskDescriptionMedium =>
      'Средний - Регулярный спам или телемаркетинг';

  @override
  String get riskDescriptionHigh =>
      'Высокий - Постоянные преследования или попытки мошенничества';

  @override
  String get riskDescriptionCritical =>
      'Критический - Опасное мошенничество или угрозы';

  @override
  String get notificationFrequencyTitle => 'Частота уведомлений';

  @override
  String get notificationFrequencyLabel => 'Частота уведомлений (часы)';

  @override
  String errorMessage(String error) {
    return 'Ошибка: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Голоса: $totalVotes ($supportPercentage% поддержка)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Поддержать ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Против ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Только что';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutesм назад';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hoursч назад';
  }

  @override
  String timeDaysAgo(int days) {
    return '$daysд назад';
  }

  @override
  String get notificationFrequencyHours => 'Частота уведомлений (часы)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes голосов ($supportPercentage% поддержка)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часов',
      one: '1 час',
      zero: '0 часов',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Важное уведомление';

  @override
  String get dataSourceDisclaimer =>
      'Числа взяты из Интернета и отправленных пользователями данных. Мы не можем гарантировать, что номер, удаленный однажды, не будет повторно отправлен другими пользователями или источниками. Пожалуйста, активно ищите и проверяйте информацию.';

  @override
  String get avatar => 'Аватар';

  @override
  String get location => 'Местоположение';

  @override
  String get simCardTitle => 'SIM-карта';

  @override
  String get liveActivitiesSettingsTitle => 'Настройки Live Activities';

  @override
  String get elementsSettingsTitle => 'Настройки элементов';

  @override
  String get liveActivityMode => 'Live Activity';

  @override
  String get liveActivityModeDescription =>
      'Отображает информацию о вызове в виде постоянного уведомления на экране блокировки и в Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'Тип номера телефона';

  @override
  String get liveActivitiesTestEndActivity => 'Завершить Activity';

  @override
  String get liveActivitiesTestSendNewActivity => 'Отправить новое Activity';

  @override
  String get liveActivitiesTestUpdateActivity => 'Обновить Activity';

  @override
  String get liveActivityControlsTitle => 'Элементы управления Live Activity';

  @override
  String get liveActivitiesTestTitle => 'Тест Live Activities';

  @override
  String get liveActivitiesTestSubtitle =>
      'Протестируйте уведомление live activity.';

  @override
  String get liveNotificationCustomizationTitle => 'Настройка Live уведомления';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Настройте внешний вид live уведомлений.';

  @override
  String get notification_instructions =>
      'Инструкции:\n1. Нажмите \"ОТПРАВИТЬ\", чтобы создать или обновить уведомление.\n2. Перейдите на главный экран или потяните вниз панель уведомлений, чтобы увидеть результат.\n3. Нажмите \"ЗАВЕРШИТЬ\", чтобы отклонить уведомление.';

  @override
  String get autoCancelNotification => 'Автоматическое отклонение уведомления';

  @override
  String get autoCancelNotificationDescription =>
      'Если отмечено, уведомление будет автоматически отклонено при нажатии пользователем.';

  @override
  String get setDelayTime => 'Установить время задержки';

  @override
  String get proposalDetails => 'Детали предложения';

  @override
  String get filterByStatus => 'Фильтровать по статусу';

  @override
  String get proposalNotFound => 'Предложение не найдено';

  @override
  String get processed => 'Обработано';

  @override
  String get showAll => 'Показать все';

  @override
  String get filterAndSortTitle => 'Фильтр и сортировка';

  @override
  String get filterVerifiedOwner => 'Фильтровать по проверенному владельцу';

  @override
  String get filterBy => 'Фильтровать по';

  @override
  String get sortOldest => 'Сначала старые';

  @override
  String get sortNewest => 'Сначала новые';

  @override
  String get sortMostPopular => 'Сначала популярные';

  @override
  String get sortLeastPopular => 'Сначала непопулярные';

  @override
  String get sortBy => 'Сортировать по';

  @override
  String get simRulesNotFound => 'Правила SIM-карты не найдены';

  @override
  String get simSlotRules => 'Правила слота SIM-карты';

  @override
  String get noSimCardDetected => 'SIM-карта не обнаружена';

  @override
  String get invalidSimData => 'Неверные данные SIM-карты';

  @override
  String get simCardData => 'Данные SIM-карты';

  @override
  String get simSlot => 'Слот SIM-карты';

  @override
  String get enableFiltering => 'Включить фильтрацию';

  @override
  String get detailedSettingsTitle => 'Подробные настройки';

  @override
  String get entryPointViewTitle => 'Вход';

  @override
  String get callTypeRejected => 'Отклонено';

  @override
  String get callTypeSilenced => 'Отключен';

  @override
  String get callTypeVoicemail => 'Голосовое сообщение';

  @override
  String get callTypeUnknownIntercept => 'Неизвестный перехват';

  @override
  String andMoreItems(int count) {
    return 'и еще $count элемента';
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
