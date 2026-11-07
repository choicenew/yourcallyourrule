// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get sheetTitle => 'Разблокировать VIP привилегии';

  @override
  String get sheetSubtitle =>
      'Безлимитный ИИ-перевод · Чисто без рекламы · Облачная синхронизация';

  @override
  String get buyButtonText => 'Подключить сейчас';

  @override
  String get watchAdButtonText => 'Посмотреть рекламу за 1 день VIP';

  @override
  String get restoreButtonText => 'Восстановить покупки';
}
