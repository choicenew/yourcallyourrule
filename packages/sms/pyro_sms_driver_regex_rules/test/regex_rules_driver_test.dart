import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_regex_rules/pyro_sms_driver_regex_rules.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('RegexRulesDriver flags messages matching spam keywords', () async {
    final driver = RegexRulesDriver();

    final safeMsg = SmsMessageEntity(
      id: '1',
      sender: '1234',
      body: 'See you tomorrow at 5pm',
      timestamp: DateTime.now(),
    );
    expect(await driver.screenMessage(safeMsg), null);

    final spamMsg = SmsMessageEntity(
      id: '2',
      sender: '1234',
      body: 'Congratulations! You are the lottery winner!',
      timestamp: DateTime.now(),
    );
    final result = await driver.screenMessage(spamMsg);
    expect(result?.recommendedAction, SmsFilterAction.cancelNotification);
    expect(result?.riskLevel, SmsRiskLevel.high);
  });
}
