import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_burst_protection/pyro_sms_driver_burst_protection.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('SmsBurstProtectionDriver detects frequency bursting', () async {
    final driver = SmsBurstProtectionDriver(
      maxMessagesPerWindow: 3,
      windowDuration: const Duration(seconds: 60),
    );

    final msg = SmsMessageEntity(
      id: '1',
      sender: '+19998887777',
      body: 'Burst test',
      timestamp: DateTime.now(),
    );

    expect(await driver.isBursting(msg), false);

    await driver.recordMessage(msg);
    await driver.recordMessage(msg);
    await driver.recordMessage(msg);

    expect(await driver.isBursting(msg), true);
  });
}
