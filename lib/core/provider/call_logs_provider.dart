import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import 'providers.dart';

/// 通话记录数据状态的Notifier类
class CallLogsNotifier extends AsyncNotifier<List<CallLog>> {
  late final CallLogRepository _callLogRepository;

  @override
  Future<List<CallLog>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有通话记录
    return _loadCallLogs();
  }

  void _initRepository() {
    // 获取仓库实例
    _callLogRepository = ref.read(callLogRepositoryProvider);
  }

  Future<List<CallLog>> _loadCallLogs() async {
    try {
      // 获取所有通话记录
      return await _callLogRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加通话记录
  Future<void> addCallLog(CallLog callLog) async {
    state = const AsyncValue.loading();
    try {
      await _callLogRepository.save(callLog);
      state = AsyncValue.data(await _loadCallLogs());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新通话记录
  Future<void> updateCallLog(CallLog callLog) async {
    state = const AsyncValue.loading();
    try {
      await _callLogRepository.update(callLog);
      state = AsyncValue.data(await _loadCallLogs());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除通话记录
  Future<void> deleteCallLog(String callLogId) async {
    state = const AsyncValue.loading();
    try {
      // 使用deleteById方法，它接受String类型的ID
      await _callLogRepository.deleteById(callLogId);
      state = AsyncValue.data(await _loadCallLogs());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

/// 通话记录数据提供者
final callLogsProvider = AsyncNotifierProvider<CallLogsNotifier, List<CallLog>>(() {
  return CallLogsNotifier();
});