import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_database/pyro_cloud_drive_database.dart';

void main() {
  group('CloudDriveDatabase Tests', () {
    test('SyncConflictResolver resolves conflicts by updatedAt', () {
      final resolver = SyncConflictResolver();
      final local = [
        {'id': '1', 'name': 'local old', 'updatedAt': '2026-01-01T00:00:00Z'},
        {'id': '2', 'name': 'local new', 'updatedAt': '2026-01-02T00:00:00Z'},
      ];
      final remote = [
        {'id': '1', 'name': 'remote new', 'updatedAt': '2026-01-02T00:00:00Z'},
        {'id': '2', 'name': 'remote old', 'updatedAt': '2026-01-01T00:00:00Z'},
        {'id': '3', 'name': 'remote only', 'updatedAt': '2026-01-01T00:00:00Z'},
      ];

      final merged = resolver.resolveConflicts(
        localItems: local,
        remoteItems: remote,
        idKey: 'id',
        updatedAtKey: 'updatedAt',
      );

      expect(merged.length, 3);
      final item1 = merged.firstWhere((r) => r['id'] == '1');
      expect(item1['name'], 'remote new'); // Remote won
      final item2 = merged.firstWhere((r) => r['id'] == '2');
      expect(item2['name'], 'local new'); // Local won
      final item3 = merged.firstWhere((r) => r['id'] == '3');
      expect(item3['name'], 'remote only');
    });
  });
}
