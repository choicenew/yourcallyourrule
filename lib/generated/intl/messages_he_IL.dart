// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a he_IL locale. All the
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
  String get localeName => 'he_IL';

  static String m0(permissionName) => "הרשאת ${permissionName} לא ניתנה.";

  static String m1(listType) => "הוסף ל-${listType}";

  static String m2(listType) => "הוסף ל-${listType}";

  static String m3(permissionName) =>
      "עליך להשבית ידנית את הרשאת ${permissionName} בהגדרות האפליקציה.";

  static String m4(listType) => "הסר ${listType}";

  static String m5(listType) => "הסר ${listType}";

  static String m6(permissionName) =>
      "עליך להשבית ידנית את הרשאת ${permissionName} בהגדרות האפליקציה.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("אודות"),
        "accept": MessageLookupByLibrary.simpleMessage("קבל"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("מודעות מופעלות:"),
        "add": MessageLookupByLibrary.simpleMessage("הוסף"),
        "addAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד רשומה מותרת"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד רשימה שחורה"),
        "addBlockedPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד חסום"),
        "addContact": MessageLookupByLibrary.simpleMessage("הוסף איש קשר"),
        "addContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד מנוי איש קשר"),
        "addLabelPage": MessageLookupByLibrary.simpleMessage("הוסף עמוד תווית"),
        "addPluginPage": MessageLookupByLibrary.simpleMessage("הוסף עמוד תוסף"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד ביטוי רגולרי"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "הוסף עמוד רשימה שחורה של SMS"),
        "addSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד מנוי SMS"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "הוסף עמוד רשימה שחורה של טקסט SMS"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "הוסף עמודי רשימה לבנה של טקסט SMS"),
        "addSmsWhitelistPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד רשימה לבנה של SMS"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמוד מנוי"),
        "addToAllowed": MessageLookupByLibrary.simpleMessage("הוסף למותרים"),
        "addToAllowedtype": m1,
        "addToBlocked": MessageLookupByLibrary.simpleMessage("הוסף לחסומים"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("הוסף לתווית"),
        "addWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("הוסף עמודי רשימה לבנה"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("נוסף בהצלחה"),
        "all": MessageLookupByLibrary.simpleMessage("הכל"),
        "allowAllAllowedNumbers":
            MessageLookupByLibrary.simpleMessage("אפשר את כל המספרים המותרים"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "אפשר את כל המספרים ברשימה שחורה"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "אפשר את כל המספרים ברשימה לבנה"),
        "allowBlockedNumbers":
            MessageLookupByLibrary.simpleMessage("אפשר מספרים חסומים"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "אפשר תבניות ברשימה שחורה של ביטויים רגולריים"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "אפשר תבניות ברשימה לבנה של ביטויים רגולריים"),
        "allowRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("אפשר שיחות נכנסות חוזרות"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "אפשר לאפליקציה זו להציג זיהוי מתקשר"),
        "allowed": MessageLookupByLibrary.simpleMessage("מותר"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("עמוד רשומה מותרת"),
        "allowedpageview":
            MessageLookupByLibrary.simpleMessage("תצוגת עמוד מותרת"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("מענה ואז ניתוק"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "האם אתה בטוח שברצונך למחוק את הפריט"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "האם אתה בטוח שברצונך למחוק איש קשר זה?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "סגירה אוטומטית של התראה מקומית"),
        "autoUpdateDisabled":
            MessageLookupByLibrary.simpleMessage("עדכון אוטומטי מושבת"),
        "autoUpdateEnabled":
            MessageLookupByLibrary.simpleMessage("עדכון אוטומטי מופעל"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("גדלי אווטאר וסמל"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("צבע גבול אווטאר"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("גודל גבול אווטאר"),
        "avatarPosition": MessageLookupByLibrary.simpleMessage("מיקום אווטאר"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("גודל אווטאר"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("כתובת URL או נתיב של אווטאר"),
        "backgroundGradient": MessageLookupByLibrary.simpleMessage("מפל רקע"),
        "backup": MessageLookupByLibrary.simpleMessage("גיבוי"),
        "backupAndRestore":
            MessageLookupByLibrary.simpleMessage("גיבוי ושחזור"),
        "bank": MessageLookupByLibrary.simpleMessage("בנק"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("מיטוב סוללה"),
        "blacklist": MessageLookupByLibrary.simpleMessage("רשימה שחורה"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("עמוד רשימה שחורה"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("רשימה שחורה ורשימה לבנה"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("תצוגת עמוד רשימה שחורה"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "חסום שיחות מקודי אזור ספציפיים:"),
        "blockInternationalCalls":
            MessageLookupByLibrary.simpleMessage("חסום שיחות בינלאומיות:"),
        "blocked": MessageLookupByLibrary.simpleMessage("חסום"),
        "blockedCallAction":
            MessageLookupByLibrary.simpleMessage("פעולה לשיחה חסומה"),
        "blockedCallNotification":
            MessageLookupByLibrary.simpleMessage("התראה על שיחה חסומה"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics":
            MessageLookupByLibrary.simpleMessage("סטטיסטיקות שיחות חסומות"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("עמוד חסום"),
        "blockedpageview":
            MessageLookupByLibrary.simpleMessage("תצוגת עמוד חסום"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "התראה גם מאפליקציית השיחות המקורית וגם התראה מקומית"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "השתמש גם בהתראת SMS מקורית וגם בהתראה מקומית"),
        "call": MessageLookupByLibrary.simpleMessage("שיחה"),
        "callHistory": MessageLookupByLibrary.simpleMessage("היסטוריית שיחות"),
        "callLog": MessageLookupByLibrary.simpleMessage("יומן שיחות"),
        "callLogPermissionDenied":
            MessageLookupByLibrary.simpleMessage("הרשאת יומן שיחות נדחתה"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "בקשת תפקיד סינון שיחות נכשלה!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "בקשת תפקיד סינון שיחות הצליחה!"),
        "callerIdApp":
            MessageLookupByLibrary.simpleMessage("אפליקציית זיהוי מתקשר"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("סגנון זיהוי מתקשר"),
        "callerIdStyleContent":
            MessageLookupByLibrary.simpleMessage("תוכן סגנון זיהוי מתקשר"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("צבע סמל סוג שיחה"),
        "cancel": MessageLookupByLibrary.simpleMessage("ביטול"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("ספק:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("צבע ספק"),
        "carrierFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן ספק"),
        "carrierPosition": MessageLookupByLibrary.simpleMessage("מיקום ספק"),
        "charity": MessageLookupByLibrary.simpleMessage("צדקה"),
        "chooseAvatarLocalOrNetwork":
            MessageLookupByLibrary.simpleMessage("בחר אווטאר (מקומי או רשת):"),
        "chooseFromGallery": MessageLookupByLibrary.simpleMessage("בחר מגלריה"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("בחר רק קישור או קובץ"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "בחר את פעולת החסימה המוגדרת כברירת מחדל"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("בחר את השפה שלך"),
        "clientId": MessageLookupByLibrary.simpleMessage("מזהה לקוח"),
        "close": MessageLookupByLibrary.simpleMessage("סגור"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName":
            MessageLookupByLibrary.simpleMessage("שם תיקיית גיבוי ענן"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "גיבוי ענן דורש גיבוי אוטומטי"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("שירותי ענן"),
        "collection": MessageLookupByLibrary.simpleMessage("גבייה"),
        "configurationExportedToFile":
            MessageLookupByLibrary.simpleMessage("התצורה יובאה לקובץ!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("התצורה יובאה"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("התצורה יובאה בהצלחה"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("התצורה נשמרה!"),
        "confirmDeletion": MessageLookupByLibrary.simpleMessage("אשר מחיקה"),
        "contactFile": MessageLookupByLibrary.simpleMessage("קובץ איש קשר"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("עמוד מנוי איש קשר"),
        "contactUs": MessageLookupByLibrary.simpleMessage("צור קשר"),
        "contacts": MessageLookupByLibrary.simpleMessage("אנשי קשר"),
        "contactsExportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("אנשי קשר יובאו בהצלחה"),
        "contactsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("אנשי קשר יובאו בהצלחה"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("עמוד אנשי קשר"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("אנשי קשר עם מספר"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("רשימת תצוגת מנויים איש קשר"),
        "countColor": MessageLookupByLibrary.simpleMessage("צבע ספירה"),
        "countFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן ספירה"),
        "countPosition": MessageLookupByLibrary.simpleMessage("מיקום ספירה"),
        "country": MessageLookupByLibrary.simpleMessage("מדינה:"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("צבע שם מדינה"),
        "countryNameFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן שם מדינה"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("מיקום שם מדינה"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("חתוך אווטאר"),
        "customerService": MessageLookupByLibrary.simpleMessage("שירות לקוחות"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("התאמה אישית של זיהוי מתקשר"),
        "dark": MessageLookupByLibrary.simpleMessage("כהה"),
        "darkMode": MessageLookupByLibrary.simpleMessage("מצב כהה"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("מחק"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("מחק איש קשר"),
        "deleted": MessageLookupByLibrary.simpleMessage("נמחק"),
        "delivery": MessageLookupByLibrary.simpleMessage("משלוח"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "דחית את ההרשאה. ניתן להפעיל ידנית את ההרשאה בהגדרות."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("השבת התראה על שיחה חסומה"),
        "disablePermission": MessageLookupByLibrary.simpleMessage("השבת הרשאה"),
        "disableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("השבת התראה מקומית של SMS"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "השבת לאפליקציה זו להציג זיהוי מתקשר"),
        "disabled": MessageLookupByLibrary.simpleMessage("מושבת"),
        "ecommerce": MessageLookupByLibrary.simpleMessage("מסחר אלקטרוני"),
        "edit": MessageLookupByLibrary.simpleMessage("ערוך"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("ערוך אווטאר"),
        "editCode": MessageLookupByLibrary.simpleMessage("ערוך קוד"),
        "editContact": MessageLookupByLibrary.simpleMessage("ערוך איש קשר"),
        "editPluginCode": MessageLookupByLibrary.simpleMessage("ערוך קוד תוסף"),
        "education": MessageLookupByLibrary.simpleMessage("חינוך"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("מיקומי אלמנטים"),
        "email": MessageLookupByLibrary.simpleMessage("דוא\"ל"),
        "enableBlockedCallNotification":
            MessageLookupByLibrary.simpleMessage("הפעל התראה על שיחה חסומה"),
        "enableDarkModeBasedOnTime":
            MessageLookupByLibrary.simpleMessage("הפעל מצב כהה בהתבסס על זמן"),
        "enableOverlayPermission":
            MessageLookupByLibrary.simpleMessage("אפשר הרשאת שכבת-על"),
        "enableSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage("הפעל התראה מקומית של SMS"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds":
            MessageLookupByLibrary.simpleMessage("הפעל כדי להסיר מודעות"),
        "enabled": MessageLookupByLibrary.simpleMessage("מופעל"),
        "endColor": MessageLookupByLibrary.simpleMessage("צבע סיום"),
        "endcall": MessageLookupByLibrary.simpleMessage("סיים שיחה"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("הזן כתובת URL של תמונה"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("הזן קוד תוסף כאן"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("הזן כתובת URL"),
        "entry": MessageLookupByLibrary.simpleMessage("רשומה"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("הרשומה נוספה בהצלחה"),
        "error": MessageLookupByLibrary.simpleMessage("שגיאה"),
        "errorExportingContacts":
            MessageLookupByLibrary.simpleMessage("שגיאה בייצוא אנשי קשר:"),
        "errorGettingPermissionStatus":
            MessageLookupByLibrary.simpleMessage("שגיאה בקבלת סטטוס הרשאה"),
        "errorImporting": MessageLookupByLibrary.simpleMessage("שגיאה בייבוא"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "שגיאה בבקשת תפקיד סינון שיחות:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("ייצוא"),
        "exportAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד רשומה מותרת"),
        "exportAsCsv": MessageLookupByLibrary.simpleMessage("ייצא כ-CSV"),
        "exportAsJson": MessageLookupByLibrary.simpleMessage("ייצא כ-JSON"),
        "exportAsVcf": MessageLookupByLibrary.simpleMessage("ייצא כ-VCF"),
        "exportAsYaml": MessageLookupByLibrary.simpleMessage("ייצא כ-YAML"),
        "exportBlacklistPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד רשימה שחורה"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד חסום"),
        "exportContactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד מנוי איש קשר"),
        "exportContacts": MessageLookupByLibrary.simpleMessage("ייצא אנשי קשר"),
        "exportFailed": MessageLookupByLibrary.simpleMessage("ייצוא נכשל"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("פורמט ייצוא:"),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד תווית"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד תוסף"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד ביטוי רגולרי"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "ייצא עמודי רשימה שחורה של SMS"),
        "exportSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמוד מנוי SMS"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "ייצא עמודי רשימה שחורה של טקסט SMS"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "ייצא עמודי רשימה לבנה של טקסט SMS"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "ייצא עמודי רשימה לבנה של SMS"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמודי מנויים"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("ייצוא בוצע בהצלחה"),
        "exportWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("ייצא עמודי רשימה לבנה"),
        "failed": MessageLookupByLibrary.simpleMessage("נכשל"),
        "failedToAdd": MessageLookupByLibrary.simpleMessage("הוספה נכשלה:"),
        "failedToAddEntry":
            MessageLookupByLibrary.simpleMessage("הוספת הרשומה נכשלה:"),
        "feature": MessageLookupByLibrary.simpleMessage("תכונה"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("תיאור התכונה"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages":
            MessageLookupByLibrary.simpleMessage("סנן הודעות SMS נכנסות"),
        "filterRepeatedIncomingCalls":
            MessageLookupByLibrary.simpleMessage("סנן שיחות נכנסות חוזרות"),
        "financial": MessageLookupByLibrary.simpleMessage("פיננסי"),
        "firstName": MessageLookupByLibrary.simpleMessage("שם פרטי"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("סביר להניח הונאה"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("התחל"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "התחברות ל-Google Drive נכשלה"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "התחברות ל-Google Drive הצליחה"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("הגדרת Google Drive"),
        "grantPermission": MessageLookupByLibrary.simpleMessage("הענק הרשאה"),
        "group": MessageLookupByLibrary.simpleMessage("קבוצה"),
        "height": MessageLookupByLibrary.simpleMessage("גובה"),
        "history": MessageLookupByLibrary.simpleMessage("היסטוריה"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("גודל סמל"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("ייבוא"),
        "importAllowedEntryPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמוד רשומה מותרת"),
        "importBlacklistsPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמודי רשימה שחורה"),
        "importBlockedentriesPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמוד רשומות חסומות"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("ייבוא תצורה"),
        "importContacts": MessageLookupByLibrary.simpleMessage("ייבא אנשי קשר"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("ייבא מ-CSV"),
        "importFromFile": MessageLookupByLibrary.simpleMessage("ייבוא מקובץ"),
        "importFromJson": MessageLookupByLibrary.simpleMessage("ייבא מ-JSON"),
        "importFromUrl":
            MessageLookupByLibrary.simpleMessage("ייבא מכתובת URL"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("ייבא מ-VCF"),
        "importFromYaml": MessageLookupByLibrary.simpleMessage("ייבא מ-YAML"),
        "importLabelPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמוד תווית"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמוד תוסף"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמוד ביטוי רגולרי"),
        "importSmsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמוד מנוי SMS"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "ייבא עמודי רשימה שחורה של טקסט SMS"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "ייבא עמודי רשימה לבנה של טקסט SMS"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמודי מנויים"),
        "importWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("ייבא עמודי רשימה לבנה"),
        "importedSuccessfullyFromUrl":
            MessageLookupByLibrary.simpleMessage("יובא בהצלחה מכתובת URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled": MessageLookupByLibrary.simpleMessage(
            "רכישות בתוך האפליקציה מופעלות"),
        "incomingCallInterceptAction":
            MessageLookupByLibrary.simpleMessage("פעולת חסימת שיחה נכנסת"),
        "initializing": MessageLookupByLibrary.simpleMessage("אתחול..."),
        "initializingDatabase":
            MessageLookupByLibrary.simpleMessage("אתחול מסד נתונים..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials":
            MessageLookupByLibrary.simpleMessage("הזן אישורי OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("ביטוח"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "חסימת שיחות נכנסות חוזרות בטווח הזמן"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("פורמט JSON לא חוקי"),
        "isNotSubscribed": MessageLookupByLibrary.simpleMessage("לא רשום"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("רשום"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "הצטרף לערוץ ולקבוצה של Telegram לקבלת מידע נוסף"),
        "keepOnlyLatestBackup":
            MessageLookupByLibrary.simpleMessage("שמור רק את הגיבוי האחרון"),
        "keyword": MessageLookupByLibrary.simpleMessage("מילת מפתח"),
        "label": MessageLookupByLibrary.simpleMessage("תווית"),
        "labelIconColor": MessageLookupByLibrary.simpleMessage("צבע סמל תווית"),
        "labelPage": MessageLookupByLibrary.simpleMessage("עמוד תווית"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("תצוגת עמוד תווית"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("צבע תוויות"),
        "labelsFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן תוויות"),
        "labelsPosition": MessageLookupByLibrary.simpleMessage("מיקום תוויות"),
        "lastName": MessageLookupByLibrary.simpleMessage("שם משפחה"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("בהיר"),
        "link": MessageLookupByLibrary.simpleMessage("קישור"),
        "loading": MessageLookupByLibrary.simpleMessage("טוען..."),
        "loan": MessageLookupByLibrary.simpleMessage("הלוואה"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "תיקיית גיבוי מקומית רק תחת תיקיית הורדות"),
        "localCard1": MessageLookupByLibrary.simpleMessage("כרטיס מקומי 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("תוכן כרטיס מקומי 1"),
        "locationColor": MessageLookupByLibrary.simpleMessage("צבע מיקום"),
        "locationFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן מיקום"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("צבע סמל מיקום"),
        "locationPosition": MessageLookupByLibrary.simpleMessage("מיקום מיקום"),
        "login": MessageLookupByLibrary.simpleMessage("התחבר"),
        "loginFailed": MessageLookupByLibrary.simpleMessage("התחברות נכשלה"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("התחבר ל-Google Drive"),
        "loginlogoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("התחבר/התנתק מ-Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("התנתק מ-Google Drive"),
        "manageRules": MessageLookupByLibrary.simpleMessage("ניהול חוקים"),
        "manualBackup": MessageLookupByLibrary.simpleMessage("גיבוי ידני"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("מסומן על ידי"),
        "matchAnyCharacter":
            MessageLookupByLibrary.simpleMessage("התאם לכל תו:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "התאם למספרי טלפון המכילים ספרות ספציפיות:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "התאם למספרי טלפון עם תווים ספציפיים באמצע:"),
        "matchSuccessful":
            MessageLookupByLibrary.simpleMessage("Match successful!"),
        "medical": MessageLookupByLibrary.simpleMessage("רפואי"),
        "merge": MessageLookupByLibrary.simpleMessage("מזג"),
        "mergeContacts": MessageLookupByLibrary.simpleMessage("מזג אנשי קשר"),
        "mergeSelected": MessageLookupByLibrary.simpleMessage("מזג נבחרים"),
        "message": MessageLookupByLibrary.simpleMessage("הודעה"),
        "mins": MessageLookupByLibrary.simpleMessage("דקות"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("שם"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("השם לא יכול להיות ריק"),
        "nameColor": MessageLookupByLibrary.simpleMessage("צבע שם"),
        "nameFontSize": MessageLookupByLibrary.simpleMessage("גודל גופן שם"),
        "namePosition": MessageLookupByLibrary.simpleMessage("מיקום שם"),
        "next": MessageLookupByLibrary.simpleMessage("הבא"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("לא נבחרה תמונה"),
        "noIncomingSmsMessagesFilter":
            MessageLookupByLibrary.simpleMessage("אין סינון הודעות SMS נכנסות"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("לא מאומת"),
        "notifications": MessageLookupByLibrary.simpleMessage("התראות"),
        "numberColor": MessageLookupByLibrary.simpleMessage("צבע מספר"),
        "numberFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן מספר"),
        "numberPosition": MessageLookupByLibrary.simpleMessage("מיקום מספר"),
        "numberType": MessageLookupByLibrary.simpleMessage("סוג מספר"),
        "numberTypeColor": MessageLookupByLibrary.simpleMessage("צבע סוג מספר"),
        "numberTypeFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן סוג מספר"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("מיקום סוג מספר"),
        "ok": MessageLookupByLibrary.simpleMessage("אישור"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("הגדרת OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription":
            MessageLookupByLibrary.simpleMessage("מנוי זיהוי מתקשר מקוון"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "התראה רק מאפליקציית השיחות המקורית"),
        "onlyRingLocalNotification":
            MessageLookupByLibrary.simpleMessage("התראה מקומית בלבד"),
        "onlyUseOriginalSmsNotification":
            MessageLookupByLibrary.simpleMessage("השתמש רק בהתראת SMS מקורית"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("פתח תיקייה מקומית"),
        "other": MessageLookupByLibrary.simpleMessage("אחר"),
        "overlay": MessageLookupByLibrary.simpleMessage("שכבת-על"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "הרשאת שכבת-על לא ניתנה, מה שעשוי להשפיע על פונקציית תצוגת זיהוי המתקשר. ניתן להפעיל את ההרשאה בהגדרות האפליקציה."),
        "page": MessageLookupByLibrary.simpleMessage("עמוד"),
        "password": MessageLookupByLibrary.simpleMessage("סיסמה"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("הדבק JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("הדבק תצורת JSON"),
        "pasteJsonHere": MessageLookupByLibrary.simpleMessage("הדבק JSON כאן"),
        "pattern": MessageLookupByLibrary.simpleMessage("תבנית"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied": MessageLookupByLibrary.simpleMessage("הרשאה נדחתה"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("הרשאה ניתנה"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":עליך להשבית ידנית את ההרשאה בהגדרות האפליקציה."),
        "permissionInTheAppSettings":
            MessageLookupByLibrary.simpleMessage("ההרשאה בהגדרות האפליקציה."),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("ההרשאה לא ניתנה."),
        "permissions": MessageLookupByLibrary.simpleMessage("הרשאות"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("נדרשות הרשאות"),
        "phone": MessageLookupByLibrary.simpleMessage("טלפון"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("קו קווי"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("קו קווי או נייד"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("נייד"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("זימונית"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("מספר אישי"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("תשלום מיוחד"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("עלות משותפת"),
        "phoneNumberTypeTollFree": MessageLookupByLibrary.simpleMessage("חינם"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("לא ידוע"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("תא קולי"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("מספר טלפון"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("אנא הזן"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("אנא הזן מספר טלפון"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a phone number and regex pattern"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("אנא הזן תבנית"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("אנא הזן כתובת URL"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "אנא בחר קובץ או הזן כתובת URL"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("אנא בחר תווית"),
        "pleaseSelectAnExportFolder":
            MessageLookupByLibrary.simpleMessage("אנא בחר תיקיית ייצוא"),
        "pleaseSelectAnOutputFile":
            MessageLookupByLibrary.simpleMessage("אנא בחר קובץ פלט:"),
        "pleaseSelectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("אנא בחר רשומות לייצוא"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "אנא הקש על \"הענק הרשאה\" ואפשר את ההרשאה במסך הבא."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "אנא הקש על \"הגדר כברירת מחדל\" ואפשר את ההרשאה במסך הבא."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "אנא המתן לסיום אתחול מסד הנתונים."),
        "pluginPage": MessageLookupByLibrary.simpleMessage("עמוד תוסף"),
        "plugins": MessageLookupByLibrary.simpleMessage("תוספים"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("תצוגת עמוד תוספים"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("פוליטי"),
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
        "regex": MessageLookupByLibrary.simpleMessage("ביטוי רגולרי"),
        "regexPage": MessageLookupByLibrary.simpleMessage("עמוד ביטוי רגולרי"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("הסבר תבנית ביטוי רגולרי"),
        "regexPatternTest":
            MessageLookupByLibrary.simpleMessage("Regex Pattern Test"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "תבניות ביטוי רגולרי הן ביטויים רגולריים המשמשים להתאמה של מספרי טלפון."),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("Regex Phone Number Test"),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("תצוגת עמוד ביטוי רגולרי"),
        "region": MessageLookupByLibrary.simpleMessage("אזור:"),
        "reject": MessageLookupByLibrary.simpleMessage("דחה"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("דחה את כל המספרים"),
        "remove": MessageLookupByLibrary.simpleMessage("הסר"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "הסר מודעות והפעל גיבוי מקוון"),
        "removeAllowed": MessageLookupByLibrary.simpleMessage("הסר ממותרים"),
        "removeAllowedtype": m4,
        "removeBlocked": MessageLookupByLibrary.simpleMessage("הסר מחסומים"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn":
            MessageLookupByLibrary.simpleMessage("שיחות חסומות חוזרות בתוך"),
        "repeatedCalls": MessageLookupByLibrary.simpleMessage("שיחות חוזרות"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("שחזר מ-Google Drive"),
        "restoreFromLocal": MessageLookupByLibrary.simpleMessage("שחזר ממקומי"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("שחזר מ-OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("שחזר מ-WebDAV"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("שיתוף נסיעות"),
        "risk": MessageLookupByLibrary.simpleMessage("סיכון"),
        "robocall": MessageLookupByLibrary.simpleMessage("שיחת רובוט"),
        "save": MessageLookupByLibrary.simpleMessage("שמור"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts": MessageLookupByLibrary.simpleMessage("חפש אנשי קשר"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("חפש רשומות"),
        "selectALabel": MessageLookupByLibrary.simpleMessage("בחר תווית:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("בחר הכל"),
        "selectColor": MessageLookupByLibrary.simpleMessage("בחר צבע"),
        "selectCountryCodeOptional":
            MessageLookupByLibrary.simpleMessage("בחר קוד מדינה (אופציונלי)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("בחר רשומות"),
        "selectEntriesToExport":
            MessageLookupByLibrary.simpleMessage("בחר רשומות לייצוא"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "אנשי קשר נבחרים מוזגו בהצלחה"),
        "selectedLabel": MessageLookupByLibrary.simpleMessage("תווית שנבחרה"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("בחירת תיקיית ייצוא"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays":
            MessageLookupByLibrary.simpleMessage("מרווחי עדכון שירות (ימים)"),
        "settings": MessageLookupByLibrary.simpleMessage("הגדרות"),
        "settingsSaved": MessageLookupByLibrary.simpleMessage("ההגדרות נשמרו"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("הגדר כברירת מחדל"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "הגדר אפליקציית זיהוי מתקשר כברירת מחדל"),
        "sharing": MessageLookupByLibrary.simpleMessage("שיתוף"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("הצג לחצן איש קשר"),
        "showContactIconButton":
            MessageLookupByLibrary.simpleMessage("הצג לחצן סמל איש קשר"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("הצג Telegram"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("הצג WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("מציג תוצאות עבור"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("השתקה ללא מענה"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("צבע כרטיס SIM"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("גודל גופן כרטיס SIM"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("מיקום כרטיס SIM"),
        "skip": MessageLookupByLibrary.simpleMessage("דלג"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("עמוד רשימה שחורה של SMS"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("סינון SMS"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "סינון SMS דורש הרשאות SMS, התראות וטלפון. אנא הענק הרשאות אלו כדי להפעיל תכונה זו."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("התראה מקומית של SMS"),
        "smsNotification": MessageLookupByLibrary.simpleMessage("התראת SMS"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("עמוד מנוי SMS"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage":
            MessageLookupByLibrary.simpleMessage("עמוד רשימה לבנה של טקסט SMS"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "תצוגת עמוד רשימה שחורה של SMS"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("רשימת תצוגת מנויים SMS"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "תצוגת עמוד רשימה שחורה של טקסט SMS"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "תצוגת עמוד רשימה לבנה של טקסט SMS"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "תצוגת עמוד רשימה לבנה של SMS"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("סביר להניח ספאם"),
        "startColor": MessageLookupByLibrary.simpleMessage("צבע התחלה"),
        "statisticsTimeRangeMinutes":
            MessageLookupByLibrary.simpleMessage("טווח זמן סטטיסטיקה (דקות):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("צבע STIR"),
        "stirFontSize": MessageLookupByLibrary.simpleMessage("גודל גופן STIR"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("מיקום STIR"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("אחסון"),
        "subscribe": MessageLookupByLibrary.simpleMessage("הירשם"),
        "subscribed": MessageLookupByLibrary.simpleMessage("רשום"),
        "subscribedLink": MessageLookupByLibrary.simpleMessage("קישור רשום"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("עמוד רשימת מנויים"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("רשימת תצוגת מנויים"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "successfully": MessageLookupByLibrary.simpleMessage("בהצלחה"),
        "survey": MessageLookupByLibrary.simpleMessage("סקר"),
        "sync": MessageLookupByLibrary.simpleMessage("סנכרון"),
        "system": MessageLookupByLibrary.simpleMessage("מערכת"),
        "takeaway": MessageLookupByLibrary.simpleMessage("טייק אווי"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("שיווק טלפוני"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("בדיקה"),
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("צבעי טקסט ותוויות"),
        "textType": MessageLookupByLibrary.simpleMessage("סוג טקסט"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "אפליקציה זו היא כלי זיהוי מתקשר חזק המאפשר לך לזהות מתקשרים לא ידועים ולחסום שיחות לא רצויות. היא כוללת:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "אפליקציה זו זקוקה לגישה למידע יומן השיחות שלך כדי לפעול כראוי. אנא הענק הרשאה."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "הרשאה זו נדרשת על מנת שהאפליקציה שלנו תהיה אפליקציית זיהוי המתקשר המוגדרת כברירת מחדל."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "הרשאה זו נדרשת על מנת שהאפליקציה שלנו תציג מידע חשוב מעל אפליקציות אחרות.\\n\\n"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("מדריך"),
        "unknown": MessageLookupByLibrary.simpleMessage("לא ידוע"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("לא רשום"),
        "url": MessageLookupByLibrary.simpleMessage("כתובת URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("פורמט כתובת URL שגוי"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("השתמש בתמונת רשת"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Use the \'.\' character to match any single character.For example, the pattern \'123.456\' matches \'123-456\', \'123.456\', \'123a456\', etc."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^0[0-9]{2,3}\' to match phone numbers starting with \'0\' followed by 2 or 3 digits, which typically represents an area code.\nUse the pattern \'^010\' to block calls from Beijing area code (010).\nUse the pattern \'^202\' to block calls from Washington area code (202).\nReplace the \'^0[0-9]{2,3}\' area code with the specific one you want to block."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "השתמש בתבנית \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' כדי להתאים למספרי טלפון בפורמט \'XXX-XXXX-XXXX\'. החלף \'X\' בספרות הספציפיות שברצונך להתאים."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "השתמש בתבנית \'^\\+\' כדי להתאים לכל מספרי הטלפון שמתחילים בסימן פלוס, שבדרך כלל מציין מספר בינלאומי."),
        "userName": MessageLookupByLibrary.simpleMessage("שם משתמש"),
        "verified": MessageLookupByLibrary.simpleMessage("מאומת"),
        "video": MessageLookupByLibrary.simpleMessage("וידאו"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("הגדרת WebDAV"),
        "webdavUrl":
            MessageLookupByLibrary.simpleMessage("כתובת URL של WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("אתר אינטרנט"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("רשימה לבנה"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("עמוד רשימה לבנה"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("תצוגת עמוד רשימה לבנה"),
        "width": MessageLookupByLibrary.simpleMessage("רוחב"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "תמיכה בתווים כלליים לסינון גמיש"),
        "windowSize": MessageLookupByLibrary.simpleMessage("גודל חלון"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "ניתן להשתמש בתחביר ביטוי רגולרי סטנדרטי כדי להגדיר תבניות, או לבקש מ-AI ליצור את התבנית עבור Flutter. "),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "דחית את ההרשאה. ניתן להפעיל ידנית את ההרשאה בהגדרות."),
        "youHaveEnabledThePermission":
            MessageLookupByLibrary.simpleMessage("הפעלת את ההרשאה."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("עליך להשבית ידנית את"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
