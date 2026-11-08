import 'package:test/test.dart';
import 'package:pyro_central_database_protocol/pyro_central_database_protocol.dart';

void main() {
  group('pyro_central_database_protocol 协议包单元测试', () {
    test('CentralPublicEntity 序列化与反序列化测试', () {
      final entity = CentralPublicEntity(
        id: 'central_rule_001',
        domain: 'system_rule',
        entityKey: 'global_clean_rule_v1',
        payload: {'priority': 100, 'enabled': true},
        version: 2,
        updatedAt: '2026-10-20T12:00:00Z',
      );

      final json = entity.toJson();
      expect(json['id'], equals('central_rule_001'));
      expect(json['domain'], equals('system_rule'));
      expect(json['version'], equals(2));

      final restored = CentralPublicEntity.fromJson(json);
      expect(restored.id, equals('central_rule_001'));
      expect(restored.payload['priority'], equals(100));
    });
  });
}
