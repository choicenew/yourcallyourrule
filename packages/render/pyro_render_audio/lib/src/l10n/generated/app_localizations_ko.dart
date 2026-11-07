// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get play => '재생';

  @override
  String get download => '다운로드 중';

  @override
  String get downloading => '다운로드 중...';

  @override
  String get like => '즐겨찾기';

  @override
  String get liked => '좋아요 표시됨';

  @override
  String get pause => '일시 정지';

  @override
  String get playlist => '재생 목록에 추가';

  @override
  String get previousTrack => '이전 트랙';

  @override
  String get nextTrack => '다음 트랙';

  @override
  String get speed => '속도';

  @override
  String get share => '공유';

  @override
  String get description => '설명';

  @override
  String get shareAudio => '오디오 공유: ';

  @override
  String get exploreMore => '더 많은 탐색';

  @override
  String get trending => '인기 급상승';

  @override
  String get switchSource => '소스 전환 / 신고';
}
