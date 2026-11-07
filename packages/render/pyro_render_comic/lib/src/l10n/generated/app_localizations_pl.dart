// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get read => 'Rozpocznij czytanie';

  @override
  String get shelf => 'Dodaj do półki';

  @override
  String get shelfIn => 'Na półce';

  @override
  String get ocr => 'Wyodrębnianie...';

  @override
  String get ocrExtracting => 'Wyodrębnianie...';

  @override
  String get translate => 'Opcje tłumaczenia';

  @override
  String get comicTranslateAi => 'Tłumaczenie AI';

  @override
  String get comicTranslateEngine => 'Tłumaczenie maszynowe';

  @override
  String get page => 'Strona';

  @override
  String get pageOf => 'z';

  @override
  String get stripMode => 'Ciągły pasek';

  @override
  String get pageMode => 'Pojedyncza strona';

  @override
  String get description => 'Opis';

  @override
  String get shareComic => 'Udostępnij komiks: ';
}
