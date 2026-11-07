// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Mākoņa un sinhronizācijas iestatījumi';

  @override
  String get encryptionTitle => 'Šifrēšana no gala līdz galam (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Šifrēt visas dublējumkopijas ar AES-256 pirms augšupielādes';

  @override
  String get encryptionEnabled => 'Iespējota (AES-256)';

  @override
  String get encryptionDisabled => 'Atspējota';

  @override
  String get configuredDrives => 'Konfigurētie mākoņa diskdziņi';

  @override
  String get noDrivesRegistered => 'Nav pievienotu mākoņa diskdziņu';

  @override
  String get cancel => 'Atcelt';

  @override
  String get save => 'Saglabāt';

  @override
  String get saveAndEnable => 'Saglabāt un iespējot';

  @override
  String get setPasswordTitle => 'Iestatīt E2EE galveno paroli';

  @override
  String get setPasswordDescription =>
      'Jūsu dublējumkopijas tiks šifrētas ar AES-256 pirms augšupielādes.';

  @override
  String get masterPasswordLabel => 'Galvenā parole';

  @override
  String get passwordEmptyError => 'Parole nevar būt tukša';

  @override
  String get syncNow => 'Sinhronizēt tagad';

  @override
  String get settings => 'Iestatījumi';

  @override
  String get connected => 'Savienots';

  @override
  String get disconnected => 'Nav savienojuma';

  @override
  String lastSynced(String time) {
    return 'Pēdējo reizi sinhronizēts: $time';
  }
}
