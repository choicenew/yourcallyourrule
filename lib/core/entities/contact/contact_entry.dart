import 'package:yourcallyourrule/core/base/base_entity.dart';

/// Contact entity class
/// Represents a contact with name, phone numbers, and other information
class Contact extends BaseEntity {
  String name;
  List<String> phoneNumbers;
  String? email;
  String? label;
  String? avatar;
  String? website;
  String? group;
  String? url;

  Contact({
    required super.id,  // Add required id parameter
    required this.name,
    required this.phoneNumbers,
    this.email,
    this.label,
    this.avatar,
    this.website,
    this.group,
    this.url,
  });  // Correct super call with named parameter

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumbers': phoneNumbers,
      'email': email,
      'label': label,
      'avatar': avatar,
      'website': website,
      'group': group,
      'url': url,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      name: map['name'] as String,
      phoneNumbers: List<String>.from(map['phoneNumbers']),
      email: map['email'] as String?,
      label: map['label'] as String?,
      avatar: map['avatar'] as String?,
      website: map['website'] as String?,
      group: map['group'] as String?,
      url: map['url'] as String?,
    );
  }

  Contact copyWith({
    String? id,
    String? name,
    List<String>? phoneNumbers,
    String? email,
    String? label,
    String? avatar,
    String? website,
    String? group,
    String? url,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      email: email ?? this.email,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      website: website ?? this.website,
      group: group ?? this.group,
      url: url ?? this.url,
    );
  }


  // 声明列表类型字段
  static const listFields = {'phonenumbers', 'phonenumber'};
}