import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_keyword_bloom_filter/pyro_sms_driver_keyword_bloom_filter.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('BloomFilter and AhoCorasickAutomaton multi-pattern searching', () {
    final bf = BloomFilter();
    bf.add('casino');
    bf.add('lottery');

    expect(bf.mightContain('casino'), true);
    expect(bf.mightContain('lottery'), true);
    expect(bf.mightContain('unrelated'), false);

    final ac = AhoCorasickAutomaton();
    ac.addKeyword('casino');
    ac.addKeyword('winner');
    ac.build();

    final matches = ac.search('Congratulations! You are the casino winner today!');
    expect(matches.contains('casino'), true);
    expect(matches.contains('winner'), true);
  });

  test('KeywordBloomFilterDriver screens messages', () async {
    final driver = KeywordBloomFilterDriver(keywords: ['casino', 'lottery']);

    final safeMsg = SmsMessageEntity(
      id: '1',
      sender: '1234',
      body: 'Meeting tomorrow at 10am',
      timestamp: DateTime.now(),
    );
    expect(await driver.screenMessage(safeMsg), null);

    final spamMsg = SmsMessageEntity(
      id: '2',
      sender: '1234',
      body: 'Claim your casino prize now!',
      timestamp: DateTime.now(),
    );
    final result = await driver.screenMessage(spamMsg);
    expect(result?.recommendedAction, SmsFilterAction.cancelNotification);
  });
}
