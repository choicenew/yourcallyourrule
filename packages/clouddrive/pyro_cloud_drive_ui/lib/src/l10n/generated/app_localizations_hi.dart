// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get cloudSettingsTitle => 'क्लाउड और सिंक सेटिंग';

  @override
  String get encryptionTitle => 'एंड-टू-एंड एन्क्रिप्शन (E2EE)';

  @override
  String get encryptionSubtitle =>
      'अपलोड करने से पहले AES-256 के साथ सभी बैकअप एन्क्रिप्ट करें';

  @override
  String get encryptionEnabled => 'सक्षम (AES-256)';

  @override
  String get encryptionDisabled => 'अक्षम';

  @override
  String get configuredDrives => 'कॉन्फ़िगर किए गए क्लाउड ड्राइव';

  @override
  String get noDrivesRegistered => 'कोई क्लाउड ड्राइव कनेक्ट नहीं है';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get saveAndEnable => 'सहेजें और सक्षम करें';

  @override
  String get setPasswordTitle => 'E2EE मास्टर पासवर्ड सेट करें';

  @override
  String get setPasswordDescription =>
      'अपलोड करने से पहले आपके बैकअप को AES-256 के साथ एन्क्रिप्ट किया जाएगा।';

  @override
  String get masterPasswordLabel => 'मास्टर पासवर्ड';

  @override
  String get passwordEmptyError => 'पासवर्ड खाली नहीं हो सकता';

  @override
  String get syncNow => 'अभी सिंक करें';

  @override
  String get settings => 'सेटिंग';

  @override
  String get connected => 'कनेक्ट किया गया';

  @override
  String get disconnected => 'डिस्कनेक्ट किया गया';

  @override
  String lastSynced(String time) {
    return 'अंतिम सिंक: $time';
  }
}
