import 'package:flutter/services.dart';
import 'package:pyro_tile_hub/pyro_tile_hub.dart';

/// Native Tile driver bridging to Android Quick Settings TileService.
class TileDriver implements ITileServiceAdapter {
  static TileDriver? _instance;

  static void register() {
    _instance ??= TileDriver();
    TileHub.instance.registerAdapter(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  static const MethodChannel _channel = MethodChannel('net.pyro.telephony/tile');

  void dispose() {
    // Clean up if needed
  }

  @override
  String get providerId => 'pyro_tile_driver';

  @override
  Future<bool> updateTileState(TileStateType state, {String? subtitle}) async {
    try {
      final bool? success = await _channel.invokeMethod<bool>('updateTileState', {
        'state': state.name,
        'subtitle': subtitle,
      });
      return success ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestAddTile() async {
    try {
      final bool? success = await _channel.invokeMethod<bool>('requestAddTile');
      return success ?? false;
    } catch (_) {
      return false;
    }
  }
}
