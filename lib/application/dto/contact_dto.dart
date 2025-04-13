import 'base_dto.dart';

/// 联系人数据传输对象
/// 用于在应用层和领域层之间传递联系人数据
class ContactDto extends BaseDto {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? label;
  final String? avatar;
  final bool isFavorite;
  final String source; // 来源(设备/云端/手动添加)
  
  ContactDto({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.label,
    this.avatar,
    this.isFavorite = false,
    required this.source,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'label': label,
      'avatar': avatar,
      'isFavorite': isFavorite,
      'source': source,
    };
  }
  
  /// 从Map创建DTO
  factory ContactDto.fromMap(Map<String, dynamic> map) {
    return ContactDto(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      label: map['label'],
      avatar: map['avatar'],
      isFavorite: map['isFavorite'] ?? false,
      source: map['source'],
    );
  }
}