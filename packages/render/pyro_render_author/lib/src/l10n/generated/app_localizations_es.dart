// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get follow => 'Seguir';

  @override
  String get following => 'Siguiendo';

  @override
  String get unfollow => 'Dejar de seguir';

  @override
  String get followedMessage => 'Autor seguido';

  @override
  String get unfollowedMessage => 'Autor dejado de seguir';

  @override
  String get like => 'Favorito';

  @override
  String get liked => 'Me gusta';

  @override
  String get likeAdded => 'Añadido a autores favoritos';

  @override
  String get likeRemoved => 'Eliminado de autores favoritos';

  @override
  String get share => 'Compartir';

  @override
  String get homepage => 'Inicio';

  @override
  String get works => 'Obras';

  @override
  String get followers => 'Seguidores';

  @override
  String get translate => 'Opciones de traducción';
}
