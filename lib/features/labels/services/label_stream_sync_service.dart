import 'dart:async';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart' hide PredefinedLabel;
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/remote_filter/data/repositories/remote_number_repository_impl.dart';

part 'label_stream_sync_service.g.dart';

@Riverpod(keepAlive: true)
LabelStreamSyncService labelStreamSyncService(Ref ref) {
  final remoteRepo = ref.watch(remoteNumberRepositoryProvider);
  return LabelStreamSyncService(remoteRepo);
}

/// 号码标记到远程号码库的异步同步中枢
class LabelStreamSyncService {
  final RemoteNumberRepositoryImpl _remoteRepo;
  StreamSubscription<LabelPhoneEntry>? _subscription;

  LabelStreamSyncService(this._remoteRepo);

  void startSync(Stream<LabelPhoneEntry> stream) {
    _subscription?.cancel();
    _subscription = stream.listen((entry) async {
      final remoteEntry = RemoteNumberEntry(
        id: entry.id,
        phoneNumber: entry.phoneNumber,
        name: entry.name,
        label: entry.labelId,
      );
      await _remoteRepo.save(remoteEntry);
      debugPrint('[LabelStreamSyncService] Synced label to remote DB: ${entry.phoneNumber}');
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
