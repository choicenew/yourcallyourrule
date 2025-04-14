import '../../domain/entities/contact/contact.dart';
import '../../domain/value_objects/phone_number.dart';
import 'base_model.dart';

/// 联系人模型
/// 用于将联系人实体转换为数据库可存储的格式
class ContactModel extends BaseModel<ContactModel> {
  final String id;
  final String name;
  final String phoneNumberValue;
  final String? label;
  final String? avatar;
  final String source;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumberValue,
    this.label,
    this.avatar,
    required this.source,
    required this.isFavorite,
    required this.createdAt,
    this.updatedAt,
  });

  /// 从联系人实体创建模型
  factory ContactModel.fromEntity(Contact contact) {
    return ContactModel(
      id: contact.id,
      name: contact.name ?? '',
      phoneNumberValue: contact.phoneNumber.value,
      label: contact.label,
      avatar: contact.avatar,
      source: contact.source,
      isFavorite: contact.isFavorite,
      createdAt: contact.createdAt,
      updatedAt: contact.updatedAt,
    );
  }
  
  /// 将模型转换为联系人实体
  Contact toEntity() {
    return Contact(
      id: id,
      name: name,
      phoneNumber: PhoneNumber(phoneNumberValue),
      label: label,
      avatar: avatar,
      source: source,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumberValue,
      'label': label,
      'avatar': avatar,
      'source': source,
      'is_favorite': isFavorite ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }
  
  /// 从Map创建模型
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      phoneNumberValue: map['phone_number'],
      label: map['label'],
      avatar: map['avatar'],
      source: map['source'],
      isFavorite: map['is_favorite'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: map['updated_at'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'])
          : null,
    );
  }
  
  /// 创建模型的副本并更新指定字段
  ContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumberValue,
    String? label,
    String? avatar,
    String? source,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumberValue: phoneNumberValue ?? this.phoneNumberValue,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      source: source ?? this.source,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}