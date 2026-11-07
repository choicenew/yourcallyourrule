// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get read => 'পড়া শুরু করুন';

  @override
  String get shelf => 'শেলফে যোগ করুন';

  @override
  String get shelfIn => 'In Shelf';

  @override
  String get ocr => 'এক্সট্রাক্ট করা হচ্ছে...';

  @override
  String get ocrExtracting => 'Extracting...';

  @override
  String get translate => 'অনুবাদ বিকল্প';

  @override
  String get comicTranslateAi => 'AI Translate';

  @override
  String get comicTranslateEngine => 'Engine Translate';

  @override
  String get page => 'Page';

  @override
  String get pageOf => 'of';

  @override
  String get stripMode => 'Continuous Strip';

  @override
  String get pageMode => 'Single Page';

  @override
  String get description => 'Description';

  @override
  String get shareComic => 'Share Comic: ';
}
