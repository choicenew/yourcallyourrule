// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Cloud & Sync Settings';

  @override
  String get encryptionTitle => 'End-to-End Encryption (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Encrypt all backups with AES-256 before upload';

  @override
  String get encryptionEnabled => 'Enabled (AES-256)';

  @override
  String get encryptionDisabled => 'Disabled';

  @override
  String get configuredDrives => 'Configured Cloud Drives';

  @override
  String get noDrivesRegistered => 'No Cloud Drives Connected';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => 'Save';

  @override
  String get saveAndEnable => 'Save & Enable';

  @override
  String get setPasswordTitle => 'Set E2EE Master Password';

  @override
  String get setPasswordDescription =>
      'Your backups will be encrypted with AES-256 before uploading.';

  @override
  String get masterPasswordLabel => 'マスターパスワード';

  @override
  String get passwordEmptyError => 'Password cannot be empty';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get settings => 'Settings';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String lastSynced(String time) {
    return 'Last synced: $time';
  }
}
