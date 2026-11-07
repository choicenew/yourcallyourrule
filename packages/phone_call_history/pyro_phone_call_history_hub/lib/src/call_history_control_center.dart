import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';

part 'call_history_control_center.g.dart';

@Riverpod(keepAlive: true)
CallHistoryControlCenter callHistoryControlCenter(Ref ref) {
  return CallHistoryControlCenter.instance;
}

/// 通话历史控制中心 (CallHistoryControlCenter)
class CallHistoryControlCenter {
  static final CallHistoryControlCenter instance = CallHistoryControlCenter._();

  CallHistoryControlCenter._();

  CallLogStorageDriver? _storageDriver;

  void registerStorageDriver(CallLogStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneCallHistoryHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  CallLogStorageDriver? get storageDriver => _storageDriver;

  Future<void> saveCallLog(CallLogEntry entry) async {
    await _storageDriver?.saveCallLog(entry);
    debugPrint('[PhoneCallHistoryHub] 保存通话日志: ${entry.phoneNumber} (${entry.callType})');
  }

  Future<List<CallLogEntry>> getAllLogs() async {
    return await _storageDriver?.getAllLogs() ?? [];
  }
}
