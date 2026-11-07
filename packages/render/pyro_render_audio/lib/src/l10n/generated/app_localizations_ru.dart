// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get play => 'Воспроизвести';

  @override
  String get download => 'Загрузка';

  @override
  String get downloading => 'Загрузка...';

  @override
  String get like => 'В избранное';

  @override
  String get liked => 'Нравится';

  @override
  String get pause => 'Пауза';

  @override
  String get playlist => 'В плейлист';

  @override
  String get previousTrack => 'Назад';

  @override
  String get nextTrack => 'Вперед';

  @override
  String get speed => 'Скорость';

  @override
  String get share => 'Поделиться';

  @override
  String get description => 'Описание';

  @override
  String get shareAudio => 'Поделиться аудио: ';

  @override
  String get exploreMore => 'Узнать больше';

  @override
  String get trending => 'В тренде';

  @override
  String get switchSource => 'Сменить источник / Сообщить';
}
