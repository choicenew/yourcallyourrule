import '../../domain/entities/call/call_log.dart';
import '../../domain/value_objects/phone_number.dart';
import 'base_model.dart';

/// 通话记录模型
/// 用于将通话记录实体转换为数据库可存储的格式
class CallModel extends BaseModel<CallModel> {
  final String id;
  final String phoneNumberValue;
  final String? name;
  final String? label;
  final String? avatar;
  final String callType; // 来电、去电、未接
  final DateTime timestamp;
  final int duration; // 通话时长（秒）
  final bool isBlocked; // 是否被阻止
  final String? ruleId; // 匹配的规则ID
  final String source;
  
  CallModel({
    required this.id,
    required this.phoneNumberValue,
    this.name,
    this.label,
    this.avatar,
    required this.callType,
    required this.timestamp,
    required this.duration,
    required this.isBlocked,
    this.ruleId,
    required this.source,
  });
  
  // Make the conversion methods static
  static String _callTypeToString(CallType type) {
    return type.toString().split('.').last;
  }

  static CallType _stringToCallType(String value) {
    return CallType.values.firstWhere(
      (type) => type.toString().split('.').last == value,
      orElse: () => CallType.unknown,
    );
  }

  /// 从通话记录实体创建模型
  factory CallModel.fromEntity(CallLog callLog) {
    return CallModel(
      id: callLog.id,
      phoneNumberValue: callLog.phoneNumber.value,
      name: callLog.name,
      label: callLog.label,
      avatar: callLog.avatar,
      callType: CallModel._callTypeToString(callLog.callType),  // Use static method
      timestamp: callLog.timestamp,
      duration: callLog.duration?.inSeconds ?? 0,
      isBlocked: false,
      ruleId: callLog.ruleId,
      source: callLog.source,
    );
  }

  /// 将模型转换为通话记录实体
  CallLog toEntity() {
    return CallLog(
      id: id,
      phoneNumber: PhoneNumber(phoneNumberValue),
      name: name,
      label: label,
      avatar: avatar,
      callType: CallModel._stringToCallType(callType),  // Use static method
      timestamp: timestamp,
      duration: Duration(seconds: duration),
      ruleId: ruleId,
      source: source,
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone_number': phoneNumberValue,
      'name': name,
      'label': label,
      'avatar': avatar,
      'call_type': callType,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'duration': duration,
      'is_blocked': isBlocked ? 1 : 0,
      'rule_id': ruleId,
      'source': source,
    };
  }
  
  /// 从Map创建模型
  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      id: map['id'],
      phoneNumberValue: map['phone_number'],
      name: map['name'],
      label: map['label'],
      avatar: map['avatar'],
      callType: map['call_type'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      duration: map['duration'],
      isBlocked: map['is_blocked'] == 1,
      ruleId: map['rule_id'],
      source: map['source'],
    );
  }
  
  /// 创建模型的副本并更新指定字段
  CallModel copyWith({
    String? id,
    String? phoneNumberValue,
    String? name,
    String? label,
    String? avatar,
    String? callType,
    DateTime? timestamp,
    int? duration,
    bool? isBlocked,
    String? ruleId,
    String? source,
  }) {
    return CallModel(
      id: id ?? this.id,
      phoneNumberValue: phoneNumberValue ?? this.phoneNumberValue,
      name: name ?? this.name,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      callType: callType ?? this.callType,
      timestamp: timestamp ?? this.timestamp,
      duration: duration ?? this.duration,
      isBlocked: isBlocked ?? this.isBlocked,
      ruleId: ruleId ?? this.ruleId,
      source: source ?? this.source,
    );
  }
}