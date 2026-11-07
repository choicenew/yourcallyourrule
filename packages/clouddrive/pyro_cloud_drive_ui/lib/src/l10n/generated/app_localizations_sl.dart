// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Nastavitve v oblaku in sinhronizacije';

  @override
  String get encryptionTitle => 'Končna šifriranost (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Šifrirajte vse varnostne kopije z AES-256 pred nalaganjem';

  @override
  String get encryptionEnabled => 'Omogočeno (AES-256)';

  @override
  String get encryptionDisabled => 'Onemogočeno';

  @override
  String get configuredDrives => 'Konfigurirani pogoni v oblaku';

  @override
  String get noDrivesRegistered => 'Ni povezanih pogonov v oblaku';

  @override
  String get cancel => 'Prekliči';

  @override
  String get save => 'Shrani';

  @override
  String get saveAndEnable => 'Shrani in omogoči';

  @override
  String get setPasswordTitle => 'Nastavi glavno geslo E2EE';

  @override
  String get setPasswordDescription =>
      'Vaše varnostne kopije bodo šifrirane z AES-256 pred nalaganjem.';

  @override
  String get masterPasswordLabel => 'Glavno geslo';

  @override
  String get passwordEmptyError => 'Geslo ne sme biti prazno';

  @override
  String get syncNow => 'Sinhroniziraj zdaj';

  @override
  String get settings => 'Nastavitve';

  @override
  String get connected => 'Povezano';

  @override
  String get disconnected => 'Prekinjeno';

  @override
  String lastSynced(String time) {
    return 'Zadnja sinhronizacija: $time';
  }
}
