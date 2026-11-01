import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_notification_listener/pyro_sms_driver_notification_listener.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('SmsNotificationListenerDriver manages evidence and protected packages', () async {
    final driver = SmsNotificationListenerDriver();

    final packages = await driver.getProtectedPackages();
    expect(packages.contains('com.whatsapp'), true);

    final evidence = SmsEvidenceItem(
      evidenceId: 'ev_1',
      message: SmsMessageEntity(
        id: '1',
        sender: '123456',
        body: 'Evidence text',
        timestamp: DateTime.now(),
      ),
      takenAction: SmsFilterAction.cancelNotification,
      riskLevel: SmsRiskLevel.high,
      category: SmsCategory.scam,
      spamScore: 0.85,
      mechanismsTriggered: [SmsDetectionMechanism.phishTank],
      capturedAt: DateTime.now(),
    );

    await driver.saveEvidence(evidence);
    final logs = driver.getCapturedEvidenceLogs();
    expect(logs.length, 1);
    expect(logs.first.evidenceId, 'ev_1');
  });
}
