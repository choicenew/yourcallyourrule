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
  String get share => 'Поделиться';

  @override
  String get push => 'Отправить / Сохранить';

  @override
  String get cite => 'Экспорт цитаты';

  @override
  String get ocr => 'Распознавание...';

  @override
  String get ocrExtracting => 'Извлечение...';

  @override
  String get translate => 'Параметры перевода';

  @override
  String get paperTranslateAi => 'ИИ Академический перевод';

  @override
  String get paperTranslateEngine => 'Стандартный перевод';

  @override
  String get abstractTitle => 'Аннотация';

  @override
  String get authorsTitle => 'Авторы';

  @override
  String get citationCopied => 'BibTeX цитата скопирована в буфер обмена';

  @override
  String get exportBibtex => 'BibTeX';

  @override
  String get keywords => 'Ключевые слова';

  @override
  String get noAbstract => 'Аннотация отсутствует.';

  @override
  String get readFullPaper => 'Читать полностью';

  @override
  String get sharePaper => 'Поделиться статьей: ';

  @override
  String get doiLabel => 'DOI: ';

  @override
  String get exploreMore => 'Узнать больше';

  @override
  String get recentlyRead => 'Недавно прочитанные';

  @override
  String get academicTrending => 'Академический тренд';

  @override
  String get paperPreviewTitle => 'Paper Preview';

  @override
  String get close => 'Закрыть';
}
