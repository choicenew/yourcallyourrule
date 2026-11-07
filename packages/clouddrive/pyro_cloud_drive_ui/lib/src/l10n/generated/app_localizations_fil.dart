// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Mga Setting ng Cloud at Pag-sync';

  @override
  String get encryptionTitle => 'End-to-End Encryption (E2EE)';

  @override
  String get encryptionSubtitle =>
      'I-encrypt ang lahat ng backup gamit ang AES-256 bago i-upload';

  @override
  String get encryptionEnabled => 'Naka-enable (AES-256)';

  @override
  String get encryptionDisabled => 'Naka-disable';

  @override
  String get configuredDrives => 'Mga Naka-configure na Cloud Drive';

  @override
  String get noDrivesRegistered => 'Walang Nakakonektang Cloud Drive';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get save => 'I-save';

  @override
  String get saveAndEnable => 'I-save at Paganahin';

  @override
  String get setPasswordTitle => 'Magtakda ng E2EE Master Password';

  @override
  String get setPasswordDescription =>
      'Ang iyong mga backup ay ia-encrypt gamit ang AES-256 bago i-upload.';

  @override
  String get masterPasswordLabel => 'Master Password';

  @override
  String get passwordEmptyError => 'Hindi maaaring maging blangko ang password';

  @override
  String get syncNow => 'I-sync Ngayon';

  @override
  String get settings => 'Mga Setting';

  @override
  String get connected => 'Nakakonekta';

  @override
  String get disconnected => 'Hindi Nakakonekta';

  @override
  String lastSynced(String time) {
    return 'Huling na-sync: $time';
  }
}
