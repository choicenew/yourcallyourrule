import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'plugin_service_provider.dart';
import 'contact_service_provider.dart';
import 'rule_management_service_provider.dart';
import 'label_service_provider.dart';
import 'location_service_provider.dart';
import 'predefined_label_service_provider.dart';
import 'remote_number_service_provider.dart';

/// CallerIdService的Provider
final callerIdServiceProvider = Provider<CallerIdService>((ref) {
  final pluginService = ref.watch(pluginServiceProvider);
  final contactService = ref.watch(contactServiceProvider);
  final ruleManagementService = ref.watch(ruleManagementServiceProvider);
  final labelService = ref.watch(labelServiceProvider);
  final locationService = ref.watch(locationServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  
  return CallerIdService(
    pluginService: pluginService,
    contactService: contactService,
    ruleManagementService: ruleManagementService,
    labelService: labelService,
    locationService: locationService,
    predefinedLabelService: predefinedLabelService,
    remoteNumberService: remoteNumberService,
  );
});