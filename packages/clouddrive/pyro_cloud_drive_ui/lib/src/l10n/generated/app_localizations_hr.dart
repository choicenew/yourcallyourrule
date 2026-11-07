// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Postavke oblaka i sinkronizacije';

  @override
  String get encryptionTitle => 'Krajnja enkripcija (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Šifrirajte sve sigurnosne kopije s AES-256 prije prijenosa';

  @override
  String get encryptionEnabled => 'Omogućeno (AES-256)';

  @override
  String get encryptionDisabled => 'Onemogućeno';

  @override
  String get configuredDrives => 'Konfigurirani pogoni u oblaku';

  @override
  String get noDrivesRegistered => 'Nema povezanih pogona u oblaku';

  @override
  String get cancel => 'Odustani';

  @override
  String get save => 'Spremi';

  @override
  String get saveAndEnable => 'Spremi i omogući';

  @override
  String get setPasswordTitle => 'Postavi E2EE glavnu lozinku';

  @override
  String get setPasswordDescription =>
      'Vaše sigurnosne kopije bit će šifrirane s AES-256 prije prijenosa.';

  @override
  String get masterPasswordLabel => 'Glavna lozinka';

  @override
  String get passwordEmptyError => 'Lozinka ne može biti prazna';

  @override
  String get syncNow => 'Sinkroniziraj odmah';

  @override
  String get settings => 'Postavke';

  @override
  String get connected => 'Povezano';

  @override
  String get disconnected => 'Prekinuto';

  @override
  String lastSynced(String time) {
    return 'Zadnja sinkronizacija: $time';
  }
}
