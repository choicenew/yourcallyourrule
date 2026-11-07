// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get read => 'Počni čitati';

  @override
  String get shelf => 'Dodaj na policu';

  @override
  String get shelfIn => 'Na polici';

  @override
  String get ocr => 'Izdvajanje...';

  @override
  String get ocrExtracting => 'Izdvajanje...';

  @override
  String get translate => 'Opcije prevoditelja';

  @override
  String get comicTranslateAi => 'AI prijevod';

  @override
  String get comicTranslateEngine => 'Prijevod strojem';

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
  String get shareComic => 'Podijeli strip: ';
}
