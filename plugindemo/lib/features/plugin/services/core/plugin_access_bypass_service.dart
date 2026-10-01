import 'package:flutter/foundation.dart';
import 'plugin_access_bypass_helper.dart';

/// PluginAccessBypassService - Cloudflare Shield Bypass Orchestrator
class PluginAccessBypassService {
  final _bypassHelper = PluginAccessBypassHelper();

  Future<Map<String, dynamic>?> bypass(
    String url, {
    String? userAgent,
    String? successMarker,
    String mode = 'auto',
  }) async {
    debugPrint(
      "🛡️ PluginAccessBypassService: Delegated bypass for $url to Helper (Mode: $mode)",
    );

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
