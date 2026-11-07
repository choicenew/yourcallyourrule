// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get read => 'Читать';

  @override
  String get shelf => 'На полку';

  @override
  String get shelfIn => 'На полке';

  @override
  String get ocr => 'Распознавание...';

  @override
  String get ocrExtracting => 'Извлечение...';

  @override
  String get translate => 'Параметры перевода';

  @override
  String get comicTranslateAi => 'ИИ Перевод';

  @override
  String get comicTranslateEngine => 'Движок перевода';

  @override
  String get page => 'Страница';

  @override
  String get pageOf => 'из';

  @override
  String get stripMode => 'Непрерывная лента';

  @override
  String get pageMode => 'Постранично';

  @override
  String get description => 'Описание';

  @override
  String get shareComic => 'Поделиться комиксом: ';
}
