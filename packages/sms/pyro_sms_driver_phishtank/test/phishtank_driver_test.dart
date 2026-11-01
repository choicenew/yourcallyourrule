import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_phishtank/pyro_sms_driver_phishtank.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('PhishTankDriver matches verified phishing URLs', () async {
    final driver = PhishTankDriver();

    final safeItem = await driver.checkUrl('http://google.com');
    expect(safeItem?.inPhishTankDatabase, false);

    final phishItem = await driver.checkUrl('http://phishing-login.top/account');
    expect(phishItem?.inPhishTankDatabase, true);
    expect(phishItem?.riskLevel, SmsRiskLevel.critical);
  });
}
