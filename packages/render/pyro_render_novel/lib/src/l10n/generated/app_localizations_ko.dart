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
  String get translate => '번역 옵션';

  @override
  String get novelTranslateAi => 'AI 번역';

  @override
  String get novelTranslateEngine => '엔진 번역';

  @override
  String get chapter => '챕터';

  @override
  String get catalog => '목차';

  @override
  String get previousChapter => '이전';

  @override
  String get nextChapter => '다음';

  @override
  String get fontSize => '글꼴 크기';

  @override
  String get description => '설명';

  @override
  String get shareBook => '도서 공유: ';

  @override
  String get firstChapterReached => '이미 첫 번째 섹션입니다';

  @override
  String get lastChapterReached => '이미 마지막 섹션입니다';

  @override
  String get localFileLoaded => '로컬 문서 로드 성공';

  @override
  String get sectionLabel => '섹션';
}
