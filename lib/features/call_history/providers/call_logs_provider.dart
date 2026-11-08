import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/call_history/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/features/call_history/data/repositories/call_log_repository_impl.dart';

/// 通话记录数据状态的 Notifier
class CallLogsNotifier extends AsyncNotifier<List<CallLog>> {
  late final CallLogRepository _callLogRepository;

  @override
  Future<List<CallLog>> build() async {
    _initRepository();
    return _loadCallLogs();
  }

  void _initRepository() {
    _callLogRepository = ref.read(callLogRepositoryProvider);
  }

  Future<List<CallLog>> _loadCallLogs() async {
    try {
      return await _callLogRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  /// 添加通话记录
  Future<void> addCallLog(CallLog callLog) async {
    state = const AsyncValue.loading();
    try {
      await _callLogRepository.save(callLog);
      state = AsyncValue.data(await _loadCallLogs());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 更新通话记录
  Future<void> updateCallLog(CallLog callLog) async {
    state = const AsyncValue.loading();
    try {
      await _callLogRepository.update(callLog);
      state = AsyncValue.data(await _loadCallLogs());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 删除通话记录
  Future<void> deleteCallLog(String callLogId) async {
    state = const AsyncValue.loading();
    try {
      await _callLogRepository.deleteById(callLogId);
      state = AsyncValue.data(await _loadCallLogs());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

/// 通话记录数据提供者
final callLogsProvider = AsyncNotifierProvider<CallLogsNotifier, List<CallLog>>(() {
  return CallLogsNotifier();
});