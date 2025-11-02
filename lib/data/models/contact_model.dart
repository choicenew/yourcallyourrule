// lib/data/models/contact_model.dart

import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'base_model.dart';

// 联系人数据模型，用于数据层与领域层之间的转换
class ContactModel extends BaseModel<Contact> {
  // 电话号码
  final List<String> phoneNumbers;
   // 联系人名称
  final String name;
  
  // 头像（可选）
  final String? avatar;
   
 // 标签ID列表（可选）
  final List<String>? labelIds;
  final bool isFavorite;
  final String? email;
  final String? website;
  final String? group;
  final String? url;

  const ContactModel({
    required super.id,
    required this.phoneNumbers,
    required this.name,
    this.avatar,
    this.labelIds,
    this.isFavorite = false,
    this.email,
    this.website,
    this.group,
    this.url,
  });

  // 从Map创建模型
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] as String,
      name: map['name'] as String,
      phoneNumbers: List<String>.from(map['phoneNumbers'] ?? []),
      email: map['email'] as String?,
      labelIds: map['labelIds'] != null ? List<String>.from(map['labelIds']) : null,
      avatar: map['avatar'] as String?,
      website: map['website'] as String?,
      group: map['group'] as String?,
      url: map['url'] as String?,
      isFavorite: (map['isFavorite'] as bool? ?? false),
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'name': name,
      'phoneNumbers': phoneNumbers,
      'email': email,
      'labelIds': labelIds,
      'avatar': avatar,
      'website': website,
      'group': group,
      'url': url,
      'isFavorite': isFavorite,
    });
    return map;
  }

  // 将模型转换为实体
  @override
  Contact toEntity() {
    return Contact(
      id: id,
      name: name,
      phoneNumbers: phoneNumbers,
      email: email,
      labelIds: labelIds,
      avatar: avatar,
      website: website,
      group: group,
      url: url,
      isFavorite: isFavorite,
    );
  }

  // 从实体创建模型
  static ContactModel fromEntity(Contact entity) {
    return ContactModel(
      id: entity.id,
      name: entity.name,
      phoneNumbers: entity.phoneNumbers,
      email: entity.email,
      labelIds: entity.labelIds,
      avatar: entity.avatar,
      website: entity.website,
      group: entity.group,
      url: entity.url,
      isFavorite: entity.isFavorite,
    );
  }

  // copyWith 方法
  ContactModel copyWith({
    String? id,
    String? name,
    List<String>? phoneNumbers,
    String? email,
    List<String>? labelIds,
    String? avatar,
    String? website,
    String? group,
    String? url,
    bool? isFavorite,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      email: email ?? this.email,
      labelIds: labelIds ?? this.labelIds,
      avatar: avatar ?? this.avatar,
      website: website ?? this.website,
      group: group ?? this.group,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}