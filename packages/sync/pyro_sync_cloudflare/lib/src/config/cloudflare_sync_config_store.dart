import 'package:pyro_cloudflare/pyro_cloudflare.dart';

/// Cloudflare 同步凭证与配置持久化存储中枢
class CloudflareSyncConfigStore {
  static final CloudflareSyncConfigStore instance = CloudflareSyncConfigStore._();

  CloudflareSyncConfigStore._();

  String _workerUrl = '';
  String _apiSecret = '';
  String _deviceId = '';

  String get workerUrl => _workerUrl;
  String get apiSecret => _apiSecret;
  String get deviceId => _deviceId;

  bool get isConfigured => _workerUrl.isNotEmpty && _apiSecret.isNotEmpty;

  /// 加载/更新凭证配置
  void updateConfig({
    required String workerUrl,
    required String apiSecret,
    String? deviceId,
  }) {
    _workerUrl = workerUrl.trim();
    _apiSecret = apiSecret.trim();
    if (deviceId != null && deviceId.isNotEmpty) {
      _deviceId = deviceId.trim();
    }
  }

  /// 导出底层的 CloudflareConfig (供 pyro_cloudflare 基础设施 SDK 直接使用)
  CloudflareConfig toInfraConfig() {
    return CloudflareConfig(
      workerUrl: _workerUrl,
      apiSecret: _apiSecret,
      accountId: '',
    );
  }
}
