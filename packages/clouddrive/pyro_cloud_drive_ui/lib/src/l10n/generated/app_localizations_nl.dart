// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Cloud- en synchronisatie-instellingen';

  @override
  String get encryptionTitle => 'End-to-end-versleuteling (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Versleutel alle back-ups met AES-256 vóór het uploaden';

  @override
  String get encryptionEnabled => 'ingeschakeld (AES-256)';

  @override
  String get encryptionDisabled => 'Uitgeschakeld';

  @override
  String get configuredDrives => 'Geconfigureerde cloudschijven';

  @override
  String get noDrivesRegistered => 'Geen cloudschijven verbonden';

  @override
  String get cancel => 'Annuleren';

  @override
  String get save => 'Opslaan';

  @override
  String get saveAndEnable => 'Opslaan & Inschakelen';

  @override
  String get setPasswordTitle => 'E2EE-hoofdwachtwoord instellen';

  @override
  String get setPasswordDescription =>
      'Uw back-ups worden vóór het uploaden versleuteld met AES-256.';

  @override
  String get masterPasswordLabel => 'Hoofdwachtwoord';

  @override
  String get passwordEmptyError => 'Wachtwoord mag niet leeg zijn';

  @override
  String get syncNow => 'Nu synchroniseren';

  @override
  String get settings => 'Instellingen';

  @override
  String get connected => 'Verbonden';

  @override
  String get disconnected => 'Verbinding verbroken';

  @override
  String lastSynced(String time) {
    return 'Laatst gesynchroniseerd: $time';
  }
}
