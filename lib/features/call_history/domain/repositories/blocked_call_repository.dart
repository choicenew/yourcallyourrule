import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class BlockedCall {
  final String phoneNumber;
  final DateTime timestamp;

  BlockedCall(this.phoneNumber, this.timestamp);

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BlockedCall.fromJson(Map<String, dynamic> json) => BlockedCall(
        json['phoneNumber'],
        DateTime.parse(json['timestamp']),
      );
}

class BlockedCallRepository {
  static const String _filePath = 'blocked_calls.json';

  // 保存屏蔽号码数据到本地文件
  Future<void> addBlockedCall(String phoneNumber) async {
    final blockedCalls = await getBlockedCalls();
    blockedCalls.add(BlockedCall(phoneNumber, DateTime.now()));
    await _saveBlockedCallsData(blockedCalls);
  }

  // 从本地文件加载屏蔽号码数据
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

  // 保存屏蔽号码数据到本地文件
  Future<void> _saveBlockedCallsData(List<BlockedCall> blockedCalls) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_filePath');
    final jsonData =
        jsonEncode(blockedCalls.map((call) => call.toJson()).toList());
    await file.writeAsString(jsonData);
  }
}
