// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get read => 'Почати читання';

  @override
  String get shelf => 'Додати на полицю';

  @override
  String get shelfIn => 'На полиці';

  @override
  String get ocr => 'Вилучення...';

  @override
  String get ocrExtracting => 'Вилучення...';

  @override
  String get translate => 'Параметри перекладу';

  @override
  String get comicTranslateAi => 'AI переклад';

  @override
  String get comicTranslateEngine => 'Машинний переклад';

  @override
  String get page => 'Сторінка';

  @override
  String get pageOf => 'з';

  @override
  String get stripMode => 'Безперервна стрічка';

  @override
  String get pageMode => 'Окрема сторінка';

  @override
  String get description => 'Опис';

  @override
  String get shareComic => 'Поділитися коміксом: ';
}
