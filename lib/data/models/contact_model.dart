// 联系人数据模型，用于数据层与领域层之间的转换

import '../../core/entities/phone_entry.dart';
import '../../core/value_objects/phone_number.dart';
import 'base_model.dart';

// 联系人模型类
class ContactModel extends BaseModel<PhoneEntry> {
  // 电话号码
  final String phoneNumber;
  
  // 联系人名称
  final String name;
  
  // 头像（可选）
  final String? avatar;
  
  // 备注（可选）
  final String? note;
  
  // 标签ID列表（可选）
  final List<String>? labelIds;
  
  // 是否收藏
  final bool isFavorite;
  
  // 最后更新时间
  final DateTime lastUpdated;

  // 构造函数
  const ContactModel({
    required String id,
    required this.phoneNumber,
    required this.name,
    this.avatar,
    this.note,
    this.labelIds,
    this.isFavorite = false,
    required this.lastUpdated,
  }) : super(id: id);
  
  // 从Map创建模型
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      avatar: map['avatar'],
      note: map['note'],
      labelIds: map['labelIds'] != null 
          ? List<String>.from(map['labelIds']) 
          : null,
      isFavorite: map['isFavorite'] ?? false,
      lastUpdated: map['lastUpdated'] != null 
          ? DateTime.parse(map['lastUpdated']) 
          : DateTime.now(),
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'name': name,
      'avatar': avatar,
      'note': note,
      'labelIds': labelIds,
      'isFavorite': isFavorite,
      'lastUpdated': lastUpdated.toIso8601String(),
    });
    return map;
  }
  
  // 将模型转换为实体
  @override
  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      phoneNumber: PhoneNumber(value:phoneNumber),
      name: name,
      avatar: avatar,
      note: note,
      labelIds: labelIds,
      isFavorite: isFavorite,
      lastUpdated: lastUpdated,
    );
  }
  
  // 从实体创建模型
  static ContactModel fromEntity(ContactEntity entity) {
    return ContactModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber.value,
      name: entity.name!,
      avatar: entity.avatar,
      note: entity.note,
      labelIds: entity.labelIds,
      isFavorite: entity.isFavorite,
      lastUpdated: entity.lastUpdated,
    );
  }
}

// 联系人实体类，继承自PhoneEntry
class ContactEntity extends PhoneEntry {
  // 备注（可选）
  final String? note;
  
  // 标签ID列表（可选）
  final List<String>? labelIds;
  
  // 是否收藏
  final bool isFavorite;
  
  // 最后更新时间
  final DateTime lastUpdated;

  // 构造函数
  const ContactEntity({
    required super.id,
    required super.phoneNumber,
    required String super.name,
    super.avatar,
    this.note,
    this.labelIds,
    this.isFavorite = false,
    required this.lastUpdated,
  });
  
  // 重写toMap方法，添加联系人特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'note': note,
      'labelIds': labelIds,
      'isFavorite': isFavorite,
      'lastUpdated': lastUpdated.toIso8601String(),
    });
    return map;
  }
}