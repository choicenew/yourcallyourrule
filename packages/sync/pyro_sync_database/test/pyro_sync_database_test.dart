import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sync_database/pyro_sync_database.dart';

void main() {
  group('DatabaseSyncManager tests', () {
    test('Can instantiate DatabaseSyncManager', () {
      final manager = DatabaseSyncManager();
      expect(manager.engine, isNull);
    });
  });
}
