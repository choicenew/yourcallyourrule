import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.dart';

part 'label_stream_sync_service.g.dart';

/// LabelStreamSyncService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
LabelStreamSyncService labelStreamSyncService(Ref ref) {
  final syncService = ref.watch(labelPhoneEntryToRemoteProvider);
  return LabelStreamSyncService(syncService);
}

/// 标签同步服务初始化提供者
@Riverpod(keepAlive: true)
void labelSyncServiceInitializer(Ref ref) {
  final callerIdService = ref.watch(callerIdServiceProvider);
  final labelStreamSyncService = ref.watch(labelStreamSyncServiceProvider);
  labelStreamSyncService.startSync(callerIdService.labelPhoneEntryStream);
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