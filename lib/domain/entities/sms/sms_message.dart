import '../base/phone_entry.dart';
import '../../value_objects/phone_number.dart';

/// 短信类型枚举
enum SmsType {
  incoming,  // 收到的短信
  outgoing,  // 发送的短信
  draft,     // 草稿
  blocked    // 已拦截
}

/// 短信消息实体
/// 表示一条短信消息
class SmsMessage extends PhoneEntry {
  final DateTime timestamp;
  final SmsType smsType;
  final String content;
  final bool isRead;
  final String? ruleId; // 匹配的规则ID，如果有的话
  
  const SmsMessage({
    required super.id,
    required super.phoneNumber,
    super.name,
    super.label,
    super.avatar,
    required super.source,
    required this.timestamp,
    required this.smsType,
    required this.content,
    this.isRead = false,
    this.ruleId,
  });
  
  /// 创建短信消息的副本，但可以更新某些属性
  SmsMessage copyWith({
    String? id,
    PhoneNumber? phoneNumber,
    String? name,
    String? label,
    String? avatar,
    String? source,
    DateTime? timestamp,
    SmsType? smsType,
    String? content,
    bool? isRead,
    String? ruleId,
  }) {
    return SmsMessage(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      source: source ?? this.source,
      timestamp: timestamp ?? this.timestamp,
      smsType: smsType ?? this.smsType,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      ruleId: ruleId ?? this.ruleId,
    );
  }
  
  /// 检查短信是否被阻止
  bool get isBlocked => smsType == SmsType.blocked;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return super == other &&
        other is SmsMessage &&
        other.timestamp == timestamp &&
        other.smsType == smsType &&
        other.content == content;
  }
  
  @override
  int get hashCode => Object.hash(
        super.hashCode,
        timestamp,
        smsType,
        content,
      );
}