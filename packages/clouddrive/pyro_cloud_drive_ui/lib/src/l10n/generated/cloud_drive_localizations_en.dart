// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'cloud_drive_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CloudDriveLocalizationsEn extends CloudDriveLocalizations {
  CloudDriveLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Cloud Drive Settings';

  @override
  String get encryptionTitle => 'End-to-End Encryption';

  @override
  String get encryptionSubtitle =>
      'Encrypt backups and sync data with master password';

  @override
  String get encryptionEnabled => 'End-to-end encryption enabled';

  @override
  String get encryptionDisabled => 'Encryption disabled';

  @override
  String get configuredDrives => 'Configured Drives';

  @override
  String get noDrivesRegistered => 'No cloud drives connected yet';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get saveAndEnable => 'Save & Enable';

  @override
  String get setPasswordTitle => 'Set Master Password';

  @override
  String get setPasswordDescription =>
      'This password will be used to encrypt/decrypt all cloud sync backups';

  @override
  String get masterPasswordLabel => 'Master Password';

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
