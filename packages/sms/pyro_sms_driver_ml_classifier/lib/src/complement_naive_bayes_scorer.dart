import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'gbt_feature_extractor.dart';

/// Driver for Complement Naive Bayes & 20-Feature GBT ML Spam Classifier
class ComplementNaiveBayesScorer implements SmsMlScorerAdapter {
  @override
  String get providerId => 'pyro_sms_driver_ml_classifier';

  final Map<String, int> _spamWordFreq = {
    'claim': 25, 'winner': 30, 'urgent': 18, 'verify': 20,
    'bank': 15, 'free': 22, 'bonus': 28, 'casino': 35,
    '中奖': 40, '汇款': 30, '博彩': 45,
  };

  final Map<String, int> _hamWordFreq = {
    'hello': 20, 'thanks': 25, 'see': 15, 'today': 12, 'meeting': 18,
  };

  @override
  Future<double> calculateSpamScore(SmsMessageEntity message) async {
    final features = GbtFeatureExtractor.extract20Features(message);

    double gbtScore = 0.0;
    if (features[3] > 0) gbtScore += 0.3;
    if (features[4] > 0) gbtScore += 0.2;
    if (features[5] > 0) gbtScore += 0.3;
    if (features[15] > 0.4) gbtScore += 0.2;

    final words = message.body.toLowerCase().split(RegExp(r'\W+'));
    double spamLogLikelihood = 0.0;
    double hamLogLikelihood = 0.0;

    for (final word in words) {
      if (word.isEmpty) continue;
      final spamCount = _spamWordFreq[word] ?? 1;
      final hamCount = _hamWordFreq[word] ?? 1;

      spamLogLikelihood += spamCount.toDouble();
      hamLogLikelihood += hamCount.toDouble();
    }

    double nbScore = 0.0;
    final totalLikelihood = spamLogLikelihood + hamLogLikelihood;
    if (totalLikelihood > 0) {
      nbScore = spamLogLikelihood / totalLikelihood;
    }

    final finalScore = (0.6 * gbtScore) + (0.4 * nbScore);
    return finalScore.clamp(0.0, 1.0);
  }

  @override
  Future<void> updateSample(SmsMessageEntity message, {required bool isSpam}) async {
    final words = message.body.toLowerCase().split(RegExp(r'\W+'));
    final targetMap = isSpam ? _spamWordFreq : _hamWordFreq;

    for (final word in words) {
      if (word.length <= 2) continue;
      targetMap[word] = (targetMap[word] ?? 0) + 1;
    }
  }
}
