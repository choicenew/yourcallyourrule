import '../base/phone_entry.dart';
import '../../value_objects/phone_number.dart';

/// 通话类型枚举
enum CallType {
  unknown,   // 未知类型
  incoming,  // 来电
  outgoing,  // 去电
  missed,    // 未接
  rejected,  // 拒接
  blocked    // 已拦截
}

/// 通话记录实体
/// 表示一条通话记录
class CallLog extends PhoneEntry {
  final DateTime timestamp;
  final CallType callType;
  final Duration? duration;
  final String? note;
  final bool isRead;
  final String? ruleId; // 匹配的规则ID，如果有的话
  
  const CallLog({
    required super.id,
    required super.phoneNumber,
    super.name,
    super.label,
    super.avatar,
    required super.source,
    required this.timestamp,
    required this.callType,
    this.duration,
    this.note,
    this.isRead = false,
    this.ruleId,
  });
  
  /// 创建通话记录的副本，但可以更新某些属性
  CallLog copyWith({
    String? id,
    PhoneNumber? phoneNumber,
    String? name,
    String? label,
    String? avatar,
    String? source,
    DateTime? timestamp,
    CallType? callType,
    Duration? duration,
    String? note,
    bool? isRead,
    String? ruleId,
  }) {
    return CallLog(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      source: source ?? this.source,
      timestamp: timestamp ?? this.timestamp,
      callType: callType ?? this.callType,
      duration: duration ?? this.duration,
      note: note ?? this.note,
      isRead: isRead ?? this.isRead,
      ruleId: ruleId ?? this.ruleId,
    );
  }
  
  /// 检查通话是否被阻止
  bool get isBlocked => callType == CallType.blocked;
  
  /// 检查通话是否被接听
  bool get isAnswered => callType == CallType.incoming || callType == CallType.outgoing;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return super == other &&
        other is CallLog &&
        other.timestamp == timestamp &&
        other.callType == callType &&
        other.duration == duration;
  }
  
  @override
  int get hashCode => Object.hash(
        super.hashCode,
        timestamp,
        callType,
        duration,
      );
}