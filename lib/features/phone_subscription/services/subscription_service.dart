import 'subscription_service_base.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';

abstract class SubscriptionService extends SubscriptionServiceBase<PhoneSubscriptionPayload, String> {
  Future<List<PhoneSubscriptionPayload>> getSubscriptionsByType(bool isWhitelist);
  Future<void> toggleSubscription(String id, bool isEnabled);
  Future<void> forceUpdateSubscription(String id);
  Future<DateTime> getLastUpdateTime(String id);
}
