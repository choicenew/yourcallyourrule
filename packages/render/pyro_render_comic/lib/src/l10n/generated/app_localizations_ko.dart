// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get read => '읽기 시작';

  @override
  String get shelf => '책장에 추가';

  @override
  String get shelfIn => '책장에 있음';

  @override
  String get ocr => '텍스트 추출';

  @override
  String get ocrExtracting => '추출 중...';

  @override
  String get translate => '번역 옵션';

  @override
  String get comicTranslateAi => 'AI 번역';

  @override
  String get comicTranslateEngine => '엔진 번역';

  @override
  String get page => '페이지';

  @override
  String get pageOf => '/';

  @override
  String get stripMode => '연속 스트립';

  @override
  String get pageMode => '단일 페이지';

  @override
  String get description => '설명';

  @override
  String get shareComic => '만화 공유: ';
}
