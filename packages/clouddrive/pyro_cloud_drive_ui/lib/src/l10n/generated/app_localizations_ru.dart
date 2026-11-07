// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Настройки облака и синхронизации';

  @override
  String get encryptionTitle => 'Шифрование (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Шифрование всех резервных копий с помощью AES-256 перед загрузкой';

  @override
  String get encryptionEnabled => 'Включено (AES-256)';

  @override
  String get encryptionDisabled => 'Отключено';

  @override
  String get configuredDrives => 'Настроенные облачные диски';

  @override
  String get noDrivesRegistered => 'Нет подключенных облачных дисков';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get saveAndEnable => 'Сохранить и включить';

  @override
  String get setPasswordTitle => 'Установить мастер-пароль E2EE';

  @override
  String get setPasswordDescription =>
      'Ваши бэкапы будут зашифрованы с помощью AES-256 перед загрузкой.';

  @override
  String get masterPasswordLabel => 'Мастер-пароль';

  @override
  String get passwordEmptyError => 'Пароль не может быть пустым';

  @override
  String get syncNow => 'Синхронизировать';

  @override
  String get settings => 'Настройки';

  @override
  String get connected => 'Подключено';

  @override
  String get disconnected => 'Отключено';

  @override
  String lastSynced(String time) {
    return 'Последняя синхронизация: $time';
  }
}
