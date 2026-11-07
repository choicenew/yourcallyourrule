// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Configuració del núvol i sincronització';

  @override
  String get encryptionTitle => 'Xifrat d\'extrem a extrem (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Xifrar totes les còpies de seguretat amb AES-256 abans de pujar';

  @override
  String get encryptionEnabled => 'Habilitat (AES-256)';

  @override
  String get encryptionDisabled => 'Deshabilitat';

  @override
  String get configuredDrives => 'Disquets al núvol configurats';

  @override
  String get noDrivesRegistered => 'No hi ha unitats al núvol connectades';

  @override
  String get cancel => 'Cancel·lar';

  @override
  String get save => 'Desar';

  @override
  String get saveAndEnable => 'Desar i habilitar';

  @override
  String get setPasswordTitle => 'Establir contrasenya mestra E2EE';

  @override
  String get setPasswordDescription =>
      'Les vostres còpies de seguretat es xifraran amb AES-256 abans de pujar-les.';

  @override
  String get masterPasswordLabel => 'Contrasenya mestra';

  @override
  String get passwordEmptyError => 'La contrasenya no pot estar buida';

  @override
  String get syncNow => 'Sincronitzar ara';

  @override
  String get settings => 'Configuració';

  @override
  String get connected => 'Connectat';

  @override
  String get disconnected => 'Desconnectat';

  @override
  String lastSynced(String time) {
    return 'Última sincronització: $time';
  }
}
