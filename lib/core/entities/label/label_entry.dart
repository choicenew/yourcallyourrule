// 标签条目实体，用于表示电话号码的标签信息

import '../../base/base_entity.dart';
import '../../value_objects/phone_number.dart';

class LabelEntry extends BaseEntity {
  // 电话号码值对象
  final PhoneNumber phoneNumber;
  
  // 标签文本内容
  final String label;
  
  // 名称（可选）
  final String? name;
  
  // 头像（可选）
  final String? avatar;
  
  // 标签颜色（可选）
  final String? color;
  
  // 标签图标（可选）
  final String? icon;
  
  // 构造函数
  const LabelEntry({
    required super.id,
    required this.phoneNumber,
    required this.label,
    this.name,
    this.avatar,
    this.color,
    this.icon,
  });
  
  // 重写toMap方法，添加标签条目特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'label': label,
      'name': name,
      'avatar': avatar,
      'color': color,
      'icon': icon,
    });
    return map;
  }
  
  // 从Map创建实例的工厂构造函数
  factory LabelEntry.fromMap(Map<String, dynamic> map) {
    return LabelEntry(
      id: map['id'],
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      label: map['label'],
      name: map['name'],
      avatar: map['avatar'],
      color: map['color'],
      icon: map['icon'],
    );
  }
}