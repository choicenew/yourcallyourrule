import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';

import '../basic_provider/rule_repository_provider.dart';
import '../basic_provider/sms_subscription_repository_provider.dart';

/// SmsSubscriptionService的Provider
final smsSubscriptionServiceProvider = Provider<SmsSubscriptionService>((ref) {
  final smsSubscriptionRepository = ref.watch(smsSubscriptionRepositoryProvider);
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  
  return SmsSubscriptionService(
    smsSubscriptionRepository,
    ruleRepository,
  );
});