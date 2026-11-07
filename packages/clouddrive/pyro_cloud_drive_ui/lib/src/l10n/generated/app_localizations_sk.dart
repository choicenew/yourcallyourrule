// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Nastavenia cloudu a synchronizácie';

  @override
  String get encryptionTitle => 'End-to-end šifrovanie (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Pred odovzdaním zašifrujte všetky zálohy pomocou AES-256';

  @override
  String get encryptionEnabled => 'Povolené (AES-256)';

  @override
  String get encryptionDisabled => 'Zakázané';

  @override
  String get configuredDrives => 'Konfigurované cloudové disky';

  @override
  String get noDrivesRegistered => 'Žiadne pripojené cloudové disky';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get save => 'Uložiť';

  @override
  String get saveAndEnable => 'Uložiť a povoliť';

  @override
  String get setPasswordTitle => 'Nastaviť hlavné heslo E2EE';

  @override
  String get setPasswordDescription =>
      'Vaše zálohy budú pred odovzdaním zašifrované pomocou AES-256.';

  @override
  String get masterPasswordLabel => 'Hlavné heslo';

  @override
  String get passwordEmptyError => 'Heslo nemôže byť prázdne';

  @override
  String get syncNow => 'Synchronizovať teraz';

  @override
  String get settings => 'Nastavenia';

  @override
  String get connected => 'Pripojené';

  @override
  String get disconnected => 'Odpojené';

  @override
  String lastSynced(String time) {
    return 'Naposledy synchronizované: $time';
  }
}
