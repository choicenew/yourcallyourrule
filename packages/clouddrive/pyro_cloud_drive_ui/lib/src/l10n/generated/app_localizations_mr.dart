// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get cloudSettingsTitle => 'क्लाउड आणि सिंक सेटिंग्ज';

  @override
  String get encryptionTitle => 'एंड-टू-एंड एनक्रिप्शन (E2EE)';

  @override
  String get encryptionSubtitle =>
      'अपलोड करण्यापूर्वी सर्व बॅकअप AES-256 सह एनक्रिप्ट करा';

  @override
  String get encryptionEnabled => 'सक्षम (AES-256)';

  @override
  String get encryptionDisabled => 'अक्षम';

  @override
  String get configuredDrives => 'कॉन्फिगर केलेले क्लाउड ड्राइव्ह्स';

  @override
  String get noDrivesRegistered => 'कोणतीही क्लाउड ड्राइव्ह कनेक्ट केलेली नाही';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get save => 'जतन करा';

  @override
  String get saveAndEnable => 'जतन करा आणि सक्षम करा';

  @override
  String get setPasswordTitle => 'E2EE मास्टर पासवर्ड सेट करा';

  @override
  String get setPasswordDescription =>
      'अपलोड करण्यापूर्वी तुमचे बॅकअप AES-256 सह एनक्रिप्ट केले जातील.';

  @override
  String get masterPasswordLabel => 'मास्टर पासवर्ड';

  @override
  String get passwordEmptyError => 'पासवर्ड रिकामा असू शकत नाही';

  @override
  String get syncNow => 'आता सिंक करा';

  @override
  String get settings => 'सेटिंग्ज';

  @override
  String get connected => 'कनेक्ट केलेले';

  @override
  String get disconnected => 'डिस्नेक्ट केलेले';

  @override
  String lastSynced(String time) {
    return 'शेवटचे सिंक केले: $time';
  }
}
