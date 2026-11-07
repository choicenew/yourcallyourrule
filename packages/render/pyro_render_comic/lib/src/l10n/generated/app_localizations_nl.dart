// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get read => 'Begin met lezen';

  @override
  String get shelf => 'Toevoegen aan boekenplank';

  @override
  String get shelfIn => 'In plank';

  @override
  String get ocr => 'Bezig met extraheren...';

  @override
  String get ocrExtracting => 'Bezig met extraheren...';

  @override
  String get translate => 'Vertalingsopties';

  @override
  String get comicTranslateAi => 'AI-vertaling';

  @override
  String get comicTranslateEngine => 'Motorvertaling';

  @override
  String get page => 'Pagina';

  @override
  String get pageOf => 'van';

  @override
  String get stripMode => 'Doorlopende strook';

  @override
  String get pageMode => 'Enkele pagina';

  @override
  String get description => 'Beschrijving';

  @override
  String get shareComic => 'Strip delen: ';
}
