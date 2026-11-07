// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Podešavanja oblaka i sinhronizacije';

  @override
  String get encryptionTitle => 'Enkripcija s kraja na kraj (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Enkriptuj sve rezervne kopije sa AES-256 pre otpremanja';

  @override
  String get encryptionEnabled => 'Omogućeno (AES-256)';

  @override
  String get encryptionDisabled => 'Onemogućeno';

  @override
  String get configuredDrives => 'Konfigurisani diskovi u oblaku';

  @override
  String get noDrivesRegistered => 'Nema povezanih diskova u oblaku';

  @override
  String get cancel => 'Otkaži';

  @override
  String get save => 'Sačuvaj';

  @override
  String get saveAndEnable => 'Sačuvaj i omogući';

  @override
  String get setPasswordTitle => 'Postavi E2EE glavnu lozinku';

  @override
  String get setPasswordDescription =>
      'Vaše rezervne kopije biće enkriptovane sa AES-256 pre otpremanja.';

  @override
  String get masterPasswordLabel => 'Glavna lozinka';

  @override
  String get passwordEmptyError => 'Lozinka ne može biti prazna';

  @override
  String get syncNow => 'Sinhronizuj odmah';

  @override
  String get settings => 'Podešavanja';

  @override
  String get connected => 'Povezano';

  @override
  String get disconnected => 'Prekinuta veza';

  @override
  String lastSynced(String time) {
    return 'Poslednja sinhronizacija: $time';
  }
}
