import '../models/sms_message_entity.dart';
import '../models/sms_screening_result.dart';

/// Abstract contract for SMS filter drivers
abstract class SmsFilterAdapter {
  String get providerId;
  String get displayName;
  bool get isEnabled;

  Future<SmsScreeningResult?> screenMessage(SmsMessageEntity message);
}
