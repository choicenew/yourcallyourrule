import 'package:pyro_tile_hub/pyro_tile_hub.dart';
import 'tile_api.g.dart';

/// Native Tile driver bridging to Android Quick Settings TileService.
class TileDriver implements ITileServiceAdapter, TileFlutterApi {
  static TileDriver? _instance;

  static void register() {
    _instance ??= TileDriver();
    TileHub.instance.registerAdapter(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  final TileHostApi _hostApi;

  TileDriver({TileHostApi? hostApi}) : _hostApi = hostApi ?? TileHostApi() {
    TileFlutterApi.setUp(this);
  }

  void dispose() {
    TileFlutterApi.setUp(null);
  }

  @override
  String get providerId => 'pyro_tile_driver';

  @override
  Future<bool> updateTileState(TileStateType state, {String? subtitle}) async {
    try {
      return await _hostApi.updateTileState(
        TileStateRequest(state: state.name, subtitle: subtitle),
      );
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestAddTile() async {
    try {
      return await _hostApi.requestAddTile(AddTileRequest());
    } catch (_) {
      return false;
    }
  }

  @override
  void onTileClicked(String state) {
    // Native tile click callback
  }
}
