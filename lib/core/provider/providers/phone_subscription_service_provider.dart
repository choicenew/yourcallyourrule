import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/subscription_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';

/// PhoneSubscriptionService的Provider
final phoneSubscriptionServiceProvider = Provider<PhoneSubscriptionService>((ref) {
  final subscriptionRepository = ref.watch(subscriptionRepositoryProvider);
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return PhoneSubscriptionService(subscriptionRepository, ruleRepository);
});