import 'package:flutter/foundation.dart';
import 'plugin_access_bypass_helper.dart';

/// PluginAccessBypassService - Cloudflare Shield Bypass Orchestrator
/// 职责：高层调度，决定是否需要启动“钻地交互”。
class PluginAccessBypassService {
  final _bypassHelper = PluginAccessBypassHelper(); // Uses Singleton

  /// 主入口：绕过 Cloudflare 盾
  Future<Map<String, dynamic>?> bypass(
    String url, {
    String? userAgent,
    String? successMarker,
    String mode = 'auto', // Defaults to 'auto' to try silent polling first
  }) async {
    debugPrint(
      "🛡️ PluginAccessBypassService: Delegated bypass for $url to Helper (Mode: $mode)",
    );

    // 直接委托给浓缩版的 Helper 引擎
    return await _bypassHelper.executeBypass(
      url,
      userAgent: userAgent,
      successMarker: successMarker,
      mode: mode,
    );
  }

  Future<void> stop() async {
    await _bypassHelper.stop();
  }

  void dispose() {
    _bypassHelper.dispose();
  }
}
