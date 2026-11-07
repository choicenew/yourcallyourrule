// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Debesies ir sinchronizavimo nustatymai';

  @override
  String get encryptionTitle => 'Šifravimas nuo galo iki galo (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Šifruoti visas atsargines kopijas naudojant AES-256 prieš įkeliant';

  @override
  String get encryptionEnabled => 'Įjungta (AES-256)';

  @override
  String get encryptionDisabled => 'Išjungta';

  @override
  String get configuredDrives => 'Sukonfigūruoti debesies diskai';

  @override
  String get noDrivesRegistered => 'Nėra prijungtų debesies diskų';

  @override
  String get cancel => 'Atšaukti';

  @override
  String get save => 'Išsaugoti';

  @override
  String get saveAndEnable => 'Išsaugoti ir įjungti';

  @override
  String get setPasswordTitle => 'Nustatyti E2EE pagrindinį slaptažodį';

  @override
  String get setPasswordDescription =>
      'Jūsų atsarginės kopijos bus užšifruotos su AES-256 prieš įkeliant.';

  @override
  String get masterPasswordLabel => 'Pagrindinis slaptažodis';

  @override
  String get passwordEmptyError => 'Slaptažodis negali būti tuščias';

  @override
  String get syncNow => 'Sinchronizuoti dabar';

  @override
  String get settings => 'Nustatymai';

  @override
  String get connected => 'Prisijungta';

  @override
  String get disconnected => 'Atsijungta';

  @override
  String lastSynced(String time) {
    return 'Paskutinį kartą sinchronizuota: $time';
  }
}
