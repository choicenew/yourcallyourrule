import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_liftoff/pyro_ads_liftoff.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('LiftoffAdapter instantiates correctly', () {
    final adapter = LiftoffAdapter();
    expect(adapter.providerId, equals('liftoff'));
    expect(adapter.providerName, contains('Liftoff'));
    expect(adapter.getTestBannerId(), isNotNull);
  });
}
