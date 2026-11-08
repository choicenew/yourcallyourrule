import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.dart';

part 'label_stream_sync_service.g.dart';

@Riverpod(keepAlive: true)
LabelStreamSyncService labelStreamSyncService(Ref ref) {
  final syncService = ref.watch(labelPhoneEntryToRemoteProvider);
  return LabelStreamSyncService(syncService);
}

@Riverpod(keepAlive: true)
void labelSyncServiceInitializer(Ref ref) {
  final callerIdentityService = ref.watch(callerIdentityServiceProvider);
  final labelStreamSyncService = ref.watch(labelStreamSyncServiceProvider);
  labelStreamSyncService.startSync(callerIdentityService.labelPhoneEntryStream);
}

class LabelStreamSyncService {
  final LabelPhoneEntryToRemote _syncService;
  StreamSubscription<LabelPhoneEntry>? _subscription;
  LabelPhoneEntry? _lastProcessedEntry;

  LabelStreamSyncService(this._syncService);

  void startSync(Stream<LabelPhoneEntry> stream) {
    _subscription?.cancel();
    _subscription = stream.listen((entry) {
      if (entry.phoneNumber != _lastProcessedEntry?.phoneNumber) {
        _syncService.sync(entry);
        _lastProcessedEntry = entry;
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
