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
  String get translate => 'Параметри перекладу';

  @override
  String get novelTranslateAi => 'AI переклад';

  @override
  String get novelTranslateEngine => 'Машинний переклад';

  @override
  String get chapter => 'Розділ';

  @override
  String get catalog => 'Каталог';

  @override
  String get previousChapter => 'Попередній';

  @override
  String get nextChapter => 'Наступний';

  @override
  String get fontSize => 'Розмір шрифту';

  @override
  String get description => 'Опис';

  @override
  String get shareBook => 'Поділитися книгою: ';

  @override
  String get firstChapterReached => 'Вже на першому розділі';

  @override
  String get lastChapterReached => 'Вже на останньому розділі';

  @override
  String get localFileLoaded => 'Локальний документ успішно завантажено';

  @override
  String get sectionLabel => 'Розділ';
}
