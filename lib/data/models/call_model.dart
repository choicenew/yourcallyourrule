// 通话数据模型，用于数据层与领域层之间的转换

import '../../core/value_objects/phone_number.dart';
import 'base_model.dart';

// 通话记录模型类
class CallModel extends BaseModel<CallEntity> {
  // 电话号码
  final String phoneNumber;
  
  // 联系人名称（可选）
  final String? contactName;
  
  // 通话类型（来电、去电、未接）
  final String callType;
  
  // 通话开始时间
  final DateTime startTime;
  
  // 通话结束时间（可选，未接来电可能没有）
  final DateTime? endTime;
  
  // 通话时长（秒）
  final int duration;
  
  // 是否已读
  final bool isRead;
  
  // SIM卡信息（可选）
  final String? simInfo;
  
  // 通话备注（可选）
  final String? note;
  
  // 是否被标记
  final bool isMarked;
  
  // 标签ID列表（可选）
  final List<String>? labelIds;

  // 构造函数
  const CallModel({
    required super.id,
    required this.phoneNumber,
    this.contactName,
    required this.callType,
    required this.startTime,
    this.endTime,
    this.duration = 0,
    this.isRead = false,
    this.simInfo,
    this.note,
    this.isMarked = false,
    this.labelIds,
  });
  
  // 从Map创建模型
  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      contactName: map['contactName'],
      callType: map['callType'],
      startTime: DateTime.parse(map['startTime']),
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
      duration: map['duration'] ?? 0,
      isRead: map['isRead'] ?? false,
      simInfo: map['simInfo'],
      note: map['note'],
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
      'callType': callType,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'duration': duration,
      'isRead': isRead,
      'simInfo': simInfo,
      'note': note,
      'isMarked': isMarked,
      'labelIds': labelIds,
    });
    return map;
  }
  
  // 将模型转换为实体
  @override

  CallEntity toEntity() {
    return CallEntity(
      id: id,
      phoneNumber: PhoneNumber(phoneNumber), // Provide the required 'value' parameter
      contactName: contactName,
      callType: callType,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      isRead: isRead,
      simInfo: simInfo,
      note: note,
      isMarked: isMarked,
      labelIds: labelIds,
    );
  }
  
  // 从实体创建模型
  static CallModel fromEntity(CallEntity entity) {
    return CallModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber.value,
      contactName: entity.contactName,
      callType: entity.callType,
      startTime: entity.startTime,
      endTime: entity.endTime,
      duration: entity.duration,
      isRead: entity.isRead,
      simInfo: entity.simInfo,
      note: entity.note,
      isMarked: entity.isMarked,
      labelIds: entity.labelIds,
    );
  }
}

// 通话记录实体类
class CallEntity {
  // 实体ID
  final String id;
  
  // 电话号码值对象
  final PhoneNumber phoneNumber;
  
  // 联系人名称（可选）
  final String? contactName;
  
  // 通话类型（来电、去电、未接）
  final String callType;
  
  // 通话开始时间
  final DateTime startTime;
  
  // 通话结束时间（可选，未接来电可能没有）
  final DateTime? endTime;
  
  // 通话时长（秒）
  final int duration;
  
  // 是否已读
  final bool isRead;
  
  // SIM卡信息（可选）
  final String? simInfo;
  
  // 通话备注（可选）
  final String? note;
  
  // 是否被标记
  final bool isMarked;
  
  // 标签ID列表（可选）
  final List<String>? labelIds;

  // 构造函数
  const CallEntity({
    required this.id,
    required this.phoneNumber,
    this.contactName,
    required this.callType,
    required this.startTime,
    this.endTime,
    this.duration = 0,
    this.isRead = false,
    this.simInfo,
    this.note,
    this.isMarked = false,
    this.labelIds,
  });
  
  // 相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CallEntity && other.id == id;
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
      'callType': callType,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'duration': duration,
      'isRead': isRead,
      'simInfo': simInfo,
      'note': note,
      'isMarked': isMarked,
      'labelIds': labelIds,
    };
  }
}