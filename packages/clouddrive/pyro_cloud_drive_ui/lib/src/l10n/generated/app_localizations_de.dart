// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Cloud- & Synchronisierungseinstellungen';

  @override
  String get encryptionTitle => 'Ende-zu-Ende-Verschlüsselung (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Alle Backups vor dem Hochladen mit AES-256 verschlüsseln';

  @override
  String get encryptionEnabled => 'Aktiviert (AES-256)';

  @override
  String get encryptionDisabled => 'Deaktiviert';

  @override
  String get configuredDrives => 'Konfigurierte Cloud-Laufwerke';

  @override
  String get noDrivesRegistered => 'Keine Cloud-Laufwerke verbunden';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get saveAndEnable => 'Speichern & Aktivieren';

  @override
  String get setPasswordTitle => 'E2EE-Master-Passwort festlegen';

  @override
  String get setPasswordDescription =>
      'Ihre Backups werden vor dem Upload mit AES-256 verschlüsselt.';

  @override
  String get masterPasswordLabel => 'Master-Passwort';

  @override
  String get passwordEmptyError => 'Passwort darf nicht leer sein';

  @override
  String get syncNow => 'Jetzt synchronisieren';

  @override
  String get settings => 'Einstellungen';

  @override
  String get connected => 'Verbunden';

  @override
  String get disconnected => 'Getrennt';

  @override
  String lastSynced(String time) {
    return 'Zuletzt synchronisiert: $time';
  }
}
