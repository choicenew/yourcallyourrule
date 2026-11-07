// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get demandSentToAi => '요청이 AI 어시스턴트로 전송되었습니다';

  @override
  String get urlCopiedToClipboard => '페이지 URL이 클립보드에 복사되었습니다';

  @override
  String get cannotOpenExternalUrl => '외부 브라우저에서 URL을 열 수 없습니다';

  @override
  String get scanningWebTextNodes => '웹 텍스트 노드 스캔 중...';

  @override
  String get noTranslatableWebNodesFound =>
      '번역 가능한 텍스트 노드를 찾을 수 없습니다. 페이지가 완전히 로드될 때까지 기다려 주세요.';

  @override
  String get bilingualTranslationComplete => '인라인 이중 언어 대역 번역 완료';

  @override
  String get failedToExtractWebText => '웹페이지에서 번역 가능한 콘텐츠를 추출하지 못했습니다';

  @override
  String get webDictionarySearchTitle => '웹 단어 검색 및 사전 검색';

  @override
  String get cancel => '취소';

  @override
  String get search => '검색';

  @override
  String get smartSelectionEnabled => '스마트 텍스트 선택 버블 및 작업 표시줄 연동 활성화됨';

  @override
  String get systemMenuRestored => '시스템 기본 길게 누르기 메뉴가 복원되었습니다';

  @override
  String get copyLink => '링크 복사';

  @override
  String get openInSystemBrowser => '시스템 브라우저에서 열기';

  @override
  String get bilingualPageTranslation => '웹페이지 이중 언어 대역 번역';

  @override
  String get extractAndTranslateContent => '콘텐츠 추출 및 번역';

  @override
  String get aiDeepAnalysisSummary => 'AI 심층 분석 및 요약';

  @override
  String get dictionaryLookup => '사전 단어 조회';

  @override
  String get shareWebPage => '웹페이지 공유';

  @override
  String get lookupWordAction => '단어 조회';

  @override
  String get translateAction => '번역';

  @override
  String get inputLookupHint => '조회할 영어 단어 또는 문구를 입력하세요...';
}
