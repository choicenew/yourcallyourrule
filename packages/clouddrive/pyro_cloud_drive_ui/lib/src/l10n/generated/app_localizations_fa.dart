// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get cloudSettingsTitle => 'تنظیمات ابری و همگام‌سازی';

  @override
  String get encryptionTitle => 'رمزگذاری سرتاسری (E2EE)';

  @override
  String get encryptionSubtitle =>
      'رمزگذاری تمامی پشتیبان‌ها با AES-256 پیش از آپلود';

  @override
  String get encryptionEnabled => 'فعال (AES-256)';

  @override
  String get encryptionDisabled => 'غیرفعال';

  @override
  String get configuredDrives => 'درایوهای ابری پیکربندی‌شده';

  @override
  String get noDrivesRegistered => 'هیچ درایو ابری متصل نشده است';

  @override
  String get cancel => 'لغو';

  @override
  String get save => 'ذخیره';

  @override
  String get saveAndEnable => 'ذخیره و فعال‌سازی';

  @override
  String get setPasswordTitle => 'تنظیم گذرواژه اصلی E2EE';

  @override
  String get setPasswordDescription =>
      'پشتیبان‌های شما پیش از آپلود با AES-256 رمزگذاری می‌شوند.';

  @override
  String get masterPasswordLabel => 'گذرواژه اصلی';

  @override
  String get passwordEmptyError => 'گذرواژه نمی‌تواند خالی باشد';

  @override
  String get syncNow => 'همگام‌سازی اکنون';

  @override
  String get settings => 'تنظیمات';

  @override
  String get connected => 'متصل';

  @override
  String get disconnected => 'قطع شده';

  @override
  String lastSynced(String time) {
    return 'آخرین همگام‌سازی: $time';
  }
}
