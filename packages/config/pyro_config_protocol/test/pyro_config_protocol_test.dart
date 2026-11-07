import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_config_protocol/pyro_config_protocol.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ConfigBackupPayload Protocol Tests', () {
    test('ConfigBackupPayload serializes to and from plain Map', () {
      final payload = ConfigBackupPayload(
        timestamp: 1728042000000,
        data: {
          'pyro_theme_mode': {'mode': 1},
          'pyro_l10n_locale': {'code': 'zh_CN'},
        },
      );

      final map = payload.toMap();
      expect(map['type'], equals('config_backup'));
      expect(map['version'], equals(1));
      expect(map['timestamp'], equals(1728042000000));
      expect(map['data'], isA<Map<String, dynamic>>());

      final restored = ConfigBackupPayload.fromMap(map);
      expect(restored.type, equals('config_backup'));
      expect(restored.version, equals(1));
      expect(restored.data, contains('pyro_theme_mode'));
      expect(restored.data, contains('pyro_l10n_locale'));
    });
  });
}
