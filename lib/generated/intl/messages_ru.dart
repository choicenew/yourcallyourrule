// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(permissionName) =>
      "Разрешение ${permissionName} не было предоставлено.";

  static String m1(listType) => "Добавить в ${listType}";

  static String m2(listType) => "Добавить в ${listType}";

  static String m3(permissionName) =>
      "Вам нужно вручную отключить разрешение ${permissionName} в настройках приложения.";

  static String m4(listType) => "Удалить ${listType}";

  static String m5(listType) => "Удалить ${listType}";

  static String m6(permissionName) =>
      "Вам нужно вручную отключить разрешение ${permissionName} в настройках приложения.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("О программе"),
        "accept": MessageLookupByLibrary.simpleMessage("Принять"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("Реклама включена:"),
        "add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу разрешенной записи"),
        "addBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу черного списка"),
        "addBlockedPage": MessageLookupByLibrary.simpleMessage(
            "Добавить заблокированную страницу"),
        "addContact": MessageLookupByLibrary.simpleMessage("Добавить контакт"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу подписки на контакты"),
        "addLabelPage":
            MessageLookupByLibrary.simpleMessage("Добавить страницу метки"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Добавить страницу плагина"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("Добавить страницу Regex"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу черного списка SMS"),
        "addSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу SMS-подписки"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу черного списка SMS-текста"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу белых списков SMS-текста"),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу белого списка SMS"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Добавить страницу подписки"),
        "addToAllowed":
            MessageLookupByLibrary.simpleMessage("Добавить в разрешенные"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Добавить в заблокированные"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("Добавить к метке"),
        "addWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Добавить страницу белых списков"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("успешно добавлено"),
        "all": MessageLookupByLibrary.simpleMessage("Все"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "Разрешить все разрешенные номера"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Разрешить все номера из черного списка"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Разрешить все номера из белого списка"),
        "allowBlockedNumbers": MessageLookupByLibrary.simpleMessage(
            "Разрешить заблокированные номера"),
        "allowOtherNumbers":
            MessageLookupByLibrary.simpleMessage("Allow Other Numbers"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Разрешить шаблоны черного списка Regex"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Разрешить шаблоны белого списка Regex"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Разрешить повторные входящие вызовы"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Разрешить этому приложению отображать АОН"),
        "allowed": MessageLookupByLibrary.simpleMessage("Разрешено"),
        "allowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Страница разрешенных записей"),
        "allowedpageview": MessageLookupByLibrary.simpleMessage(
            "Вид страницы разрешенных записей"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Ответить и сбросить"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Вы уверены, что хотите удалить этот элемент?"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Вы уверены, что хотите удалить этот контакт?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Автоматическое закрытие локального уведомления"),
        "autoUpdateDisabled":
            MessageLookupByLibrary.simpleMessage("Автообновление отключено"),
        "autoUpdateEnabled":
            MessageLookupByLibrary.simpleMessage("Автообновление включено"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatar": MessageLookupByLibrary.simpleMessage("Avatar"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("Размеры аватаров и значков"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("Цвет границы аватара"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("Размер границы аватара"),
        "avatarPosition":
            MessageLookupByLibrary.simpleMessage("Положение аватара"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("Размер аватара"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("URL или путь к аватару"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Градиент фона"),
        "backup": MessageLookupByLibrary.simpleMessage("Резервное копирование"),
        "backupAndRestore": MessageLookupByLibrary.simpleMessage(
            "Резервное копирование и восстановление"),
        "bank": MessageLookupByLibrary.simpleMessage("Банк"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Оптимизация батареи"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Черный список"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("Страница черного списка"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("Черный и белый списки"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("Вид страницы черного списка"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Блокировать звонки из определенных кодов зон:"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "Блокировать международные звонки:"),
        "blocked": MessageLookupByLibrary.simpleMessage("Заблокировано"),
        "blockedCallAction": MessageLookupByLibrary.simpleMessage(
            "Действие при заблокированном вызове"),
        "blockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Уведомление о заблокированном вызове"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics": MessageLookupByLibrary.simpleMessage(
            "Статистика заблокированных вызовов"),
        "blockedPage":
            MessageLookupByLibrary.simpleMessage("Заблокированная страница"),
        "blockedpageview": MessageLookupByLibrary.simpleMessage(
            "Вид заблокированной страницы"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Уведомление исходного приложения вызова и локальное уведомление"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Оригинальное SMS-уведомление и локальное уведомление"),
        "call": MessageLookupByLibrary.simpleMessage("Вызов"),
        "callHistory": MessageLookupByLibrary.simpleMessage("История вызовов"),
        "callLog": MessageLookupByLibrary.simpleMessage("Журнал вызовов"),
        "callLogPermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Разрешение на журнал вызовов отклонено"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Запрос роли фильтрации вызовов не удался!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Запрос роли фильтрации вызовов выполнен успешно!"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage("Приложение АОН"),
        "callerIdData": MessageLookupByLibrary.simpleMessage("Caller ID Data:"),
        "callerIdDataIsNotAvailable": MessageLookupByLibrary.simpleMessage(
            "Caller ID Data is not available"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle": MessageLookupByLibrary.simpleMessage("Стиль АОН"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("содержимое стиля АОН"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("Цвет значка типа вызова"),
        "cancel": MessageLookupByLibrary.simpleMessage("отмена"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Оператор:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("Цвет оператора"),
        "carrierFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта оператора"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("Положение оператора"),
        "charity": MessageLookupByLibrary.simpleMessage("Благотворительность"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Выберите аватар (локальный или сетевой):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Выбрать из галереи"),
        "chooseOnlyLinkOrFile": MessageLookupByLibrary.simpleMessage(
            "Выберите только ссылку или файл"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Выберите действие перехвата по умолчанию"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Выберите язык"),
        "clientId": MessageLookupByLibrary.simpleMessage("ID клиента"),
        "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName": MessageLookupByLibrary.simpleMessage(
            "Имя каталога облачного резервного копирования"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "Для облачного резервного копирования требуется автоматическое резервное копирование"),
        "cloudServices":
            MessageLookupByLibrary.simpleMessage("Облачные сервисы"),
        "collection": MessageLookupByLibrary.simpleMessage("Взыскание"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "Конфигурация экспортирована в файл!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Конфигурация импортирована"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Конфигурация успешно импортирована"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Конфигурация сохранена!"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Подтвердить удаление"),
        "contactFile": MessageLookupByLibrary.simpleMessage("Файл контакта"),
        "contactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Страница подписки на контакты"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Связаться с нами"),
        "contacts": MessageLookupByLibrary.simpleMessage("Контакты"),
        "contactsExportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Контакты успешно экспортированы"),
        "contactsImportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Контакты успешно импортированы"),
        "contactsPage":
            MessageLookupByLibrary.simpleMessage("Страница контактов"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("контактов с номером"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Список подписок на контакты"),
        "count": MessageLookupByLibrary.simpleMessage("Count"),
        "countColor": MessageLookupByLibrary.simpleMessage("Цвет счетчика"),
        "countFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта счетчика"),
        "countPosition":
            MessageLookupByLibrary.simpleMessage("Положение счетчика"),
        "country": MessageLookupByLibrary.simpleMessage("Страна:"),
        "countryCode": MessageLookupByLibrary.simpleMessage("Country Code"),
        "countryName": MessageLookupByLibrary.simpleMessage("Country Name"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Цвет названия страны"),
        "countryNameFontSize": MessageLookupByLibrary.simpleMessage(
            "Размер шрифта названия страны"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Положение названия страны"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("Обрезать аватар"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("Служба поддержки"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("Настроить АОН"),
        "dark": MessageLookupByLibrary.simpleMessage("Темный"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Темный режим"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "deleteContact":
            MessageLookupByLibrary.simpleMessage("Удалить контакт"),
        "deleted": MessageLookupByLibrary.simpleMessage("Удалено"),
        "delivery": MessageLookupByLibrary.simpleMessage("Доставка"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Вы отклонили разрешение. Вы можете вручную включить разрешение в настройках."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Отключить уведомление о заблокированном вызове"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("Отключить разрешение"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Отключить локальное SMS-уведомление"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Запретить этому приложению отображать АОН"),
        "disabled": MessageLookupByLibrary.simpleMessage("Выключено"),
        "ecommerce":
            MessageLookupByLibrary.simpleMessage("Электронная коммерция"),
        "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
        "editAvatar":
            MessageLookupByLibrary.simpleMessage("Редактировать аватар"),
        "editCode": MessageLookupByLibrary.simpleMessage("Редактировать код"),
        "editContact":
            MessageLookupByLibrary.simpleMessage("Редактировать контакт"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Редактировать код плагина"),
        "education": MessageLookupByLibrary.simpleMessage("Образование"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Положения элементов"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Включить уведомление о заблокированном вызове"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Включить темный режим в зависимости от времени"),
        "enableOverlayPermission": MessageLookupByLibrary.simpleMessage(
            "Включить разрешение на отображение поверх других приложений"),
        "enableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Включить локальное SMS-уведомление"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds": MessageLookupByLibrary.simpleMessage(
            "Включите, чтобы удалить рекламу"),
        "enabled": MessageLookupByLibrary.simpleMessage("Включено"),
        "endColor": MessageLookupByLibrary.simpleMessage("Конечный цвет"),
        "endcall": MessageLookupByLibrary.simpleMessage("Завершить вызов"),
        "enterCountryCode": MessageLookupByLibrary.simpleMessage(
            "Enter country code (e.g., US, CA)"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Введите URL изображения"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("Введите код плагина здесь"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("Введите URL"),
        "entry": MessageLookupByLibrary.simpleMessage("Запись"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("запись успешно добавлена"),
        "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
        "errorExportingContacts":
            MessageLookupByLibrary.simpleMessage("Ошибка экспорта контактов:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Ошибка получения статуса разрешения"),
        "errorImporting":
            MessageLookupByLibrary.simpleMessage("Ошибка импорта"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Ошибка запроса роли фильтрации вызовов:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Экспорт"),
        "exportAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу разрешенных записей"),
        "exportAsCsv":
            MessageLookupByLibrary.simpleMessage("Экспортировать как CSV"),
        "exportAsJson":
            MessageLookupByLibrary.simpleMessage("Экспортировать как JSON"),
        "exportAsVcf":
            MessageLookupByLibrary.simpleMessage("Экспортировать как VCF"),
        "exportAsYaml":
            MessageLookupByLibrary.simpleMessage("Экспортировать как YAML"),
        "exportBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу черного списка"),
        "exportBlockedPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать заблокированную страницу"),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу подписки на контакты"),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("Экспортировать контакты"),
        "exportFailed": MessageLookupByLibrary.simpleMessage("Ошибка экспорта"),
        "exportFormat":
            MessageLookupByLibrary.simpleMessage("формат экспорта:"),
        "exportLabelPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу метки"),
        "exportPluginPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу плагина"),
        "exportRegexPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу Regex"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу черных списков SMS"),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу SMS-подписки"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу черных списков SMS-текста"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу белых списков SMS-текста"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу белых списков SMS"),
        "exportSubscriptionsPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу подписок"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("Экспорт выполнен успешно"),
        "exportWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Экспортировать страницу белых списков"),
        "failed": MessageLookupByLibrary.simpleMessage("Ошибка"),
        "failedToAdd":
            MessageLookupByLibrary.simpleMessage("Не удалось добавить:"),
        "failedToAddEntry":
            MessageLookupByLibrary.simpleMessage("Не удалось добавить запись:"),
        "feature": MessageLookupByLibrary.simpleMessage("Функция"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("описание функции"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages": MessageLookupByLibrary.simpleMessage(
            "Фильтровать входящие SMS-сообщения"),
        "filterRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Фильтр повторных входящих вызовов"),
        "financial": MessageLookupByLibrary.simpleMessage("Финансы"),
        "firstName": MessageLookupByLibrary.simpleMessage("Имя"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("Вероятно, мошенничество"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Начать"),
        "googleDriveLoginFailed":
            MessageLookupByLibrary.simpleMessage("Ошибка входа в Google Диск"),
        "googleDriveLoginSuccessfully":
            MessageLookupByLibrary.simpleMessage("Успешный вход в Google Диск"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Настройки Google Диска"),
        "grantPermission":
            MessageLookupByLibrary.simpleMessage("Предоставить разрешение"),
        "group": MessageLookupByLibrary.simpleMessage("Группа"),
        "height": MessageLookupByLibrary.simpleMessage("Высота"),
        "history": MessageLookupByLibrary.simpleMessage("История"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("Размер значка"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Импорт"),
        "importAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу разрешенных записей"),
        "importBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу черных списков"),
        "importBlockedentriesPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу заблокированных записей"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Импорт конфигурации"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("Импортировать контакты"),
        "importFromCsv":
            MessageLookupByLibrary.simpleMessage("Импортировать из CSV"),
        "importFromFile":
            MessageLookupByLibrary.simpleMessage("Импортировать из файла"),
        "importFromJson":
            MessageLookupByLibrary.simpleMessage("Импортировать из JSON"),
        "importFromUrl":
            MessageLookupByLibrary.simpleMessage("Импортировать из URL"),
        "importFromVcf":
            MessageLookupByLibrary.simpleMessage("Импортировать из VCF"),
        "importFromYaml":
            MessageLookupByLibrary.simpleMessage("Импортировать из YAML"),
        "importLabelPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу метки"),
        "importPluginPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу плагина"),
        "importRegexPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу Regex"),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу SMS-подписки"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу черных списков SMS-текста"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу белых списков SMS-текста"),
        "importSubscriptionsPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу подписок"),
        "importWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Импортировать страницу белых списков"),
        "importedSuccessfullyFromUrl": MessageLookupByLibrary.simpleMessage(
            "Успешно импортировано из URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled": MessageLookupByLibrary.simpleMessage(
            "Внутриигровые покупки включены"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Действие перехвата входящего вызова"),
        "initializing":
            MessageLookupByLibrary.simpleMessage("Инициализация..."),
        "initializingDatabase": MessageLookupByLibrary.simpleMessage(
            "Инициализация базы данных..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "Введите учетные данные OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("Страхование"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Перехватывать повторные входящие вызовы в пределах временного диапазона"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Неверный формат JSON"),
        "isNotSubscribed": MessageLookupByLibrary.simpleMessage("не подписан"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("подписан"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Присоединяйтесь к каналу и группе Telegram для получения дополнительной информации"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "Хранить только последнюю резервную копию"),
        "keyword": MessageLookupByLibrary.simpleMessage("Ключевое слово"),
        "label": MessageLookupByLibrary.simpleMessage("Метка"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("Цвет значка метки"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Страница метки"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("Вид страницы меток"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("Цвет меток"),
        "labelsFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта меток"),
        "labelsPosition":
            MessageLookupByLibrary.simpleMessage("Положение меток"),
        "lastName": MessageLookupByLibrary.simpleMessage("Фамилия"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Светлый"),
        "link": MessageLookupByLibrary.simpleMessage("Ссылка"),
        "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
        "loan": MessageLookupByLibrary.simpleMessage("Кредит"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Локальный каталог резервного копирования только в папке «Загрузки»"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Локальная карта 1"),
        "localCard1Content": MessageLookupByLibrary.simpleMessage(
            "содержимое локальной карты 1"),
        "locationColor":
            MessageLookupByLibrary.simpleMessage("Цвет местоположения"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage(
            "Размер шрифта местоположения"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("Цвет значка местоположения"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Положение местоположения"),
        "login": MessageLookupByLibrary.simpleMessage("Вход"),
        "loginFailed": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Войти в Google Диск"),
        "loginlogoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Вход/выход из Google Диска"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Выйти из Google Диска"),
        "manageRules":
            MessageLookupByLibrary.simpleMessage("Управление правилами"),
        "manualBackup": MessageLookupByLibrary.simpleMessage(
            "Ручное резервное копирование"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Помечено:"),
        "matchAnyCharacter":
            MessageLookupByLibrary.simpleMessage("Сопоставить любой символ:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Сопоставлять номера телефонов, содержащие определенные цифры:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Сопоставлять номера телефонов с определенными символами посередине:"),
        "matchSuccessful":
            MessageLookupByLibrary.simpleMessage("Match successful!"),
        "medical": MessageLookupByLibrary.simpleMessage("Медицина"),
        "merge": MessageLookupByLibrary.simpleMessage("Объединить"),
        "mergeContacts":
            MessageLookupByLibrary.simpleMessage("Объединить контакты"),
        "mergeSelected":
            MessageLookupByLibrary.simpleMessage("Объединить выбранные"),
        "message": MessageLookupByLibrary.simpleMessage("Сообщение"),
        "mins": MessageLookupByLibrary.simpleMessage("мин"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Имя не может быть пустым"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Цвет имени"),
        "nameFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта имени"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Положение имени"),
        "next": MessageLookupByLibrary.simpleMessage("Далее"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("Изображение не выбрано"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Нет фильтра входящих SMS-сообщений"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Не подтверждено"),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "numberColor": MessageLookupByLibrary.simpleMessage("Цвет номера"),
        "numberFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта номера"),
        "numberPosition":
            MessageLookupByLibrary.simpleMessage("Положение номера"),
        "numberType": MessageLookupByLibrary.simpleMessage("Тип номера"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("Цвет типа номера"),
        "numberTypeFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта типа номера"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Положение типа номера"),
        "ok": MessageLookupByLibrary.simpleMessage("ОК"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("Настройки OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription":
            MessageLookupByLibrary.simpleMessage("Онлайн-подписка на АОН"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Только уведомление исходного приложения вызова"),
        "onlyRingLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Только звонок и локальное уведомление"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Использовать только оригинальное SMS-уведомление"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Открыть локальную папку"),
        "other": MessageLookupByLibrary.simpleMessage("Другое"),
        "overlay": MessageLookupByLibrary.simpleMessage(
            "Отображение поверх других приложений"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "Разрешение наложения не предоставлено, что может повлиять на функцию отображения идентификатора вызывающего абонента. Вы можете включить разрешение в настройках приложения."),
        "page": MessageLookupByLibrary.simpleMessage("Страница"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("Вставить JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("Вставить JSON-конфигурацию"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("Вставьте JSON сюда"),
        "pattern": MessageLookupByLibrary.simpleMessage("Шаблон"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Разрешение отклонено"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Разрешение предоставлено"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":Вам нужно вручную отключить разрешение в настройках приложения."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "разрешение в настройках приложения."),
        "permissionWasNotGranted": MessageLookupByLibrary.simpleMessage(
            "разрешение не было предоставлено."),
        "permissions": MessageLookupByLibrary.simpleMessage("Разрешения"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("Требуемые разрешения"),
        "phone": MessageLookupByLibrary.simpleMessage("Телефон"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Стационарный"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("Стационарный,Мобильный"),
        "phoneNumberTypeMobile":
            MessageLookupByLibrary.simpleMessage("Мобильный"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("Пейджер"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Личный номер"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("Платный"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("С разделенной оплатой"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Бесплатный"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Неизвестно"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Голосовая почта"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "pleaseEnter":
            MessageLookupByLibrary.simpleMessage("Пожалуйста, введите"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Введите номер телефона"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a phone number and regex pattern"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("Введите шаблон"),
        "pleaseEnterAnUrl": MessageLookupByLibrary.simpleMessage("Введите URL"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Выберите файл или введите URL"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("Выберите метку"),
        "pleaseSelectAnExportFolder":
            MessageLookupByLibrary.simpleMessage("Выберите папку для экспорта"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("Выберите выходной файл:"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Выберите записи для экспорта"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите «Предоставить разрешение» и разрешите его на следующем экране."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите «Настроить по умолчанию» и разрешите разрешение на следующем экране."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Пожалуйста, подождите, пока завершится инициализация базы данных."),
        "pluginData": MessageLookupByLibrary.simpleMessage("Plugin Data:"),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Страница плагина"),
        "plugins": MessageLookupByLibrary.simpleMessage("Плагины"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("Вид страницы плагинов"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("Политика"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchaseFailed":
            MessageLookupByLibrary.simpleMessage("Purchase failed:"),
        "purchaseIsBeingProcessed": MessageLookupByLibrary.simpleMessage(
            "Purchase is being processed..."),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("Purchase successful!"),
        "quarterlySubscription":
            MessageLookupByLibrary.simpleMessage("Quarterly Subscription"),
        "recordbackup": MessageLookupByLibrary.simpleMessage("RecordBackup"),
        "regex": MessageLookupByLibrary.simpleMessage("Regex"),
        "regexPage": MessageLookupByLibrary.simpleMessage("Страница Regex"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("Объяснение шаблона Regex"),
        "regexPatternTest":
            MessageLookupByLibrary.simpleMessage("Regex Pattern Test"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Шаблоны Regex - это регулярные выражения, используемые для сопоставления номеров телефонов."),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("Regex Phone Number Test"),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("Вид страницы Regex"),
        "region": MessageLookupByLibrary.simpleMessage("Регион:"),
        "reject": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Отклонить все номера"),
        "remove": MessageLookupByLibrary.simpleMessage("Удалить"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Удалить рекламу и включить онлайн-резервное копирование"),
        "removeAllowed":
            MessageLookupByLibrary.simpleMessage("Удалить из разрешенных"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("Удалить из заблокированных"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn": MessageLookupByLibrary.simpleMessage(
            "Повторные заблокированные вызовы в течение"),
        "repeatedCalls":
            MessageLookupByLibrary.simpleMessage("Повторные вызовы"),
        "restoreFromGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Восстановить из Google Диска"),
        "restoreFromLocal": MessageLookupByLibrary.simpleMessage(
            "Восстановить из локальной копии"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("Восстановить из OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Восстановить из WebDAV"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing":
            MessageLookupByLibrary.simpleMessage("Совместные поездки"),
        "risk": MessageLookupByLibrary.simpleMessage("Риск"),
        "robocall": MessageLookupByLibrary.simpleMessage("Автодозвон"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("Поиск контактов"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("Поиск записей"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("Выберите метку:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать все"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Выберите цвет"),
        "selectCountryCodeOptional": MessageLookupByLibrary.simpleMessage(
            "Выберите код страны (необязательно)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("Выбрать записи"),
        "selectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Выберите записи для экспорта"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Выбранные контакты успешно объединены"),
        "selectedLabel":
            MessageLookupByLibrary.simpleMessage("Выбранная метка"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("выбор папки для экспорта"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Интервалы обновления службы (дни)"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("Настройки сохранены"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("Настроить по умолчанию"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Настроить приложение АОН по умолчанию"),
        "sharing": MessageLookupByLibrary.simpleMessage("Поделиться"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("Показать кнопку контакта"),
        "showContactIconButton": MessageLookupByLibrary.simpleMessage(
            "Показать кнопку значка контакта"),
        "showTelegram":
            MessageLookupByLibrary.simpleMessage("Показать Telegram"),
        "showWhatsapp":
            MessageLookupByLibrary.simpleMessage("Показать WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("Результаты поиска для"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("Без звука, без ответа"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("Цвет SIM-карты"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта SIM-карты"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("Положение SIM-карты"),
        "skip": MessageLookupByLibrary.simpleMessage("Пропустить"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Страница черного списка SMS"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("Фильтрация SMS"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "Для фильтрации SMS требуются разрешения на SMS, уведомления и телефон. Предоставьте эти разрешения, чтобы включить эту функцию."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Локальное SMS-уведомление"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("SMS-уведомление"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Страница SMS-подписки"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Страница белого списка SMS-текста"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Вид страницы черного списка SMS"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Список SMS-подписок"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Вид страницы черного списка SMS-текста"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Вид страницы белых списков SMS-текста"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Вид страницы белого списка SMS"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("Вероятно, спам"),
        "startColor": MessageLookupByLibrary.simpleMessage("Начальный цвет"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Временной диапазон статистики (минуты):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("Цвет STIR"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("Размер шрифта STIR"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("Положение STIR"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Хранилище"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Подписаться"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Подписанные"),
        "subscribedLink":
            MessageLookupByLibrary.simpleMessage("Подписанная ссылка"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("Страница списка подписок"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Список подписок"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "successfully": MessageLookupByLibrary.simpleMessage("успешно"),
        "survey": MessageLookupByLibrary.simpleMessage("Опрос"),
        "sync": MessageLookupByLibrary.simpleMessage("Синхронизировать"),
        "system": MessageLookupByLibrary.simpleMessage("Системный"),
        "takeaway": MessageLookupByLibrary.simpleMessage("На вынос"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("Телемаркетинг"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("Тест"),
        "testCallerIdOverlay":
            MessageLookupByLibrary.simpleMessage("Test Caller ID Overlay"),
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("Цвета текста и меток"),
        "textType": MessageLookupByLibrary.simpleMessage("Тип текста"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Это приложение является мощным инструментом для определения номера вызывающего абонента, которое позволяет идентифицировать неизвестных абонентов и блокировать нежелательные звонки. Оно обладает следующими функциями:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Этому приложению требуется доступ к информации журнала вызовов для правильной работы. Пожалуйста, предоставьте разрешение."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "Это разрешение требуется для того, чтобы наше приложение было приложением для определения номера вызывающего абонента по умолчанию."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "Это разрешение требуется для того, чтобы наше приложение отображало важную информацию поверх других приложений.\\n\\n"),
        "toTestRules": MessageLookupByLibrary.simpleMessage("To test rules"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Руководство"),
        "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("Неподписанные"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("Неверный формат URL"),
        "useNetworkImage": MessageLookupByLibrary.simpleMessage(
            "Использовать сетевое изображение"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Используйте символ \'.\' для сопоставления любого одиночного символа. Например, шаблон \'123.456\' соответствует \'123-456\', \'123.456\', \'123a456\' и т. д."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Используйте шаблон \'^0[0-9]{2,3}\' для сопоставления номеров телефонов, начинающихся с \'0\', за которым следуют 2 или 3 цифры, что обычно представляет собой код зоны.\nИспользуйте шаблон \'^010\' для блокировки звонков из кода зоны Пекина (010).\nИспользуйте шаблон \'^202\' для блокировки звонков из кода зоны Вашингтона (202).\nЗамените код зоны \'^0[0-9]{2,3}\' на тот, который вы хотите заблокировать."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Используйте шаблон \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' для сопоставления номеров телефонов в формате \'XXX-XXXX-XXXX\'. Замените \'X\' на конкретные цифры, которые вы хотите сопоставить."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Используйте шаблон \'^\\+\' для сопоставления всех номеров телефонов, начинающихся со знака плюс, который обычно указывает на международный номер."),
        "userName": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
        "verificationPageRules":
            MessageLookupByLibrary.simpleMessage("Verification Page (Rules)"),
        "verificationResultsRules": MessageLookupByLibrary.simpleMessage(
            "Verification Results (shouldAcceptCall Rules):"),
        "verified": MessageLookupByLibrary.simpleMessage("Подтверждено"),
        "verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "verifyPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Verify Phone Number"),
        "video": MessageLookupByLibrary.simpleMessage("Видео"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("Настройки WebDAV"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("URL WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("Веб-сайт"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Белый список"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("Страница белого списка"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("Вид страницы белых списков"),
        "width": MessageLookupByLibrary.simpleMessage("Ширина"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "Поддержка подстановочных знаков для гибкой фильтрации"),
        "windowSize": MessageLookupByLibrary.simpleMessage("Размер окна"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "Вы можете использовать стандартный синтаксис регулярных выражений для определения шаблонов или попросить ИИ сгенерировать шаблон для Flutter."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Вы отклонили разрешение. Вы можете вручную включить разрешение в настройках."),
        "youHaveEnabledThePermission":
            MessageLookupByLibrary.simpleMessage("Вы включили разрешение."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("Вам нужно вручную отключить"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
