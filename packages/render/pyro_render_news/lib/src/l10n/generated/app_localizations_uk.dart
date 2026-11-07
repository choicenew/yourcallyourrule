// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get read => 'Почати читання';

  @override
  String get share => 'Поділитися';

  @override
  String get ocr => 'Вилучення...';

  @override
  String get ocrExtracting => 'Вилучення...';

  @override
  String get translate => 'Параметри перекладу';

  @override
  String get newsTranslateAi => 'AI переклад';

  @override
  String get newsTranslateEngine => 'Машинний переклад';

  @override
  String get source => 'Джерело';

  @override
  String get publishTime => 'Опубліковано';

  @override
  String get copiedLink => 'Посилання на статтю скопійовано в буфер обміну';

  @override
  String get description => 'Опис';

  @override
  String get shareNews => 'Поділитися статтею: ';
}
