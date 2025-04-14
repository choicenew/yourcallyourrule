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
  final String smsType;  // Changed from messageType to smsType
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final String? ruleId;
  final String source;
  
  SmsModel({
    required this.id,
    required this.phoneNumberValue,
    this.name,
    this.label,
    this.avatar,
    required this.smsType,  // Changed parameter name
    required this.content,
    required this.timestamp,
    required this.isRead,
    this.ruleId,
    required this.source,
  });

  // Add conversion methods for SmsType enum
  static String _smsTypeToString(SmsType type) {
    return type.toString().split('.').last;
  }

  static SmsType _stringToSmsType(String value) {
    return SmsType.values.firstWhere(
      (type) => type.toString().split('.').last == value,
      orElse: () => SmsType.unknown,
    );
  }
  
  factory SmsModel.fromEntity(SmsMessage smsMessage) {
    return SmsModel(
      id: smsMessage.id,
      phoneNumberValue: smsMessage.phoneNumber.value,
      name: smsMessage.name,
      label: smsMessage.label,
      avatar: smsMessage.avatar,
      smsType: _smsTypeToString(smsMessage.smsType),
      content: smsMessage.content,
      timestamp: smsMessage.timestamp,
      isRead: smsMessage.isRead,
      ruleId: smsMessage.ruleId,
      source: smsMessage.source,
    );
  }
  
  SmsMessage toEntity() {
    return SmsMessage(
      id: id,
      phoneNumber: PhoneNumber(phoneNumberValue),
      name: name,
      label: label,
      avatar: avatar,
      smsType: _stringToSmsType(smsType),
      content: content,
      timestamp: timestamp,
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
      'sms_type': smsType,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'is_read': isRead ? 1 : 0,
      'rule_id': ruleId,
      'source': source,
    };
  }
  
  factory SmsModel.fromMap(Map<String, dynamic> map) {
    return SmsModel(
      id: map['id'],
      phoneNumberValue: map['phone_number'],
      name: map['name'],
      label: map['label'],
      avatar: map['avatar'],
      smsType: map['sms_type'],
      content: map['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
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
    String? smsType,  // Changed from messageType to smsType
    String? content,
    DateTime? timestamp,
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
      smsType: smsType ?? this.smsType,  // Fixed parameter name
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      ruleId: ruleId ?? this.ruleId,
      source: source ?? this.source,
    );
  }
}