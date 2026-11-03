import 'package:flutter/foundation.dart';
import 'package:pyro_call_screening_driver/pyro_call_screening_driver.dart';

class CallScreeningConnectors {
  static bool _mounted = false;

  static void ensureMounted({bool enableDriver = true}) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[CallScreeningConnectors] Mounting CallScreening drivers...');
    if (enableDriver) {
      CallScreeningDriver.register();
    }
    debugPrint('[CallScreeningConnectors] CallScreening assembly complete.');
  }
}
