import 'package:flutter/foundation.dart';
import 'package:pyro_stir_driver/pyro_stir_driver.dart';

class StirConnectors {
  static bool _mounted = false;

  static void ensureMounted({bool enableDriver = true}) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[StirConnectors] Mounting STIR package drivers...');
    if (enableDriver) {
      StirDriver.register();
    }
    debugPrint('[StirConnectors] STIR package assembly complete.');
  }
}
