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
    return CallLogModel(
      id: map['id']?.toString() ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'], // 添加name字段
      timestamp: DateTime.parse(map['timestamp']),
      simDisplayName: map['simDisplayName'] ?? '',
      callType: map['callType'] ?? '',
      simSlotIndex: map['simSlotIndex'] ?? 0,
      carrierName: map['carrierName'] ?? '',
      countryIso: map['countryIso'] ?? '',
      subscriptionId: map['subscriptionId'] ?? 0,
      labelIds:
          map['labelIds'] != null ? List<String>.from(map['labelIds']) : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name, // 添加name字段
      'timestamp': timestamp.toIso8601String(),
      'simDisplayName': simDisplayName,
      'callType': callType,
      'simSlotIndex': simSlotIndex,
      'carrierName': carrierName,
      'countryIso': countryIso,
      'subscriptionId': subscriptionId,
      'labelIds': labelIds,
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
