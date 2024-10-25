// caller_id_cache.dart

// 保存单个 CallerIdData 到缓存文件
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../services/caller_id_service.dart';

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