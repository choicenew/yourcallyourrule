// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Sky- og synkroniseringsinnstillinger';

  @override
  String get encryptionTitle => 'End-to-End-kryptering (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Krypter alle sikkerhetskopier med AES-256 før opplasting';

  @override
  String get encryptionEnabled => 'Aktivert (AES-256)';

  @override
  String get encryptionDisabled => 'Deaktivert';

  @override
  String get configuredDrives => 'Konfigurerte skydisker';

  @override
  String get noDrivesRegistered => 'Ingen skydisker tilkoblet';

  @override
  String get cancel => 'Avbryt';

  @override
  String get save => 'Lagre';

  @override
  String get saveAndEnable => 'Lagre og aktiver';

  @override
  String get setPasswordTitle => 'Angi E2EE hovedpassord';

  @override
  String get setPasswordDescription =>
      'Sikkerhetskopiene dine blir kryptert med AES-256 før opplasting.';

  @override
  String get masterPasswordLabel => 'Hovedpassord';

  @override
  String get passwordEmptyError => 'Passordet kan ikke være tomt';

  @override
  String get syncNow => 'Synkroniser nå';

  @override
  String get settings => 'Innstillinger';

  @override
  String get connected => 'Koblet til';

  @override
  String get disconnected => 'Frakoblet';

  @override
  String lastSynced(String time) {
    return 'Sist synkronisert: $time';
  }
}
