// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get read => 'Počni čitanje';

  @override
  String get shelf => 'Dodaj na policu';

  @override
  String get shelfIn => 'Na polici';

  @override
  String get ocr => 'Ekstraktovanje...';

  @override
  String get ocrExtracting => 'Ekstraktovanje...';

  @override
  String get translate => 'Opcije prevoda';

  @override
  String get comicTranslateAi => 'AI prevod';

  @override
  String get comicTranslateEngine => 'Mašinski prevod';

  @override
  String get page => 'Stranica';

  @override
  String get pageOf => 'od';

  @override
  String get stripMode => 'Kontinuirana traka';

  @override
  String get pageMode => 'Jedna stranica';

  @override
  String get description => 'Opis';

  @override
  String get shareComic => 'Podeli strip: ';
}
