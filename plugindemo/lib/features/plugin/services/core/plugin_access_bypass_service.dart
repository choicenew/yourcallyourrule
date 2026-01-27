import 'package:flutter/foundation.dart';
import 'plugin_access_bypass_helper.dart';

/// PluginAccessBypassService - Cloudflare Shield Bypass Orchestrator
/// 职责：高层调度，决定是否需要启动“钻地交互”。
class PluginAccessBypassService {
  final _bypassHelper = PluginAccessBypassHelper();

  /// 主入口：绕过 Cloudflare 盾
  Future<Map<String, dynamic>?> bypass(
    String url, {
    String? userAgent,
    String? successMarker,
    String mode = 'interactive',
  }) async {
    debugPrint(
      "🛡️ PluginAccessBypassService: Delegated bypass for $url to Helper",
    );

    // 直接委托给浓缩版的 Helper 引擎
    return await _bypassHelper.executeBypass(
      url,
      userAgent: userAgent,
      successMarker: successMarker,
    );
  }

  void dispose() {
    _bypassHelper.dispose();
  }
}
