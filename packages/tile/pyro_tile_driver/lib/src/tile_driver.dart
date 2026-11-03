import 'package:flutter/services.dart';
import 'package:pyro_tile_hub/pyro_tile_hub.dart';

/// Native Tile driver bridging to Android Quick Settings TileService.
class TileDriver implements ITileServiceAdapter {
  static void register() {
    TileHub.instance.registerAdapter(TileDriver());
  }

  static const MethodChannel _channel = MethodChannel('com.yours.yourcallyourrule/tile');

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
