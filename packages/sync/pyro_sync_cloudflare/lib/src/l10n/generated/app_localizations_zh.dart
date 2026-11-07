// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get cloudflareConfigTitle => 'Cloudflare Worker 边缘同步配置';

  @override
  String get workerUrlLabel => 'Worker 节点 URL';

  @override
  String get workerUrlHint => 'https://your-worker.workers.dev';

  @override
  String get apiSecretLabel => 'API 密钥 / Key';

  @override
  String get apiSecretHint => '填入 X-API-SECRET 密钥';

  @override
  String get deviceIdLabel => '设备硬件 ID';

  @override
  String get deviceIdHint => '如 dev_pixel8_001';

  @override
  String get saveConfigButton => '保存配置';

  @override
  String get testConnectionButton => '测试物理连通性';

  @override
  String get saveSuccessMessage => '设置保存成功！';

  @override
  String get testingMessage => '正在测试与 Cloudflare Worker 的物理连通性...';

  @override
  String get testSuccessMessage => '物理连通成功！Cloudflare Worker 状态良好。';

  @override
  String get testFailedMessage => '网络连接失败，请检查 Worker URL 与 API 密钥。';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');
}
