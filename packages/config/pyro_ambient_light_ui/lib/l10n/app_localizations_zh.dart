// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get warmTintTitle => '暖纸色温护眼';

  @override
  String get eyeCareModeLabel => '防蓝光护眼模式';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get warmTintTitle => '暖纸色温护眼';

  @override
  String get eyeCareModeLabel => '防蓝光护眼模式';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get warmTintTitle => '暖纸色温护眼';

  @override
  String get eyeCareModeLabel => '防蓝光护眼模式';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get warmTintTitle => '暖纸色温护眼';

  @override
  String get eyeCareModeLabel => '防蓝光护眼模式';
}
