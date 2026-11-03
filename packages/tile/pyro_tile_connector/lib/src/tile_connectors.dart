import 'package:flutter/foundation.dart';
import 'package:pyro_tile_driver/pyro_tile_driver.dart';

class TileConnectors {
  static bool _mounted = false;

  static void ensureMounted({bool enableDriver = true}) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[TileConnectors] Mounting Quick Settings Tile package drivers...');
    if (enableDriver) {
      TileDriver.register();
    }
    debugPrint('[TileConnectors] Quick Settings Tile package assembly complete.');
  }
}
