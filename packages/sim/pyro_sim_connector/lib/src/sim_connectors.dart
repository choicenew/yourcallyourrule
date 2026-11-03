import 'package:flutter/foundation.dart';
import 'package:pyro_sim_driver/pyro_sim_driver.dart';

class SimConnectors {
  static bool _mounted = false;

  static void ensureMounted({bool enableDriver = true}) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[SimConnectors] Mounting SIM package drivers...');
    if (enableDriver) {
      SimDriver.register();
    }
    debugPrint('[SimConnectors] SIM package assembly complete.');
  }
}
