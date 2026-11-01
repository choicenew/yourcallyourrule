import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_ml_classifier/pyro_sms_driver_ml_classifier.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('ComplementNaiveBayesScorer calculates spam score', () async {
    final scorer = ComplementNaiveBayesScorer();

    final hamMsg = SmsMessageEntity(
      id: '1',
      sender: '+1234567890',
      body: 'Hello thanks for meeting today',
      timestamp: DateTime.now(),
    );
    final hamScore = await scorer.calculateSpamScore(hamMsg);
    expect(hamScore, lessThan(0.5));

    final spamMsg = SmsMessageEntity(
      id: '2',
      sender: '8005550199',
      body: r'URGENT: Claim free casino bonus $1000 winner verify at http://spam.xyz',
      timestamp: DateTime.now(),
    );
    final spamScore = await scorer.calculateSpamScore(spamMsg);
    expect(spamScore, greaterThanOrEqualTo(0.7));
  });
}
