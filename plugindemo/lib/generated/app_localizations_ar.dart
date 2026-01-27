// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get aboutContactSubscription => 'حول اشتراك جهة الاتصال';

  @override
  String get aboutLabels => 'حول العلامات';

  @override
  String get aboutPhoneSubscriptionRules => 'حول قواعد اشتراك الهاتف';

  @override
  String get aboutPhoneSubscriptions => 'حول اشتراكات الهاتف';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'اشترك في قوائم قواعد الهاتف عبر عنوان URL، قم بتحديث القواعد تلقائيًا. يدعم ملفات قواعد بتنسيق JSON و CSV.';

  @override
  String get aboutSmsFilter => 'حول تصفية الرسائل القصيرة';

  @override
  String get aboutSmsSubscriptionRules => 'حول قواعد اشتراك الرسائل القصيرة';

  @override
  String get aboutSubtitle => 'معلومات الإصدار القانوني للتطبيق';

  @override
  String get aboutTitle => 'حول';

  @override
  String get action => 'الإجراء';

  @override
  String get actionAll => 'الكل';

  @override
  String get actionAllow => 'السماح';

  @override
  String get actionBlock => 'الحظر';

  @override
  String get actionFilterAll => 'كل المرشحات';

  @override
  String get actionFilterTitle => 'التصفية حسب نوع الإجراء';

  @override
  String get actionFilterTooltip => 'مرشح الإجراء';

  @override
  String get actionNone => 'لا إجراء';

  @override
  String get actionSilence => 'كتم';

  @override
  String actionTag(Object actionType) {
    return 'الإجراء: $actionType';
  }

  @override
  String get actionType => 'نوع الإجراء';

  @override
  String get actionUnknown => 'غير معروف';

  @override
  String get add => 'إضافة';

  @override
  String get addAllowedBlockedRule => 'إضافة قاعدة السماح/الحظر';

  @override
  String get addAllowSubscription => 'إضافة اشتراك سماح';

  @override
  String get addBlockSubscription => 'إضافة اشتراك حظر';

  @override
  String get addContactButton => 'إضافة جهة اتصال';

  @override
  String addContactFailed(Object error) {
    return 'فشل في إضافة جهة الاتصال: $error';
  }

  @override
  String get addedToAllowedRules => 'تمت الإضافة إلى قواعد السماح';

  @override
  String get addedToBlacklist => 'تمت الإضافة إلى القائمة السوداء';

  @override
  String get addedToBlockedRules => 'تمت الإضافة إلى قواعد الحظر';

  @override
  String get addedToFavoriteContacts => 'تمت الإضافة إلى جهات الاتصال المفضلة';

  @override
  String get addedToFavorites => 'تمت الإضافة إلى المفضلة';

  @override
  String get addedToWhitelist => 'تمت الإضافة إلى القائمة البيضاء';

  @override
  String get addFavorite => 'إضافة مفضلة';

  @override
  String get addFilter => 'إضافة مرشح';

  @override
  String get addLabel => 'إضافة علامة';

  @override
  String get addLabelButton => 'إضافة علامة';

  @override
  String addLabelFailed(Object error) {
    return 'فشل في إضافة علامة: $error';
  }

  @override
  String get addLabelToCall => 'إضافة علامة لسجل المكالمات';

  @override
  String get addName => 'إضافة اسم';

  @override
  String get addNoneSubscription => 'إضافة اشتراك لا شيء';

  @override
  String get addOrEditContactInfo =>
      'يُستخدم لإضافة أو تعديل معلومات جهة الاتصال';

  @override
  String get addPhoneMark => 'إضافة علامة هاتف';

  @override
  String get addPhoneNumberRule => 'إضافة قاعدة رقم هاتف';

  @override
  String get addPlugin => 'إضافة مكون إضافي';

  @override
  String get addPluginFailed => 'فشل في إضافة المكون الإضافي';

  @override
  String addPluginFailedWithError(Object error) {
    return 'فشل في إضافة المكون الإضافي: $error';
  }

  @override
  String get addPluginFromLocalFile => 'إضافة مكون إضافي من ملف محلي';

  @override
  String get addPluginFromUrl => 'إضافة مكون إضافي من عنوان URL';

  @override
  String get addRegexRule => 'إضافة قاعدة تعبير عادي';

  @override
  String get addRule => 'إضافة قاعدة';

  @override
  String get addRuleButton => 'إضافة قاعدة';

  @override
  String addRuleFailed(Object error) {
    return 'فشل في إضافة قاعدة: $error';
  }

  @override
  String get addRuleTooltip => 'إضافة قاعدة';

  @override
  String get addSilenceSubscription => 'إضافة اشتراك صامت';

  @override
  String get addSimRuleButton => 'إضافة قاعدة SIM';

  @override
  String get addSmsFilterRule => 'إضافة قاعدة تصفية رسائل قصيرة';

  @override
  String get addSmsRule => 'إضافة قاعدة رسائل قصيرة';

  @override
  String get addSmsSubscription => 'إضافة اشتراك رسائل قصيرة';

  @override
  String get addSubscription => 'إضافة اشتراك';

  @override
  String get addSubscriptionButton => 'إضافة اشتراك';

  @override
  String addSubscriptionFailed(Object error) {
    return 'فشل في إضافة اشتراك: $error';
  }

  @override
  String get addSubscriptionTooltip => 'إضافة اشتراك';

  @override
  String get addToAllowedRules => 'إضافة إلى قواعد السماح';

  @override
  String get addToBlacklist => 'إضافة إلى القائمة السوداء';

  @override
  String get addToBlockedRules => 'إضافة إلى قواعد الحظر';

  @override
  String get addToFavoriteContacts => 'إضافة إلى جهات الاتصال المفضلة';

  @override
  String get addToFavorites => 'إضافة إلى المفضلة';

  @override
  String get addToRules => 'إضافة إلى القواعد';

  @override
  String get addToWhitelist => 'إضافة إلى القائمة البيضاء';

  @override
  String get adPlaceholder => 'موضع إعلان';

  @override
  String get agent => 'وكيل';

  @override
  String get all => 'الكل';

  @override
  String get allCallsTab => 'الكل';

  @override
  String get allDataClearedSuccessfully => 'تم مسح جميع البيانات بنجاح';

  @override
  String get allow => 'السماح';

  @override
  String get allowAllAllowRules => 'السماح لجميع قواعد السماح';

  @override
  String get allowAllAllowRulesDesc => 'السماح بالمكالمات من قواعد السماح';

  @override
  String get allowAllBlacklistedNumbers => 'السماح لجميع الأرقام المحظورة';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'السماح بالمكالمات من القائمة السوداء';

  @override
  String get allowAllBlockRules => 'السماح لجميع قواعد الحظر';

  @override
  String get allowAllBlockRulesDesc => 'السماح بالمكالمات من قواعد الحظر';

  @override
  String get allowAllowedNumbers => 'السماح للأرقام المسموح بها';

  @override
  String get allowAllowedNumbersDesc => 'السماح بالمكالمات من القائمة البيضاء';

  @override
  String get allowBlock => 'السماح/الحظر';

  @override
  String get allowBlockedNumbers => 'السماح للأرقام المحظورة';

  @override
  String get allowBlockedNumbersDesc => 'السماح بالمكالمات من القائمة السوداء';

  @override
  String get allowedBlockedRule => 'قاعدة السماح/الحظر';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'تعديل قاعدة السماح/الحظر';

  @override
  String get allowedBlockedRuleManagement => 'إدارة قواعد السماح/الحظر';

  @override
  String get allowNonExceededNumbers => 'السماح للأرقام التي لم تتجاوز الحد';

  @override
  String get allowNonExceededNumbersDescription =>
      'السماح تلقائيًا بالأرقام التي لا تتجاوز حد العد';

  @override
  String get allowRegexAllowRules => 'السماح لقواعد التعبير العادي';

  @override
  String get allowRegexAllowRulesDesc =>
      'تمكين مطابقة نمط التعبير العادي لقواعد السماح';

  @override
  String get allowRegexAllowRulesDescription =>
      'تمكين قواعد السماح المستندة إلى التعبير العادي';

  @override
  String get allowRegexBlockRules => 'السماح لقواعد حظر التعبير العادي';

  @override
  String get allowRegexBlockRulesDesc =>
      'تمكين مطابقة نمط التعبير العادي لقواعد الحظر';

  @override
  String get allowRegexBlockRulesDescription =>
      'تمكين قواعد الحظر المستندة إلى التعبير العادي';

  @override
  String get allowRule => 'قاعدة السماح';

  @override
  String get allowRules => 'قواعد السماح';

  @override
  String get allowWhitelistedNumbers =>
      'السماح للأرقام المدرجة في القائمة البيضاء';

  @override
  String get allowWhitelistedNumbersDescription =>
      'السماح لجميع الأرقام في القائمة البيضاء';

  @override
  String get allPermissionsGranted => 'تم منح جميع الأذونات';

  @override
  String get allSettingsCompleted => 'اكتملت جميع الإعدادات.';

  @override
  String allUpdateSuccess(Object count) {
    return 'اكتملت جميع التحديثات ($count قواعد)';
  }

  @override
  String get answerThenHangup => 'الرد ثم إنهاء المكالمة';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. جميع الحقوق محفوظة.';

  @override
  String get applicationSoftware => 'برنامج التطبيق';

  @override
  String get apply => 'تطبيق';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'فشل التفويض: يرجى التحقق من معرف العميل والمفتاح';

  @override
  String get authorizationFailedMessage => 'فشل التفويض';

  @override
  String get authorizationSuccessMessage => 'نجح التفويض';

  @override
  String get authorizeLoginButton => 'تفويض تسجيل الدخول';

  @override
  String get automotiveIndustry => 'صناعة السيارات';

  @override
  String get autoSyncLabel => 'المزامنة التلقائية';

  @override
  String get autoUpdate => 'التحديث التلقائي';

  @override
  String get autoUpdateDescription =>
      'ضبط فترات التحديث التلقائي للاشتراكات أو التحديث يدويًا';

  @override
  String get autoUpdateSettings => 'إعدادات التحديث التلقائي';

  @override
  String get autoUpdateSettingsSubtitle =>
      'إدارة التحديثات التلقائية للقواعد والإضافات';

  @override
  String get autoUpdateSettingsTitle => 'إعدادات التحديث التلقائي';

  @override
  String get autoUpdateSubtitle =>
      'إدارة التحديثات التلقائية للقواعد والإضافات';

  @override
  String get autoUpdateTitle => 'التحديث التلقائي';

  @override
  String get avatarBorderColor => 'لون حدود الصورة الرمزية';

  @override
  String get avatarBorderSize => 'حجم حدود الصورة الرمزية';

  @override
  String get avatarIconSizesSetting => 'أحجام الصور الرمزية والأيقونات';

  @override
  String get avatarPosition => 'موضع الصورة الرمزية';

  @override
  String get avatarSize => 'حجم الصورة الرمزية';

  @override
  String axisPosition(Object axis) {
    return 'موضع $axis';
  }

  @override
  String get backgroundGradientSetting => 'تدرج الخلفية';

  @override
  String get backup => 'نسخ احتياطي';

  @override
  String get backupAndRestore => 'النسخ الاحتياطي والاستعادة';

  @override
  String get backupAndRestoreSubtitle =>
      'نسخ بيانات التطبيق احتياطيًا أو استعادتها';

  @override
  String get backupAndRestoreTitle => 'النسخ الاحتياطي والاستعادة';

  @override
  String get backupFailed => 'فشل النسخ الاحتياطي';

  @override
  String get backupFailedMessage => 'فشل النسخ الاحتياطي';

  @override
  String backupFailedWithError(Object error) {
    return 'فشل النسخ الاحتياطي: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'نسخ بيانات التطبيق احتياطيًا أو استعادتها';

  @override
  String get backupRestoreTitle => 'النسخ الاحتياطي والاستعادة';

  @override
  String get backupSectionTitle => 'نسخ احتياطي';

  @override
  String get backupSettings => 'إعدادات النسخ الاحتياطي';

  @override
  String get backupSettingsDialogTitle => 'إعدادات النسخ الاحتياطي';

  @override
  String get backupSettingsTitle => 'إعدادات النسخ الاحتياطي';

  @override
  String get backupSuccessMessage => 'تم النسخ الاحتياطي بنجاح إلى السحابة';

  @override
  String backupSuccessToLocal(Object path) {
    return 'تم النسخ الاحتياطي بنجاح إلى: $path';
  }

  @override
  String get backupToCloud => 'النسخ الاحتياطي إلى السحابة';

  @override
  String get backupToCloudDescription =>
      'نسخ الإعدادات والقواعد احتياطيًا إلى مساحة التخزين السحابية';

  @override
  String backupToCloudFailed(Object error) {
    return 'فشل النسخ الاحتياطي إلى السحابة: $error';
  }

  @override
  String get backupToCloudLabel => 'النسخ الاحتياطي إلى السحابة';

  @override
  String get backupToCloudSuccess => 'تم النسخ الاحتياطي بنجاح إلى السحابة';

  @override
  String get backupToCloudTitle => 'النسخ الاحتياطي إلى السحابة';

  @override
  String get backupToLocalLabel => 'النسخ الاحتياطي محليًا';

  @override
  String get bank => 'بنك';

  @override
  String get basicInfo => 'المعلومات الأساسية';

  @override
  String get basicRuleFilter => 'مرشح القاعدة الأساسي';

  @override
  String get basicRuleFiltering => 'تصفية القواعد الأساسية';

  @override
  String get basicRuleFilteringExplanation =>
      '• تصفية القواعد الأساسية: تصفية القواعد بناءً على القائمة السوداء والقائمة البيضاء والتعبيرات العادية';

  @override
  String get basicRuleFilterSettings => 'إعدادات مرشح القاعدة الأساسي';

  @override
  String get basicRuleFilterSubtitle =>
      'تصفية المكالمات باستخدام القائمة السوداء/البيضاء والتعبيرات العادية';

  @override
  String get batchDeleteContacts => 'حذف جهات الاتصال دفعة واحدة';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'هل أنت متأكد من رغبتك في حذف جهات الاتصال المحددة $count؟';
  }

  @override
  String get batchDeleteFailed => 'فشل الحذف دفعة واحدة';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'هل أنت متأكد من رغبتك في حذف التسميات $count؟';
  }

  @override
  String get blacklist => 'القائمة السوداء';

  @override
  String get blacklistingAndWhitelisting => 'القائمة السوداء والقائمة البيضاء';

  @override
  String get blacklistLabel => 'القائمة السوداء';

  @override
  String get blackWhiteList => 'القائمة السوداء/البيضاء';

  @override
  String get block => 'حظر';

  @override
  String get blockCalls => 'حظر المكالمات';

  @override
  String get blocked => 'محظور';

  @override
  String get blockedCallAction => 'إجراء المكالمة المحظورة';

  @override
  String get blockedCalls => 'المكالمات المحظورة';

  @override
  String get blockedCallsTitle => 'المكالمات المحظورة';

  @override
  String get blockedCommunications => 'الاتصالات المحظورة';

  @override
  String get blockedPhoneLabel => 'المكالمات المحظورة';

  @override
  String get blockedSpamCalls => 'مكالمات البريد العشوائي المحظورة';

  @override
  String get blockingTrend => 'اتجاه الحظر';

  @override
  String get blockInternationalCalls => 'يطابق الأرقام التي لا تبدأ بـ + أو 00';

  @override
  String get blockInternationalCallsTitle => 'حظر المكالمات الدولية';

  @override
  String get blockLandlineNumbersTitle => 'حظر أرقام الهواتف الثابتة';

  @override
  String get blockMobileNumbers => 'يطابق الأرقام التي لا تبدأ بـ 13-19';

  @override
  String get blockMobileNumbersTitle => 'حظر أرقام الهواتف المحمولة';

  @override
  String get blockPremiumRateNumbers =>
      'يطابق الأرقام التي لا تبدأ بـ 118 أو 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'حظر أرقام التعريفة المميزة';

  @override
  String get blockRule => 'قاعدة الحظر';

  @override
  String get blockRules => 'قواعد الحظر';

  @override
  String get blockSpecificAreaCodes =>
      'يطابق الأرقام التي تبدأ بـ 0 + 2-3 أرقام';

  @override
  String get blockSpecificAreaCodesTitle => 'حظر رموز المناطق المحددة:';

  @override
  String get blockTypeAnalysisTitle => 'تحليل نوع الحظر';

  @override
  String get both => 'كلاهما';

  @override
  String get bulkDelete => 'حذف دفعة واحدة لجهات الاتصال';

  @override
  String get bulkDeleteContacts => 'حذف جهات الاتصال دفعة واحدة';

  @override
  String get bulkDeleteLabels => 'حذف التسميات دفعة واحدة';

  @override
  String get call => 'مكالمة';

  @override
  String get callback => 'إعادة الاتصال';

  @override
  String callbackTo(String number) {
    return 'إعادة الاتصال بالرقم $number';
  }

  @override
  String get callBlocking => 'حظر المكالمات';

  @override
  String get callerIdApp => 'تطبيق هوية المتصل';

  @override
  String get callerIdCustomizationTitle => 'تخصيص هوية المتصل';

  @override
  String get callerIdDialogTitle => 'معلومات هوية المتصل';

  @override
  String get callerIdDisplayMode => 'وضع عرض معرف المتصل';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'مميز بواسطة $count';
  }

  @override
  String get callerIdPreview => 'معاينة معرف المتصل';

  @override
  String get callFilter => 'فلتر المكالمات';

  @override
  String get callFilterDescription =>
      'عند التمكين، يتم فحص المكالمات الواردة مقابل قائمة القواعد أدناه. لا تتم مزامنة قواعد تصفية المكالمات بين الأجهزة افتراضيًا.';

  @override
  String get callFilterRules => 'قواعد تصفية المكالمات';

  @override
  String get callFilterRulesDescription =>
      'تعيين قواعد أساسية لتصفية المكالمات';

  @override
  String get callFilterSettings => 'إعدادات تصفية المكالمات';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'تعيين حدود تكرار المكالمات وقواعد الحظر';

  @override
  String get callFrequencyInterceptionTitle => 'اعتراض تكرار المكالمات';

  @override
  String get callHistory => 'سجل المكالمات';

  @override
  String get callHistoryInfoDesc =>
      'هنا يظهر سجل مكالماتك، بما في ذلك المكالمات الواردة والصادرة والمفقودة.';

  @override
  String get callHistoryInfoTitle => 'سجل المكالمات';

  @override
  String callHistoryInitFailed(Object error) {
    return 'فشل تهيئة سجل المكالمات: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'فشل تحديث سجل المكالمات: $error';
  }

  @override
  String get callHistoryTab => 'سجل المكالمات';

  @override
  String get callHistoryTimelineEarlier => 'سابقًا';

  @override
  String get callHistoryTimelineToday => 'اليوم';

  @override
  String get callHistoryTimelineYesterday => 'أمس';

  @override
  String get callScreeningPermission => 'إذن فحص المكالمات';

  @override
  String get callScreeningPermissionDescription =>
      'يُستخدم لفحص وحظر المكالمات غير المرغوب فيها.';

  @override
  String get callScreeningPermissionNotGranted =>
      'لم يتم منح إذن فحص المكالمات، قد يؤثر على وظائف التطبيق.';

  @override
  String get callSettingsSubtitle => 'إعدادات معرف المتصل والتصفية والحظر';

  @override
  String get callSettingsTitle => 'إعدادات المكالمات';

  @override
  String get callStatistics => 'إحصائيات المكالمات';

  @override
  String get callTypeAnswered => 'تم الرد';

  @override
  String get callTypeBlocked => 'محظور';

  @override
  String get callTypeIconColor => 'لون أيقونة نوع المكالمة';

  @override
  String get callTypeMissed => 'مكالمة فائتة';

  @override
  String get callTypeOutgoing => 'صادرة';

  @override
  String get callTypePosition => 'موضع نوع المكالمة';

  @override
  String get callTypeUnknown => 'غير معروف';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get carRental => 'تأجير سيارات';

  @override
  String get carrier => 'مزود الخدمة';

  @override
  String get carrierColor => 'لون مزود الخدمة';

  @override
  String get carrierFontSize => 'حجم خط مزود الخدمة';

  @override
  String get carrierPosition => 'موضع مزود الخدمة';

  @override
  String get changeLabel => 'تغيير التسمية';

  @override
  String changePluginStatusFailed(Object error) {
    return 'فشل تغيير حالة المكون الإضافي: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'فشل تغيير حالة الاشتراك: $error';
  }

  @override
  String get changeTag => 'تغيير الوسم';

  @override
  String get charity => 'جمعيات خيرية';

  @override
  String chartMonthFormat(int month) {
    return 'الشهر $month';
  }

  @override
  String get chartOneDayAgo => 'قبل يوم واحد';

  @override
  String get chartOneMonthAgo => 'قبل شهر واحد';

  @override
  String get chartOneWeekAgo => 'قبل أسبوع واحد';

  @override
  String get chartTenDaysAgo => 'قبل 10 أيام';

  @override
  String get chartThreeDaysAgo => 'قبل 3 أيام';

  @override
  String get chartToday => 'اليوم';

  @override
  String get checkFileFormat => 'الرجاء التحقق من تنسيق الملف أو الأذونات';

  @override
  String checkPermissionFailed(Object error) {
    return 'فشل التحقق من الأذونات: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'اختر إجراء الاعتراض الافتراضي';

  @override
  String get clearAllData => 'مسح جميع البيانات';

  @override
  String get clearAllDataConfirmation =>
      'هل أنت متأكد أنك تريد مسح جميع بيانات التطبيق؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get clearAllDataDescription => 'مسح جميع بيانات التطبيق';

  @override
  String get clearAllDataLabel => 'مسح جميع البيانات';

  @override
  String get clearFilter => 'مسح الفلتر';

  @override
  String get clearLabelFilter => 'مسح فلتر التسميات';

  @override
  String get clearLabelFilterButton => 'مسح فلتر التسميات';

  @override
  String get closeButton => 'إغلاق';

  @override
  String get cloudSync => 'المزامنة السحابية';

  @override
  String get cloudSyncAndBackupTitle => 'المزامنة والنسخ الاحتياطي السحابي';

  @override
  String get cloudSyncSettingsSubtitle =>
      'تكوين WebDAV و OneDrive و Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'إعدادات المزامنة السحابية';

  @override
  String get cloudSyncTitle => 'المزامنة السحابية';

  @override
  String get collapseLabelSelector => 'طي محدد التسميات';

  @override
  String get collection => 'تحصيل الديون';

  @override
  String get colorPickerTitle => 'اختر اللون';

  @override
  String get configManagement => 'إدارة التكوين';

  @override
  String get configUpdated => 'تم تحديث التكوين';

  @override
  String get configurationAdvice =>
      'من خلال التكوين المناسب، يمكنك تعيين استراتيجيات تصفية مختلفة لبطاقات SIM الخاصة بالعمل والشخصية.';

  @override
  String get configureBackupOptions => 'تكوين خيارات النسخ الاحتياطي';

  @override
  String get configureBackupOptionsSubtitle => 'تكوين خيارات النسخ الاحتياطي';

  @override
  String get configureCloudSyncService => 'تكوين خدمة المزامنة السحابية';

  @override
  String get configureCloudSyncServiceHint =>
      'الرجاء تكوين خدمة مزامنة سحابية لتمكين المزامنة بين الأجهزة المتعددة.';

  @override
  String get configureCloudSyncServiceMessage =>
      'الرجاء تكوين خدمة مزامنة سحابية لتمكين المزامنة بين الأجهزة المتعددة.';

  @override
  String get configureSimCardFilterRules => 'تكوين قواعد فلتر بطاقة SIM';

  @override
  String get configureSyncServiceHint =>
      'الرجاء تكوين خدمة المزامنة في إعدادات المزامنة السحابية أولاً';

  @override
  String get confirm => 'تأكيد';

  @override
  String get confirmBatchDeleteContacts => 'هل أنت متأكد أنك تريد حذف المحدد';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get confirmDelete => 'تأكيد الحذف';

  @override
  String get confirmDeleteContact => 'هل أنت متأكد أنك تريد حذف';

  @override
  String get confirmDeleteContactName => 'تأكيد الحذف؟';

  @override
  String get confirmDeleteFilter => 'هل أنت متأكد أنك تريد حذف هذا الفلتر؟';

  @override
  String confirmDeleteLabel(Object name) {
    return 'هل أنت متأكد أنك تريد حذف التسمية \"$name\"؟';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'هل أنت متأكد أنك تريد حذف المكون الإضافي \"$name\"؟';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'هل أنت متأكد أنك تريد حذف $count مكونات إضافية؟';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'هل أنت متأكد أنك تريد حذف هذه القاعدة؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get confirmDeleteSelectedContacts =>
      'هل أنت متأكد من حذف جهات الاتصال المحددة؟';

  @override
  String get confirmDeleteSmsFilterRule =>
      'هل أنت متأكد أنك تريد حذف قاعدة فلتر الرسائل القصيرة هذه؟';

  @override
  String get confirmDeleteSmsRule =>
      'هل أنت متأكد أنك تريد حذف قاعدة الرسائل القصيرة هذه؟';

  @override
  String get confirmDeleteSubscription =>
      'هل أنت متأكد أنك تريد حذف هذا الاشتراك؟';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'هل أنت متأكد أنك تريد حذف $name؟';
  }

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get connectedStatus => 'متصل';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'فشل الاتصال: الرجاء التحقق من عنوان الخادم واسم المستخدم وكلمة المرور';

  @override
  String get connectionFailedMessage => 'فشل الاتصال';

  @override
  String get connectionStatusLabel => 'حالة الاتصال';

  @override
  String get connectionSuccessMessage => 'تم الاتصال بنجاح';

  @override
  String get contactAddSuccess => 'تمت إضافة جهة الاتصال بنجاح';

  @override
  String get contactDeleted => 'تم حذف جهة الاتصال';

  @override
  String get contactEditDialog => 'مربع حوار تعديل جهة الاتصال';

  @override
  String get contactNameHint => 'أدخل اسم جهة الاتصال (اختياري)';

  @override
  String get contactNameLabel => 'الاسم';

  @override
  String get contactNameOptional => 'اسم جهة الاتصال (اختياري)';

  @override
  String get contactNotFound => 'لم يتم العثور على جهة الاتصال';

  @override
  String get contacts => 'جهات الاتصال';

  @override
  String contactsDeleted(Object count) {
    return 'تم حذف $count جهات اتصال';
  }

  @override
  String get contactSettingsSubtitle => 'إدارة جهات الاتصال وإعدادات الملصقات';

  @override
  String get contactSettingsTitle => 'إعدادات جهات الاتصال';

  @override
  String contactsLoadingFailed(Object error) {
    return 'فشل تحميل جهات الاتصال: $error';
  }

  @override
  String get contactsManagement => 'إدارة جهات الاتصال';

  @override
  String get contactsManagementPageTitle => 'صفحة إدارة جهات الاتصال';

  @override
  String get contactsPageTitle => 'إدارة جهات الاتصال';

  @override
  String get contactsPermission => 'إذن جهات الاتصال';

  @override
  String get contactsPermissionDescription =>
      'يُستخدم لتحديد مكالمات جهات الاتصال.';

  @override
  String get contactsTab => 'جهات الاتصال';

  @override
  String get contactSubscriptionDescription =>
      'الاشتراك في قوائم جهات الاتصال عبر رابط URL، وتحديث معلومات جهات الاتصال والملصقات تلقائيًا. يدعم بيانات بتنسيق JSON.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'فشل تحميل اشتراكات جهات الاتصال: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'اشتراكات جهات الاتصال';

  @override
  String get contactUpdateSuccess => 'تم تحديث جهة الاتصال بنجاح';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get content => 'المحتوى';

  @override
  String get contentRegex => 'تعبير عادي للمحتوى';

  @override
  String get countColor => 'لون العد';

  @override
  String get countFontSize => 'حجم خط العد';

  @override
  String get countPosition => 'موضع العد';

  @override
  String get country => 'الدولة';

  @override
  String get countryNameColor => 'لون اسم الدولة';

  @override
  String get countryNameFontSize => 'حجم خط اسم الدولة';

  @override
  String get countryRegionNamePosition => 'موضع اسم الدولة/المنطقة';

  @override
  String get countrySelectionDialog => 'مربع حوار اختيار الدولة';

  @override
  String get countrySelectionDialogDescription =>
      'يُستخدم لاختيار دولة للاستعلام عن معلومات معرف المتصل';

  @override
  String get countThresholdDescription =>
      'تعيين الحد الأدنى للعد المطلوب لتشغيل إجراءات التصفية';

  @override
  String get countThresholdLabel => 'حد العد';

  @override
  String get countThresholdSettings => 'إعدادات حد العد';

  @override
  String countThresholdValue(Object count) {
    return 'حد العد: $count';
  }

  @override
  String get createdRules => 'القواعد التي تم إنشاؤها';

  @override
  String get csvFormat => 'تنسيق CSV';

  @override
  String get currentDeviceChip => 'الحالي';

  @override
  String get currentDeviceLabel => 'ملصق الجهاز الحالي';

  @override
  String get currentDeviceTitle => 'الجهاز الحالي';

  @override
  String get currentLabels => 'الملصقات الحالية:';

  @override
  String get currentLanguage => 'اللغة الحالية';

  @override
  String get currentPasswordLabel => 'كلمة المرور الحالية';

  @override
  String get customerService => 'خدمة العملاء';

  @override
  String get customRange => 'نطاق مخصص';

  @override
  String get dailyStatistics => 'إحصائيات يومية';

  @override
  String get dailyStatisticsDesc =>
      'استلم إحصائيات يومية حول المكالمات والرسائل المحظورة';

  @override
  String get dashboardTab => 'لوحة التحكم';

  @override
  String get dataAnalysis => 'تحليل البيانات';

  @override
  String get dataAnalysisDashboardPage => 'صفحة لوحة تحكم تحليل البيانات';

  @override
  String get dataExport => 'تصدير البيانات';

  @override
  String dataLoadFailure(Object error) {
    return 'فشل تحميل البيانات: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'فشل تحميل البيانات: $error';
  }

  @override
  String get dataMigration => 'ترحيل البيانات';

  @override
  String get dataMigrationDescription =>
      'تسمح لك هذه الميزة بنقل جميع بياناتك بين الأجهزة. حاليًا، يمكنك استخدام ميزات النسخ الاحتياطي والاستعادة لترحيل بياناتك يدويًا.';

  @override
  String get dataMigrationDialogContent =>
      'تسمح لك هذه الميزة بنقل جميع بياناتك بين الأجهزة. حاليًا، يمكنك استخدام ميزات النسخ الاحتياطي والاستعادة لترحيل بياناتك يدويًا.';

  @override
  String get dataMigrationDialogTitle => 'ترحيل البيانات';

  @override
  String get dataMigrationSectionTitle => 'ترحيل البيانات';

  @override
  String get dataSourceReminder => 'تذكير بمصدر البيانات';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أيام',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days يوم VIP';
  }

  @override
  String get debtCollection => 'تحصيل الديون';

  @override
  String get defaultPeriod => 'الأسبوع';

  @override
  String get delete => 'حذف';

  @override
  String get deleteButton => 'حذف';

  @override
  String get deleteContact => 'حذف جهة الاتصال';

  @override
  String deleteContactConfirm(Object name) {
    return 'هل أنت متأكد من أنك تريد حذف $name؟';
  }

  @override
  String get deleteContactConfirmation =>
      'هل أنت متأكد من أنك تريد حذف جهة الاتصال';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'هل أنت متأكد من أنك تريد حذف $deviceName؟';
  }

  @override
  String get deleteDeviceDialogTitle => 'حذف الجهاز';

  @override
  String deleteFailed(Object error) {
    return 'فشل الحذف: $error';
  }

  @override
  String get deleteFilter => 'حذف المرشح';

  @override
  String get deleteLabel => 'حذف الملصق';

  @override
  String deleteLabelFailed(Object error) {
    return 'فشل حذف الملصق: $error';
  }

  @override
  String get deletePlugin => 'حذف المكون الإضافي';

  @override
  String deletePluginFailed(Object error) {
    return 'فشل حذف المكون الإضافي: $error';
  }

  @override
  String get deletePlugins => 'حذف المكونات الإضافية';

  @override
  String deletePluginsFailed(Object error) {
    return 'فشل حذف المكونات الإضافية: $error';
  }

  @override
  String get deleteRule => 'حذف القاعدة';

  @override
  String deleteRuleFailed(Object error) {
    return 'فشل الحذف: $error';
  }

  @override
  String get deleteSelected => 'حذف المحدد';

  @override
  String get deleteSmsRule => 'حذف قاعدة الرسائل القصيرة';

  @override
  String get deleteSubscription => 'حذف الاشتراك';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'هل أنت متأكد من أنك تريد حذف الاشتراك \"$name\"؟';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'فشل حذف الاشتراك: $error';
  }

  @override
  String get deleteSuccess => 'تم الحذف بنجاح';

  @override
  String get delivery => 'التسليم';

  @override
  String get deviceDeletedSuccessfully => 'تم حذف الجهاز بنجاح';

  @override
  String get deviceDeletedSuccessfullyMessage => 'تم حذف الجهاز بنجاح';

  @override
  String get deviceIdLabel => 'معرف الجهاز';

  @override
  String get deviceIDLabel => 'معرف الجهاز';

  @override
  String get deviceManagementSubtitle => 'إدارة مزامنة الأجهزة المتعددة';

  @override
  String get deviceManagementTitle => 'إدارة الأجهزة';

  @override
  String get deviceModelLabel => 'طراز الجهاز';

  @override
  String get deviceName => 'اسم الجهاز';

  @override
  String get deviceNameCannotBeEmpty => 'لا يمكن أن يكون اسم الجهاز فارغًا';

  @override
  String get deviceNameHint => 'الرجاء إدخال اسم الجهاز';

  @override
  String get deviceNameLabel => 'اسم الجهاز';

  @override
  String get deviceRenamedSuccessfully => 'تمت إعادة تسمية الجهاز بنجاح';

  @override
  String get deviceRenamedSuccessfullyMessage => 'تمت إعادة تسمية الجهاز بنجاح';

  @override
  String get devicesSyncedSuccessfully => 'تمت مزامنة الأجهزة بنجاح';

  @override
  String get devicesSyncedSuccessfullyMessage => 'تمت مزامنة الأجهزة بنجاح';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'تمت مزامنة الأجهزة بنجاح';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'تم إلغاء تسجيل الجهاز بنجاح';

  @override
  String get dialogTitle => 'شرح نمط Regex';

  @override
  String get differentFromLocalCounter =>
      'تختلف هذه الميزة عن مرشح العداد المحلي، حيث تركز على أنماط المكالمات المتكررة في وقت قصير بدلاً من عدد مرات وضع علامة على المدى الطويل.';

  @override
  String get disabled => 'معطل';

  @override
  String get disabledStatus => 'معطل';

  @override
  String get disableGlobalPlugins => 'تعطيل المكونات الإضافية العامة';

  @override
  String get disableSubscriptionSuccessfully => 'تم تعطيل الاشتراك بنجاح';

  @override
  String get disconnectButton => 'قطع الاتصال';

  @override
  String get disconnectedMessage => 'تم قطع الاتصال';

  @override
  String get disconnectedStatus => 'تم قطع الاتصال';

  @override
  String get disconnectFailedMessage => 'فشل قطع الاتصال';

  @override
  String get done => 'تم';

  @override
  String get dualSimAdvice =>
      'هذه الميزة مفيدة بشكل خاص للهواتف ذات الشريحتين لتعيين استراتيجيات تصفية مختلفة لبطاقات SIM الخاصة بالعمل والشخصية.';

  @override
  String get earlier => 'سابقًا';

  @override
  String get ecommerce => 'التجارة الإلكترونية';

  @override
  String get edit => 'تعديل';

  @override
  String get editContact => 'تعديل جهة الاتصال';

  @override
  String get editFilter => 'تعديل المرشح';

  @override
  String get editLabel => 'تعديل التسمية';

  @override
  String get editPhoneRule => 'تعديل قاعدة الهاتف';

  @override
  String get editPhoneRules => 'تستخدم لتعديل قواعد الهاتف';

  @override
  String get editPhoneRuleTitle => 'تعديل قاعدة الهاتف';

  @override
  String get editRule => 'تعديل القاعدة';

  @override
  String get editSmsRule => 'تعديل قاعدة الرسائل القصيرة';

  @override
  String get education => 'التعليم';

  @override
  String get elementPositionsSetting => 'مواقع العناصر';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailOptional => 'البريد الإلكتروني (اختياري)';

  @override
  String get enableCallFilter => 'تمكين مرشح المكالمات';

  @override
  String get enableCallFilterDescription =>
      'عند التمكين، يتم التحقق من المكالمات الواردة مقابل قائمة القواعد أدناه. لا تتم مزامنة قواعد تصفية المكالمات بين الأجهزة افتراضيًا.';

  @override
  String get enabled => 'ممكّن';

  @override
  String get enabledStatus => 'ممكّن';

  @override
  String get enableEncryption => 'تمكين التشفير';

  @override
  String get enableEncryptionDescription => 'تشفير ملفات النسخ الاحتياطي';

  @override
  String get enableEncryptionLabel => 'تمكين التشفير';

  @override
  String get enableEncryptionSubtitle => 'سيتم تشفير ملفات النسخ الاحتياطي';

  @override
  String get enableEncryptionTitle => 'تمكين التشفير';

  @override
  String get enableGlobalPlugins => 'تمكين المكونات الإضافية العامة';

  @override
  String get enableLocalCountFilter => 'تمكين مرشح العداد المحلي';

  @override
  String get enableLocalCountFilterDescription =>
      'تصفية المكالمات العشوائية تلقائيًا بناءً على عدد علامات المكالمات';

  @override
  String get enableLocalNotification => 'استخدام الإشعار المحلي';

  @override
  String get enableLocalNotificationDescription =>
      'عند التمكين، سيتم عرض إشعارات الرسائل المصفاة على الجهاز';

  @override
  String get enableLocationSummary => 'الموقع';

  @override
  String get enableMuteRules => 'تمكين قواعد كتم الصوت';

  @override
  String get enableMuteRulesDesc => 'تطبيق تكوين قواعد اعتراض كتم الصوت';

  @override
  String get enableNoneActionRules => 'تمكين قواعد عدم اتخاذ إجراء';

  @override
  String get enableNoneActionRulesDesc =>
      'السماح بتكوينات القواعد التي لا تحتوي على إجراءات اعتراض';

  @override
  String get enableNotifications => 'تمكين الإشعارات';

  @override
  String get enableRemoteNumberFilter => 'تمكين مرشح الأرقام البعيد';

  @override
  String get enableRemoteNumberFilterDescription =>
      'استخدام قاعدة بيانات بعيدة لتصفية الأرقام';

  @override
  String get enableRule => 'تمكين القاعدة';

  @override
  String get enableSmsFilter => 'تمكين تصفية الرسائل القصيرة';

  @override
  String get enableSmsFilterDescription =>
      'عند التمكين، سيتم تصفية الرسائل تلقائيًا وفقًا للقواعد';

  @override
  String get enableStatisticsNotifications => 'تمكين إشعارات الإحصائيات';

  @override
  String get enableSubscriptionSuccessfully => 'تم تمكين الاشتراك بنجاح';

  @override
  String get enableTimeInterception => 'تمكين اعتراض الوقت';

  @override
  String get enableTimeInterceptionDescription =>
      'اعتراض المكالمات المتكررة خلال فترة زمنية قصيرة';

  @override
  String get enableTimeInterceptor => 'تمكين اعتراض الوقت';

  @override
  String get endCallImmediately => 'إنهاء المكالمة فورًا';

  @override
  String get endColor => 'لون النهاية';

  @override
  String get endDate => 'تاريخ الانتهاء';

  @override
  String get enhancedFilterInstructionsTitle => 'نظام التصفية المحسن';

  @override
  String get enhancedFilterSettings => 'إعدادات التصفية المحسنة';

  @override
  String get enhancedFilterSettingsTitle => 'إعدادات التصفية المحسنة';

  @override
  String get enhancedFilterSystemDescription =>
      'يدعم نظام التصفية المحسن كلاً من القواعد العامة وتكوينات التصفية لكل بطاقة SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'الرجاء إدخال كل من رقم الهاتف ونمط Regex';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'الرجاء إدخال كل من رقم الهاتف ونمط Regex.';

  @override
  String get enterContactName => 'الرجاء إدخال اسم جهة الاتصال';

  @override
  String get enterCurrentPasswordHint => 'الرجاء إدخال كلمة المرور الحالية';

  @override
  String get enterDeviceName => 'إدخال اسم الجهاز';

  @override
  String get enterDeviceNameHint => 'الرجاء إدخال اسم الجهاز';

  @override
  String get enterEmail => 'الرجاء إدخال البريد الإلكتروني';

  @override
  String get enterEmailOptional => 'الرجاء إدخال البريد الإلكتروني (اختياري)';

  @override
  String get enterEncryptionPasswordHint => 'إدخال كلمة مرور التشفير';

  @override
  String get enterEncryptionPasswordTitle => 'إدخال كلمة مرور التشفير';

  @override
  String get enterFilterName => 'الرجاء إدخال اسم المرشح';

  @override
  String get enterFilterPattern => 'الرجاء إدخال نمط المرشح';

  @override
  String get enterIconCode => 'إدخال رمز الأيقونة';

  @override
  String get enterName => 'إدخال اسم جهة الاتصال';

  @override
  String get enterNewDeviceNameHint => 'إدخال اسم جديد لهذا الجهاز';

  @override
  String get enterNewPasswordHint => 'الرجاء إدخال كلمة مرور جديدة';

  @override
  String get enterPasswordAgain => 'إدخال كلمة المرور مرة أخرى';

  @override
  String get enterPasswordHint => 'الرجاء إدخال كلمة المرور';

  @override
  String get enterPhoneNumber => 'إدخال رقم الهاتف';

  @override
  String get enterPhoneNumberHint => 'إدخال رقم الهاتف للاختبار';

  @override
  String get enterPhoneNumberMultiple =>
      'الرجاء إدخال رقم الهاتف، أرقام متعددة مفصولة بفواصل';

  @override
  String get enterPhoneNumberToStartSearch => 'إدخال رقم الهاتف لبدء البحث';

  @override
  String get enterPhoneNumberToVerify => 'إدخال رقم الهاتف للتحقق';

  @override
  String get enterPluginName => 'إدخال اسم المكون الإضافي';

  @override
  String get enterPluginUrl => 'إدخال عنوان URL للمكون الإضافي';

  @override
  String get enterRegexHint => 'إدخال نمط Regex';

  @override
  String get enterRuleNameAndPattern => 'الرجاء إدخال اسم القاعدة والنمط';

  @override
  String get enterRuleNameAndPatternMessage =>
      'الرجاء إدخال اسم القاعدة ونمط التعبير النمطي.';

  @override
  String get enterRuleNameHint => 'أدخل اسم القاعدة';

  @override
  String get enterSearchContent => 'الرجاء إدخال محتوى البحث';

  @override
  String get enterSubscriptionName => 'أدخل اسم الاشتراك';

  @override
  String get enterSubscriptionUrl => 'أدخل عنوان URL للاشتراك';

  @override
  String get enterSyncFolderNameHint =>
      'الرجاء إدخال اسم مجلد المزامنة (الافتراضي: NotificationManager)';

  @override
  String get entertainment => 'ترفيه';

  @override
  String get enterValidNameAndUrl => 'الرجاء إدخال اسم وعنوان URL صالحين';

  @override
  String get enterValidUrl => 'الرجاء إدخال عنوان URL صالح';

  @override
  String get enterVersion => 'أدخل الإصدار';

  @override
  String get enterWebDAVPasswordHint => 'الرجاء إدخال كلمة مرور WebDAV';

  @override
  String get enterWebDAVServerAddressHint => 'الرجاء إدخال عنوان خادم WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'الرجاء إدخال اسم مستخدم WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'خطأ في حذف الجهاز: $error';
  }

  @override
  String get errorLoadingPlugin => 'خطأ في تحميل المكون الإضافي';

  @override
  String errorOccurredMessage(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'خطأ في إعادة تسمية الجهاز: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'خطأ في مزامنة الأجهزة: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'خطأ في مزامنة الأجهزة: $error';
  }

  @override
  String get errorText => 'خطأ';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'خطأ في إلغاء تسجيل الجهاز: $error';
  }

  @override
  String get exampleBlock400Prefix => 'مثال: حظر أرقام بادئة 400';

  @override
  String get exampleBlockMarketingSms => 'مثال: حظر رسائل SMS التسويقية';

  @override
  String get exampleContentRegex => 'مثال: .*offer.*';

  @override
  String get exampleContentRegexHint => 'مثال على التعبير النمطي للمحتوى';

  @override
  String get exampleCouponPromotionDiscount =>
      'مثال: .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'مثال: العائلة، الأصدقاء، إلخ.';

  @override
  String get examplePhoneNumber => 'مثال: 10086، 12345، إلخ.';

  @override
  String get exampleRegex400Prefix => 'مثال على التعبير النمطي لبادئة 400';

  @override
  String get exampleRegexFormat => 'مثال: تنسيق ^10086\$';

  @override
  String get exampleSenderRegexHint => 'مثال';

  @override
  String get exchange => 'تبادل';

  @override
  String get exchangeNow => 'تبادل الآن';

  @override
  String get exchangeVip => 'تبادل VIP';

  @override
  String get expandLabelSelector => 'توسيع محدد التسميات';

  @override
  String expiryTime(Object time) {
    return 'وقت الانتهاء: $time';
  }

  @override
  String get export => 'تصدير';

  @override
  String get exportAllApplicationSettings => 'تصدير جميع إعدادات التطبيق';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'تصدير جميع إعدادات التطبيق';

  @override
  String get exportAllRuleConfigurations => 'تصدير جميع تكوينات القواعد';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'تصدير جميع تكوينات القواعد';

  @override
  String get exportComplete => 'اكتمل التصدير';

  @override
  String get exportConfig => 'تصدير التكوين';

  @override
  String get exportContacts => 'تصدير جهات الاتصال';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get exportError => 'خطأ في التصدير';

  @override
  String get exportFailed => 'فشل التصدير';

  @override
  String get exportFailure => 'فشل في تصدير التكوين';

  @override
  String get exportFeatureComingSoon => 'ميزة التصدير قادمة قريبًا';

  @override
  String get exporting => 'جاري التصدير...';

  @override
  String get exportLabels => 'تصدير التسميات';

  @override
  String exportLabelsFailed(Object error) {
    return 'فشل في تصدير التسميات: $error';
  }

  @override
  String get exportPluginList => 'تصدير قائمة المكونات الإضافية';

  @override
  String exportPluginListFailed(Object error) {
    return 'فشل في تصدير قائمة المكونات الإضافية: $error';
  }

  @override
  String get exportRules => 'تصدير القواعد';

  @override
  String get exportRulesDialogTitle => 'تصدير القواعد';

  @override
  String get exportRulesTitle => 'تصدير القواعد';

  @override
  String get exportSmsRules => 'تصدير قواعد SMS';

  @override
  String get exportStatisticsData => 'تصدير بيانات الإحصائيات';

  @override
  String get exportSuccess => 'تم التصدير بنجاح';

  @override
  String get exportSuccesslly => 'تم تصدير التكوين بنجاح';

  @override
  String get failedToAddContact => 'فشل في إضافة جهة اتصال';

  @override
  String failedToAddRule(Object error) {
    return 'فشل في إضافة قاعدة: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'فشل في إضافة قاعدة SMS: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'فشل في إضافة اشتراك SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'فشل في النسخ الاحتياطي للإعدادات: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'فشل في فك تشفير ملف النسخ الاحتياطي';

  @override
  String get failedToDeleteDevice => 'فشل في حذف الجهاز';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'فشل في حذف قاعدة SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'فشل في تصدير القواعد: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'فشل في تصدير قواعد SMS: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'فشل في الحصول على معلومات هوية المتصل: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'فشل في استيراد القواعد: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'فشل في استيراد قواعد SMS: $error';
  }

  @override
  String get failedToLoadContacts => 'فشل في تحميل جهات الاتصال';

  @override
  String get failedToLoadPlugin => 'فشل في تحميل المكون الإضافي';

  @override
  String get failedToRenameDevice => 'فشل في إعادة تسمية الجهاز';

  @override
  String get failedToRestoreSettings => 'فشل في استعادة الإعدادات';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'فشل في استعادة الإعدادات: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'فشل في تعيين كلمة المرور: $error';
  }

  @override
  String get failedToSyncDevices => 'فشل في مزامنة الأجهزة';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'فشل في تبديل حالة القاعدة: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => 'فشل في تبديل حالة الاشتراك';

  @override
  String get failedToUpdateContact => 'فشل في تحديث جهة اتصال';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'فشل في تحديث قاعدة SMS: $error';
  }

  @override
  String get failure => 'فشل';

  @override
  String get favoriteContacts => 'جهات الاتصال المفضلة';

  @override
  String get featureAddRules => '• إضافة قواعد خاصة بأرقام الهواتف';

  @override
  String get featureCenter => 'مركز الميزات';

  @override
  String get featureEnableDisable =>
      '• تمكين/تعطيل عوامل تصفية مختلفة لكل شريحة SIM';

  @override
  String get featureListTitle => 'الميزات:';

  @override
  String get featureManageRules => '• إدارة قوائم القواعد لكل شريحة SIM';

  @override
  String get features => 'ميزات';

  @override
  String get fetchingCallerIdInfo => 'جاري جلب معلومات هوية المتصل...';

  @override
  String fileSavedTo(Object path) {
    return 'تم حفظ الملف في: $path';
  }

  @override
  String get filter => 'تصفية';

  @override
  String get filterByLabel => 'التصفية حسب التسمية';

  @override
  String get filterClear => 'مسح التصفية';

  @override
  String get filterControlPanelTitle => 'لوحة تحكم التصفية';

  @override
  String get filterControlSubtitle =>
      'إدارة حالة التشغيل/الإيقاف لجميع عوامل التصفية';

  @override
  String get filterControlTitle => 'التحكم في الفلاتر';

  @override
  String get filterDeleteFailed => 'فشل حذف الفلتر';

  @override
  String get filterDeleteSuccess => 'تم حذف الفلتر بنجاح';

  @override
  String get filterDetails => 'تفاصيل الفلتر';

  @override
  String get filtered => 'مفلتر';

  @override
  String get filteredSms => 'رسائل SMS مفلترة';

  @override
  String get filteredSmsLabel => 'رسائل SMS مفلترة';

  @override
  String get filterExplanation => 'شرح الفلتر';

  @override
  String get filterManagement => 'إدارة الفلاتر';

  @override
  String get filterName => 'اسم الفلتر';

  @override
  String get filterPattern => 'نمط الفلتر';

  @override
  String get filterPriorityNote =>
      'ملاحظة: توجد علاقات أولوية بين الفلاتر، يرجى الرجوع إلى وثائق المساعدة للحصول على التفاصيل';

  @override
  String get filterSaveFailed => 'فشل حفظ الفلتر';

  @override
  String get filterSaveSuccess => 'تم حفظ الفلتر بنجاح';

  @override
  String get filterSettings => 'إعدادات الفلتر';

  @override
  String get filterSettingsTitle => 'إعدادات الفلتر';

  @override
  String get filterSMS => 'فلترة الرسائل القصيرة';

  @override
  String get filterToggleInstructions =>
      'تمكين أو تعطيل الفلاتر لفتحة SIM هذه:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'فلتر $status: $filterName';
  }

  @override
  String get filterType => 'نوع الفلتر';

  @override
  String get financial => 'مالي';

  @override
  String get flexibleCombinationFeature =>
      '• تركيبات مرنة: تمكين/تعطيل الفلاتر لكل فتحة SIM';

  @override
  String get fontSizesSetting => 'أحجام الخطوط';

  @override
  String foundRules(Object count) {
    return 'تم العثور على $count قاعدة';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'تم العثور على $count قاعدة. هل تريد استيرادها؟';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'تم العثور على $count قاعدة. هل تريد استيرادها؟';
  }

  @override
  String get fraudAlert => 'تنبيه احتيال - قم بإنهاء المكالمة';

  @override
  String get fraudScamLikely => 'احتيال محتمل';

  @override
  String get free => 'مجاني';

  @override
  String get functionSettingsTitle => 'إعدادات الوظائف';

  @override
  String generalUpdateFailure(Object error) {
    return 'فشل التحديث: $error';
  }

  @override
  String get getFree => 'احصل على مجاني';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'تكوين الفلاتر العامة لجميع بطاقات SIM:';

  @override
  String get globalFilterFeature =>
      '• فلاتر عامة: قواعد أساسية لجميع المكالمات الواردة';

  @override
  String get globalFilterSettings => 'إعدادات الفلتر العام';

  @override
  String get globalFilterToggleInstructions =>
      'تكوين إعدادات الفلتر العامة التي تنطبق على جميع فتحات SIM:';

  @override
  String get globalSearchSubtitle =>
      'البحث عن جهات الاتصال، الملصقات، القوائم السوداء، القوائم البيضاء، إلخ.';

  @override
  String get globalSearchTitle => 'بحث عام';

  @override
  String get globalSettings => 'الإعدادات العامة';

  @override
  String get googleAdDisplayPosition => 'موضع عرض إعلانات Google';

  @override
  String get googleAdMobIntegrationText => 'يمكن دمج إعلانات Google AdMob هنا';

  @override
  String get googleDriveAuthDescription =>
      'مصادقة باستخدام معرّف عميل ومفتاح Google Drive المُكوّنين في النظام';

  @override
  String get googleDriveAuthorizationHint =>
      'مصادقة باستخدام معرّف عميل ومفتاح Google Drive المُكوّنين في النظام';

  @override
  String get googleDriveConfigTitle => 'تكوين Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'تكوين Google Drive';

  @override
  String get government => 'حكومي';

  @override
  String get granted => 'ممنوح';

  @override
  String get grantNecessaryPermissions => 'منح الأذونات الضرورية';

  @override
  String get grantPermissions => 'منح الأذونات';

  @override
  String get headhunter => 'صياد رؤوس';

  @override
  String get height => 'ارتفاع';

  @override
  String get homePageTitle => 'الصفحة الرئيسية';

  @override
  String get homeTab => 'الصفحة الرئيسية';

  @override
  String get howItWorksPoint1 =>
      '• سيسمح النظام تلقائيًا بالمكالمات من نفس الرقم ضمن النافذة الزمنية المحددة';

  @override
  String get howItWorksPoint2 =>
      '• النوافذ الزمنية الأقصر تؤدي إلى اعتراض أكثر صرامة؛ النوافذ الزمنية الأطول تؤدي إلى اعتراض أقل صرامة';

  @override
  String get howItWorksPoint3 =>
      '• يفحص النظام سجلات المكالمات لتحديد ما إذا كانت مكالمة متكررة';

  @override
  String get howItWorksTitle => 'كيف تعمل:';

  @override
  String get iconCodeOptional => 'رمز الأيقونة (اختياري)';

  @override
  String get iconSize => 'حجم الأيقونة';

  @override
  String get import => 'استيراد';

  @override
  String get important => 'هام';

  @override
  String get importButton => 'استيراد';

  @override
  String get importConfig => 'استيراد التكوين';

  @override
  String get importContacts => 'استيراد جهات الاتصال';

  @override
  String get importExportContacts => 'استيراد/تصدير جهات الاتصال';

  @override
  String get importExportContactsTooltip => 'استيراد/تصدير جهات الاتصال';

  @override
  String get importExportRules => 'استيراد/تصدير القواعد';

  @override
  String importFailed(Object error) {
    return 'فشل الاستيراد: $error';
  }

  @override
  String get importFailure => 'فشل استيراد التكوين';

  @override
  String get importFeatureComingSoon => 'ميزة الاستيراد قادمة قريبًا';

  @override
  String get importLabels => 'استيراد الملصقات';

  @override
  String importLabelsFailed(Object error) {
    return 'فشل استيراد الملصقات: $error';
  }

  @override
  String get importPluginList => 'استيراد قائمة الإضافات';

  @override
  String importPluginListFailed(Object error) {
    return 'فشل استيراد قائمة الإضافات: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'تم استيراد $count من الإضافات بنجاح';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'استيراد تكوينات القواعد من ملف';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'استيراد تكوينات القواعد من ملف';

  @override
  String get importRules => 'استيراد القواعد';

  @override
  String get importRulesButton => 'استيراد القواعد';

  @override
  String get importRulesDialogTitle => 'استيراد القواعد';

  @override
  String importRulesError(Object error) {
    return 'فشل استيراد القواعد: $error';
  }

  @override
  String get importRulesInstructions => 'استيراد القواعد من ملف CSV';

  @override
  String get importRulesSuccess => 'تم استيراد القواعد بنجاح';

  @override
  String get importRulesTitle => 'استيراد القواعد';

  @override
  String get importSuccess => 'تم الاستيراد بنجاح';

  @override
  String get incomingCallInterceptAction => 'إجراء اعتراض المكالمات الواردة';

  @override
  String get incomingCallNotification => 'إشعار المكالمات الواردة';

  @override
  String get incorrectPassword => 'كلمة مرور غير صحيحة';

  @override
  String get initializing => 'جارٍ التهيئة';

  @override
  String get installed => 'مثبت';

  @override
  String get insufficientMarks => 'علامات غير كافية';

  @override
  String get insurance => 'تأمين';

  @override
  String get interceptAction => 'إجراء الاعتراض';

  @override
  String get interceptionActionSettingsSubtitle =>
      'اضبط كيفية التعامل مع المكالمات المحظورة';

  @override
  String get interceptionActionSettingsTitle => 'إعدادات إجراء الاعتراض';

  @override
  String get interceptionTimeInterval => 'فاصل زمني للاعتراض';

  @override
  String get internet => 'إنترنت';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'تم تعيين فترة تحديث $service إلى $days أيام';
  }

  @override
  String get invalidContentRegex => 'تعبير عادي غير صالح للمحتوى';

  @override
  String get invalidLabel => 'تسمية غير صالحة';

  @override
  String get invalidRegexPattern => 'نمط تعبير نمطي غير صالح';

  @override
  String get invalidSenderRegex => 'تعبير نمطي غير صالح للمرسل';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'انضم إلى قناة ومجموعة تيليجرام لمزيد من المعلومات';

  @override
  String get jsLogsTitle => 'سجلات JavaScript';

  @override
  String get jsonFormat => 'تنسيق JSON';

  @override
  String get keepAllVersions => 'الاحتفاظ بجميع الإصدارات';

  @override
  String get keepAllVersionsDescription =>
      'الاحتفاظ بجميع الإصدارات التاريخية لكل نسخة احتياطية';

  @override
  String get keepAllVersionsLabel => 'الاحتفاظ بجميع الإصدارات';

  @override
  String get keepAllVersionsSubtitle =>
      'الاحتفاظ بالإصدارات التاريخية لكل نسخة احتياطية';

  @override
  String get keepAllVersionsTitle => 'الاحتفاظ بجميع الإصدارات';

  @override
  String get label => 'تسمية';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'تمت إضافة التسمية \"$name\" بنجاح';
  }

  @override
  String get labelCategories => 'فئات التسميات';

  @override
  String get labelDeleted => 'تم حذف التسمية';

  @override
  String get labelDescription =>
      'تساعدك التسميات على إدارة جهات الاتصال بشكل أفضل، وإضافة تسميات مخصصة لأرقام الهواتف لتحديد المكالمات والرسائل بسهولة.';

  @override
  String get labelFilter => 'مرشح التسمية';

  @override
  String get labelFilterTooltip => 'مرشح التسمية';

  @override
  String get labelIconColor => 'لون أيقونة التسمية';

  @override
  String get labelManagement => 'إدارة التسميات';

  @override
  String get labelNotFound => 'لم يتم العثور على التسمية';

  @override
  String get labelRemoved => 'تمت إزالة التسمية';

  @override
  String labelRemoveFailed(Object error) {
    return 'فشل إزالة التسمية: $error';
  }

  @override
  String get labels => 'تسميات';

  @override
  String get labelsColor => 'لون التسميات';

  @override
  String labelsDeleted(Object count) {
    return 'تم حذف $count تسمية';
  }

  @override
  String get labelsExportedSuccessfully => 'تم تصدير التسميات بنجاح';

  @override
  String get labelsFontSize => 'حجم خط التسميات';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'تم استيراد $count تسمية بنجاح';
  }

  @override
  String get labelsPosition => 'موضع التسميات';

  @override
  String labelTag(Object labelId) {
    return 'تسمية: $labelId';
  }

  @override
  String get labelUpdated => 'تم تحديث التسمية';

  @override
  String labelUpdateFailed(Object error) {
    return 'فشل تحديث التسمية: $error';
  }

  @override
  String get labelUpdateSuccess => 'تم تحديث التسمية \"\$labelText\" بنجاح';

  @override
  String get languageSettings => 'إعدادات اللغة';

  @override
  String get languageSettingsSubtitle => 'تغيير لغة عرض التطبيق';

  @override
  String get languageSettingsTitle => 'إعدادات اللغة';

  @override
  String get last30Days => 'آخر 30 يومًا';

  @override
  String get last7Days => 'آخر 7 أيام';

  @override
  String get lastSyncLabel => 'آخر مزامنة';

  @override
  String lastUpdated(Object date) {
    return 'آخر تحديث: $date';
  }

  @override
  String get lifetimeMembership => 'عضوية مدى الحياة';

  @override
  String get lifetimeMembershipDescription =>
      'شراء لمرة واحدة، فتح جميع الميزات المتميزة والتحديثات المستقبلية بشكل دائم';

  @override
  String loadContactsFailed(Object error) {
    return 'فشل تحميل جهات الاتصال: $error';
  }

  @override
  String get loadDataFailed => 'فشل تحميل البيانات';

  @override
  String get loadFailed => 'فشل التحميل';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get loadingData => 'جارٍ تحميل البيانات...';

  @override
  String get loadingTags => 'جارٍ تحميل العلامات...';

  @override
  String loadLabelFailed(Object error) {
    return 'فشل تحميل التسميات: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'فشل تحميل التسميات: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'فشل تحميل أرقام الهواتف المميزة: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'فشل تحميل الهواتف المميزة: $error';
  }

  @override
  String get loadMore => 'تحميل المزيد';

  @override
  String get loadPluginButton => 'تحميل المكون الإضافي';

  @override
  String loadPluginsFailed(Object error) {
    return 'فشل تحميل المكونات الإضافية: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'فشل تحميل الإعدادات: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'فشل تحميل قواعد الرسائل القصيرة: $error';
  }

  @override
  String get loadStatusFailedMessage => 'فشل تحميل الحالة';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'فشل تحميل الاشتراكات: $error';
  }

  @override
  String get loan => 'قرض';

  @override
  String get localBackupTitle => 'نسخ احتياطي محلي';

  @override
  String get localCounterFilter => 'مرشح العداد المحلي';

  @override
  String get localCounterFilterSubtitle =>
      'تصفية المكالمات المزعجة تلقائيًا بناءً على تكرار المكالمات';

  @override
  String get localCountFilter => 'مرشح العدد المحلي';

  @override
  String get localCountFilterDescription =>
      'اعترض المكالمات المتكررة بناءً على أعداد الأرقام المحلية';

  @override
  String get localCountFilterExplanationContent =>
      'يقوم مرشح العدد المحلي بتحليل سجلات سجل المكالمات لتحديد وحظر المكالمات المزعجة المتكررة تلقائيًا.';

  @override
  String get localCountFilterExplanationTitle => 'شرح مرشح العدد المحلي';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• تحديد ما إذا كان سيتم الحظر بناءً على قيمة عدد الرقم';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• عندما يتجاوز عدد الرقم الحد المحدد، يمكنك اختيار حظره تلقائيًا';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• يمكنك السماح بشكل انتقائي للأرقام التي لا تتجاوز الحد';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• يمكنك اختيار ما إذا كنت ستسجل جميع سجلات الاستعلام';

  @override
  String get localCountFiltering => 'تصفية العدد المحلي';

  @override
  String get localCountFilteringExplanation =>
      '• تصفية العدد المحلي: قواعد التصفية بناءً على عدد العلامات المحلية';

  @override
  String get localCountFilterSettings => 'إعدادات مرشح العدد المحلي';

  @override
  String get localCountFilterUseCases =>
      'هذا المرشح مناسب بشكل خاص لتحديد المكالمات المزعجة التي تم طلبها تلقائيًا ومكالمات التسويق.';

  @override
  String get localFilterSettings => 'إعدادات المرشح المحلي';

  @override
  String get localNotificationDisabled => 'تم تعطيل الإشعارات المحلية';

  @override
  String get localNotificationEnabled => 'تم تمكين الإشعارات المحلية';

  @override
  String get localServices => 'خدمات محلية';

  @override
  String get locationColor => 'لون الموقع';

  @override
  String get locationFontSize => 'حجم خط الموقع';

  @override
  String get locationIconColor => 'لون أيقونة الموقع';

  @override
  String get locationPosition => 'موضع الموقع';

  @override
  String get logAllLocalQueries => 'تسجيل جميع الاستعلامات المحلية';

  @override
  String get logAllLocalQueriesDescription =>
      'تسجيل جميع استعلامات الأرقام المحلية';

  @override
  String get logAllRemoteQueries => 'تسجيل جميع الاستعلامات عن بعد';

  @override
  String get logAllRemoteQueriesDescription =>
      'تسجيل جميع عمليات استعلام الأرقام عن بعد';

  @override
  String get manage => 'إدارة جهات الاتصال';

  @override
  String get manageContacts => 'إدارة';

  @override
  String get manageFavoriteContacts => 'إدارة جهات الاتصال المفضلة';

  @override
  String get manageFilterRules => 'إدارة قواعد التصفية';

  @override
  String get manageFilterRulesDescription =>
      'إضافة، تحرير، أو حذف قواعد تصفية الرسائل القصيرة';

  @override
  String get manageFrequentContacts => 'إدارة جهات الاتصال المتكررة';

  @override
  String get markCounts => 'عدد العلامات';

  @override
  String get markCount => 'عدد العلامات';

  @override
  String markedByCount(Object count) {
    return 'مميز بواسطة $count';
  }

  @override
  String get markedPhonesList => 'قائمة أرقام الهواتف المميزة';

  @override
  String get markExchange => 'تبادل العلامات';

  @override
  String get markPhone => 'تمييز رقم الهاتف';

  @override
  String markPhoneFailed(Object error) {
    return 'فشل في وضع علامة على رقم الهاتف: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'لوضع علامات على أرقام الهواتف';

  @override
  String get markPhoneManagementTitle => 'إدارة علامات أرقام الهواتف';

  @override
  String get markPhoneSuccess => 'تم وضع علامة على رقم الهاتف بنجاح';

  @override
  String get matchFailed => 'فشل المطابقة!';

  @override
  String get matchFailedMessage => 'فشل المطابقة.';

  @override
  String get matchNumbersWithSpecialCharacters => 'يطابق تنسيق أرقام معين';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'مطابقة الأرقام بأحرف خاصة:';

  @override
  String get matchSpecificDigitPatterns => 'يطابق تنسيق XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle => 'مطابقة أنماط الأرقام المحددة:';

  @override
  String get matchSuccessful => 'تمت المطابقة بنجاح!';

  @override
  String get matchSuccessfulMessage => 'تمت المطابقة بنجاح!';

  @override
  String get medical => 'طبي';

  @override
  String get membershipPrivileges => 'امتيازات العضوية';

  @override
  String get migrationTool => 'أداة الترحيل';

  @override
  String get migrationToolTitle => 'أداة الترحيل';

  @override
  String get minutes => 'دقائق';

  @override
  String get month => 'شهر';

  @override
  String get monthly => 'شهري';

  @override
  String get monthlyCallCount => 'مكالمات شهرية';

  @override
  String get monthlyChartTitle => 'المكالمات المحظورة الشهرية';

  @override
  String get monthlyMembership => 'عضوية شهرية';

  @override
  String get monthlyMembershipDescription =>
      'افتح جميع الميزات المميزة، تجديد تلقائي شهري';

  @override
  String get monthlyTotal => 'الإجمالي الشهري';

  @override
  String get monthlyTotalLabel => 'الإجمالي الشهري';

  @override
  String get moreOptions => 'المزيد من الخيارات';

  @override
  String get mute => 'كتم الصوت';

  @override
  String get name => 'الاسم';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'لا يمكن أن يكون الاسم ورقم الهاتف فارغين';

  @override
  String get nameAndPhoneNumberRequired => 'الاسم ورقم الهاتف مطلوبان';

  @override
  String get nameColor => 'لون الاسم';

  @override
  String get nameFontSize => 'حجم خط الاسم';

  @override
  String nameLabel(Object name) {
    return 'الاسم: $name';
  }

  @override
  String get namePosition => 'موضع الاسم';

  @override
  String get nameUnknown => 'الاسم: غير معروف';

  @override
  String nameWithValue(String name) {
    return 'الاسم: $name';
  }

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get nextStep => 'التالي';

  @override
  String get noAction => 'لا إجراء';

  @override
  String get noActionRules => 'قواعد عدم اتخاذ إجراء';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'لا توجد خدمة مزامنة سحابية نشطة';

  @override
  String get noCallLogs => 'لا توجد سجلات مكالمات';

  @override
  String get noCallRecords => 'لا توجد سجلات مكالمات';

  @override
  String get noContacts => 'لا توجد جهات اتصال بعد';

  @override
  String get noContactsYet => 'لا توجد جهات اتصال بعد';

  @override
  String get noData => 'لا توجد بيانات';

  @override
  String get noDevicesRegisteredMessage => 'لم يتم تسجيل أي أجهزة';

  @override
  String get noDevicesRegisteredYet => 'لم يتم تسجيل أي أجهزة بعد.';

  @override
  String get noFilters => 'لا توجد عوامل تصفية بعد';

  @override
  String get noLabels => 'لا توجد علامات بعد';

  @override
  String get noMarkedPhones => 'لا توجد أرقام هواتف مميزة';

  @override
  String get noMatchingContacts => 'لا توجد جهات اتصال مطابقة';

  @override
  String get noMatchingContactsFound => 'لم يتم العثور على جهات اتصال مطابقة';

  @override
  String get noMatchingNumbersFound => 'لم يتم العثور على أرقام مطابقة';

  @override
  String get noMatchingRecords => 'لا توجد سجلات مكالمات مطابقة';

  @override
  String noMatchingRules(Object ruleType) {
    return 'لا توجد $ruleType مطابقة';
  }

  @override
  String get none => 'لا شيء';

  @override
  String get noneServiceType => 'لا شيء';

  @override
  String get noPlugins => 'لا توجد إضافات بعد';

  @override
  String get noRecords => 'لا توجد سجلات مكالمات';

  @override
  String get noResultReturned => 'لم يتم إرجاع أي نتيجة';

  @override
  String get noResultReturnedLog => 'لم يتم إرجاع أي نتيجة من المكون الإضافي';

  @override
  String noRules(Object ruleType) {
    return 'لا توجد $ruleType بعد';
  }

  @override
  String get noRulesPrompt => 'لم يتم العثور على قواعد، يرجى إضافة قواعد';

  @override
  String get noRulesToExport => 'لا توجد قواعد للتصدير';

  @override
  String get noSmsFilterRulesYet => 'لا توجد قواعد تصفية الرسائل القصيرة بعد';

  @override
  String get noSmsRulesYet => 'لا توجد قواعد رسائل قصيرة بعد';

  @override
  String get noSubscriptions => 'لا توجد اشتراكات';

  @override
  String get noSubscriptionsYet => 'لا توجد اشتراكات بعد';

  @override
  String get notGranted => 'لم يتم منح';

  @override
  String get notificationModeDescription =>
      'عرض معلومات المتصل في شريط الإشعارات';

  @override
  String get notificationPermission => 'إذن الإشعارات';

  @override
  String get notificationPermissionDescription =>
      'تُستخدم لعرض إشعارات المكالمات والرسائل الواردة.';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get notificationSettings => 'إعدادات الإشعارات';

  @override
  String get notificationSettingsSaved => 'تم حفظ إعدادات الإشعارات بنجاح';

  @override
  String get notSet => 'لم يتم التعيين';

  @override
  String get notVerifiedText => 'لم يتم التحقق';

  @override
  String get noValidSmsRulesFoundInFile =>
      'لم يتم العثور على قواعد رسائل قصيرة صالحة في الملف';

  @override
  String get number => 'الرقم';

  @override
  String get numberColor => 'لون الرقم';

  @override
  String get numberFontSize => 'حجم خط الرقم';

  @override
  String get numberPosition => 'موضع الرقم';

  @override
  String get numberSearch => 'البحث عن رقم';

  @override
  String get numberTypeColor => 'لون نوع الرقم';

  @override
  String get numberTypeFontSize => 'حجم خط نوع الرقم';

  @override
  String get numberTypePosition => 'موضع نوع الرقم';

  @override
  String get ok => 'موافق';

  @override
  String get okButton => 'موافق';

  @override
  String get onboardingCompleteDescription =>
      'مدير أمان مكالماتك جاهز، ابدأ بالاستمتاع بتجربة مكالمات آمنة!';

  @override
  String get onboardingLanguageDescription =>
      'اختر لغتك المفضلة للحصول على أفضل تجربة.';

  @override
  String get onboardingPermissionsDescription =>
      'لتوفير خدمة كاملة، نحتاج إلى الأذونات التالية:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'حظر مكالمات ورسائل البريد العشوائي بنقرة واحدة، وتخصيص قواعد الحظر، وتوفير بيئة هادئة لك.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'تحديد المكالمات المجهولة تلقائيًا، ووضع علامات على الأرقام المشبوهة، وحماية أمان مكالماتك.';

  @override
  String get onboardingWelcomeDescription =>
      'خبير إدارة مكالماتك، يوفر خدمات شاملة لتحديد المكالمات وحظرها.';

  @override
  String get oneDriveAuthDescription =>
      'مصادقة باستخدام معرف ومفتاح عميل OneDrive المهيأ في النظام';

  @override
  String get oneDriveAuthorizationHint =>
      'مصادقة باستخدام معرف ومفتاح عميل OneDrive المهيأ في النظام';

  @override
  String get oneDriveConfigTitle => 'تكوين OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'تكوين OneDrive';

  @override
  String get onlineCallerIdSubscription => 'اشتراك معرف المتصل عبر الإنترنت';

  @override
  String get openAppSettings => 'فتح إعدادات التطبيق';

  @override
  String openAppSettingsFailed(Object error) {
    return 'فشل فتح إعدادات التطبيق: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'فشل العملية: $error';
  }

  @override
  String get operationFailure => 'فشلت العملية';

  @override
  String get operationSuccess => 'نجحت العملية';

  @override
  String get other => 'أخرى';

  @override
  String get ourOtherApps => 'تطبيقاتنا الأخرى';

  @override
  String get overlayMode => 'نافذة عائمة';

  @override
  String get overlayModeDescription => 'عرض معلومات المتصل في نافذة عائمة';

  @override
  String get overlayPermission => 'إذن النافذة العائمة';

  @override
  String get overlayPermissionDescription =>
      'يُستخدم لعرض تراكب المكالمات الواردة.';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordCannotBeEmpty => 'لا يمكن أن تكون كلمة المرور فارغة';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get passwordSetSuccessfully => 'تم تعيين كلمة المرور بنجاح';

  @override
  String get pattern => 'نمط';

  @override
  String get pendingSync => 'مزامنة معلقة';

  @override
  String get periodMonth => 'شهر';

  @override
  String get periodWeek => 'أسبوع';

  @override
  String get periodYear => 'سنة';

  @override
  String get permissionDenied => 'تم رفض طلب الإذن';

  @override
  String get permissionGranted => 'تم منح الإذن';

  @override
  String get permissionManagement => 'إدارة الأذونات';

  @override
  String get phoneCallsTab => 'الهاتف';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get phoneNumberCannotBeEmpty => 'لا يمكن أن يكون رقم الهاتف فارغًا';

  @override
  String get phoneNumberHintText => 'أدخل رقم الهاتف لإضافة قاعدة';

  @override
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  String get phoneNumberRegexRequired =>
      'يرجى إدخال كل من رقم الهاتف ونمط التعبير العادي';

  @override
  String get phoneNumberTypeFixedLine => 'خط أرضي';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'خط أرضي أو جوال';

  @override
  String get phoneNumberTypeMobile => 'جوال';

  @override
  String get phoneNumberTypePager => 'فاكس';

  @override
  String get phoneNumberTypePersonalNumber => 'رقم شخصي';

  @override
  String get phoneNumberTypePremiumRate => 'معدل مميز';

  @override
  String get phoneNumberTypeSharedCost => 'تكلفة مشتركة';

  @override
  String get phoneNumberTypeTollFree => 'مجاني';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'غير معروف';

  @override
  String get phoneNumberTypeVoicemail => 'بريد صوتي';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'إذن الهاتف';

  @override
  String get phonePermissionDescription =>
      'يُستخدم لتحديد وحظر المكالمات الواردة.';

  @override
  String get phoneRule => 'قاعدة الهاتف';

  @override
  String get phoneRuleEditDialog => 'مربع حوار تحرير قاعدة الهاتف';

  @override
  String get phoneRuleManagement => 'إدارة قواعد الهاتف';

  @override
  String get phoneRuleSubscription => 'اشتراك قاعدة الهاتف';

  @override
  String get phoneSubscription => 'اشتراك الهاتف';

  @override
  String get phoneSubscriptionRulesDescription =>
      'اشترك في قوائم قواعد الهاتف عبر عنوان URL لتحديث قوائم الأرقام المسموح بها والمحظورة تلقائيًا. يدعم ملفات قواعد بتنسيق JSON.';

  @override
  String get phoneSubscriptionTitle => 'اشتراكات قواعد الهاتف';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'يرجى تحديد تسمية وإدخال رقم هاتف صالح';

  @override
  String pluginAddedSuccess(Object name) {
    return 'تمت إضافة المكون الإضافي \"$name\" بنجاح';
  }

  @override
  String get pluginDeleted => 'تم حذف المكون الإضافي';

  @override
  String get pluginLatestVersion => 'المكون الإضافي هو بالفعل أحدث إصدار';

  @override
  String get pluginListExportSuccess =>
      'تم تصدير قائمة المكونات الإضافية بنجاح';

  @override
  String get pluginLoadedSuccessfully => 'تم تحميل المكون الإضافي بنجاح';

  @override
  String get pluginManagement => 'إدارة المكونات الإضافية';

  @override
  String get pluginManagementSubtitle =>
      'إدارة وتكوين المكونات الإضافية لجهات خارجية';

  @override
  String get pluginManagementTitle => 'إدارة المكونات الإضافية';

  @override
  String get pluginName => 'اسم المكون الإضافي';

  @override
  String get pluginNotLoaded =>
      'لم يتم تحميل المكون الإضافي بعد. يرجى تحميل المكون الإضافي أولاً.';

  @override
  String pluginsDeleted(Object count) {
    return 'تم حذف $count مكون إضافي بنجاح.';
  }

  @override
  String get pluginService => 'خدمة المكونات الإضافية';

  @override
  String get pluginTestPageTitle => 'اختبار المكون الإضافي';

  @override
  String get pluginUpdateSuccess => 'تم تحديث المكون الإضافي بنجاح';

  @override
  String get pluginUrl => 'عنوان URL للمكون الإضافي';

  @override
  String get pluginUrlCannotBeEmpty =>
      'لا يمكن أن يكون عنوان URL للمكون الإضافي فارغًا';

  @override
  String get pluginUrlHint => 'أدخل عنوان URL للمكون الإضافي';

  @override
  String get pluginUrlLabel => 'عنوان URL للمكون الإضافي';

  @override
  String get pluginVersion => 'إصدار المكون الإضافي';

  @override
  String get political => 'سياسي';

  @override
  String get powerfulSpamBlocking => 'حظر البريد العشوائي القوي';

  @override
  String get previousStep => 'السابق';

  @override
  String get prioritizeRemoteAction =>
      'تحديد أولويات إعدادات الإجراء عن بُد بعد';

  @override
  String get prioritizeRemoteActionDescription =>
      'تحديد أولويات إعدادات الإجراء من قاعدة البيانات البعيدة';

  @override
  String get processing => 'جارٍ المعالجة...';

  @override
  String get processingOperation => 'جارٍ المعالجة...';

  @override
  String get purchase => 'شراء';

  @override
  String get quarterlyMembership => 'عضوية ربع سنوية';

  @override
  String get quarterlyMembershipDescription =>
      'افتح جميع الميزات المتميزة، تجديد تلقائي كل ثلاثة أشهر';

  @override
  String get queryButton => 'استعلام';

  @override
  String get queryFailed => 'فشل الاستعلام';

  @override
  String get queryFailedLog => 'فشل الاستعلام';

  @override
  String get querying => 'جارٍ الاستعلام...';

  @override
  String get queryingPhoneNumber => 'جارٍ الاستعلام عن رقم الهاتف';

  @override
  String get queryResultTitle => 'نتيجة الاستعلام';

  @override
  String get ready => 'جاهز!';

  @override
  String get receiveWeeklyStatistics => 'استلام إحصائيات أسبوعية';

  @override
  String get recruiter => 'مسؤول التوظيف';

  @override
  String get reEnterPasswordHint => 'يرجى إعادة إدخال كلمة المرور';

  @override
  String get refresh => 'تحديث';

  @override
  String get refreshPermissionStatus => 'تحديث حالة الإذن';

  @override
  String get refreshTooltip => 'تحديث';

  @override
  String regexError(Object error) {
    return 'خطأ في التعبير العادي: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'خطأ في التعبير العادي: $error';
  }

  @override
  String get regexPattern => 'نمط Regex';

  @override
  String get regexPatternExplanation => 'شرح نمط Regex';

  @override
  String get regexPatternExplanationButton => 'شرح نمط Regex';

  @override
  String get regexPatternLabel => 'نمط Regex';

  @override
  String get regexPatternsExamples =>
      'استخدم صيغة regex قياسية لتعريف الأنماط. أمثلة:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'أنماط Regex لمطابقة أرقام الهواتف';

  @override
  String get regexRule => 'قاعدة Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'فشل في إضافة قاعدة regex: $error';
  }

  @override
  String get regexRuleAddSuccess => 'تمت إضافة قاعدة regex بنجاح';

  @override
  String get regexRuleManagement => 'إدارة قواعد Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'لا يمكن أن يكون اسم القاعدة ونمط regex فارغين';

  @override
  String get regexRules => 'قواعد Regex';

  @override
  String get regexTesterTitle => 'مختبر Regex';

  @override
  String regexValidationFailed(Object error) {
    return 'فشل التحقق من صحة Regex: $error';
  }

  @override
  String get regexValidationSuccess => 'نجح التحقق من صحة Regex';

  @override
  String get region => 'المنطقة';

  @override
  String get registeredDevicesTitle => 'الأجهزة المسجلة';

  @override
  String get rejectAllCalls => 'رفض جميع المكالمات';

  @override
  String get rejectAllCallsDescription =>
      'عند التمكين، سيتم رفض جميع المكالمات بأعلى أولوية';

  @override
  String get rejectAllNumbers => 'رفض جميع الأرقام';

  @override
  String get rejectAllNumbersDesc => 'رفض جميع المكالمات الواردة عند التمكين';

  @override
  String get rejectExceededNumbers => 'رفض الأرقام المتجاوزة';

  @override
  String get rejectExceededNumbersDescription =>
      'رفض الأرقام تلقائيًا التي تتجاوز الحد الأقصى للعدد';

  @override
  String get remoteFilterSettings => 'إعدادات الفلتر عن بعد';

  @override
  String get remoteFilterSettingsPageTitle => 'إعدادات فلتر الأرقام عن بعد';

  @override
  String get remoteNumberFilter => 'فلتر الأرقام عن بعد';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'يستخدم هذا الفلتر قاعدة بيانات خارجية مستقلة للحصول على أحدث معلومات الأرقام.';

  @override
  String get remoteNumberFilterDescription =>
      'اعتراض المكالمات المزعجة بناءً على معلومات قاعدة البيانات الخارجية';

  @override
  String get remoteNumberFilterExplanationContent =>
      'يقوم فلتر الأرقام الخارجي بتحديد وحظر المكالمات العشوائية عن طريق الاستعلام عن قاعدة بيانات خارجية بناءً على عدد الأرقام.';

  @override
  String get remoteNumberFilterExplanationTitle => 'شرح فلتر الأرقام عن بعد';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• حد العد: تحديده بناءً على تكرار حدوث الرقم';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• إجراءات الفلتر: تكوين كيفية التعامل مع الأرقام التي تتجاوز الحد';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• إعدادات الأولوية: تعيين الأولوية للإجراءات الخارجية';

  @override
  String get remoteNumberFilterFeatures => 'الميزات:';

  @override
  String get remoteNumberFiltering => 'فلترة الأرقام عن بعد';

  @override
  String get remoteNumberFilteringExplanation =>
      '• فلترة الأرقام عن بعد: قواعد فلترة بناءً على معلومات قاعدة البيانات الخارجية';

  @override
  String get remoteNumberFilterSubtitle =>
      'تحديد المكالمات العشوائية باستخدام قاعدة بيانات سحابية وتقارير مجتمعية';

  @override
  String get removeAdsDescription =>
      'قم بإزالة جميع الإعلانات في التطبيق بشكل دائم لتجربة أكثر سلاسة';

  @override
  String get removeAdsTitle => 'إزالة الإعلانات';

  @override
  String get removedFromFavoriteContacts =>
      'تمت الإزالة من جهات الاتصال المفضلة';

  @override
  String get removedFromFavorites => 'تمت الإزالة من المفضلة';

  @override
  String get removeFavorite => 'إزالة مفضل';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get renameButton => 'إعادة تسمية';

  @override
  String get renameDeviceDialogTitle => 'إعادة تسمية الجهاز';

  @override
  String get renameDeviceTitle => 'إعادة تسمية الجهاز';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'سيؤدي هذا إلى استبدال جميع إعداداتك الحالية. هل أنت متأكد من رغبتك في المتابعة؟';

  @override
  String get requestAllPermissions => 'طلب جميع الأذونات';

  @override
  String get requestPermission => 'طلب إذن';

  @override
  String requestPermissionFailed(Object error) {
    return 'فشل طلب الإذن: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count علامات';
  }

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get restore => 'استعادة';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'استعادة إعدادات التطبيق من النسخة الاحتياطية';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'استعادة إعدادات التطبيق من النسخة الاحتياطية';

  @override
  String get restoreButton => 'استعادة';

  @override
  String restoreFailedWithError(Object error) {
    return 'فشل الاستعادة من السحابة: $error';
  }

  @override
  String get restoreFromCloud => 'استعادة من السحابة';

  @override
  String get restoreFromCloudDescription =>
      'استعادة الإعدادات والقواعد من التخزين السحابي';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'فشل الاستعادة من السحابة: $error';
  }

  @override
  String get restoreFromCloudLabel => 'استعادة من السحابة';

  @override
  String get restoreFromCloudSuccess => 'تمت الاستعادة بنجاح من السحابة';

  @override
  String get restoreFromCloudTitle => 'استعادة من السحابة';

  @override
  String get restoreFromLocal => 'استعادة من المحلية';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get restoreSectionTitle => 'استعادة';

  @override
  String get restoreSettings => 'استعادة الإعدادات';

  @override
  String get restoreSettingsConfirmation =>
      'سيؤدي هذا إلى استبدال جميع إعداداتك الحالية. هل أنت متأكد من رغبتك في المتابعة؟';

  @override
  String get restoreSettingsDialogTitle => 'استعادة الإعدادات';

  @override
  String get restoreSettingsTitle => 'استعادة الإعدادات';

  @override
  String get restoreSuccessFromLocal => 'تمت الاستعادة بنجاح من المحلية';

  @override
  String get restoreSuccessMessage => 'تمت الاستعادة بنجاح من السحابة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get ridesharing => 'مشاركة الرحلات';

  @override
  String get risk => 'خطر';

  @override
  String get robocall => 'مكالمة آلية';

  @override
  String get ruleAction => 'إجراء القاعدة';

  @override
  String get ruleAddButton => 'إضافة قاعدة';

  @override
  String get ruleAddedSuccess => 'تمت إضافة القاعدة بنجاح';

  @override
  String ruleAddFailure(Object error) {
    return 'فشل في إضافة القاعدة: $error';
  }

  @override
  String get ruleAddSuccess => 'تمت إضافة القاعدة بنجاح';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'هل أنت متأكد من رغبتك في حذف $ruleType هذا؟';
  }

  @override
  String get ruleDeleteConfirmTitle => 'حذف القاعدة';

  @override
  String get ruleDeletedSuccess => 'تم حذف القاعدة بنجاح';

  @override
  String get ruleDeletedSuccessfully => 'تم حذف القاعدة بنجاح';

  @override
  String ruleDeleteFailed(Object error) {
    return 'فشل في حذف القاعدة: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'فشل في حذف القاعدة: $error';
  }

  @override
  String get ruleDeleteSuccess => 'تم حذف القاعدة بنجاح';

  @override
  String get ruleDisabledSuccessfully => 'تم تعطيل القاعدة بنجاح';

  @override
  String get ruleEnabledSuccessfully => 'تم تمكين القاعدة بنجاح';

  @override
  String ruleLoadFailed(Object error) {
    return 'فشل في تحميل القواعد: $error';
  }

  @override
  String get ruleManagement => 'إدارة القواعد';

  @override
  String get ruleManagementTitle => 'إدارة القواعد';

  @override
  String get ruleName => 'اسم القاعدة';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'لا يمكن أن يكون اسم القاعدة ومحتوى regex فارغين';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'لا يمكن أن يكون اسم القاعدة ورقم الهاتف فارغين';

  @override
  String get ruleNameHint => 'مثال: عائلة، أصدقاء، إلخ.';

  @override
  String get ruleNameLabel => 'اسم القاعدة';

  @override
  String get ruleNamePatternRequired => 'الرجاء إدخال اسم القاعدة والنمط';

  @override
  String get ruleNameRequired =>
      'لا يمكن أن يكون اسم القاعدة ورقم الهاتف فارغين';

  @override
  String get ruleNotExist => 'القاعدة غير موجودة أو تم حذفها';

  @override
  String ruleNotFound(Object error) {
    return 'القاعدة غير موجودة: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'تم حفظ القاعدة بنجاح!';

  @override
  String get ruleSavedSuccessMessage => 'تم حفظ القاعدة بنجاح!';

  @override
  String ruleSaveFailed(Object error) {
    return 'فشل الحفظ: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'فشل الحفظ: $error';
  }

  @override
  String get ruleSaveSuccess => 'تم حفظ القاعدة بنجاح!';

  @override
  String get rulesExportedSuccessfully => 'تم تصدير القواعد بنجاح';

  @override
  String rulesExportedTo(Object path) {
    return 'تم تصدير القواعد إلى: $path';
  }

  @override
  String get rulesImported => 'تم استيراد القواعد بنجاح';

  @override
  String rulesImportedSuccessfully(Object count) {
    return 'تم استيراد $count قاعدة بنجاح';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'فشل استيراد القواعد: $error';
  }

  @override
  String get ruleStatistics => 'إحصائيات القاعدة';

  @override
  String ruleStatusChanged(Object status) {
    return 'تم تغيير حالة القاعدة إلى $status بنجاح';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'فشلت العملية: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'تم تغيير حالة القاعدة إلى $status بنجاح';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'فشل تحديث القاعدة: $error';
  }

  @override
  String get ruleUpdateSuccess => 'تم تحديث القاعدة بنجاح';

  @override
  String get ruleVerification => 'التحقق من القاعدة';

  @override
  String get save => 'حفظ';

  @override
  String get saveButton => 'حفظ';

  @override
  String get saveButtonLabel => 'حفظ';

  @override
  String get saveButtonText => 'حفظ';

  @override
  String saveFailed(Object error) {
    return 'فشل الحفظ: $error';
  }

  @override
  String get saveFilter => 'حفظ الفلتر';

  @override
  String get saveSettings => 'حفظ الإعدادات';

  @override
  String saveSettingsFailed(Object error) {
    return 'فشل حفظ الإعدادات: $error';
  }

  @override
  String get scamsLikely => 'عمليات احتيال محتملة';

  @override
  String get search => 'بحث';

  @override
  String get searchContacts => 'بحث عن جهات الاتصال';

  @override
  String searchError(Object error) {
    return 'خطأ في البحث: $error';
  }

  @override
  String get searchFilters => 'فلاتر البحث';

  @override
  String get searchForContacts => 'ابحث عن جهات الاتصال';

  @override
  String get searchHint => 'بحث...';

  @override
  String get searchSettingsSubtitle =>
      'البحث عن جهات الاتصال، الملصقات، القوائم السوداء، القوائم البيضاء، إلخ.';

  @override
  String get searchSettingsTitle => 'إعدادات البحث';

  @override
  String get securityMessage =>
      'لا تثق بأي مكالمات هاتفية. تحقق دائمًا من أرقام خدمة العملاء بشكل مستقل. لا تشارك أبدًا كلمات المرور، رموز التحقق، أرقام البطاقات، أو المعلومات الشخصية.';

  @override
  String get selectActionToPerform =>
      'حدد الإجراء المراد تنفيذه عند مطابقة القاعدة';

  @override
  String get selectActionWhenBlockingCalls => 'حدد الإجراء عند حظر المكالمات';

  @override
  String get selectActionWhenRuleMatches => 'حدد الإجراء عند مطابقة القاعدة';

  @override
  String get selectAll => 'تحديد الكل';

  @override
  String get selectCountry => 'تحديد الدولة';

  @override
  String get selectDateRange => 'تحديد نطاق التاريخ';

  @override
  String get selectedDateRange => 'نطاق التاريخ المحدد';

  @override
  String selectedItems(Object count) {
    return 'تم تحديد $count عنصر';
  }

  @override
  String get selectedLabel => 'محدد:';

  @override
  String get selectExportFormat => 'تحديد تنسيق التصدير';

  @override
  String get selectLabel => 'تحديد الملصق';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'الرجاء تحديد ملصق وإدخال رقم هاتف صالح';

  @override
  String get selectLanguage => 'تحديد اللغة';

  @override
  String get selectMultiple => 'تحديد متعدد';

  @override
  String get selectPeriod => 'تحديد الفترة';

  @override
  String get selectSimCard => 'تحديد بطاقة SIM';

  @override
  String get selectSimSlot => 'تحديد فتحة SIM';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'حدد الإجراء المحدد الذي سيتم تنفيذه عند حظر المكالمات';

  @override
  String get selectTag => 'تحديد الوسم';

  @override
  String get selectTags => 'تحديد الوسوم';

  @override
  String get selectTrustedDataSource => 'الرجاء تحديد مصادر بيانات موثوقة';

  @override
  String get selectYourLanguage => 'حدد لغتك';

  @override
  String get sender => 'المرسل';

  @override
  String get senderRegexOptional => 'تعبير نمطي للمرسل (اختياري)';

  @override
  String get serverAddressLabel => 'عنوان الخادم';

  @override
  String get serviceTypeContact => 'اشتراك جهة الاتصال';

  @override
  String get serviceTypeLabel => 'نوع الخدمة';

  @override
  String get serviceTypePhone => 'اشتراك الهاتف';

  @override
  String get serviceTypePlugin => 'تحديث الإضافة';

  @override
  String get serviceTypeSms => 'اشتراك الرسائل القصيرة';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'تعيين';

  @override
  String get setEncryptionPassword => 'تعيين كلمة مرور التشفير';

  @override
  String get setEncryptionPasswordDescription =>
      'تعيين كلمة مرور التشفير للنسخ الاحتياطي والاستعادة';

  @override
  String get setEncryptionPasswordLabel => 'تعيين كلمة مرور التشفير';

  @override
  String get setEncryptionPasswordTitle => 'تعيين كلمة مرور التشفير';

  @override
  String get setPasswordButton => 'تعيين';

  @override
  String get settings => 'الإعدادات';

  @override
  String settingsBackedUpTo(Object path) {
    return 'تم النسخ الاحتياطي للإعدادات إلى: $path';
  }

  @override
  String get settingsLoaded => 'تم تحميل الإعدادات';

  @override
  String settingsLoadFailed(Object error) {
    return 'فشل تحميل الإعدادات: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'تم استعادة الإعدادات بنجاح. الرجاء إعادة تشغيل التطبيق لتطبيق التغييرات.';

  @override
  String get settingsSaved => 'تم حفظ الإعدادات';

  @override
  String settingsSaveFailed(Object error) {
    return 'فشل حفظ الإعدادات: $error';
  }

  @override
  String get settingsTab => 'الإعدادات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get setup => 'إعداد';

  @override
  String get showContactEditDialogStaticMethod =>
      'طريقة ثابتة لعرض مربع حوار تحرير جهة الاتصال';

  @override
  String get showExplanation => 'عرض الشرح';

  @override
  String get silence => 'صمت';

  @override
  String get silenceAndNoAnswer => 'صمت وعدم الرد';

  @override
  String get silenceNoAnswer => 'صمت وعدم الرد';

  @override
  String get silentCallVoiceClone => 'استنساخ صوت مكالمة صامتة';

  @override
  String get silentRules => 'قواعد الصمت';

  @override
  String simCard(Object simNumber) {
    return 'بطاقة SIM $simNumber';
  }

  @override
  String get simCardColor => 'لون بطاقة SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• إعدادات بطاقة SIM: قم بتعيين قواعد فلترة مستقلة لكل بطاقة SIM';

  @override
  String get simCardFilterRules => 'قواعد فلترة بطاقة SIM';

  @override
  String get simCardFilterRulesDescription =>
      'قم بتعيين قواعد فلترة مختلفة بناءً على فتحات بطاقة SIM';

  @override
  String get simCardFontSize => 'حجم خط بطاقة SIM';

  @override
  String get simCardPosition => 'موضع بطاقة SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'بطاقة SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'فشل تحميل معلومات بطاقة SIM: $error';
  }

  @override
  String get simRuleInstructions =>
      'تسمح لك قواعد فتحة SIM بتكوين قواعد تصفية مستقلة لكل فتحة SIM.';

  @override
  String get simRuleInstructionsTitle => 'قواعد فتحة SIM';

  @override
  String get simRuleManagement => 'إدارة قواعد فتحة SIM';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1،-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2،-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'فشل تحميل بيانات SIM: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'تهيئة مرشح فتحة SIM';

  @override
  String get simSlotFilterConfigurationDescription =>
      'السماح بتعيين قواعد التصفية حسب فتحة SIM';

  @override
  String get simSlotFilterDescription =>
      'قم بتكوين قواعد تصفية مستقلة لكل بطاقة SIM:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'إعدادات مرشح فتحة SIM $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'فشل تحميل فتحات SIM: $error';
  }

  @override
  String get simSlotManagement => 'إدارة فتحات SIM';

  @override
  String simSlotOperationFailed(Object error) {
    return 'فشل عملية فتحة SIM: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'موضع فتحة SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• قواعد فتحة SIM: استراتيجيات تصفية مستقلة لكل SIM';

  @override
  String get simSlotRuleListTitle => 'قائمة قواعد فتحة SIM';

  @override
  String get simSlotRuleManagement => 'قواعد فتحة SIM';

  @override
  String get simSlotRuleManagementTitle => 'إدارة القواعد';

  @override
  String get simSlotSettings => 'إعدادات فتحة SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'فتحة SIM $slotNumber';
  }

  @override
  String get skip => 'تخطي';

  @override
  String get smartCallerId => 'تحديد هوية المتصل الذكية';

  @override
  String get sms => 'رسالة نصية قصيرة';

  @override
  String get smsFilterDescription =>
      'يساعدك تصفية الرسائل القصيرة على تصفية رسائل البريد العشوائي تلقائيًا والحفاظ على نظافة قائمة الرسائل الخاصة بك. يمكنك تعيين قواعد التصفية وطرق الإشعارات.';

  @override
  String get smsFilterDisabled => 'تم تعطيل تصفية الرسائل القصيرة';

  @override
  String get smsFilterEnabled => 'تم تمكين تصفية الرسائل القصيرة';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'تمت إضافة قاعدة تصفية الرسائل القصيرة بنجاح';

  @override
  String get smsFilterRules => 'قواعد تصفية الرسائل القصيرة';

  @override
  String get smsFilterSettings => 'إعدادات تصفية الرسائل القصيرة';

  @override
  String get smsHistory => 'سجل الرسائل القصيرة';

  @override
  String get smsManagement => 'إدارة الرسائل القصيرة';

  @override
  String get smsPermission => 'إذن الرسائل القصيرة';

  @override
  String get smsPermissionDescription => 'يستخدم لتصفية رسائل البريد العشوائي.';

  @override
  String get smsRuleAddedSuccessfully =>
      'تمت إضافة قاعدة الرسائل القصيرة بنجاح';

  @override
  String get smsRuleDeletedSuccessfully => 'تم حذف قاعدة الرسائل القصيرة بنجاح';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'فشل تحميل قواعد الرسائل القصيرة: $error';
  }

  @override
  String get smsRuleManagement => 'إدارة قواعد الرسائل القصيرة';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'تم تصدير قواعد الرسائل القصيرة بنجاح إلى $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'تم استيراد قواعد الرسائل القصيرة بنجاح';

  @override
  String get smsRuleSubscription => 'اشتراك قاعدة الرسائل القصيرة';

  @override
  String get smsRuleUpdatedSuccessfully =>
      'تم تحديث قاعدة الرسائل القصيرة بنجاح';

  @override
  String get smsSettingsSubtitle =>
      'تصفية الرسائل القصيرة وحظر الكلمات الرئيسية';

  @override
  String get smsSettingsTitle => 'إعدادات الرسائل القصيرة';

  @override
  String get smsSubscription => 'اشتراك الرسائل القصيرة';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'تمت إضافة اشتراك الرسائل القصيرة بنجاح';

  @override
  String get smsSubscriptionRulesDescription =>
      'اشترك في قوائم قواعد الرسائل القصيرة عبر URL، مع دعم مطابقة التعبيرات العادية. يمكنك تعيين إجراءات الحظر أو السماح.';

  @override
  String get smsTab => 'رسالة نصية قصيرة';

  @override
  String get somePermissionsDenied => 'تم رفض بعض طلبات الإذن';

  @override
  String get spamLikely => 'احتمالية بريد عشوائي';

  @override
  String get startColor => 'لون البدء';

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String get startUsing => 'البدء';

  @override
  String get statAnswered => 'تم الرد';

  @override
  String get statBlocked => 'تم الحظر';

  @override
  String get staticMethodShowCallerIdDialog =>
      'طريقة ثابتة لعرض مربع حوار معلومات هوية المتصل';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'طريقة ثابتة لعرض مربع حوار اختيار البلد';

  @override
  String get staticMethodToDisplayDialog => 'طريقة ثابتة لعرض مربع حوار';

  @override
  String get statistics => 'إحصائيات';

  @override
  String get statisticsExportFeatureComingSoon =>
      'ميزة تصدير الإحصائيات قادمة قريبًا';

  @override
  String get statisticsGrid => 'شبكة الإحصائيات';

  @override
  String get statisticsPageTitle => 'تحليل البيانات';

  @override
  String get stirColor => 'لون STIR';

  @override
  String get stirFontSize => 'حجم خط STIR';

  @override
  String get stirPosition => 'موضع STIR';

  @override
  String get storagePermission => 'إذن التخزين';

  @override
  String get storagePermissionDescription => 'يستخدم لحفظ الإعدادات والقواعد.';

  @override
  String get subscribe => 'اشترك';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'تمت إضافة الاشتراك \"$name\" بنجاح';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'هل أنت متأكد أنك تريد حذف هذا الاشتراك؟';

  @override
  String get subscriptionDeleteConfirmTitle => 'حذف الاشتراك';

  @override
  String get subscriptionDeleted => 'تم حذف الاشتراك';

  @override
  String get subscriptionDeletedSuccessfully => 'تم حذف الاشتراك بنجاح';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'فشل حذف الاشتراك: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'تم حذف الاشتراك';

  @override
  String get subscriptionEmptyState => 'لا توجد اشتراكات متاحة';

  @override
  String get subscriptionEmptyText => 'لا توجد اشتراكات حتى الآن';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'فشل تحميل الاشتراكات: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'فشل تحميل الاشتراكات: $error';
  }

  @override
  String get subscriptionManagementTitle => 'إدارة الاشتراكات';

  @override
  String get subscriptionName => 'اسم الاشتراك';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'لا يمكن أن يكون اسم الاشتراك وعنوان URL فارغين';

  @override
  String get subscriptionNameHint => 'أدخل اسم الاشتراك';

  @override
  String get subscriptionPageTitle => 'إدارة الاشتراكات';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'فشل تغيير حالة الاشتراك: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'فشل تبديل حالة الاشتراك: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'فشل تحديث الاشتراك: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'تم تحديث الاشتراك بنجاح';

  @override
  String get subscriptionUrl => 'عنوان URL للاشتراك';

  @override
  String get subscriptionUrlHint => 'أدخل عنوان URL للاشتراك';

  @override
  String successfullyImportedRules(Object count) {
    return 'تم استيراد $count قاعدة بنجاح';
  }

  @override
  String get supportSync => 'دعم المزامنة';

  @override
  String get survey => 'استبيان';

  @override
  String get syncDevicesButton => 'مزامنة الأجهزة';

  @override
  String get syncFailed => 'فشلت المزامنة';

  @override
  String get syncFailedMessage => 'فشلت المزامنة';

  @override
  String get syncFolderNameHint =>
      'يرجى إدخال اسم مجلد المزامنة (افتراضي: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'اسم مجلد المزامنة';

  @override
  String get synchronized => 'تمت المزامنة';

  @override
  String get syncing => 'جاري المزامنة...';

  @override
  String get syncNow => 'مزامنة الآن';

  @override
  String get syncNowButton => 'مزامنة الآن';

  @override
  String get syncStatusTitle => 'حالة المزامنة';

  @override
  String get syncStatusUpdatedMessage => 'تم تحديث حالة المزامنة';

  @override
  String get syncSuccessful => 'تمت المزامنة بنجاح';

  @override
  String get syncSuccessMessage => 'تمت المزامنة بنجاح';

  @override
  String get syncWithCloudStorage => 'المزامنة مع التخزين السحابي';

  @override
  String get syncWithCloudStorageSubtitle => 'المزامنة مع التخزين السحابي';

  @override
  String get systemFeatures => 'ميزات النظام:';

  @override
  String get systemSettingsTitle => 'إعدادات النظام';

  @override
  String get tabAll => 'الكل';

  @override
  String get tabAnswered => 'تم الرد عليها';

  @override
  String get tabBlocked => 'محظورة';

  @override
  String get tabMissed => 'لم يتم الرد عليها';

  @override
  String get tabOutgoing => 'صادرة';

  @override
  String tagLabel(String tag) {
    return 'علامة: $tag';
  }

  @override
  String get tagsUpdated => 'تم تحديث العلامات';

  @override
  String get takeaway => 'الوجبات الجاهزة';

  @override
  String get telecommunication => 'الاتصالات';

  @override
  String get telegram => 'تيليجرام';

  @override
  String get telemarketing => 'التسويق عبر الهاتف';

  @override
  String get testButton => 'اختبار';

  @override
  String get testButtonLabel => 'اختبار';

  @override
  String get testConnectionButton => 'اختبار الاتصال';

  @override
  String get textColorsSetting => 'ألوان النص والتسمية';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'هذا التطبيق هو أداة قوية لمعرف المتصل تتيح لك تحديد وحظر المكالمات غير المرغوب فيها.';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get timeInterceptor => ' اعتراض الوقت';

  @override
  String get timeInterceptorDescription =>
      'اعتراض/السماح تلقائيًا بالمكالمات المحتملة بناءً على تكرار المكالمات';

  @override
  String get timeInterceptorExplanation =>
      '• اعتراض الوقت: اعتراض/السماح بالمكالمات المتكررة في فترة زمنية قصيرة';

  @override
  String get timeInterceptorExplanationContent =>
      'تقوم ميزة اعتراض تكرار المكالمات بتحليل تكرار المكالمات لتحديد واعتراض/السماح تلقائيًا بمكالمات البريد العشوائي المتكررة.';

  @override
  String get timeInterceptorExplanationTitle => 'شرح اعتراض تكرار المكالمات';

  @override
  String get timeInterceptorSettingsTitle => 'إعدادات اعتراض تكرار المكالمات';

  @override
  String get timeInterceptorSubtitle =>
      'اعتراض المكالمات المحتملة العشوائية تلقائيًا بناءً على تكرار المكالمات';

  @override
  String get timeInterceptorTitle => 'تمكين اعتراض تكرار المكالمات';

  @override
  String get timeWindowDescription =>
      'قم بتعيين حجم نافذة الوقت للسماح بالمكالمات المتكررة. سيتم السماح بالمكالمات من نفس الرقم ضمن هذه النافذة';

  @override
  String timeWindowLabel(int minutes) {
    return 'نافذة وقت الاعتراض (دقائق): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'قم بتعيين حجم نافذة الوقت للسماح بالمكالمات المتكررة. سيتم السماح بالمكالمات من نفس الرقم ضمن هذه النافذة';

  @override
  String get today => 'اليوم';

  @override
  String get total => 'الإجمالي';

  @override
  String get totalBlocked => 'إجمالي المحظور';

  @override
  String get totalFiltered => 'إجمالي المفلتر';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'نقل البيانات بين الأجهزة أو المنصات';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'نقل البيانات بين الأجهزة أو المنصات';

  @override
  String get travelTicketing => 'تذاكر السفر';

  @override
  String get trend => 'الاتجاه';

  @override
  String get trendChart => 'مخطط الاتجاه';

  @override
  String get tutorial => 'برنامج تعليمي';

  @override
  String get type => 'النوع';

  @override
  String get unassignedSIMCard => 'بطاقة SIM غير معينة';

  @override
  String get unknown => 'غير معروف';

  @override
  String get unknownLabel => 'تسمية غير معروفة';

  @override
  String get unknownTag => 'علامة: غير معروف';

  @override
  String get unregisterButton => 'إلغاء التسجيل';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'هل أنت متأكد أنك تريد إلغاء تسجيل $deviceName؟';
  }

  @override
  String get unregisterDeviceTitle => 'إلغاء تسجيل الجهاز';

  @override
  String get unsupportedFileFormat => 'تنسيق ملف غير مدعوم';

  @override
  String get update => 'تحديث';

  @override
  String get updateAllNow => 'تحديث الكل الآن';

  @override
  String get updateCallFilterConfig => 'تحديث تكوين مرشح المكالمات';

  @override
  String updateContactFailed(Object error) {
    return 'فشل تحديث جهة الاتصال: $error';
  }

  @override
  String get updateFavoriteStatus => 'تحديث حالة المفضلة';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'فشل تحديث حالة المفضلة: $error';
  }

  @override
  String get updateInterval => 'فاصل التحديث';

  @override
  String get updateLabelFailed => 'فشل تحديث التسمية';

  @override
  String get updateNow => 'تحديث الآن';

  @override
  String get updatePlugin => 'تحديث المكون الإضافي';

  @override
  String updatePluginFailed(Object error) {
    return 'فشل تحديث المكون الإضافي: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'فشل تحديث القاعدة: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'فشل تحديث الاشتراك: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return 'تم تحديث $service بنجاح ($count قواعد)';
  }

  @override
  String get updateTags => 'تحديث العلامات';

  @override
  String get useCasesPoint1 =>
      '• تحديد مكالمات البريد العشوائي التي تعيد الاتصال تلقائيًا';

  @override
  String get useCasesPoint2 =>
      '• اعتراض مكالمات التسويق التي تتصل عدة مرات في فترة قصيرة';

  @override
  String get useCasesPoint3 => '• منع التفجير الهاتفي والمضايقة';

  @override
  String get useCasesTitle => 'حالات الاستخدام:';

  @override
  String get useGlobalSettings => 'استخدام الإعدادات العامة';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'اسم المستخدم';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'استخدم صيغة regex القياسية لتحديد الأنماط. أمثلة:';

  @override
  String get validateRegex => 'التحقق من صحة Regex';

  @override
  String get verificationFailedText => 'فشل';

  @override
  String get verifiedText => 'تم التحقق';

  @override
  String get verify => 'تحقق';

  @override
  String version(Object version) {
    return 'الإصدار: $version';
  }

  @override
  String get vipExchangeDescription =>
      'تبادل عضوية VIP مع عدد علامات رقم الهاتف';

  @override
  String get vipExchangeTitle => 'تبادل VIP العلامة';

  @override
  String get watchAd => 'مشاهدة الإعلان';

  @override
  String get watchAdForTemp => 'مشاهدة الإعلان للمزايا المؤقتة';

  @override
  String get watchAdForTempDescription =>
      'شاهد إعلانًا قصيرًا لفتح بعض الميزات المميزة مؤقتًا';

  @override
  String get webDAVConfigTitle => 'إعدادات WebDAV';

  @override
  String get webdavConfigurationTitle => 'إعدادات WebDAV';

  @override
  String get webdavPasswordHint => 'يرجى إدخال كلمة مرور WebDAV';

  @override
  String get webdavServerAddressHint => 'يرجى إدخال عنوان خادم WebDAV';

  @override
  String get webdavUsernameHint => 'يرجى إدخال اسم مستخدم WebDAV';

  @override
  String get week => 'الأسبوع';

  @override
  String get weekly => 'أسبوعي';

  @override
  String get weeklyBlockedCallsSummary => 'ملخص المكالمات المحظورة الأسبوعي';

  @override
  String get weeklyChartTitle => 'المكالمات المحظورة الأسبوعية';

  @override
  String get weeklyReport => 'تقرير أسبوعي';

  @override
  String get weeklyReportDesc => 'تلقي تقرير ملخص أسبوعي لنشاط حظر المكالمات';

  @override
  String get welcome => 'أهلاً وسهلاً';

  @override
  String get whitelist => 'القائمة البيضاء';

  @override
  String get whitelistLabel => 'القائمة البيضاء';

  @override
  String get width => 'العرض';

  @override
  String get wildcardMatchingDescription =>
      'استخدم \'.\' لمطابقة أي حرف (على سبيل المثال، \'123.456\' تطابق 123-456)';

  @override
  String get wildcardMatchingTitle => 'مطابقة الأحرف البديلة:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'دعم الأحرف البديلة للتصفية المرنة';

  @override
  String get windowSizeSetting => 'حجم النافذة';

  @override
  String get year => 'سنة';

  @override
  String get yearly => 'سنوي';

  @override
  String get yearlyChartTitle => 'المكالمات المحظورة السنوية';

  @override
  String get noSimCardsDetected => 'لم يتم اكتشاف بطاقات SIM';

  @override
  String get filterManagementDescription => 'تعيين مرشحات المكالمات';

  @override
  String get callerIdCustomizationSubtitle => 'تخصيص تخطيط معرّف المتصل';

  @override
  String get fraudAlerSettingTitle => 'إعداد تنبيه الاحتيال';

  @override
  String get fraudAlerSettingSubtitle => 'لتعيين تنبيه الاحتيال';

  @override
  String get enableFraudAlert => 'تمكين تنبيه الاحتيال';

  @override
  String get enableFraudAlertDescription =>
      'تنبيه للمكالمات المشتبه بها كاحتيال';

  @override
  String get enableVibration => 'تمكين الاهتزاز';

  @override
  String get enableVibrationDescription =>
      'اهتزاز عند الاشتباه في مكالمة احتيالية';

  @override
  String get notificationSettingsTitle => 'إعدادات الإشعارات';

  @override
  String get useLocalNotification => 'استخدام الإشعارات المحلية';

  @override
  String get useLocalNotificationDescription =>
      'تمكين الإشعارات المحلية للمكالمات الواردة';

  @override
  String get cancelLocalNotification => 'إغلاق الإشعارات المحلية';

  @override
  String get useStirNotification => 'استخدام الإشعارات من STIR';

  @override
  String get useStirNotificationDescription =>
      'تمكين إشعارات STIR للمكالمات الواردة';

  @override
  String get cancelLocalNotificationDescription =>
      'إغلاق الإشعارات المحلية تلقائيًا';

  @override
  String get callerIdSettingsTitle => 'إعدادات معرّف المتصل';

  @override
  String get callerIdSettingsSubtitle => 'لإعداد إشعار وعرض المكالمات الواردة';

  @override
  String get purchaseTitle => 'شراء';

  @override
  String get purchaseSubtitle => 'لشراء الخدمة';

  @override
  String get callerIdNotificationTitle => 'معلومات المكالمة الواردة';

  @override
  String callerIdBody(String phoneNumber) {
    return 'الرقم: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'مكالمة محظورة';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'مكالمة محظورة من $phoneNumber';
  }

  @override
  String get stirVerified => 'تم التحقق';

  @override
  String get stirNotVerified => 'لم يتم التحقق';

  @override
  String get stirFailed => 'فشل التحقق';

  @override
  String get stirUnknown => 'حالة التحقق غير معروفة';

  @override
  String get stirVerificationTitle => 'التحقق من STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage للرقم $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'إعدادات رسائل الأمان المتحركة';

  @override
  String get messageColor => 'لون الرسالة';

  @override
  String get messageFontSize => 'حجم خط الرسالة';

  @override
  String get messagePosition => 'موضع الرسالة';

  @override
  String get containerWidth => 'عرض الحاوية';

  @override
  String get scrollSpeed => 'سرعة التمرير';

  @override
  String get enableSecurityMessage => 'تمكين رسالة الأمان';

  @override
  String get fraudAlertTitle => 'تنبيه الاحتيال';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'مكالمة احتيال محتملة من $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'فشل تحميل القواعد: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'فشل تحميل سجل المكالمات: $error';
  }

  @override
  String get noBlockedTypeData => 'لا توجد بيانات نوع محظور متاحة';

  @override
  String importEntity(Object entityTypeName) {
    return 'استيراد $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return 'تم استيراد $entityTypeName بنجاح، تم استيراد $count سجل إجمالاً';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'فشل استيراد $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'تصدير $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return 'تم تصدير $entityTypeName بنجاح';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'فشل تصدير $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'خدمة مزامنة السحابة';

  @override
  String get membershipCenter => 'مركز العضوية';

  @override
  String get redeemVipWithMarks => 'استبدال VIP بالعلامات';

  @override
  String get currentMarkCount => 'عدد العلامات الحالي';

  @override
  String get markMoreNumbersForMore =>
      'ضع علامة على المزيد من الأرقام للحصول على المزيد من العلامات';

  @override
  String get noAds => 'لا إعلانات';

  @override
  String get cloudBackup => 'نسخ احتياطي سحابي';

  @override
  String get callerIdEnhancement => 'تحسين معرّف المتصل';

  @override
  String get voiceRecognition => 'التعرف على الصوت';

  @override
  String get feature => 'ميزة';

  @override
  String get normalUser => 'مستخدم عادي';

  @override
  String get vipUser => 'مستخدم VIP';

  @override
  String get temporaryVip => 'VIP مؤقت';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get unknownAction => 'إجراء غير معروف';

  @override
  String get settingsBackup => 'نسخ احتياطي للإعدادات ';

  @override
  String get allServicesStatusTitle => 'حالة الخدمة الحالية';

  @override
  String get allServicesStatusSubtitle => 'الحالة الحالية لكل خدمة سحابية';

  @override
  String get redirect => 'إعادة توجيه';

  @override
  String get notify => 'إعلام';

  @override
  String get log => 'تسجيل';

  @override
  String get custom => 'مخصص';

  @override
  String get allowActionDescription =>
      'سيتم السماح بالمكالمات، حتى لو كان الرقم موجودًا في القائمة المحظورة.';

  @override
  String get blockActionDescription =>
      'سيتم حظر المكالمات وعرضها في سجل المكالمات.';

  @override
  String get silenceActionDescription =>
      'سيتم إسكات المكالمات ولكن سيتم عرضها في سجل المكالمات.';

  @override
  String get noneActionDescription => 'لن يتم اتخاذ أي إجراء خاص للمكالمة.';

  @override
  String get redirectActionDescription => 'إعادة توجيه المكالمة إلى رقم محدد.';

  @override
  String get labelActionDescription =>
      'إضافة تسمية للمكالمة لسهولة التعرف عليها.';

  @override
  String get notifyActionDescription => 'إرسال إشعار عند تلقي مكالمة.';

  @override
  String get logActionDescription =>
      'تسجيل معلومات المكالمة دون اتخاذ أي إجراءات أخرى.';

  @override
  String get customActionDescription => 'تنفيذ إجراء مخصص.';

  @override
  String get synced => 'تمت المزامنة';

  @override
  String get needVipAccess => 'تحتاج إلى وصول VIP لاستخدام هذه الميزة';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'استيراد أو تصدير بيانات $entityTypeName';
  }

  @override
  String get importExportTitle => 'استيراد/تصدير';

  @override
  String get noPhoneRules => 'لم يتم العثور على قواعد هاتف';

  @override
  String get noRegexRules => 'لم يتم العثور على قواعد تعبير عادي';

  @override
  String get noAllowedBlockedRules =>
      'لم يتم العثور على قواعد مسموح بها/محظورة';

  @override
  String get importExport => 'استيراد/تصدير';

  @override
  String get filterByAction => 'التصفية حسب الإجراء';

  @override
  String get upgradeToVip => 'الترقية إلى VIP';

  @override
  String get batteryOptimizationPermission => 'تحسين البطارية';

  @override
  String get batteryOptimizationPermissionDescription =>
      'اسمح للتطبيق بالعمل في الخلفية لتوفير خدمات مثل هوية المتصل.';

  @override
  String get permissionTitle => 'أذونات خاصة';

  @override
  String get permissionSubtitle => 'إدارة أذونات التراكب وتحسين البطارية';

  @override
  String get themeSettingsTitle => 'إعدادات المظهر';

  @override
  String get themeSettingsSubtitle => 'اختر المظهر المفضل لديك';

  @override
  String get databaseSyncTitle => 'مزامنة قاعدة البيانات';

  @override
  String get countrySyncSettingsTitle =>
      'إعدادات مزامنة قاعدة البيانات حسب البلد';

  @override
  String get countrySyncSettingsSubtitle => 'حدد البلدان لمزامنة البيانات';

  @override
  String get countryDataDisclaimer =>
      'يرجى ملاحظة: قد لا تتضمن قاعدة البيانات بيانات لجميع البلدان أو المناطق المحددة.';

  @override
  String get editSubscription => 'تعديل الاشتراك';

  @override
  String get searchByNameOrPhoneNumber => 'البحث بالاسم أو رقم الهاتف';

  @override
  String get allowedBlockedRulesInfo =>
      'تُستخدم القواعد المسموح بها/المحظورة لمطابقة المكالمات بأرقام هواتف محددة، والتي لها الأولوية القصوى.';

  @override
  String get searchPhoneRulesHint => 'البحث عن قواعد الهاتف';

  @override
  String get phoneRulesInfo =>
      'تُستخدم قواعد الهاتف لمطابقة المكالمات بأرقام هواتف محددة، والتي لها أولوية أقل. تأتي بعضها من اشتراكات phoneRule';

  @override
  String get searchSubscriptionsHint => 'البحث عن الاشتراكات';

  @override
  String get searchPluginsHint => 'البحث عن الإضافات';

  @override
  String get searchLabelsHint => 'البحث عن العلامات';

  @override
  String get pluginDescription => 'وصف الإضافة';

  @override
  String get enterPluginDescription => 'أدخل وصف الإضافة';

  @override
  String get searchRegexRulesHint => 'البحث عن قواعد Regex';

  @override
  String get regexRulesInfo =>
      'تُستخدم قواعد Regex لتصفية المكالمات بناءً على أنماط Regex.';

  @override
  String get searchMarkedPhonesHint => 'البحث عن الأرقام المميزة';

  @override
  String get searchContactSubscriptionsHint => 'البحث عن اشتراكات جهات الاتصال';

  @override
  String get showAllContacts => 'عرض كل جهات الاتصال';

  @override
  String get showFavorites => 'عرض المفضلة';

  @override
  String get manualEntry => 'معلومات الإدخال اليدوي';

  @override
  String get scriptSaved => 'تم حفظ البرنامج النصي';

  @override
  String editScriptFor(String pluginName) {
    return 'تعديل البرنامج النصي لـ $pluginName';
  }

  @override
  String get saveScript => 'حفظ البرنامج النصي';

  @override
  String get testPlugin => 'اختبار الإضافة';

  @override
  String get description => 'الوصف';

  @override
  String get accessTargetUrl => 'الوصول إلى عنوان URL المستهدف';

  @override
  String get result => 'النتيجة';

  @override
  String get editScript => 'تعديل البرنامج النصي';

  @override
  String get numberFormat => 'تنسيق الرقم';

  @override
  String get nationalNumber => 'رقم وطني';

  @override
  String get e164Number => 'رقم E164';

  @override
  String get pluginRulesInfo =>
      'لأسباب أمنية، يرجى استخدام الإضافات من مصادر موثوقة فقط. لا تتردد في استخدام قوالبنا لإنشاء إضافات مخصصة خاصة بك!';

  @override
  String get advancedMode => 'الوضع المتقدم';

  @override
  String get pleaseEnterAtLeastOneNumber => 'يرجى إدخال رقم واحد على الأقل.';

  @override
  String get openInWebView => 'فتح في WebView';

  @override
  String get pluginLabel => 'ملصق الإضافة';

  @override
  String get pluginID => 'المعرف';

  @override
  String get pluginURL => 'عنوان URL';

  @override
  String get messageBackgroundColor => 'لون خلفية الرسالة';

  @override
  String get clearAllCallLogs => 'مسح جميع سجلات المكالمات';

  @override
  String get clearAllCallLogsConfirmation => 'تأكيد مسح جميع سجلات المكالمات';

  @override
  String get allCallLogsCleared => 'تم مسح جميع سجلات المكالمات';

  @override
  String get unblocked => 'تم إلغاء الحظر';

  @override
  String get blockNumber => 'حظر الرقم';

  @override
  String get blockNumberSuccess => 'تم حظر الرقم بنجاح';

  @override
  String get blockNumberFailed => 'فشل حظر الرقم';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'هل أنت متأكد أنك تريد إلغاء حظر $phoneNumber؟';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'الاتصال بـ $phoneNumber...';
  }

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get unblock => 'إلغاء الحظر';

  @override
  String get unblockNumber => 'إلغاء حظر الرقم';

  @override
  String get unblockNumberSuccess => 'تم إلغاء حظر الرقم بنجاح';

  @override
  String get unblockNumberFailed => 'فشل إلغاء حظر الرقم';

  @override
  String get serviceNotAvailable => 'الخدمة غير متوفرة';

  @override
  String get callingNumberFailed => 'فشل الاتصال بالرقم';

  @override
  String get listView => 'عرض القائمة';

  @override
  String get timelineView => 'عرض المخطط الزمني';

  @override
  String get nameCannotBeEmpty => 'لا يمكن أن يكون الاسم فارغًا';

  @override
  String get selectAction => 'تحديد الإجراء';

  @override
  String get selectTargetService => 'تحديد الخدمة المستهدفة';

  @override
  String get callDetails => 'تفاصيل المكالمة';

  @override
  String get callType => 'نوع المكالمة';

  @override
  String get callTime => 'وقت المكالمة';

  @override
  String get numberInvalidFormat => 'تنسيق الرقم غير صالح';

  @override
  String get membershipFeature => 'ميزة العضوية';

  @override
  String get medium => 'متوسط';

  @override
  String get finalRisk => 'المخاطر النهائية';

  @override
  String get simState => 'حالة الشريحة';

  @override
  String get ipCountry => 'بلد IP';

  @override
  String get simCountry => 'بلد الشريحة';

  @override
  String get isRoaming => 'التجوال';

  @override
  String get isNumberMatch => 'مطابقة الرقم';

  @override
  String get support => 'الدعم';

  @override
  String get rewardedAdService => 'خدمة الإعلانات المكافأة';

  @override
  String get hasVipPrivilegeExceptAds =>
      'لديك بالفعل امتيازات VIP (باستثناء الإعلانات)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'لديك بالفعل امتيازات مؤقتة، تاريخ الانتهاء: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'تحتاج إلى مشاهدة $count إعلانات أخرى للحصول على امتيازات VIP مؤقتة';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'تم منحك $days أيام من امتيازات الشراء المؤقت. تاريخ الانتهاء: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'انتهت صلاحية امتياز الشراء المؤقت';

  @override
  String get loadingAd => 'جارٍ تحميل الإعلان...';

  @override
  String get earnedTempVip => 'تمت مكافأتك بـ VIP مؤقت';

  @override
  String get vipExchangeService => 'خدمة صرف VIP';

  @override
  String get marksInsufficient => 'علامات غير كافية للصرف';

  @override
  String get invalidExchangeRule => 'قاعدة صرف غير صالحة';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'تم الصرف بنجاح لـ $description، تاريخ الانتهاء: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'فشل الصرف: $error';
  }

  @override
  String get vip3DaysWithAds => '3 أيام VIP مع إعلانات (مزامنة فقط)';

  @override
  String get vip5DaysNoAds => '5 أيام VIP كاملة الميزات خالية من الإعلانات';

  @override
  String get vip7DaysNoAds => '7 أيام VIP كاملة الميزات خالية من الإعلانات';

  @override
  String get noNotifications => 'لا توجد إشعارات';

  @override
  String get clearAllNotifications => 'مسح جميع الإشعارات';

  @override
  String get clearAllNotificationsConfirmation => 'تأكيد مسح جميع الإشعارات';

  @override
  String get allNotificationsCleared => 'تم مسح جميع الإشعارات';

  @override
  String get clearButton => 'مسح';

  @override
  String get justNow => 'الآن';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قبل $count دقائق',
      one: 'قبل دقيقة واحدة',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قبل $count ساعات',
      one: 'قبل ساعة واحدة',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قبل $count أيام',
      one: 'قبل يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'أمس';

  @override
  String get deletionProposal => 'اقتراح حذف';

  @override
  String get createProposal => 'إنشاء اقتراح';

  @override
  String get createProposalTitle => 'إنشاء اقتراح حذف';

  @override
  String get reason => 'السبب';

  @override
  String get reasonOutdated => 'رقم قديم';

  @override
  String get reasonPrivacy => 'مخاوف تتعلق بالخصوصية';

  @override
  String get reasonNotInService => 'غير متوفر في الخدمة';

  @override
  String get reasonWronglyIdentified => 'تم التعرف عليه بشكل خاطئ';

  @override
  String get reasonInaccurateInfo => 'معلومات غير دقيقة';

  @override
  String get reasonWrongMarked => 'تم وضع علامة خاطئة';

  @override
  String get reasonOther => 'آخر';

  @override
  String get submit => 'إرسال';

  @override
  String get cancel => 'إلغاء';

  @override
  String get proposalStatus => 'الحالة';

  @override
  String get statusPending => 'معلق';

  @override
  String get statusActive => 'نشط';

  @override
  String get statusCompleted => 'مكتمل';

  @override
  String get statusExpired => 'منتهي الصلاحية';

  @override
  String get riskLevel => 'مستوى المخاطرة';

  @override
  String get riskLevelVerified => 'تم التحقق';

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
    return 'موافق: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'غير موافق: $count';
  }

  @override
  String totalVotes(int count) {
    return 'الإجمالي: $count';
  }

  @override
  String get voteAgree => 'موافق';

  @override
  String get voteDisagree => 'غير موافق';

  @override
  String createdAt(String date) {
    return 'تم الإنشاء: $date';
  }

  @override
  String get verificationReport => 'تقرير التحقق';

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
  String get loadingProposals => 'جارٍ تحميل الاقتراحات...';

  @override
  String get refreshProposals => 'تحديث الاقتراحات';

  @override
  String get totalPendingProposals => 'إجمالي الاقتراحات المعلقة';

  @override
  String get highRisk => 'مخاطرة عالية';

  @override
  String get mediumRisk => 'مخاطرة متوسطة';

  @override
  String get lowRisk => 'مخاطرة منخفضة';

  @override
  String get communityImpact => 'تأثير المجتمع';

  @override
  String get criticalIssues => 'مشكلات حرجة';

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
  String get proposalProcessed => 'تمت معالجة هذا الاقتراح';

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
  String get pending => 'معلق';

  @override
  String get critical => 'حرج';

  @override
  String get oppose => 'عارض';

  @override
  String get veryLow => 'منخفض جداً';

  @override
  String get deletionProposals => 'اقتراحات حذف';

  @override
  String get deletionProposalNotificationDescription =>
      'إشعارات حول نتائج وتحديثات تصويت اقتراحات الحذف.';

  @override
  String get deletionProposalCreated => 'تم إنشاء اقتراح الحذف';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'تم تقديم اقتراح الحذف الخاص بك للرقم $phoneNumber للمراجعة المجتمعية.';
  }

  @override
  String get proposalApproved => 'تمت الموافقة على الاقتراح ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'تمت الموافقة على اقتراح الحذف الخاص بالرقم $phoneNumber من قبل المجتمع ($supportPercentage% دعم، $totalVotes أصوات).';
  }

  @override
  String get proposalRejected => 'تم رفض الاقتراح ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'تم رفض اقتراح الحذف الخاص بالرقم $phoneNumber من قبل المجتمع ($supportPercentage% دعم، $totalVotes أصوات).';
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
  String get searchProposals => 'البحث عن اقتراحات';

  @override
  String get defaultNotifications => 'الإشعارات الافتراضية';

  @override
  String get defaultNotificationsDescription =>
      'قناة الإشعارات الافتراضية للتطبيق.';

  @override
  String get blockedCallNotifications => 'إشعارات المكالمات المحظورة';

  @override
  String get blockedCallNotificationsDescription =>
      'يعرض معلومات حول المكالمات المحظورة.';

  @override
  String get stirVerification => 'التحقق من STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'يعرض نتائج التحقق من STIR/SHAKEN للأرقام.';

  @override
  String get fraudAlerts => 'تنبيهات الاحتيال';

  @override
  String get fraudAlertsDescription =>
      'يعرض تحذيرات للمكالمات الاحتيالية المحتملة.';

  @override
  String get notificationFrequencyDescription =>
      'اختر عدد المرات التي تتلقى فيها إشعارات حول مقترحات الحذف الجديدة. يمكنك تلقيها فورًا، أو في دفعات، أو بفاصل زمني مخصص.';

  @override
  String get notificationMode => 'وضع الإشعارات';

  @override
  String get immediateNotifications => 'فوري';

  @override
  String get immediateNotificationsDescription =>
      'تلقي إشعار فور إنشاء اقتراح.';

  @override
  String get batchNotifications => 'مجمعة';

  @override
  String get batchNotificationsDescription => 'تلقي ملخص للإشعارات بشكل دوري.';

  @override
  String get customNotifications => 'مخصص';

  @override
  String get customNotificationsDescription =>
      'حدد الفاصل الزمني الخاص بك لتلقي الإشعارات.';

  @override
  String get customFrequency => 'التردد المخصص';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours ساعة';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours ساعة $minutes دقيقة';
  }

  @override
  String get pendingProposals => 'المقترحات المعلقة';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقترحات معلقة',
      one: '1 مقترح معلق',
      zero: 'لا توجد مقترحات معلقة',
    );
    return 'لديك $_temp0.';
  }

  @override
  String get guidelinesLabel => 'إرشادات';

  @override
  String get riskLevelLabel => 'مستوى المخاطرة';

  @override
  String get riskLevelDescription => 'مستوى مخاطرة الرقم';

  @override
  String get phoneNumberMinDigits =>
      'يجب أن يتكون رقم الهاتف من 7 أرقام على الأقل';

  @override
  String get provideDetailedExplanation =>
      'قدم شرحًا مفصلاً (10 أحرف على الأقل)';

  @override
  String get reasonMinCharacters => 'يجب أن يكون السبب 10 أحرف على الأقل';

  @override
  String get countryCodeTwoLetters => 'رمز البلد (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'رمز البلد (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'مثل: US، CN، GB';

  @override
  String get countryCodeRequired => 'رمز البلد مطلوب';

  @override
  String get countryCodeLengthError => 'يجب أن يتكون رمز البلد من حرفين';

  @override
  String get phoneNumberHint => 'أدخل رقم الهاتف';

  @override
  String get phoneNumberRequired => 'رقم الهاتف مطلوب';

  @override
  String get phoneNumberLengthError =>
      'يجب أن يتكون رقم الهاتف من 7 أرقام على الأقل';

  @override
  String get reasonHint => 'قدم شرحًا مفصلاً (10 أحرف على الأقل)';

  @override
  String get reasonRequired => 'السبب مطلوب';

  @override
  String get reasonLengthError => 'يجب أن يكون السبب 10 أحرف على الأقل';

  @override
  String get guidelinesTitle => 'إرشادات';

  @override
  String get guidelinesText =>
      '• قم بالإبلاغ عن الأرقام التي تمثل مشكلة حقيقية فقط\n• قدم أسبابًا دقيقة ومفصلة\n• اختر مستوى المخاطرة المناسب بناءً على الخطورة\n• قد يؤدي الإبلاغ الكاذب إلى تقييد الحساب';

  @override
  String get riskLevelCritical => 'حرج';

  @override
  String get riskLevelMedium => 'متوسط';

  @override
  String get riskLevelVeryLow => 'منخفض جدًا';

  @override
  String get riskDescriptionVeryLow =>
      'منخفض جدًا - إزعاج طفيف، مكالمات غير متكررة';

  @override
  String get riskDescriptionLow => 'منخفض - مكالمات غير مرغوب فيها عرضية';

  @override
  String get riskDescriptionMedium =>
      'متوسط - برامج غير مرغوب فيها منتظمة أو تسويق عبر الهاتف';

  @override
  String get riskDescriptionHigh => 'مرتفع - مضايقات مستمرة أو محاولات احتيال';

  @override
  String get riskDescriptionCritical => 'حرج - عمليات احتيال خطيرة أو تهديدات';

  @override
  String get notificationFrequencyTitle => 'تكرار الإشعارات';

  @override
  String get notificationFrequencyLabel => 'تكرار الإشعارات (ساعات)';

  @override
  String errorMessage(String error) {
    return 'خطأ: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'الأصوات: $totalVotes ($supportPercentage% دعم)';
  }

  @override
  String get timeJustNow => 'الآن';

  @override
  String timeMinutesAgo(int minutes) {
    return 'قبل $minutes دقيقة';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'قبل $hours ساعة';
  }

  @override
  String timeDaysAgo(int days) {
    return 'قبل $days يوم';
  }

  @override
  String get reportingGuidelines =>
      '• قم بالإبلاغ عن الأرقام التي تمثل مشكلة حقيقية فقط\n• قدم أسبابًا دقيقة ومفصلة\n• اختر مستوى المخاطرة المناسب بناءً على الخطورة\n• قد يؤدي الإبلاغ الكاذب إلى تقييد الحساب';

  @override
  String get notificationFrequencyHours => 'تكرار الإشعارات (ساعات)';

  @override
  String supportCount(int supportCount) {
    return 'دعم ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'معارضة ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes صوت ($supportPercentage% دعم)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ساعات',
      one: '1 ساعة',
      zero: '0 ساعات',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'ملاحظة هامة';

  @override
  String get dataSourceDisclaimer =>
      'يتم الحصول على الأرقام من الإنترنت ومساهمات المستخدمين. لا يمكننا ضمان عدم إعادة تقديم رقم، بمجرد حذفه، من قبل مستخدمين أو مصادر أخرى. يرجى البحث والتحقق من المعلومات بنشاط.';

  @override
  String get avatar => 'صورة شخصية';

  @override
  String get location => 'الموقع';

  @override
  String get simCardTitle => 'بطاقة SIM';

  @override
  String get liveActivitiesSettingsTitle => 'إعدادات الأنشطة المباشرة';

  @override
  String get elementsSettingsTitle => 'إعدادات العناصر';

  @override
  String get liveActivityMode => 'النشاط المباشر';

  @override
  String get liveActivityModeDescription =>
      'يعرض معلومات المكالمة كإشعار دائم على شاشة القفل وفي الجزيرة الديناميكية (iOS).';

  @override
  String get phoneNumberType => 'نوع رقم الهاتف';

  @override
  String get liveActivitiesTestEndActivity => 'إنهاء النشاط';

  @override
  String get liveActivitiesTestSendNewActivity => 'إرسال نشاط جديد';

  @override
  String get liveActivitiesTestUpdateActivity => 'تحديث النشاط';

  @override
  String get liveActivityControlsTitle => 'عناصر تحكم النشاط المباشر';

  @override
  String get liveActivitiesTestTitle => 'اختبار الأنشطة المباشرة';

  @override
  String get liveActivitiesTestSubtitle => 'اختبر إشعار النشاط المباشر.';

  @override
  String get liveNotificationCustomizationTitle => 'تخصيص الإشعارات المباشرة';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'قم بتخصيص مظهر الإشعارات المباشرة.';

  @override
  String get notification_instructions =>
      'التعليمات:\n1. اضغط على \"إرسال\" لإنشاء أو تحديث إشعار.\n2. انتقل إلى الشاشة الرئيسية أو اسحب شريط الإشعارات لرؤية النتيجة.\n3. اضغط على \"إنهاء\" لإغلاق الإشعار.';

  @override
  String get autoCancelNotification => 'إلغاء الإشعار تلقائيًا';

  @override
  String get autoCancelNotificationDescription =>
      'إذا تم تحديد هذا الخيار، فسيتم إغلاق الإشعار تلقائيًا عند النقر عليه من قبل المستخدم.';

  @override
  String get setDelayTime => 'ضبط وقت التأخير';

  @override
  String get proposalDetails => 'تفاصيل الاقتراح';

  @override
  String get filterByStatus => 'تصفية حسب الحالة';

  @override
  String get proposalNotFound => 'الاقتراح غير موجود';

  @override
  String get processed => 'معالج';

  @override
  String get showAll => 'عرض الكل';

  @override
  String get filterAndSortTitle => 'التصفية والفرز';

  @override
  String get filterVerifiedOwner => 'تصفية المالك الذي تم التحقق منه';

  @override
  String get filterBy => 'التصفية حسب';

  @override
  String get sortOldest => 'فرز الأقدم';

  @override
  String get sortNewest => 'فرز الأحدث';

  @override
  String get sortMostPopular => 'فرز الأكثر شيوعًا';

  @override
  String get sortLeastPopular => 'فرز الأقل شيوعًا';

  @override
  String get sortBy => 'الفرز حسب';

  @override
  String get simRulesNotFound => 'قواعد SIM غير موجودة';

  @override
  String get simSlotRules => 'قواعد فتحة SIM';

  @override
  String get noSimCardDetected => 'لم يتم الكشف عن بطاقة SIM';

  @override
  String get invalidSimData => 'بيانات SIM غير صالحة';

  @override
  String get simCardData => 'بيانات بطاقة SIM';

  @override
  String get simSlot => 'فتحة SIM';

  @override
  String get enableFiltering => 'تمكين التصفية';

  @override
  String get detailedSettingsTitle => 'الإعدادات المفصلة';

  @override
  String get entryPointViewTitle => 'نقطة الدخول';

  @override
  String get callTypeRejected => 'مرفوض';

  @override
  String get callTypeSilenced => 'تم إسكاته';

  @override
  String get callTypeVoicemail => 'بريد صوتي';

  @override
  String get callTypeUnknownIntercept => 'اعتراض غير معروف';

  @override
  String andMoreItems(int count) {
    return 'و $count عناصر أخرى';
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
