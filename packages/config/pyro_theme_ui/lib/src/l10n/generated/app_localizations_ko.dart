// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get themeSettingsExpansionTitle => '고급 외관 및 테마 엔진 설정';

  @override
  String get selectThemeModeTitle => '테마 모드 선택';

  @override
  String get themeAuto => '시스템 기본값';

  @override
  String get themeLight => '라이트 테마';

  @override
  String get themeDark => '다크 테마';

  @override
  String get dynamicColorTitle => 'Android 12+ 동적 배경화면 색상 (Material You)';

  @override
  String get dynamicColorSubtitle => '시스템 배경화면 색상을 자동으로 추출하여 앱 테마에 적용';

  @override
  String get flexSchemePresetTitle => 'FlexScheme 사전 설정 테마';

  @override
  String get selectFlexSchemeDialogTitle => '색상 테마 선택';

  @override
  String get pickCustomThemeColorTitle => '사용자 지정 테마 색상 선택';

  @override
  String get oledTrueBlackTitle => 'OLED 트루 블랙 모드';

  @override
  String get oledTrueBlackSubtitle => '다크 모드에서 순수 블랙(#000000) 배경을 사용하여 배터리 절약';

  @override
  String get highContrastTitle => '고대비 시각 효과 향상';

  @override
  String get highContrastSubtitle => '텍스트 및 테두리 대비를 높여 접근성 향상';

  @override
  String get primarySwapTitle => '기본 / 보조 색상 교체';

  @override
  String get primarySwapSubtitle => 'UI에서 메인 색상과 서브 색상의 가중치 교체';

  @override
  String get glassmorphismSectionTitle => '글래스모피즘 효과 (Glassmorphism)';

  @override
  String get glassBlurTitle => '배경 블러 반지름 (Blur Radius)';

  @override
  String get glassOpacityTitle => '컨테이너 불투명도 (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => '앱 표시 언어';

  @override
  String get selectAppLanguageTitle => '앱 언어 선택';

  @override
  String get searchLanguageHint => '언어 이름 또는 코드 검색 (예: ko, en, ja)...';

  @override
  String get designTokensPreviewTitle => '디자인 토큰 팔레트 미리보기';

  @override
  String get modeCustomSeed => '사용자 지정 Seed 색상';

  @override
  String get modeDynamicWallpaper => '동적 배경화면에서 자동 추출';

  @override
  String get modeFlexSchemePreset => 'FlexScheme 사전 설정 색상';

  @override
  String get closeButton => '닫기';
}
