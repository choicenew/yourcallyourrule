import '../../domain/entities/sms/sms_message.dart';
import '../../domain/value_objects/phone_number.dart';
import 'base_model.dart';

/// 短信消息模型
/// 用于将短信消息实体转换为数据库可存储的格式
class SmsModel extends BaseModel<SmsModel> {
  final String id;
  final String phoneNumberValue;
  final String? name;
  final String? label;
  final String? avatar;
  final String messageType; // 收到、发送
  final String content;
  final DateTime timestamp;
  final bool isBlocked; // 是否被阻止
  final bool isRead; // 是否已读
  final String? ruleId; // 匹配的规则ID
  final String source;
  
  SmsModel({
    required this.id,
    required this.phoneNumberValue,
    this.name,
    this.label,
    this.avatar,
    required this.messageType,
    required this.content,
    required this.timestamp,
    required this.isBlocked,
    required this.isRead,
    this.ruleId,
    required this.source,
  });
  
  /// 从短信消息实体创建模型
  factory SmsModel.fromEntity(SmsMessage smsMessage) {
    return SmsModel(
      id: smsMessage.id,
      phoneNumberValue: smsMessage.phoneNumber.value,
      name: smsMessage.name,
      label: smsMessage.label,
      avatar: smsMessage.avatar,
      messageType: smsMessage.messageType,
      content: smsMessage.content,
      timestamp: smsMessage.timestamp,
      isBlocked: smsMessage.isBlocked,
      isRead: smsMessage.isRead,
      ruleId: smsMessage.ruleId,
      source: smsMessage.source,
    );
  }
  
  /// 将模型转换为短信消息实体
  SmsMessage toEntity() {
    return SmsMessage(
      id: id,
      phoneNumber: PhoneNumber(phoneNumberValue),
      name: name,
      label: label,
      avatar: avatar,
      messageType: messageType,
      content: content,
      timestamp: timestamp,
      isBlocked: isBlocked,
      isRead: isRead,
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
      'message_type': messageType,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'is_blocked': isBlocked ? 1 : 0,
      'is_read': isRead ? 1 : 0,
      'rule_id': ruleId,
      'source': source,
    };
  }
  
  /// 从Map创建模型
  factory SmsModel.fromMap(Map<String, dynamic> map) {
    return SmsModel(
      id: map['id'],
      phoneNumberValue: map['phone_number'],
      name: map['name'],
      label: map['label'],
      avatar: map['avatar'],
      messageType: map['message_type'],
      content: map['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      isBlocked: map['is_blocked'] == 1,
      isRead: map['is_read'] == 1,
      ruleId: map['rule_id'],
      source: map['source'],
    );
  }
  
  /// 创建模型的副本并更新指定字段
  SmsModel copyWith({
    String? id,
    String? phoneNumberValue,
    String? name,
    String? label,
    String? avatar,
    String? messageType,
    String? content,
    DateTime? timestamp,
    bool? isBlocked,
    bool? isRead,
    String? ruleId,
    String? source,
  }) {
    return SmsModel(
      id: id ?? this.id,
      phoneNumberValue: phoneNumberValue ?? this.phoneNumberValue,
      name: name ?? this.name,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      messageType: messageType ?? this.messageType,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isBlocked: isBlocked ?? this.isBlocked,
      isRead: isRead ?? this.isRead,
      ruleId: ruleId ?? this.ruleId,
      source: source ?? this.source,
    );
  }
}