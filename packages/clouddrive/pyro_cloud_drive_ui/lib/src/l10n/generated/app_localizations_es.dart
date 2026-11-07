// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Configuración de Nube y Sincronización';

  @override
  String get encryptionTitle => 'Cifrado de extremo a extremo (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Cifrar todas las copias de seguridad con AES-256 antes de subir';

  @override
  String get encryptionEnabled => 'Habilitado (AES-256)';

  @override
  String get encryptionDisabled => 'Deshabilitado';

  @override
  String get configuredDrives => 'Unidades en la nube configuradas';

  @override
  String get noDrivesRegistered => 'No hay unidades en la nube conectadas';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get saveAndEnable => 'Guardar y habilitar';

  @override
  String get setPasswordTitle => 'Establecer contraseña maestra E2EE';

  @override
  String get setPasswordDescription =>
      'Tus copias de seguridad se cifrarán con AES-256 antes de subir.';

  @override
  String get masterPasswordLabel => 'Contraseña maestra';

  @override
  String get passwordEmptyError => 'La contraseña no puede estar vacía';

  @override
  String get syncNow => 'Sincronizar ahora';

  @override
  String get settings => 'Configuración';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String lastSynced(String time) {
    return 'Última sincronización: $time';
  }
}
