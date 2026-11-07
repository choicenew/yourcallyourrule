// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Ustawienia chmury i synchronizacji';

  @override
  String get encryptionTitle => 'Szyfrowanie end-to-end (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Zaszyfruj wszystkie kopie zapasowe za pomocą AES-256 przed przesłaniem';

  @override
  String get encryptionEnabled => 'Włączone (AES-256)';

  @override
  String get encryptionDisabled => 'Wyłączone';

  @override
  String get configuredDrives => 'Skonfigurowane dyski w chmurze';

  @override
  String get noDrivesRegistered => 'Brak podłączonych dysków w chmurze';

  @override
  String get cancel => 'Anuluj';

  @override
  String get save => 'Zapisz';

  @override
  String get saveAndEnable => 'Zapisz i włącz';

  @override
  String get setPasswordTitle => 'Ustaw hasło główne E2EE';

  @override
  String get setPasswordDescription =>
      'Twoje kopie zapasowe zostaną zaszyfrowane za pomocą AES-256 przed przesłaniem.';

  @override
  String get masterPasswordLabel => 'Hasło główne';

  @override
  String get passwordEmptyError => 'Hasło nie może być puste';

  @override
  String get syncNow => 'Synchronizuj teraz';

  @override
  String get settings => 'Ustawienia';

  @override
  String get connected => 'Połączono';

  @override
  String get disconnected => 'Rozłączono';

  @override
  String lastSynced(String time) {
    return 'Ostatnia synchronizacja: $time';
  }
}
