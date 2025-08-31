import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/contact_subscription_repository_provider.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';

import '../basic_provider/rule_repository_provider.dart';
import '../basic_provider/contact_repository_provider.dart';

/// ContactSubscriptionService的Provider
final contactSubscriptionServiceProvider = Provider<ContactSubscriptionService>((ref) {
  final contactSubscriptionRepository = ref.watch(contactSubscriptionRepositoryProvider);
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final contactRepository = ref.watch(contactRepositoryProvider);
  
  return ContactSubscriptionService(
    contactSubscriptionRepository,
    ruleRepository,
    contactRepository,
  );
});