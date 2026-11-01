import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_google_safe_browsing/pyro_sms_driver_google_safe_browsing.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('GoogleSafeBrowsingDriver detects threat URLs', () async {
    final driver = GoogleSafeBrowsingDriver();

    final safeItem = await driver.checkUrl('http://example.com');
    expect(safeItem?.riskLevel, SmsRiskLevel.safe);

    final threatItem = await driver.checkUrl('http://google-phishing-verify.icu');
    expect(threatItem?.riskLevel, SmsRiskLevel.critical);
  });
}
