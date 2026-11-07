// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get cloudSettingsTitle => 'کل라우ڈ اور مطابقت پذیری کی ترتیبات';

  @override
  String get encryptionTitle => 'آخر سے آخر تک خفیہ کاری (E2EE)';

  @override
  String get encryptionSubtitle =>
      'اپ لوڈ کرنے سے پہلے تمام بیک اپ کو AES-256 سے خفیہ کریں';

  @override
  String get encryptionEnabled => 'فعال ہے (AES-256)';

  @override
  String get encryptionDisabled => 'غیر فعال ہے';

  @override
  String get configuredDrives => 'ترتیب دیے گئے کل라우ڈ ڈرائیوز';

  @override
  String get noDrivesRegistered => 'کوئی کل라우ڈ ڈرائیو منسلک نہیں ہے';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get saveAndEnable => 'محفوظ کریں اور فعال کریں';

  @override
  String get setPasswordTitle => 'E2EE ماسٹر پاس ورڈ سیٹ کریں';

  @override
  String get setPasswordDescription =>
      'اپ لوڈ کرنے سے پہلے آپ کے بیک اپ کو AES-256 سے خفیہ کیا جائے گا۔';

  @override
  String get masterPasswordLabel => 'ماسٹر پاس ورڈ';

  @override
  String get passwordEmptyError => 'پاس ورڈ خالی نہیں ہو سکتا';

  @override
  String get syncNow => 'ابھی ہم آہنگ کریں';

  @override
  String get settings => 'ترتیبات';

  @override
  String get connected => 'منسلک ہے';

  @override
  String get disconnected => 'منقطع ہے';

  @override
  String lastSynced(String time) {
    return 'آخری مطابقت پذیری: $time';
  }
}
