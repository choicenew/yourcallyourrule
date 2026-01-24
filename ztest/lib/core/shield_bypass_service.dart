import 'package:flutter/foundation.dart';
import 'cloudflare_legacy_service.dart';

/// ShieldBypassService - Cloudflare Shield Bypass Orchestrator
/// 职责：高层调度，决定是否需要启动“钻地交互”。
class ShieldBypassService {
  final _legacyService = CloudflareLegacyService();

  /// 主入口：绕过 Cloudflare 盾
  Future<Map<String, dynamic>?> bypass(
    String url, {
    String? userAgent,
    String? successMarker,
    String mode = 'interactive',
  }) async {
    debugPrint(
      "🛡️ ShieldBypassService: Delegated bypass for $url to Legacy Engine",
    );

    // 直接委托给浓缩版的 Tiny Legacy 引擎
    return await _legacyService.executeBypass(
      url,
      successMarker: successMarker,
    );
  }

  void dispose() {
    _legacyService.dispose();
  }
}
