import 'base_dto.dart';

/// 通话记录数据传输对象
/// 用于在应用层和领域层之间传递通话记录数据
class CallDto extends BaseDto {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? label;
  final String? avatar;
  final DateTime timestamp;
  final int duration; // 通话时长(秒)
  final String type; // 通话类型(已接/未接/拒接/呼出)
  final bool isRead; // 是否已读
  final String? note; // 备注
  final String? matchedRuleId; // 匹配的规则ID
  
  CallDto({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.label,
    this.avatar,
    required this.timestamp,
    required this.duration,
    required this.type,
    this.isRead = false,
    this.note,
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
      'duration': duration,
      'type': type,
      'isRead': isRead,
      'note': note,
      'matchedRuleId': matchedRuleId,
    };
  }
  
  /// 从Map创建DTO
  factory CallDto.fromMap(Map<String, dynamic> map) {
    return CallDto(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      label: map['label'],
      avatar: map['avatar'],
      timestamp: DateTime.parse(map['timestamp']),
      duration: map['duration'],
      type: map['type'],
      isRead: map['isRead'] ?? false,
      note: map['note'],
      matchedRuleId: map['matchedRuleId'],
    );
  }
}