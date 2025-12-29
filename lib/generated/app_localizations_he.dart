// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get aboutContactSubscription => 'אודות מנוי אנשי קשר';

  @override
  String get aboutLabels => 'אודות תוויות';

  @override
  String get aboutPhoneSubscriptionRules => 'אודות כללי מנוי טלפון';

  @override
  String get aboutPhoneSubscriptions => 'אודות מנויי טלפון';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'הירשם לרשימות כללים לטלפון באמצעות URL, עדכן כללים באופן אוטומטי. תומך בקבצי כללים בפורמט JSON, CSV.';

  @override
  String get aboutSmsFilter => 'אודות סינון SMS';

  @override
  String get aboutSmsSubscriptionRules => 'אודות כללי מנוי SMS';

  @override
  String get aboutSubtitle => 'גרסת אפליקציה ומידע משפטי';

  @override
  String get aboutTitle => 'אודות';

  @override
  String get action => 'פעולה';

  @override
  String get actionAll => 'הכל';

  @override
  String get actionAllow => 'אפשר';

  @override
  String get actionBlock => 'חסום';

  @override
  String get actionFilterAll => 'כל המסננים';

  @override
  String get actionFilterTitle => 'סנן לפי סוג פעולה';

  @override
  String get actionFilterTooltip => 'מסנן פעולה';

  @override
  String get actionNone => 'אין פעולה';

  @override
  String get actionSilence => 'השתק';

  @override
  String actionTag(Object actionType) {
    return 'פעולה: $actionType';
  }

  @override
  String get actionType => 'סוג פעולה';

  @override
  String get actionUnknown => 'לא ידוע';

  @override
  String get add => 'הוסף';

  @override
  String get addAllowedBlockedRule => 'הוסף כלל אישור/חסימה';

  @override
  String get addAllowSubscription => 'הוסף מנוי אישור';

  @override
  String get addBlockSubscription => 'הוסף מנוי חסימה';

  @override
  String get addContactButton => 'הוסף איש קשר';

  @override
  String addContactFailed(Object error) {
    return 'נכשל הוספת איש קשר: $error';
  }

  @override
  String get addedToAllowedRules => 'נוסף לכללי האישור';

  @override
  String get addedToBlacklist => 'נוסף לרשימה השחורה';

  @override
  String get addedToBlockedRules => 'נוסף לכללי החסימה';

  @override
  String get addedToFavoriteContacts => 'נוסף לאנשי קשר מועדפים';

  @override
  String get addedToFavorites => 'נוסף למועדפים';

  @override
  String get addedToWhitelist => 'נוסף לרשימה הלבנה';

  @override
  String get addFavorite => 'הוסף למועדפים';

  @override
  String get addFilter => 'הוסף מסנן';

  @override
  String get addLabel => 'הוסף תווית';

  @override
  String get addLabelButton => 'הוסף תווית';

  @override
  String addLabelFailed(Object error) {
    return 'נכשל הוספת תווית: $error';
  }

  @override
  String get addLabelToCall => 'הוסף תווית להקלטת שיחה';

  @override
  String get addName => 'הוסף שם';

  @override
  String get addNoneSubscription => 'הוסף מנוי ללא פעולה';

  @override
  String get addOrEditContactInfo => 'משמש להוספה או עריכה של פרטי איש קשר';

  @override
  String get addPhoneMark => 'הוסף סימן טלפון';

  @override
  String get addPhoneNumberRule => 'הוסף כלל מספר טלפון';

  @override
  String get addPlugin => 'הוסף תוסף';

  @override
  String get addPluginFailed => 'נכשל הוספת תוסף';

  @override
  String addPluginFailedWithError(Object error) {
    return 'נכשל הוספת תוסף: $error';
  }

  @override
  String get addPluginFromLocalFile => 'הוסף תוסף מקובץ מקומי';

  @override
  String get addPluginFromUrl => 'הוסף תוסף מ-URL';

  @override
  String get addRegexRule => 'הוסף כלל Regex';

  @override
  String get addRule => 'הוסף כלל';

  @override
  String get addRuleButton => 'הוסף כלל';

  @override
  String addRuleFailed(Object error) {
    return 'נכשל הוספת כלל: $error';
  }

  @override
  String get addRuleTooltip => 'הוסף כלל';

  @override
  String get addSilenceSubscription => 'הוסף מנוי השתקה';

  @override
  String get addSimRuleButton => 'הוסף כלל SIM';

  @override
  String get addSmsFilterRule => 'הוסף כלל סינון SMS';

  @override
  String get addSmsRule => 'הוסף כלל SMS';

  @override
  String get addSmsSubscription => 'הוסף מנוי SMS';

  @override
  String get addSubscription => 'הוסף מנוי';

  @override
  String get addSubscriptionButton => 'הוסף מנוי';

  @override
  String addSubscriptionFailed(Object error) {
    return 'נכשל הוספת מנוי: $error';
  }

  @override
  String get addSubscriptionTooltip => 'הוסף מנוי';

  @override
  String get addToAllowedRules => 'הוסף לכללי האישור';

  @override
  String get addToBlacklist => 'הוסף לרשימה השחורה';

  @override
  String get addToBlockedRules => 'הוסף לכללי החסימה';

  @override
  String get addToFavoriteContacts => 'הוסף לאנשי קשר מועדפים';

  @override
  String get addToFavorites => 'הוסף למועדפים';

  @override
  String get addToRules => 'הוסף לכללים';

  @override
  String get addToWhitelist => 'הוסף לרשימה הלבנה';

  @override
  String get adPlaceholder => 'פרסומת';

  @override
  String get agent => 'סוכן';

  @override
  String get all => 'הכל';

  @override
  String get allCallsTab => 'הכל';

  @override
  String get allDataClearedSuccessfully => 'כל הנתונים נוקו בהצלחה';

  @override
  String get allow => 'אפשר';

  @override
  String get allowAllAllowRules => 'אפשר את כל כללי האישור';

  @override
  String get allowAllAllowRulesDesc => 'אפשר שיחות מכללי האישור';

  @override
  String get allowAllBlacklistedNumbers => 'אפשר את כל המספרים החסומים';

  @override
  String get allowAllBlacklistedNumbersDesc => 'אפשר שיחות מרשימת החסימה';

  @override
  String get allowAllBlockRules => 'אפשר את כל כללי החסימה';

  @override
  String get allowAllBlockRulesDesc => 'אפשר שיחות מכללי החסימה';

  @override
  String get allowAllowedNumbers => 'אפשר מספרים מורשים';

  @override
  String get allowAllowedNumbersDesc => 'אפשר שיחות מרשימת האישור';

  @override
  String get allowBlock => 'אישור/חסימה';

  @override
  String get allowBlockedNumbers => 'אפשר מספרים חסומים';

  @override
  String get allowBlockedNumbersDesc => 'אפשר שיחות מרשימת החסימה';

  @override
  String get allowedBlockedRule => 'כלל אישור/חסימה';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'ערוך כלל אישור/חסימה';

  @override
  String get allowedBlockedRuleManagement => 'ניהול כללי אישור/חסימה';

  @override
  String get allowNonExceededNumbers => 'אפשר מספרים שלא חרגו מהסף';

  @override
  String get allowNonExceededNumbersDescription =>
      'אפשר באופן אוטומטי מספרים שלא חרגו מסף הכמות';

  @override
  String get allowRegexAllowRules => 'אפשר כללי Regex לאישור';

  @override
  String get allowRegexAllowRulesDesc => 'אפשר התאמת תבנית Regex לכללי אישור';

  @override
  String get allowRegexAllowRulesDescription => 'אפשר כללי אישור מבוססי Regex';

  @override
  String get allowRegexBlockRules => 'אפשר כללי Regex לחסימה';

  @override
  String get allowRegexBlockRulesDesc => 'אפשר התאמת תבנית Regex לכללי חסימה';

  @override
  String get allowRegexBlockRulesDescription => 'אפשר כללי חסימה מבוססי Regex';

  @override
  String get allowRule => 'כלל אישור';

  @override
  String get allowRules => 'כללי אישור';

  @override
  String get allowWhitelistedNumbers => 'אפשר מספרים ברשימה הלבנה';

  @override
  String get allowWhitelistedNumbersDescription =>
      'אפשר את כל המספרים ברשימה הלבנה';

  @override
  String get allPermissionsGranted => 'כל ההרשאות הוענקו';

  @override
  String get allSettingsCompleted => 'כל ההגדרות הושלמו.';

  @override
  String allUpdateSuccess(Object count) {
    return 'כל העדכונים הושלמו ($count כללים)';
  }

  @override
  String get answerThenHangup => 'ענה ואז נתק';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. כל הזכויות שמורות.';

  @override
  String get applicationSoftware => 'תוכנת יישום';

  @override
  String get apply => 'החל';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'אימות נכשל: אנא בדוק את מזהה הלקוח והמפתח';

  @override
  String get authorizationFailedMessage => 'אימות נכשל';

  @override
  String get authorizationSuccessMessage => 'אימות הצליח';

  @override
  String get authorizeLoginButton => 'אשר כניסה';

  @override
  String get automotiveIndustry => 'תעשיית הרכב';

  @override
  String get autoSyncLabel => 'סנכרון אוטומטי';

  @override
  String get autoUpdate => 'עדכון אוטומטי';

  @override
  String get autoUpdateDescription =>
      'הגדר מרווחי עדכון אוטומטיים למנויים או עדכן ידנית';

  @override
  String get autoUpdateSettings => 'הגדרות עדכון אוטומטי';

  @override
  String get autoUpdateSettingsSubtitle =>
      'נהל עדכונים אוטומטיים עבור כללים ותוספים';

  @override
  String get autoUpdateSettingsTitle => 'הגדרות עדכון אוטומטי';

  @override
  String get autoUpdateSubtitle => 'נהל עדכונים אוטומטיים עבור כללים ותוספים';

  @override
  String get autoUpdateTitle => 'עדכון אוטומטי';

  @override
  String get avatarBorderColor => 'צבע גבול התמונה האישית';

  @override
  String get avatarBorderSize => 'גודל גבול התמונה האישית';

  @override
  String get avatarIconSizesSetting => 'גודל תמונות אישיות וסמלים';

  @override
  String get avatarPosition => 'מיקום תמונה אישית';

  @override
  String get avatarSize => 'גודל תמונה אישית';

  @override
  String axisPosition(Object axis) {
    return 'מיקום $axis';
  }

  @override
  String get backgroundGradientSetting => 'מעבר צבע רקע';

  @override
  String get backup => 'גיבוי';

  @override
  String get backupAndRestore => 'גיבוי ושחזור';

  @override
  String get backupAndRestoreSubtitle => 'גבה או שחזר נתוני יישום';

  @override
  String get backupAndRestoreTitle => 'גיבוי ושחזור';

  @override
  String get backupFailed => 'גיבוי נכשל';

  @override
  String get backupFailedMessage => 'גיבוי נכשל';

  @override
  String backupFailedWithError(Object error) {
    return 'גיבוי נכשל: $error';
  }

  @override
  String get backupRestoreSubtitle => 'גבה או שחזר נתוני יישום';

  @override
  String get backupRestoreTitle => 'גיבוי ושחזור';

  @override
  String get backupSectionTitle => 'גיבוי';

  @override
  String get backupSettings => 'הגדרות גיבוי';

  @override
  String get backupSettingsDialogTitle => 'הגדרות גיבוי';

  @override
  String get backupSettingsTitle => 'הגדרות גיבוי';

  @override
  String get backupSuccessMessage => 'הועלה בהצלחה לענן';

  @override
  String backupSuccessToLocal(Object path) {
    return 'הגיבוי הוצלח ל: $path';
  }

  @override
  String get backupToCloud => 'גיבוי לענן';

  @override
  String get backupToCloudDescription => 'גבה הגדרות וכללים לאחסון ענן';

  @override
  String backupToCloudFailed(Object error) {
    return 'כשל בגיבוי לענן: $error';
  }

  @override
  String get backupToCloudLabel => 'גיבוי לענן';

  @override
  String get backupToCloudSuccess => 'הועלה בהצלחה לענן';

  @override
  String get backupToCloudTitle => 'גיבוי לענן';

  @override
  String get backupToLocalLabel => 'גיבוי למקומי';

  @override
  String get bank => 'בנק';

  @override
  String get basicInfo => 'מידע בסיסי';

  @override
  String get basicRuleFilter => 'מסנן כללים בסיסי';

  @override
  String get basicRuleFiltering => 'סינון כללים בסיסי';

  @override
  String get basicRuleFilteringExplanation =>
      '• סינון כללים בסיסי: סינון כללים על בסיס רשימה שחורה, רשימה לבנה וביטויים רגולריים';

  @override
  String get basicRuleFilterSettings => 'הגדרות מסנן כללים בסיסי';

  @override
  String get basicRuleFilterSubtitle =>
      'סנן שיחות באמצעות רשימה שחורה/לבנה וביטויים רגולריים';

  @override
  String get batchDeleteContacts => 'מחיקת אנשי קשר באצווה';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'האם אתה בטוח שברצונך למחוק $count אנשי קשר נבחרים?';
  }

  @override
  String get batchDeleteFailed => 'מחיקה באצווה נכשלה';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'האם אתה בטוח שברצונך למחוק $count תוויות?';
  }

  @override
  String get blacklist => 'רשימה שחורה';

  @override
  String get blacklistingAndWhitelisting => 'רישום שחור ולבן';

  @override
  String get blacklistLabel => 'רשימה שחורה';

  @override
  String get blackWhiteList => 'רשימה שחורה/לבנה';

  @override
  String get block => 'חסום';

  @override
  String get blockCalls => 'חסום שיחות';

  @override
  String get blocked => 'חסום';

  @override
  String get blockedCallAction => 'פעולת שיחה חסומה';

  @override
  String get blockedCalls => 'שיחות חסומות';

  @override
  String get blockedCallsTitle => 'שיחות חסומות';

  @override
  String get blockedCommunications => 'תקשורות חסומות';

  @override
  String get blockedPhoneLabel => 'שיחות חסומות';

  @override
  String get blockedSpamCalls => 'שיחות ספאם חסומות';

  @override
  String get blockingTrend => 'מגמת חסימה';

  @override
  String get blockInternationalCalls =>
      'מתאים למספרים שאינם מתחילים ב- + או 00';

  @override
  String get blockInternationalCallsTitle => 'חסום שיחות בינלאומיות';

  @override
  String get blockLandlineNumbersTitle => 'חסום מספרי קווי קרקע';

  @override
  String get blockMobileNumbers => 'מתאים למספרים שאינם מתחילים ב- 13-19';

  @override
  String get blockMobileNumbersTitle => 'חסום מספרי סלולר';

  @override
  String get blockPremiumRateNumbers =>
      'מתאים למספרים שאינם מתחילים ב- 118 או 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'חסום מספרי פרימיום';

  @override
  String get blockRule => 'כלל חסימה';

  @override
  String get blockRules => 'כללי חסימה';

  @override
  String get blockSpecificAreaCodes =>
      'מתאים למספרים שמתחילים ב- 0 + 2-3 ספרות';

  @override
  String get blockSpecificAreaCodesTitle => 'חסום קידומות אזור ספציפיות:';

  @override
  String get blockTypeAnalysisTitle => 'ניתוח סוגי חסימות';

  @override
  String get both => 'שניהם';

  @override
  String get bulkDelete => 'מחיקת אנשי קשר באצווה';

  @override
  String get bulkDeleteContacts => 'מחיקת אנשי קשר באצווה';

  @override
  String get bulkDeleteLabels => 'מחיקת תוויות באצווה';

  @override
  String get call => 'שיחה';

  @override
  String get callback => 'התקשר בחזרה';

  @override
  String callbackTo(String number) {
    return 'התקשר בחזרה אל $number';
  }

  @override
  String get callBlocking => 'חסימת שיחות';

  @override
  String get callerIdApp => 'אפליקציית מזהה מתקשר';

  @override
  String get callerIdCustomizationTitle => 'התאם אישית את מזהה המתקשר';

  @override
  String get callerIdDialogTitle => 'מידע על מזהה מתקשר';

  @override
  String get callerIdDisplayMode => 'מצב תצוגת מזהה המתקשר';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'סומן על ידי $count';
  }

  @override
  String get callerIdPreview => 'תצוגה מקדימה של מזהה המתקשר';

  @override
  String get callFilter => 'סינון שיחות';

  @override
  String get callFilterDescription =>
      'כאשר מופעל, שיחות נכנסות נבדקות מול רשימת הכללים שלהלן. כללי סינון שיחות אינם מסונכרנים בין מכשירים כברירת מחדל.';

  @override
  String get callFilterRules => 'כללי סינון שיחות';

  @override
  String get callFilterRulesDescription => 'הגדר כללים בסיסיים לסינון שיחות';

  @override
  String get callFilterSettings => 'הגדרות סינון שיחות';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'הגדר מגבלות תדירות שיחות וכללי חסימה';

  @override
  String get callFrequencyInterceptionTitle => 'יירוט תדירות שיחות';

  @override
  String get callHistory => 'היסטוריית שיחות';

  @override
  String get callHistoryInfoDesc =>
      'כאן מוצגת היסטוריית השיחות שלך, כולל שיחות נכנסות, יוצאות ולא נענו.';

  @override
  String get callHistoryInfoTitle => 'היסטוריית שיחות';

  @override
  String callHistoryInitFailed(Object error) {
    return 'נכשל באתחול היסטוריית שיחות: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'נכשל ברענון היסטוריית שיחות: $error';
  }

  @override
  String get callHistoryTab => 'היסטוריית שיחות';

  @override
  String get callHistoryTimelineEarlier => 'מוקדם יותר';

  @override
  String get callHistoryTimelineToday => 'היום';

  @override
  String get callHistoryTimelineYesterday => 'אתמול';

  @override
  String get callScreeningPermission => 'הרשאת סינון שיחות';

  @override
  String get callScreeningPermissionDescription =>
      'משמש לסינון וחסימת שיחות ספאם.';

  @override
  String get callScreeningPermissionNotGranted =>
      'הרשאת סינון שיחות לא הוענקה, עשויה להשפיע על פונקציונליות האפליקציה.';

  @override
  String get callSettingsSubtitle => 'הגדרות מזהה מתקשר, סינון וחסימה';

  @override
  String get callSettingsTitle => 'הגדרות שיחות';

  @override
  String get callStatistics => 'סטטיסטיקות שיחות';

  @override
  String get callTypeAnswered => 'נענו';

  @override
  String get callTypeBlocked => 'נחסמו';

  @override
  String get callTypeIconColor => 'צבע אייקון סוג שיחה';

  @override
  String get callTypeMissed => 'שיחה שלא נענתה';

  @override
  String get callTypeOutgoing => 'יוצאת';

  @override
  String get callTypePosition => 'מיקום סוג שיחה';

  @override
  String get callTypeUnknown => 'לא ידוע';

  @override
  String get cancelButton => 'ביטול';

  @override
  String get carRental => 'השכרת רכב';

  @override
  String get carrier => 'ספק';

  @override
  String get carrierColor => 'צבע ספק';

  @override
  String get carrierFontSize => 'גודל גופן ספק';

  @override
  String get carrierPosition => 'מיקום ספק';

  @override
  String get changeLabel => 'שנה תווית';

  @override
  String changePluginStatusFailed(Object error) {
    return 'נכשל בשינוי סטטוס תוסף: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'נכשל בשינוי סטטוס מנוי: $error';
  }

  @override
  String get changeTag => 'שנה תג';

  @override
  String get charity => 'צדקה';

  @override
  String chartMonthFormat(int month) {
    return 'חודש $month';
  }

  @override
  String get chartOneDayAgo => 'לפני יום אחד';

  @override
  String get chartOneMonthAgo => 'לפני חודש אחד';

  @override
  String get chartOneWeekAgo => 'לפני שבוע אחד';

  @override
  String get chartTenDaysAgo => 'לפני 10 ימים';

  @override
  String get chartThreeDaysAgo => 'לפני 3 ימים';

  @override
  String get chartToday => 'היום';

  @override
  String get checkFileFormat => 'אנא בדוק את פורמט הקובץ או הרשאות';

  @override
  String checkPermissionFailed(Object error) {
    return 'נכשל בבדיקת הרשאות: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'בחר את פעולת היירוט המוגדרת כברירת מחדל';

  @override
  String get clearAllData => 'מחק את כל הנתונים';

  @override
  String get clearAllDataConfirmation =>
      'האם אתה בטוח שברצונך למחוק את כל נתוני האפליקציה? לא ניתן לבטל פעולה זו.';

  @override
  String get clearAllDataDescription => 'מחק את כל נתוני האפליקציה';

  @override
  String get clearAllDataLabel => 'מחק את כל הנתונים';

  @override
  String get clearFilter => 'נקה מסנן';

  @override
  String get clearLabelFilter => 'נקה מסנן תווית';

  @override
  String get clearLabelFilterButton => 'נקה מסנן תווית';

  @override
  String get closeButton => 'סגור';

  @override
  String get cloudSync => 'סנכרון ענן';

  @override
  String get cloudSyncAndBackupTitle => 'סנכרון וגיבוי בענן';

  @override
  String get cloudSyncSettingsSubtitle =>
      'הגדר WebDAV, OneDrive ו-Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'הגדרות סנכרון ענן';

  @override
  String get cloudSyncTitle => 'סנכרון ענן';

  @override
  String get collapseLabelSelector => 'כווץ בוחר תווית';

  @override
  String get collection => 'גביית חובות';

  @override
  String get colorPickerTitle => 'בחר צבע';

  @override
  String get configManagement => 'ניהול תצורה';

  @override
  String get configUpdated => 'תצורה עודכנה';

  @override
  String get configurationAdvice =>
      'באמצעות תצורה נכונה, ניתן להגדיר אסטרטגיות סינון שונות עבור SIM עבודה ואישי.';

  @override
  String get configureBackupOptions => 'הגדר אפשרויות גיבוי';

  @override
  String get configureBackupOptionsSubtitle => 'הגדר אפשרויות גיבוי';

  @override
  String get configureCloudSyncService => 'הגדר שירות סנכרון ענן';

  @override
  String get configureCloudSyncServiceHint =>
      'אנא הגדר שירות סנכרון ענן כדי לאפשר סנכרון בין מספר מכשירים.';

  @override
  String get configureCloudSyncServiceMessage =>
      'אנא הגדר שירות סנכרון ענן כדי לאפשר סנכרון בין מספר מכשירים.';

  @override
  String get configureSimCardFilterRules => 'הגדר כללי סינון כרטיס SIM';

  @override
  String get configureSyncServiceHint =>
      'אנא הגדר שירות סנכרון בהגדרות סנכרון הענן תחילה';

  @override
  String get confirm => 'אישור';

  @override
  String get confirmBatchDeleteContacts =>
      'האם אתה בטוח שברצונך למחוק את הנבחרים';

  @override
  String get confirmButton => 'אישור';

  @override
  String get confirmDelete => 'אישור מחיקה';

  @override
  String get confirmDeleteContact => 'האם אתה בטוח שברצונך למחוק';

  @override
  String get confirmDeleteContactName => 'אישור מחיקה?';

  @override
  String get confirmDeleteFilter => 'האם אתה בטוח שברצונך למחוק מסנן זה?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'האם אתה בטוח שברצונך למחוק את התווית \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'האם אתה בטוח שברצונך למחוק את התוסף \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'האם אתה בטוח שברצונך למחוק $count תוספים?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'האם אתה בטוח שברצונך למחוק כלל זה? לא ניתן לבטל פעולה זו.';

  @override
  String get confirmDeleteSelectedContacts =>
      'האם אתה בטוח שברצונך למחוק אנשי קשר נבחרים?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'האם אתה בטוח שברצונך למחוק כלל מסנן SMS זה?';

  @override
  String get confirmDeleteSmsRule => 'האם אתה בטוח שברצונך למחוק כלל SMS זה?';

  @override
  String get confirmDeleteSubscription => 'האם אתה בטוח שברצונך למחוק מנוי זה?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'האם אתה בטוח שברצונך למחוק $name?';
  }

  @override
  String get confirmPassword => 'אישור סיסמה';

  @override
  String get confirmPasswordLabel => 'אישור סיסמה';

  @override
  String get connectedStatus => 'מחובר';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'החיבור נכשל: אנא בדוק את כתובת השרת, שם המשתמש והסיסמה';

  @override
  String get connectionFailedMessage => 'החיבור נכשל';

  @override
  String get connectionStatusLabel => 'סטטוס חיבור';

  @override
  String get connectionSuccessMessage => 'החיבור הצליח';

  @override
  String get contactAddSuccess => 'איש קשר נוסף בהצלחה';

  @override
  String get contactDeleted => 'איש קשר נמחק';

  @override
  String get contactEditDialog => 'דיאלוג עריכת איש קשר';

  @override
  String get contactNameHint => 'הזן שם איש קשר (אופציונלי)';

  @override
  String get contactNameLabel => 'שם';

  @override
  String get contactNameOptional => 'שם איש קשר (אופציונלי)';

  @override
  String get contactNotFound => 'איש קשר לא נמצא';

  @override
  String get contacts => 'אנשי קשר';

  @override
  String contactsDeleted(Object count) {
    return 'נמחקו $count אנשי קשר';
  }

  @override
  String get contactSettingsSubtitle => 'ניהול אנשי קשר והגדרות תווית';

  @override
  String get contactSettingsTitle => 'הגדרות אנשי קשר';

  @override
  String contactsLoadingFailed(Object error) {
    return 'טעינת אנשי קשר נכשלה: $error';
  }

  @override
  String get contactsManagement => 'ניהול אנשי קשר';

  @override
  String get contactsManagementPageTitle => 'דף ניהול אנשי קשר';

  @override
  String get contactsPageTitle => 'ניהול אנשי קשר';

  @override
  String get contactsPermission => 'הרשאת אנשי קשר';

  @override
  String get contactsPermissionDescription => 'משמש לזיהוי שיחות מאנשי קשר.';

  @override
  String get contactsTab => 'אנשי קשר';

  @override
  String get contactSubscriptionDescription =>
      'הירשם לרשימות אנשי קשר באמצעות URL, עדכן אוטומטית פרטי אנשי קשר ותוויות. תומך בנתוני פורמט JSON.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'טעינת מנויי אנשי קשר נכשלה: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'מנויי אנשי קשר';

  @override
  String get contactUpdateSuccess => 'איש קשר עודכן בהצלחה';

  @override
  String get contactUs => 'צור קשר';

  @override
  String get content => 'תוכן';

  @override
  String get contentRegex => 'ביטוי רגולרי לתוכן';

  @override
  String get countColor => 'צבע ספירה';

  @override
  String get countFontSize => 'גודל גופן ספירה';

  @override
  String get countPosition => 'מיקום ספירה';

  @override
  String get country => 'מדינה';

  @override
  String get countryNameColor => 'צבע שם מדינה';

  @override
  String get countryNameFontSize => 'גודל גופן שם מדינה';

  @override
  String get countryRegionNamePosition => 'מיקום שם מדינה/אזור';

  @override
  String get countrySelectionDialog => 'דיאלוג בחירת מדינה';

  @override
  String get countrySelectionDialogDescription =>
      'משמש לבחירת מדינה לשליפת פרטי מזהה מתקשר';

  @override
  String get countThresholdDescription =>
      'הגדר את סף הספירה המינימלי הנדרש להפעלת פעולות סינון';

  @override
  String get countThresholdLabel => 'סף ספירה';

  @override
  String get countThresholdSettings => 'הגדרות סף ספירה';

  @override
  String countThresholdValue(Object count) {
    return 'סף ספירה: $count';
  }

  @override
  String get createdRules => 'כללים שנוצרו';

  @override
  String get csvFormat => 'פורמט CSV';

  @override
  String get currentDeviceChip => 'נוכחי';

  @override
  String get currentDeviceLabel => 'תווית התקן נוכחי';

  @override
  String get currentDeviceTitle => 'התקן נוכחי';

  @override
  String get currentLabels => 'תוויות נוכחיות:';

  @override
  String get currentLanguage => 'שפה נוכחית';

  @override
  String get currentPasswordLabel => 'סיסמה נוכחית';

  @override
  String get customerService => 'שירות לקוחות';

  @override
  String get customRange => 'טווח מותאם אישית';

  @override
  String get dailyStatistics => 'סטטיסטיקה יומית';

  @override
  String get dailyStatisticsDesc =>
      'קבל סטטיסטיקה יומית על שיחות והודעות חסומות';

  @override
  String get dashboardTab => 'לוח מחוונים';

  @override
  String get dataAnalysis => 'ניתוח נתונים';

  @override
  String get dataAnalysisDashboardPage => 'דף לוח מחוונים לניתוח נתונים';

  @override
  String get dataExport => 'ייצוא נתונים';

  @override
  String dataLoadFailure(Object error) {
    return 'טעינת נתונים נכשלה: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'טעינת נתונים נכשלה: $error';
  }

  @override
  String get dataMigration => 'העברת נתונים';

  @override
  String get dataMigrationDescription =>
      'תכונה זו מאפשרת לך להעביר את כל הנתונים שלך בין מכשירים. כרגע, תוכל להשתמש בתכונות הגיבוי והשחזור כדי להעביר את הנתונים שלך באופן ידני.';

  @override
  String get dataMigrationDialogContent =>
      'תכונה זו מאפשרת לך להעביר את כל הנתונים שלך בין מכשירים. כרגע, תוכל להשתמש בתכונות הגיבוי והשחזור כדי להעביר את הנתונים שלך באופן ידני.';

  @override
  String get dataMigrationDialogTitle => 'העברת נתונים';

  @override
  String get dataMigrationSectionTitle => 'העברת נתונים';

  @override
  String get dataSourceReminder => 'תזכורת מקור נתונים';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ימים',
      one: 'יום אחד',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days ימי VIP';
  }

  @override
  String get debtCollection => 'גביית חובות';

  @override
  String get defaultPeriod => 'שבוע';

  @override
  String get delete => 'מחק';

  @override
  String get deleteButton => 'מחק';

  @override
  String get deleteContact => 'מחק איש קשר';

  @override
  String deleteContactConfirm(Object name) {
    return 'האם אתה בטוח שברצונך למחוק את $name?';
  }

  @override
  String get deleteContactConfirmation => 'האם אתה בטוח שברצונך למחוק איש קשר';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'האם אתה בטוח שברצונך למחוק את $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'מחק התקן';

  @override
  String deleteFailed(Object error) {
    return 'מחיקה נכשלה: $error';
  }

  @override
  String get deleteFilter => 'מחק מסנן';

  @override
  String get deleteLabel => 'מחק תווית';

  @override
  String deleteLabelFailed(Object error) {
    return 'מחיקת תווית נכשלה: $error';
  }

  @override
  String get deletePlugin => 'מחק תוסף';

  @override
  String deletePluginFailed(Object error) {
    return 'מחיקת תוסף נכשלה: $error';
  }

  @override
  String get deletePlugins => 'מחק תוספים';

  @override
  String deletePluginsFailed(Object error) {
    return 'מחיקת תוספים נכשלה: $error';
  }

  @override
  String get deleteRule => 'מחק כלל';

  @override
  String deleteRuleFailed(Object error) {
    return 'מחיקה נכשלה: $error';
  }

  @override
  String get deleteSelected => 'מחק נבחרים';

  @override
  String get deleteSmsRule => 'מחק כלל SMS';

  @override
  String get deleteSubscription => 'מחק מנוי';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'האם אתה בטוח שברצונך למחוק את המנוי \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'מחיקת מנוי נכשלה: $error';
  }

  @override
  String get deleteSuccess => 'המחיקה הצליחה';

  @override
  String get delivery => 'משלוח';

  @override
  String get deviceDeletedSuccessfully => 'ההתקן נמחק בהצלחה';

  @override
  String get deviceDeletedSuccessfullyMessage => 'ההתקן נמחק בהצלחה';

  @override
  String get deviceIdLabel => 'מזהה התקן';

  @override
  String get deviceIDLabel => 'מזהה התקן';

  @override
  String get deviceManagementSubtitle => 'נהל סנכרון בין מספר התקנים';

  @override
  String get deviceManagementTitle => 'ניהול התקנים';

  @override
  String get deviceModelLabel => 'דגם התקן';

  @override
  String get deviceName => 'שם התקן';

  @override
  String get deviceNameCannotBeEmpty => 'שם המכשיר לא יכול להיות ריק';

  @override
  String get deviceNameHint => 'הכנס שם מכשיר';

  @override
  String get deviceNameLabel => 'שם מכשיר';

  @override
  String get deviceRenamedSuccessfully => 'המכשיר שונה בהצלחה';

  @override
  String get deviceRenamedSuccessfullyMessage => 'המכשיר שונה בהצלחה';

  @override
  String get devicesSyncedSuccessfully => 'מכשירים סונכרנו בהצלחה';

  @override
  String get devicesSyncedSuccessfullyMessage => 'מכשירים סונכרנו בהצלחה';

  @override
  String get devicesSynchronizedSuccessfullyMessage => 'מכשירים סונכרנו בהצלחה';

  @override
  String get deviceUnregisteredSuccessfullyMessage => 'המכשיר נרשם בהצלחה';

  @override
  String get dialogTitle => 'הסבר דפוס Regex';

  @override
  String get differentFromLocalCounter =>
      'תכונה זו שונה ממסנן המונה המקומי, שכן היא מתמקדת בדפוסי שיחות חוזרים בפרק זמן קצר במקום בספירת סימונים לטווח ארוך.';

  @override
  String get disabled => 'מושבת';

  @override
  String get disabledStatus => 'מושבת';

  @override
  String get disableGlobalPlugins => 'בטל פלאגינים גלובליים';

  @override
  String get disableSubscriptionSuccessfully => 'השבתה מנוי בהצלחה';

  @override
  String get disconnectButton => 'נתק';

  @override
  String get disconnectedMessage => 'מנותק';

  @override
  String get disconnectedStatus => 'מנותק';

  @override
  String get disconnectFailedMessage => 'ניתוק נכשל';

  @override
  String get done => 'סיום';

  @override
  String get dualSimAdvice =>
      'תכונה זו שימושית במיוחד עבור טלפונים עם שני SIM כדי להגדיר אסטרטגיות סינון שונות עבור כרטיסי SIM עבודה ואישיים.';

  @override
  String get earlier => 'מוקדם יותר';

  @override
  String get ecommerce => 'מסחר אלקטרוני';

  @override
  String get edit => 'ערוך';

  @override
  String get editContact => 'ערוך איש קשר';

  @override
  String get editFilter => 'ערוך מסנן';

  @override
  String get editLabel => 'ערוך תווית';

  @override
  String get editPhoneRule => 'ערוך כלל טלפון';

  @override
  String get editPhoneRules => 'משמש לעריכת כללי טלפון';

  @override
  String get editPhoneRuleTitle => 'ערוך כלל טלפון';

  @override
  String get editRule => 'ערוך כלל';

  @override
  String get editSmsRule => 'ערוך כלל SMS';

  @override
  String get education => 'חינוך';

  @override
  String get elementPositionsSetting => 'מיקומי אלמנטים';

  @override
  String get email => 'דוא\"ל';

  @override
  String get emailOptional => 'דוא\"ל (אופציונלי)';

  @override
  String get enableCallFilter => 'אפשר סינון שיחות';

  @override
  String get enableCallFilterDescription =>
      'כאשר מופעל, שיחות נכנסות נבדקות מול רשימת הכללים למטה. כללי סינון שיחות אינם מסונכרנים בין מכשירים כברירת מחדל.';

  @override
  String get enabled => 'מופעל';

  @override
  String get enabledStatus => 'מופעל';

  @override
  String get enableEncryption => 'אפשר הצפנה';

  @override
  String get enableEncryptionDescription => 'הצפן קבצי גיבוי';

  @override
  String get enableEncryptionLabel => 'אפשר הצפנה';

  @override
  String get enableEncryptionSubtitle => 'קבצי גיבוי יוצפנו';

  @override
  String get enableEncryptionTitle => 'אפשר הצפנה';

  @override
  String get enableGlobalPlugins => 'אפשר פלאגינים גלובליים';

  @override
  String get enableLocalCountFilter => 'אפשר מסנן מונה מקומי';

  @override
  String get enableLocalCountFilterDescription =>
      'סנן אוטומטית שיחות ספאם על פי ספירת סימוני שיחות';

  @override
  String get enableLocalNotification => 'השתמש בהתראות מקומיות';

  @override
  String get enableLocalNotificationDescription =>
      'כאשר מופעל, התראות להודעות מסוננות יוצגו במכשיר';

  @override
  String get enableLocationSummary => 'מיקום';

  @override
  String get enableMuteRules => 'אפשר כללי השתקה';

  @override
  String get enableMuteRulesDesc => 'החל תצורת כללי חסימת השתקה';

  @override
  String get enableNoneActionRules => 'אפשר כללים ללא פעולה';

  @override
  String get enableNoneActionRulesDesc => 'אפשר הגדרות כללים ללא פעולות חסימה';

  @override
  String get enableNotifications => 'אפשר התראות';

  @override
  String get enableRemoteNumberFilter => 'אפשר מסנן מספרים מרוחקים';

  @override
  String get enableRemoteNumberFilterDescription =>
      'השתמש במסד נתונים מרוחק לסינון מספרים';

  @override
  String get enableRule => 'אפשר כלל';

  @override
  String get enableSmsFilter => 'אפשר סינון SMS';

  @override
  String get enableSmsFilterDescription =>
      'כאשר מופעל, הודעות יסוננו אוטומטית לפי הכללים';

  @override
  String get enableStatisticsNotifications => 'אפשר התראות סטטיסטיקה';

  @override
  String get enableSubscriptionSuccessfully => 'אפשר מנוי בהצלחה';

  @override
  String get enableTimeInterception => 'אפשר חסימת זמן';

  @override
  String get enableTimeInterceptionDescription =>
      'חסום שיחות חוזרות בפרק זמן קצר';

  @override
  String get enableTimeInterceptor => 'אפשר חוסם זמן';

  @override
  String get endCallImmediately => 'סיים שיחה באופן מיידי';

  @override
  String get endColor => 'צבע סיום';

  @override
  String get endDate => 'תאריך סיום';

  @override
  String get enhancedFilterInstructionsTitle => 'מערכת סינון משופרת';

  @override
  String get enhancedFilterSettings => 'הגדרות סינון משופרות';

  @override
  String get enhancedFilterSettingsTitle => 'הגדרות סינון משופרות';

  @override
  String get enhancedFilterSystemDescription =>
      'מערכת הסינון המשופרת תומכת בכללים גלובליים ובהגדרות סינון לכל כרטיס SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'אנא הכנס גם מספר טלפון וגם דפוס Regex';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'אנא הכנס גם מספר טלפון וגם דפוס Regex.';

  @override
  String get enterContactName => 'אנא הכנס שם איש קשר';

  @override
  String get enterCurrentPasswordHint => 'אנא הכנס סיסמה נוכחית';

  @override
  String get enterDeviceName => 'הכנס שם מכשיר';

  @override
  String get enterDeviceNameHint => 'הכנס שם מכשיר';

  @override
  String get enterEmail => 'אנא הכנס דוא\"ל';

  @override
  String get enterEmailOptional => 'אנא הכנס דוא\"ל (אופציונלי)';

  @override
  String get enterEncryptionPasswordHint => 'הכנס סיסמת הצפנה';

  @override
  String get enterEncryptionPasswordTitle => 'הכנס סיסמת הצפנה';

  @override
  String get enterFilterName => 'אנא הכנס שם מסנן';

  @override
  String get enterFilterPattern => 'אנא הכנס דפוס מסנן';

  @override
  String get enterIconCode => 'הכנס קוד אייקון';

  @override
  String get enterName => 'הכנס שם איש קשר';

  @override
  String get enterNewDeviceNameHint => 'הכנס שם חדש למכשיר זה';

  @override
  String get enterNewPasswordHint => 'אנא הכנס סיסמה חדשה';

  @override
  String get enterPasswordAgain => 'הכנס סיסמה שוב';

  @override
  String get enterPasswordHint => 'אנא הכנס סיסמה';

  @override
  String get enterPhoneNumber => 'הכנס מספר טלפון';

  @override
  String get enterPhoneNumberHint => 'הכנס מספר טלפון לבדיקה';

  @override
  String get enterPhoneNumberMultiple =>
      'אנא הכנס מספר טלפון, מספרים מרובים מופרדים בפסיקים';

  @override
  String get enterPhoneNumberToStartSearch => 'הכנס מספר טלפון להתחלת חיפוש';

  @override
  String get enterPhoneNumberToVerify => 'הכנס מספר טלפון לאימות';

  @override
  String get enterPluginName => 'הכנס שם פלאגין';

  @override
  String get enterPluginUrl => 'הכנס כתובת URL של פלאגין';

  @override
  String get enterRegexHint => 'הכנס דפוס Regex';

  @override
  String get enterRuleNameAndPattern => 'אנא הכנס שם כלל ודפוס';

  @override
  String get enterRuleNameAndPatternMessage => 'נא להזין שם כלל ותבנית Regex.';

  @override
  String get enterRuleNameHint => 'הזן שם כלל';

  @override
  String get enterSearchContent => 'נא להזין תוכן לחיפוש';

  @override
  String get enterSubscriptionName => 'הזן שם מנוי';

  @override
  String get enterSubscriptionUrl => 'הזן כתובת URL למנוי';

  @override
  String get enterSyncFolderNameHint =>
      'נא להזין שם תיקיית סינכרון (ברירת מחדל: NotificationManager)';

  @override
  String get entertainment => 'בידור';

  @override
  String get enterValidNameAndUrl => 'נא להזין שם וכתובת URL תקינים';

  @override
  String get enterValidUrl => 'נא להזין כתובת URL תקינה';

  @override
  String get enterVersion => 'הזן גרסה';

  @override
  String get enterWebDAVPasswordHint => 'נא להזין סיסמת WebDAV';

  @override
  String get enterWebDAVServerAddressHint => 'נא להזין כתובת שרת WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'נא להזין שם משתמש WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'שגיאה במחיקת מכשיר: $error';
  }

  @override
  String get errorLoadingPlugin => 'שגיאה בטעינת פלאגין';

  @override
  String errorOccurredMessage(Object error) {
    return 'אירעה שגיאה: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'שגיאה בשינוי שם מכשיר: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'שגיאה בסנכרון מכשירים: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'שגיאה בסנכרון מכשירים: $error';
  }

  @override
  String get errorText => 'שגיאה';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'שגיאה בהסרת רישום מכשיר: $error';
  }

  @override
  String get exampleBlock400Prefix => 'לדוגמה, חסימת מספרים מתחילים ב-400';

  @override
  String get exampleBlockMarketingSms => 'לדוגמה, חסימת SMS שיווקיים';

  @override
  String get exampleContentRegex => 'לדוגמה, .*offer.*';

  @override
  String get exampleContentRegexHint => 'דוגמה ל-Regex של תוכן';

  @override
  String get exampleCouponPromotionDiscount =>
      'לדוגמה, .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'לדוגמה, משפחה, חברים וכו\'.';

  @override
  String get examplePhoneNumber => 'לדוגמה, 10086, 12345, וכו\'.';

  @override
  String get exampleRegex400Prefix => 'דוגמה ל-Regex עבור קידומת 400';

  @override
  String get exampleRegexFormat => 'דוגמה: פורמט ^10086\$';

  @override
  String get exampleSenderRegexHint => 'דוגמה';

  @override
  String get exchange => 'החלפה';

  @override
  String get exchangeNow => 'החלף עכשיו';

  @override
  String get exchangeVip => 'החלף VIP';

  @override
  String get expandLabelSelector => 'הרחב בוחר תוויות';

  @override
  String expiryTime(Object time) {
    return 'זמן תפוגה: $time';
  }

  @override
  String get export => 'ייצוא';

  @override
  String get exportAllApplicationSettings => 'ייצא את כל הגדרות האפליקציה';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'ייצא את כל הגדרות האפליקציה';

  @override
  String get exportAllRuleConfigurations => 'ייצא את כל תצורות הכללים';

  @override
  String get exportAllRuleConfigurationsSubtitle => 'ייצא את כל תצורות הכללים';

  @override
  String get exportComplete => 'ייצוא הושלם';

  @override
  String get exportConfig => 'ייצוא תצורה';

  @override
  String get exportContacts => 'ייצוא אנשי קשר';

  @override
  String get exportData => 'ייצוא נתונים';

  @override
  String get exportError => 'שגיאת ייצוא';

  @override
  String get exportFailed => 'הייצוא נכשל';

  @override
  String get exportFailure => 'נכשל בייצוא תצורה';

  @override
  String get exportFeatureComingSoon => 'תכונת הייצוא תגיע בקרוב';

  @override
  String get exporting => 'מייצא...';

  @override
  String get exportLabels => 'ייצוא תוויות';

  @override
  String exportLabelsFailed(Object error) {
    return 'נכשל בייצוא תוויות: $error';
  }

  @override
  String get exportPluginList => 'ייצוא רשימת פלאגינים';

  @override
  String exportPluginListFailed(Object error) {
    return 'נכשל בייצוא רשימת פלאגינים: $error';
  }

  @override
  String get exportRules => 'ייצוא כללים';

  @override
  String get exportRulesDialogTitle => 'ייצוא כללים';

  @override
  String get exportRulesTitle => 'ייצוא כללים';

  @override
  String get exportSmsRules => 'ייצוא כללי SMS';

  @override
  String get exportStatisticsData => 'ייצוא נתוני סטטיסטיקה';

  @override
  String get exportSuccess => 'ייצוא הצליח';

  @override
  String get exportSuccesslly => 'התצורה יצאה בהצלחה';

  @override
  String get failedToAddContact => 'נכשל בהוספת איש קשר';

  @override
  String failedToAddRule(Object error) {
    return 'נכשל בהוספת כלל: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'נכשל בהוספת כלל SMS: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'נכשל בהוספת מנוי SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'נכשל בגיבוי הגדרות: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'נכשל בפיצוח קובץ גיבוי';

  @override
  String get failedToDeleteDevice => 'נכשל במחיקת מכשיר';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'נכשל במחיקת כלל SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'נכשל בייצוא כללים: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'נכשל בייצוא כללי SMS: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'נכשל בקבלת מידע על מזהה מתקשר: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'נכשל בייבוא כללים: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'נכשל בייבוא כללי SMS: $error';
  }

  @override
  String get failedToLoadContacts => 'נכשל בטעינת אנשי קשר';

  @override
  String get failedToLoadPlugin => 'נכשל בטעינת פלאגין';

  @override
  String get failedToRenameDevice => 'נכשל בשינוי שם מכשיר';

  @override
  String get failedToRestoreSettings => 'נכשל בשחזור הגדרות';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'נכשל בשחזור הגדרות: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'נכשל בהגדרת סיסמה: $error';
  }

  @override
  String get failedToSyncDevices => 'נכשל בסנכרון מכשירים';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'נכשל בהחלפת סטטוס כלל: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => 'נכשל בהחלפת סטטוס מנוי';

  @override
  String get failedToUpdateContact => 'נכשל בעדכון איש קשר';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'נכשל בעדכון כלל SMS: $error';
  }

  @override
  String get failure => 'כישלון';

  @override
  String get favoriteContacts => 'אנשי קשר מועדפים';

  @override
  String get featureAddRules => '• הוספת כללים ספציפיים למספר טלפון';

  @override
  String get featureCenter => 'מרכז תכונות';

  @override
  String get featureEnableDisable => '• הפעלה/כיבוי של מסננים שונים לכל SIM';

  @override
  String get featureListTitle => 'תכונות:';

  @override
  String get featureManageRules => '• ניהול רשימות כללים לכל SIM';

  @override
  String get features => 'תכונות';

  @override
  String get fetchingCallerIdInfo => 'מביא מידע על מזהה מתקשר...';

  @override
  String fileSavedTo(Object path) {
    return 'הקובץ נשמר ב: $path';
  }

  @override
  String get filter => 'סנן';

  @override
  String get filterByLabel => 'סנן לפי תווית';

  @override
  String get filterClear => 'נקה סינון';

  @override
  String get filterControlPanelTitle => 'פאנל בקרת סינון';

  @override
  String get filterControlSubtitle => 'נהל את סטטוס ההפעלה/כיבוי של כל המסננים';

  @override
  String get filterControlTitle => 'בקרת סינון';

  @override
  String get filterDeleteFailed => 'מחיקת סינון נכשלה';

  @override
  String get filterDeleteSuccess => 'הסינון נמחק בהצלחה';

  @override
  String get filterDetails => 'פרטי סינון';

  @override
  String get filtered => 'מסונן';

  @override
  String get filteredSms => 'SMS מסוננים';

  @override
  String get filteredSmsLabel => 'SMS מסוננים';

  @override
  String get filterExplanation => 'הסבר סינון';

  @override
  String get filterManagement => 'ניהול סינון';

  @override
  String get filterName => 'שם סינון';

  @override
  String get filterPattern => 'תבנית סינון';

  @override
  String get filterPriorityNote =>
      'הערה: קיימים יחסי עדיפות בין מסננים, אנא עיין בתיעוד העזרה לקבלת פרטים';

  @override
  String get filterSaveFailed => 'שמירת סינון נכשלה';

  @override
  String get filterSaveSuccess => 'הסינון נשמר בהצלחה';

  @override
  String get filterSettings => 'הגדרות סינון';

  @override
  String get filterSettingsTitle => 'הגדרות סינון';

  @override
  String get filterSMS => 'סינון SMS';

  @override
  String get filterToggleInstructions =>
      'הפעל או השבת מסננים עבור חריץ SIM זה:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'סנן $status: $filterName';
  }

  @override
  String get filterType => 'סוג סינון';

  @override
  String get financial => 'פיננסי';

  @override
  String get flexibleCombinationFeature =>
      '• שילובים גמישים: הפעל/השבת מסננים לפי חריץ SIM';

  @override
  String get fontSizesSetting => 'גדלי גופן';

  @override
  String foundRules(Object count) {
    return 'נמצאו $count כללים';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'נמצאו $count כללים. האם ברצונך לייבא אותם?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'נמצאו $count כללים. האם ברצונך לייבא אותם?';
  }

  @override
  String get fraudAlert => 'התראת הונאה - נתק את השיחה';

  @override
  String get fraudScamLikely => 'חשד להונאה/תרמית';

  @override
  String get free => 'חינם';

  @override
  String get functionSettingsTitle => 'הגדרות פונקציה';

  @override
  String generalUpdateFailure(Object error) {
    return 'עדכון נכשל: $error';
  }

  @override
  String get getFree => 'קבל חינם';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'הגדר מסננים גלובליים עבור כל כרטיסי ה-SIM:';

  @override
  String get globalFilterFeature =>
      '• מסננים גלובליים: כללים בסיסיים לכל השיחות הנכנסות';

  @override
  String get globalFilterSettings => 'הגדרות מסנן גלובלי';

  @override
  String get globalFilterToggleInstructions =>
      'הגדר הגדרות מסנן גלובליות החלות על כל חריצי ה-SIM:';

  @override
  String get globalSearchSubtitle =>
      'חפש אנשי קשר, תוויות, רשימות שחורות, רשימות לבנות וכו\'.';

  @override
  String get globalSearchTitle => 'חיפוש גלובלי';

  @override
  String get globalSettings => 'הגדרות גלובליות';

  @override
  String get googleAdDisplayPosition => 'מיקום תצוגת פרסומת של Google';

  @override
  String get googleAdMobIntegrationText => 'ניתן לשלב פרסומות Google AdMob כאן';

  @override
  String get googleDriveAuthDescription =>
      'אשר באמצעות מזהה הלקוח ומפתח Google Drive שהוגדרו במערכת';

  @override
  String get googleDriveAuthorizationHint =>
      'אשר באמצעות מזהה הלקוח ומפתח Google Drive שהוגדרו במערכת';

  @override
  String get googleDriveConfigTitle => 'תצורת Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'תצורת Google Drive';

  @override
  String get government => 'ממשלה';

  @override
  String get granted => 'הוענק';

  @override
  String get grantNecessaryPermissions => 'הענק הרשאות נחוצות';

  @override
  String get grantPermissions => 'הענק הרשאות';

  @override
  String get headhunter => 'Headhunter';

  @override
  String get height => 'גובה';

  @override
  String get homePageTitle => 'דף הבית';

  @override
  String get homeTab => 'בית';

  @override
  String get howItWorksPoint1 =>
      '• המערכת תאפשר אוטומטית שיחות מאותו מספר בתוך חלון הזמן שנקבע';

  @override
  String get howItWorksPoint2 =>
      '• חלונות זמן קצרים יותר מובילים ליירוט קפדני יותר; חלונות זמן ארוכים יותר מובילים ליירוט פחות קפדני';

  @override
  String get howItWorksPoint3 =>
      '• המערכת בודקת את יומני השיחות כדי לקבוע אם זו שיחה חוזרת';

  @override
  String get howItWorksTitle => 'איך זה עובד:';

  @override
  String get iconCodeOptional => 'קוד אייקון (אופציונלי)';

  @override
  String get iconSize => 'גודל אייקון';

  @override
  String get import => 'יבוא';

  @override
  String get important => 'חשוב';

  @override
  String get importButton => 'יבוא';

  @override
  String get importConfig => 'ייבוא תצורה';

  @override
  String get importContacts => 'ייבוא אנשי קשר';

  @override
  String get importExportContacts => 'ייבוא/ייצוא אנשי קשר';

  @override
  String get importExportContactsTooltip => 'ייבוא/ייצוא אנשי קשר';

  @override
  String get importExportRules => 'ייבוא/ייצוא כללים';

  @override
  String importFailed(Object error) {
    return 'ייבוא נכשל: $error';
  }

  @override
  String get importFailure => 'כשל בייבוא תצורה';

  @override
  String get importFeatureComingSoon => 'תכונת ייבוא בקרוב';

  @override
  String get importLabels => 'ייבוא תוויות';

  @override
  String importLabelsFailed(Object error) {
    return 'כשל בייבוא תוויות: $error';
  }

  @override
  String get importPluginList => 'ייבוא רשימת פלאגינים';

  @override
  String importPluginListFailed(Object error) {
    return 'כשל בייבוא רשימת פלאגינים: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'יובאו בהצלחה $count פלאגינים';
  }

  @override
  String get importRuleConfigurationsFromFile => 'ייבוא תצורות כללים מקובץ';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'ייבוא תצורות כללים מקובץ';

  @override
  String get importRules => 'ייבוא כללים';

  @override
  String get importRulesButton => 'יבוא כללים';

  @override
  String get importRulesDialogTitle => 'יבוא כללים';

  @override
  String importRulesError(Object error) {
    return 'כשל בייבוא כללים: $error';
  }

  @override
  String get importRulesInstructions => 'ייבוא כללים מקובץ CSV';

  @override
  String get importRulesSuccess => 'הכללים יובאו בהצלחה';

  @override
  String get importRulesTitle => 'ייבוא כללים';

  @override
  String get importSuccess => 'הייבוא הצליח';

  @override
  String get incomingCallInterceptAction => 'פעולת יירוט שיחה נכנסת';

  @override
  String get incomingCallNotification => 'התראת שיחה נכנסת';

  @override
  String get incorrectPassword => 'סיסמה שגויה';

  @override
  String get initializing => 'מאחל';

  @override
  String get installed => 'מותקן';

  @override
  String get insufficientMarks => 'סימנים לא מספיקים';

  @override
  String get insurance => 'ביטוח';

  @override
  String get interceptAction => 'פעולת יירוט';

  @override
  String get interceptionActionSettingsSubtitle =>
      'הגדר כיצד שיחות חסומות מטופלות';

  @override
  String get interceptionActionSettingsTitle => 'הגדרות פעולת יירוט';

  @override
  String get interceptionTimeInterval => 'מרווח זמן ליירוט';

  @override
  String get internet => 'אינטרנט';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'מרווח עדכון $service הוגדר ל-$days ימים';
  }

  @override
  String get invalidContentRegex => 'ביטוי רגולרי של תוכן לא תקין';

  @override
  String get invalidLabel => 'תווית לא תקינה';

  @override
  String get invalidRegexPattern => 'תבנית ביטוי רגולרי לא תקינה';

  @override
  String get invalidSenderRegex => 'ביטוי רגולרי של שולח לא תקין';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'הצטרף לערוץ ול קבוצת הטלגרם למידע נוסף';

  @override
  String get jsLogsTitle => 'יומני JavaScript';

  @override
  String get jsonFormat => 'פורמט JSON';

  @override
  String get keepAllVersions => 'שמור את כל הגרסאות';

  @override
  String get keepAllVersionsDescription =>
      'שמור את כל הגרסאות ההיסטוריות של כל גיבוי';

  @override
  String get keepAllVersionsLabel => 'שמור את כל הגרסאות';

  @override
  String get keepAllVersionsSubtitle => 'שמור גרסאות היסטוריות של כל גיבוי';

  @override
  String get keepAllVersionsTitle => 'שמור את כל הגרסאות';

  @override
  String get label => 'תווית';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'התווית \"$name\" הוספה בהצלחה';
  }

  @override
  String get labelCategories => 'קטגוריות תווית';

  @override
  String get labelDeleted => 'התווית נמחקה';

  @override
  String get labelDescription =>
      'תוויות עוזרות לך לנהל אנשי קשר טוב יותר, הוסף תוויות מותאמות אישית למספרי טלפון לצורך זיהוי קל של שיחות והודעות.';

  @override
  String get labelFilter => 'סינון תווית';

  @override
  String get labelFilterTooltip => 'סינון תווית';

  @override
  String get labelIconColor => 'צבע אייקון התווית';

  @override
  String get labelManagement => 'ניהול תווית';

  @override
  String get labelNotFound => 'התווית לא נמצאה';

  @override
  String get labelRemoved => 'התווית הוסרה';

  @override
  String labelRemoveFailed(Object error) {
    return 'הסרת תווית נכשלה: $error';
  }

  @override
  String get labels => 'תוויות';

  @override
  String get labelsColor => 'צבע תוויות';

  @override
  String labelsDeleted(Object count) {
    return '$count תוויות נמחקו';
  }

  @override
  String get labelsExportedSuccessfully => 'התוויות יוצאו בהצלחה';

  @override
  String get labelsFontSize => 'גודל גופן תוויות';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'הייבוא של $count תוויות הושלם בהצלחה';
  }

  @override
  String get labelsPosition => 'מיקום תוויות';

  @override
  String labelTag(Object labelId) {
    return 'תווית: $labelId';
  }

  @override
  String get labelUpdated => 'התווית עודכנה';

  @override
  String labelUpdateFailed(Object error) {
    return 'עדכון תווית נכשל: $error';
  }

  @override
  String get labelUpdateSuccess => 'התווית \"\$labelText\" עודכנה בהצלחה';

  @override
  String get languageSettings => 'הגדרות שפה';

  @override
  String get languageSettingsSubtitle => 'שנה את שפת התצוגה של האפליקציה';

  @override
  String get languageSettingsTitle => 'הגדרות שפה';

  @override
  String get last30Days => '30 הימים האחרונים';

  @override
  String get last7Days => '7 הימים האחרונים';

  @override
  String get lastSyncLabel => 'סנכרון אחרון';

  @override
  String lastUpdated(Object date) {
    return 'עודכן לאחרונה: $date';
  }

  @override
  String get lifetimeMembership => 'חברות לכל החיים';

  @override
  String get lifetimeMembershipDescription =>
      'רכישה חד פעמית, פתח לצמיתות את כל התכונות הפרימיום ועדכונים עתידיים';

  @override
  String loadContactsFailed(Object error) {
    return 'טעינת אנשי קשר נכשלה: $error';
  }

  @override
  String get loadDataFailed => 'טעינת נתונים נכשלה';

  @override
  String get loadFailed => 'טעינה נכשלה';

  @override
  String get loading => 'טוען...';

  @override
  String get loadingData => 'טוען נתונים...';

  @override
  String get loadingTags => 'טוען תגיות...';

  @override
  String loadLabelFailed(Object error) {
    return 'טעינת תוויות נכשלה: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'טעינת תוויות נכשלה: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'טעינת מספרים מסומנים נכשלה: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'טעינת טלפונים מסומנים נכשלה: $error';
  }

  @override
  String get loadMore => 'טען עוד';

  @override
  String get loadPluginButton => 'טען פלאגין';

  @override
  String loadPluginsFailed(Object error) {
    return 'טעינת פלאגינים נכשלה: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'טעינת הגדרות נכשלה: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'טעינת כללי SMS נכשלה: $error';
  }

  @override
  String get loadStatusFailedMessage => 'טעינת מצב נכשלה';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'טעינת מינויים נכשלה: $error';
  }

  @override
  String get loan => 'הלוואה';

  @override
  String get localBackupTitle => 'גיבוי מקומי';

  @override
  String get localCounterFilter => 'סינון מונה מקומי';

  @override
  String get localCounterFilterSubtitle =>
      'סנן אוטומטית שיחות ספאם על פי תדירות שיחות';

  @override
  String get localCountFilter => 'סינון ספירת מקומית';

  @override
  String get localCountFilterDescription =>
      'יירוט שיחות תכופות על בסיס ספירת מספרים מקומיים';

  @override
  String get localCountFilterExplanationContent =>
      'סינון ספירת המספרים המקומי מנתח רשומות היסטוריית שיחות כדי לזהות ולחסום אוטומטית שיחות ספאם תכופות.';

  @override
  String get localCountFilterExplanationTitle => 'הסבר לסינון ספירת מקומית';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• קבע אם לחסום על בסיס ערך הספירה של המספר';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• כאשר ספירת מספר חורגת מהסף שנקבע, ניתן לבחור לחסום אותו אוטומטית';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• ניתן לאפשר באופן סלקטיבי מספרים שאינם חורגים מהסף';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• ניתן לבחור אם לרשום את כל יומני השאילתות';

  @override
  String get localCountFiltering => 'סינון ספירת מקומית';

  @override
  String get localCountFilteringExplanation =>
      '• סינון ספירת מקומית: כללי סינון המבוססים על ספירת סימון מקומי';

  @override
  String get localCountFilterSettings => 'הגדרות סינון ספירת מקומית';

  @override
  String get localCountFilterUseCases =>
      'מסנן זה מתאים במיוחד לזיהוי שיחות ספאם אוטומטיות ושיחות שיווקיות.';

  @override
  String get localFilterSettings => 'הגדרות סינון מקומי';

  @override
  String get localNotificationDisabled => 'התראה מקומית מושבתת';

  @override
  String get localNotificationEnabled => 'התראה מקומית מופעלת';

  @override
  String get localServices => 'שירותים מקומיים';

  @override
  String get locationColor => 'צבע מיקום';

  @override
  String get locationFontSize => 'גודל גופן מיקום';

  @override
  String get locationIconColor => 'צבע אייקון מיקום';

  @override
  String get locationPosition => 'מיקום מיקום';

  @override
  String get logAllLocalQueries => 'רשום את כל השאילתות המקומיות';

  @override
  String get logAllLocalQueriesDescription =>
      'רשום יומנים לכל השאילתות של מספרים מקומיים';

  @override
  String get logAllRemoteQueries => 'רשום את כל השאילתות מרחוק';

  @override
  String get logAllRemoteQueriesDescription =>
      'רשום את כל פעולות השאילתה של מספרים מרחוק';

  @override
  String get manage => 'נהל אנשי קשר';

  @override
  String get manageContacts => 'ניהול';

  @override
  String get manageFavoriteContacts => 'נהל אנשי קשר מועדפים';

  @override
  String get manageFilterRules => 'נהל כללי סינון';

  @override
  String get manageFilterRulesDescription => 'הוסף, ערוך או מחק כללי סינון SMS';

  @override
  String get manageFrequentContacts => 'נהל אנשי קשר תכופים';

  @override
  String get markCounts => 'ספירות סימון';

  @override
  String get markCount => 'ספירת סימון';

  @override
  String markedByCount(Object count) {
    return 'סומן על ידי $count';
  }

  @override
  String get markedPhonesList => 'Marked Phone Numbers';

  @override
  String get markExchange => 'החלפת סימון';

  @override
  String get markPhone => 'סמן מספר טלפון';

  @override
  String markPhoneFailed(Object error) {
    return 'נכשל סימון מספר טלפון: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'לסימון מספרי טלפון';

  @override
  String get markPhoneManagementTitle => 'ניהול סימון טלפונים';

  @override
  String get markPhoneSuccess => 'מספר הטלפון סומן בהצלחה';

  @override
  String get matchFailed => 'התאמה נכשלה!';

  @override
  String get matchFailedMessage => 'התאמה נכשלה.';

  @override
  String get matchNumbersWithSpecialCharacters => 'מתאים לפורמט מספר ספציפי';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'התאם מספרים עם תווים מיוחדים:';

  @override
  String get matchSpecificDigitPatterns => 'מתאים לפורמט XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle => 'התאם תבניות ספרות ספציפיות:';

  @override
  String get matchSuccessful => 'התאמה הצליחה!';

  @override
  String get matchSuccessfulMessage => 'התאמה הצליחה!';

  @override
  String get medical => 'רפואי';

  @override
  String get membershipPrivileges => 'זכויות חברות';

  @override
  String get migrationTool => 'כלי הגירה';

  @override
  String get migrationToolTitle => 'כלי הגירה';

  @override
  String get minutes => 'דקות';

  @override
  String get month => 'חודש';

  @override
  String get monthly => 'חודשי';

  @override
  String get monthlyCallCount => 'שיחות חודשיות';

  @override
  String get monthlyChartTitle => 'שיחות חסומות חודשיות';

  @override
  String get monthlyMembership => 'חברות חודשית';

  @override
  String get monthlyMembershipDescription =>
      'פתח את כל התכונות הפרימיום, חידוש אוטומטי חודשי';

  @override
  String get monthlyTotal => 'סך הכל חודשי';

  @override
  String get monthlyTotalLabel => 'סך הכל חודשי';

  @override
  String get moreOptions => 'עוד אפשרויות';

  @override
  String get mute => 'השתק';

  @override
  String get name => 'שם';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'שם ומספר טלפון אינם יכולים להיות ריקים';

  @override
  String get nameAndPhoneNumberRequired => 'שם ומספר טלפון נדרשים';

  @override
  String get nameColor => 'צבע שם';

  @override
  String get nameFontSize => 'גודל גופן שם';

  @override
  String nameLabel(Object name) {
    return 'שם: $name';
  }

  @override
  String get namePosition => 'מיקום שם';

  @override
  String get nameUnknown => 'שם: לא ידוע';

  @override
  String nameWithValue(String name) {
    return 'שם: $name';
  }

  @override
  String get newPasswordLabel => 'סיסמה חדשה';

  @override
  String get nextStep => 'הבא';

  @override
  String get noAction => 'אין פעולה';

  @override
  String get noActionRules => 'אין כללי פעולה';

  @override
  String get noActiveCloudSyncServiceMessage => 'אין שירות סנכרון ענן פעיל';

  @override
  String get noCallLogs => 'אין יומני שיחות';

  @override
  String get noCallRecords => 'אין רישומי שיחות';

  @override
  String get noContacts => 'עדיין אין אנשי קשר';

  @override
  String get noContactsYet => 'עדיין אין אנשי קשר';

  @override
  String get noData => 'אין נתונים';

  @override
  String get noDevicesRegisteredMessage => 'אין מכשירים רשומים';

  @override
  String get noDevicesRegisteredYet => 'עדיין אין מכשירים רשומים.';

  @override
  String get noFilters => 'עדיין אין מסננים';

  @override
  String get noLabels => 'עדיין אין תוויות';

  @override
  String get noMarkedPhones => 'אין מספרי טלפון מסומנים';

  @override
  String get noMatchingContacts => 'אין אנשי קשר תואמים';

  @override
  String get noMatchingContactsFound => 'לא נמצאו אנשי קשר תואמים';

  @override
  String get noMatchingNumbersFound => 'לא נמצאו מספרים תואמים';

  @override
  String get noMatchingRecords => 'אין רישומי שיחות תואמים';

  @override
  String noMatchingRules(Object ruleType) {
    return 'אין $ruleType תואמים';
  }

  @override
  String get none => 'אין';

  @override
  String get noneServiceType => 'אין';

  @override
  String get noPlugins => 'עדיין אין פלאגינים';

  @override
  String get noRecords => 'אין רישומי שיחות';

  @override
  String get noResultReturned => 'לא הוחזר תוצאה';

  @override
  String get noResultReturnedLog => 'לא הוחזרה תוצאה מהפלאגין';

  @override
  String noRules(Object ruleType) {
    return 'עדיין אין $ruleType';
  }

  @override
  String get noRulesPrompt => 'לא נמצאו כללים, אנא הוסף כללים';

  @override
  String get noRulesToExport => 'אין כללים לייצוא';

  @override
  String get noSmsFilterRulesYet => 'עדיין אין כללי סינון SMS';

  @override
  String get noSmsRulesYet => 'עדיין אין כללי SMS';

  @override
  String get noSubscriptions => 'אין מנויים';

  @override
  String get noSubscriptionsYet => 'עדיין אין מנויים';

  @override
  String get notGranted => 'לא הוענק';

  @override
  String get notificationModeDescription => 'הצג מידע על המתקשר בשורת ההתראות';

  @override
  String get notificationPermission => 'הרשאת התראה';

  @override
  String get notificationPermissionDescription =>
      'משמש להצגת התראות על שיחות והודעות נכנסות.';

  @override
  String get notifications => 'התראות';

  @override
  String get notificationSettings => 'הגדרות התראות';

  @override
  String get notificationSettingsSaved => 'הגדרות ההתראות נשמרו בהצלחה';

  @override
  String get notSet => 'לא הוגדר';

  @override
  String get notVerifiedText => 'לא מאומת';

  @override
  String get noValidSmsRulesFoundInFile => 'לא נמצאו כללי SMS תקינים בקובץ';

  @override
  String get number => 'מספר';

  @override
  String get numberColor => 'צבע מספר';

  @override
  String get numberFontSize => 'גודל גופן מספר';

  @override
  String get numberPosition => 'מיקום מספר';

  @override
  String get numberSearch => 'חיפוש מספר';

  @override
  String get numberTypeColor => 'צבע סוג מספר';

  @override
  String get numberTypeFontSize => 'גודל גופן סוג מספר';

  @override
  String get numberTypePosition => 'מיקום סוג מספר';

  @override
  String get ok => 'אישור';

  @override
  String get okButton => 'אישור';

  @override
  String get onboardingCompleteDescription =>
      'מנהל אבטחת השיחות שלך מוכן, התחל ליהנות מחוויית שיחה בטוחה!';

  @override
  String get onboardingLanguageDescription =>
      'בחר את השפה המועדפת עליך לחוויה הטובה ביותר.';

  @override
  String get onboardingPermissionsDescription =>
      'כדי לספק שירות מלא, אנו זקוקים להרשאות הבאות:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'חסימה בלחיצה אחת של שיחות וודעות זבל, התאם אישית כללי חסימה, ותן לך סביבה שקטה.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'זהה אוטומטית שיחות לא ידועות, סמן מספרים חשודים, והגן על בטיחות השיחות שלך.';

  @override
  String get onboardingWelcomeDescription =>
      'מומחה ניהול השיחות שלך, המספק זיהוי שיחות וחסימה מקיפים.';

  @override
  String get oneDriveAuthDescription =>
      'אשר באמצעות מזהה לקוח OneDrive ואישור המוגדרים במערכת';

  @override
  String get oneDriveAuthorizationHint =>
      'אשר באמצעות מזהה לקוח OneDrive ואישור המוגדרים במערכת';

  @override
  String get oneDriveConfigTitle => 'תצורת OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'תצורת OneDrive';

  @override
  String get onlineCallerIdSubscription => 'מנוי לזיהוי מתקשר אונליין';

  @override
  String get openAppSettings => 'פתח הגדרות אפליקציה';

  @override
  String openAppSettingsFailed(Object error) {
    return 'כשל בפתיחת הגדרות האפליקציה: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'הפעולה נכשלה: $error';
  }

  @override
  String get operationFailure => 'הפעולה נכשלה';

  @override
  String get operationSuccess => 'הפעולה הצליחה';

  @override
  String get other => 'אחר';

  @override
  String get ourOtherApps => 'אפליקציות נוספות שלנו';

  @override
  String get overlayMode => 'חלון צף';

  @override
  String get overlayModeDescription => 'הצג מידע מתקשר בחלון צף';

  @override
  String get overlayPermission => 'הרשאת חלון צף';

  @override
  String get overlayPermissionDescription =>
      'משמש להצגת שכבת-על של שיחות נכנסות.';

  @override
  String get overview => 'סקירה כללית';

  @override
  String get password => 'סיסמה';

  @override
  String get passwordCannotBeEmpty => 'סיסמה אינה יכולה להיות ריקה';

  @override
  String get passwordLabel => 'סיסמה';

  @override
  String get passwordsDoNotMatch => 'סיסמאות אינן תואמות';

  @override
  String get passwordSetSuccessfully => 'הסיסמה הוגדרה בהצלחה';

  @override
  String get pattern => 'תבנית';

  @override
  String get pendingSync => 'סנכרון ממתין';

  @override
  String get periodMonth => 'חודש';

  @override
  String get periodWeek => 'שבוע';

  @override
  String get periodYear => 'שנה';

  @override
  String get permissionDenied => 'בקשת הרשאה נדחתה';

  @override
  String get permissionGranted => 'הרשאה ניתנה';

  @override
  String get permissionManagement => 'ניהול הרשאות';

  @override
  String get phoneCallsTab => 'טלפון';

  @override
  String get phoneNumber => 'מספר טלפון';

  @override
  String get phoneNumberCannotBeEmpty => 'מספר טלפון אינו יכול להיות ריק';

  @override
  String get phoneNumberHintText => 'הזן מספר טלפון להוספת כלל';

  @override
  String get phoneNumberLabel => 'מספר טלפון';

  @override
  String get phoneNumberRegexRequired => 'אנא הזן מספר טלפון וגם תבנית regex';

  @override
  String get phoneNumberTypeFixedLine => 'קו קבוע';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'קו קבוע או נייד';

  @override
  String get phoneNumberTypeMobile => 'נייד';

  @override
  String get phoneNumberTypePager => 'בייג\'ר';

  @override
  String get phoneNumberTypePersonalNumber => 'מספר אישי';

  @override
  String get phoneNumberTypePremiumRate => 'שיעור פרמיום';

  @override
  String get phoneNumberTypeSharedCost => 'עלות משותפת';

  @override
  String get phoneNumberTypeTollFree => 'ללא תשלום';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'לא ידוע';

  @override
  String get phoneNumberTypeVoicemail => 'דואר קולי';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'הרשאת טלפון';

  @override
  String get phonePermissionDescription => 'משמש לזיהוי וחסימת שיחות נכנסות.';

  @override
  String get phoneRule => 'כלל טלפון';

  @override
  String get phoneRuleEditDialog => 'דו-שיח עריכת כלל טלפון';

  @override
  String get phoneRuleManagement => 'ניהול כללי טלפון';

  @override
  String get phoneRuleSubscription => 'מנוי כללי טלפון';

  @override
  String get phoneSubscription => 'מנוי טלפון';

  @override
  String get phoneSubscriptionRulesDescription =>
      'הירשם לרשימות כללי טלפון באמצעות URL כדי לעדכן אוטומטית כללי רשימה לבנה ושחורה. תומך בקובצי כללים בפורמט JSON.';

  @override
  String get phoneSubscriptionTitle => 'מנויי כללי טלפון';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'אנא בחר תווית והזן מספר טלפון תקין';

  @override
  String pluginAddedSuccess(Object name) {
    return 'התוסף \"$name\" הוסף בהצלחה';
  }

  @override
  String get pluginDeleted => 'התוסף נמחק';

  @override
  String get pluginLatestVersion => 'התוסף כבר בגרסה האחרונה';

  @override
  String get pluginListExportSuccess => 'רשימת התוספים יצואנה בהצלחה';

  @override
  String get pluginLoadedSuccessfully => 'התוסף נטען בהצלחה';

  @override
  String get pluginManagement => 'ניהול תוספים';

  @override
  String get pluginManagementSubtitle => 'נהל והגדר תוספים של צד שלישי';

  @override
  String get pluginManagementTitle => 'ניהול תוספים';

  @override
  String get pluginName => 'שם תוסף';

  @override
  String get pluginNotLoaded => 'התוסף עדיין לא נטען. אנא טען את התוסף תחילה.';

  @override
  String pluginsDeleted(Object count) {
    return '$count תוספים נמחקו בהצלחה.';
  }

  @override
  String get pluginService => 'שירות תוספים';

  @override
  String get pluginTestPageTitle => 'בדיקת תוסף';

  @override
  String get pluginUpdateSuccess => 'התוסף עודכן בהצלחה';

  @override
  String get pluginUrl => 'כתובת URL של תוסף';

  @override
  String get pluginUrlCannotBeEmpty =>
      'כתובת URL של תוסף אינה יכולה להיות ריקה';

  @override
  String get pluginUrlHint => 'הזן כתובת URL של תוסף';

  @override
  String get pluginUrlLabel => 'כתובת URL של תוסף';

  @override
  String get pluginVersion => 'גרסת תוסף';

  @override
  String get political => 'פוליטי';

  @override
  String get powerfulSpamBlocking => 'חסימת ספאם עוצמתית';

  @override
  String get previousStep => 'קודם';

  @override
  String get prioritizeRemoteAction => 'העדפת הגדרות פעולה מרוחקות';

  @override
  String get prioritizeRemoteActionDescription =>
      'העדפת הגדרות פעולה מבסיס הנתונים המרוחק';

  @override
  String get processing => 'מעבד...';

  @override
  String get processingOperation => 'מעבד...';

  @override
  String get purchase => 'רכישה';

  @override
  String get quarterlyMembership => 'חברות רבעונית';

  @override
  String get quarterlyMembershipDescription =>
      'פתח את כל התכונות הפרימיום, חידוש אוטומטי כל רבעון';

  @override
  String get queryButton => 'בירור';

  @override
  String get queryFailed => 'הבירור נכשל';

  @override
  String get queryFailedLog => 'הבירור נכשל';

  @override
  String get querying => 'מברר...';

  @override
  String get queryingPhoneNumber => 'בירור מספר טלפון';

  @override
  String get queryResultTitle => 'תוצאת בירור';

  @override
  String get ready => 'מוכן!';

  @override
  String get receiveWeeklyStatistics => 'קבל סטטיסטיקות שבועיות';

  @override
  String get recruiter => 'מגייס';

  @override
  String get reEnterPasswordHint => 'אנא הכנס סיסמה מחדש';

  @override
  String get refresh => 'רענן';

  @override
  String get refreshPermissionStatus => 'רענן סטטוס הרשאה';

  @override
  String get refreshTooltip => 'רענן';

  @override
  String regexError(Object error) {
    return 'שגיאת Regex: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'שגיאת Regex: $error';
  }

  @override
  String get regexPattern => 'דפוס ביטוי רגולרי';

  @override
  String get regexPatternExplanation => 'הסבר לדפוס ביטוי רגולרי';

  @override
  String get regexPatternExplanationButton => 'הסבר לדפוס ביטוי רגולרי';

  @override
  String get regexPatternLabel => 'דפוס ביטוי רגולרי';

  @override
  String get regexPatternsExamples =>
      'השתמש בתחביר ביטוי רגולרי סטנדרטי להגדרת דפוסים. דוגמאות:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'דפוסי ביטוי רגולרי להתאמת מספרי טלפון';

  @override
  String get regexRule => 'כלל ביטוי רגולרי';

  @override
  String regexRuleAddFailed(Object error) {
    return 'הוספת כלל ביטוי רגולרי נכשלה: $error';
  }

  @override
  String get regexRuleAddSuccess => 'כלל ביטוי רגולרי נוסף בהצלחה';

  @override
  String get regexRuleManagement => 'ניהול כללי ביטוי רגולרי';

  @override
  String get regexRuleNamePatternRequired =>
      'שם הכלל ודפוס הביטוי הרגולרי לא יכולים להיות ריקים';

  @override
  String get regexRules => 'כללי ביטוי רגולרי';

  @override
  String get regexTesterTitle => 'בוחן ביטויים רגולריים';

  @override
  String regexValidationFailed(Object error) {
    return 'אימות ביטוי רגולרי נכשל: $error';
  }

  @override
  String get regexValidationSuccess => 'אימות ביטוי רגולרי הצליח';

  @override
  String get region => 'אזור';

  @override
  String get registeredDevicesTitle => 'מכשירים רשומים';

  @override
  String get rejectAllCalls => 'דחה את כל השיחות';

  @override
  String get rejectAllCallsDescription =>
      'כאשר מופעל, כל השיחות יידחו בעדיפות הגבוהה ביותר';

  @override
  String get rejectAllNumbers => 'דחה את כל המספרים';

  @override
  String get rejectAllNumbersDesc => 'דחה את כל השיחות הנכנסות כאשר מופעל';

  @override
  String get rejectExceededNumbers => 'דחה מספרים חורגים';

  @override
  String get rejectExceededNumbersDescription =>
      'דחה אוטומטית מספרים החורגים מסף הספירה';

  @override
  String get remoteFilterSettings => 'הגדרות מסנן מרחוק';

  @override
  String get remoteFilterSettingsPageTitle => 'הגדרות מסנן מספרים מרחוק';

  @override
  String get remoteNumberFilter => 'מסנן מספרים מרחוק';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'מסנן זה משתמש במסד נתונים מרחוק עצמאי כדי לקבל את מידע המספרים העדכני ביותר.';

  @override
  String get remoteNumberFilterDescription =>
      'יירט שיחות מטרידות על בסיס מידע ממסד נתונים מרחוק';

  @override
  String get remoteNumberFilterExplanationContent =>
      'מסנן המספרים מרחוק מזהה ומונע שיחות ספאם על ידי שאילתה למסד נתונים מרחוק על סמך ספירת מספרים.';

  @override
  String get remoteNumberFilterExplanationTitle => 'הסבר למסנן מספרים מרחוק';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• סף ספירה: קבע על בסיס תדירות הופעת המספר';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• פעולות סינון: הגדר כיצד לטפל במספרים החורגים מהסף';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• הגדרות עדיפות: קבע עדיפות לפעולות מרחוק';

  @override
  String get remoteNumberFilterFeatures => 'תכונות:';

  @override
  String get remoteNumberFiltering => 'סינון מספרים מרחוק';

  @override
  String get remoteNumberFilteringExplanation =>
      '• סינון מספרים מרחוק: כללי סינון המבוססים על מידע ממסד נתונים מרחוק';

  @override
  String get remoteNumberFilterSubtitle =>
      'זהה שיחות ספאם באמצעות מסד נתונים בענן ודיווחים קהילתיים';

  @override
  String get removeAdsDescription =>
      'הסר לצמיתות את כל הפרסומות באפליקציה לחוויה חלקה יותר';

  @override
  String get removeAdsTitle => 'הסר פרסומות';

  @override
  String get removedFromFavoriteContacts => 'הוסר מרשימת אנשי הקשר המועדפים';

  @override
  String get removedFromFavorites => 'הוסר מרשימת המועדפים';

  @override
  String get removeFavorite => 'הסר מועדף';

  @override
  String get removeFromFavorites => 'הסר מרשימת המועדפים';

  @override
  String get renameButton => 'שנה שם';

  @override
  String get renameDeviceDialogTitle => 'שנה שם למכשיר';

  @override
  String get renameDeviceTitle => 'שנה שם למכשיר';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'פעולה זו תחליף את כל ההגדרות הנוכחיות שלך. האם אתה בטוח שברצונך להמשיך?';

  @override
  String get requestAllPermissions => 'בקש את כל ההרשאות';

  @override
  String get requestPermission => 'בקש הרשאה';

  @override
  String requestPermissionFailed(Object error) {
    return 'בקשת הרשאה נכשלה: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count סימנים';
  }

  @override
  String get reset => 'אפס';

  @override
  String get restore => 'שחזר';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'שחזר הגדרות אפליקציה מגיבוי';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'שחזר הגדרות אפליקציה מגיבוי';

  @override
  String get restoreButton => 'שחזר';

  @override
  String restoreFailedWithError(Object error) {
    return 'שחזור מהענן נכשל: $error';
  }

  @override
  String get restoreFromCloud => 'שחזר מהענן';

  @override
  String get restoreFromCloudDescription => 'שחזר הגדרות וכללים מאחסון בענן';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'שחזור מהענן נכשל: $error';
  }

  @override
  String get restoreFromCloudLabel => 'שחזר מהענן';

  @override
  String get restoreFromCloudSuccess => 'שוחזר בהצלחה מהענן';

  @override
  String get restoreFromCloudTitle => 'שחזר מהענן';

  @override
  String get restoreFromLocal => 'שחזר מהמקומי';

  @override
  String get restorePurchases => 'שחזר רכישות';

  @override
  String get restoreSectionTitle => 'שחזור';

  @override
  String get restoreSettings => 'שחזר הגדרות';

  @override
  String get restoreSettingsConfirmation =>
      'פעולה זו תחליף את כל ההגדרות הנוכחיות שלך. האם אתה בטוח שברצונך להמשיך?';

  @override
  String get restoreSettingsDialogTitle => 'שחזר הגדרות';

  @override
  String get restoreSettingsTitle => 'שחזר הגדרות';

  @override
  String get restoreSuccessFromLocal => 'שוחזר בהצלחה מהמקומי';

  @override
  String get restoreSuccessMessage => 'שוחזר בהצלחה מהענן';

  @override
  String get retry => 'נסה שוב';

  @override
  String get ridesharing => 'שיתוף נסיעות';

  @override
  String get risk => 'סיכון';

  @override
  String get robocall => 'שיחת רובו';

  @override
  String get ruleAction => 'פעולת כלל';

  @override
  String get ruleAddButton => 'הוסף כלל';

  @override
  String get ruleAddedSuccess => 'כלל נוסף בהצלחה';

  @override
  String ruleAddFailure(Object error) {
    return 'הוספת כלל נכשלה: $error';
  }

  @override
  String get ruleAddSuccess => 'כלל נוסף בהצלחה';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'האם אתה בטוח שברצונך למחוק את ה-$ruleType הזה?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'מחק כלל';

  @override
  String get ruleDeletedSuccess => 'כלל נמחק בהצלחה';

  @override
  String get ruleDeletedSuccessfully => 'כלל נמחק בהצלחה';

  @override
  String ruleDeleteFailed(Object error) {
    return 'מחיקת כלל נכשלה: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'מחיקת כלל נכשלה: $error';
  }

  @override
  String get ruleDeleteSuccess => 'כלל נמחק בהצלחה';

  @override
  String get ruleDisabledSuccessfully => 'כלל הושבת בהצלחה';

  @override
  String get ruleEnabledSuccessfully => 'כלל הופעל בהצלחה';

  @override
  String ruleLoadFailed(Object error) {
    return 'טעינת כללים נכשלה: $error';
  }

  @override
  String get ruleManagement => 'ניהול כללים';

  @override
  String get ruleManagementTitle => 'ניהול כללים';

  @override
  String get ruleName => 'שם הכלל';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'שם הכלל וביטוי התוכן הרגולרי לא יכולים להיות ריקים';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'שם הכלל ומספר הטלפון לא יכולים להיות ריקים';

  @override
  String get ruleNameHint => 'למשל, משפחה, חברים, וכו\'.';

  @override
  String get ruleNameLabel => 'שם הכלל';

  @override
  String get ruleNamePatternRequired => 'אנא הזן שם כלל ודפוס';

  @override
  String get ruleNameRequired => 'שם הכלל ומספר הטלפון לא יכולים להיות ריקים';

  @override
  String get ruleNotExist => 'הכלל אינו קיים או נמחק';

  @override
  String ruleNotFound(Object error) {
    return 'הכלל לא נמצא: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'הכלל נשמר בהצלחה!';

  @override
  String get ruleSavedSuccessMessage => 'הכלל נשמר בהצלחה!';

  @override
  String ruleSaveFailed(Object error) {
    return 'שמירה נכשלה: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'שמירה נכשלה: $error';
  }

  @override
  String get ruleSaveSuccess => 'הכלל נשמר בהצלחה!';

  @override
  String get rulesExportedSuccessfully => 'כללים יצאו בהצלחה';

  @override
  String rulesExportedTo(Object path) {
    return 'כללים יצאו ל: $path';
  }

  @override
  String get rulesImported => 'כללים יובאו בהצלחה';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count כללים יובאו בהצלחה';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'נכשל ביבוא כללים: $error';
  }

  @override
  String get ruleStatistics => 'סטטיסטיקות כללים';

  @override
  String ruleStatusChanged(Object status) {
    return 'הכלל $status בהצלחה';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'הפעולה נכשלה: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'הכלל $status בהצלחה';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'נכשל עדכון הכלל: $error';
  }

  @override
  String get ruleUpdateSuccess => 'הכלל עודכן בהצלחה';

  @override
  String get ruleVerification => 'אימות כללים';

  @override
  String get save => 'שמור';

  @override
  String get saveButton => 'שמור';

  @override
  String get saveButtonLabel => 'שמור';

  @override
  String get saveButtonText => 'שמור';

  @override
  String saveFailed(Object error) {
    return 'שמירה נכשלה: $error';
  }

  @override
  String get saveFilter => 'שמור סינון';

  @override
  String get saveSettings => 'שמור הגדרות';

  @override
  String saveSettingsFailed(Object error) {
    return 'נכשל שמירת הגדרות: $error';
  }

  @override
  String get scamsLikely => 'סביר להניח שמדובר בהונאות';

  @override
  String get search => 'חיפוש';

  @override
  String get searchContacts => 'חפש אנשי קשר';

  @override
  String searchError(Object error) {
    return 'שגיאת חיפוש: $error';
  }

  @override
  String get searchFilters => 'סנני חיפוש';

  @override
  String get searchForContacts => 'חפש אנשי קשר';

  @override
  String get searchHint => 'חפש...';

  @override
  String get searchSettingsSubtitle =>
      'חפש אנשי קשר, תוויות, רשימות שחורות, רשימות לבנות וכו\'.';

  @override
  String get searchSettingsTitle => 'הגדרות חיפוש';

  @override
  String get securityMessage =>
      'אל תסמוך על שיחות טלפון כלשהן. תמיד אמת מספרי שירות לקוחות באופן עצמאי. לעולם אל תשתף סיסמאות, קודי אימות, מספרי כרטיסים או מידע אישי.';

  @override
  String get selectActionToPerform => 'בחר את הפעולה שיש לבצע כאשר הכלל תואם';

  @override
  String get selectActionWhenBlockingCalls => 'בחר פעולה בעת חסימת שיחות';

  @override
  String get selectActionWhenRuleMatches => 'בחר פעולה כאשר הכלל תואם';

  @override
  String get selectAll => 'בחר הכל';

  @override
  String get selectCountry => 'בחר מדינה';

  @override
  String get selectDateRange => 'בחר טווח תאריכים';

  @override
  String get selectedDateRange => 'טווח תאריכים שנבחר';

  @override
  String selectedItems(Object count) {
    return '$count פריטים נבחרו';
  }

  @override
  String get selectedLabel => 'נבחר:';

  @override
  String get selectExportFormat => 'בחר פורמט ייצוא';

  @override
  String get selectLabel => 'בחר תווית';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'אנא בחר תווית והזן מספר טלפון חוקי';

  @override
  String get selectLanguage => 'בחר שפה';

  @override
  String get selectMultiple => 'בחר מרובה';

  @override
  String get selectPeriod => 'בחר תקופה';

  @override
  String get selectSimCard => 'בחר כרטיס SIM';

  @override
  String get selectSimSlot => 'בחר חריץ SIM';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'בחר את הפעולה הספציפית לביצוע בעת חסימת שיחות';

  @override
  String get selectTag => 'בחר תגית';

  @override
  String get selectTags => 'בחר תגיות';

  @override
  String get selectTrustedDataSource => 'אנא בחר מקורות נתונים מהימנים';

  @override
  String get selectYourLanguage => 'בחר את השפה שלך';

  @override
  String get sender => 'שולח';

  @override
  String get senderRegexOptional => 'ביטוי רגולרי של שולח (אופציונלי)';

  @override
  String get serverAddressLabel => 'כתובת שרת';

  @override
  String get serviceTypeContact => 'מנוי איש קשר';

  @override
  String get serviceTypeLabel => 'סוג שירות';

  @override
  String get serviceTypePhone => 'מנוי טלפון';

  @override
  String get serviceTypePlugin => 'עדכון תוסף';

  @override
  String get serviceTypeSms => 'מנוי SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'הגדר';

  @override
  String get setEncryptionPassword => 'הגדר סיסמת הצפנה';

  @override
  String get setEncryptionPasswordDescription =>
      'הגדר סיסמת הצפנה לגיבוי ושחזור';

  @override
  String get setEncryptionPasswordLabel => 'הגדר סיסמת הצפנה';

  @override
  String get setEncryptionPasswordTitle => 'הגדר סיסמת הצפנה';

  @override
  String get setPasswordButton => 'הגדר';

  @override
  String get settings => 'הגדרות';

  @override
  String settingsBackedUpTo(Object path) {
    return 'הגדרות גובו ל: $path';
  }

  @override
  String get settingsLoaded => 'הגדרות נטענו';

  @override
  String settingsLoadFailed(Object error) {
    return 'נכשל טעינת הגדרות: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'הגדרות שוחזרו בהצלחה. אנא הפעל מחדש את האפליקציה כדי שהשינויים ייכנסו לתוקף.';

  @override
  String get settingsSaved => 'הגדרות נשמרו';

  @override
  String settingsSaveFailed(Object error) {
    return 'נכשל שמירת הגדרות: $error';
  }

  @override
  String get settingsTab => 'הגדרות';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get setup => 'הגדרה';

  @override
  String get showContactEditDialogStaticMethod =>
      'שיטה סטטית להצגת דיאלוג עריכת איש קשר';

  @override
  String get showExplanation => 'הצג הסבר';

  @override
  String get silence => 'השתק';

  @override
  String get silenceAndNoAnswer => 'השתק וללא מענה';

  @override
  String get silenceNoAnswer => 'השתק ללא מענה';

  @override
  String get silentCallVoiceClone => 'שכפול קול שיחה מושתקת';

  @override
  String get silentRules => 'כללים מושתקים';

  @override
  String simCard(Object simNumber) {
    return 'כרטיס SIM $simNumber';
  }

  @override
  String get simCardColor => 'צבע כרטיס SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• הגדרת כרטיס SIM: הגדר כללי סינון עצמאיים לכל כרטיס SIM';

  @override
  String get simCardFilterRules => 'כללי סינון כרטיס SIM';

  @override
  String get simCardFilterRulesDescription =>
      'הגדר כללי סינון שונים בהתבסס על חריצי כרטיס SIM';

  @override
  String get simCardFontSize => 'גודל גופן כרטיס SIM';

  @override
  String get simCardPosition => 'מיקום כרטיס SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'נכשל טעינת מידע על כרטיס SIM: $error';
  }

  @override
  String get simRuleInstructions =>
      'כללי כרטיס ה-SIM מאפשרים לך להגדיר כללי סינון עצמאיים עבור כל חריץ SIM.';

  @override
  String get simRuleInstructionsTitle => 'כללי חריץ SIM';

  @override
  String get simRuleManagement => 'ניהול כללי חריץ SIM';

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
    return 'טעינת נתוני SIM נכשלה: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'תצורת מסנן חריץ SIM';

  @override
  String get simSlotFilterConfigurationDescription =>
      'מאפשר הגדרת כללי סינון לפי חריץ SIM';

  @override
  String get simSlotFilterDescription =>
      'הגדר כללי סינון עצמאיים עבור כל כרטיס SIM:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'הגדרות מסנן חריץ SIM $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'טעינת חריצי SIM נכשלה: $error';
  }

  @override
  String get simSlotManagement => 'ניהול חריץ SIM';

  @override
  String simSlotOperationFailed(Object error) {
    return 'פעולת חריץ SIM נכשלה: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'מיקום חריץ SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• כללי חריץ SIM: אסטרטגיות סינון עצמאיות לכל SIM';

  @override
  String get simSlotRuleListTitle => 'רשימת כללי חריץ SIM';

  @override
  String get simSlotRuleManagement => 'כללי חריץ SIM';

  @override
  String get simSlotRuleManagementTitle => 'ניהול כללים';

  @override
  String get simSlotSettings => 'הגדרות חריץ SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'חריץ SIM $slotNumber';
  }

  @override
  String get skip => 'דלג';

  @override
  String get smartCallerId => 'זיהוי מתקשר חכם';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'סינון SMS עוזר לך לסנן הודעות ספאם באופן אוטומטי ולשמור על רשימת ההודעות שלך נקייה. ניתן להגדיר כללי סינון ושיטות הודעה.';

  @override
  String get smsFilterDisabled => 'סינון SMS מושבת';

  @override
  String get smsFilterEnabled => 'סינון SMS מופעל';

  @override
  String get smsFilterRuleAddedSuccessfully => 'כלל סינון SMS נוסף בהצלחה';

  @override
  String get smsFilterRules => 'כללי סינון SMS';

  @override
  String get smsFilterSettings => 'הגדרות סינון SMS';

  @override
  String get smsHistory => 'היסטוריית SMS';

  @override
  String get smsManagement => 'ניהול SMS';

  @override
  String get smsPermission => 'הרשאת SMS';

  @override
  String get smsPermissionDescription => 'משמש לסינון הודעות ספאם.';

  @override
  String get smsRuleAddedSuccessfully => 'כלל SMS נוסף בהצלחה';

  @override
  String get smsRuleDeletedSuccessfully => 'כלל SMS נמחק בהצלחה';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'טעינת כללי SMS נכשלה: $error';
  }

  @override
  String get smsRuleManagement => 'ניהול כללי SMS';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'כללי SMS יצאו בהצלחה אל $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'כללי SMS יובאו בהצלחה';

  @override
  String get smsRuleSubscription => 'מנוי כללי SMS';

  @override
  String get smsRuleUpdatedSuccessfully => 'כלל SMS עודכן בהצלחה';

  @override
  String get smsSettingsSubtitle => 'סינון SMS וחסימת מילות מפתח';

  @override
  String get smsSettingsTitle => 'הגדרות SMS';

  @override
  String get smsSubscription => 'מנוי SMS';

  @override
  String get smsSubscriptionAddedSuccessfully => 'מנוי SMS נוסף בהצלחה';

  @override
  String get smsSubscriptionRulesDescription =>
      'הירשם לרשימות כללי SMS באמצעות URL, תומך בהתאמת ביטוי רגולרי. ניתן להגדיר פעולות חסימה או הרשאה.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'חלק מבקשות ההרשאה נדחו';

  @override
  String get spamLikely => 'ספאם סביר';

  @override
  String get startColor => 'צבע התחלה';

  @override
  String get startDate => 'תאריך התחלה';

  @override
  String get startUsing => 'התחל להשתמש';

  @override
  String get statAnswered => 'נענה';

  @override
  String get statBlocked => 'נחסם';

  @override
  String get staticMethodShowCallerIdDialog =>
      'שיטה סטטית להצגת דיאלוג מידע למתקשר';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'שיטה סטטית להצגת דיאלוג בחירת מדינה';

  @override
  String get staticMethodToDisplayDialog => 'שיטה סטטית להצגת דיאלוג';

  @override
  String get statistics => 'סטטיסטיקה';

  @override
  String get statisticsExportFeatureComingSoon =>
      'תכונת ייצוא סטטיסטיקה תגיע בקרוב';

  @override
  String get statisticsGrid => 'טבלת סטטיסטיקה';

  @override
  String get statisticsPageTitle => 'ניתוח נתונים';

  @override
  String get stirColor => 'צבע STIR';

  @override
  String get stirFontSize => 'גודל גופן STIR';

  @override
  String get stirPosition => 'מיקום STIR';

  @override
  String get storagePermission => 'הרשאת אחסון';

  @override
  String get storagePermissionDescription => 'משמש לשמירת הגדרות וכללים.';

  @override
  String get subscribe => 'הירשם כמנוי';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'המנוי \"$name\" נוסף בהצלחה';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'האם אתה בטוח שברצונך למחוק מנוי זה?';

  @override
  String get subscriptionDeleteConfirmTitle => 'מחיקת מנוי';

  @override
  String get subscriptionDeleted => 'המנוי נמחק';

  @override
  String get subscriptionDeletedSuccessfully => 'המנוי נמחק בהצלחה';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'מחיקת המנוי נכשלה: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'המנוי נמחק';

  @override
  String get subscriptionEmptyState => 'אין מנויים זמינים';

  @override
  String get subscriptionEmptyText => 'עדיין אין מנויים';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'טעינת מנויים נכשלה: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'טעינת מנויים נכשלה: $error';
  }

  @override
  String get subscriptionManagementTitle => 'ניהול מנויים';

  @override
  String get subscriptionName => 'שם המנוי';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'שם המנוי וכתובת ה-URL אינם יכולים להיות ריקים';

  @override
  String get subscriptionNameHint => 'הזן שם מנוי';

  @override
  String get subscriptionPageTitle => 'ניהול מנויים';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'שינוי סטטוס המנוי נכשל: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'שינוי סטטוס המנוי נכשל: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'עדכון המנוי נכשל: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'המנוי עודכן בהצלחה';

  @override
  String get subscriptionUrl => 'כתובת URL של מנוי';

  @override
  String get subscriptionUrlHint => 'הזן כתובת URL של מנוי';

  @override
  String successfullyImportedRules(Object count) {
    return '$count כללים יובאו בהצלחה';
  }

  @override
  String get supportSync => 'תמיכה בסנכרון';

  @override
  String get survey => 'סקר';

  @override
  String get syncDevicesButton => 'סנכרן מכשירים';

  @override
  String get syncFailed => 'הסנכרון נכשל';

  @override
  String get syncFailedMessage => 'הסנכרון נכשל';

  @override
  String get syncFolderNameHint =>
      'אנא הזן שם תיקיית סנכרון (ברירת מחדל: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'שם תיקיית סנכרון';

  @override
  String get synchronized => 'מסונכרן';

  @override
  String get syncing => 'מסנכרן...';

  @override
  String get syncNow => 'סנכרן עכשיו';

  @override
  String get syncNowButton => 'סנכרן עכשיו';

  @override
  String get syncStatusTitle => 'סטטוס סינכרון';

  @override
  String get syncStatusUpdatedMessage => 'סטטוס הסינכרון עודכן';

  @override
  String get syncSuccessful => 'סינכרון הושלם בהצלחה';

  @override
  String get syncSuccessMessage => 'סינכרון הושלם בהצלחה';

  @override
  String get syncWithCloudStorage => 'סנכרן עם אחסון ענן';

  @override
  String get syncWithCloudStorageSubtitle => 'סנכרן עם אחסון ענן';

  @override
  String get systemFeatures => 'תכונות מערכת:';

  @override
  String get systemSettingsTitle => 'הגדרות מערכת';

  @override
  String get tabAll => 'הכל';

  @override
  String get tabAnswered => 'נענו';

  @override
  String get tabBlocked => 'נחסמו';

  @override
  String get tabMissed => 'הוחמצו';

  @override
  String get tabOutgoing => 'יוצאים';

  @override
  String tagLabel(String tag) {
    return 'תגית: $tag';
  }

  @override
  String get tagsUpdated => 'תגיות עודכנו';

  @override
  String get takeaway => 'טייק אווי';

  @override
  String get telecommunication => 'תקשורת';

  @override
  String get telegram => 'טלגרם';

  @override
  String get telemarketing => 'שיווק טלפוני';

  @override
  String get testButton => 'בדיקה';

  @override
  String get testButtonLabel => 'בדיקה';

  @override
  String get testConnectionButton => 'בדוק חיבור';

  @override
  String get textColorsSetting => 'צבעי טקסט ותוויות';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'אפליקציה זו היא כלי מזהה שיחות עוצמתי המאפשר לך לזהות ולחסום שיחות לא רצויות.';

  @override
  String get thisWeek => 'השבוע';

  @override
  String get timeInterceptor => 'חוטם זמן';

  @override
  String get timeInterceptorDescription =>
      'יירט/אפשר שיחות פוטנציאליות באופן אוטומטי בהתבסס על תדירות שיחות';

  @override
  String get timeInterceptorExplanation =>
      '• חוטם זמן: יירוט/אפשר שיחות חוזרות בפרק זמן קצר';

  @override
  String get timeInterceptorExplanationContent =>
      'תכונת יירוט תדירות השיחות מנתחת את תדירות השיחות כדי לזהות באופן אוטומטי וליירט/לאפשר שיחות זבל תכופות.';

  @override
  String get timeInterceptorExplanationTitle => 'הסבר יירוט תדירות שיחות';

  @override
  String get timeInterceptorSettingsTitle => 'הגדרות יירוט תדירות שיחות';

  @override
  String get timeInterceptorSubtitle =>
      'יירוט אוטומטי של שיחות זבל פוטנציאליות בהתבסס על תדירות שיחות';

  @override
  String get timeInterceptorTitle => 'אפשר יירוט תדירות שיחות';

  @override
  String get timeWindowDescription =>
      'קבע את גודל חלון הזמן להתרת שיחות חוזרות. שיחות מאותו מספר בתוך חלון זה יותרו';

  @override
  String timeWindowLabel(int minutes) {
    return 'חלון זמן יירוט (דקות): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'קבע את גודל חלון הזמן להתרת שיחות חוזרות. שיחות מאותו מספר בתוך חלון זה יותרו';

  @override
  String get today => 'היום';

  @override
  String get total => 'סה\"כ';

  @override
  String get totalBlocked => 'סה\"כ נחסמו';

  @override
  String get totalFiltered => 'סה\"כ סוננו';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'העבר נתונים בין מכשירים או פלטפורמות';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'העבר נתונים בין מכשירים או פלטפורמות';

  @override
  String get travelTicketing => 'כרטיסי נסיעה';

  @override
  String get trend => 'מגמה';

  @override
  String get trendChart => 'תרשים מגמה';

  @override
  String get tutorial => 'מדריך';

  @override
  String get type => 'סוג';

  @override
  String get unassignedSIMCard => 'כרטיס SIM לא משויך';

  @override
  String get unknown => 'לא ידוע';

  @override
  String get unknownLabel => 'תווית לא ידועה';

  @override
  String get unknownTag => 'תגית: לא ידוע';

  @override
  String get unregisterButton => 'בטל רישום';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'האם אתה בטוח שברצונך לבטל רישום של $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'בטל רישום מכשיר';

  @override
  String get unsupportedFileFormat => 'פורמט קובץ לא נתמך';

  @override
  String get update => 'עדכון';

  @override
  String get updateAllNow => 'עדכן הכל עכשיו';

  @override
  String get updateCallFilterConfig => 'עדכן תצורת מסנן שיחות';

  @override
  String updateContactFailed(Object error) {
    return 'שגיאה בעדכון איש קשר: $error';
  }

  @override
  String get updateFavoriteStatus => 'עדכן סטטוס מועדף';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'שגיאה בעדכון סטטוס מועדף: $error';
  }

  @override
  String get updateInterval => 'מרווח עדכון';

  @override
  String get updateLabelFailed => 'שגיאה בעדכון תווית';

  @override
  String get updateNow => 'עדכן עכשיו';

  @override
  String get updatePlugin => 'עדכן תוסף';

  @override
  String updatePluginFailed(Object error) {
    return 'שגיאה בעדכון תוסף: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'שגיאה בעדכון כלל: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'שגיאה בעדכון מנוי: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service עודכן בהצלחה ($count כללים)';
  }

  @override
  String get updateTags => 'עדכן תגיות';

  @override
  String get useCasesPoint1 => '• זיהוי שיחות זבל של חייגן אוטומטי';

  @override
  String get useCasesPoint2 =>
      '• יירוט שיחות שיווק שמתקשרות מספר פעמים בפרק זמן קצר';

  @override
  String get useCasesPoint3 => '• מניעת הטלת טלפונים והטרדות';

  @override
  String get useCasesTitle => 'מקרים לשימוש:';

  @override
  String get useGlobalSettings => 'השתמש בהגדרות גלובליות';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'שם משתמש';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'השתמש בתחביר Regex סטנדרטי להגדרת תבניות. דוגמאות:';

  @override
  String get validateRegex => 'אמת Regex';

  @override
  String get verificationFailedText => 'נכשל';

  @override
  String get verifiedText => 'מאומת';

  @override
  String get verify => 'אמת';

  @override
  String version(Object version) {
    return 'גרסה: $version';
  }

  @override
  String get vipExchangeDescription => 'החלף חברות VIP בספירת סימוני טלפון';

  @override
  String get vipExchangeTitle => 'החלפת VIP סימונים';

  @override
  String get watchAd => 'צפה בפרסומת';

  @override
  String get watchAdForTemp => 'צפה בפרסומת להרשאות זמניות';

  @override
  String get watchAdForTempDescription =>
      'צפה בפרסומת קצרה כדי לפתוח באופן זמני חלק מהתכונות הפרימיום';

  @override
  String get webDAVConfigTitle => 'תצורת WebDAV';

  @override
  String get webdavConfigurationTitle => 'תצורת WebDAV';

  @override
  String get webdavPasswordHint => 'אנא הזן סיסמת WebDAV';

  @override
  String get webdavServerAddressHint => 'אנא הזן כתובת שרת WebDAV';

  @override
  String get webdavUsernameHint => 'אנא הזן שם משתמש WebDAV';

  @override
  String get week => 'שבוע';

  @override
  String get weekly => 'שבועי';

  @override
  String get weeklyBlockedCallsSummary => 'סיכום שיחות חסומות שבועיות';

  @override
  String get weeklyChartTitle => 'שיחות חסומות שבועיות';

  @override
  String get weeklyReport => 'דוח שבועי';

  @override
  String get weeklyReportDesc => 'קבל דוח סיכום שבועי של פעילות חסימת שיחות';

  @override
  String get welcome => 'ברוכים הבאים';

  @override
  String get whitelist => 'רשימה לבנה';

  @override
  String get whitelistLabel => 'רשימה לבנה';

  @override
  String get width => 'רוחב';

  @override
  String get wildcardMatchingDescription =>
      'השתמשו ב-\'.\' כדי להתאים לכל תו (לדוגמה, \'123.456\' יתאים ל-123-456)';

  @override
  String get wildcardMatchingTitle => 'התאמת תווים כלליים:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'תמיכה בתווים כלליים לסינון גמיש';

  @override
  String get windowSizeSetting => 'גודל חלון';

  @override
  String get year => 'שנה';

  @override
  String get yearly => 'שנתי';

  @override
  String get yearlyChartTitle => 'שיחות חסומות שנתיות';

  @override
  String get noSimCardsDetected => 'לא זוהו כרטיסי SIM';

  @override
  String get filterManagementDescription => 'הגדר מסנני שיחות';

  @override
  String get callerIdCustomizationSubtitle => 'התאמה אישית של פריסת מזהה מתקשר';

  @override
  String get fraudAlerSettingTitle => 'הגדרת התראת הונאה';

  @override
  String get fraudAlerSettingSubtitle => 'להגדרת התראת הונאה';

  @override
  String get enableFraudAlert => 'הפעל התראת הונאה';

  @override
  String get enableFraudAlertDescription => 'התראות לשיחות חשודות כהונאה';

  @override
  String get enableVibration => 'הפעל רטט';

  @override
  String get enableVibrationDescription => 'רעד כאשר שיחות חשודות כהונאה';

  @override
  String get notificationSettingsTitle => 'הגדרות התראות';

  @override
  String get useLocalNotification => 'השתמש בהתראות מקומיות';

  @override
  String get useLocalNotificationDescription =>
      'הפעל התראות מקומיות לשיחות נכנסות';

  @override
  String get cancelLocalNotification => 'סגור התראות מקומיות';

  @override
  String get useStirNotification => 'השתמש בהתראה מ-STIR';

  @override
  String get useStirNotificationDescription => 'הפעל התראות STIR לשיחות נכנסות';

  @override
  String get cancelLocalNotificationDescription =>
      'סגור התראות מקומיות באופן אוטומטי';

  @override
  String get callerIdSettingsTitle => 'הגדרות מזהה מתקשר';

  @override
  String get callerIdSettingsSubtitle => 'להגדרת התראה ותצוגה של שיחה נכנסת';

  @override
  String get purchaseTitle => 'רכישה';

  @override
  String get purchaseSubtitle => 'לרכישת השירות';

  @override
  String get callerIdNotificationTitle => 'מידע על שיחה נכנסת';

  @override
  String callerIdBody(String phoneNumber) {
    return 'מספר: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'שיחה חסומה';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'שיחה חסומה מ- $phoneNumber';
  }

  @override
  String get stirVerified => 'מאומת';

  @override
  String get stirNotVerified => 'לא מאומת';

  @override
  String get stirFailed => 'אימות נכשל';

  @override
  String get stirUnknown => 'סטטוס אימות לא ידוע';

  @override
  String get stirVerificationTitle => 'אימות STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage עבור מספר $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings => 'הגדרות הודעות אבטחה מתגלגלות';

  @override
  String get messageColor => 'צבע הודעה';

  @override
  String get messageFontSize => 'גודל גופן הודעה';

  @override
  String get messagePosition => 'מיקום הודעה';

  @override
  String get containerWidth => 'רוחב מכלול';

  @override
  String get scrollSpeed => 'מהירות גלילה';

  @override
  String get enableSecurityMessage => 'הפעל הודעת אבטחה';

  @override
  String get fraudAlertTitle => 'התראת הונאה';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'שיחת הונאה פוטנציאלית מ- $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'נכשל טעינת כללים: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'נכשל טעינת יומן שיחות: $error';
  }

  @override
  String get noBlockedTypeData => 'אין נתוני סוג חסימה זמינים';

  @override
  String importEntity(Object entityTypeName) {
    return 'ייבוא $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName יובא בהצלחה, סך הכל $count רשומות יובאו';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'נכשל ייבוא $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'ייצוא $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName ייוצא בהצלחה';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'נכשל ייצוא $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'שירות סנכרון ענן';

  @override
  String get membershipCenter => 'מרכז חברות';

  @override
  String get redeemVipWithMarks => 'מימוש VIP עם סימנים';

  @override
  String get currentMarkCount => 'כמות סימנים נוכחית';

  @override
  String get markMoreNumbersForMore => 'סמן עוד מספרים לעוד סימנים';

  @override
  String get noAds => 'אין פרסומות';

  @override
  String get cloudBackup => 'גיבוי בענן';

  @override
  String get callerIdEnhancement => 'שיפור מזהה מתקשר';

  @override
  String get voiceRecognition => 'זיהוי קולי';

  @override
  String get feature => 'תכונה';

  @override
  String get normalUser => 'משתמש רגיל';

  @override
  String get vipUser => 'משתמש VIP';

  @override
  String get temporaryVip => 'VIP זמני';

  @override
  String get removeAds => 'הסרת פרסומות';

  @override
  String get unknownAction => 'פעולה לא ידועה';

  @override
  String get settingsBackup => 'גיבוי הגדרות ';

  @override
  String get allServicesStatusTitle => 'סטטוס שירותים נוכחי';

  @override
  String get allServicesStatusSubtitle => 'סטטוס נוכחי של כל שירותי הענן';

  @override
  String get redirect => 'הפנה';

  @override
  String get notify => 'הודע';

  @override
  String get log => 'יומן';

  @override
  String get custom => 'מותאם אישית';

  @override
  String get allowActionDescription =>
      'שיחות יורשו, גם אם המספר נמצא ברשימת החסימה.';

  @override
  String get blockActionDescription => 'שיחות ייחסמו ויוצגו ביומן השיחות.';

  @override
  String get silenceActionDescription => 'שיחות יושקטו אך יוצגו ביומן השיחות.';

  @override
  String get noneActionDescription => 'לא תתבצע פעולה מיוחדת עבור השיחה.';

  @override
  String get redirectActionDescription => 'הפנה את השיחה למספר שצוין.';

  @override
  String get labelActionDescription => 'הוסף תווית לשיחה לצורך זיהוי קל.';

  @override
  String get notifyActionDescription => 'שלח התראה בעת קבלת שיחה.';

  @override
  String get logActionDescription => 'רשום את פרטי השיחה מבלי לבצע פעולה אחרת.';

  @override
  String get customActionDescription => 'בצע פעולה מותאמת אישית.';

  @override
  String get synced => 'מסונכרן';

  @override
  String get needVipAccess => 'אתה זקוק לגישת VIP כדי להשתמש בתכונה זו';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'ייבוא או ייצוא של נתוני $entityTypeName';
  }

  @override
  String get importExportTitle => 'ייבוא/ייצוא';

  @override
  String get noPhoneRules => 'לא נמצאו כללי טלפון';

  @override
  String get noRegexRules => 'לא נמצאו כללי Regex';

  @override
  String get noAllowedBlockedRules => 'לא נמצאו כללים מותרים/חסומים';

  @override
  String get importExport => 'ייבוא/ייצוא';

  @override
  String get filterByAction => 'סנן לפי פעולה';

  @override
  String get upgradeToVip => 'שדרג ל-VIP';

  @override
  String get batteryOptimizationPermission => 'אופטימיזציה של סוללה';

  @override
  String get batteryOptimizationPermissionDescription =>
      'אפשר לאפליקציה לפעול ברקע כדי לספק שירותים כמו זיהוי מתקשר.';

  @override
  String get permissionTitle => 'הרשאות מיוחדות';

  @override
  String get permissionSubtitle => 'נהל הרשאות שכבת-על ואופטימיזציה של סוללה';

  @override
  String get themeSettingsTitle => 'הגדרות ערכת נושא';

  @override
  String get themeSettingsSubtitle => 'בחר את ערכת הנושא המועדפת עליך';

  @override
  String get databaseSyncTitle => 'סנכרון מסד נתונים';

  @override
  String get countrySyncSettingsTitle => 'הגדרות סנכרון מסד נתונים מבוסס מדינה';

  @override
  String get countrySyncSettingsSubtitle => 'בחר מדינות לסנכרון נתונים';

  @override
  String get countryDataDisclaimer =>
      'שימו לב: מסד הנתונים עשוי שלא לכלול נתונים עבור כל המדינות או האזורים הספציפיים.';

  @override
  String get editSubscription => 'ערוך מנוי';

  @override
  String get searchByNameOrPhoneNumber => 'חפש לפי שם או מספר טלפון';

  @override
  String get allowedBlockedRulesInfo =>
      'כללים מותרים/חסומים משמשים להתאמת שיחות למספרי טלפון ספציפיים, בעלי עדיפות הגבוהה ביותר.';

  @override
  String get searchPhoneRulesHint => 'חפש כללי טלפון';

  @override
  String get phoneRulesInfo =>
      'כללי טלפון משמשים להתאמת שיחות למספרי טלפון ספציפיים, בעלי עדיפות נמוכה יותר. חלקם מגיעים ממנויי phoneRule.';

  @override
  String get searchSubscriptionsHint => 'חפש מנויים';

  @override
  String get searchPluginsHint => 'חפש פלאגינים';

  @override
  String get searchLabelsHint => 'חפש תוויות';

  @override
  String get pluginDescription => 'תיאור פלאגין';

  @override
  String get enterPluginDescription => 'הכנס תיאור פלאגין';

  @override
  String get searchRegexRulesHint => 'חפש כללי Regex';

  @override
  String get regexRulesInfo =>
      'כללי Regex משמשים לסינון שיחות על סמך תבניות Regex.';

  @override
  String get searchMarkedPhonesHint => 'חפש טלפונים מסומנים';

  @override
  String get searchContactSubscriptionsHint => 'חפש מנויי קשר';

  @override
  String get showAllContacts => 'הצג את כל אנשי הקשר';

  @override
  String get showFavorites => 'הצג מועדפים';

  @override
  String get manualEntry => 'מידע על כניסה ידנית';

  @override
  String get scriptSaved => 'סקריפט נשמר';

  @override
  String editScriptFor(String pluginName) {
    return 'ערוך סקריפט עבור $pluginName';
  }

  @override
  String get saveScript => 'שמור סקריפט';

  @override
  String get testPlugin => 'בדוק פלאגין';

  @override
  String get description => 'תיאור';

  @override
  String get accessTargetUrl => 'גישה לכתובת URL יעד';

  @override
  String get result => 'תוצאה';

  @override
  String get editScript => 'ערוך סקריפט';

  @override
  String get numberFormat => 'פורמט מספר';

  @override
  String get nationalNumber => 'מספר לאומי';

  @override
  String get e164Number => 'מספר E164';

  @override
  String get pluginRulesInfo =>
      'למען אבטחה, השתמש רק בפלאגינים ממקורות מהימנים. אל תהסס להשתמש בתבניות שלנו ליצירת פלאגינים מותאמים אישית משלך!';

  @override
  String get advancedMode => 'מצב מתקדם';

  @override
  String get pleaseEnterAtLeastOneNumber => 'אנא הכנס לפחות מספר אחד.';

  @override
  String get openInWebView => 'פתח ב-WebView';

  @override
  String get pluginLabel => 'תווית פלאגין';

  @override
  String get pluginID => 'מזהה';

  @override
  String get pluginURL => 'כתובת URL';

  @override
  String get messageBackgroundColor => 'צבע רקע הודעה';

  @override
  String get clearAllCallLogs => 'נקה את כל יומני השיחות';

  @override
  String get clearAllCallLogsConfirmation => 'אשר לנקות את כל יומני השיחות';

  @override
  String get allCallLogsCleared => 'כל יומני השיחות נוקו';

  @override
  String get unblocked => 'בוטל חסימה';

  @override
  String get blockNumber => 'חסום מספר';

  @override
  String get blockNumberSuccess => 'חסימת מספר הצליחה';

  @override
  String get blockNumberFailed => 'חסימת מספר נכשלה';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'האם אתה בטוח שברצונך לבטל חסימה של $phoneNumber?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'מתקשר אל $phoneNumber...';
  }

  @override
  String get viewDetails => 'הצג פרטים';

  @override
  String get unblock => 'בטל חסימה';

  @override
  String get unblockNumber => 'בטל חסימה של מספר';

  @override
  String get unblockNumberSuccess => 'המספר בוטל חסימה בהצלחה';

  @override
  String get unblockNumberFailed => 'ביטול חסימת מספר נכשל';

  @override
  String get serviceNotAvailable => 'השירות אינו זמין';

  @override
  String get callingNumberFailed => 'שיחת מספר נכשלה';

  @override
  String get listView => 'תצוגת רשימה';

  @override
  String get timelineView => 'תצוגת ציר זמן';

  @override
  String get nameCannotBeEmpty => 'שם לא יכול להיות ריק';

  @override
  String get selectAction => 'בחר פעולה';

  @override
  String get selectTargetService => 'בחר את שירות היעד';

  @override
  String get callDetails => 'פרטי שיחה';

  @override
  String get callType => 'סוג שיחה';

  @override
  String get callTime => 'זמן שיחה';

  @override
  String get numberInvalidFormat => 'פורמט מספר לא תקין';

  @override
  String get membershipFeature => 'תכונת חברות';

  @override
  String get medium => 'בינוני';

  @override
  String get finalRisk => 'סיכון סופי';

  @override
  String get simState => 'מצב SIM';

  @override
  String get ipCountry => 'מדינת IP';

  @override
  String get simCountry => 'מדינת SIM';

  @override
  String get isRoaming => 'בנדידה';

  @override
  String get isNumberMatch => 'התאמת מספר';

  @override
  String get support => 'תמיכה';

  @override
  String get rewardedAdService => 'שירות מודעות מתגמלות';

  @override
  String get hasVipPrivilegeExceptAds => 'כבר יש לך הרשאות VIP (למעט מודעות)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'כבר יש לך הרשאות זמניות, תאריך תפוגה: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'עליך לצפות בעוד $count מודעות כדי לקבל הרשאות VIP זמניות';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'הוענקו לך $days ימי הרשאות רכישה זמניות. תאריך תפוגה: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'זכות הרכישה הזמנית פגה תוקף';

  @override
  String get loadingAd => 'טוען מודעה...';

  @override
  String get earnedTempVip => 'זכית ב-VIP זמני';

  @override
  String get vipExchangeService => 'שירות החלפת VIP';

  @override
  String get marksInsufficient => 'סימנים לא מספיקים להחלפה';

  @override
  String get invalidExchangeRule => 'כלל החלפה לא תקין';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'הוחלף בהצלחה עבור $description, תאריך תפוגה: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'החלפה נכשלה: $error';
  }

  @override
  String get vip3DaysWithAds => 'VIP של 3 ימים עם מודעות (סנכרון בלבד)';

  @override
  String get vip5DaysNoAds => 'VIP של 5 ימים ללא מודעות ועם כל התכונות';

  @override
  String get vip7DaysNoAds => 'VIP של 7 ימים ללא מודעות ועם כל התכונות';

  @override
  String get noNotifications => 'אין התראות';

  @override
  String get clearAllNotifications => 'נקה את כל ההתראות';

  @override
  String get clearAllNotificationsConfirmation => 'אשר לנקות את כל ההתראות';

  @override
  String get allNotificationsCleared => 'כל ההתראות נוקו';

  @override
  String get clearButton => 'נקה';

  @override
  String get justNow => 'הרגע';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'לפני $count דקות',
      one: 'לפני דקה אחת',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'לפני $count שעות',
      one: 'לפני שעה אחת',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'לפני $count ימים',
      one: 'לפני יום אחד',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'אתמול';

  @override
  String get deletionProposal => 'הצעת מחיקה';

  @override
  String get createProposal => 'צור הצעת מחיקה';

  @override
  String get createProposalTitle => 'צור הצעת מחיקה';

  @override
  String get reason => 'סיבה';

  @override
  String get reasonOutdated => 'מספר מיושן';

  @override
  String get reasonPrivacy => 'חשש לפרטיות';

  @override
  String get reasonNotInService => 'לא בשירות';

  @override
  String get reasonWronglyIdentified => 'זוהה בטעות';

  @override
  String get reasonInaccurateInfo => 'מידע שגוי';

  @override
  String get reasonWrongMarked => 'סומן בטעות';

  @override
  String get reasonOther => 'אחר';

  @override
  String get submit => 'שלח';

  @override
  String get cancel => 'בטל';

  @override
  String get proposalStatus => 'סטטוס';

  @override
  String get statusPending => 'ממתין';

  @override
  String get statusActive => 'פעיל';

  @override
  String get statusCompleted => 'הושלם';

  @override
  String get statusExpired => 'פג תוקף';

  @override
  String get riskLevel => 'רמת סיכון';

  @override
  String get riskLevelVerified => 'מאומת';

  @override
  String get riskLevelLow => 'נמוך';

  @override
  String get riskLevelHigh => 'גבוה';

  @override
  String get riskLevelUnknown => 'לא ידוע';

  @override
  String get votingProgress => 'התקדמות הצבעה';

  @override
  String agreeVotes(int count) {
    return 'הסכמה: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'אי-הסכמה: $count';
  }

  @override
  String totalVotes(int count) {
    return 'סה\"כ: $count';
  }

  @override
  String get voteAgree => 'הסכמה';

  @override
  String get voteDisagree => 'אי-הסכמה';

  @override
  String createdAt(String date) {
    return 'נוצר: $date';
  }

  @override
  String get verificationReport => 'דוח אימות';

  @override
  String get showReport => 'הצג דוח';

  @override
  String get hideReport => 'הסתר דוח';

  @override
  String get proposalStatistics => 'סטטיסטיקות הצעה';

  @override
  String get totalProposals => 'סה\"כ הצעות';

  @override
  String get activeProposals => 'הצעות פעילות';

  @override
  String get completedProposals => 'הצעות שהושלמו';

  @override
  String get myVotes => 'הצבעות שלי';

  @override
  String get proposalCreated => 'הצעת מחיקה נוצרה בהצלחה';

  @override
  String get proposalCreateFailed => 'יצירת הצעת מחיקה נכשלה';

  @override
  String get voteSubmitted => 'הצבעה הוגשה בהצלחה';

  @override
  String get voteSubmitFailed => 'הגשת הצבעה נכשלה';

  @override
  String get noProposalsFound => 'לא נמצאו הצעות';

  @override
  String get loadingProposals => 'טוען הצעות...';

  @override
  String get refreshProposals => 'רענן הצעות';

  @override
  String get totalPendingProposals => 'סה\"כ הצעות ממתינות';

  @override
  String get highRisk => 'סיכון גבוה';

  @override
  String get mediumRisk => 'סיכון בינוני';

  @override
  String get lowRisk => 'סיכון נמוך';

  @override
  String get communityImpact => 'השפעה קהילתית';

  @override
  String get criticalIssues => 'בעיות קריטיות';

  @override
  String get communityParticipation => 'השתתפות קהילתית';

  @override
  String get noActivity => 'אין פעילות';

  @override
  String get low => 'נמוך';

  @override
  String get moderate => 'בינוני';

  @override
  String get high => 'גבוה';

  @override
  String get veryHigh => 'גבוה מאוד';

  @override
  String get voted => 'הצבעתי';

  @override
  String get communityVotes => 'הצבעות קהילה';

  @override
  String get waitingForMoreVotes => 'ממתין ליותר הצבעות קהילה';

  @override
  String get proposalProcessed => 'הצעה זו עובדה';

  @override
  String get supported => 'נתמך';

  @override
  String get opposed => 'התנגד';

  @override
  String get approved => 'אושר';

  @override
  String get rejected => 'נדחה';

  @override
  String get completed => 'הושלם';

  @override
  String get pending => 'ממתין';

  @override
  String get critical => 'קריטי';

  @override
  String get oppose => 'התנגד';

  @override
  String get veryLow => 'נמוך מאוד';

  @override
  String get deletionProposals => 'הצעות מחיקה';

  @override
  String get deletionProposalNotificationDescription =>
      'התראות על תוצאות ועדכונים של הצבעות להצעות מחיקה.';

  @override
  String get deletionProposalCreated => 'הצעת מחיקה נוצרה';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'הצעת המחיקה שלך למספר $phoneNumber הוגשה לבדיקת הקהילה.';
  }

  @override
  String get proposalApproved => 'הצעה אושרה ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'הצעת המחיקה למספר $phoneNumber אושרה על ידי הקהילה ($supportPercentage% תמיכה, $totalVotes הצבעות).';
  }

  @override
  String get proposalRejected => 'הצעה נדחתה ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'הצעת המחיקה למספר $phoneNumber נדחתה על ידי הקהילה ($supportPercentage% תמיכה, $totalVotes הצבעות).';
  }

  @override
  String get communityVotingStarted => 'הצבעת הקהילה החלה';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'הצעת מחיקה חדשה למספר $phoneNumber פתוחה כעת להצבעת הקהילה.';
  }

  @override
  String get votingCompleted => 'ההצבעה הסתיימה';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'הצבעת הקהילה עבור $phoneNumber הסתיימה. תוצאה: $result ($supportPercentage% תמיכה).';
  }

  @override
  String get newVoteReceived => 'התקבלה הצבעה חדשה';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'מישהו הצביע ל$voteType את מחיקת המספר $phoneNumber. הצבעות נוכחיות: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'טעינת מספר ההצבעות נכשלה';

  @override
  String get voteCount => 'מספר הצבעות';

  @override
  String get deletionProposalInfo => 'מידע על הצעת מחיקה';

  @override
  String get deletionProposalDescription =>
      'הצע למספרים למחיקה המפרים את כללי הקהילה. השתתפותך עוזרת לשמור על הפלטפורמה בטוחה.';

  @override
  String get voteToEarnVip => 'הצבע על הצעות כדי להרוויח הרשאות VIP!';

  @override
  String get voteFailed => 'הצבעה נכשלה';

  @override
  String get searchProposals => 'חפש הצעות';

  @override
  String get defaultNotifications => 'התראות ברירת מחדל';

  @override
  String get defaultNotificationsDescription =>
      'ערוץ ההתראות ברירת המחדל לאפליקציה.';

  @override
  String get blockedCallNotifications => 'התראות שיחות חסומות';

  @override
  String get blockedCallNotificationsDescription =>
      'מציג מידע על שיחות חסומות.';

  @override
  String get stirVerification => 'אימות STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'מציג תוצאות אימות STIR/SHAKEN עבור מספרים.';

  @override
  String get fraudAlerts => 'התראות הונאה';

  @override
  String get fraudAlertsDescription =>
      'מציג אזהרות עבור שיחות פוטנציאליות של הונאה.';

  @override
  String get notificationFrequencyDescription =>
      'בחר באיזו תדירות תקבל הודעות על הצעות מחיקה חדשות. תוכל לקבל אותן באופן מיידי, באצוות, או במרווח מותאם אישית.';

  @override
  String get notificationMode => 'מצב התראה';

  @override
  String get immediateNotifications => 'מיידי';

  @override
  String get immediateNotificationsDescription =>
      'קבל הודעה מיד עם יצירת הצעה.';

  @override
  String get batchNotifications => 'באצוות';

  @override
  String get batchNotificationsDescription =>
      'קבל סיכום של התראות באופן תקופתי.';

  @override
  String get customNotifications => 'מותאם אישית';

  @override
  String get customNotificationsDescription => 'הגדר מרווח משלך לקבלת התראות.';

  @override
  String get customFrequency => 'תדירות מותאמת אישית';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes דקות';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours שעות';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours שעות $minutes דקות';
  }

  @override
  String get pendingProposals => 'הצעות ממתינות';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count הצעות ממתינות',
      one: 'הצעה ממתינה אחת',
      zero: 'אין הצעות ממתינות',
    );
    return 'יש לך $_temp0.';
  }

  @override
  String get guidelinesLabel => 'הנחיות';

  @override
  String get riskLevelLabel => 'רמת סיכון';

  @override
  String get riskLevelDescription => 'רמת הסיכון של המספר';

  @override
  String get phoneNumberMinDigits => 'מספר הטלפון חייב להיות לפחות 7 ספרות';

  @override
  String get provideDetailedExplanation => 'ספק הסבר מפורט (מינימום 10 תווים)';

  @override
  String get reasonMinCharacters => 'הסיבה חייבת להיות לפחות 10 תווים';

  @override
  String get countryCodeTwoLetters => 'קידומת מדינה (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'קידומת מדינה (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'לדוגמה, US, CN, GB';

  @override
  String get countryCodeRequired => 'קידומת מדינה נדרשת';

  @override
  String get countryCodeLengthError => 'קידומת מדינה חייבת להיות 2 אותיות';

  @override
  String get phoneNumberHint => 'הזן מספר טלפון';

  @override
  String get phoneNumberRequired => 'מספר טלפון נדרש';

  @override
  String get phoneNumberLengthError => 'מספר הטלפון חייב להיות לפחות 7 ספרות';

  @override
  String get reasonHint => 'ספק הסבר מפורט (מינימום 10 תווים)';

  @override
  String get reasonRequired => 'סיבה נדרשת';

  @override
  String get reasonLengthError => 'הסיבה חייבת להיות לפחות 10 תווים';

  @override
  String get guidelinesTitle => 'הנחיות';

  @override
  String get guidelinesText =>
      '• דווח רק על מספרים שהם באמת בעייתיים\n• ספק סיבות מדויקות ומפורטות\n• בחר רמת סיכון מתאימה בהתאם לחומרה\n• דיווחים שקריים עלולים לגרום להגבלות על החשבון';

  @override
  String get riskLevelCritical => 'קריטי';

  @override
  String get riskLevelMedium => 'בינוני';

  @override
  String get riskLevelVeryLow => 'נמוך מאוד';

  @override
  String get riskDescriptionVeryLow => 'נמוך מאוד - מטרד קל, שיחות נדירות';

  @override
  String get riskDescriptionLow => 'נמוך - שיחות לא רצויות מדי פעם';

  @override
  String get riskDescriptionMedium => 'בינוני - ספאם קבוע או טלמרקטינג';

  @override
  String get riskDescriptionHigh => 'גבוה - הטרדה מתמדת או ניסיונות הונאה';

  @override
  String get riskDescriptionCritical => 'קריטי - הונאות או איומים מסוכנים';

  @override
  String get notificationFrequencyTitle => 'תדירות התראות';

  @override
  String get notificationFrequencyLabel => 'תדירות התראות (שעות)';

  @override
  String errorMessage(String error) {
    return 'שגיאה: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'הצבעות: $totalVotes ($supportPercentage% תמיכה)';
  }

  @override
  String get timeJustNow => 'זה עתה';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes דקות לפני';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours שעות לפני';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days ימים לפני';
  }

  @override
  String get reportingGuidelines =>
      '• דווח רק על מספרים שהם באמת בעייתיים\n• ספק סיבות מדויקות ומפורטות\n• בחר רמת סיכון מתאימה בהתאם לחומרה\n• דיווחים שקריים עלולים לגרום להגבלות על החשבון';

  @override
  String get notificationFrequencyHours => 'תדירות התראות (שעות)';

  @override
  String supportCount(int supportCount) {
    return 'תמיכה ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'התנגדות ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes הצבעות ($supportPercentage% תמיכה)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count שעות',
      one: 'שעה אחת',
      zero: '0 שעות',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'הודעה חשובה';

  @override
  String get dataSourceDisclaimer =>
      'מספרים נלקחים מהאינטרנט ומדיווחים של משתמשים. איננו יכולים להבטיח שמספר, לאחר שנמחק, לא יוגש מחדש על ידי משתמשים או מקורות אחרים. אנא חפש ואמת מידע באופן פעיל.';

  @override
  String get avatar => 'תמונת פרופיל';

  @override
  String get location => 'מיקום';

  @override
  String get simCardTitle => 'כרטיס SIM';

  @override
  String get liveActivitiesSettingsTitle => 'הגדרות פעילויות חיות';

  @override
  String get elementsSettingsTitle => 'הגדרות אלמנטים';

  @override
  String get liveActivityMode => 'פעילות חיה';

  @override
  String get liveActivityModeDescription =>
      'מציג מידע על שיחות כהתראה מתמשכת על מסך הנעילה וב-Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'סוג מספר טלפון';

  @override
  String get liveActivitiesTestEndActivity => 'סיים פעילות';

  @override
  String get liveActivitiesTestSendNewActivity => 'שלח פעילות חדשה';

  @override
  String get liveActivitiesTestUpdateActivity => 'עדכן פעילות';

  @override
  String get liveActivityControlsTitle => 'בקרות פעילות חיה';

  @override
  String get liveActivitiesTestTitle => 'מבחן פעילויות חיות';

  @override
  String get liveActivitiesTestSubtitle => 'בדוק את התראת הפעילות החיה.';

  @override
  String get liveNotificationCustomizationTitle => 'התאמה אישית של התראות חיות';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'התאם אישית את מראה ההתראות החיות.';

  @override
  String get notification_instructions =>
      'הוראות:\n1. לחץ על \"שלח\" ליצירה או עדכון של התראה.\n2. עבור למסך הבית שלך או משוך מטה את מגירת ההתראות כדי לראות את התוצאה.\n3. לחץ על \"סיים\" כדי לבטל את ההתראה.';

  @override
  String get autoCancelNotification => 'ביטול אוטומטי של התראה';

  @override
  String get autoCancelNotificationDescription =>
      'אם מסומן, ההתראה תבוטל אוטומטית כאשר המשתמש לוחץ עליה.';

  @override
  String get setDelayTime => 'הגדר זמן השהייה';

  @override
  String get proposalDetails => 'פרטי הצעה';

  @override
  String get filterByStatus => 'סנן לפי סטטוס';

  @override
  String get proposalNotFound => 'הצעה לא נמצאה';

  @override
  String get processed => 'עובד';

  @override
  String get showAll => 'הצג הכל';

  @override
  String get filterAndSortTitle => 'סנן ומיון';

  @override
  String get filterVerifiedOwner => 'סנן בעלים מאומתים';

  @override
  String get filterBy => 'סנן לפי';

  @override
  String get sortOldest => 'מיון מהישן ביותר';

  @override
  String get sortNewest => 'מיון מהחדש ביותר';

  @override
  String get sortMostPopular => 'מיון הפופולרי ביותר';

  @override
  String get sortLeastPopular => 'מיון הכי פחות פופולרי';

  @override
  String get sortBy => 'מיון לפי';

  @override
  String get simRulesNotFound => 'כללי SIM לא נמצאו';

  @override
  String get simSlotRules => 'כללים של חריץ SIM';

  @override
  String get noSimCardDetected => 'לא זוהה כרטיס SIM';

  @override
  String get invalidSimData => 'נתוני SIM לא חוקיים';

  @override
  String get simCardData => 'נתוני כרטיס SIM';

  @override
  String get simSlot => 'חריץ SIM';

  @override
  String get enableFiltering => 'אפשר סינון';

  @override
  String get detailedSettingsTitle => 'הגדרות מפורטות';

  @override
  String get entryPointViewTitle => 'תצוגת נקודת כניסה';

  @override
  String get callTypeRejected => 'נדחה';

  @override
  String get callTypeSilenced => 'הושתק';

  @override
  String get callTypeVoicemail => 'השארת הודעה';

  @override
  String get callTypeUnknownIntercept => 'יירוט לא ידוע';

  @override
  String andMoreItems(int count) {
    return 'ועוד $count פריטים';
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
}
