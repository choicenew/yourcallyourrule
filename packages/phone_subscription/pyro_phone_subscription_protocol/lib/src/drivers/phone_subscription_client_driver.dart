import 'package:pyro_phone_subscription_protocol/src/models/phone_subscription_payload.dart';

/// 云端电话订阅 HTTP 拉取 Driver 抽象接口契约 (PhoneSubscriptionClientDriver)
abstract class PhoneSubscriptionClientDriver {
  Future<PhoneSubscriptionPayload?> fetchPayloadFromUrl(String url);
}
