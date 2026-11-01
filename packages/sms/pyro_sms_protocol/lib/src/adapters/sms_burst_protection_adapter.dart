import '../models/sms_message_entity.dart';

/// Abstract adapter for SMS burst protection against high-frequency SMS spam
abstract class SmsBurstProtectionAdapter {
  String get providerId;

  /// Returns true if sender has triggered SMS burst limit (e.g. >3 messages in 60 seconds)
  Future<bool> isBursting(SmsMessageEntity message);

  /// Record incoming message event for burst rate window tracking
  Future<void> recordMessage(SmsMessageEntity message);
}
