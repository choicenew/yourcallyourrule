// caller_id_cache.dart

// 保存单个 CallerIdData 到缓存文件


import '../services/caller_id_service.dart';
import '../views/call_history/call_log_database.dart';



/*
Future<void> saveCallerIdDataToCache(String phoneNumber, CallerIdData callerIdData) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/caller_id_cache.json';
  final file = File(filePath);

  // 读取已有缓存数据
  Map<String, dynamic> cachedCallerIdData = {};
  if (await file.exists()) {
    final jsonData = await file.readAsString();
    cachedCallerIdData = json.decode(jsonData);
  }

  // 更新缓存数据，如果存在相同号码则覆盖
  cachedCallerIdData[phoneNumber] = callerIdData.toJson();

  // 将更新后的数据写入文件
  final updatedJsonData = json.encode(cachedCallerIdData);
  await file.writeAsString(updatedJsonData);
}
*/


Future<void> saveCallerIdDataToCache(String phoneNumber, CallerIdData callerIdData) async {
  final database = CallLogDatabase.instance; // 获取 CallLogDatabase 实例
  await database.insertCallerIdData(callerIdData); // 调用 CallLogDatabase 的 insertCallerIdData 方法
}