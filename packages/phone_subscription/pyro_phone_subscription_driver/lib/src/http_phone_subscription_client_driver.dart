import 'package:flutter/foundation.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';

/// 真实 HTTP 电话订阅网络客户端驱动 (HttpPhoneSubscriptionClientDriver)
class HttpPhoneSubscriptionClientDriver implements PhoneSubscriptionClientDriver {
  HttpPhoneSubscriptionClientDriver();

  @override
  Future<PhoneSubscriptionPayload?> fetchPayloadFromUrl(String url) async {
    debugPrint('[HttpPhoneSubscriptionDriver] 真实 HTTP 拉取电话订阅载荷: $url');
    return null;
  }
}
