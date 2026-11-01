import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_bot_automation/pyro_sms_driver_bot_automation.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('BotAutomationDriver executes automation rules', () async {
    final driver = BotAutomationDriver();
    driver.addRule(const AutomationRule(
      id: 'rule_1',
      name: 'High Risk Alert',
      minRiskLevel: SmsRiskLevel.high,
      webhookUrl: 'http://localhost/webhook',
    ));

    final msg = SmsMessageEntity(
      id: '1',
      sender: '123456',
      body: 'Phishing link http://malicious.xyz',
      timestamp: DateTime.now(),
    );

    const result = SmsScreeningResult(
      recommendedAction: SmsFilterAction.cancelNotification,
      riskLevel: SmsRiskLevel.high,
      category: SmsCategory.phishing,
      spamScore: 0.95,
      mechanismsTriggered: [SmsDetectionMechanism.openPhish],
      reasoning: 'Phishing domain detected',
    );

    await driver.executeAutomation(msg, result);
    // Verified execution completed without error
  });
}
