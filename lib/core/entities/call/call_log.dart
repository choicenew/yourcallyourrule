import 'dart:convert';

import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';

class CallLog extends BaseEntity {
  final List<String>? labelIds;
  final String phoneNumber;
  final String? name; // 添加name字段
  final DateTime timestamp; // 通话开始时间
  final DateTime? endTime;    // 🔥 新增：通话结束时间
  final int? duration;       // 🔥 新增：通话时长（毫秒）
  final String simDisplayName;
  final LocalCallType callType;
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
    this.endTime,
    this.duration,
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
        'labelIds': labelIds != null ? jsonEncode(labelIds) : null,
        'phoneNumber': phoneNumber,
        'name': name, // 添加name字段
        'timestamp': timestamp.millisecondsSinceEpoch,
        'endTime': endTime?.millisecondsSinceEpoch, // 🔥 新增
        'duration': duration,                      // 🔥 新增
        'simDisplayName': simDisplayName,
        'callType': callType.name, // 使用枚举的 name 属性
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

    DateTime? parsedEndTime;
    final dynamic endTimeValue = map['endTime'];
    if (endTimeValue != null) {
      if (endTimeValue is int) {
        parsedEndTime = DateTime.fromMillisecondsSinceEpoch(endTimeValue);
      } else if (endTimeValue is String) {
        final int? asInt = int.tryParse(endTimeValue);
        if (asInt != null) {
          parsedEndTime = DateTime.fromMillisecondsSinceEpoch(asInt);
        }
      }
    }

    int? parsedDuration;
    final dynamic durationValue = map['duration'];
    if (durationValue != null) {
      if (durationValue is int) {
        parsedDuration = durationValue;
      } else if (durationValue is String) {
        parsedDuration = int.tryParse(durationValue);
      }
    }

    return CallLog(
      id: map['id'] as String,
      labelIds: labelIds,
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String?,
      timestamp: parsedTimestamp,
      endTime: parsedEndTime, // 🔥 新增
      duration: parsedDuration, // 🔥 新增
      simDisplayName: map['simDisplayName'] as String,
      callType: LocalCallType.fromString(map['callType'] as String), // 从字符串转换
      simSlotIndex: int.tryParse(map['simSlotIndex']?.toString() ?? '0') ?? 0,
      carrierName: map['carrierName'] as String,
      countryIso: map['countryIso'] as String,
      subscriptionId: int.tryParse(map['subscriptionId']?.toString() ?? '0') ?? 0,
    );
  }

  CallLog copyWith({
    String? id,
    List<String>? labelIds,
    String? phoneNumber,
    String? name, // 添加name参数
    DateTime? timestamp,
    DateTime? endTime,     // 🔥 新增
    int? duration,        // 🔥 新增
    String? simDisplayName,
    LocalCallType? callType,
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
      endTime: endTime ?? this.endTime,       // 🔥 新增
      duration: duration ?? this.duration,     // 🔥 新增
      simDisplayName: simDisplayName ?? this.simDisplayName,
      callType: callType ?? this.callType,
      simSlotIndex: simSlotIndex ?? this.simSlotIndex,
      carrierName: carrierName ?? this.carrierName,
      countryIso: countryIso ?? this.countryIso,
      subscriptionId: subscriptionId ?? this.subscriptionId,
    );
  }
}