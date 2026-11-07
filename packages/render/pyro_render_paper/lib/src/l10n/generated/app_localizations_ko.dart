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
  String get push => '푸시 / 저장';

  @override
  String get cite => '인용 내보내기';

  @override
  String get ocr => '텍스트 추출';

  @override
  String get ocrExtracting => '추출 중...';

  @override
  String get translate => '번역 옵션';

  @override
  String get paperTranslateAi => 'AI 학술 번역';

  @override
  String get paperTranslateEngine => '표준 번역';

  @override
  String get abstractTitle => '초록';

  @override
  String get authorsTitle => '저자';

  @override
  String get citationCopied => 'BibTeX 인용이 클립보드에 복사되었습니다';

  @override
  String get exportBibtex => 'BibTeX';

  @override
  String get keywords => '키워드';

  @override
  String get noAbstract => '사용 가능한 초록이 없습니다.';

  @override
  String get readFullPaper => '전체 논문 읽기';

  @override
  String get sharePaper => '논문 공유: ';

  @override
  String get doiLabel => 'DOI: ';

  @override
  String get exploreMore => '더 많은 탐색';

  @override
  String get recentlyRead => '최근 읽은 항목';

  @override
  String get academicTrending => '학술 트렌드';

  @override
  String get paperPreviewTitle => 'Paper Preview';

  @override
  String get close => '닫기';
}
