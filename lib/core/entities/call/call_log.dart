import 'package:yourcallyourrule/core/base/base_entity.dart';

class CallLog extends BaseEntity {
  final List<String>? labelIds;
  final String phoneNumber;
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
    required this.phoneNumber,
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
        'phoneNumber': phoneNumber,
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

    return CallLog(
      id: map['id'] as String,
      labelIds: map['labelIds'] != null ? List<String>.from(map['labelIds']) : null,
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String?, // 添加name字段
      timestamp: parsedTimestamp,
      simDisplayName: map['simDisplayName'] as String,
      callType: map['callType'] as String,
      simSlotIndex: int.parse(map['simSlotIndex'].toString()),
      carrierName: map['carrierName'] as String,
      countryIso: map['countryIso'] as String,
      subscriptionId: int.parse(map['subscriptionId'].toString()),
    );
  }

  CallLog copyWith({
    String? id,
    List<String>? labelIds,
    String? phoneNumber,
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
      phoneNumber: phoneNumber ?? this.phoneNumber,
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