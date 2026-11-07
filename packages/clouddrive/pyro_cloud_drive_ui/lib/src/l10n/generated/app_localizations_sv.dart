// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Moln- och synkinställningar';

  @override
  String get encryptionTitle => 'End-to-End-kryptering (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Kryptera alla säkerhetskopior med AES-256 före uppladdning';

  @override
  String get encryptionEnabled => 'Aktiverad (AES-256)';

  @override
  String get encryptionDisabled => 'Inaktiverad';

  @override
  String get configuredDrives => 'Konfigurerade molnenheter';

  @override
  String get noDrivesRegistered => 'Inga molnenheter anslutna';

  @override
  String get cancel => 'Avbryt';

  @override
  String get save => 'Spara';

  @override
  String get saveAndEnable => 'Spara & Aktivera';

  @override
  String get setPasswordTitle => 'Ställ in E2EE-huvudlösenord';

  @override
  String get setPasswordDescription =>
      'Dina säkerhetskopior krypteras med AES-256 innan uppladdning.';

  @override
  String get masterPasswordLabel => 'Huvudlösenord';

  @override
  String get passwordEmptyError => 'Lösenordet får inte vara tomt';

  @override
  String get syncNow => 'Synka nu';

  @override
  String get settings => 'Inställningar';

  @override
  String get connected => 'Ansluten';

  @override
  String get disconnected => 'Frånkopplad';

  @override
  String lastSynced(String time) {
    return 'Senast synkad: $time';
  }
}
