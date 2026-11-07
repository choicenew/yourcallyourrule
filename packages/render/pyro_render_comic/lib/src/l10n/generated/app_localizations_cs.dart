// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get read => 'Začít číst';

  @override
  String get shelf => 'Přidat do police';

  @override
  String get shelfIn => 'V polici';

  @override
  String get ocr => 'Extrakce...';

  @override
  String get ocrExtracting => 'Extrakce...';

  @override
  String get translate => 'Možnosti překladu';

  @override
  String get comicTranslateAi => 'AI překlad';

  @override
  String get comicTranslateEngine => 'Překlad enginem';

  @override
  String get page => 'Stránka';

  @override
  String get pageOf => 'z';

  @override
  String get stripMode => 'Plynulý proužek';

  @override
  String get pageMode => 'Jedna stránka';

  @override
  String get description => 'Popis';

  @override
  String get shareComic => 'Sdílet komiks: ';
}
