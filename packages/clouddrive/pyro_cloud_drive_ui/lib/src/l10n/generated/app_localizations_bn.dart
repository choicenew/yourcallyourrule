// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get cloudSettingsTitle => 'ক্লাউড এবং সিঙ্ক সেটিংস';

  @override
  String get encryptionTitle => 'এন্ড-টু-এন্ড এনক্রিপশন (E2EE)';

  @override
  String get encryptionSubtitle =>
      'আপলোড করার আগে AES-256 দিয়ে সমস্ত ব্যাকআপ এনক্রিপ্ট করুন';

  @override
  String get encryptionEnabled => 'সক্রিয় (AES-256)';

  @override
  String get encryptionDisabled => 'নিষ্ক্রিয়';

  @override
  String get configuredDrives => 'কনফিগার করা ক্লাউড ড্রাইভ';

  @override
  String get noDrivesRegistered => 'কোনো ক্লাউড ড্রাইভ সংযুক্ত নেই';

  @override
  String get cancel => 'বাতিল';

  @override
  String get save => 'সেভ করুন';

  @override
  String get saveAndEnable => 'সেভ করুন এবং সক্রিয় করুন';

  @override
  String get setPasswordTitle => 'E2EE মাস্টার পাসওয়ার্ড সেট করুন';

  @override
  String get setPasswordDescription =>
      'আপলোড করার আগে আপনার ব্যাকআপগুলি AES-256 দিয়ে এনক্রিপ্ট করা হবে।';

  @override
  String get masterPasswordLabel => 'মাস্টার পাসওয়ার্ড';

  @override
  String get passwordEmptyError => 'পাসওয়ার্ড খালি থাকতে পারে না';

  @override
  String get syncNow => 'এখনই সিঙ্ক করুন';

  @override
  String get settings => 'সেটিংস';

  @override
  String get connected => 'সংযুক্ত';

  @override
  String get disconnected => 'বিচ্ছিন্ন';

  @override
  String lastSynced(String time) {
    return 'সর্বশেষ সিঙ্ক হয়েছে: $time';
  }
}
