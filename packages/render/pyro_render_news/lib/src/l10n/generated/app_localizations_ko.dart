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
  String get share => '공유';

  @override
  String get ocr => '텍스트 추출';

  @override
  String get ocrExtracting => '추출 중...';

  @override
  String get translate => '번역 옵션';

  @override
  String get newsTranslateAi => 'AI 번역';

  @override
  String get newsTranslateEngine => '엔진 번역';

  @override
  String get source => '소스';

  @override
  String get publishTime => '게시됨';

  @override
  String get copiedLink => '기사 링크가 클립보드에 복사되었습니다';

  @override
  String get description => '설명';

  @override
  String get shareNews => '기사 공유: ';
}
