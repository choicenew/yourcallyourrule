import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_tile_driver/pyro_tile_driver.dart';
import 'package:pyro_tile_driver/src/tile_api.g.dart';

class FakeTileHostApi implements TileHostApi {
  TileStateRequest? lastUpdateRequest;
  AddTileRequest? lastAddRequest;

  @override
  // ignore: non_constant_identifier_names
  BinaryMessenger? get pigeonVar_binaryMessenger => null;

  @override
  // ignore: non_constant_identifier_names
  String get pigeonVar_messageChannelSuffix => '';

  @override
  Future<bool> updateTileState(TileStateRequest request) async {
    lastUpdateRequest = request;
    return true;
  }

  @override
  Future<bool> requestAddTile(AddTileRequest request) async {
    lastAddRequest = request;
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TileDriver Pigeon Type-Safe Tests', () {
    late FakeTileHostApi fakeHostApi;
    late TileDriver driver;

    setUp(() {
      fakeHostApi = FakeTileHostApi();
      driver = TileDriver(hostApi: fakeHostApi);
    });

    tearDown(() {
      driver.dispose();
    });

    test('updateTileState sends strongly-typed TileStateRequest', () async {
      final success = await driver.updateTileState(
        TileStateType.active,
        subtitle: 'Protected',
      );

      expect(success, isTrue);
      expect(fakeHostApi.lastUpdateRequest, isNotNull);
      expect(fakeHostApi.lastUpdateRequest!.state, equals('active'));
      expect(fakeHostApi.lastUpdateRequest!.subtitle, equals('Protected'));
    });

    test('requestAddTile sends strongly-typed AddTileRequest', () async {
      final success = await driver.requestAddTile();

      expect(success, isTrue);
      expect(fakeHostApi.lastAddRequest, isNotNull);
    });
  });
}

