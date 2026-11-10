import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/remote_filter/data/repositories/remote_number_repository_impl.dart';

final pluginToRemoteSyncServiceProvider = Provider<PluginToRemoteSyncService>((ref) {
  final remoteRepo = ref.watch(remoteNumberRepositoryProvider);
  return PluginToRemoteSyncService(remoteRepo);
});

final pluginSyncServiceInitializerProvider = Provider<void>((ref) {
  final syncService = ref.watch(pluginToRemoteSyncServiceProvider);
});

class PluginToRemoteSyncService {
  final RemoteNumberRepositoryImpl _remoteRepo;
  StreamSubscription<dynamic>? _dataSubscription;

  PluginToRemoteSyncService(this._remoteRepo);

  void startSync(
    Stream<PluginSourceData> pluginDataStream, [
    Stream<LabelPhoneEntry>? labelPhoneEntryStream,
  ]) {
    _dataSubscription?.cancel();
    _dataSubscription = pluginDataStream.listen((data) => _handleData(data, null));
  }

  Future<void> _handleData(
    PluginSourceData? pluginSourceData,
    LabelPhoneEntry? labelPhoneEntry,
  ) async {
    final phone = pluginSourceData?.phoneNumber ?? labelPhoneEntry?.phoneNumber ?? '';
    if (phone.isEmpty) return;

    final newEntry = RemoteNumberEntry(
      id: const Uuid().v4(),
      phoneNumber: phone,
      name: pluginSourceData?.name ?? labelPhoneEntry?.name ?? '',
      label: pluginSourceData?.predefinedLabel ?? '',
      count: pluginSourceData?.count ?? 0,
      actionType: 'block',
      isEnabled: true,
    );

    await _remoteRepo.save(newEntry);
  }

  void dispose() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }
}
