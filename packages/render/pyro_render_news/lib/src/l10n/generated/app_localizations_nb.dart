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
  String get share => 'Del';

  @override
  String get ocr => 'Trekker ut tekst...';

  @override
  String get ocrExtracting => 'Trekker ut...';

  @override
  String get translate => 'Oversettelsesalternativer';

  @override
  String get newsTranslateAi => 'AI-oversettelse';

  @override
  String get newsTranslateEngine => 'Motoroversettelse';

  @override
  String get source => 'Kilde';

  @override
  String get publishTime => 'Publisert';

  @override
  String get copiedLink => 'Artikkelkobling kopiert til utklippstavle';

  @override
  String get description => 'Beskrivelse';

  @override
  String get shareNews => 'Del artikkel: ';
}
