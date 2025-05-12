import 'package:yourcallyourrule/core/base/base_entity.dart';

/// Contact entity class
/// Represents a contact with name, phone numbers, and other information
class Contact extends BaseEntity {
  String name;
  List<String> phoneNumbers;
  String? email;
  String? labelId; // Changed from label to labelId
  String? avatar;
  String? website;
  String? group;
  String? url;
  bool isFavorite; // 是否为常用联系人

  Contact({
    required super.id,  // Add required id parameter
    required this.name,
    required this.phoneNumbers,
    this.email,
    this.labelId, // Changed from label to labelId
    this.avatar,
    this.website,
    this.group,
    this.url,
    this.isFavorite = false, // 默认不是常用联系人
  });  // Correct super call with named parameter

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumbers': phoneNumbers,
      'email': email,
      'labelId': labelId, // Changed from label to labelId
      'avatar': avatar,
      'website': website,
      'group': group,
      'url': url,
      'isFavorite': isFavorite,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      name: map['name'] as String,
      phoneNumbers: List<String>.from(map['phoneNumbers']),
      email: map['email'] as String?,
      labelId: map['labelId'] as String?, // Changed from label to labelId
      avatar: map['avatar'] as String?,
      website: map['website'] as String?,
      group: map['group'] as String?,
      url: map['url'] as String?,
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  Contact copyWith({
    String? id,
    String? name,
    List<String>? phoneNumbers,
    String? email,
    String? labelId, // Changed from label to labelId
    String? avatar,
    String? website,
    String? group,
    String? url,
    bool? isFavorite,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      email: email ?? this.email,
      labelId: labelId ?? this.labelId, // Changed from label to labelId
      avatar: avatar ?? this.avatar,
      website: website ?? this.website,
      group: group ?? this.group,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }


  // 声明列表类型字段
  static const listFields = {'phonenumbers', 'phonenumber'};
}