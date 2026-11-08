// 电话条目基类，所有与电话号码相关的实体都应该继承自这个类

import '../../base/base_entity.dart';
import '../../value_objects/phone_number.dart';

abstract class PhoneEntry extends BaseEntity {
  // 电话号码值对象
  final PhoneNumber phoneNumber;
  
  // 名称（可选）
  final String? name;
  
  // 头像（可选）
  final String? avatar;
  
  // 构造函数
  const PhoneEntry({
    required super.id,
    required this.phoneNumber,
    this.name,
    this.avatar,
  });
  
  // 重写toMap方法，添加电话条目特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'name': name,
      'avatar': avatar,
    });
    return map;
  }
}