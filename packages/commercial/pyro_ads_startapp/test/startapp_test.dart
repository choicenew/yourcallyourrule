import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_startapp/pyro_ads_startapp.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('StartIoAdapter instantiates correctly', () {
    final adapter = StartIoAdapter();
    expect(adapter.providerId, equals('startio'));
    expect(adapter.providerName, contains('Start.io'));
    expect(adapter.getTestBannerId(), isNotNull);
  });
}
