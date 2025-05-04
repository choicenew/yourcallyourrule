import 'package:yourcallyourrule/core/base/base_entity.dart';

class CallLog extends BaseEntity {

  final String number;
  final DateTime timestamp;
  final String simDisplayName;
  final String callType;
  final int simSlotIndex;
  final String carrierName;
  final String countryIso;
  final int subscriptionId;

  CallLog({
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

  @override
Map<String, dynamic> toMap() => {
        'id': id,
        'number': number,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'simDisplayName': simDisplayName,
        'callType': callType,
        'simSlotIndex': simSlotIndex,
        'carrierName': carrierName,
        'countryIso': countryIso,
        'subscriptionId': subscriptionId,
      };

  factory CallLog.fromMap(Map<String, dynamic> map) {
    return CallLog(
      id: map['id'] as String,
      number: map['number'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      simDisplayName: map['simDisplayName'] as String,
      callType: map['callType'] as String,
      simSlotIndex: map['simSlotIndex'] as int,
      carrierName: map['carrierName'] as String,
      countryIso: map['countryIso'] as String,
      subscriptionId: map['subscriptionId'] as int,
    );
  }

  CallLog copyWith({
    String? id,
    String? number,
    DateTime? timestamp,
    String? simDisplayName,
    String? callType,
    int? simSlotIndex,
    String? carrierName,
    String? countryIso,
    int? subscriptionId,
  }) {
    return CallLog(
      id: id ?? this.id,
      number: number ?? this.number,
      timestamp: timestamp ?? this.timestamp,
      simDisplayName: simDisplayName ?? this.simDisplayName,
      callType: callType ?? this.callType,
      simSlotIndex: simSlotIndex ?? this.simSlotIndex,
      carrierName: carrierName ?? this.carrierName,
      countryIso: countryIso ?? this.countryIso,
      subscriptionId: subscriptionId ?? this.subscriptionId,
    );
  }
}