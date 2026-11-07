// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get follow => 'Стежити';

  @override
  String get following => 'Ви стежите';

  @override
  String get unfollow => 'Не стежити';

  @override
  String get followedMessage => 'Ви підписалися на автора';

  @override
  String get unfollowedMessage => 'Ви відписалися від автора';

  @override
  String get like => 'Сподобалося';

  @override
  String get liked => 'Сподобалося';

  @override
  String get likeAdded => 'Додано до улюблених авторів';

  @override
  String get likeRemoved => 'Видалено з улюблених авторів';

  @override
  String get share => 'Поділитися';

  @override
  String get homepage => 'Головна сторінка';

  @override
  String get works => 'Роботи';

  @override
  String get followers => 'Підписники';

  @override
  String get translate => 'Параметри перекладу';
}
