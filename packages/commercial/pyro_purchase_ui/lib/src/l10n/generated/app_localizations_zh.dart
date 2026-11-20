// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get sheetTitle => '解锁 VIP 尊享特权';

  @override
  String get sheetSubtitle => '无限端侧大模型翻译 · 全纯净无广告 · 云端高臻同步';

  @override
  String get buyButtonText => '立即开通';

  @override
  String get watchAdButtonText => '看广告兑换 1 天 VIP';

  @override
  String get restoreButtonText => '恢复购买';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get sheetTitle => '解锁 VIP 尊享特权';

  @override
  String get sheetSubtitle => '无限端侧大模型翻译 · 全纯净无广告 · 云端高臻同步';

  @override
  String get buyButtonText => '立即开通';

  @override
  String get watchAdButtonText => '看广告兑换 1 天 VIP';

  @override
  String get restoreButtonText => '恢复购买';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get sheetTitle => '解鎖 VIP 尊享特權';

  @override
  String get sheetSubtitle => '無限端側大模型翻譯 · 全純淨無廣告 · 雲端高精準同步';

  @override
  String get buyButtonText => '立即開通';

  @override
  String get watchAdButtonText => '看廣告兌換 1 天 VIP';

  @override
  String get restoreButtonText => '恢復購買';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get sheetTitle => '解鎖 VIP 尊享特權';

  @override
  String get sheetSubtitle => '無限端側大模型翻譯 · 全純淨無廣告 · 雲端高精準同步';

  @override
  String get buyButtonText => '立即開通';

  @override
  String get watchAdButtonText => '看廣告兌換 1 天 VIP';

  @override
  String get restoreButtonText => '恢復購買';
}
