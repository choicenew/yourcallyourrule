// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get follow => 'Seguir';

  @override
  String get following => 'Seguint';

  @override
  String get unfollow => 'Deixar de seguir';

  @override
  String get followedMessage => 'Seguint l\'autor';

  @override
  String get unfollowedMessage => 'S\'ha deixat de seguir l\'autor';

  @override
  String get like => 'M\'agrada';

  @override
  String get liked => 'M\'agrada';

  @override
  String get likeAdded => 'Afegit als autors preferits';

  @override
  String get likeRemoved => 'Eliminat dels autors preferits';

  @override
  String get share => 'Compartir';

  @override
  String get homepage => 'Pàgina d\'inici';

  @override
  String get works => 'Obres';

  @override
  String get followers => 'Seguidors';

  @override
  String get translate => 'Opcions de traducció';
}
