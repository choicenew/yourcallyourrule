import 'dart:io';
import 'package:flutter/foundation.dart';

/// PyroPlatformNetwork: 全局网络极简接管门面
/// 专为零侵入无损适配设计。主 App 在 main() 函数第一行调用 [install]，
/// 即可通过全局 [HttpOverrides] 无感接管应用层及河图脚本引擎的所有底层网络请求。
class PyroPlatformNetwork {
  PyroPlatformNetwork._();

  static bool _isInstalled = false;

  /// 开启全局原生网络拦截与 TLS 证书适配
  /// [enableUnsafeSsl] 是否放行自签名/不受信任的 SSL 证书（默认 Windows 场景下开启放行）
  static void install({bool enableUnsafeSsl = true}) {
    if (_isInstalled) return;

    HttpOverrides.global = _PyroHttpOverrides(enableUnsafeSsl: enableUnsafeSsl);
    _isInstalled = true;
    debugPrint('🚀 [PyroPlatformNetwork] App-wide HttpOverrides installed successfully.');
  }

  /// 检查是否已挂载全局拦截
  static bool get isInstalled => _isInstalled;
}

class _PyroHttpOverrides extends HttpOverrides {
  final bool enableUnsafeSsl;

  _PyroHttpOverrides({this.enableUnsafeSsl = true});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    if (enableUnsafeSsl) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    }

    return client;
  }
}
