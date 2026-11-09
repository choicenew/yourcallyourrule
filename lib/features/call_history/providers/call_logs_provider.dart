import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/call_history/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/features/call_history/data/repositories/call_log_repository_impl.dart';

/// 通话记录数据状态的 Notifier
class CallLogsNotifier extends AsyncNotifier<List<CallLogEntry>> {
  late final CallLogRepository _callLogRepository;

  @override
  Future<List<CallLogEntry>> build() async {
    _initRepository();
    return _loadCallLogs();
  }

  void _initRepository() {
    _callLogRepository = ref.read(callLogRepositoryProvider);
  }

  Future<List<CallLogEntry>> _loadCallLogs() async {
    try {
      return await _callLogRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  /// 添加通话记录
  Future<void> addCallLog(CallLogEntry callLog) async {
    state = const AsyncValue.loading();
    try {
      await _callLogRepository.save(callLog);
      state = AsyncValue.data(await _loadCallLogs());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 更新通话记录
  Future<void> updateCallLog(CallLogEntry callLog) async {
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
final callLogsProvider = AsyncNotifierProvider<CallLogsNotifier, List<CallLogEntry>>(() {
  return CallLogsNotifier();
});
