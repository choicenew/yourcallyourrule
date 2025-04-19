// 短信数据模型，用于数据层与领域层之间的转换

import '../../core/value_objects/phone_number.dart';
import 'base_model.dart';

// 短信记录模型类
class SmsModel extends BaseModel<SmsEntity> {
  // 电话号码
  final String phoneNumber;
  
  // 联系人名称（可选）
  final String? contactName;
  
  // 短信类型（接收、发送）
  final String messageType;
  
  // 短信内容
  final String content;
  
  // 短信时间
  final DateTime timestamp;
  
  // 是否已读
  final bool isRead;
  
  // SIM卡信息（可选）
  final String? simInfo;
  
  // 是否被标记
  final bool isMarked;
  
  // 标签ID列表（可选）
  final List<String>? labelIds;

  // 构造函数
  const SmsModel({
    required String id,
    required this.phoneNumber,
    this.contactName,
    required this.messageType,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.simInfo,
    this.isMarked = false,
    this.labelIds,
  }) : super(id: id);
  
  // 从Map创建模型
  factory SmsModel.fromMap(Map<String, dynamic> map) {
    return SmsModel(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      contactName: map['contactName'],
      messageType: map['messageType'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'] ?? false,
      simInfo: map['simInfo'],
      isMarked: map['isMarked'] ?? false,
      labelIds: map['labelIds'] != null 
          ? List<String>.from(map['labelIds']) 
          : null,
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'contactName': contactName,
      'messageType': messageType,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'simInfo': simInfo,
      'isMarked': isMarked,
      'labelIds': labelIds,
    });
    return map;
  }
  
  // 将模型转换为实体
  @override
  SmsEntity toEntity() {
    return SmsEntity(
      id: id,
      phoneNumber: PhoneNumber(value:phoneNumber),
      contactName: contactName,
      messageType: messageType,
      content: content,
      timestamp: timestamp,
      isRead: isRead,
      simInfo: simInfo,
      isMarked: isMarked,
      labelIds: labelIds,
    );
  }
  
  // 从实体创建模型
  static SmsModel fromEntity(SmsEntity entity) {
    return SmsModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber.value,
      contactName: entity.contactName,
      messageType: entity.messageType,
      content: entity.content,
      timestamp: entity.timestamp,
      isRead: entity.isRead,
      simInfo: entity.simInfo,
      isMarked: entity.isMarked,
      labelIds: entity.labelIds,
    );
  }
}

// 短信记录实体类
class SmsEntity {
  // 实体ID
  final String id;
  
  // 电话号码值对象
  final PhoneNumber phoneNumber;
  
  // 联系人名称（可选）
  final String? contactName;
  
  // 短信类型（接收、发送）
  final String messageType;
  
  // 短信内容
  final String content;
  
  // 短信时间
  final DateTime timestamp;
  
  // 是否已读
  final bool isRead;
  
  // SIM卡信息（可选）
  final String? simInfo;
  
  // 是否被标记
  final bool isMarked;
  
  // 标签ID列表（可选）
  final List<String>? labelIds;

  // 构造函数
  const SmsEntity({
    required this.id,
    required this.phoneNumber,
    this.contactName,
    required this.messageType,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.simInfo,
    this.isMarked = false,
    this.labelIds,
  });
  
  // 相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SmsEntity && other.id == id;
  }
  
  // 哈希码
  @override
  int get hashCode => id.hashCode;
  
  // 将实体转换为Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber.value,
      'contactName': contactName,
      'messageType': messageType,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'simInfo': simInfo,
      'isMarked': isMarked,
      'labelIds': labelIds,
    };
  }
}