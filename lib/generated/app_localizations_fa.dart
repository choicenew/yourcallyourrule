// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get aboutContactSubscription => 'درباره اشتراک مخاطبین';

  @override
  String get aboutLabels => 'درباره برچسب‌ها';

  @override
  String get aboutPhoneSubscriptionRules => 'درباره قوانین اشتراک تلفن';

  @override
  String get aboutPhoneSubscriptions => 'درباره اشتراک‌های تلفن';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'قوانین لیست تلفن را از طریق URL مشترک شوید، قوانین را به طور خودکار به‌روز کنید. از فایل‌های قانون در فرمت JSON، CSV پشتیبانی می‌کند.';

  @override
  String get aboutSmsFilter => 'درباره فیلتر پیامک';

  @override
  String get aboutSmsSubscriptionRules => 'درباره قوانین اشتراک پیامک';

  @override
  String get aboutSubtitle => 'اطلاعات نسخه برنامه و حقوقی';

  @override
  String get aboutTitle => 'درباره';

  @override
  String get action => 'اقدام';

  @override
  String get actionAll => 'همه';

  @override
  String get actionAllow => 'مجاز';

  @override
  String get actionBlock => 'مسدود';

  @override
  String get actionFilterAll => 'همه فیلترها';

  @override
  String get actionFilterTitle => 'فیلتر بر اساس نوع اقدام';

  @override
  String get actionFilterTooltip => 'فیلتر اقدام';

  @override
  String get actionNone => 'بدون اقدام';

  @override
  String get actionSilence => 'بی‌صدا';

  @override
  String actionTag(Object actionType) {
    return 'اقدام: $actionType';
  }

  @override
  String get actionType => 'نوع اقدام';

  @override
  String get actionUnknown => 'ناشناخته';

  @override
  String get add => 'افزودن';

  @override
  String get addAllowedBlockedRule => 'افزودن قانون مجاز/مسدود';

  @override
  String get addAllowSubscription => 'افزودن اشتراک مجاز';

  @override
  String get addBlockSubscription => 'افزودن اشتراک مسدود';

  @override
  String get addContactButton => 'افزودن مخاطب';

  @override
  String addContactFailed(Object error) {
    return 'افزودن مخاطب ناموفق بود: $error';
  }

  @override
  String get addedToAllowedRules => 'به قوانین مجاز اضافه شد';

  @override
  String get addedToBlacklist => 'به لیست سیاه اضافه شد';

  @override
  String get addedToBlockedRules => 'به قوانین مسدود اضافه شد';

  @override
  String get addedToFavoriteContacts => 'به مخاطبین مورد علاقه اضافه شد';

  @override
  String get addedToFavorites => 'به مورد علاقه اضافه شد';

  @override
  String get addedToWhitelist => 'به لیست سفید اضافه شد';

  @override
  String get addFavorite => 'افزودن مورد علاقه';

  @override
  String get addFilter => 'افزودن فیلتر';

  @override
  String get addLabel => 'افزودن برچسب';

  @override
  String get addLabelButton => 'افزودن برچسب';

  @override
  String addLabelFailed(Object error) {
    return 'افزودن برچسب ناموفق بود: $error';
  }

  @override
  String get addLabelToCall => 'افزودن برچسب به رکورد تماس';

  @override
  String get addName => 'افزودن نام';

  @override
  String get addNoneSubscription => 'افزودن اشتراک هیچ';

  @override
  String get addOrEditContactInfo =>
      'برای افزودن یا ویرایش اطلاعات مخاطب استفاده می‌شود';

  @override
  String get addPhoneMark => 'افزودن نشانگر تلفن';

  @override
  String get addPhoneNumberRule => 'افزودن قانون شماره تلفن';

  @override
  String get addPlugin => 'افزودن افزونه';

  @override
  String get addPluginFailed => 'افزودن افزونه ناموفق بود';

  @override
  String addPluginFailedWithError(Object error) {
    return 'افزودن افزونه ناموفق بود: $error';
  }

  @override
  String get addPluginFromLocalFile => 'افزودن افزونه از فایل محلی';

  @override
  String get addPluginFromUrl => 'افزودن افزونه از URL';

  @override
  String get addRegexRule => 'افزودن قانون Regex';

  @override
  String get addRule => 'افزودن قانون';

  @override
  String get addRuleButton => 'افزودن قانون';

  @override
  String addRuleFailed(Object error) {
    return 'افزودن قانون ناموفق بود: $error';
  }

  @override
  String get addRuleTooltip => 'افزودن قانون';

  @override
  String get addSilenceSubscription => 'افزودن اشتراک بی‌صدا';

  @override
  String get addSimRuleButton => 'افزودن قانون سیم';

  @override
  String get addSmsFilterRule => 'افزودن قانون فیلتر پیامک';

  @override
  String get addSmsRule => 'افزودن قانون پیامک';

  @override
  String get addSmsSubscription => 'افزودن اشتراک پیامک';

  @override
  String get addSubscription => 'افزودن اشتراک';

  @override
  String get addSubscriptionButton => 'افزودن اشتراک';

  @override
  String addSubscriptionFailed(Object error) {
    return 'افزودن اشتراک ناموفق بود: $error';
  }

  @override
  String get addSubscriptionTooltip => 'افزودن اشتراک';

  @override
  String get addToAllowedRules => 'افزودن به قوانین مجاز';

  @override
  String get addToBlacklist => 'افزودن به لیست سیاه';

  @override
  String get addToBlockedRules => 'افزودن به قوانین مسدود';

  @override
  String get addToFavoriteContacts => 'افزودن به مخاطبین مورد علاقه';

  @override
  String get addToFavorites => 'افزودن به مورد علاقه';

  @override
  String get addToRules => 'افزودن به قوانین';

  @override
  String get addToWhitelist => 'افزودن به لیست سفید';

  @override
  String get adPlaceholder => 'جای خالی تبلیغ';

  @override
  String get agent => 'نماینده';

  @override
  String get all => 'همه';

  @override
  String get allCallsTab => 'همه';

  @override
  String get allDataClearedSuccessfully => 'تمام داده‌ها با موفقیت پاک شد';

  @override
  String get allow => 'مجاز';

  @override
  String get allowAllAllowRules => 'همه قوانین مجاز';

  @override
  String get allowAllAllowRulesDesc => 'تماس‌های قوانین مجاز را مجاز کن';

  @override
  String get allowAllBlacklistedNumbers => 'همه شماره‌های لیست سیاه';

  @override
  String get allowAllBlacklistedNumbersDesc => 'تماس‌های لیست مسدود را مجاز کن';

  @override
  String get allowAllBlockRules => 'همه قوانین مسدود';

  @override
  String get allowAllBlockRulesDesc => 'تماس‌های قوانین مسدود را مجاز کن';

  @override
  String get allowAllowedNumbers => 'شماره‌های مجاز';

  @override
  String get allowAllowedNumbersDesc => 'تماس‌های لیست مجاز را مجاز کن';

  @override
  String get allowBlock => 'مجاز/مسدود';

  @override
  String get allowBlockedNumbers => 'شماره‌های مسدود';

  @override
  String get allowBlockedNumbersDesc => 'تماس‌های لیست مسدود را مجاز کن';

  @override
  String get allowedBlockedRule => 'قانون مجاز/مسدود';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'ویرایش قانون مجاز/مسدود';

  @override
  String get allowedBlockedRuleManagement => 'مدیریت قوانین مجاز/مسدود';

  @override
  String get allowNonExceededNumbers => 'اجازه شماره‌های بیشتر از حد مجاز';

  @override
  String get allowNonExceededNumbersDescription =>
      'به طور خودکار شماره‌هایی که از حد شمارش عبور نمی‌کنند را مجاز کن';

  @override
  String get allowRegexAllowRules => 'قوانین مجاز Regex';

  @override
  String get allowRegexAllowRulesDesc =>
      'تطابق الگوی Regex برای قوانین مجاز را فعال کن';

  @override
  String get allowRegexAllowRulesDescription =>
      'قوانین مجاز مبتنی بر Regex را فعال کن';

  @override
  String get allowRegexBlockRules => 'قوانین مسدود Regex';

  @override
  String get allowRegexBlockRulesDesc =>
      'تطابق الگوی Regex برای قوانین مسدود را فعال کن';

  @override
  String get allowRegexBlockRulesDescription =>
      'قوانین مسدود مبتنی بر Regex را فعال کن';

  @override
  String get allowRule => 'قانون مجاز';

  @override
  String get allowRules => 'قوانین مجاز';

  @override
  String get allowWhitelistedNumbers =>
      'اجازه دادن به شماره‌های موجود در لیست مجاز';

  @override
  String get allowWhitelistedNumbersDescription =>
      'اجازه دادن به تمام شماره‌های موجود در لیست مجاز';

  @override
  String get allPermissionsGranted => 'تمام مجوزها اعطا شد';

  @override
  String get allSettingsCompleted => 'تمام تنظیمات کامل شد.';

  @override
  String allUpdateSuccess(Object count) {
    return 'تمام به‌روزرسانی‌ها کامل شد ($count قانون)';
  }

  @override
  String get answerThenHangup => 'پاسخ و سپس قطع تماس';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. تمامی حقوق محفوظ است.';

  @override
  String get applicationSoftware => 'نرم‌افزار برنامه';

  @override
  String get apply => 'اعمال';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'مجوز ناموفق بود: لطفاً شناسه مشتری و کلید را بررسی کنید';

  @override
  String get authorizationFailedMessage => 'مجوز ناموفق بود';

  @override
  String get authorizationSuccessMessage => 'مجوز موفقیت‌آمیز بود';

  @override
  String get authorizeLoginButton => 'مجوز ورود';

  @override
  String get automotiveIndustry => 'صنعت خودرو';

  @override
  String get autoSyncLabel => 'همگام‌سازی خودکار';

  @override
  String get autoUpdate => 'به‌روزرسانی خودکار';

  @override
  String get autoUpdateDescription =>
      'فاصله‌های زمانی به‌روزرسانی خودکار برای اشتراک‌ها را تنظیم کنید یا به صورت دستی به‌روزرسانی کنید';

  @override
  String get autoUpdateSettings => 'تنظیمات به‌روزرسانی خودکار';

  @override
  String get autoUpdateSettingsSubtitle =>
      'مدیریت به‌روزرسانی‌های خودکار برای قوانین و افزونه‌ها';

  @override
  String get autoUpdateSettingsTitle => 'تنظیمات به‌روزرسانی خودکار';

  @override
  String get autoUpdateSubtitle =>
      'مدیریت به‌روزرسانی‌های خودکار برای قوانین و افزونه‌ها';

  @override
  String get autoUpdateTitle => 'به‌روزرسانی خودکار';

  @override
  String get avatarBorderColor => 'رنگ حاشیه آواتار';

  @override
  String get avatarBorderSize => 'اندازه حاشیه آواتار';

  @override
  String get avatarIconSizesSetting => 'تنظیم اندازه آواتار و آیکون';

  @override
  String get avatarPosition => 'موقعیت آواتار';

  @override
  String get avatarSize => 'اندازه آواتار';

  @override
  String axisPosition(Object axis) {
    return 'موقعیت $axis';
  }

  @override
  String get backgroundGradientSetting => 'گرادیان پس‌زمینه';

  @override
  String get backup => 'پشتیبان‌گیری';

  @override
  String get backupAndRestore => 'پشتیبان‌گیری و بازیابی';

  @override
  String get backupAndRestoreSubtitle =>
      'پشتیبان‌گیری یا بازیابی داده‌های برنامه';

  @override
  String get backupAndRestoreTitle => 'پشتیبان‌گیری و بازیابی';

  @override
  String get backupFailed => 'پشتیبان‌گیری ناموفق بود';

  @override
  String get backupFailedMessage => 'پشتیبان‌گیری ناموفق بود';

  @override
  String backupFailedWithError(Object error) {
    return 'پشتیبان‌گیری ناموفق بود: $error';
  }

  @override
  String get backupRestoreSubtitle => 'پشتیبان‌گیری یا بازیابی داده‌های برنامه';

  @override
  String get backupRestoreTitle => 'پشتیبان‌گیری و بازیابی';

  @override
  String get backupSectionTitle => 'پشتیبان‌گیری';

  @override
  String get backupSettings => 'تنظیمات پشتیبان‌گیری';

  @override
  String get backupSettingsDialogTitle => 'تنظیمات پشتیبان‌گیری';

  @override
  String get backupSettingsTitle => 'تنظیمات پشتیبان‌گیری';

  @override
  String get backupSuccessMessage => 'با موفقیت در فضای ابری پشتیبان‌گیری شد';

  @override
  String backupSuccessToLocal(Object path) {
    return 'پشتیبان‌گیری با موفقیت در: $path';
  }

  @override
  String get backupToCloud => 'پشتیبان‌گیری در فضای ابری';

  @override
  String get backupToCloudDescription =>
      'پشتیبان‌گیری از تنظیمات و قوانین در فضای ذخیره‌سازی ابری';

  @override
  String backupToCloudFailed(Object error) {
    return 'پشتیبان‌گیری در فضای ابری ناموفق بود: $error';
  }

  @override
  String get backupToCloudLabel => 'پشتیبان‌گیری در فضای ابری';

  @override
  String get backupToCloudSuccess => 'با موفقیت در فضای ابری پشتیبان‌گیری شد';

  @override
  String get backupToCloudTitle => 'پشتیبان‌گیری در فضای ابری';

  @override
  String get backupToLocalLabel => 'پشتیبان‌گیری در دستگاه محلی';

  @override
  String get bank => 'بانک';

  @override
  String get basicInfo => 'اطلاعات پایه';

  @override
  String get basicRuleFilter => 'فیلتر قانون پایه';

  @override
  String get basicRuleFiltering => 'فیلتر قانون پایه';

  @override
  String get basicRuleFilteringExplanation =>
      '• فیلتر قانون پایه: فیلتر کردن قوانین بر اساس لیست سیاه، لیست مجاز و regex';

  @override
  String get basicRuleFilterSettings => 'تنظیمات فیلتر قانون پایه';

  @override
  String get basicRuleFilterSubtitle =>
      'فیلتر کردن تماس‌ها با استفاده از لیست سیاه/مجاز و عبارات منظم';

  @override
  String get batchDeleteContacts => 'حذف دسته‌ای مخاطبین';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'آیا مطمئن هستید که می‌خواهید $count مخاطب انتخاب شده را حذف کنید؟';
  }

  @override
  String get batchDeleteFailed => 'حذف دسته‌ای ناموفق بود';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'آیا مطمئن هستید که می‌خواهید $count برچسب را حذف کنید؟';
  }

  @override
  String get blacklist => 'لیست سیاه';

  @override
  String get blacklistingAndWhitelisting => 'لیست سیاه و لیست مجاز';

  @override
  String get blacklistLabel => 'لیست سیاه';

  @override
  String get blackWhiteList => 'لیست سیاه/مجاز';

  @override
  String get block => 'مسدود کردن';

  @override
  String get blockCalls => 'مسدود کردن تماس‌ها';

  @override
  String get blocked => 'مسدود شده';

  @override
  String get blockedCallAction => 'عملکرد تماس مسدود شده';

  @override
  String get blockedCalls => 'تماس‌های مسدود شده';

  @override
  String get blockedCallsTitle => 'تماس‌های مسدود شده';

  @override
  String get blockedCommunications => 'ارتباطات مسدود شده';

  @override
  String get blockedPhoneLabel => 'تماس‌های مسدود شده';

  @override
  String get blockedSpamCalls => 'تماس‌های اسپم مسدود شده';

  @override
  String get blockingTrend => 'روند مسدودسازی';

  @override
  String get blockInternationalCalls =>
      'شماره‌هایی را که با + یا 00 شروع نمی‌شوند، مطابقت می‌دهد';

  @override
  String get blockInternationalCallsTitle => 'مسدود کردن تماس‌های بین‌المللی';

  @override
  String get blockLandlineNumbersTitle => 'مسدود کردن شماره‌های تلفن ثابت';

  @override
  String get blockMobileNumbers =>
      'شماره‌هایی را که با 13-19 شروع نمی‌شوند، مطابقت می‌دهد';

  @override
  String get blockMobileNumbersTitle => 'مسدود کردن شماره‌های تلفن همراه';

  @override
  String get blockPremiumRateNumbers =>
      'شماره‌هایی را که با 118 یا 120-190 شروع نمی‌شوند، مطابقت می‌دهد';

  @override
  String get blockPremiumRateNumbersTitle =>
      'مسدود کردن شماره‌های با تعرفه بالا';

  @override
  String get blockRule => 'قانون مسدودسازی';

  @override
  String get blockRules => 'قوانین مسدودسازی';

  @override
  String get blockSpecificAreaCodes =>
      'شماره‌هایی را که با 0 + 2-3 رقم شروع می‌شوند، مطابقت می‌دهد';

  @override
  String get blockSpecificAreaCodesTitle => 'مسدود کردن کدهای منطقه خاص:';

  @override
  String get blockTypeAnalysisTitle => 'تحلیل نوع مسدودسازی';

  @override
  String get both => 'هر دو';

  @override
  String get bulkDelete => 'حذف دسته‌ای مخاطبین';

  @override
  String get bulkDeleteContacts => 'حذف دسته‌ای مخاطبین';

  @override
  String get bulkDeleteLabels => 'حذف دسته‌ای برچسب‌ها';

  @override
  String get call => 'تماس';

  @override
  String get callback => 'تماس مجدد';

  @override
  String callbackTo(String number) {
    return 'تماس مجدد به $number';
  }

  @override
  String get callBlocking => 'مسدود کردن تماس';

  @override
  String get callerIdApp => 'برنامه شناسه تماس‌گیرنده';

  @override
  String get callerIdCustomizationTitle => 'سفارشی‌سازی شناسه تماس‌گیرنده';

  @override
  String get callerIdDialogTitle => 'اطلاعات شناسه تماس‌گیرنده';

  @override
  String get callerIdDisplayMode => 'حالت نمایش شناسه تماس گیرنده';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'علامت‌گذاری شده توسط $count';
  }

  @override
  String get callerIdPreview => 'پیش‌نمایش شناسه تماس گیرنده';

  @override
  String get callFilter => 'فیلتر تماس';

  @override
  String get callFilterDescription =>
      'هنگامی که فعال باشد، تماس‌های ورودی با لیست قوانین زیر بررسی می‌شوند. قوانین فیلترینگ تماس به طور پیش‌فرض بین دستگاه‌ها همگام‌سازی نمی‌شوند.';

  @override
  String get callFilterRules => 'قوانین فیلتر تماس';

  @override
  String get callFilterRulesDescription =>
      'قوانین اساسی برای فیلترینگ تماس تنظیم کنید';

  @override
  String get callFilterSettings => 'تنظیمات فیلتر تماس';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'محدودیت‌های فرکانس تماس و قوانین مسدودسازی را تنظیم کنید';

  @override
  String get callFrequencyInterceptionTitle => 'رهگیری فرکانس تماس';

  @override
  String get callHistory => 'تاریخچه تماس';

  @override
  String get callHistoryInfoDesc =>
      'تاریخچه تماس شما در اینجا نمایش داده می‌شود، از جمله تماس‌های ورودی، خروجی و از دست رفته.';

  @override
  String get callHistoryInfoTitle => 'تاریخچه تماس';

  @override
  String callHistoryInitFailed(Object error) {
    return 'مقداردهی اولیه تاریخچه تماس ناموفق بود: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'به‌روزرسانی تاریخچه تماس ناموفق بود: $error';
  }

  @override
  String get callHistoryTab => 'تاریخچه تماس';

  @override
  String get callHistoryTimelineEarlier => 'قدیمی‌تر';

  @override
  String get callHistoryTimelineToday => 'امروز';

  @override
  String get callHistoryTimelineYesterday => 'دیروز';

  @override
  String get callScreeningPermission => 'مجوز غربالگری تماس';

  @override
  String get callScreeningPermissionDescription =>
      'برای غربالگری و مسدود کردن تماس‌های اسپم استفاده می‌شود.';

  @override
  String get callScreeningPermissionNotGranted =>
      'مجوز غربالگری تماس اعطا نشده است، ممکن است بر عملکرد برنامه تأثیر بگذارد.';

  @override
  String get callSettingsSubtitle =>
      'تنظیمات شناسه تماس گیرنده، فیلترینگ و مسدودسازی';

  @override
  String get callSettingsTitle => 'تنظیمات تماس';

  @override
  String get callStatistics => 'آمار تماس';

  @override
  String get callTypeAnswered => 'پاسخ داده شده';

  @override
  String get callTypeBlocked => 'مسدود شده';

  @override
  String get callTypeIconColor => 'رنگ آیکون نوع تماس';

  @override
  String get callTypeMissed => 'تماس از دست رفته';

  @override
  String get callTypeOutgoing => 'خروجی';

  @override
  String get callTypePosition => 'موقعیت نوع تماس';

  @override
  String get callTypeUnknown => 'ناشناخته';

  @override
  String get cancelButton => 'لغو';

  @override
  String get carRental => 'اجاره اتومبیل';

  @override
  String get carrier => 'اپراتور';

  @override
  String get carrierColor => 'رنگ اپراتور';

  @override
  String get carrierFontSize => 'اندازه فونت اپراتور';

  @override
  String get carrierPosition => 'موقعیت اپراتور';

  @override
  String get changeLabel => 'تغییر برچسب';

  @override
  String changePluginStatusFailed(Object error) {
    return 'تغییر وضعیت پلاگین ناموفق بود: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'تغییر وضعیت اشتراک ناموفق بود: $error';
  }

  @override
  String get changeTag => 'تغییر برچسب';

  @override
  String get charity => 'خیریه';

  @override
  String chartMonthFormat(int month) {
    return 'ماه $month';
  }

  @override
  String get chartOneDayAgo => '۱ روز پیش';

  @override
  String get chartOneMonthAgo => '۱ ماه پیش';

  @override
  String get chartOneWeekAgo => '۱ هفته پیش';

  @override
  String get chartTenDaysAgo => '۱۰ روز پیش';

  @override
  String get chartThreeDaysAgo => '۳ روز پیش';

  @override
  String get chartToday => 'امروز';

  @override
  String get checkFileFormat => 'لطفاً فرمت فایل یا مجوزها را بررسی کنید';

  @override
  String checkPermissionFailed(Object error) {
    return 'بررسی مجوزها ناموفق بود: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'اقدام پیش‌فرض رهگیری را انتخاب کنید';

  @override
  String get clearAllData => 'حذف همه داده‌ها';

  @override
  String get clearAllDataConfirmation =>
      'آیا مطمئن هستید که می‌خواهید تمام داده‌های برنامه را حذف کنید؟ این عمل قابل برگشت نیست.';

  @override
  String get clearAllDataDescription => 'حذف تمام داده‌های برنامه';

  @override
  String get clearAllDataLabel => 'حذف همه داده‌ها';

  @override
  String get clearFilter => 'پاک کردن فیلتر';

  @override
  String get clearLabelFilter => 'پاک کردن فیلتر برچسب';

  @override
  String get clearLabelFilterButton => 'پاک کردن فیلتر برچسب';

  @override
  String get closeButton => 'بستن';

  @override
  String get cloudSync => 'همگام‌سازی ابری';

  @override
  String get cloudSyncAndBackupTitle => 'همگام‌سازی و پشتیبان‌گیری ابری';

  @override
  String get cloudSyncSettingsSubtitle =>
      'تنظیمات WebDAV، OneDrive و Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'تنظیمات همگام‌سازی ابری';

  @override
  String get cloudSyncTitle => 'همگام‌سازی ابری';

  @override
  String get collapseLabelSelector => 'بستن انتخابگر برچسب';

  @override
  String get collection => 'وصول بدهی';

  @override
  String get colorPickerTitle => 'انتخاب رنگ';

  @override
  String get configManagement => 'مدیریت پیکربندی';

  @override
  String get configUpdated => 'پیکربندی به‌روز شد';

  @override
  String get configurationAdvice =>
      'از طریق پیکربندی مناسب، می‌توانید استراتژی‌های فیلتر متفاوتی را برای سیم‌کارت‌های کاری و شخصی تنظیم کنید.';

  @override
  String get configureBackupOptions => 'تنظیم گزینه‌های پشتیبان‌گیری';

  @override
  String get configureBackupOptionsSubtitle => 'تنظیم گزینه‌های پشتیبان‌گیری';

  @override
  String get configureCloudSyncService => 'پیکربندی سرویس همگام‌سازی ابری';

  @override
  String get configureCloudSyncServiceHint =>
      'لطفاً برای فعال کردن همگام‌سازی بین دستگاه‌ها، سرویس همگام‌سازی ابری را پیکربندی کنید.';

  @override
  String get configureCloudSyncServiceMessage =>
      'لطفاً برای فعال کردن همگام‌سازی بین دستگاه‌ها، سرویس همگام‌سازی ابری را پیکربندی کنید.';

  @override
  String get configureSimCardFilterRules => 'پیکربندی قوانین فیلتر سیم‌کارت';

  @override
  String get configureSyncServiceHint =>
      'لطفاً ابتدا سرویس همگام‌سازی را در تنظیمات همگام‌سازی ابری پیکربندی کنید';

  @override
  String get confirm => 'تأیید';

  @override
  String get confirmBatchDeleteContacts =>
      'آیا مطمئن هستید که می‌خواهید مخاطبین انتخاب شده را حذف کنید؟';

  @override
  String get confirmButton => 'تأیید';

  @override
  String get confirmDelete => 'تأیید حذف';

  @override
  String get confirmDeleteContact => 'آیا مطمئن هستید که می‌خواهید حذف کنید';

  @override
  String get confirmDeleteContactName => 'حذف تأیید شود؟';

  @override
  String get confirmDeleteFilter =>
      'آیا مطمئن هستید که می‌خواهید این فیلتر را حذف کنید؟';

  @override
  String confirmDeleteLabel(Object name) {
    return 'آیا مطمئن هستید که می‌خواهید برچسب \"$name\" را حذف کنید؟';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'آیا مطمئن هستید که می‌خواهید پلاگین \"$name\" را حذف کنید؟';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'آیا مطمئن هستید که می‌خواهید $count پلاگین را حذف کنید؟';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'آیا مطمئن هستید که می‌خواهید این قانون را حذف کنید؟ این عمل قابل برگشت نیست.';

  @override
  String get confirmDeleteSelectedContacts =>
      'آیا مطمئن هستید که مخاطبین انتخاب شده را حذف می‌کنید؟';

  @override
  String get confirmDeleteSmsFilterRule =>
      'آیا مطمئن هستید که می‌خواهید این قانون فیلتر پیامک را حذف کنید؟';

  @override
  String get confirmDeleteSmsRule =>
      'آیا مطمئن هستید که می‌خواهید این قانون پیامک را حذف کنید؟';

  @override
  String get confirmDeleteSubscription =>
      'آیا مطمئن هستید که می‌خواهید این اشتراک را حذف کنید؟';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'آیا مطمئن هستید که می‌خواهید $name را حذف کنید؟';
  }

  @override
  String get confirmPassword => 'تأیید رمز عبور';

  @override
  String get confirmPasswordLabel => 'تأیید رمز عبور';

  @override
  String get connectedStatus => 'متصل';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'اتصال ناموفق بود: لطفاً آدرس سرور، نام کاربری و رمز عبور را بررسی کنید';

  @override
  String get connectionFailedMessage => 'اتصال ناموفق بود';

  @override
  String get connectionStatusLabel => 'وضعیت اتصال';

  @override
  String get connectionSuccessMessage => 'اتصال با موفقیت انجام شد';

  @override
  String get contactAddSuccess => 'مخاطب با موفقیت اضافه شد';

  @override
  String get contactDeleted => 'مخاطب حذف شد';

  @override
  String get contactEditDialog => 'گفتگوی ویرایش مخاطب';

  @override
  String get contactNameHint => 'نام مخاطب را وارد کنید (اختیاری)';

  @override
  String get contactNameLabel => 'نام';

  @override
  String get contactNameOptional => 'نام مخاطب (اختیاری)';

  @override
  String get contactNotFound => 'مخاطب یافت نشد';

  @override
  String get contacts => 'مخاطبین';

  @override
  String contactsDeleted(Object count) {
    return '$count مخاطب حذف شد';
  }

  @override
  String get contactSettingsSubtitle => 'مدیریت مخاطبین و تنظیمات برچسب';

  @override
  String get contactSettingsTitle => 'تنظیمات مخاطبین';

  @override
  String contactsLoadingFailed(Object error) {
    return 'بارگیری مخاطبین با شکست مواجه شد: $error';
  }

  @override
  String get contactsManagement => 'مدیریت مخاطبین';

  @override
  String get contactsManagementPageTitle => 'صفحه مدیریت مخاطبین';

  @override
  String get contactsPageTitle => 'مدیریت مخاطبین';

  @override
  String get contactsPermission => 'مجوز مخاطبین';

  @override
  String get contactsPermissionDescription =>
      'برای شناسایی تماس‌های مخاطبین استفاده می‌شود.';

  @override
  String get contactsTab => 'مخاطبین';

  @override
  String get contactSubscriptionDescription =>
      'لیست مخاطبین را از طریق URL مشترک کنید، اطلاعات و برچسب‌های مخاطب را به طور خودکار به‌روز کنید. از داده‌های فرمت JSON پشتیبانی می‌کند.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'بارگیری اشتراک‌های مخاطب با شکست مواجه شد: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'اشتراک‌های مخاطب';

  @override
  String get contactUpdateSuccess => 'مخاطب با موفقیت به‌روزرسانی شد';

  @override
  String get contactUs => 'با ما تماس بگیرید';

  @override
  String get content => 'محتوا';

  @override
  String get contentRegex => 'عبارت منظم محتوا';

  @override
  String get countColor => 'رنگ تعداد';

  @override
  String get countFontSize => 'اندازه فونت تعداد';

  @override
  String get countPosition => 'موقعیت تعداد';

  @override
  String get country => 'کشور';

  @override
  String get countryNameColor => 'رنگ نام کشور';

  @override
  String get countryNameFontSize => 'اندازه فونت نام کشور';

  @override
  String get countryRegionNamePosition => 'موقعیت نام کشور/منطقه';

  @override
  String get countrySelectionDialog => 'گفتگوی انتخاب کشور';

  @override
  String get countrySelectionDialogDescription =>
      'برای انتخاب کشوری برای پرس و جو اطلاعات شناسه تماس گیرنده استفاده می شود';

  @override
  String get countThresholdDescription =>
      'حداقل حد آستانه تعداد مورد نیاز برای فعال کردن اقدامات فیلترینگ را تنظیم کنید';

  @override
  String get countThresholdLabel => 'آستانه تعداد';

  @override
  String get countThresholdSettings => 'تنظیمات آستانه تعداد';

  @override
  String countThresholdValue(Object count) {
    return 'آستانه تعداد: $count';
  }

  @override
  String get createdRules => 'قوانین ایجاد شده';

  @override
  String get csvFormat => 'فرمت CSV';

  @override
  String get currentDeviceChip => 'فعلی';

  @override
  String get currentDeviceLabel => 'برچسب دستگاه فعلی';

  @override
  String get currentDeviceTitle => 'دستگاه فعلی';

  @override
  String get currentLabels => 'برچسب‌های فعلی:';

  @override
  String get currentLanguage => 'زبان فعلی';

  @override
  String get currentPasswordLabel => 'رمز عبور فعلی';

  @override
  String get customerService => 'خدمات مشتری';

  @override
  String get customRange => 'محدوده سفارشی';

  @override
  String get dailyStatistics => 'آمار روزانه';

  @override
  String get dailyStatisticsDesc =>
      'دریافت آمار روزانه در مورد تماس‌ها و پیام‌های مسدود شده';

  @override
  String get dashboardTab => 'داشبورد';

  @override
  String get dataAnalysis => 'تحلیل داده';

  @override
  String get dataAnalysisDashboardPage => 'صفحه داشبورد تحلیل داده';

  @override
  String get dataExport => 'صادرات داده';

  @override
  String dataLoadFailure(Object error) {
    return 'بارگیری داده با شکست مواجه شد: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'بارگیری داده با شکست مواجه شد: $error';
  }

  @override
  String get dataMigration => 'مهاجرت داده';

  @override
  String get dataMigrationDescription =>
      'این ویژگی به شما امکان می دهد تمام داده های خود را بین دستگاه ها منتقل کنید. در حال حاضر، می توانید از ویژگی های پشتیبان گیری و بازیابی برای انتقال دستی داده های خود استفاده کنید.';

  @override
  String get dataMigrationDialogContent =>
      'این ویژگی به شما امکان می دهد تمام داده های خود را بین دستگاه ها منتقل کنید. در حال حاضر، می توانید از ویژگی های پشتیبان گیری و بازیابی برای انتقال دستی داده های خود استفاده کنید.';

  @override
  String get dataMigrationDialogTitle => 'مهاجرت داده';

  @override
  String get dataMigrationSectionTitle => 'مهاجرت داده';

  @override
  String get dataSourceReminder => 'یادآوری منبع داده';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count روز',
      one: '1 روز',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days روز VIP';
  }

  @override
  String get debtCollection => 'وصول بدهی';

  @override
  String get defaultPeriod => 'هفته';

  @override
  String get delete => 'حذف';

  @override
  String get deleteButton => 'حذف';

  @override
  String get deleteContact => 'حذف مخاطب';

  @override
  String deleteContactConfirm(Object name) {
    return 'آیا مطمئن هستید که می خواهید $name را حذف کنید؟';
  }

  @override
  String get deleteContactConfirmation =>
      'آیا مطمئن هستید که می خواهید مخاطب را حذف کنید؟';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'آیا مطمئن هستید که می خواهید $deviceName را حذف کنید؟';
  }

  @override
  String get deleteDeviceDialogTitle => 'حذف دستگاه';

  @override
  String deleteFailed(Object error) {
    return 'حذف با شکست مواجه شد: $error';
  }

  @override
  String get deleteFilter => 'حذف فیلتر';

  @override
  String get deleteLabel => 'حذف برچسب';

  @override
  String deleteLabelFailed(Object error) {
    return 'حذف برچسب با شکست مواجه شد: $error';
  }

  @override
  String get deletePlugin => 'حذف پلاگین';

  @override
  String deletePluginFailed(Object error) {
    return 'حذف پلاگین با شکست مواجه شد: $error';
  }

  @override
  String get deletePlugins => 'حذف پلاگین‌ها';

  @override
  String deletePluginsFailed(Object error) {
    return 'حذف پلاگین‌ها با شکست مواجه شد: $error';
  }

  @override
  String get deleteRule => 'حذف قانون';

  @override
  String deleteRuleFailed(Object error) {
    return 'حذف با شکست مواجه شد: $error';
  }

  @override
  String get deleteSelected => 'حذف موارد انتخاب شده';

  @override
  String get deleteSmsRule => 'حذف قانون پیامک';

  @override
  String get deleteSubscription => 'حذف اشتراک';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'آیا مطمئن هستید که می خواهید اشتراک \"$name\" را حذف کنید؟';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'حذف اشتراک با شکست مواجه شد: $error';
  }

  @override
  String get deleteSuccess => 'حذف با موفقیت انجام شد';

  @override
  String get delivery => 'تحویل';

  @override
  String get deviceDeletedSuccessfully => 'دستگاه با موفقیت حذف شد';

  @override
  String get deviceDeletedSuccessfullyMessage => 'دستگاه با موفقیت حذف شد';

  @override
  String get deviceIdLabel => 'شناسه دستگاه';

  @override
  String get deviceIDLabel => 'شناسه دستگاه';

  @override
  String get deviceManagementSubtitle =>
      'همگام سازی چندین دستگاه را مدیریت کنید';

  @override
  String get deviceManagementTitle => 'مدیریت دستگاه';

  @override
  String get deviceModelLabel => 'مدل دستگاه';

  @override
  String get deviceName => 'نام دستگاه';

  @override
  String get deviceNameCannotBeEmpty => 'نام دستگاه نمی‌تواند خالی باشد';

  @override
  String get deviceNameHint => 'لطفا نام دستگاه را وارد کنید';

  @override
  String get deviceNameLabel => 'نام دستگاه';

  @override
  String get deviceRenamedSuccessfully => 'دستگاه با موفقیت تغییر نام یافت';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'دستگاه با موفقیت تغییر نام یافت';

  @override
  String get devicesSyncedSuccessfully => 'دستگاه‌ها با موفقیت همگام‌سازی شدند';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'دستگاه‌ها با موفقیت همگام‌سازی شدند';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'دستگاه‌ها با موفقیت همگام‌سازی شدند';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'دستگاه با موفقیت لغو ثبت شد';

  @override
  String get dialogTitle => 'توضیح الگوی Regex';

  @override
  String get differentFromLocalCounter =>
      'این ویژگی با فیلتر شمارنده محلی متفاوت است، زیرا به جای شمارش علامت‌گذاری طولانی مدت، بر الگوهای تماس تکراری در مدت زمان کوتاه تمرکز دارد.';

  @override
  String get disabled => 'غیرفعال';

  @override
  String get disabledStatus => 'غیرفعال';

  @override
  String get disableGlobalPlugins => 'غیرفعال کردن افزونه‌های جهانی';

  @override
  String get disableSubscriptionSuccessfully =>
      'غیرفعال کردن اشتراک با موفقیت انجام شد';

  @override
  String get disconnectButton => 'قطع اتصال';

  @override
  String get disconnectedMessage => 'قطع شد';

  @override
  String get disconnectedStatus => 'قطع شد';

  @override
  String get disconnectFailedMessage => 'قطع اتصال ناموفق بود';

  @override
  String get done => 'انجام شد';

  @override
  String get dualSimAdvice =>
      'این ویژگی به خصوص برای گوشی‌های دو سیم کارت مفید است تا استراتژی‌های فیلترینگ متفاوتی برای سیم کارت‌های کاری و شخصی تنظیم شود.';

  @override
  String get earlier => 'قبلی';

  @override
  String get ecommerce => 'تجارت الکترونیک';

  @override
  String get edit => 'ویرایش';

  @override
  String get editContact => 'ویرایش مخاطب';

  @override
  String get editFilter => 'ویرایش فیلتر';

  @override
  String get editLabel => 'ویرایش برچسب';

  @override
  String get editPhoneRule => 'ویرایش قانون تلفن';

  @override
  String get editPhoneRules => 'برای ویرایش قوانین تلفن استفاده می‌شود';

  @override
  String get editPhoneRuleTitle => 'ویرایش قانون تلفن';

  @override
  String get editRule => 'ویرایش قانون';

  @override
  String get editSmsRule => 'ویرایش قانون پیامک';

  @override
  String get education => 'تحصیلات';

  @override
  String get elementPositionsSetting => 'موقعیت عناصر';

  @override
  String get email => 'ایمیل';

  @override
  String get emailOptional => 'ایمیل (اختیاری)';

  @override
  String get enableCallFilter => 'فعال کردن فیلتر تماس';

  @override
  String get enableCallFilterDescription =>
      'هنگامی که فعال باشد، تماس‌های ورودی با لیست قوانین زیر بررسی می‌شوند. قوانین فیلترینگ تماس به طور پیش‌فرض بین دستگاه‌ها همگام‌سازی نمی‌شوند.';

  @override
  String get enabled => 'فعال';

  @override
  String get enabledStatus => 'فعال';

  @override
  String get enableEncryption => 'فعال کردن رمزگذاری';

  @override
  String get enableEncryptionDescription => 'فایل‌های پشتیبان را رمزگذاری کنید';

  @override
  String get enableEncryptionLabel => 'فعال کردن رمزگذاری';

  @override
  String get enableEncryptionSubtitle => 'فایل‌های پشتیبان رمزگذاری خواهند شد';

  @override
  String get enableEncryptionTitle => 'فعال کردن رمزگذاری';

  @override
  String get enableGlobalPlugins => 'فعال کردن افزونه‌های جهانی';

  @override
  String get enableLocalCountFilter => 'فعال کردن فیلتر شمارش محلی';

  @override
  String get enableLocalCountFilterDescription =>
      'به طور خودکار تماس‌های اسپم را بر اساس شمارش علامت‌گذاری تماس فیلتر کنید';

  @override
  String get enableLocalNotification => 'استفاده از اعلان محلی';

  @override
  String get enableLocalNotificationDescription =>
      'هنگامی که فعال باشد، اعلان‌هایی برای پیام‌های فیلتر شده در دستگاه نمایش داده می‌شود';

  @override
  String get enableLocationSummary => 'مکان';

  @override
  String get enableMuteRules => 'فعال کردن قوانین سکوت';

  @override
  String get enableMuteRulesDesc => 'اعمال پیکربندی قوانین مسدودسازی سکوت';

  @override
  String get enableNoneActionRules => 'فعال کردن قوانین بدون اقدام';

  @override
  String get enableNoneActionRulesDesc =>
      'اجازه پیکربندی قوانین بدون اقدامات مسدودسازی';

  @override
  String get enableNotifications => 'فعال کردن اعلان‌ها';

  @override
  String get enableRemoteNumberFilter => 'فعال کردن فیلتر شماره از راه دور';

  @override
  String get enableRemoteNumberFilterDescription =>
      'استفاده از پایگاه داده از راه دور برای فیلتر کردن شماره‌ها';

  @override
  String get enableRule => 'فعال کردن قانون';

  @override
  String get enableSmsFilter => 'فعال کردن فیلترینگ پیامک';

  @override
  String get enableSmsFilterDescription =>
      'هنگامی که فعال باشد، پیام‌ها به طور خودکار مطابق با قوانین فیلتر می‌شوند';

  @override
  String get enableStatisticsNotifications => 'فعال کردن اعلان‌های آماری';

  @override
  String get enableSubscriptionSuccessfully =>
      'فعال کردن اشتراک با موفقیت انجام شد';

  @override
  String get enableTimeInterception => 'فعال کردن مسدودسازی زمان';

  @override
  String get enableTimeInterceptionDescription =>
      'مسدود کردن تماس‌های تکراری در مدت زمان کوتاه';

  @override
  String get enableTimeInterceptor => 'فعال کردن مسدود کننده زمان';

  @override
  String get endCallImmediately => 'قطع فوری تماس';

  @override
  String get endColor => 'رنگ پایانی';

  @override
  String get endDate => 'تاریخ پایان';

  @override
  String get enhancedFilterInstructionsTitle => 'سیستم فیلتر پیشرفته';

  @override
  String get enhancedFilterSettings => 'تنظیمات فیلتر پیشرفته';

  @override
  String get enhancedFilterSettingsTitle => 'تنظیمات فیلتر پیشرفته';

  @override
  String get enhancedFilterSystemDescription =>
      'سیستم فیلتر پیشرفته از قوانین جهانی و پیکربندی فیلترینگ برای هر سیم کارت پشتیبانی می‌کند.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'لطفاً هم شماره تلفن و هم الگوی regex را وارد کنید';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'لطفاً هم شماره تلفن و هم الگوی regex را وارد کنید.';

  @override
  String get enterContactName => 'لطفاً نام مخاطب را وارد کنید';

  @override
  String get enterCurrentPasswordHint => 'لطفاً رمز عبور فعلی را وارد کنید';

  @override
  String get enterDeviceName => 'نام دستگاه را وارد کنید';

  @override
  String get enterDeviceNameHint => 'لطفاً نام دستگاه را وارد کنید';

  @override
  String get enterEmail => 'لطفاً ایمیل را وارد کنید';

  @override
  String get enterEmailOptional => 'لطفاً ایمیل (اختیاری) را وارد کنید';

  @override
  String get enterEncryptionPasswordHint => 'رمز عبور رمزگذاری را وارد کنید';

  @override
  String get enterEncryptionPasswordTitle => 'رمز عبور رمزگذاری را وارد کنید';

  @override
  String get enterFilterName => 'لطفاً نام فیلتر را وارد کنید';

  @override
  String get enterFilterPattern => 'لطفاً الگوی فیلتر را وارد کنید';

  @override
  String get enterIconCode => 'کد آیکون را وارد کنید';

  @override
  String get enterName => 'نام مخاطب را وارد کنید';

  @override
  String get enterNewDeviceNameHint => 'یک نام جدید برای این دستگاه وارد کنید';

  @override
  String get enterNewPasswordHint => 'لطفاً رمز عبور جدید را وارد کنید';

  @override
  String get enterPasswordAgain => 'رمز عبور را دوباره وارد کنید';

  @override
  String get enterPasswordHint => 'لطفاً رمز عبور را وارد کنید';

  @override
  String get enterPhoneNumber => 'شماره تلفن را وارد کنید';

  @override
  String get enterPhoneNumberHint => 'شماره تلفن برای تست را وارد کنید';

  @override
  String get enterPhoneNumberMultiple =>
      'لطفاً شماره تلفن را وارد کنید، شماره‌های متعدد با کاما جدا شده‌اند';

  @override
  String get enterPhoneNumberToStartSearch =>
      'شماره تلفن را برای شروع جستجو وارد کنید';

  @override
  String get enterPhoneNumberToVerify => 'شماره تلفن را برای تأیید وارد کنید';

  @override
  String get enterPluginName => 'نام افزونه را وارد کنید';

  @override
  String get enterPluginUrl => 'آدرس URL افزونه را وارد کنید';

  @override
  String get enterRegexHint => 'الگوی regex را وارد کنید';

  @override
  String get enterRuleNameAndPattern => 'لطفاً نام و الگوی قانون را وارد کنید';

  @override
  String get enterRuleNameAndPatternMessage =>
      'لطفا نام قانون و الگوی regex را وارد کنید.';

  @override
  String get enterRuleNameHint => 'نام قانون را وارد کنید';

  @override
  String get enterSearchContent => 'لطفاً محتوای جستجو را وارد کنید';

  @override
  String get enterSubscriptionName => 'نام اشتراک را وارد کنید';

  @override
  String get enterSubscriptionUrl => 'آدرس اشتراک را وارد کنید';

  @override
  String get enterSyncFolderNameHint =>
      'لطفاً نام پوشه همگام سازی را وارد کنید (پیش فرض: NotificationManager)';

  @override
  String get entertainment => 'سرگرمی';

  @override
  String get enterValidNameAndUrl => 'لطفاً نام و آدرس معتبر را وارد کنید';

  @override
  String get enterValidUrl => 'لطفاً یک آدرس معتبر وارد کنید';

  @override
  String get enterVersion => 'نسخه را وارد کنید';

  @override
  String get enterWebDAVPasswordHint => 'لطفاً رمز عبور WebDAV را وارد کنید';

  @override
  String get enterWebDAVServerAddressHint =>
      'لطفاً آدرس سرور WebDAV را وارد کنید';

  @override
  String get enterWebDAVUsernameHint => 'لطفاً نام کاربری WebDAV را وارد کنید';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'خطا در حذف دستگاه: $error';
  }

  @override
  String get errorLoadingPlugin => 'خطا در بارگذاری افزونه';

  @override
  String errorOccurredMessage(Object error) {
    return 'خطایی رخ داد: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'خطا در تغییر نام دستگاه: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'خطا در همگام سازی دستگاه ها: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'خطا در همگام سازی دستگاه ها: $error';
  }

  @override
  String get errorText => 'خطا';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'خطا در لغو ثبت دستگاه: $error';
  }

  @override
  String get exampleBlock400Prefix =>
      'به عنوان مثال، مسدود کردن اعداد پیشوند 400';

  @override
  String get exampleBlockMarketingSms =>
      'به عنوان مثال، مسدود کردن پیامک های تبلیغاتی';

  @override
  String get exampleContentRegex => 'به عنوان مثال، .*offer.*';

  @override
  String get exampleContentRegexHint => 'الگوی محتوای نمونه';

  @override
  String get exampleCouponPromotionDiscount =>
      'به عنوان مثال، .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'به عنوان مثال، خانواده، دوستان، و غیره.';

  @override
  String get examplePhoneNumber => 'به عنوان مثال، 10086، 12345، و غیره.';

  @override
  String get exampleRegex400Prefix => 'الگوی نمونه برای پیشوند 400';

  @override
  String get exampleRegexFormat => 'مثال: قالب ^10086\$';

  @override
  String get exampleSenderRegexHint => 'مثال';

  @override
  String get exchange => 'تبادل';

  @override
  String get exchangeNow => 'اکنون تبادل کنید';

  @override
  String get exchangeVip => 'تبادل VIP';

  @override
  String get expandLabelSelector => 'انتخابگر برچسب را باز کنید';

  @override
  String expiryTime(Object time) {
    return 'زمان انقضا: $time';
  }

  @override
  String get export => 'خروجی';

  @override
  String get exportAllApplicationSettings => 'خروجی تمام تنظیمات برنامه';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'خروجی تمام تنظیمات برنامه';

  @override
  String get exportAllRuleConfigurations => 'خروجی تمام تنظیمات قوانین';

  @override
  String get exportAllRuleConfigurationsSubtitle => 'خروجی تمام تنظیمات قوانین';

  @override
  String get exportComplete => 'خروجی کامل شد';

  @override
  String get exportConfig => 'خروجی تنظیمات';

  @override
  String get exportContacts => 'خروجی مخاطبین';

  @override
  String get exportData => 'خروجی داده';

  @override
  String get exportError => 'خطای خروجی';

  @override
  String get exportFailed => 'خروجی ناموفق بود';

  @override
  String get exportFailure => 'خطا در خروجی تنظیمات';

  @override
  String get exportFeatureComingSoon => 'ویژگی خروجی به زودی ارائه می شود';

  @override
  String get exporting => 'در حال خروجی گرفتن...';

  @override
  String get exportLabels => 'خروجی برچسب ها';

  @override
  String exportLabelsFailed(Object error) {
    return 'خطا در خروجی برچسب ها: $error';
  }

  @override
  String get exportPluginList => 'خروجی لیست افزونه ها';

  @override
  String exportPluginListFailed(Object error) {
    return 'خطا در خروجی لیست افزونه ها: $error';
  }

  @override
  String get exportRules => 'خروجی قوانین';

  @override
  String get exportRulesDialogTitle => 'خروجی قوانین';

  @override
  String get exportRulesTitle => 'خروجی قوانین';

  @override
  String get exportSmsRules => 'خروجی قوانین پیامک';

  @override
  String get exportStatisticsData => 'خروجی داده های آماری';

  @override
  String get exportSuccess => 'خروجی موفقیت آمیز بود';

  @override
  String get exportSuccesslly => 'تنظیمات با موفقیت خروجی گرفته شد';

  @override
  String get failedToAddContact => 'خطا در افزودن مخاطب';

  @override
  String failedToAddRule(Object error) {
    return 'خطا در افزودن قانون: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'خطا در افزودن قانون پیامک: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'خطا در افزودن اشتراک پیامک: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'خطا در پشتیبان گیری از تنظیمات: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'خطا در رمزگشایی فایل پشتیبان';

  @override
  String get failedToDeleteDevice => 'خطا در حذف دستگاه';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'خطا در حذف قانون پیامک: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'خطا در خروجی قوانین: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'خطا در خروجی قوانین پیامک: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'خطا در دریافت اطلاعات شناسه تماس گیرنده: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'خطا در وارد کردن قوانین: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'خطا در وارد کردن قوانین پیامک: $error';
  }

  @override
  String get failedToLoadContacts => 'خطا در بارگذاری مخاطبین';

  @override
  String get failedToLoadPlugin => 'خطا در بارگذاری افزونه';

  @override
  String get failedToRenameDevice => 'خطا در تغییر نام دستگاه';

  @override
  String get failedToRestoreSettings => 'خطا در بازیابی تنظیمات';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'خطا در بازیابی تنظیمات: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'خطا در تنظیم رمز عبور: $error';
  }

  @override
  String get failedToSyncDevices => 'خطا در همگام سازی دستگاه ها';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'خطا در تغییر وضعیت قانون: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => 'خطا در تغییر وضعیت اشتراک';

  @override
  String get failedToUpdateContact => 'خطا در به روز رسانی مخاطب';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'خطا در به روز رسانی قانون پیامک: $error';
  }

  @override
  String get failure => 'خطا';

  @override
  String get favoriteContacts => 'مخاطبین مورد علاقه';

  @override
  String get featureAddRules => '• اضافه کردن قوانین خاص شماره تلفن';

  @override
  String get featureCenter => 'مرکز ویژگی ها';

  @override
  String get featureEnableDisable =>
      '• فعال/غیرفعال کردن فیلترهای مختلف برای هر سیم کارت';

  @override
  String get featureListTitle => 'ویژگی ها:';

  @override
  String get featureManageRules => '• مدیریت لیست قوانین برای هر سیم کارت';

  @override
  String get features => 'ویژگی ها';

  @override
  String get fetchingCallerIdInfo =>
      'در حال دریافت اطلاعات شناسه تماس گیرنده...';

  @override
  String fileSavedTo(Object path) {
    return 'فایل در این مسیر ذخیره شد: $path';
  }

  @override
  String get filter => 'فیلتر';

  @override
  String get filterByLabel => 'فیلتر بر اساس برچسب';

  @override
  String get filterClear => 'حذف فیلتر';

  @override
  String get filterControlPanelTitle => 'پنل کنترل فیلتر';

  @override
  String get filterControlSubtitle =>
      'وضعیت روشن/خاموش همه فیلترها را مدیریت کنید';

  @override
  String get filterControlTitle => 'کنترل فیلتر';

  @override
  String get filterDeleteFailed => 'حذف فیلتر ناموفق بود';

  @override
  String get filterDeleteSuccess => 'فیلتر با موفقیت حذف شد';

  @override
  String get filterDetails => 'جزئیات فیلتر';

  @override
  String get filtered => 'فیلتر شده';

  @override
  String get filteredSms => 'پیامک های فیلتر شده';

  @override
  String get filteredSmsLabel => 'پیامک های فیلتر شده';

  @override
  String get filterExplanation => 'توضیح فیلتر';

  @override
  String get filterManagement => 'مدیریت فیلتر';

  @override
  String get filterName => 'نام فیلتر';

  @override
  String get filterPattern => 'الگوی فیلتر';

  @override
  String get filterPriorityNote =>
      'توجه: بین فیلترها روابط اولویت وجود دارد، لطفاً برای جزئیات به مستندات راهنما مراجعه کنید.';

  @override
  String get filterSaveFailed => 'ذخیره فیلتر ناموفق بود';

  @override
  String get filterSaveSuccess => 'فیلتر با موفقیت ذخیره شد';

  @override
  String get filterSettings => 'تنظیمات فیلتر';

  @override
  String get filterSettingsTitle => 'تنظیمات فیلتر';

  @override
  String get filterSMS => 'فیلتر SMS';

  @override
  String get filterToggleInstructions =>
      'فعال یا غیرفعال کردن فیلترها برای این اسلات سیم کارت:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'فیلتر $status: $filterName';
  }

  @override
  String get filterType => 'نوع فیلتر';

  @override
  String get financial => 'مالی';

  @override
  String get flexibleCombinationFeature =>
      '• ترکیبات انعطاف پذیر: فعال/غیرفعال کردن فیلترها بر اساس اسلات سیم کارت';

  @override
  String get fontSizesSetting => 'اندازه فونت ها';

  @override
  String foundRules(Object count) {
    return '$count قانون پیدا شد';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count قانون پیدا شد. آیا می خواهید آنها را وارد کنید؟';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count قانون پیدا شد. آیا می خواهید آنها را وارد کنید؟';
  }

  @override
  String get fraudAlert => 'هشدار کلاهبرداری - تماس را قطع کنید';

  @override
  String get fraudScamLikely => 'کلاهبرداری احتمالی';

  @override
  String get free => 'رایگان';

  @override
  String get functionSettingsTitle => 'تنظیمات عملکرد';

  @override
  String generalUpdateFailure(Object error) {
    return 'به روز رسانی ناموفق بود: $error';
  }

  @override
  String get getFree => 'دریافت رایگان';

  @override
  String get github => 'گیت هاب';

  @override
  String get globalFilterDescription =>
      'فیلترهای سراسری را برای همه سیم کارت ها پیکربندی کنید:';

  @override
  String get globalFilterFeature =>
      '• فیلترهای سراسری: قوانین اساسی برای همه تماس های ورودی';

  @override
  String get globalFilterSettings => 'تنظیمات فیلتر سراسری';

  @override
  String get globalFilterToggleInstructions =>
      'تنظیمات فیلتر سراسری را که برای همه اسلات های سیم کارت اعمال می شود، پیکربندی کنید:';

  @override
  String get globalSearchSubtitle =>
      'جستجوی مخاطبین، برچسب ها، لیست سیاه، لیست سفید و غیره.';

  @override
  String get globalSearchTitle => 'جستجوی سراسری';

  @override
  String get globalSettings => 'تنظیمات سراسری';

  @override
  String get googleAdDisplayPosition => 'موقعیت نمایش تبلیغ گوگل';

  @override
  String get googleAdMobIntegrationText =>
      'تبلیغات Google AdMob را می توان در اینجا ادغام کرد';

  @override
  String get googleDriveAuthDescription =>
      'با استفاده از شناسه مشتری و کلید Google Drive پیکربندی شده توسط سیستم، مجوز دهید';

  @override
  String get googleDriveAuthorizationHint =>
      'با استفاده از شناسه مشتری و کلید Google Drive پیکربندی شده توسط سیستم، مجوز دهید';

  @override
  String get googleDriveConfigTitle => 'پیکربندی Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'پیکربندی Google Drive';

  @override
  String get government => 'دولتی';

  @override
  String get granted => 'اعطا شده';

  @override
  String get grantNecessaryPermissions => 'مجوزهای لازم را اعطا کنید';

  @override
  String get grantPermissions => 'اعطای مجوزها';

  @override
  String get headhunter => 'شکارچی سر';

  @override
  String get height => 'ارتفاع';

  @override
  String get homePageTitle => 'صفحه اصلی';

  @override
  String get homeTab => 'خانه';

  @override
  String get howItWorksPoint1 =>
      '• سیستم به طور خودکار تماس های یکسان را در بازه زمانی تنظیم شده مجاز می کند';

  @override
  String get howItWorksPoint2 =>
      '• پنجره های زمانی کوتاهتر باعث رهگیری دقیق تر می شوند؛ پنجره های زمانی طولانی تر باعث رهگیری شل تر می شوند';

  @override
  String get howItWorksPoint3 =>
      '• سیستم گزارش تماس ها را برای تعیین اینکه آیا یک تماس تکراری است بررسی می کند';

  @override
  String get howItWorksTitle => 'نحوه کار:';

  @override
  String get iconCodeOptional => 'کد آیکون (اختیاری)';

  @override
  String get iconSize => 'اندازه آیکون';

  @override
  String get import => 'وارد کردن';

  @override
  String get important => 'مهم';

  @override
  String get importButton => 'وارد کردن';

  @override
  String get importConfig => 'وارد کردن پیکربندی';

  @override
  String get importContacts => 'وارد کردن مخاطبین';

  @override
  String get importExportContacts => 'وارد کردن/خروجی مخاطبین';

  @override
  String get importExportContactsTooltip => 'وارد کردن/خروجی مخاطبین';

  @override
  String get importExportRules => 'وارد کردن/خروجی قوانین';

  @override
  String importFailed(Object error) {
    return 'وارد کردن ناموفق بود: $error';
  }

  @override
  String get importFailure => 'وارد کردن پیکربندی انجام نشد';

  @override
  String get importFeatureComingSoon => 'قابلیت وارد کردن به زودی ارائه می شود';

  @override
  String get importLabels => 'وارد کردن برچسب ها';

  @override
  String importLabelsFailed(Object error) {
    return 'وارد کردن برچسب ها ناموفق بود: $error';
  }

  @override
  String get importPluginList => 'وارد کردن لیست پلاگین';

  @override
  String importPluginListFailed(Object error) {
    return 'وارد کردن لیست پلاگین ناموفق بود: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'با موفقیت $count پلاگین وارد شد';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'وارد کردن پیکربندی قوانین از فایل';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'وارد کردن پیکربندی قوانین از فایل';

  @override
  String get importRules => 'وارد کردن قوانین';

  @override
  String get importRulesButton => 'وارد کردن قوانین';

  @override
  String get importRulesDialogTitle => 'وارد کردن قوانین';

  @override
  String importRulesError(Object error) {
    return 'وارد کردن قوانین ناموفق بود: $error';
  }

  @override
  String get importRulesInstructions => 'قوانین را از فایل CSV وارد کنید';

  @override
  String get importRulesSuccess => 'قوانین با موفقیت وارد شدند';

  @override
  String get importRulesTitle => 'وارد کردن قوانین';

  @override
  String get importSuccess => 'وارد کردن موفقیت آمیز بود';

  @override
  String get incomingCallInterceptAction => 'اقدام رهگیری تماس ورودی';

  @override
  String get incomingCallNotification => 'اعلان تماس ورودی';

  @override
  String get incorrectPassword => 'رمز عبور اشتباه است';

  @override
  String get initializing => 'درحال مقداردهی اولیه';

  @override
  String get installed => 'نصب شده';

  @override
  String get insufficientMarks => 'نمرات ناکافی';

  @override
  String get insurance => 'بیمه';

  @override
  String get interceptAction => 'اقدام رهگیری';

  @override
  String get interceptionActionSettingsSubtitle =>
      'نحوه مدیریت تماس های مسدود شده را تنظیم کنید';

  @override
  String get interceptionActionSettingsTitle => 'تنظیمات اقدام رهگیری';

  @override
  String get interceptionTimeInterval => 'بازه زمانی رهگیری';

  @override
  String get internet => 'اینترنت';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'بازه زمانی به روز رسانی $service روی $days روز تنظیم شد';
  }

  @override
  String get invalidContentRegex => 'عبارت منظم محتوا نامعتبر است';

  @override
  String get invalidLabel => 'برچسب نامعتبر';

  @override
  String get invalidRegexPattern => 'الگوی regex نامعتبر';

  @override
  String get invalidSenderRegex => 'الگوی regex فرستنده نامعتبر';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'برای اطلاعات بیشتر به کانال و گروه تلگرام بپیوندید';

  @override
  String get jsLogsTitle => 'گزارشات JS';

  @override
  String get jsonFormat => 'قالب JSON';

  @override
  String get keepAllVersions => 'نگه داشتن همه نسخه‌ها';

  @override
  String get keepAllVersionsDescription =>
      'تمام نسخه‌های تاریخی هر پشتیبان را نگه دارید';

  @override
  String get keepAllVersionsLabel => 'نگه داشتن همه نسخه‌ها';

  @override
  String get keepAllVersionsSubtitle =>
      'نسخه‌های تاریخی هر پشتیبان را نگه دارید';

  @override
  String get keepAllVersionsTitle => 'نگه داشتن همه نسخه‌ها';

  @override
  String get label => 'برچسب';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'برچسب \"$name\" با موفقیت اضافه شد';
  }

  @override
  String get labelCategories => 'دسته بندی برچسب‌ها';

  @override
  String get labelDeleted => 'برچسب حذف شد';

  @override
  String get labelDescription =>
      'برچسب‌ها به شما کمک می‌کنند تا مخاطبین را بهتر مدیریت کنید، برچسب‌های سفارشی را به شماره تلفن‌ها اضافه کنید تا تماس‌ها و پیام‌ها به راحتی شناسایی شوند.';

  @override
  String get labelFilter => 'فیلتر برچسب';

  @override
  String get labelFilterTooltip => 'فیلتر برچسب';

  @override
  String get labelIconColor => 'رنگ آیکون برچسب';

  @override
  String get labelManagement => 'مدیریت برچسب';

  @override
  String get labelNotFound => 'برچسب یافت نشد';

  @override
  String get labelRemoved => 'برچسب حذف شد';

  @override
  String labelRemoveFailed(Object error) {
    return 'حذف برچسب ناموفق بود: $error';
  }

  @override
  String get labels => 'برچسب‌ها';

  @override
  String get labelsColor => 'رنگ برچسب‌ها';

  @override
  String labelsDeleted(Object count) {
    return '$count برچسب حذف شد';
  }

  @override
  String get labelsExportedSuccessfully => 'برچسب‌ها با موفقیت صادر شدند';

  @override
  String get labelsFontSize => 'اندازه فونت برچسب‌ها';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count برچسب با موفقیت وارد شد';
  }

  @override
  String get labelsPosition => 'موقعیت برچسب‌ها';

  @override
  String labelTag(Object labelId) {
    return 'برچسب: $labelId';
  }

  @override
  String get labelUpdated => 'برچسب به روز شد';

  @override
  String labelUpdateFailed(Object error) {
    return 'به روز رسانی برچسب ناموفق بود: $error';
  }

  @override
  String get labelUpdateSuccess => 'برچسب \"\$labelText\" با موفقیت به روز شد';

  @override
  String get languageSettings => 'تنظیمات زبان';

  @override
  String get languageSettingsSubtitle => 'تغییر زبان نمایش برنامه';

  @override
  String get languageSettingsTitle => 'تنظیمات زبان';

  @override
  String get last30Days => '30 روز گذشته';

  @override
  String get last7Days => '7 روز گذشته';

  @override
  String get lastSyncLabel => 'آخرین همگام سازی';

  @override
  String lastUpdated(Object date) {
    return 'آخرین به روز رسانی: $date';
  }

  @override
  String get lifetimeMembership => 'عضویت مادام العمر';

  @override
  String get lifetimeMembershipDescription =>
      'خرید یک بار، تمام ویژگی‌های ممتاز و به‌روزرسانی‌های آینده را به طور دائم باز کنید';

  @override
  String loadContactsFailed(Object error) {
    return 'بارگذاری مخاطبین ناموفق بود: $error';
  }

  @override
  String get loadDataFailed => 'بارگذاری داده ناموفق بود';

  @override
  String get loadFailed => 'بارگذاری ناموفق';

  @override
  String get loading => 'در حال بارگذاری...';

  @override
  String get loadingData => 'در حال بارگذاری داده‌ها...';

  @override
  String get loadingTags => 'در حال بارگذاری تگ‌ها...';

  @override
  String loadLabelFailed(Object error) {
    return 'بارگذاری برچسب‌ها ناموفق بود: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'بارگذاری برچسب‌ها ناموفق بود: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'بارگذاری شماره تلفن‌های علامت‌گذاری شده ناموفق بود: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'بارگذاری تلفن‌های علامت‌گذاری شده ناموفق بود: $error';
  }

  @override
  String get loadMore => 'بیشتر بارگیری کنید';

  @override
  String get loadPluginButton => 'بارگیری پلاگین';

  @override
  String loadPluginsFailed(Object error) {
    return 'بارگذاری پلاگین‌ها ناموفق بود: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'بارگذاری تنظیمات ناموفق بود: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'بارگذاری قوانین پیامک ناموفق بود: $error';
  }

  @override
  String get loadStatusFailedMessage => 'بارگذاری وضعیت ناموفق بود';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'بارگذاری اشتراک‌ها ناموفق بود: $error';
  }

  @override
  String get loan => 'قرض';

  @override
  String get localBackupTitle => 'پشتیبان گیری محلی';

  @override
  String get localCounterFilter => 'فیلتر شمارنده محلی';

  @override
  String get localCounterFilterSubtitle =>
      'به طور خودکار تماس‌های اسپم را بر اساس فرکانس تماس فیلتر کنید';

  @override
  String get localCountFilter => 'فیلتر تعداد محلی';

  @override
  String get localCountFilterDescription =>
      'اعتراض به تماس‌های مکرر بر اساس تعداد اعداد محلی';

  @override
  String get localCountFilterExplanationContent =>
      'فیلتر تعداد محلی، سوابق تاریخچه تماس را تجزیه و تحلیل می‌کند تا به طور خودکار تماس‌های اسپم مکرر را شناسایی و مسدود کند.';

  @override
  String get localCountFilterExplanationTitle => 'توضیح فیلتر تعداد محلی';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• تعیین اینکه آیا بر اساس مقدار تعداد شماره مسدود شود';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• هنگامی که تعداد یک شماره از حد تعیین شده فراتر رفت، می‌توانید آن را به طور خودکار مسدود کنید';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• می‌توانید اعداد را که از حد فراتر نمی‌روند به طور انتخابی مجاز کنید';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• می‌توانید انتخاب کنید که آیا تمام گزارش‌های پرس و جو را ثبت کنید';

  @override
  String get localCountFiltering => 'فیلتر تعداد محلی';

  @override
  String get localCountFilteringExplanation =>
      '• فیلتر تعداد محلی: قوانین فیلتر بر اساس تعداد علامت‌گذاری محلی';

  @override
  String get localCountFilterSettings => 'تنظیمات فیلتر تعداد محلی';

  @override
  String get localCountFilterUseCases =>
      'این فیلتر به ویژه برای شناسایی تماس‌های اسپم خودکار و تماس‌های بازاریابی مناسب است.';

  @override
  String get localFilterSettings => 'تنظیمات فیلتر محلی';

  @override
  String get localNotificationDisabled => 'اعلان محلی غیرفعال شد';

  @override
  String get localNotificationEnabled => 'اعلان محلی فعال شد';

  @override
  String get localServices => 'خدمات محلی';

  @override
  String get locationColor => 'رنگ مکان';

  @override
  String get locationFontSize => 'اندازه فونت مکان';

  @override
  String get locationIconColor => 'رنگ آیکون مکان';

  @override
  String get locationPosition => 'موقعیت مکان';

  @override
  String get logAllLocalQueries => 'ثبت تمام پرس و جوهای محلی';

  @override
  String get logAllLocalQueriesDescription =>
      'ثبت ورود برای تمام پرس و جوهای شماره محلی';

  @override
  String get logAllRemoteQueries => 'ثبت تمام پرس و جوهای راه دور';

  @override
  String get logAllRemoteQueriesDescription =>
      'تمام عملیات پرس و جوی شماره راه دور را ثبت کنید';

  @override
  String get manage => 'مدیریت مخاطبین';

  @override
  String get manageContacts => 'مدیریت';

  @override
  String get manageFavoriteContacts => 'مدیریت مخاطبین مورد علاقه';

  @override
  String get manageFilterRules => 'مدیریت قوانین فیلتر';

  @override
  String get manageFilterRulesDescription =>
      'اضافه کردن، ویرایش یا حذف قوانین فیلتر پیامک';

  @override
  String get manageFrequentContacts => 'مدیریت مخاطبین پرتکرار';

  @override
  String get markCounts => 'شمارش علامت‌گذاری';

  @override
  String get markCount => 'شمارش علامت‌گذاری';

  @override
  String markedByCount(Object count) {
    return 'علامت‌گذاری شده توسط $count';
  }

  @override
  String get markedPhonesList => 'لیست شماره تلفن‌های علامت‌گذاری شده';

  @override
  String get markExchange => 'تبادل علامت‌گذاری';

  @override
  String get markPhone => 'علامت‌گذاری شماره تلفن';

  @override
  String markPhoneFailed(Object error) {
    return 'شماره تلفن با شکست علامت گذاری شد: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'برای علامت گذاری شماره تلفن ها';

  @override
  String get markPhoneManagementTitle => 'مدیریت شماره های علامت گذاری شده';

  @override
  String get markPhoneSuccess => 'شماره تلفن با موفقیت علامت گذاری شد';

  @override
  String get matchFailed => 'تطابق ناموفق بود!';

  @override
  String get matchFailedMessage => 'تطابق ناموفق بود.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'با فرمت خاص شماره مطابقت دارد';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'تطابق اعداد با کاراکترهای ویژه:';

  @override
  String get matchSpecificDigitPatterns => 'با فرمت XXX-XXXX-XXXX مطابقت دارد';

  @override
  String get matchSpecificDigitPatternsTitle => 'تطابق الگوهای رقم خاص:';

  @override
  String get matchSuccessful => 'تطابق موفقیت آمیز بود!';

  @override
  String get matchSuccessfulMessage => 'تطابق موفقیت آمیز بود!';

  @override
  String get medical => 'پزشکی';

  @override
  String get membershipPrivileges => 'مزایای عضویت';

  @override
  String get migrationTool => 'ابزار مهاجرت';

  @override
  String get migrationToolTitle => 'ابزار مهاجرت';

  @override
  String get minutes => 'دقیقه';

  @override
  String get month => 'ماه';

  @override
  String get monthly => 'ماهانه';

  @override
  String get monthlyCallCount => 'تعداد تماس های ماهانه';

  @override
  String get monthlyChartTitle => 'تماس های مسدود شده ماهانه';

  @override
  String get monthlyMembership => 'عضویت ماهانه';

  @override
  String get monthlyMembershipDescription =>
      'باز کردن تمام ویژگی های ممتاز، تمدید خودکار ماهانه';

  @override
  String get monthlyTotal => 'مجموع ماهانه';

  @override
  String get monthlyTotalLabel => 'مجموع ماهانه';

  @override
  String get moreOptions => 'گزینه های بیشتر';

  @override
  String get mute => 'بی صدا کردن';

  @override
  String get name => 'نام';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'نام و شماره تلفن نمی توانند خالی باشند';

  @override
  String get nameAndPhoneNumberRequired =>
      'نام و شماره تلفن نمی توانند خالی باشند';

  @override
  String get nameColor => 'رنگ نام';

  @override
  String get nameFontSize => 'اندازه فونت نام';

  @override
  String nameLabel(Object name) {
    return 'نام: $name';
  }

  @override
  String get namePosition => 'موقعیت نام';

  @override
  String get nameUnknown => 'نام: ناشناس';

  @override
  String nameWithValue(String name) {
    return 'نام: $name';
  }

  @override
  String get newPasswordLabel => 'رمز عبور جدید';

  @override
  String get nextStep => 'بعدی';

  @override
  String get noAction => 'هیچ اقدامی';

  @override
  String get noActionRules => 'قوانین عدم اقدام';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'هی هیچ سرویس همگام سازی ابری فعال نیست';

  @override
  String get noCallLogs => 'هیچ سابقه تماسی وجود ندارد';

  @override
  String get noCallRecords => 'هیچ سابقه تماسی وجود ندارد';

  @override
  String get noContacts => 'هنوز هیچ مخاطبی وجود ندارد';

  @override
  String get noContactsYet => 'هنوز هیچ مخاطبی وجود ندارد';

  @override
  String get noData => 'داده ای وجود ندارد';

  @override
  String get noDevicesRegisteredMessage => 'هیچ دستگاهی ثبت نشده است';

  @override
  String get noDevicesRegisteredYet => 'هنوز هیچ دستگاهی ثبت نشده است.';

  @override
  String get noFilters => 'هنوز هیچ فیلتری وجود ندارد';

  @override
  String get noLabels => 'هنوز هیچ برچسبی وجود ندارد';

  @override
  String get noMarkedPhones => 'هیچ شماره تلفن علامت گذاری شده ای وجود ندارد';

  @override
  String get noMatchingContacts => 'هیچ مخاطب مطابقی وجود ندارد';

  @override
  String get noMatchingContactsFound => 'هیچ مخاطب مطابقی یافت نشد';

  @override
  String get noMatchingNumbersFound => 'هیچ شماره مطابقی یافت نشد';

  @override
  String get noMatchingRecords => 'هیچ سابقه تماس مطابقی وجود ندارد';

  @override
  String noMatchingRules(Object ruleType) {
    return 'هیچ $ruleType مطابقی وجود ندارد';
  }

  @override
  String get none => 'هیچ کدام';

  @override
  String get noneServiceType => 'هیچ کدام';

  @override
  String get noPlugins => 'هنوز هیچ افزونه ای وجود ندارد';

  @override
  String get noRecords => 'هیچ سابقه تماسی وجود ندارد';

  @override
  String get noResultReturned => 'نتیجه ای بازگردانده نشد';

  @override
  String get noResultReturnedLog => 'نتیجه ای از افزونه بازگردانده نشد';

  @override
  String noRules(Object ruleType) {
    return 'هنوز هیچ $ruleType وجود ندارد';
  }

  @override
  String get noRulesPrompt => 'هیچ قانونی یافت نشد، لطفا قوانین را اضافه کنید';

  @override
  String get noRulesToExport => 'هیچ قانونی برای صادرات وجود ندارد';

  @override
  String get noSmsFilterRulesYet => 'هنوز هیچ قانون فیلتر پیامکی وجود ندارد';

  @override
  String get noSmsRulesYet => 'هنوز هیچ قانون پیامکی وجود ندارد';

  @override
  String get noSubscriptions => 'هیچ اشتراکاتی وجود ندارد';

  @override
  String get noSubscriptionsYet => 'هنوز هیچ اشتراکاتی وجود ندارد';

  @override
  String get notGranted => 'اعطا نشده';

  @override
  String get notificationMode => 'حالت اعلان';

  @override
  String get notificationModeDescription =>
      'نمایش اطلاعات تماس گیرنده در نوار اعلان';

  @override
  String get notificationPermission => 'مجوز اعلان';

  @override
  String get notificationPermissionDescription =>
      'برای نمایش اعلان های تماس و پیام ورودی استفاده می شود.';

  @override
  String get notifications => 'اعلان ها';

  @override
  String get notificationSettings => 'تنظیمات اعلان';

  @override
  String get notificationSettingsSaved => 'تنظیمات اعلان با موفقیت ذخیره شد';

  @override
  String get notSet => 'تنظیم نشده';

  @override
  String get notVerifiedText => 'تایید نشده';

  @override
  String get noValidSmsRulesFoundInFile =>
      'هیچ قانون پیامکی معتبری در فایل یافت نشد';

  @override
  String get number => 'شماره';

  @override
  String get numberColor => 'رنگ شماره';

  @override
  String get numberFontSize => 'اندازه فونت شماره';

  @override
  String get numberPosition => 'موقعیت شماره';

  @override
  String get numberSearch => 'جستجوی شماره';

  @override
  String get numberTypeColor => 'رنگ نوع شماره';

  @override
  String get numberTypeFontSize => 'اندازه فونت نوع شماره';

  @override
  String get numberTypePosition => 'موقعیت نوع شماره';

  @override
  String get ok => 'باشه';

  @override
  String get okButton => 'باشه';

  @override
  String get onboardingCompleteDescription =>
      'مدیر امنیتی تماس شما آماده است، از تجربه تماس امن لذت ببرید!';

  @override
  String get onboardingLanguageDescription =>
      'زبان مورد نظر خود را برای بهترین تجربه انتخاب کنید.';

  @override
  String get onboardingPermissionsDescription =>
      'برای ارائه خدمات کامل، به مجوزهای زیر نیاز داریم:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'مسدود کردن یک کلیکی تماس ها و پیام های اسپم، سفارشی سازی قوانین مسدودسازی، و ارائه یک محیط آرام به شما.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'شناسایی خودکار تماس های ناشناس، علامت گذاری شماره های مشکوک، و محافظت از امنیت تماس شما.';

  @override
  String get onboardingWelcomeDescription =>
      'متخصص مدیریت تماس شما، ارائه خدمات جامع شناسایی و مسدودسازی تماس.';

  @override
  String get oneDriveAuthDescription =>
      'با شناسه و کلید کلاینت OneDrive که در سیستم پیکربندی شده است، مجوز دریافت کنید';

  @override
  String get oneDriveAuthorizationHint =>
      'با شناسه و کلید کلاینت OneDrive که در سیستم پیکربندی شده است، مجوز دریافت کنید';

  @override
  String get oneDriveConfigTitle => 'پیکربندی OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'پیکربندی OneDrive';

  @override
  String get onlineCallerIdSubscription => 'اشتراک شناسه تماس گیرنده آنلاین';

  @override
  String get openAppSettings => 'باز کردن تنظیمات برنامه';

  @override
  String openAppSettingsFailed(Object error) {
    return 'خطا در باز کردن تنظیمات برنامه: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'عملیات ناموفق بود: $error';
  }

  @override
  String get operationFailure => 'عملیات ناموفق بود';

  @override
  String get operationSuccess => 'عملیات موفقیت آمیز بود';

  @override
  String get other => 'سایر';

  @override
  String get ourOtherApps => 'برنامه‌های دیگر ما';

  @override
  String get overlayMode => 'پنجره شناور';

  @override
  String get overlayModeDescription =>
      'نمایش اطلاعات تماس گیرنده در یک پنجره شناور';

  @override
  String get overlayPermission => 'مجوز پنجره شناور';

  @override
  String get overlayPermissionDescription =>
      'برای نمایش پنجره شناور تماس ورودی استفاده می شود.';

  @override
  String get overview => 'مرور کلی';

  @override
  String get password => 'رمز عبور';

  @override
  String get passwordCannotBeEmpty => 'رمز عبور نمی تواند خالی باشد';

  @override
  String get passwordLabel => 'رمز عبور';

  @override
  String get passwordsDoNotMatch => 'رمزهای عبور مطابقت ندارند';

  @override
  String get passwordSetSuccessfully => 'رمز عبور با موفقیت تنظیم شد';

  @override
  String get pattern => 'الگو';

  @override
  String get pendingSync => 'همگام سازی در انتظار';

  @override
  String get periodMonth => 'ماه';

  @override
  String get periodWeek => 'هفته';

  @override
  String get periodYear => 'سال';

  @override
  String get permissionDenied => 'درخواست مجوز رد شد';

  @override
  String get permissionGranted => 'مجوز اعطا شد';

  @override
  String get permissionManagement => 'مدیریت مجوز';

  @override
  String get phoneCallsTab => 'تلفن';

  @override
  String get phoneNumber => 'شماره تلفن';

  @override
  String get phoneNumberCannotBeEmpty => 'شماره تلفن نمی تواند خالی باشد';

  @override
  String get phoneNumberHint => 'شماره تلفن را وارد کنید';

  @override
  String get phoneNumberHintText =>
      'شماره تلفن را برای اضافه کردن قانون وارد کنید';

  @override
  String get phoneNumberLabel => 'شماره تلفن';

  @override
  String get phoneNumberRegexRequired =>
      'لطفا هم شماره تلفن و هم الگوی regex را وارد کنید';

  @override
  String get phoneNumberRequired => 'شماره تلفن مورد نیاز است';

  @override
  String get phoneNumberTypeFixedLine => 'خط ثابت';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'خط ثابت یا موبایل';

  @override
  String get phoneNumberTypeMobile => 'موبایل';

  @override
  String get phoneNumberTypePager => 'پیجر';

  @override
  String get phoneNumberTypePersonalNumber => 'شماره شخصی';

  @override
  String get phoneNumberTypePremiumRate => 'نرخ ویژه';

  @override
  String get phoneNumberTypeSharedCost => 'هزینه اشتراکی';

  @override
  String get phoneNumberTypeTollFree => 'بدون هزینه';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'ناشناخته';

  @override
  String get phoneNumberTypeVoicemail => 'صندوق صوتی';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'مجوز تلفن';

  @override
  String get phonePermissionDescription =>
      'برای شناسایی و مسدود کردن تماس های ورودی استفاده می شود.';

  @override
  String get phoneRule => 'قانون تلفن';

  @override
  String get phoneRuleEditDialog => 'کادر گفتگو ویرایش قانون تلفن';

  @override
  String get phoneRuleManagement => 'مدیریت قوانین تلفن';

  @override
  String get phoneRuleSubscription => 'اشتراک قانون تلفن';

  @override
  String get phoneSubscription => 'اشتراک تلفن';

  @override
  String get phoneSubscriptionRulesDescription =>
      'برای به روز رسانی خودکار قوانین لیست سفید و سیاه، لیست های قوانین تلفن را از طریق URL مشترک شوید. از فایل های قانون با فرمت JSON پشتیبانی می کند.';

  @override
  String get phoneSubscriptionTitle => 'اشتراک های قوانین تلفن';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'لطفا یک برچسب انتخاب کرده و یک شماره تلفن معتبر وارد کنید';

  @override
  String pluginAddedSuccess(Object name) {
    return 'افزودن پلاگین \"$name\" با موفقیت انجام شد';
  }

  @override
  String get pluginDeleted => 'پلاگین حذف شد';

  @override
  String get pluginLatestVersion => 'پلاگین در حال حاضر آخرین نسخه است';

  @override
  String get pluginListExportSuccess => 'لیست پلاگین ها با موفقیت صادر شد';

  @override
  String get pluginLoadedSuccessfully => 'پلاگین با موفقیت بارگذاری شد';

  @override
  String get pluginManagement => 'مدیریت پلاگین';

  @override
  String get pluginManagementSubtitle =>
      'مدیریت و پیکربندی پلاگین های شخص ثالث';

  @override
  String get pluginManagementTitle => 'مدیریت پلاگین';

  @override
  String get pluginName => 'نام پلاگین';

  @override
  String get pluginNotLoaded =>
      'پلاگین هنوز بارگذاری نشده است. لطفا ابتدا پلاگین را بارگذاری کنید.';

  @override
  String pluginsDeleted(Object count) {
    return '$count پلاگین با موفقیت حذف شد.';
  }

  @override
  String get pluginService => 'سرویس پلاگین';

  @override
  String get pluginTestPageTitle => 'تست پلاگین';

  @override
  String get pluginUpdateSuccess => 'پلاگین با موفقیت به روز شد';

  @override
  String get pluginUrl => 'آدرس پلاگین';

  @override
  String get pluginUrlCannotBeEmpty => 'آدرس پلاگین نمی تواند خالی باشد';

  @override
  String get pluginUrlHint => 'آدرس پلاگین را وارد کنید';

  @override
  String get pluginUrlLabel => 'آدرس پلاگین';

  @override
  String get pluginVersion => 'نسخه پلاگین';

  @override
  String get political => 'سیاسی';

  @override
  String get powerfulSpamBlocking => 'مسدود کننده قدرتمند هرزنامه';

  @override
  String get previousStep => 'قبلی';

  @override
  String get prioritizeRemoteAction => 'اولویت تنظیمات عمل از راه دور';

  @override
  String get prioritizeRemoteActionDescription =>
      'اولویت تنظیمات عمل از پایگاه داده از راه دور';

  @override
  String get processing => 'در حال پردازش...';

  @override
  String get processingOperation => 'در حال پردازش...';

  @override
  String get purchase => 'خرید';

  @override
  String get quarterlyMembership => 'عضویت سه ماهه';

  @override
  String get quarterlyMembershipDescription =>
      'دسترسی به تمام ویژگی های پرمیوم، تمدید خودکار سه ماهه';

  @override
  String get queryButton => 'پرس و جو';

  @override
  String get queryFailed => 'پرس و جو ناموفق بود';

  @override
  String get queryFailedLog => 'پرس و جو ناموفق بود';

  @override
  String get querying => 'در حال پرس و جو...';

  @override
  String get queryingPhoneNumber => 'در حال پرس و جو شماره تلفن';

  @override
  String get queryResultTitle => 'نتیجه پرس و جو';

  @override
  String get ready => 'آماده!';

  @override
  String get receiveWeeklyStatistics => 'دریافت آمار هفتگی';

  @override
  String get recruiter => 'استخدام کننده';

  @override
  String get reEnterPasswordHint => 'لطفا رمز عبور را مجددا وارد کنید';

  @override
  String get refresh => 'بازنشانی';

  @override
  String get refreshPermissionStatus => 'بازنشانی وضعیت مجوز';

  @override
  String get refreshTooltip => 'بازنشانی';

  @override
  String regexError(Object error) {
    return 'خطای Regex: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'خطای Regex: $error';
  }

  @override
  String get regexPattern => 'الگوی Regex';

  @override
  String get regexPatternExplanation => 'توضیح الگوی Regex';

  @override
  String get regexPatternExplanationButton => 'توضیح الگوی Regex';

  @override
  String get regexPatternLabel => 'الگوی Regex';

  @override
  String get regexPatternsExamples =>
      'از سینتکس استاندارد regex برای تعریف الگوها استفاده کنید. مثال ها:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'الگوهای Regex برای تطابق شماره تلفن';

  @override
  String get regexRule => 'قانون Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'افزودن قانون regex ناموفق بود: $error';
  }

  @override
  String get regexRuleAddSuccess => 'قانون regex با موفقیت اضافه شد';

  @override
  String get regexRuleManagement => 'مدیریت قوانین Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'نام قانون و الگوی regex نباید خالی باشد';

  @override
  String get regexRules => 'قوانین Regex';

  @override
  String get regexTesterTitle => 'تستر Regex';

  @override
  String regexValidationFailed(Object error) {
    return 'اعتبارسنجی Regex ناموفق بود: $error';
  }

  @override
  String get regexValidationSuccess => 'اعتبارسنجی Regex موفقیت آمیز بود';

  @override
  String get region => 'منطقه';

  @override
  String get registeredDevicesTitle => 'دستگاه های ثبت شده';

  @override
  String get rejectAllCalls => 'رد همه تماس ها';

  @override
  String get rejectAllCallsDescription =>
      'در صورت فعال بودن، همه تماس ها با بالاترین اولویت رد خواهند شد';

  @override
  String get rejectAllNumbers => 'رد همه شماره ها';

  @override
  String get rejectAllNumbersDesc =>
      'در صورت فعال بودن، همه تماس های ورودی را رد کنید';

  @override
  String get rejectExceededNumbers => 'رد شماره های از حد گذشته';

  @override
  String get rejectExceededNumbersDescription =>
      'رد خودکار شماره هایی که از آستانه شمارش فراتر می روند';

  @override
  String get remoteFilterSettings => 'تنظیمات فیلتر از راه دور';

  @override
  String get remoteFilterSettingsPageTitle => 'تنظیمات فیلتر شماره از راه دور';

  @override
  String get remoteNumberFilter => 'فیلتر شماره از راه دور';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'این فیلتر از یک پایگاه داده از راه دور مستقل برای دریافت آخرین اطلاعات شماره استفاده می کند.';

  @override
  String get remoteNumberFilterDescription =>
      'تماس های مزاحم را بر اساس اطلاعات پایگاه داده از راه دور رهگیری کنید';

  @override
  String get remoteNumberFilterExplanationContent =>
      'فیلتر شماره از راه دور با پرس و جو از یک پایگاه داده از راه دور بر اساس تعداد شماره، تماس های اسپم را شناسایی و مسدود می کند.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'توضیح فیلتر شماره از راه دور';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• آستانه شمارش: بر اساس فراوانی وقوع شماره تعیین کنید';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• اقدامات فیلتر: نحوه برخورد با شماره هایی که از آستانه فراتر می روند را پیکربندی کنید';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• تنظیمات اولویت: اولویت اقدامات از راه دور را تنظیم کنید';

  @override
  String get remoteNumberFilterFeatures => 'ویژگی ها:';

  @override
  String get remoteNumberFiltering => 'فیلترینگ شماره از راه دور';

  @override
  String get remoteNumberFilteringExplanation =>
      '• فیلتر شماره از راه دور: قوانین فیلترینگ بر اساس اطلاعات پایگاه داده از راه دور';

  @override
  String get remoteNumberFilterSubtitle =>
      'شناسایی تماس های اسپم با استفاده از پایگاه داده ابری و گزارش های جامعه';

  @override
  String get removeAdsDescription =>
      'برای تجربه روان تر، تمام تبلیغات را در برنامه به طور دائم حذف کنید';

  @override
  String get removeAdsTitle => 'حذف تبلیغات';

  @override
  String get removedFromFavoriteContacts => 'از مخاطبین مورد علاقه حذف شد';

  @override
  String get removedFromFavorites => 'از موارد دلخواه حذف شد';

  @override
  String get removeFavorite => 'حذف مورد دلخواه';

  @override
  String get removeFromFavorites => 'حذف از موارد دلخواه';

  @override
  String get renameButton => 'تغییر نام';

  @override
  String get renameDeviceDialogTitle => 'تغییر نام دستگاه';

  @override
  String get renameDeviceTitle => 'تغییر نام دستگاه';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'این کار تمام تنظیمات فعلی شما را جایگزین می کند. آیا مطمئن هستید که می خواهید ادامه دهید؟';

  @override
  String get requestAllPermissions => 'درخواست همه مجوزها';

  @override
  String get requestPermission => 'درخواست مجوز';

  @override
  String requestPermissionFailed(Object error) {
    return 'درخواست مجوز ناموفق بود: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count علامت';
  }

  @override
  String get reset => 'بازنشانی';

  @override
  String get restore => 'بازیابی';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'بازیابی تنظیمات برنامه از پشتیبان';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'تنظیمات برنامه را از پشتیبان بازیابی کنید';

  @override
  String get restoreButton => 'بازیابی';

  @override
  String restoreFailedWithError(Object error) {
    return 'بازیابی از ابر ناموفق بود: $error';
  }

  @override
  String get restoreFromCloud => 'بازیابی از ابر';

  @override
  String get restoreFromCloudDescription =>
      'تنظیمات و قوانین را از فضای ذخیره سازی ابری بازیابی کنید';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'بازیابی از ابر ناموفق بود: $error';
  }

  @override
  String get restoreFromCloudLabel => 'بازیابی از ابر';

  @override
  String get restoreFromCloudSuccess => 'با موفقیت از ابر بازیابی شد';

  @override
  String get restoreFromCloudTitle => 'بازیابی از ابر';

  @override
  String get restoreFromLocal => 'بازیابی از محلی';

  @override
  String get restorePurchases => 'بازیابی خریدها';

  @override
  String get restoreSectionTitle => 'بازیابی';

  @override
  String get restoreSettings => 'بازیابی تنظیمات';

  @override
  String get restoreSettingsConfirmation =>
      'این کار تمام تنظیمات فعلی شما را جایگزین می کند. آیا مطمئن هستید که می خواهید ادامه دهید؟';

  @override
  String get restoreSettingsDialogTitle => 'بازیابی تنظیمات';

  @override
  String get restoreSettingsTitle => 'بازیابی تنظیمات';

  @override
  String get restoreSuccessFromLocal => 'با موفقیت از محلی بازیابی شد';

  @override
  String get restoreSuccessMessage => 'با موفقیت از ابر بازیابی شد';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get ridesharing => 'اشتراک گذاری سفر';

  @override
  String get risk => 'خطر';

  @override
  String get robocall => 'تماس ربات';

  @override
  String get ruleAction => 'اقدام قانون';

  @override
  String get ruleAddButton => 'افزودن قانون';

  @override
  String get ruleAddedSuccess => 'قانون با موفقیت اضافه شد';

  @override
  String ruleAddFailure(Object error) {
    return 'افزودن قانون ناموفق بود: $error';
  }

  @override
  String get ruleAddSuccess => 'قانون با موفقیت اضافه شد';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'آیا مطمئن هستید که می خواهید این $ruleType را حذف کنید؟';
  }

  @override
  String get ruleDeleteConfirmTitle => 'حذف قانون';

  @override
  String get ruleDeletedSuccess => 'قانون با موفقیت حذف شد';

  @override
  String get ruleDeletedSuccessfully => 'قانون با موفقیت حذف شد';

  @override
  String ruleDeleteFailed(Object error) {
    return 'حذف قانون ناموفق بود: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'حذف قانون ناموفق بود: $error';
  }

  @override
  String get ruleDeleteSuccess => 'قانون با موفقیت حذف شد';

  @override
  String get ruleDisabledSuccessfully => 'قانون با موفقیت غیرفعال شد';

  @override
  String get ruleEnabledSuccessfully => 'قانون با موفقیت فعال شد';

  @override
  String ruleLoadFailed(Object error) {
    return 'بارگیری قوانین ناموفق بود: $error';
  }

  @override
  String get ruleManagement => 'مدیریت قوانین';

  @override
  String get ruleManagementTitle => 'مدیریت قوانین';

  @override
  String get ruleName => 'نام قانون';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'نام قانون و regex محتوا نباید خالی باشد';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'نام قانون و شماره تلفن نباید خالی باشد';

  @override
  String get ruleNameHint => 'مانند: خانواده، دوستان و غیره';

  @override
  String get ruleNameLabel => 'نام قانون';

  @override
  String get ruleNamePatternRequired => 'لطفا نام و الگوی قانون را وارد کنید';

  @override
  String get ruleNameRequired => 'نام قانون و شماره تلفن نباید خالی باشد';

  @override
  String get ruleNotExist => 'قانون وجود ندارد یا حذف شده است';

  @override
  String ruleNotFound(Object error) {
    return 'قانون یافت نشد: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'قانون با موفقیت ذخیره شد!';

  @override
  String get ruleSavedSuccessMessage => 'قانون با موفقیت ذخیره شد!';

  @override
  String ruleSaveFailed(Object error) {
    return 'ذخیره ناموفق بود: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'ذخیره ناموفق بود: $error';
  }

  @override
  String get ruleSaveSuccess => 'قانون با موفقیت ذخیره شد!';

  @override
  String get rulesExportedSuccessfully => 'قوانین با موفقیت صادر شدند';

  @override
  String rulesExportedTo(Object path) {
    return 'قوانین به: $path صادر شدند';
  }

  @override
  String get rulesImported => 'قوانین با موفقیت وارد شدند';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count قانون با موفقیت وارد شد';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'ورود قوانین ناموفق بود: $error';
  }

  @override
  String get ruleStatistics => 'آمار قانون';

  @override
  String ruleStatusChanged(Object status) {
    return 'قانون با موفقیت $status شد';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'عملیات ناموفق بود: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'قانون با موفقیت $status شد';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'به‌روزرسانی قانون ناموفق بود: $error';
  }

  @override
  String get ruleUpdateSuccess => 'قانون با موفقیت به‌روزرسانی شد';

  @override
  String get ruleVerification => 'تأیید قانون';

  @override
  String get save => 'ذخیره';

  @override
  String get saveButton => 'ذخیره';

  @override
  String get saveButtonLabel => 'ذخیره';

  @override
  String get saveButtonText => 'ذخیره';

  @override
  String saveFailed(Object error) {
    return 'ذخیره ناموفق بود: $error';
  }

  @override
  String get saveFilter => 'ذخیره فیلتر';

  @override
  String get saveSettings => 'ذخیره تنظیمات';

  @override
  String saveSettingsFailed(Object error) {
    return 'ذخیره تنظیمات ناموفق بود: $error';
  }

  @override
  String get scamsLikely => 'احتمال کلاهبرداری';

  @override
  String get search => 'جستجو';

  @override
  String get searchContacts => 'جستجوی مخاطبین';

  @override
  String searchError(Object error) {
    return 'خطای جستجو: $error';
  }

  @override
  String get searchFilters => 'فیلترهای جستجو';

  @override
  String get searchForContacts => 'جستجو برای مخاطبین';

  @override
  String get searchHint => 'جستجو...';

  @override
  String get searchSettingsSubtitle =>
      'جستجوی مخاطبین، برچسب‌ها، لیست سیاه، لیست سفید و غیره.';

  @override
  String get searchSettingsTitle => 'تنظیمات جستجو';

  @override
  String get securityMessage =>
      'به هیچ تماس تلفنی اعتماد نکنید. همیشه شماره‌های خدمات مشتری را به طور مستقل تأیید کنید. هرگز رمزهای عبور، کدهای تأیید، شماره کارت یا اطلاعات شخصی را به اشتراک نگذارید.';

  @override
  String get selectActionToPerform =>
      'اقدام مورد نظر هنگام تطابق قانون را انتخاب کنید';

  @override
  String get selectActionWhenBlockingCalls =>
      'اقدام هنگام مسدود کردن تماس‌ها را انتخاب کنید';

  @override
  String get selectActionWhenRuleMatches =>
      'اقدام هنگام تطابق قانون را انتخاب کنید';

  @override
  String get selectAll => 'انتخاب همه';

  @override
  String get selectCountry => 'انتخاب کشور';

  @override
  String get selectDateRange => 'انتخاب محدوده تاریخ';

  @override
  String get selectedDateRange => 'محدوده تاریخ انتخاب شده';

  @override
  String selectedItems(Object count) {
    return '$count مورد انتخاب شده';
  }

  @override
  String get selectedLabel => 'انتخاب شده:';

  @override
  String get selectExportFormat => 'انتخاب فرمت خروجی';

  @override
  String get selectLabel => 'انتخاب برچسب';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'لطفاً یک برچسب انتخاب کرده و یک شماره تلفن معتبر وارد کنید';

  @override
  String get selectLanguage => 'انتخاب زبان';

  @override
  String get selectMultiple => 'انتخاب چندگانه';

  @override
  String get selectPeriod => 'انتخاب دوره';

  @override
  String get selectSimCard => 'انتخاب سیم کارت';

  @override
  String get selectSimSlot => 'انتخاب اسلات سیم کارت';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'اقدام خاص مورد نظر هنگام مسدود کردن تماس‌ها را انتخاب کنید';

  @override
  String get selectTag => 'انتخاب تگ';

  @override
  String get selectTags => 'انتخاب تگ‌ها';

  @override
  String get selectTrustedDataSource => 'لطفاً منابع داده معتبر را انتخاب کنید';

  @override
  String get selectYourLanguage => 'انتخاب زبان شما';

  @override
  String get sender => 'فرستنده';

  @override
  String get senderRegexOptional => 'عبارت منظم فرستنده (اختیاری)';

  @override
  String get serverAddressLabel => 'آدرس سرور';

  @override
  String get serviceTypeContact => 'اشتراک تماس';

  @override
  String get serviceTypeLabel => 'نوع سرویس';

  @override
  String get serviceTypePhone => 'اشتراک تلفن';

  @override
  String get serviceTypePlugin => 'به‌روزرسانی افزونه';

  @override
  String get serviceTypeSms => 'اشتراک پیامک';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'تنظیم';

  @override
  String get setEncryptionPassword => 'تنظیم رمز عبور رمزگذاری';

  @override
  String get setEncryptionPasswordDescription =>
      'رمز عبور رمزگذاری را برای پشتیبان‌گیری و بازیابی تنظیم کنید';

  @override
  String get setEncryptionPasswordLabel => 'تنظیم رمز عبور رمزگذاری';

  @override
  String get setEncryptionPasswordTitle => 'تنظیم رمز عبور رمزگذاری';

  @override
  String get setPasswordButton => 'تنظیم';

  @override
  String get settings => 'تنظیمات';

  @override
  String settingsBackedUpTo(Object path) {
    return 'تنظیمات در: $path پشتیبان‌گیری شد';
  }

  @override
  String get settingsLoaded => 'تنظیمات بارگذاری شد';

  @override
  String settingsLoadFailed(Object error) {
    return 'بارگذاری تنظیمات ناموفق بود: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'تنظیمات با موفقیت بازیابی شد. لطفاً برنامه را مجدداً راه‌اندازی کنید تا تغییرات اعمال شوند.';

  @override
  String get settingsSaved => 'تنظیمات ذخیره شد';

  @override
  String settingsSaveFailed(Object error) {
    return 'ذخیره تنظیمات ناموفق بود: $error';
  }

  @override
  String get settingsTab => 'تنظیمات';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get setup => 'تنظیم';

  @override
  String get showContactEditDialogStaticMethod =>
      'متد استاتیک برای نمایش پنجره ویرایش مخاطب';

  @override
  String get showExplanation => 'نمایش توضیح';

  @override
  String get silence => 'بی‌صدا کردن';

  @override
  String get silenceAndNoAnswer => 'بی‌صدا کردن و عدم پاسخ';

  @override
  String get silenceNoAnswer => 'بی‌صدا کردن عدم پاسخ';

  @override
  String get silentCallVoiceClone => 'کلون صدای تماس بی‌صدا';

  @override
  String get silentRules => 'قوانین بی‌صدا';

  @override
  String simCard(Object simNumber) {
    return 'سیم کارت $simNumber';
  }

  @override
  String get simCardColor => 'رنگ سیم کارت';

  @override
  String get simCardConfigurationExplanation =>
      '• تنظیمات سیم کارت: قوانین فیلتر مستقل برای هر سیم کارت تنظیم کنید';

  @override
  String get simCardFilterRules => 'قوانین فیلتر سیم کارت';

  @override
  String get simCardFilterRulesDescription =>
      'قوانین فیلتر متفاوتی را بر اساس اسلات سیم کارت تنظیم کنید';

  @override
  String get simCardFontSize => 'اندازه فونت سیم کارت';

  @override
  String get simCardPosition => 'موقعیت سیم کارت';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'سیم $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'بارگذاری اطلاعات سیم کارت ناموفق بود: $error';
  }

  @override
  String get simRuleInstructions =>
      'قوانین اسلات سیم کارت به شما امکان می دهد قوانین فیلترینگ مستقلی را برای هر اسلات سیم کارت پیکربندی کنید.';

  @override
  String get simRuleInstructionsTitle => 'قوانین اسلات سیم کارت';

  @override
  String get simRuleManagement => 'مدیریت قوانین اسلات سیم کارت';

  @override
  String simSlot1(String countryIso) {
    return 'سیم کارت ۱،-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'سیم کارت ۲،-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'خطا در بارگذاری داده های سیم کارت: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'پیکربندی فیلتر اسلات سیم کارت';

  @override
  String get simSlotFilterConfigurationDescription =>
      'امکان تنظیم قوانین فیلتر بر اساس اسلات سیم کارت';

  @override
  String get simSlotFilterDescription =>
      'قوانین فیلترینگ مستقل را برای هر سیم کارت پیکربندی کنید:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'تنظیمات فیلتر اسلات سیم کارت $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'خطا در بارگذاری اسلات های سیم کارت: $error';
  }

  @override
  String get simSlotManagement => 'مدیریت اسلات سیم کارت';

  @override
  String simSlotOperationFailed(Object error) {
    return 'عملیات اسلات سیم کارت ناموفق بود: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'موقعیت اسلات سیم کارت $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• قوانین اسلات سیم کارت: استراتژی های فیلترینگ مستقل برای هر سیم کارت';

  @override
  String get simSlotRuleListTitle => 'لیست قوانین اسلات سیم کارت';

  @override
  String get simSlotRuleManagement => 'قوانین اسلات سیم کارت';

  @override
  String get simSlotRuleManagementTitle => 'مدیریت قوانین';

  @override
  String get simSlotSettings => 'تنظیمات اسلات سیم کارت';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'اسلات سیم کارت $slotNumber';
  }

  @override
  String get skip => 'رد شدن';

  @override
  String get smartCallerId => 'شناسایی هوشمند تماس گیرنده';

  @override
  String get sms => 'پیامک';

  @override
  String get smsFilterDescription =>
      'فیلتر کردن پیامک به شما کمک می کند تا پیام های اسپم را به طور خودکار فیلتر کرده و لیست پیام های خود را تمیز نگه دارید. می توانید قوانین فیلتر و روش های اعلان را تنظیم کنید.';

  @override
  String get smsFilterDisabled => 'فیلتر کردن پیامک غیرفعال است';

  @override
  String get smsFilterEnabled => 'فیلتر کردن پیامک فعال است';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'قانون فیلتر پیامک با موفقیت اضافه شد';

  @override
  String get smsFilterRules => 'قوانین فیلتر پیامک';

  @override
  String get smsFilterSettings => 'تنظیمات فیلتر پیامک';

  @override
  String get smsHistory => 'تاریخچه پیامک';

  @override
  String get smsManagement => 'مدیریت پیامک';

  @override
  String get smsPermission => 'مجوز پیامک';

  @override
  String get smsPermissionDescription =>
      'برای فیلتر کردن پیام های اسپم استفاده می شود.';

  @override
  String get smsRuleAddedSuccessfully => 'قانون پیامک با موفقیت اضافه شد';

  @override
  String get smsRuleDeletedSuccessfully => 'قانون پیامک با موفقیت حذف شد';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'خطا در بارگذاری قوانین پیامک: $error';
  }

  @override
  String get smsRuleManagement => 'مدیریت قوانین پیامک';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'قوانین پیامک با موفقیت به $filePath صادر شد';
  }

  @override
  String get smsRulesImportedSuccessfully => 'قوانین پیامک با موفقیت وارد شد';

  @override
  String get smsRuleSubscription => 'اشتراک قوانین پیامک';

  @override
  String get smsRuleUpdatedSuccessfully => 'قانون پیامک با موفقیت به روز شد';

  @override
  String get smsSettingsSubtitle => 'فیلتر کردن پیامک و مسدود کردن کلمات کلیدی';

  @override
  String get smsSettingsTitle => 'تنظیمات پیامک';

  @override
  String get smsSubscription => 'اشتراک پیامک';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'اشتراک پیامک با موفقیت اضافه شد';

  @override
  String get smsSubscriptionRulesDescription =>
      'اشتراک در لیست قوانین پیامک از طریق URL، پشتیبانی از تطبیق عبارت منظم. می توانید اقدامات مسدود کردن یا مجاز کردن را تنظیم کنید.';

  @override
  String get smsTab => 'پیامک';

  @override
  String get somePermissionsDenied => 'درخواست برخی مجوزها رد شد';

  @override
  String get spamLikely => 'احتمال اسپم';

  @override
  String get startColor => 'رنگ شروع';

  @override
  String get startDate => 'تاریخ شروع';

  @override
  String get startUsing => 'شروع به استفاده';

  @override
  String get statAnswered => 'پاسخ داده شده';

  @override
  String get statBlocked => 'مسدود شده';

  @override
  String get staticMethodShowCallerIdDialog =>
      'روش استاتیک برای نمایش دیالوگ اطلاعات تماس گیرنده';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'روش استاتیک برای نمایش دیالوگ انتخاب کشور';

  @override
  String get staticMethodToDisplayDialog => 'روش استاتیک برای نمایش دیالوگ';

  @override
  String get statistics => 'آمار';

  @override
  String get statisticsExportFeatureComingSoon =>
      'قابلیت صادرات آمار به زودی ارائه می شود';

  @override
  String get statisticsGrid => 'شبکه آمار';

  @override
  String get statisticsPageTitle => 'تحلیل داده ها';

  @override
  String get stirColor => 'رنگ STIR';

  @override
  String get stirFontSize => 'اندازه فونت STIR';

  @override
  String get stirPosition => 'موقعیت STIR';

  @override
  String get storagePermission => 'مجوز ذخیره سازی';

  @override
  String get storagePermissionDescription =>
      'برای ذخیره تنظیمات و قوانین استفاده می شود.';

  @override
  String get subscribe => 'اشتراک';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'اشتراک \"$name\" با موفقیت اضافه شد';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'آیا مطمئن هستید که می خواهید این اشتراک را حذف کنید؟';

  @override
  String get subscriptionDeleteConfirmTitle => 'حذف اشتراک';

  @override
  String get subscriptionDeleted => 'اشتراک حذف شد';

  @override
  String get subscriptionDeletedSuccessfully => 'اشتراک با موفقیت حذف شد';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'خطا در حذف اشتراک: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'اشتراک حذف شد';

  @override
  String get subscriptionEmptyState => 'هیچ اشتراکی موجود نیست';

  @override
  String get subscriptionEmptyText => 'هنوز هیچ اشتراکی وجود ندارد';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'خطا در بارگذاری اشتراک ها: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'خطا در بارگذاری اشتراک ها: $error';
  }

  @override
  String get subscriptionManagementTitle => 'مدیریت اشتراک';

  @override
  String get subscriptionName => 'نام اشتراک';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'نام و URL اشتراک نمی توانند خالی باشند';

  @override
  String get subscriptionNameHint => 'نام اشتراک را وارد کنید';

  @override
  String get subscriptionPageTitle => 'مدیریت اشتراک';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'خطا در تغییر وضعیت اشتراک: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'خطا در تغییر وضعیت اشتراک: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'خطا در به روز رسانی اشتراک: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'اشتراک با موفقیت به روز شد';

  @override
  String get subscriptionUrl => 'URL اشتراک';

  @override
  String get subscriptionUrlHint => 'URL اشتراک را وارد کنید';

  @override
  String successfullyImportedRules(Object count) {
    return '$count قانون با موفقیت وارد شد';
  }

  @override
  String get supportSync => 'پشتیبانی از همگام سازی';

  @override
  String get survey => 'نظرسنجی';

  @override
  String get syncDevicesButton => 'همگام سازی دستگاه ها';

  @override
  String get syncFailed => 'همگام سازی ناموفق بود';

  @override
  String get syncFailedMessage => 'همگام سازی ناموفق بود';

  @override
  String get syncFolderNameHint =>
      'لطفا نام پوشه همگام سازی را وارد کنید (پیش فرض: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'نام پوشه همگام سازی';

  @override
  String get synchronized => 'همگام سازی شده';

  @override
  String get syncing => 'در حال همگام سازی...';

  @override
  String get syncNow => 'اکنون همگام سازی کنید';

  @override
  String get syncNowButton => 'همگام سازی هم اکنون';

  @override
  String get syncStatusTitle => 'وضعیت همگام سازی';

  @override
  String get syncStatusUpdatedMessage => 'وضعیت همگام سازی به روز شد';

  @override
  String get syncSuccessful => 'همگام سازی موفقیت آمیز بود';

  @override
  String get syncSuccessMessage => 'همگام سازی موفقیت آمیز بود';

  @override
  String get syncWithCloudStorage => 'همگام سازی با فضای ذخیره سازی ابری';

  @override
  String get syncWithCloudStorageSubtitle =>
      'همگام سازی با فضای ذخیره سازی ابری';

  @override
  String get systemFeatures => 'ویژگی های سیستم:';

  @override
  String get systemSettingsTitle => 'تنظیمات سیستم';

  @override
  String get tabAll => 'همه';

  @override
  String get tabAnswered => 'پاسخ داده شده';

  @override
  String get tabBlocked => 'مسدود شده';

  @override
  String get tabMissed => 'از دست رفته';

  @override
  String get tabOutgoing => 'خروجی';

  @override
  String tagLabel(String tag) {
    return 'برچسب: $tag';
  }

  @override
  String get tagsUpdated => 'برچسب ها به روز شدند';

  @override
  String get takeaway => 'برداشت';

  @override
  String get telecommunication => 'مخابرات';

  @override
  String get telegram => 'تلگرام';

  @override
  String get telemarketing => 'بازاریابی تلفنی';

  @override
  String get testButton => 'تست';

  @override
  String get testButtonLabel => 'تست';

  @override
  String get testConnectionButton => 'تست اتصال';

  @override
  String get textColorsSetting => 'رنگ متن و برچسب';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'این برنامه یک ابزار قدرتمند شناسه تماس گیرنده است که به شما امکان می دهد تماس های ناخواسته را شناسایی و مسدود کنید.';

  @override
  String get thisWeek => 'این هفته';

  @override
  String get timeInterceptor => 'رهگیر زمان';

  @override
  String get timeInterceptorDescription =>
      'رهگیری/اجازه دادن خودکار تماس های بالقوه بر اساس فراوانی تماس';

  @override
  String get timeInterceptorExplanation =>
      '• رهگیر زمان: رهگیری/اجازه دادن تماس های تکراری در مدت زمان کوتاه';

  @override
  String get timeInterceptorExplanationContent =>
      'ویژگی رهگیری فراوانی تماس، فراوانی تماس را تجزیه و تحلیل می کند تا تماس های هرزنامه مکرر را به طور خودکار شناسایی و رهگیری/اجازه دهد.';

  @override
  String get timeInterceptorExplanationTitle => 'توضیحات رهگیری فراوانی تماس';

  @override
  String get timeInterceptorSettingsTitle => 'تنظیمات رهگیری فراوانی تماس';

  @override
  String get timeInterceptorSubtitle =>
      'رهگیری خودکار تماس های هرزنامه بالقوه بر اساس فراوانی تماس';

  @override
  String get timeInterceptorTitle => 'فعال کردن رهگیری فراوانی تماس';

  @override
  String get timeWindowDescription =>
      'اندازه پنجره زمانی را برای اجازه دادن به تماس های تکراری تنظیم کنید. تماس های یک شماره در این پنجره مجاز خواهند بود';

  @override
  String timeWindowLabel(int minutes) {
    return 'پنجره زمانی رهگیری (دقیقه): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'اندازه پنجره زمانی را برای اجازه دادن به تماس های تکراری تنظیم کنید. تماس های یک شماره در این پنجره مجاز خواهند بود';

  @override
  String get today => 'امروز';

  @override
  String get total => 'کل';

  @override
  String get totalBlocked => 'کل مسدود شده';

  @override
  String get totalFiltered => 'کل فیلتر شده';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'انتقال داده بین دستگاه ها یا پلتفرم ها';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'انتقال داده بین دستگاه ها یا پلتفرم ها';

  @override
  String get travelTicketing => 'بلیط سفر';

  @override
  String get trend => 'روند';

  @override
  String get trendChart => 'نمودار روند';

  @override
  String get tutorial => 'آموزش';

  @override
  String get type => 'نوع';

  @override
  String get unassignedSIMCard => 'کارت سیم اختصاص داده نشده';

  @override
  String get unknown => 'ناشناخته';

  @override
  String get unknownLabel => 'برچسب ناشناخته';

  @override
  String get unknownTag => 'برچسب: ناشناخته';

  @override
  String get unregisterButton => 'لغو ثبت نام';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'آیا مطمئن هستید که می خواهید دستگاه $deviceName را لغو ثبت نام کنید؟';
  }

  @override
  String get unregisterDeviceTitle => 'لغو ثبت نام دستگاه';

  @override
  String get unsupportedFileFormat => 'فرمت فایل پشتیبانی نشده';

  @override
  String get update => 'به روز رسانی';

  @override
  String get updateAllNow => 'همه را هم اکنون به روز کن';

  @override
  String get updateCallFilterConfig => 'به روز رسانی پیکربندی فیلتر تماس';

  @override
  String updateContactFailed(Object error) {
    return 'به روز رسانی مخاطب ناموفق بود: $error';
  }

  @override
  String get updateFavoriteStatus => 'به روز رسانی وضعیت مورد علاقه';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'به روز رسانی وضعیت مورد علاقه ناموفق بود: $error';
  }

  @override
  String get updateInterval => 'بازه به روز رسانی';

  @override
  String get updateLabelFailed => 'به روز رسانی برچسب ناموفق بود';

  @override
  String get updateNow => 'هم اکنون به روز کن';

  @override
  String get updatePlugin => 'به روز رسانی افزونه';

  @override
  String updatePluginFailed(Object error) {
    return 'به روز رسانی افزونه ناموفق بود: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'به روز رسانی قانون ناموفق بود: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'به روز رسانی اشتراک ناموفق بود: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service با موفقیت به روز شد ($count قوانین)';
  }

  @override
  String get updateTags => 'به روز رسانی برچسب ها';

  @override
  String get useCasesPoint1 =>
      '• شناسایی تماس های هرزنامه با شماره گیری مجدد خودکار';

  @override
  String get useCasesPoint2 =>
      '• رهگیری تماس های بازاریابی که چندین بار در مدت زمان کوتاه تماس می گیرند';

  @override
  String get useCasesPoint3 => '• جلوگیری از بمباران تلفنی و آزار و اذیت';

  @override
  String get useCasesTitle => 'موارد استفاده:';

  @override
  String get useGlobalSettings => 'استفاده از تنظیمات جهانی';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'نام کاربری';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'از نحو استاندارد regex برای تعریف الگوها استفاده کنید. مثال ها:';

  @override
  String get validateRegex => 'اعتبار سنجی Regex';

  @override
  String get verificationFailedText => 'ناموفق';

  @override
  String get verifiedText => 'تایید شده';

  @override
  String get verify => 'تایید';

  @override
  String version(Object version) {
    return 'نسخه: $version';
  }

  @override
  String get vipExchangeDescription =>
      'تبادل عضویت VIP با تعداد علامت گذاری شماره تلفن';

  @override
  String get vipExchangeTitle => 'تبادل VIP علامت گذاری';

  @override
  String get watchAd => 'تماشای تبلیغ';

  @override
  String get watchAdForTemp => 'تماشای تبلیغ برای امتیازات موقت';

  @override
  String get watchAdForTempDescription =>
      'یک تبلیغ کوتاه تماشا کنید تا برخی از ویژگی های ممتاز را به طور موقت باز کنید';

  @override
  String get webDAVConfigTitle => 'پیکربندی WebDAV';

  @override
  String get webdavConfigurationTitle => 'پیکربندی WebDAV';

  @override
  String get webdavPasswordHint => 'لطفا رمز عبور WebDAV را وارد کنید';

  @override
  String get webdavServerAddressHint => 'لطفا آدرس سرور WebDAV را وارد کنید';

  @override
  String get webdavUsernameHint => 'لطفا نام کاربری WebDAV را وارد کنید';

  @override
  String get week => 'هفته';

  @override
  String get weekly => 'هفتگی';

  @override
  String get weeklyBlockedCallsSummary => 'خلاصه تماس های مسدود شده هفتگی';

  @override
  String get weeklyChartTitle => 'تماس های مسدود شده هفتگی';

  @override
  String get weeklyReport => 'گزارش هفتگی';

  @override
  String get weeklyReportDesc =>
      'گزارش خلاصه هفتگی فعالیت مسدود کردن تماس را دریافت کنید';

  @override
  String get welcome => 'به';

  @override
  String get whitelist => 'لیست مجاز';

  @override
  String get whitelistLabel => 'لیست مجاز';

  @override
  String get width => 'عرض';

  @override
  String get wildcardMatchingDescription =>
      'از \'.\' برای تطابق با هر کاراکتری استفاده کنید (مثلاً \'123.456\' با 123-456 مطابقت دارد)';

  @override
  String get wildcardMatchingTitle => 'تطابق کاراکتر عام:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'پشتیبانی از کاراکتر عام برای فیلترینگ انعطاف پذیر';

  @override
  String get windowSizeSetting => 'اندازه پنجره';

  @override
  String get year => 'سال';

  @override
  String get yearly => 'سالانه';

  @override
  String get yearlyChartTitle => 'تماس‌های مسدود شده سالانه';

  @override
  String get noSimCardsDetected => 'هیچ سیم کارتی شناسایی نشد';

  @override
  String get filterManagementDescription => 'تنظیم فیلترهای تماس';

  @override
  String get callerIdCustomizationSubtitle =>
      'سفارشی سازی طرح بندی شناسه تماس گیرنده';

  @override
  String get fraudAlerSettingTitle => 'تنظیم هشدار تقلب';

  @override
  String get fraudAlerSettingSubtitle => 'برای تنظیم هشدار تقلب';

  @override
  String get enableFraudAlert => 'فعال کردن هشدار تقلب';

  @override
  String get enableFraudAlertDescription =>
      'هشدار برای تماس های مشکوک به کلاهبرداری';

  @override
  String get enableVibration => 'فعال کردن لرزش';

  @override
  String get enableVibrationDescription =>
      'هنگام تماس مشکوک به کلاهبرداری، لرزش را فعال کنید';

  @override
  String get notificationSettingsTitle => 'تنظیمات اعلان';

  @override
  String get useLocalNotification => 'استفاده از اعلان های محلی';

  @override
  String get useLocalNotificationDescription =>
      'فعال کردن اعلان های محلی برای تماس های ورودی';

  @override
  String get cancelLocalNotification => 'بستن اعلان های محلی';

  @override
  String get useStirNotification => 'استفاده از اعلان STIR';

  @override
  String get useStirNotificationDescription =>
      'فعال کردن اعلان های STIR برای تماس های ورودی';

  @override
  String get cancelLocalNotificationDescription => 'بستن خودکار اعلان های محلی';

  @override
  String get callerIdSettingsTitle => 'تنظیمات شناسه تماس گیرنده';

  @override
  String get callerIdSettingsSubtitle =>
      'برای تنظیم اعلان و حالت نمایش تماس ورودی';

  @override
  String get purchaseTitle => 'خرید';

  @override
  String get purchaseSubtitle => 'برای خرید سرویس';

  @override
  String get callerIdNotificationTitle => 'اطلاعات تماس ورودی';

  @override
  String callerIdBody(String phoneNumber) {
    return 'شماره: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'تماس مسدود شده';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'تماس مسدود شده از $phoneNumber';
  }

  @override
  String get stirVerified => 'تایید شده';

  @override
  String get stirNotVerified => 'تایید نشده';

  @override
  String get stirFailed => 'تایید ناموفق بود';

  @override
  String get stirUnknown => 'وضعیت تایید نامشخص';

  @override
  String get stirVerificationTitle => 'تایید STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage برای شماره $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings => 'تنظیمات پیام امنیتی پیمایشی';

  @override
  String get messageColor => 'رنگ پیام';

  @override
  String get messageFontSize => 'اندازه فونت پیام';

  @override
  String get messagePosition => 'موقعیت پیام';

  @override
  String get containerWidth => 'عرض کانتینر';

  @override
  String get scrollSpeed => 'سرعت پیمایش';

  @override
  String get enableSecurityMessage => 'فعال کردن پیام امنیتی';

  @override
  String get fraudAlertTitle => 'هشدار تقلب';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'تماس مشکوک به تقلب از $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'بارگذاری قوانین ناموفق بود: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'بارگذاری گزارش تماس ناموفق بود: $error';
  }

  @override
  String get noBlockedTypeData => 'هیچ داده ای از نوع مسدود شده در دسترس نیست';

  @override
  String importEntity(Object entityTypeName) {
    return 'وارد کردن $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName با موفقیت وارد شد، در مجموع $count رکورد وارد شد';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'وارد کردن $entityTypeName ناموفق بود: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'صادر کردن $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName با موفقیت صادر شد';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'صادر کردن $entityTypeName ناموفق بود: $error';
  }

  @override
  String get cloudSyncService => 'سرویس همگام سازی ابری';

  @override
  String get membershipCenter => 'مرکز عضویت';

  @override
  String get redeemVipWithMarks => 'بازخرید VIP با مارک';

  @override
  String get currentMarkCount => 'تعداد مارک فعلی';

  @override
  String get markMoreNumbersForMore =>
      'برای دریافت مارک بیشتر، شماره های بیشتری را مارک کنید';

  @override
  String get noAds => 'بدون تبلیغات';

  @override
  String get cloudBackup => 'پشتیبان گیری ابری';

  @override
  String get callerIdEnhancement => 'بهبود شناسه تماس گیرنده';

  @override
  String get voiceRecognition => 'تشخیص صدا';

  @override
  String get feature => 'ویژگی';

  @override
  String get normalUser => 'کاربر عادی';

  @override
  String get vipUser => 'کاربر VIP';

  @override
  String get temporaryVip => 'VIP موقت';

  @override
  String get removeAds => 'حذف تبلیغات';

  @override
  String get unknownAction => 'اقدام نامشخص';

  @override
  String get settingsBackup => 'پشتیبان گیری تنظیمات ';

  @override
  String get allServicesStatusTitle => 'وضعیت فعلی سرویس';

  @override
  String get allServicesStatusSubtitle => 'وضعیت فعلی هر سرویس ابری';

  @override
  String get redirect => 'هدایت';

  @override
  String get notify => 'اطلاع دادن';

  @override
  String get log => 'ثبت';

  @override
  String get custom => 'سفارشی';

  @override
  String get allowActionDescription =>
      'تماس ها اجازه داده می شوند، حتی اگر شماره در لیست مسدود شده باشد.';

  @override
  String get blockActionDescription =>
      'تماس ها مسدود شده و در گزارش تماس نمایش داده می شوند.';

  @override
  String get silenceActionDescription =>
      'تماس ها بی صدا می شوند اما در گزارش تماس نمایش داده می شوند.';

  @override
  String get noneActionDescription =>
      'هیچ اقدام ویژه ای برای تماس انجام نخواهد شد.';

  @override
  String get redirectActionDescription =>
      'تماس را به یک شماره مشخص هدایت کنید.';

  @override
  String get labelActionDescription =>
      'برای شناسایی آسان، یک برچسب به تماس اضافه کنید.';

  @override
  String get notifyActionDescription => 'هنگام دریافت تماس، اعلان ارسال کنید.';

  @override
  String get logActionDescription =>
      'اطلاعات تماس را بدون انجام هیچ اقدام دیگری ثبت کنید.';

  @override
  String get customActionDescription => 'یک اقدام سفارشی انجام دهید.';

  @override
  String get synced => 'همگام سازی شده';

  @override
  String get needVipAccess =>
      'برای استفاده از این ویژگی به دسترسی VIP نیاز دارید';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'وارد کردن یا صادر کردن داده های $entityTypeName';
  }

  @override
  String get importExportTitle => 'واردات/صادرات';

  @override
  String get noPhoneRules => 'هیچ قانون تلفنی یافت نشد';

  @override
  String get noRegexRules => 'هیچ قانون regex یافت نشد';

  @override
  String get noAllowedBlockedRules => 'هیچ قانون مجاز/مسدود شده ای یافت نشد';

  @override
  String get importExport => 'واردات/صادرات';

  @override
  String get filterByAction => 'فیلتر بر اساس اقدام';

  @override
  String get upgradeToVip => 'ارتقا به VIP';

  @override
  String get batteryOptimizationPermission => 'بهینه سازی باتری';

  @override
  String get batteryOptimizationPermissionDescription =>
      'به برنامه اجازه دهید تا در پس زمینه برای ارائه خدماتی مانند شناسه تماس گیرنده اجرا شود.';

  @override
  String get permissionTitle => 'مجوزهای ویژه';

  @override
  String get permissionSubtitle => 'مدیریت مجوزهای همپوشانی و بهینه سازی باتری';

  @override
  String get themeSettingsTitle => 'تنظیمات پوسته';

  @override
  String get themeSettingsSubtitle => 'پوسته مورد علاقه خود را انتخاب کنید';

  @override
  String get databaseSyncTitle => 'همگام سازی پایگاه داده';

  @override
  String get countrySyncSettingsTitle =>
      'تنظیمات همگام سازی پایگاه داده مبتنی بر کشور';

  @override
  String get countrySyncSettingsSubtitle =>
      'کشورها را برای همگام سازی داده ها انتخاب کنید';

  @override
  String get countryDataDisclaimer =>
      'لطفاً توجه داشته باشید: ممکن است پایگاه داده شامل داده هایی برای همه کشورها یا مناطق خاص نباشد.';

  @override
  String get editSubscription => 'ویرایش اشتراک';

  @override
  String get searchByNameOrPhoneNumber => 'جستجو بر اساس نام یا شماره تلفن';

  @override
  String get allowedBlockedRulesInfo =>
      'قوانین مجاز/مسدود شده برای تطبیق تماس ها با شماره تلفن های خاص استفاده می شوند که بالاترین اولویت را دارند.';

  @override
  String get searchPhoneRulesHint => 'جستجو قوانین تلفن';

  @override
  String get phoneRulesInfo =>
      'قوانین تلفن برای تطبیق تماس ها با شماره تلفن های خاص استفاده می شوند که اولویت کمتری دارند. برخی از آنها از اشتراک های phoneRule می آیند.';

  @override
  String get searchSubscriptionsHint => 'جستجو اشتراک ها';

  @override
  String get searchPluginsHint => 'جستجو افزونه ها';

  @override
  String get searchLabelsHint => 'جستجو برچسب ها';

  @override
  String get pluginDescription => 'توضیحات افزونه';

  @override
  String get enterPluginDescription => 'توضیحات افزونه را وارد کنید';

  @override
  String get searchRegexRulesHint => 'جستجو قوانین Regex';

  @override
  String get regexRulesInfo =>
      'قوانین Regex برای فیلتر کردن تماس ها بر اساس الگوهای Regex استفاده می شوند.';

  @override
  String get searchMarkedPhonesHint => 'جستجو شماره های علامت گذاری شده';

  @override
  String get searchContactSubscriptionsHint => 'جستجو اشتراک های تماس';

  @override
  String get showAllContacts => 'نمایش همه مخاطبین';

  @override
  String get showFavorites => 'نمایش موارد دلخواه';

  @override
  String get manualEntry => 'اطلاعات ورود دستی';

  @override
  String get scriptSaved => 'اسکریپت ذخیره شد';

  @override
  String editScriptFor(String pluginName) {
    return 'ویرایش اسکریپت برای $pluginName';
  }

  @override
  String get saveScript => 'ذخیره اسکریپت';

  @override
  String get testPlugin => 'آزمایش افزونه';

  @override
  String get description => 'توضیحات';

  @override
  String get accessTargetUrl => 'دسترسی به URL هدف';

  @override
  String get result => 'نتیجه';

  @override
  String get editScript => 'ویرایش اسکریپت';

  @override
  String get numberFormat => 'فرمت شماره';

  @override
  String get nationalNumber => 'شماره ملی';

  @override
  String get e164Number => 'شماره E164';

  @override
  String get pluginRulesInfo =>
      'برای امنیت، لطفاً فقط از افزونه های منابع معتبر استفاده کنید. در استفاده از قالب های ما برای ایجاد افزونه های سفارشی خود آزاد باشید!';

  @override
  String get advancedMode => 'حالت پیشرفته';

  @override
  String get pleaseEnterAtLeastOneNumber => 'لطفاً حداقل یک شماره وارد کنید.';

  @override
  String get openInWebView => 'باز کردن در WebView';

  @override
  String get pluginLabel => 'برچسب افزونه';

  @override
  String get pluginID => 'شناسه';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'رنگ پس زمینه پیام';

  @override
  String get clearAllCallLogs => 'پاک کردن همه گزارش های تماس';

  @override
  String get clearAllCallLogsConfirmation =>
      'تایید برای پاک کردن همه گزارش های تماس';

  @override
  String get allCallLogsCleared => 'همه گزارش های تماس پاک شدند';

  @override
  String get unblocked => 'مسدود نشده';

  @override
  String get blockNumber => 'مسدود کردن شماره';

  @override
  String get blockNumberSuccess => 'مسدود کردن شماره موفقیت آمیز بود';

  @override
  String get blockNumberFailed => 'مسدود کردن شماره ناموفق بود';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'آیا مطمئن هستید که می خواهید $phoneNumber را از مسدودیت خارج کنید؟';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'در حال تماس با $phoneNumber...';
  }

  @override
  String get viewDetails => 'مشاهده جزئیات';

  @override
  String get unblock => 'رفع مسدودیت';

  @override
  String get unblockNumber => 'رفع مسدودیت شماره';

  @override
  String get unblockNumberSuccess => 'شماره با موفقیت از مسدودیت خارج شد';

  @override
  String get unblockNumberFailed => 'رفع مسدودیت شماره ناموفق بود';

  @override
  String get serviceNotAvailable => 'سرویس در دسترس نیست';

  @override
  String get callingNumberFailed => 'تماس با شماره ناموفق بود';

  @override
  String get listView => 'نمای لیست';

  @override
  String get timelineView => 'نمای خط زمانی';

  @override
  String get nameCannotBeEmpty => 'نام نمی تواند خالی باشد';

  @override
  String get selectAction => 'اقدام را انتخاب کنید';

  @override
  String get selectTargetService => 'سرویس هدف را انتخاب کنید';

  @override
  String get callDetails => 'جزئیات تماس';

  @override
  String get callType => 'نوع تماس';

  @override
  String get callTime => 'زمان تماس';

  @override
  String get numberInvalidFormat => 'فرمت شماره نامعتبر است';

  @override
  String get membershipFeature => 'ویژگی عضویت';

  @override
  String get medium => 'متوسط';

  @override
  String get verificationReport => 'گزارش تأیید';

  @override
  String get finalRisk => 'ریسک نهایی';

  @override
  String get simState => 'وضعیت سیم کارت';

  @override
  String get ipCountry => 'کشور IP';

  @override
  String get simCountry => 'کشور سیم کارت';

  @override
  String get isRoaming => 'در حال رومینگ';

  @override
  String get isNumberMatch => 'تطابق شماره';

  @override
  String get support => 'پشتیبانی';

  @override
  String get rewardedAdService => 'سرویس تبلیغات پاداش';

  @override
  String get hasVipPrivilegeExceptAds =>
      'شما از قبل دارای امتیازات VIP (به جز تبلیغات) هستید';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'شما از قبل دارای امتیازات موقت هستید، تاریخ انقضا: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'برای دریافت امتیازات VIP موقت باید $count تبلیغ دیگر تماشا کنید';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'شما $days روز امتیاز خرید موقت دریافت کرده اید. تاریخ انقضا: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'امتیاز خرید موقت منقضی شده است';

  @override
  String get loadingAd => 'در حال بارگذاری تبلیغ...';

  @override
  String get earnedTempVip => 'VIP موقت دریافت شد';

  @override
  String get vipExchangeService => 'سرویس تبادل VIP';

  @override
  String get marksInsufficient => 'نشان کافی برای تبادل وجود ندارد';

  @override
  String get invalidExchangeRule => 'قانون تبادل نامعتبر';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'با موفقیت برای $description تبادل شد، تاریخ انقضا: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'تبادل ناموفق: $error';
  }

  @override
  String get vip3DaysWithAds => 'VIP 3 روزه با تبلیغات (فقط همگام سازی)';

  @override
  String get vip5DaysNoAds => 'VIP 5 روزه کامل بدون تبلیغات';

  @override
  String get vip7DaysNoAds => 'VIP 7 روزه کامل بدون تبلیغات';

  @override
  String get noNotifications => 'بدون اعلان';

  @override
  String get clearAllNotifications => 'پاک کردن همه اعلان ها';

  @override
  String get clearAllNotificationsConfirmation =>
      'تایید برای پاک کردن همه اعلان ها';

  @override
  String get allNotificationsCleared => 'تم مسح جميع الإشعارات';

  @override
  String get clearButton => 'مسح';

  @override
  String get justNow => 'مباشرة الآن';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دقائق مضت',
      one: 'دقيقة واحدة مضت',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ساعات مضت',
      one: 'ساعة واحدة مضت',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أيام مضت',
      one: 'يوم واحد مضى',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'الأمس';

  @override
  String get deletionProposal => 'اقتراح الحذف';

  @override
  String get deletionProposals => 'اقتراحات الحذف';

  @override
  String get createProposal => 'إنشاء اقتراح';

  @override
  String get createProposalTitle => 'إنشاء اقتراح حذف';

  @override
  String get reason => 'السبب';

  @override
  String get reasonOutdated => 'الرقم قديم';

  @override
  String get reasonPrivacy => 'قضية خصوصية';

  @override
  String get reasonNotInService => 'ليس قيد الخدمة';

  @override
  String get reasonWronglyIdentified => 'تم التعرف عليه بشكل خاطئ';

  @override
  String get reasonInaccurateInfo => 'معلومات غير دقيقة';

  @override
  String get reasonWrongMarked => 'تم وضع علامة خاطئة';

  @override
  String get reasonOther => 'أخرى';

  @override
  String get submit => 'إرسال';

  @override
  String get cancel => 'إلغاء';

  @override
  String get proposalStatus => 'الحالة';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusActive => 'نشط';

  @override
  String get statusCompleted => 'مكتمل';

  @override
  String get statusExpired => 'منتهي الصلاحية';

  @override
  String get riskLevel => 'مستوى المخاطرة';

  @override
  String get riskLevelVerified => 'تم التحقق منه';

  @override
  String get riskLevelLow => 'منخفض';

  @override
  String get riskLevelHigh => 'مرتفع';

  @override
  String get riskLevelUnknown => 'غير معروف';

  @override
  String get votingProgress => 'تقدم التصويت';

  @override
  String agreeVotes(int count) {
    return 'الموافقة: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'المعارضة: $count';
  }

  @override
  String totalVotes(int count) {
    return 'الإجمالي: $count';
  }

  @override
  String get voteAgree => 'موافقة';

  @override
  String get voteDisagree => 'معارضة';

  @override
  String createdAt(String date) {
    return 'تم الإنشاء: $date';
  }

  @override
  String get showReport => 'إظهار التقرير';

  @override
  String get hideReport => 'إخفاء التقرير';

  @override
  String get proposalStatistics => 'إحصائيات الاقتراح';

  @override
  String get totalProposals => 'إجمالي الاقتراحات';

  @override
  String get activeProposals => 'الاقتراحات النشطة';

  @override
  String get completedProposals => 'الاقتراحات المكتملة';

  @override
  String get myVotes => 'أصواتي';

  @override
  String get proposalCreated => 'تم إنشاء الاقتراح بنجاح';

  @override
  String get proposalCreateFailed => 'فشل إنشاء الاقتراح';

  @override
  String get voteSubmitted => 'تم تقديم التصويت بنجاح';

  @override
  String get voteSubmitFailed => 'فشل تقديم التصويت';

  @override
  String get noProposalsFound => 'لم يتم العثور على اقتراحات';

  @override
  String get loadingProposals => 'جاري تحميل الاقتراحات...';

  @override
  String get refreshProposals => 'تحديث الاقتراحات';

  @override
  String get totalPendingProposals => 'إجمالي الاقتراحات قيد الانتظار';

  @override
  String get highRisk => 'مخاطرة عالية';

  @override
  String get mediumRisk => 'مخاطرة متوسطة';

  @override
  String get lowRisk => 'مخاطرة منخفضة';

  @override
  String get communityImpact => 'تأثير المجتمع';

  @override
  String get criticalIssues => 'مشاكل حرجة';

  @override
  String get communityParticipation => 'مشاركة المجتمع';

  @override
  String get noActivity => 'لا يوجد نشاط';

  @override
  String get low => 'منخفض';

  @override
  String get moderate => 'متوسط';

  @override
  String get high => 'مرتفع';

  @override
  String get veryHigh => 'مرتفع جداً';

  @override
  String get voted => 'تم التصويت';

  @override
  String get communityVotes => 'أصوات المجتمع';

  @override
  String get waitingForMoreVotes => 'في انتظار المزيد من أصوات المجتمع';

  @override
  String get proposalProcessed => 'تم معالجة هذا الاقتراح';

  @override
  String get supported => 'مدعوم';

  @override
  String get opposed => 'معارض';

  @override
  String get approved => 'موافق عليه';

  @override
  String get rejected => 'مرفوض';

  @override
  String get completed => 'مكتمل';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get critical => 'حرج';

  @override
  String get oppose => 'معارضة';

  @override
  String get veryLow => 'منخفض جداً';

  @override
  String get deletionProposalNotificationDescription =>
      'إشعارات حول نتائج وتحديثات تصويت اقتراحات الحذف.';

  @override
  String get deletionProposalCreated => 'تم إنشاء اقتراح حذف';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'تم تقديم اقتراح الحذف الخاص بك للرقم $phoneNumber لمراجعة المجتمع.';
  }

  @override
  String get proposalApproved => 'تمت الموافقة على الاقتراح ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'تمت الموافقة على اقتراح الحذف للرقم $phoneNumber من قبل المجتمع ($supportPercentage% دعم، $totalVotes صوت).';
  }

  @override
  String get proposalRejected => 'تم رفض الاقتراح ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'تم رفض اقتراح الحذف للرقم $phoneNumber من قبل المجتمع ($supportPercentage% دعم، $totalVotes صوت).';
  }

  @override
  String get communityVotingStarted => 'بدأ تصويت المجتمع';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'اقتراح حذف جديد للرقم $phoneNumber مفتوح الآن لتصويت المجتمع.';
  }

  @override
  String get votingCompleted => 'اكتمل التصويت';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'انتهى تصويت المجتمع للرقم $phoneNumber. النتيجة: $result ($supportPercentage% دعم).';
  }

  @override
  String get newVoteReceived => 'تم استلام تصويت جديد';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'صوت شخص ما لـ $voteType حذف الرقم $phoneNumber. الأصوات الحالية: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'فشل تحميل عدد الأصوات';

  @override
  String get voteCount => 'عدد الأصوات';

  @override
  String get deletionProposalInfo => 'معلومات اقتراح الحذف';

  @override
  String get deletionProposalDescription =>
      'اقترح أرقامًا للحذف تنتهك إرشادات المجتمع. مشاركتك تساعد في الحفاظ على أمان المنصة.';

  @override
  String get voteToEarnVip => 'صوّت على الاقتراحات لكسب امتيازات VIP!';

  @override
  String get voteFailed => 'فشل التصويت';

  @override
  String get searchProposals => 'بحث عن الاقتراحات';

  @override
  String get defaultNotifications => 'الإشعارات الافتراضية';

  @override
  String get defaultNotificationsDescription =>
      'قناة الإشعارات الافتراضية للتطبيق.';

  @override
  String get blockedCallNotifications => 'إشعارات المكالمات المحظورة';

  @override
  String get blockedCallNotificationsDescription =>
      'اطلاعات مربوط به تماس‌های مسدود شده را نمایش می‌دهد.';

  @override
  String get stirVerification => 'تأیید STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'نتایج تأیید STIR/SHAKEN را برای شماره‌ها نمایش می‌دهد.';

  @override
  String get fraudAlerts => 'هشدار تقلب';

  @override
  String get fraudAlertsDescription =>
      'هشدارها را برای تماس‌های بالقوه تقلبی نمایش می‌دهد.';

  @override
  String get notificationFrequencyDescription =>
      'انتخاب کنید که هر چند وقت یکبار اعلان‌هایی در مورد پیشنهادات حذف جدید دریافت کنید. می‌توانید آن‌ها را بلافاصله، در دسته‌های دسته‌بندی شده، یا در یک بازه زمانی سفارشی دریافت کنید.';

  @override
  String get immediateNotifications => 'فوری';

  @override
  String get immediateNotificationsDescription =>
      'به محض ایجاد یک پیشنهاد، اعلان دریافت کنید.';

  @override
  String get batchNotifications => 'دسته‌ای';

  @override
  String get batchNotificationsDescription =>
      'خلاصه‌ای از اعلان‌ها را به صورت دوره‌ای دریافت کنید.';

  @override
  String get customNotifications => 'سفارشی';

  @override
  String get customNotificationsDescription =>
      'بازه زمانی دلخواه خود را برای دریافت اعلان‌ها تعریف کنید.';

  @override
  String get customFrequency => 'بازه زمانی سفارشی';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes دقیقه';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours ساعت';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours ساعت $minutes دقیقه';
  }

  @override
  String get pendingProposals => 'پیشنهادات در انتظار';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count پیشنهاد در انتظار',
      one: '1 پیشنهاد در انتظار',
      zero: 'پیشنهاد در انتظاری ندارید',
    );
    return 'شما $_temp0 دارید.';
  }

  @override
  String get guidelinesLabel => 'دستورالعمل‌ها';

  @override
  String get reportingGuidelines =>
      '• فقط شماره‌هایی را گزارش دهید که واقعاً مشکل‌ساز هستند\n• دلایل دقیق و جزئی ارائه دهید\n• سطح ریسک مناسب را بر اساس شدت انتخاب کنید\n• گزارش‌های نادرست ممکن است منجر به محدودیت حساب شود';

  @override
  String get riskLevelLabel => 'سطح ریسک';

  @override
  String get riskLevelDescription => 'سطح ریسک شماره';

  @override
  String get phoneNumberMinDigits => 'شماره تلفن باید حداقل 7 رقم باشد';

  @override
  String get provideDetailedExplanation =>
      'یک توضیح دقیق ارائه دهید (حداقل 10 کاراکتر)';

  @override
  String get reasonMinCharacters => 'دلیل باید حداقل 10 کاراکتر باشد';

  @override
  String get countryCodeTwoLetters => 'کد کشور (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'کد کشور (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'مثال: US، CN، GB';

  @override
  String get countryCodeRequired => 'کد کشور الزامی است';

  @override
  String get countryCodeLengthError => 'کد کشور باید 2 حرف باشد';

  @override
  String get phoneNumberLengthError => 'شماره تلفن باید حداقل 7 رقم باشد';

  @override
  String get reasonHint => 'توضیح دقیق ارائه دهید (حداقل 10 کاراکتر)';

  @override
  String get reasonRequired => 'دلیل الزامی است';

  @override
  String get reasonLengthError => 'دلیل باید حداقل 10 کاراکتر باشد';

  @override
  String get guidelinesTitle => 'دستورالعمل‌ها';

  @override
  String get guidelinesText =>
      '• فقط شماره‌هایی را گزارش دهید که واقعاً مشکل‌ساز هستند\n• دلایل دقیق و جزئی ارائه دهید\n• سطح ریسک مناسب را بر اساس شدت انتخاب کنید\n• گزارش‌های نادرست ممکن است منجر به محدودیت حساب شود';

  @override
  String get riskLevelCritical => 'بحرانی';

  @override
  String get riskLevelMedium => 'متوسط';

  @override
  String get riskLevelVeryLow => 'بسیار کم';

  @override
  String get riskDescriptionVeryLow => 'بسیار کم - آزار جزئی، تماس‌های نامنظم';

  @override
  String get riskDescriptionLow => 'کم - تماس‌های ناخواسته گاه به گاه';

  @override
  String get riskDescriptionMedium => 'متوسط - اسپم یا تلفن مارکتینگ منظم';

  @override
  String get riskDescriptionHigh =>
      'زیاد - مزاحمت مداوم یا تلاش برای کلاهبرداری';

  @override
  String get riskDescriptionCritical =>
      'بحرانی - کلاهبرداری‌های خطرناک یا تهدید';

  @override
  String get notificationFrequencyTitle => 'بازه زمانی اعلان';

  @override
  String get notificationFrequencyLabel => 'بازه زمانی اعلان (ساعت)';

  @override
  String errorMessage(String error) {
    return 'خطا: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'آراء: $totalVotes ($supportPercentage% حمایت)';
  }

  @override
  String supportCount(int supportCount) {
    return 'حمایت ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'مخالفت ($opposeCount)';
  }

  @override
  String get timeJustNow => 'همین الان';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes دقیقه پیش';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours ساعت پیش';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days روز پیش';
  }

  @override
  String get notificationFrequencyHours => 'بازه زمانی اعلان (ساعت)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes رای ($supportPercentage% حمایت)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ساعت',
      one: '1 ساعت',
      zero: '0 ساعت',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'اطلاعیه مهم';

  @override
  String get dataSourceDisclaimer =>
      'شماره‌ها از اینترنت و ارسالی‌های کاربر جمع‌آوری شده‌اند. ما نمی‌توانیم تضمین کنیم که یک شماره پس از حذف مجدداً توسط سایر کاربران یا منابع ارسال نشود. لطفاً فعالانه اطلاعات را جستجو و تأیید کنید.';

  @override
  String get avatar => 'آواتار';

  @override
  String get location => 'مکان';

  @override
  String get simCardTitle => 'سیم کارت';

  @override
  String get liveActivitiesSettingsTitle => 'تنظیمات فعالیت‌های زنده';

  @override
  String get elementsSettingsTitle => 'تنظیمات عناصر';

  @override
  String get liveActivityMode => 'فعالیت زنده';

  @override
  String get liveActivityModeDescription =>
      'اطلاعات تماس را به صورت اعلان دائمی در صفحه قفل و جزیره پویا (iOS) نمایش می‌دهد.';

  @override
  String get phoneNumberType => 'نوع شماره تلفن';

  @override
  String get liveActivitiesTestEndActivity => 'پایان فعالیت';

  @override
  String get liveActivitiesTestSendNewActivity => 'ارسال فعالیت جدید';

  @override
  String get liveActivitiesTestUpdateActivity => 'به‌روزرسانی فعالیت';

  @override
  String get liveActivityControlsTitle => 'کنترل‌های فعالیت زنده';

  @override
  String get liveActivitiesTestTitle => 'تست فعالیت‌های زنده';

  @override
  String get liveActivitiesTestSubtitle => 'اعلان فعالیت زنده را تست کنید.';

  @override
  String get liveNotificationCustomizationTitle => 'سفارشی‌سازی اعلان زنده';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'ظاهر اعلان‌های زنده را سفارشی کنید.';

  @override
  String get notification_instructions =>
      'دستورالعمل‌ها:\n1. روی \"ارسال\" ضربه بزنید تا اعلان ایجاد یا به‌روزرسانی شود.\n2. به صفحه اصلی بروید یا سینی اعلان را به سمت پایین بکشید تا نتیجه را ببینید.\n3. برای رد کردن اعلان، روی \"پایان\" ضربه بزنید.';

  @override
  String get autoCancelNotification => 'لغو خودکار اعلان';

  @override
  String get autoCancelNotificationDescription =>
      'اگر علامت زده شود، اعلان به طور خودکار هنگام ضربه زدن کاربر لغو می‌شود.';

  @override
  String get setDelayTime => 'تنظیم زمان تأخیر';

  @override
  String get proposalDetails => 'جزئیات پیشنهاد';

  @override
  String get filterByStatus => 'فیلتر بر اساس وضعیت';

  @override
  String get proposalNotFound => 'پیشنهاد یافت نشد';

  @override
  String get processed => 'پردازش شده';

  @override
  String get showAll => 'نمایش همه';

  @override
  String get filterAndSortTitle => 'فیلتر و مرتب‌سازی';

  @override
  String get filterVerifiedOwner => 'فیلتر مالک تأیید شده';

  @override
  String get filterBy => 'فیلتر بر اساس';

  @override
  String get sortOldest => 'قدیمی‌ترین';

  @override
  String get sortNewest => 'جدیدترین';

  @override
  String get sortMostPopular => 'محبوب‌ترین';

  @override
  String get sortLeastPopular => 'کمترین محبوبیت';

  @override
  String get sortBy => 'مرتب‌سازی بر اساس';

  @override
  String get simRulesNotFound => 'قوانین سیم کارت یافت نشد';

  @override
  String get simSlotRules => 'قوانین اسلات سیم کارت';

  @override
  String get noSimCardDetected => 'سیم کارت شناسایی نشد';

  @override
  String get invalidSimData => 'داده‌های سیم کارت نامعتبر';

  @override
  String get simCardData => 'داده‌های سیم کارت';

  @override
  String get simSlot => 'اسلات سیم کارت';

  @override
  String get enableFiltering => 'فعال کردن فیلتر';

  @override
  String get detailedSettingsTitle => 'تنظیمات دقیق';

  @override
  String get entryPointViewTitle => 'نمای نقطه ورود';

  @override
  String get callTypeRejected => 'رد شده';

  @override
  String get callTypeSilenced => 'بی‌صدا شده';

  @override
  String get callTypeVoicemail => 'پیام صوتی';

  @override
  String get callTypeUnknownIntercept => 'رهگیری ناشناخته';

  @override
  String andMoreItems(int count) {
    return 'و $count مورد دیگر';
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
  String get configSaved => 'Configuration Saved!';

  @override
  String get masterDeviceLabel => 'Is Master Device (Admin)';

  @override
  String get masterDeviceHelp =>
      'Only the master device can initialize the database structure.';
}
