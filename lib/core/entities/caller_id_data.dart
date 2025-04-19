// 来电显示数据实体类，用于表示来电显示所需的所有信息

import '../base/base_entity.dart';
import '../value_objects/phone_number.dart';

class CallerIdData extends BaseEntity {
  // 电话号码值对象
  final PhoneNumber phoneNumber;
  
  // 名称（可选）
  final String? name;
  
  // 国家名称（可选）
  final String? countryName;
  
  // 地区（可选）
  final String? region;
  
  // 运营商（可选）
  final String? carrier;
  
  // 标签列表（可选）
  final List<Label>? labels;
  
  // 头像（可选）
  final String? avatar;
  
  // 计数（用于统计出现次数）
  final int count;
  
  // 构造函数
  const CallerIdData({
    required String id,
    required this.phoneNumber,
    this.name,
    this.countryName,
    this.region,
    this.carrier,
    this.labels,
    this.avatar,
    this.count = 0,
  }) : super(id: id);
  
  // 重写toMap方法，添加来电显示数据特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'name': name,
      'countryName': countryName,
      'region': region,
      'carrier': carrier,
      'labels': labels?.map((label) => label.toMap()).toList(),
      'avatar': avatar,
      'count': count,
    });
    return map;
  }
  
  // 从Map创建实例的工厂构造函数
  factory CallerIdData.fromMap(Map<String, dynamic> map) {
    return CallerIdData(
      id: map['id'],
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      name: map['name'],
      countryName: map['countryName'],
      region: map['region'],
      carrier: map['carrier'],
      labels: (map['labels'] as List?)
          ?.map((labelMap) => Label.fromMap(labelMap))
          .toList(),
      avatar: map['avatar'],
      count: map['count'] ?? 0,
    );
  }
  
  // 创建带有递增计数的新实例
  CallerIdData incrementCount() {
    return CallerIdData(
      id: id,
      phoneNumber: phoneNumber,
      name: name,
      countryName: countryName,
      region: region,
      carrier: carrier,
      labels: labels,
      avatar: avatar,
      count: count + 1,
    );
  }
}

/// 标签类，用于表示电话号码的标签
class Label {
  final String label;
  final String? color;
  final String? icon;

  const Label({
    required this.label,
    this.color,
    this.icon,
  });

  // 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'color': color,
      'icon': icon,
    };
  }

  // 从Map创建实例
  factory Label.fromMap(Map<String, dynamic> map) {
    return Label(
      label: map['label'],
      color: map['color'],
      icon: map['icon'],
    );
  }
  
  // 相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Label && 
           other.label == label && 
           other.color == color && 
           other.icon == icon;
  }
  
  // 哈希码
  @override
  int get hashCode => Object.hash(label, color, icon);
}