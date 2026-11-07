// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get read => 'Start lesing';

  @override
  String get shelf => 'Legg til i hylle';

  @override
  String get shelfIn => 'I hylle';

  @override
  String get ocr => 'Trekker ut tekst...';

  @override
  String get ocrExtracting => 'Trekker ut...';

  @override
  String get translate => 'Oversettelsesalternativer';

  @override
  String get comicTranslateAi => 'AI-oversettelse';

  @override
  String get comicTranslateEngine => 'Motoroversettelse';

  @override
  String get page => 'Side';

  @override
  String get pageOf => 'av';

  @override
  String get stripMode => 'Kontinuerlig stripe';

  @override
  String get pageMode => 'Enkeltside';

  @override
  String get description => 'Beskrivelse';

  @override
  String get shareComic => 'Del tegneserie: ';
}
