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
  String get ocr => 'Εξαγωγή...';

  @override
  String get ocrExtracting => 'Extracting...';

  @override
  String get translate => 'Επιλογές μετάφρασης';

  @override
  String get comicTranslateAi => 'AI Translate';

  @override
  String get comicTranslateEngine => 'Engine Translate';

  @override
  String get page => 'Page';

  @override
  String get pageOf => 'of';

  @override
  String get stripMode => 'Continuous Strip';

  @override
  String get pageMode => 'Single Page';

  @override
  String get description => 'Description';

  @override
  String get shareComic => 'Share Comic: ';
}
