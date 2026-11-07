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
  String get translate => 'Oversettelsesalternativer';

  @override
  String get novelTranslateAi => 'AI-oversettelse';

  @override
  String get novelTranslateEngine => 'Motoroversettelse';

  @override
  String get chapter => 'Kapittel';

  @override
  String get catalog => 'Katalog';

  @override
  String get previousChapter => 'Forrige';

  @override
  String get nextChapter => 'Neste';

  @override
  String get fontSize => 'Skriftstørrelse';

  @override
  String get description => 'Beskrivelse';

  @override
  String get shareBook => 'Del bok: ';

  @override
  String get firstChapterReached => 'Allerede på første avsnitt';

  @override
  String get lastChapterReached => 'Allerede på siste avsnitt';

  @override
  String get localFileLoaded => 'Lokalt dokument ble lastet inn';

  @override
  String get sectionLabel => 'Seksjon';
}
