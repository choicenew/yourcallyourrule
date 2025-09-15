import 'dart:async';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.dart';

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