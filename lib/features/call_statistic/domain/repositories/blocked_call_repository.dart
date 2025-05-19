import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class BlockedCall {
  final String phoneNumber;
  final DateTime timestamp;
  final BlockedType type;

  BlockedCall(this.phoneNumber, this.timestamp, {this.type = BlockedType.call});

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'timestamp': timestamp.toIso8601String(),
        'type': type.index,
      };

  factory BlockedCall.fromJson(Map<String, dynamic> json) => BlockedCall(
        json['phoneNumber'],
        DateTime.parse(json['timestamp']),
        type: json['type'] != null ? BlockedType.values[json['type']] : BlockedType.call,
      );
}

enum BlockedType {
  call,
  sms
}

class BlockedCallRepository {
  static const String _filePath = 'blocked_calls.json';

  // 保存屏蔽电话数据到本地文件
  Future<void> addBlockedCall(String phoneNumber) async {
    final blockedCalls = await getBlockedCalls();
    blockedCalls.add(BlockedCall(phoneNumber, DateTime.now(), type: BlockedType.call));
    await _saveBlockedCallsData(blockedCalls);
  }
  
  // 保存屏蔽短信数据到本地文件
  Future<void> addBlockedSms(String phoneNumber) async {
    final blockedCalls = await getBlockedCalls();
    blockedCalls.add(BlockedCall(phoneNumber, DateTime.now(), type: BlockedType.sms));
    await _saveBlockedCallsData(blockedCalls);
  }

  // 从本地文件加载所有屏蔽数据
  Future<List<BlockedCall>> getBlockedCalls() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_filePath');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final List<dynamic> decodedList = jsonDecode(jsonData);
      return decodedList.map((item) => BlockedCall.fromJson(item)).toList();
    }
    return [];
  }

  // 获取仅电话的屏蔽数据
  Future<List<BlockedCall>> getBlockedCallsOnly() async {
    final allCalls = await getBlockedCalls();
    return allCalls.where((call) => call.type == BlockedType.call).toList();
  }
  
  // 获取仅短信的屏蔽数据
  Future<List<BlockedCall>> getBlockedSmsOnly() async {
    final allCalls = await getBlockedCalls();
    return allCalls.where((call) => call.type == BlockedType.sms).toList();
  }
  
  // 保存屏蔽数据到本地文件
  Future<void> _saveBlockedCallsData(List<BlockedCall> blockedCalls) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_filePath');
    final jsonData =
        jsonEncode(blockedCalls.map((call) => call.toJson()).toList());
    await file.writeAsString(jsonData);
  }
}
