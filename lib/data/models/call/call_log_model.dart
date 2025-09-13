import 'dart:convert';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/data/models/base_model.dart';

class CallLogModel extends BaseModel<CallLog> {
  final String phoneNumber;
  final String? name; // 添加name字段
  final DateTime timestamp;
  final String simDisplayName;
  final String callType;
  final int simSlotIndex;
  final String carrierName;
  final String countryIso;
  final int subscriptionId;
  final List<String>? labelIds;

  CallLogModel({
    required super.id,
    required this.phoneNumber,
    this.name, // 添加name参数
    required this.timestamp,
    required this.simDisplayName,
    required this.callType,
    required this.simSlotIndex,
    required this.carrierName,
    required this.countryIso,
    required this.subscriptionId,
    this.labelIds,
  });

  factory CallLogModel.fromMap(Map<String, dynamic> map) {
    dynamic labelIdsData = map['labelIds'];
    List<String>? labelIds;
    if (labelIdsData is String) {
      try {
        final decoded = jsonDecode(labelIdsData);
        if (decoded is List) {
          labelIds = decoded.map((e) => e.toString()).toList();
        }
      } catch (e) {
        // Ignore if parsing fails
      }
    } else if (labelIdsData is List) {
      labelIds = List<String>.from(labelIdsData);
    }

    DateTime parsedTimestamp;
    final dynamic timestampValue = map['timestamp'];

    if (timestampValue is int) {
      parsedTimestamp = DateTime.fromMillisecondsSinceEpoch(timestampValue);
    } else if (timestampValue is String) {
      final int? asInt = int.tryParse(timestampValue);
      if (asInt != null) {
        parsedTimestamp = DateTime.fromMillisecondsSinceEpoch(asInt);
      } else {
        try {
          parsedTimestamp = DateTime.parse(timestampValue);
        } catch (e) {
          parsedTimestamp = DateTime.now();
        }
      }
    } else {
      parsedTimestamp = DateTime.now();
    }

    return CallLogModel(
      id: map['id']?.toString() ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'],
      timestamp: parsedTimestamp,
      simDisplayName: map['simDisplayName'] ?? '',
      callType: map['callType'] ?? '',
      simSlotIndex: int.tryParse(map['simSlotIndex']?.toString() ?? '0') ?? 0,
      carrierName: map['carrierName'] ?? '',
      countryIso: map['countryIso'] ?? '',
      subscriptionId: int.tryParse(map['subscriptionId']?.toString() ?? '0') ?? 0,
      labelIds: labelIds,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'simDisplayName': simDisplayName,
      'callType': callType,
      'simSlotIndex': simSlotIndex,
      'carrierName': carrierName,
      'countryIso': countryIso,
      'subscriptionId': subscriptionId,
      'labelIds': labelIds != null ? jsonEncode(labelIds) : null,
    };
  }

  @override
  CallLog toEntity() {
    return CallLog(
      id: id,
      phoneNumber: phoneNumber,
      name: name, // 添加name字段
      timestamp: timestamp,
      simDisplayName: simDisplayName,
      callType: callType,
      simSlotIndex: simSlotIndex,
      carrierName: carrierName,
      countryIso: countryIso,
      subscriptionId: subscriptionId,
      labelIds: labelIds,
    );
  }

  factory CallLogModel.fromEntity(CallLog entity) {
    return CallLogModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber,
      name: entity.name, // 添加name字段
      timestamp: entity.timestamp,
      simDisplayName: entity.simDisplayName,
      callType: entity.callType,
      simSlotIndex: entity.simSlotIndex,
      carrierName: entity.carrierName,
      countryIso: entity.countryIso,
      subscriptionId: entity.subscriptionId,
      labelIds: entity.labelIds,
    );
  }
}
