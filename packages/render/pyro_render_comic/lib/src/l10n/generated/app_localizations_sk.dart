// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get read => 'Začať čítať';

  @override
  String get shelf => 'Pridať na poličku';

  @override
  String get shelfIn => 'Na poličke';

  @override
  String get ocr => 'Extrahuje sa...';

  @override
  String get ocrExtracting => 'Extrahuje sa...';

  @override
  String get translate => 'Možnosti prekladu';

  @override
  String get comicTranslateAi => 'AI preklad';

  @override
  String get comicTranslateEngine => 'Preklad enginom';

  @override
  String get page => 'Strana';

  @override
  String get pageOf => 'z';

  @override
  String get stripMode => 'Priebežný pás';

  @override
  String get pageMode => 'Jedna strana';

  @override
  String get description => 'Popis';

  @override
  String get shareComic => 'Zdieľať komiks: ';
}
