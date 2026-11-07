// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get follow => '팔로우';

  @override
  String get following => '팔로잉';

  @override
  String get unfollow => '언팔로우';

  @override
  String get followedMessage => '저자를 팔로우했습니다';

  @override
  String get unfollowedMessage => '저자 팔로우를 취소했습니다';

  @override
  String get like => '즐겨찾기';

  @override
  String get liked => '좋아요 표시됨';

  @override
  String get likeAdded => '좋아요한 저자에 추가됨';

  @override
  String get likeRemoved => '좋아요한 저자에서 제거됨';

  @override
  String get share => '공유';

  @override
  String get homepage => '홈페이지';

  @override
  String get works => '작품';

  @override
  String get followers => '팔로워';

  @override
  String get translate => '번역 옵션';
}
