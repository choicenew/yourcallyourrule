// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Impostazioni cloud e sincronizzazione';

  @override
  String get encryptionTitle => 'Crittografia end-to-end (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Crittografa tutti i backup con AES-256 prima del caricamento';

  @override
  String get encryptionEnabled => 'Abilitata (AES-256)';

  @override
  String get encryptionDisabled => 'Disabilitata';

  @override
  String get configuredDrives => 'Unità cloud configurate';

  @override
  String get noDrivesRegistered => 'Nessuna unità cloud connessa';

  @override
  String get cancel => 'Annulla';

  @override
  String get save => 'Salva';

  @override
  String get saveAndEnable => 'Salva e abilita';

  @override
  String get setPasswordTitle => 'Imposta password principale E2EE';

  @override
  String get setPasswordDescription =>
      'I tuoi backup saranno crittografati con AES-256 prima del caricamento.';

  @override
  String get masterPasswordLabel => 'Password principale';

  @override
  String get passwordEmptyError => 'La password non può essere vuota';

  @override
  String get syncNow => 'Sincronizza ora';

  @override
  String get settings => 'Impostazioni';

  @override
  String get connected => 'Connesso';

  @override
  String get disconnected => 'Disconnesso';

  @override
  String lastSynced(String time) {
    return 'Ultima sincronizzazione: $time';
  }
}
