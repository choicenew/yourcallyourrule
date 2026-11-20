// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get sheetTitle => 'Розблокуйте VIP привілеї';

  @override
  String get sheetSubtitle =>
      'Необмежений переклад Edge AI · Повністю без реклами · Преміум хмарна синхронізація';

  @override
  String get buyButtonText => 'Підписатися зараз';

  @override
  String get watchAdButtonText => 'Дивитися рекламу за 1 день VIP';

  @override
  String get restoreButtonText => 'Відновити покупки';
}
