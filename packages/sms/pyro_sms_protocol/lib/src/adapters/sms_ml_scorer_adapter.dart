import '../models/sms_message_entity.dart';

/// Abstract adapter for end-side ML spam score calculation (Complement Naive Bayes / 20-Feature GBT)
abstract class SmsMlScorerAdapter {
  String get providerId;

  /// Calculate spam score between 0.0 (safe) and 1.0 (definitely spam)
  Future<double> calculateSpamScore(SmsMessageEntity message);

  /// Train/update Naive Bayes sample locally
  Future<void> updateSample(SmsMessageEntity message, {required bool isSpam});
}
