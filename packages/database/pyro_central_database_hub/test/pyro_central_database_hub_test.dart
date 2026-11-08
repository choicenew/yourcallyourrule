import 'package:test/test.dart';
import 'package:pyro_central_database_protocol/pyro_central_database_protocol.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';

class MockCentralAdapter implements CentralDatabaseAdapter {
  @override
  String get moduleId => 'mock_central_db';

  @override
  Future<List<CentralPublicEntity>> fetchPublicEntities(String domain) async => [];

  @override
  Future<CentralPublicEntity?> getPublicEntity(String domain, String entityKey) async => null;

  @override
  Future<bool> publishPublicEntity(CentralPublicEntity entity) async => true;

  @override
  Future<bool> initialize() async => true;
}

void main() {
  group('pyro_central_database_hub 单例注册测试', () {
    setUp(() {
      CentralDatabaseHub.instance.clear();
    });

    test('CentralDatabaseHub 适配器注册与获取测试', () {
      final hub = CentralDatabaseHub.instance;
      final mockAdapter = MockCentralAdapter();

      hub.register(mockAdapter);
      expect(hub.getAdapter('mock_central_db'), equals(mockAdapter));
      expect(hub.allAdapters.length, equals(1));

      hub.unregister('mock_central_db');
      expect(hub.getAdapter('mock_central_db'), isNull);
    });
  });
}
