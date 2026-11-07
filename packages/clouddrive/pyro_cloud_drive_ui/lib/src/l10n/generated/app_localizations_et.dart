// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Pilve- ja sünkroonimisseaded';

  @override
  String get encryptionTitle => 'Otsast lõpuni krüptimine (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Krüpteeri kõik varukoopiad enne üleslaadimist AES-256-ga';

  @override
  String get encryptionEnabled => 'Lubatud (AES-256)';

  @override
  String get encryptionDisabled => 'Keelatud';

  @override
  String get configuredDrives => 'Konfigureeritud pilvekettad';

  @override
  String get noDrivesRegistered => 'Pilvekettaid pole ühendatud';

  @override
  String get cancel => 'Loobu';

  @override
  String get save => 'Salvesta';

  @override
  String get saveAndEnable => 'Salvesta ja luba';

  @override
  String get setPasswordTitle => 'Määra E2EE põhiparool';

  @override
  String get setPasswordDescription =>
      'Teie varukoopiad krüpteeritakse enne üleslaadimist AES-256-ga.';

  @override
  String get masterPasswordLabel => 'Põhiparool';

  @override
  String get passwordEmptyError => 'Parool ei tohi olla tühi';

  @override
  String get syncNow => 'Sünkrooni kohe';

  @override
  String get settings => 'Seaded';

  @override
  String get connected => 'Ühendatud';

  @override
  String get disconnected => 'Ühendus katkenud';

  @override
  String lastSynced(String time) {
    return 'Viimati sünkroonitud: $time';
  }
}
