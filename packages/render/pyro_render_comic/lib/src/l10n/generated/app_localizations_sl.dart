// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get read => 'Začni brati';

  @override
  String get shelf => 'Dodaj na polico';

  @override
  String get shelfIn => 'Na polici';

  @override
  String get ocr => 'Ekstrahiranje...';

  @override
  String get ocrExtracting => 'Ekstrahiranje...';

  @override
  String get translate => 'Možnosti prevajanja';

  @override
  String get comicTranslateAi => 'Prevajanje AI';

  @override
  String get comicTranslateEngine => 'Prevajanje s pogonom';

  @override
  String get page => 'Stran';

  @override
  String get pageOf => 'od';

  @override
  String get stripMode => 'Neprekinjen trak';

  @override
  String get pageMode => 'Ena stran';

  @override
  String get description => 'Opis';

  @override
  String get shareComic => 'Deli strip: ';
}
