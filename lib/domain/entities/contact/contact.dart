import '../base/phone_entry.dart';
import '../../value_objects/phone_number.dart';

/// 联系人实体
/// 表示用户的联系人
class Contact extends PhoneEntry {
  final String? email;
  final String? address;
  final bool isFavorite;
  final Map<String, dynamic>? additionalInfo;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const Contact({
    required super.id,
    required super.phoneNumber,
    super.name,
    super.label,
    super.avatar,
    required super.source,
    this.email,
    this.address,
    this.isFavorite = false,
    this.additionalInfo,
    required this.createdAt,
    this.updatedAt,
  });
  
  /// 创建联系人的副本，但可以更新某些属性
  Contact copyWith({
    String? id,
    PhoneNumber? phoneNumber,
    String? name,
    String? label,
    String? avatar,
    String? source,
    String? email,
    String? address,
    bool? isFavorite,
    Map<String, dynamic>? additionalInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Contact(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      source: source ?? this.source,
      email: email ?? this.email,
      address: address ?? this.address,
      isFavorite: isFavorite ?? this.isFavorite,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return super == other &&
        other is Contact &&
        other.email == email &&
        other.address == address &&
        other.isFavorite == isFavorite &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
  
  @override
  int get hashCode => Object.hash(
        super.hashCode,
        email,
        address,
        isFavorite,
        createdAt,
        updatedAt,
      );
}