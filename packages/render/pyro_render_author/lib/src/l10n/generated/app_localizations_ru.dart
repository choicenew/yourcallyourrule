// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get follow => 'Подписаться';

  @override
  String get following => 'Подписки';

  @override
  String get unfollow => 'Отписаться';

  @override
  String get followedMessage => 'Автор добавлен в подписки';

  @override
  String get unfollowedMessage => 'Автор удален из подписок';

  @override
  String get like => 'В избранное';

  @override
  String get liked => 'Нравится';

  @override
  String get likeAdded => 'Добавлено в понравившиеся авторы';

  @override
  String get likeRemoved => 'Удалено из понравившихся авторов';

  @override
  String get share => 'Поделиться';

  @override
  String get homepage => 'Главная';

  @override
  String get works => 'Работы';

  @override
  String get followers => 'Подписчики';

  @override
  String get translate => 'Параметры перевода';
}
