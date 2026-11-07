// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Настройки за облак и синхронизация';

  @override
  String get encryptionTitle => 'Крайно шифране (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Шифране на всички резервни копия с AES-256 преди качване';

  @override
  String get encryptionEnabled => 'Активирано (AES-256)';

  @override
  String get encryptionDisabled => 'Деактивирано';

  @override
  String get configuredDrives => 'Конфигурирани облачни дискове';

  @override
  String get noDrivesRegistered => 'Няма свързани облачни дискове';

  @override
  String get cancel => 'Отказ';

  @override
  String get save => 'Запази';

  @override
  String get saveAndEnable => 'Запази и активирай';

  @override
  String get setPasswordTitle => 'Задаване на E2EE главна парола';

  @override
  String get setPasswordDescription =>
      'Вашите архиви ще бъдат шифровани с AES-256 преди качване.';

  @override
  String get masterPasswordLabel => 'Главна парола';

  @override
  String get passwordEmptyError => 'Паролата не може да бъде празна';

  @override
  String get syncNow => 'Синхронизиране сега';

  @override
  String get settings => 'Настройки';

  @override
  String get connected => 'Свързан';

  @override
  String get disconnected => 'Прекъснат';

  @override
  String lastSynced(String time) {
    return 'Последно синхронизирано: $time';
  }
}
