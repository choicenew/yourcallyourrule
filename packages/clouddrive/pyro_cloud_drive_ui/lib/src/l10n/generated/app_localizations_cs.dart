// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Nastavení cloudu a synchronizace';

  @override
  String get encryptionTitle => 'Šifrování end-to-end (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Před odesláním zašifrovat všechny zálohy pomocí AES-256';

  @override
  String get encryptionEnabled => 'Povoleno (AES-256)';

  @override
  String get encryptionDisabled => 'Zakázáno';

  @override
  String get configuredDrives => 'Konfigurované cloudové disky';

  @override
  String get noDrivesRegistered => 'Žádné připojené cloudové disky';

  @override
  String get cancel => 'Zrušit';

  @override
  String get save => 'Uložit';

  @override
  String get saveAndEnable => 'Uložit a povolit';

  @override
  String get setPasswordTitle => 'Nastavit hlavní heslo E2EE';

  @override
  String get setPasswordDescription =>
      'Vaše zálohy budou před odesláním zašifrovány pomocí AES-256.';

  @override
  String get masterPasswordLabel => 'Hlavní heslo';

  @override
  String get passwordEmptyError => 'Heslo nemůže být prázdné';

  @override
  String get syncNow => 'Synchronizovat nyní';

  @override
  String get settings => 'Nastavení';

  @override
  String get connected => 'Připojeno';

  @override
  String get disconnected => 'Odpojeno';

  @override
  String lastSynced(String time) {
    return 'Naposledy synchronizováno: $time';
  }
}
