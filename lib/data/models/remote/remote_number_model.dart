// 远程号码数据模型，用于存储私有号码数据

import '../../base_model.dart';

// 远程号码模型类
class RemoteNumberModel extends BaseModel<RemoteNumberEntity> {
  // 联系人名称（可选）
  final String? name;
  
  // 电话号码
  final String phoneNumber;
  
  // 标签文本内容
  final String label;
  
  // 优先级
  final int priority;
  
  // 动作
  final String action;
  
  // 计数属性
  final int count;
  
  // 构造函数
  const RemoteNumberModel({
    required super.id,
    this.name,
    required this.phoneNumber,
    required this.label,
    required this.priority,
    required this.action,
    required this.count,
  });
  
  // 从Map创建模型
  factory RemoteNumberModel.fromMap(Map<String, dynamic> map) {
    return RemoteNumberModel(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      label: map['label'],
      priority: map['priority'],
      action: map['action'],
      count: map['count'] is String ? int.tryParse(map['count']) ?? 0 : (map['count'] ?? 0),
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'name': name,
      'phoneNumber': phoneNumber,
      'label': label,
      'priority': priority,
      'action': action,
      'count': count,
    });
    return map;
  }
  
  // 将模型转换为实体
  @override
  RemoteNumberEntity toEntity() {
    return RemoteNumberEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      label: label,
      priority: priority,
      action: action,
      count: count,
    );
  }
  
  // 从实体创建模型
  factory RemoteNumberModel.fromEntity(RemoteNumberEntity entity) {
    return RemoteNumberModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      label: entity.label,
      priority: entity.priority,
      action: entity.action,
      count: entity.count,
    );
  }
}

// 远程号码实体类
class RemoteNumberEntity {
  final String id;
  final String? name;
  final String phoneNumber;
  final String label;
  final int priority;
  final String action;
  final int count;
  
  const RemoteNumberEntity({
    required this.id,
    this.name,
    required this.phoneNumber,
    required this.label,
    required this.priority,
    required this.action,
    required this.count,
  });
}