import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_openphish/pyro_sms_driver_openphish.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:pyro_sms_subscription/pyro_sms_subscription.dart';

void main() {
  test('OpenPhishDriver matches real synced threat domains', () async {
    const mockFeed = 'http://real-phishing-threat-domain.icu/login';
    await FeedRepository.instance.syncOpenPhishFeed(customFeedContent: mockFeed);

    final driver = OpenPhishDriver();

    final safeItem = await driver.checkUrl('http://github.com');
    expect(safeItem?.inOpenPhishFeed, false);

    final phishItem = await driver.checkUrl('http://real-phishing-threat-domain.icu/account');
    expect(phishItem?.inOpenPhishFeed, true);
    expect(phishItem?.riskLevel, SmsRiskLevel.critical);
  });
}
