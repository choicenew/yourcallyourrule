
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/data/models/base_model.dart';

class CallLogModel extends BaseModel<CallLog> {
  final String number;
  final DateTime timestamp;
  final String simDisplayName;
  final String callType;
  final int simSlotIndex;
  final String carrierName;
  final String countryIso;
  final int subscriptionId;

  CallLogModel({
    required super.id,
    required this.number,
    required this.timestamp,
    required this.simDisplayName,
    required this.callType,
    required this.simSlotIndex,
    required this.carrierName,
    required this.countryIso,
    required this.subscriptionId,
  });

  factory CallLogModel.fromMap(Map<String, dynamic> map) {
    return CallLogModel(
      id: map['id']?.toString() ?? '',
      number: map['number'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
      simDisplayName: map['simDisplayName'] ?? '',
      callType: map['callType'] ?? '',
      simSlotIndex: map['simSlotIndex'] ?? 0,
      carrierName: map['carrierName'] ?? '',
      countryIso: map['countryIso'] ?? '',
      subscriptionId: map['subscriptionId'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'timestamp': timestamp.toIso8601String(),
      'simDisplayName': simDisplayName,
      'callType': callType,
      'simSlotIndex': simSlotIndex,
      'carrierName': carrierName,
      'countryIso': countryIso,
      'subscriptionId': subscriptionId,
    };
  }

  @override
  CallLog toEntity() {
    return CallLog(
      id: id,
      number: number,
      timestamp: timestamp,
      simDisplayName: simDisplayName,
      callType: callType,
      simSlotIndex: simSlotIndex,
      carrierName: carrierName,
      countryIso: countryIso,
      subscriptionId: subscriptionId,
    );
  }

  factory CallLogModel.fromEntity(CallLog entity) {
    return CallLogModel(
      id: entity.id,
      number: entity.number,
      timestamp: entity.timestamp,
      simDisplayName: entity.simDisplayName,
      callType: entity.callType,
      simSlotIndex: entity.simSlotIndex,
      carrierName: entity.carrierName,
      countryIso: entity.countryIso,
      subscriptionId: entity.subscriptionId,
    );
  }
}