// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Pilvi- ja synkronointiasetukset';

  @override
  String get encryptionTitle => 'Päästä päähän -salaus (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Salaa kaikki varmuuskopiot AES-256:lla ennen lataamista';

  @override
  String get encryptionEnabled => 'Käytössä (AES-256)';

  @override
  String get encryptionDisabled => 'Ei käytössä';

  @override
  String get configuredDrives => 'Määritetyt pilviasemat';

  @override
  String get noDrivesRegistered => 'Ei yhdistettyjä pilviasemia';

  @override
  String get cancel => 'Peruuta';

  @override
  String get save => 'Tallenna';

  @override
  String get saveAndEnable => 'Tallenna ja ota käyttöön';

  @override
  String get setPasswordTitle => 'Aseta E2EE-pääsalasana';

  @override
  String get setPasswordDescription =>
      'Varmuuskopiosi salataan AES-256:lla ennen lataamista.';

  @override
  String get masterPasswordLabel => 'Pääsalasana';

  @override
  String get passwordEmptyError => 'Salasana ei voi olla tyhjä';

  @override
  String get syncNow => 'Synkronoi nyt';

  @override
  String get settings => 'Asetukset';

  @override
  String get connected => 'Yhdistetty';

  @override
  String get disconnected => 'Ei yhteyttä';

  @override
  String lastSynced(String time) {
    return 'Viimeksi synkronoitu: $time';
  }
}
