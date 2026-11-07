// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get read => 'Започни четене';

  @override
  String get shelf => 'Добави в рафта';

  @override
  String get shelfIn => 'В рафта';

  @override
  String get ocr => 'Извличане...';

  @override
  String get ocrExtracting => 'Извличане...';

  @override
  String get translate => 'Опции за превод';

  @override
  String get comicTranslateAi => 'AI превод';

  @override
  String get comicTranslateEngine => 'Превод от двигател';

  @override
  String get page => 'Страница';

  @override
  String get pageOf => 'от';

  @override
  String get stripMode => 'Непрекъсната лента';

  @override
  String get pageMode => 'Единична страница';

  @override
  String get description => 'Описание';

  @override
  String get shareComic => 'Споделяне на комикс: ';
}
