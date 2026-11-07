import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_admob/pyro_ads_admob.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('PyroAdsAdmobAdapter instantiates correctly as NetworkAdapter', () {
    final adapter = PyroAdsAdmobAdapter();
    expect(adapter.providerId, equals('admob'));
    expect(adapter.providerName, contains('AdMob'));
    expect(adapter.getTestBannerId(), isNotNull);
  });
}
