import 'package:flutter/foundation.dart';
import 'package:pyro_call_redirection_driver/pyro_call_redirection_driver.dart';

/// Plug-and-Play Assembly Connector for Call Redirection Package Suite
class CallRedirectionConnectors {
  static bool _mounted = false;

  /// Single-line plug-and-play entrypoint for host app assembly.
  static void ensureMounted({bool enableRedirectionDriver = true}) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[CallRedirectionConnectors] Mounting call redirection drivers...');
    if (enableRedirectionDriver) {
      CallRedirectionDriver.register();
    }
    debugPrint('[CallRedirectionConnectors] Call redirection assembly complete.');
  }
}
