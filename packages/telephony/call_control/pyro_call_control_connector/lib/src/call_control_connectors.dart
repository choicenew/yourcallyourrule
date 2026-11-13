import 'package:flutter/foundation.dart';
import 'package:pyro_call_control_driver/pyro_call_control_driver.dart';
import 'package:pyro_call_control_hub/pyro_call_control_hub.dart';

/// Plug-and-Play Assembly Connector for Call Control Package Suite
class CallControlConnectors {
  static bool _mounted = false;

  /// Single-line plug-and-play entrypoint for host app assembly.
  static void ensureMounted({
    bool enableDriver = true,
    int? defaultHangupDelayMs,
    bool enableMicMuteProtection = true,
  }) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[CallControlConnectors] Mounting Call Control drivers...');

    if (defaultHangupDelayMs != null) {
      CallControlHub.instance.defaultHangupDelayMs = defaultHangupDelayMs;
    }
    CallControlHub.instance.enableMicMuteProtection = enableMicMuteProtection;

    if (enableDriver) {
      CallControlDriver.register();
    }

    debugPrint('[CallControlConnectors] Call Control assembly complete.');
  }
}
