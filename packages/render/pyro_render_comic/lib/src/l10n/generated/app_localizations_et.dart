// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get read => 'Alusta lugemist';

  @override
  String get shelf => 'Lisa riiulile';

  @override
  String get shelfIn => 'Riiulil';

  @override
  String get ocr => 'Teksti eraldamine...';

  @override
  String get ocrExtracting => 'Teksti eraldamine...';

  @override
  String get translate => 'Tõlkevalikud';

  @override
  String get comicTranslateAi => 'AI tõlge';

  @override
  String get comicTranslateEngine => 'Mootori tõlge';

  @override
  String get page => 'Lehekülg';

  @override
  String get pageOf => '/';

  @override
  String get stripMode => 'Pidev riba';

  @override
  String get pageMode => 'Üks leht';

  @override
  String get description => 'Kirjeldus';

  @override
  String get shareComic => 'Jaga koomiksit: ';
}
