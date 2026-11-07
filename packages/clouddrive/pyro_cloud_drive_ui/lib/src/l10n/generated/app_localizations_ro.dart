// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Setări cloud și sincronizare';

  @override
  String get encryptionTitle => 'Criptare end-to-end (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Criptează toate copiile de rezervă cu AES-256 înainte de încărcare';

  @override
  String get encryptionEnabled => 'Activat (AES-256)';

  @override
  String get encryptionDisabled => 'Dezactivat';

  @override
  String get configuredDrives => 'Discuri cloud configurate';

  @override
  String get noDrivesRegistered => 'Niciun disc cloud conectat';

  @override
  String get cancel => 'Anulează';

  @override
  String get save => 'Salvează';

  @override
  String get saveAndEnable => 'Salvează și activează';

  @override
  String get setPasswordTitle => 'Setează parola principală E2EE';

  @override
  String get setPasswordDescription =>
      'Copiile de rezervă vor fi criptate cu AES-256 înainte de încărcare.';

  @override
  String get masterPasswordLabel => 'Parolă principală';

  @override
  String get passwordEmptyError => 'Parola nu poate fi goală';

  @override
  String get syncNow => 'Sincronizează acum';

  @override
  String get settings => 'Setări';

  @override
  String get connected => 'Conectat';

  @override
  String get disconnected => 'Deconectat';

  @override
  String lastSynced(String time) {
    return 'Ultima sincronizare: $time';
  }
}
