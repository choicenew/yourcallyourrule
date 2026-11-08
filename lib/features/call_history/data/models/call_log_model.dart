import 'dart:convert';

import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';

/// 强类型模型转化层 (Drift / Local DB <-> CallLogEntry)
class CallLogModel {
  final String id;
  final String phoneNumber;
  final String? name;
  final DateTime timestamp;
  final DateTime? endTime;
  final int? duration;
  final String simDisplayName;
  final String callType;
  final int simSlotIndex;
  final String carrierName;
  final String countryIso;
  final int subscriptionId;
  final List<String>? labelIds;

  CallLogModel({
    required this.id,
    required this.phoneNumber,
    this.name,
    required this.timestamp,
    this.endTime,
    this.duration,
    required this.simDisplayName,
    required this.callType,
    required this.simSlotIndex,
    required this.carrierName,
    required this.countryIso,
    required this.subscriptionId,
    this.labelIds,
  });

  CallLogEntry toEntity() {
    return CallLogEntry(
      id: id,
      phoneNumber: phoneNumber,
      callType: callType,
      timestamp: timestamp.millisecondsSinceEpoch,
      durationSeconds: duration != null ? (duration! / 1000).round() : null,
      name: name,
      location: countryIso,
    );
  }

  factory CallLogModel.fromEntity(CallLogEntry entity) {
    return CallLogModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber,
      name: entity.name,
      timestamp: DateTime.fromMillisecondsSinceEpoch(entity.timestamp ?? DateTime.now().millisecondsSinceEpoch),
      duration: entity.durationSeconds != null ? entity.durationSeconds! * 1000 : null,
      simDisplayName: '',
      callType: entity.callType,
      simSlotIndex: 0,
      carrierName: '',
      countryIso: entity.location ?? '',
      subscriptionId: 0,
    );
  }

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

    return CallLogModel(
      id: map['id']?.toString() ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'],
      timestamp: parsedTimestamp,
      endTime: parsedEndTime,
      duration: parsedDuration,
      simDisplayName: map['simDisplayName'] ?? '',
      callType: map['callType'] ?? '',
      simSlotIndex: int.tryParse(map['simSlotIndex']?.toString() ?? '0') ?? 0,
      carrierName: map['carrierName'] ?? '',
      countryIso: map['countryIso'] ?? '',
      subscriptionId: int.tryParse(map['subscriptionId']?.toString() ?? '0') ?? 0,
      labelIds: labelIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'duration': duration,
      'simDisplayName': simDisplayName,
      'callType': callType,
      'simSlotIndex': simSlotIndex,
      'carrierName': carrierName,
      'countryIso': countryIso,
      'subscriptionId': subscriptionId,
      'labelIds': labelIds != null ? jsonEncode(labelIds) : null,
    };
  }
}