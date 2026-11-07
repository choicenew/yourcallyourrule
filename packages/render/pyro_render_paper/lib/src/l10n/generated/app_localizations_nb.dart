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
  String get push => 'Send / Lagre';

  @override
  String get cite => 'Eksporter sitering';

  @override
  String get ocr => 'Trekker ut tekst...';

  @override
  String get ocrExtracting => 'Trekker ut...';

  @override
  String get translate => 'Oversettelsesalternativer';

  @override
  String get paperTranslateAi => 'AI akademisk oversettelse';

  @override
  String get paperTranslateEngine => 'Standard oversettelse';

  @override
  String get abstractTitle => 'Sammendrag';

  @override
  String get authorsTitle => 'Forfattere';

  @override
  String get citationCopied => 'BibTeX-sitering kopiert til utklippstavle';

  @override
  String get exportBibtex => 'BibTeX';

  @override
  String get keywords => 'Nøkkelord';

  @override
  String get noAbstract => 'Ingen sammendrag tilgjengelig.';

  @override
  String get readFullPaper => 'Les hele artikkelen';

  @override
  String get sharePaper => 'Del artikkel: ';

  @override
  String get doiLabel => 'DOI: ';

  @override
  String get exploreMore => 'Utforsk mer';

  @override
  String get recentlyRead => 'Nylig lest';

  @override
  String get academicTrending => 'Akademiske trender';

  @override
  String get paperPreviewTitle => 'Paper Preview';

  @override
  String get close => 'Lukk';
}
