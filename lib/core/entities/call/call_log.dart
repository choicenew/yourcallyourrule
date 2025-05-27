import 'package:yourcallyourrule/core/base/base_entity.dart';

class CallLog extends BaseEntity {
  final List<String>? labelIds;
  final String number;
  final String? name; // 添加name字段
  final DateTime timestamp;
  final String simDisplayName;
  final String callType;
  final int simSlotIndex;
  final String carrierName;
  final String countryIso;
  final int subscriptionId;

  CallLog({
    required super.id,
    this.labelIds,
    required this.number,
    this.name, // 添加name参数
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
        'labelIds': labelIds,
        'number': number,
        'name': name, // 添加name字段
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
      labelIds: map['labelIds'] != null ? List<String>.from(map['labelIds']) : null,
      number: map['number'] as String,
      name: map['name'] as String?, // 添加name字段
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
    List<String>? labelIds,
    String? number,
    String? name, // 添加name参数
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
      labelIds: labelIds ?? this.labelIds,
      number: number ?? this.number,
      name: name ?? this.name, // 添加name字段
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