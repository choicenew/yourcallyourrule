import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/labels/providers/label_phone_entry_to_remote_provider.dart';
import 'package:yourcallyourrule/features/labels/services/label_stream_sync_service.dart';

final labelStreamSyncServiceProvider = Provider((ref) {
  final syncService = ref.watch(labelPhoneEntryToRemoteProvider);
  return LabelStreamSyncService(syncService);
});