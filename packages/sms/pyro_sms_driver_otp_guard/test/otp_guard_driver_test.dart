import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_otp_guard/pyro_sms_driver_otp_guard.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('OtpGuardDriver extracts and masks OTP code', () {
    final driver = OtpGuardDriver();

    const body = 'Your verification code is 849201. Do not share it.';
    final code = driver.extractOtpCode(body);
    expect(code, '849201');

    final masked = driver.maskOtpCode(code!);
    expect(masked, '84****');

    final sanitizedBody = driver.sanitizeSmsBody(body);
    expect(sanitizedBody.contains('84****'), true);
    expect(sanitizedBody.contains('849201'), false);
  });

  test('OtpGuardDriver records and auto-expires OTPs', () async {
    final driver = OtpGuardDriver(autoExpireDuration: const Duration(milliseconds: 100));

    final msg = SmsMessageEntity(
      id: '101',
      sender: 'Bank2FA',
      body: 'Code 123456',
      timestamp: DateTime.now(),
    );

    await driver.screenMessage(msg);
    expect(driver.getActiveRecords().length, 1);

    await Future.delayed(const Duration(milliseconds: 150));
    expect(driver.getActiveRecords().length, 0);
  });
}
