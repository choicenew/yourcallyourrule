// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get read => 'Lesen beginnen';

  @override
  String get shelf => 'Zum Regal hinzufügen';

  @override
  String get shelfIn => 'Im Regal';

  @override
  String get ocr => 'Extrahieren...';

  @override
  String get ocrExtracting => 'Extrahieren...';

  @override
  String get translate => 'Übersetzungsoptionen';

  @override
  String get comicTranslateAi => 'KI-Übersetzung';

  @override
  String get comicTranslateEngine => 'Engine-Übersetzung';

  @override
  String get page => 'Seite';

  @override
  String get pageOf => 'von';

  @override
  String get stripMode => 'Fortlaufender Strip';

  @override
  String get pageMode => 'Einzelseite';

  @override
  String get description => 'Beschreibung';

  @override
  String get shareComic => 'Comic teilen: ';
}
