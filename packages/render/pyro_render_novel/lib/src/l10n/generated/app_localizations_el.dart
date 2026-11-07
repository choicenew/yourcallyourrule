// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get read => 'Έναρξη ανάγνωσης';

  @override
  String get shelf => 'Προσθήκη στη βιβλιοθήκη';

  @override
  String get shelfIn => 'In Shelf';

  @override
  String get translate => 'Επιλογές μετάφρασης';

  @override
  String get novelTranslateAi => 'AI Translate';

  @override
  String get novelTranslateEngine => 'Engine Translate';

  @override
  String get chapter => 'Chapter';

  @override
  String get catalog => 'Catalog';

  @override
  String get previousChapter => 'Previous';

  @override
  String get nextChapter => 'Next';

  @override
  String get fontSize => 'Font Size';

  @override
  String get description => 'Description';

  @override
  String get shareBook => 'Share Book: ';

  @override
  String get firstChapterReached => 'Already at the first section';

  @override
  String get lastChapterReached => 'Already at the last section';

  @override
  String get localFileLoaded => 'Local document loaded successfully';

  @override
  String get sectionLabel => 'Section';
}
