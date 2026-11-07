// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get read => 'Start læsning';

  @override
  String get shelf => 'Tilføj til hylde';

  @override
  String get shelfIn => 'In Shelf';

  @override
  String get ocr => 'Uddrager...';

  @override
  String get ocrExtracting => 'Extracting...';

  @override
  String get translate => 'Oversættelsesmuligheder';

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
