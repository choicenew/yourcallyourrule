// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Definições de Nuvem e Sincronização';

  @override
  String get encryptionTitle => 'Encriptação End-to-End (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Encriptar todos os backups com AES-256 antes de enviar';

  @override
  String get encryptionEnabled => 'Ativado (AES-256)';

  @override
  String get encryptionDisabled => 'Desativado';

  @override
  String get configuredDrives => 'Unidades de Nuvem Configuradas';

  @override
  String get noDrivesRegistered => 'Sem Unidades de Nuvem Ligadas';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get saveAndEnable => 'Guardar & Ativar';

  @override
  String get setPasswordTitle => 'Definir Palavra-passe Mestra E2EE';

  @override
  String get setPasswordDescription =>
      'Os seus backups serão encriptados com AES-256 antes de enviar.';

  @override
  String get masterPasswordLabel => 'Palavra-passe Mestra';

  @override
  String get passwordEmptyError => 'A palavra-passe não pode estar vazia';

  @override
  String get syncNow => 'Sincronizar Agora';

  @override
  String get settings => 'Definições';

  @override
  String get connected => 'Ligado';

  @override
  String get disconnected => 'Desligado';

  @override
  String lastSynced(String time) {
    return 'Última sincronização: $time';
  }
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get cloudSettingsTitle => 'Configurações de Nuvem e Sincronização';

  @override
  String get encryptionTitle => 'Criptografia End-to-End (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Criptografar todos os backups com AES-256 antes de enviar';

  @override
  String get encryptionEnabled => 'Ativado (AES-256)';

  @override
  String get encryptionDisabled => 'Desativado';

  @override
  String get configuredDrives => 'Unidades em Nuvem Configuradas';

  @override
  String get noDrivesRegistered => 'Nenhuma Unidade em Nuvem Conectada';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get saveAndEnable => 'Salvar & Ativar';

  @override
  String get setPasswordTitle => 'Definir Senha Mestra E2EE';

  @override
  String get setPasswordDescription =>
      'Seus backups serão criptografados com AES-256 antes de enviar.';

  @override
  String get masterPasswordLabel => 'Senha Mestra';

  @override
  String get passwordEmptyError => 'A senha não pode estar vazia';

  @override
  String get syncNow => 'Sincronizar Agora';

  @override
  String get settings => 'Configurações';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String lastSynced(String time) {
    return 'Última sincronização: $time';
  }
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get cloudSettingsTitle => 'Definições de Nuvem e Sincronização';

  @override
  String get encryptionTitle => 'Encriptação End-to-End (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Encriptar todos os backups com AES-256 antes de enviar';

  @override
  String get encryptionEnabled => 'Ativado (AES-256)';

  @override
  String get encryptionDisabled => 'Desativado';

  @override
  String get configuredDrives => 'Unidades de Nuvem Configuradas';

  @override
  String get noDrivesRegistered => 'Sem Unidades de Nuvem Ligadas';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get saveAndEnable => 'Guardar & Ativar';

  @override
  String get setPasswordTitle => 'Definir Palavra-passe Mestra E2EE';

  @override
  String get setPasswordDescription =>
      'Os seus backups serão encriptados com AES-256 antes de enviar.';

  @override
  String get masterPasswordLabel => 'Palavra-passe Mestra';

  @override
  String get passwordEmptyError => 'A palavra-passe não pode estar vazia';

  @override
  String get syncNow => 'Sincronizar Agora';

  @override
  String get settings => 'Definições';

  @override
  String get connected => 'Ligado';

  @override
  String get disconnected => 'Desligado';

  @override
  String lastSynced(String time) {
    return 'Última sincronização: $time';
  }
}
