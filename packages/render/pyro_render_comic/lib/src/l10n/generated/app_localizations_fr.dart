// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get read => 'Commencer la lecture';

  @override
  String get shelf => 'Ajouter à la bibliothèque';

  @override
  String get shelfIn => 'Dans la bibliothèque';

  @override
  String get ocr => 'Extraction...';

  @override
  String get ocrExtracting => 'Extraction...';

  @override
  String get translate => 'Options de traduction';

  @override
  String get comicTranslateAi => 'Traduction IA';

  @override
  String get comicTranslateEngine => 'Traduction moteur';

  @override
  String get page => 'Page';

  @override
  String get pageOf => 'sur';

  @override
  String get stripMode => 'Bande continue';

  @override
  String get pageMode => 'Page unique';

  @override
  String get description => 'Description';

  @override
  String get shareComic => 'Partager la BD : ';
}
