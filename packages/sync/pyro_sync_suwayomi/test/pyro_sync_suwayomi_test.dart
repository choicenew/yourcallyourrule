import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sync_suwayomi/pyro_sync_suwayomi.dart';

void main() {
  group('SuwayomiServiceImpl Unit Tests', () {
    test('initial state should not be connected', () async {
      final service = SuwayomiServiceImpl();
      expect(await service.isConnected(), isFalse);
    });

    test('getLibrary should throw StateError if not connected', () async {
      final service = SuwayomiServiceImpl();
      expect(() => service.getLibrary(), throwsA(isA<StateError>()));
    });
  });
}
