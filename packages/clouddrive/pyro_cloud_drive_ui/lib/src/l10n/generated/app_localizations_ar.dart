// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get cloudSettingsTitle => 'إعدادات السحابة والمزامنة';

  @override
  String get encryptionTitle => 'التشفير من طرف إلى طرف (E2EE)';

  @override
  String get encryptionSubtitle =>
      'تشفير كافة النسخ الاحتياطية باستخدام AES-256 قبل التحميل';

  @override
  String get encryptionEnabled => 'مفعل (AES-256)';

  @override
  String get encryptionDisabled => 'معطل';

  @override
  String get configuredDrives => 'محركات الأقراص السحابية المُكوّنة';

  @override
  String get noDrivesRegistered => 'لا توجد محركات أقراص سحابية متصلة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get saveAndEnable => 'حفظ وتمكين';

  @override
  String get setPasswordTitle => 'تعيين كلمة المرور الرئيسية لـ E2EE';

  @override
  String get setPasswordDescription =>
      'سيتم تشفير نسخك الاحتياطية باستخدام AES-256 قبل التحميل.';

  @override
  String get masterPasswordLabel => 'كلمة المرور الرئيسية';

  @override
  String get passwordEmptyError => 'لا يمكن أن تكون كلمة المرور فارغة';

  @override
  String get syncNow => 'مزامنة الآن';

  @override
  String get settings => 'الإعدادات';

  @override
  String get connected => 'متصل';

  @override
  String get disconnected => 'غير متصل';

  @override
  String lastSynced(String time) {
    return 'آخر مزامنة: $time';
  }
}
