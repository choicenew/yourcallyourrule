import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/providers/caller_id_service_provider.dart';
import 'package:yourcallyourrule/features/caller_id/providers/plugin_to_remote_sync_service_provider.dart';

/// A provider that initializes and connects the CallerIdService and PluginToRemoteSyncService.
final pluginSyncServiceInitializerProvider = Provider<void>((ref) {
  // Watch the providers to ensure they are initialized.
  final callerIdService = ref.watch(callerIdServiceProvider);
  final pluginToRemoteSyncService = ref.watch(pluginToRemoteSyncServiceProvider);

  // Start the sync service by passing the streams from CallerIdService.
  pluginToRemoteSyncService.startSync(
    callerIdService.pluginDataStream,
    callerIdService.labelPhoneEntryStream,
  );

  // The subscription is managed inside PluginToRemoteSyncService, and its lifecycle
  // is tied to the pluginToRemoteSyncServiceProvider.
});