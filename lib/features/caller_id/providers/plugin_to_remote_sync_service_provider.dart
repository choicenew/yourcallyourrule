import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/services/plugin_to_remote_sync_service.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_service_provider.dart';


final pluginToRemoteSyncServiceProvider = Provider<PluginToRemoteSyncService>((ref) {
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  return PluginToRemoteSyncService(remoteNumberService);
});