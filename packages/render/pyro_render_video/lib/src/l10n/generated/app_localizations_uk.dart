// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get play => 'Відтворити відео';

  @override
  String get download => 'Завантаження';

  @override
  String get downloading => 'Завантаження...';

  @override
  String get like => 'Сподобалося';

  @override
  String get liked => 'Сподобалося';

  @override
  String get pause => 'Пауза';

  @override
  String get replay => 'Повторити';

  @override
  String get speed => 'Швидкість';

  @override
  String get quality => 'Якість';

  @override
  String get share => 'Поділитися';

  @override
  String get description => 'Опис';

  @override
  String get shareVideo => 'Поділитися відео: ';
}
