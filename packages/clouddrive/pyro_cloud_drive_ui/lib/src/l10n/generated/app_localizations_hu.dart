// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Felhő és szinkronizálás beállításai';

  @override
  String get encryptionTitle => 'Végpontok közötti titkosítás (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Minden biztonsági mentés titkosítása AES-256-tal feltöltés előtt';

  @override
  String get encryptionEnabled => 'Engedélyezve (AES-256)';

  @override
  String get encryptionDisabled => 'Letiltva';

  @override
  String get configuredDrives => 'Konfigurált felhőmeghajtók';

  @override
  String get noDrivesRegistered => 'Nincsenek csatlakoztatott felhőmeghajtók';

  @override
  String get cancel => 'Mégse';

  @override
  String get save => 'Mentés';

  @override
  String get saveAndEnable => 'Mentés és engedélyezés';

  @override
  String get setPasswordTitle => 'E2EE mester jelszó beállítása';

  @override
  String get setPasswordDescription =>
      'A biztonsági mentéseid AES-256-tal lesznek titkosítva feltöltés előtt.';

  @override
  String get masterPasswordLabel => 'Mester jelszó';

  @override
  String get passwordEmptyError => 'A jelszó nem lehet üres';

  @override
  String get syncNow => 'Szinkronizálás most';

  @override
  String get settings => 'Beállítások';

  @override
  String get connected => 'Kapcsolódva';

  @override
  String get disconnected => 'Kapcsolat megszakadva';

  @override
  String lastSynced(String time) {
    return 'Utolsó szinkronizálás: $time';
  }
}
