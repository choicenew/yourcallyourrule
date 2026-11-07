// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get syncSettingsTitle => '云端数据同步设置';

  @override
  String get syncStatusIdle => '所有数据已全新同步';

  @override
  String get syncStatusSyncing => '正在同步增量数据...';

  @override
  String get syncNowLabel => '立即同步';

  @override
  String get mountedProvidersSectionTitle => '已挂载的同步提供商';

  @override
  String get testConnectivity => '测试物理连通性';

  @override
  String get connectionSuccess => '网络物理连通成功！';

  @override
  String get connectionFailed => '无法连接，请检查配置';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get syncSettingsTitle => '云端数据同步设置';

  @override
  String get syncStatusIdle => '所有数据已全新同步';

  @override
  String get syncStatusSyncing => '正在同步增量数据...';

  @override
  String get syncNowLabel => '立即同步';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get syncSettingsTitle => '云端数据同步设置';

  @override
  String get syncStatusIdle => '所有数据已全新同步';

  @override
  String get syncStatusSyncing => '正在同步增量数据...';

  @override
  String get syncNowLabel => '立即同步';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get syncSettingsTitle => '云端数据同步设置';

  @override
  String get syncStatusIdle => '所有数据已全新同步';

  @override
  String get syncStatusSyncing => '正在同步增量数据...';

  @override
  String get syncNowLabel => '立即同步';
}
