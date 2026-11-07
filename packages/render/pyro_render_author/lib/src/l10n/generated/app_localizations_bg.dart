// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get follow => 'Следване';

  @override
  String get following => 'Следвани';

  @override
  String get unfollow => 'Спрете следването';

  @override
  String get followedMessage => 'Следвате автора';

  @override
  String get unfollowedMessage => 'Спряхте да следвате автора';

  @override
  String get like => 'Харесвани';

  @override
  String get liked => 'Харесани';

  @override
  String get likeAdded => 'Добавен към харесаните автори';

  @override
  String get likeRemoved => 'Премахнат от харесаните автори';

  @override
  String get share => 'Споделяне';

  @override
  String get homepage => 'Начална страница';

  @override
  String get works => 'Произведения';

  @override
  String get followers => 'Последователи';

  @override
  String get translate => 'Опции за превод';
}
