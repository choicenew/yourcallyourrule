import '../enums/tile_state_type.dart';

/// Abstract adapter contract for Quick Settings Tile Service.
abstract interface class ITileServiceAdapter {
  String get providerId;

  /// Update Quick Settings Tile status.
  Future<bool> updateTileState(TileStateType state, {String? subtitle});

  /// Request OS to prompt user to add Tile to Quick Settings.
  Future<bool> requestAddTile();
}
