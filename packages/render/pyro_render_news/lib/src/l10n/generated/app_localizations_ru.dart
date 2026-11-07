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
  String get ocr => 'Распознавание...';

  @override
  String get ocrExtracting => 'Извлечение...';

  @override
  String get translate => 'Параметры перевода';

  @override
  String get newsTranslateAi => 'ИИ Перевод';

  @override
  String get newsTranslateEngine => 'Движок перевода';

  @override
  String get source => 'Источник';

  @override
  String get publishTime => 'Опубликовано';

  @override
  String get copiedLink => 'Ссылка скопирована в буфер обмена';

  @override
  String get description => 'Описание';

  @override
  String get shareNews => 'Поделиться статьей: ';
}
