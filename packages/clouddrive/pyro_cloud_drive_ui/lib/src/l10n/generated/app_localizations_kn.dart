// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get cloudSettingsTitle => 'ಕ್ಲೌಡ್ ಮತ್ತು ಸಿಂಕ್ ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get encryptionTitle => 'ಎಂಡ್-ಟು-ಎಂಡ್ ಎನ್‌ಕ್ರಿಪ್ಶನ್ (E2EE)';

  @override
  String get encryptionSubtitle =>
      'ಅಪ್‌ಲೋಡ್ ಮಾಡುವ ಮೊದಲು ಎಲ್ಲಾ ಬ್ಯಾಕಪ್‌ಗಳನ್ನು AES-256 ನೊಂದಿಗೆ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಿ';

  @override
  String get encryptionEnabled => 'ಸಕ್ರಿಯಗೊಳಿಸಲಾಗಿದೆ (AES-256)';

  @override
  String get encryptionDisabled => 'ನಿಷ್ಕ್ರಿಯಗೊಳಿಸಲಾಗಿದೆ';

  @override
  String get configuredDrives => 'ಕಾನ್ಫಿಗರ್ ಮಾಡಿದ ಕ್ಲೌಡ್ ಡ್ರೈವ್‌ಗಳು';

  @override
  String get noDrivesRegistered => 'ಯಾವುದೇ ಕ್ಲೌಡ್ ಡ್ರೈವ್‌ಗಳು ಸಂಪರ್ಕಗೊಂಡಿಲ್ಲ';

  @override
  String get cancel => 'ರದ್ದುಗೊಳಿಸಿ';

  @override
  String get save => 'ಉಳಿಸಿ';

  @override
  String get saveAndEnable => 'ಉಳಿಸಿ ಮತ್ತು ಸಕ್ರಿಯಗೊಳಿಸಿ';

  @override
  String get setPasswordTitle => 'E2EE ಮಾಸ್ಟರ್ ಪಾಸ್‌ವರ್ಡ್ ಹೊಂದಿಸಿ';

  @override
  String get setPasswordDescription =>
      'ಅಪ್‌ಲೋಡ್ ಮಾಡುವ ಮೊದಲು ನಿಮ್ಮ ಬ್ಯಾಕಪ್‌ಗಳನ್ನು AES-256 ಮೂಲಕ ಎನ್‌ಕ್ರಿಪ್ಟ್ ಮಾಡಲಾಗುತ್ತದೆ.';

  @override
  String get masterPasswordLabel => 'ಮಾಸ್ಟರ್ ಪಾಸ್‌ವರ್ಡ್';

  @override
  String get passwordEmptyError => 'ಪಾಸ್‌ವರ್ಡ್ ಖಾಲಿಯಾಗಿರಬಾರದು';

  @override
  String get syncNow => 'ಈಗ ಸಿಂಕ್ ಮಾಡಿ';

  @override
  String get settings => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get connected => 'ಸಂಪರ್ಕಗೊಂಡಿದೆ';

  @override
  String get disconnected => 'ಸಂಪರ್ಕ ಕಡಿತಗೊಂಡಿದೆ';

  @override
  String lastSynced(String time) {
    return 'ಕೊನೆಯದಾಗಿ ಸಿಂಕ್ ಮಾಡಲಾಗಿದೆ: $time';
  }
}
