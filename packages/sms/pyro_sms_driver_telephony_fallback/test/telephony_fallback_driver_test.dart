import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_telephony_fallback/pyro_sms_driver_telephony_fallback.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('TelephonyFallbackDriver initializes platform channel handler', () async {
    final driver = TelephonyFallbackDriver();
    expect(driver.providerId, 'pyro_sms_driver_telephony_fallback');
    expect(await driver.isSmsPermissionGranted(), false);
  });
}
