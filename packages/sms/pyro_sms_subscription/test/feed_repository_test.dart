import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_subscription/pyro_sms_subscription.dart';

void main() {
  test('FeedRepository parses real feed.txt lines', () async {
    const mockRawFeed = '''
http://phishing-site-1.com/login
https://malicious-domain-2.icu/account
# Comment line
http://secure-update-3.xyz/verify
''';

    final domains = await FeedRepository.instance.syncOpenPhishFeed(customFeedContent: mockRawFeed);
    expect(domains.contains('phishing-site-1.com'), true);
    expect(domains.contains('malicious-domain-2.icu'), true);
    expect(domains.contains('secure-update-3.xyz'), true);
    expect(domains.length, 3);
  });
}
