// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get read => 'Start Reading';

  @override
  String get shelf => 'Add to Shelf';

  @override
  String get shelfIn => 'In Shelf';

  @override
  String get ocr => 'Extracting...';

  @override
  String get ocrExtracting => 'Extracting...';

  @override
  String get translate => 'Translate';

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
