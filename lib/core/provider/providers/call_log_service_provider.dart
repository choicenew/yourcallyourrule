import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/call_log_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/contact_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';

/// CallLogService的Provider
final callLogServiceProvider = Provider<CallLogService>((ref) {
  final callLogRepository = ref.watch(callLogRepositoryProvider);
  final contactService = ref.watch(contactServiceProvider);
  final labelService = ref.watch(labelServiceProvider);
  final allowedBlockedService = ref.watch(allowedBlockedServiceProvider);
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);
  
  return CallLogService(
    callLogRepository,
    contactService: contactService,
    labelService: labelService,
    allowedBlockedService: allowedBlockedService,
    ruleManagementService: ruleManagementService,
  );
});