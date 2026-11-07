// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get demandSentToAi => 'Запрос отправлен ассистенту ИИ';

  @override
  String get urlCopiedToClipboard => 'URL страницы скопирован в буфер обмена';

  @override
  String get cannotOpenExternalUrl =>
      'Невозможно открыть URL во внешнем браузере';

  @override
  String get scanningWebTextNodes =>
      'Сканирование текстовых узлов веб-страницы...';

  @override
  String get noTranslatableWebNodesFound =>
      'Не найдено переводимых текстовых узлов. Пожалуйста, дождитесь полной загрузки страницы.';

  @override
  String get bilingualTranslationComplete =>
      'Строчный двуязычный перевод завершен';

  @override
  String get failedToExtractWebText =>
      'Не удалось извлечь переводимый контент с веб-страницы';

  @override
  String get webDictionarySearchTitle => 'Поиск слов в Интернете и словаре';

  @override
  String get cancel => 'Отмена';

  @override
  String get search => 'Поиск';

  @override
  String get smartSelectionEnabled =>
      'Включена умная всплывающая подсказка выбора текста и связь с панелью действий';

  @override
  String get systemMenuRestored =>
      'Восстановлено системное меню длительного нажатия';

  @override
  String get copyLink => 'Скопировать ссылку';

  @override
  String get openInSystemBrowser => 'Открыть в системном браузере';

  @override
  String get bilingualPageTranslation => 'Двуязычный перевод веб-страницы';

  @override
  String get extractAndTranslateContent => 'Извлечь и перевести контент';

  @override
  String get aiDeepAnalysisSummary => 'Глубокий анализ и аннотация ИИ';

  @override
  String get dictionaryLookup => 'Поиск в словаре';

  @override
  String get shareWebPage => 'Поделиться веб-страницей';

  @override
  String get lookupWordAction => 'Поиск слова';

  @override
  String get translateAction => 'Перевести';

  @override
  String get inputLookupHint =>
      'Введите английское слово или фразу для поиска...';
}
