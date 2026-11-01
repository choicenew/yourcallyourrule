import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_link_resolver/pyro_sms_driver_link_resolver.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('LinkResolverDriver detects shorteners and high risk TLDs', () async {
    final driver = LinkResolverDriver();

    final shortener = await driver.checkUrl('http://bit.ly/3xXyZ');
    expect(shortener?.isShortener, true);
    expect(shortener?.riskLevel, SmsRiskLevel.medium);

    final highRiskTld = await driver.checkUrl('http://bank-account.icu');
    expect(highRiskTld?.isHighRiskTld, true);
    expect(highRiskTld?.riskLevel, SmsRiskLevel.high);

    expect(driver.isRegexSafe('(a+)+'), false);
    expect(driver.isRegexSafe(r'^[0-9]+$'), true);
  });
}
