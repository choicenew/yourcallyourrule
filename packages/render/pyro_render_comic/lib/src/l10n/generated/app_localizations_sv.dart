// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get read => 'Börja läsa';

  @override
  String get shelf => 'Lägg till i hylla';

  @override
  String get shelfIn => 'I hylla';

  @override
  String get ocr => 'Extraherar...';

  @override
  String get ocrExtracting => 'Extraherar...';

  @override
  String get translate => 'Översättningsalternativ';

  @override
  String get comicTranslateAi => 'AI-översättning';

  @override
  String get comicTranslateEngine => 'Motoröversättning';

  @override
  String get page => 'Sida';

  @override
  String get pageOf => 'av';

  @override
  String get stripMode => 'Kontinuerlig remsa';

  @override
  String get pageMode => 'Enkeltsida';

  @override
  String get description => 'Beskrivning';

  @override
  String get shareComic => 'Dela serie: ';
}
