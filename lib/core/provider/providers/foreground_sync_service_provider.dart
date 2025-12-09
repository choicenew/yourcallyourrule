import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_sync_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/phone_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_manager_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/sync_scheduler_provider.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_provider.dart';
import 'package:yourcallyourrule/core/services/foreground_sync_service.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_subscription_service_provider.dart';
import 'package:yourcallyourrule/features/sms/providers/sms_subscription_service_provider.dart';

/// Provider for the ForegroundSyncService instance.
///
/// This provider constructs the [ForegroundSyncService] with its required
/// dependencies, which are obtained from other providers.
final foregroundSyncServiceProvider = Provider<ForegroundSyncService>((ref) {
  final syncManager = ref.watch(incrementalSyncManagerProvider);
  final syncScheduler = ref.watch(syncSchedulerProvider);
  final callLogSyncService = ref.watch(callLogSyncServiceProvider);

  final phoneService = ref.watch(phoneSubscriptionServiceProvider);
  final smsService = ref.watch(smsSubscriptionServiceProvider);
  final contactService = ref.watch(contactSubscriptionServiceProvider);
  final pluginService = ref.watch(pluginManagerServiceProvider);
  final configRepo = ref.watch(configRepositoryProvider);

  final autoUpdateService = AutoUpdateService(
    phoneService: phoneService,
    smsService: smsService,
    contactService: contactService,
    pluginService: pluginService,
    configRepository: configRepo,
  );

  return ForegroundSyncService(
    syncManager: syncManager,
    syncScheduler: syncScheduler,
    callLogSyncService: callLogSyncService,
    autoUpdateService: autoUpdateService,
  );
});

/// Initializer provider for the foreground sync service.
///
/// This [FutureProvider] is designed to be read once at application startup.
/// It triggers the `syncIfNeeded` method of the [ForegroundSyncService]
/// to ensure a sync check is performed when the app is launched.
final foregroundSyncServiceInitializerProvider = FutureProvider<void>((ref) async {
  // Watch the service provider to get the service instance.
  final foregroundSyncService = ref.watch(foregroundSyncServiceProvider);

  // Call the method to perform the sync check.
  await foregroundSyncService.syncIfNeeded();
});
