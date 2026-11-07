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
  String get replay => 'Повтор';

  @override
  String get speed => 'Скорость';

  @override
  String get quality => 'Качество';

  @override
  String get share => 'Поделиться';

  @override
  String get description => 'Описание';

  @override
  String get shareVideo => 'Поделиться видео: ';
}
