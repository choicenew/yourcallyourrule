import '../services/caller_id_monitor_service.dart';

import '../views/call_history/call_log_database.dart';






Future<void> saveCallerIdDataToCache(String phoneNumber, CallData callData) async {
  final database = CallScreeningDatabase.instance; // 获取 CallLogDatabase 实例
  await database.insertCallerIdData(callData.callerIdData); // 调用 CallLogDatabase 的 insertCallerIdData 方法
  await CallScreeningDatabase.instance.insertCallScreeningEntry(callData);
}