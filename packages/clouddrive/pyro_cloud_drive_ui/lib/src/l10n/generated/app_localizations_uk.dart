// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Налаштування хмари та синхронізації';

  @override
  String get encryptionTitle => 'Сквозне шифрування (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Шифрувати всі бекапи за допомогою AES-256 перед завантаженням';

  @override
  String get encryptionEnabled => 'Увімкнено (AES-256)';

  @override
  String get encryptionDisabled => 'Вимкнено';

  @override
  String get configuredDrives => 'Налаштовані хмарні диски';

  @override
  String get noDrivesRegistered => 'Немає підключених хмарних дисків';

  @override
  String get cancel => 'Скасувати';

  @override
  String get save => 'Зберегти';

  @override
  String get saveAndEnable => 'Зберегти та увімкнути';

  @override
  String get setPasswordTitle => 'Встановити головний пароль E2EE';

  @override
  String get setPasswordDescription =>
      'Ваші резервні копії будуть зашифровані за допомогою AES-256 перед завантаженням.';

  @override
  String get masterPasswordLabel => 'Головний пароль';

  @override
  String get passwordEmptyError => 'Пароль не може бути порожнім';

  @override
  String get syncNow => 'Синхронізувати зараз';

  @override
  String get settings => 'Налаштування';

  @override
  String get connected => 'Підключено';

  @override
  String get disconnected => 'Відключено';

  @override
  String lastSynced(String time) {
    return 'Остання синхронізація: $time';
  }
}
