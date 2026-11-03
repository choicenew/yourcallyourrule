import 'package:flutter/foundation.dart';
import 'package:pyro_tile_protocol/pyro_tile_protocol.dart';

/// IoC Locator and state manager for Quick Settings Tile.
class TileHub {
  static final TileHub _instance = TileHub._internal();
  static TileHub get instance => _instance;

  TileHub._internal();

  ITileServiceAdapter? _adapter;

  void registerAdapter(ITileServiceAdapter adapter) {
    _adapter = adapter;
    debugPrint('[TileHub] Registered Tile service adapter: ${adapter.providerId}');
  }

  /// Update Quick Settings Tile status.
  Future<bool> updateTileState(TileStateType state, {String? subtitle}) async {
    final adapter = _adapter;
    if (adapter == null) {
      debugPrint('[TileHub] Warning: No ITileServiceAdapter registered!');
      return false;
    }
    return await adapter.updateTileState(state, subtitle: subtitle);
  }

  /// Prompt user to add Quick Settings Tile to status bar pull down.
  Future<bool> requestAddTile() async {
    final adapter = _adapter;
    if (adapter == null) return false;
    return await adapter.requestAddTile();
  }
}
