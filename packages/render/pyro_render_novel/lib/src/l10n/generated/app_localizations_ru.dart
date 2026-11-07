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
  String get translate => 'Параметры перевода';

  @override
  String get novelTranslateAi => 'ИИ Перевод';

  @override
  String get novelTranslateEngine => 'Движок перевода';

  @override
  String get chapter => 'Глава';

  @override
  String get catalog => 'Оглавление';

  @override
  String get previousChapter => 'Назад';

  @override
  String get nextChapter => 'Вперед';

  @override
  String get fontSize => 'Размер шрифта';

  @override
  String get description => 'Описание';

  @override
  String get shareBook => 'Поделиться книгой: ';

  @override
  String get firstChapterReached => 'Это первый раздел';

  @override
  String get lastChapterReached => 'Это последний раздел';

  @override
  String get localFileLoaded => 'Локальный документ успешно загружен';

  @override
  String get sectionLabel => 'Раздел';
}
