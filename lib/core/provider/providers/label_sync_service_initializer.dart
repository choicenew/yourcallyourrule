// 这个 Provider 不返回任何有用的值 (void)，它的唯一作用就是在被读取时，
// 将 CallerIdService 的流 和 LabelStreamSyncService 连接起来。
// 这完全模仿了您的 plugin_sync_service_initializer.dart 的模式。
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/providers/caller_id_service_provider.dart';
import 'package:yourcallyourrule/features/labels/providers/label_stream_sync_service_provider.dart';

final labelSyncServiceInitializerProvider = Provider<void>((ref) {
  // 1. 监听（watch）数据源服务，确保它被创建
  final callerIdService = ref.watch(callerIdServiceProvider);
  
  // 2. 监听（watch）我们的新监听服务，确保它也被创建
  final labelStreamSyncService = ref.watch(labelStreamSyncServiceProvider);

  // 3. 执行连接操作：将数据源的流传递给监听服务
  labelStreamSyncService.startSync(callerIdService.labelPhoneEntryStream);

  // Riverpod 会自动管理这个监听的生命周期。
  // 当这个 Provider 被销毁时，labelStreamSyncServiceProvider 也会被销毁，
  // 它的 dispose 方法会被调用，从而取消流的订阅。
});