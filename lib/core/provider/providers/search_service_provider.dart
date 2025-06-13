import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/core/provider/providers/contact_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/remote_number_service_provider.dart';

/// SearchService的Provider
/// 由于SearchService需要BuildContext，使用Provider.family
final searchServiceProvider = Provider.family<SearchService, BuildContext>((ref, context) {
  final contactService = ref.watch(contactServiceProvider);
  final labelService = ref.watch(labelServiceProvider);
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);
  final allowedBlockedService = ref.watch(allowedBlockedServiceProvider);
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  
  return SearchService(
    contactService: contactService,
    labelService: labelService,
    ruleManagementService: ruleManagementService,
    allowedBlockedService: allowedBlockedService,
    remoteNumberService: remoteNumberService,
    context: context,
  );
});