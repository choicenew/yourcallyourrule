// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get read => 'Start Reading';

  @override
  String get share => 'Share';

  @override
  String get ocr => 'Extracting...';

  @override
  String get ocrExtracting => 'Extracting...';

  @override
  String get translate => 'Translate';

  @override
  String get newsTranslateAi => 'AI Translate';

  @override
  String get newsTranslateEngine => 'Engine Translate';

  @override
  String get source => 'ソース';

  @override
  String get publishTime => 'Published';

  @override
  String get copiedLink => 'Article link copied to clipboard';

  @override
  String get description => 'Description';

  @override
  String get shareNews => 'Share Article: ';
}
