// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get follow => 'Prati';

  @override
  String get following => 'Praćeno';

  @override
  String get unfollow => 'Prestani pratiti';

  @override
  String get followedMessage => 'Autor praćen';

  @override
  String get unfollowedMessage => 'Prestanak praćenja autora';

  @override
  String get like => 'Sviđa mi se';

  @override
  String get liked => 'Sviđa mi się';

  @override
  String get likeAdded => 'Dodano među omiljene autore';

  @override
  String get likeRemoved => 'Uklonjeno iz omiljenih autora';

  @override
  String get share => 'Podijeli';

  @override
  String get homepage => 'Početna stranica';

  @override
  String get works => 'Radovi';

  @override
  String get followers => 'Sljedbenici';

  @override
  String get translate => 'Opcije prevoditelja';
}
