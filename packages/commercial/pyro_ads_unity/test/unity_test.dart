import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_unity/pyro_ads_unity.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('UnityAdapter instantiates correctly', () {
    final adapter = UnityAdapter();
    expect(adapter.providerId, equals('unity'));
    expect(adapter.providerName, contains('Unity'));
    expect(adapter.getTestBannerId(), isNotNull);
  });
}
