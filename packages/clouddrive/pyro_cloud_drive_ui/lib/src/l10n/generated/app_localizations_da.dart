// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Sky- og synkroniseringsindstillinger';

  @override
  String get encryptionTitle => 'Ende-til-ende-kryptering (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Krypter alle sikkerhedskopier med AES-256 før upload';

  @override
  String get encryptionEnabled => 'Aktiveret (AES-256)';

  @override
  String get encryptionDisabled => 'Deaktiveret';

  @override
  String get configuredDrives => 'Konfigurerede skydrev';

  @override
  String get noDrivesRegistered => 'Ingen skydrev tilsluttet';

  @override
  String get cancel => 'Annuller';

  @override
  String get save => 'Gem';

  @override
  String get saveAndEnable => 'Gem og aktiver';

  @override
  String get setPasswordTitle => 'Indstil E2EE-hovedadgangskode';

  @override
  String get setPasswordDescription =>
      'Dine sikkerhedskopier krypteres med AES-256 før upload.';

  @override
  String get masterPasswordLabel => 'Hovedadgangskode';

  @override
  String get passwordEmptyError => 'Adgangskode kan ikke være tom';

  @override
  String get syncNow => 'Synkroniser nu';

  @override
  String get settings => 'Indstillinger';

  @override
  String get connected => 'Forbundet';

  @override
  String get disconnected => 'Afbrudt';

  @override
  String lastSynced(String time) {
    return 'Sidst synkroniseret: $time';
  }
}
