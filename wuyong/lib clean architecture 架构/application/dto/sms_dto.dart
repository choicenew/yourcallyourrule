import 'base_dto.dart';

/// 短信消息数据传输对象
/// 用于在应用层和领域层之间传递短信消息数据
class SmsDto extends BaseDto {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? label;
  final String? avatar;
  final DateTime timestamp;
  final String content; // 短信内容
  final String type; // 短信类型(收到/发送)
  final bool isRead; // 是否已读
  final String? matchedRuleId; // 匹配的规则ID
  
  SmsDto({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.label,
    this.avatar,
    required this.timestamp,
    required this.content,
    required this.type,
    this.isRead = false,
    this.matchedRuleId,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'label': label,
      'avatar': avatar,
      'timestamp': timestamp.toIso8601String(),
      'content': content,
      'type': type,
      'isRead': isRead,
      'matchedRuleId': matchedRuleId,
    };
  }
  
  /// 从Map创建DTO
  factory SmsDto.fromMap(Map<String, dynamic> map) {
    return SmsDto(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      label: map['label'],
      avatar: map['avatar'],
      timestamp: DateTime.parse(map['timestamp']),
      content: map['content'],
      type: map['type'],
      isRead: map['isRead'] ?? false,
      matchedRuleId: map['matchedRuleId'],
    );
  }
}