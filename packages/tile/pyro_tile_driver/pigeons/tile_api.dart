import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/tile_api.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/pyro/tile/TileApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.pyro.tile'),
))

class TileStateRequest {
  TileStateRequest({required this.state, this.subtitle});
  String state;
  String? subtitle;
}

class AddTileRequest {
  AddTileRequest({this.label});
  String? label;
}

@HostApi()
abstract class TileHostApi {
  @async
  bool updateTileState(TileStateRequest request);

  @async
  bool requestAddTile(AddTileRequest request);
}

@FlutterApi()
abstract class TileFlutterApi {
  void onTileClicked(String state);
}

