// 来电显示数据实体类，用于表示来电显示所需的所有信息

import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';

import '../base/base_entity.dart';
import '../value_objects/phone_number.dart';
import '../value_objects/rule_action.dart';

class CallerIdData extends BaseEntity {
  // 电话号码值对象
  final PhoneNumber phoneNumber;
  
  // 新增号码类型字段
  final PhoneNumberType numberType;
  
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
  
  // 规则动作（用于指定如何处理该号码）
  final RuleAction action;
  
  // 获取头像图片
  ImageProvider? get avatarImage {
    if (avatar == null || avatar!.isEmpty) {
      // 如果没有头像但有标签，则使用第一个标签
      if (labels != null && labels!.isNotEmpty) {
        return AssetImage(AvatarUtils.getSafeAvatarPath(labels!.first.label));
      }
      return null;
    }
    
    // 如果avatar是URL链接，则使用NetworkImage
    if (avatar!.startsWith('http')) {
      return NetworkImage(avatar!);
    } else {
      // 如果avatar是本地资源路径，则使用AssetImage
      return AssetImage(avatar!);
    }
  }
  
  // 更新构造函数
  const CallerIdData({
    required super.id,
    required this.phoneNumber,
    required this.numberType,
    this.name,
    this.countryName,
    this.region,
    this.carrier,
    this.labels,
    this.avatar,
    this.count = 0,
    this.action = RuleAction.none,
  });
  
  // 更新toMap方法
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'numberType': numberType.index, // 存储枚举索引值
      'name': name,
      'countryName': countryName,
      'region': region,
      'carrier': carrier,
      'labels': labels?.map((label) => label.toMap()).toList(),
      'avatar': avatar,
      'count': count,
      'action': action.toString(),
    });
    return map;
  }
  
  // 更新fromMap方法
  factory CallerIdData.fromMap(Map<String, dynamic> map) {
    // 解析action字段，如果存在
    RuleAction action = RuleAction.none;
    if (map['action'] != null && map['action'] is String && map['action'].isNotEmpty) {
      action = RuleAction.fromString(map['action']);
    }
    
    return CallerIdData(
      id: map['id'],
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      numberType: PhoneNumberType.values[map['numberType']], // 从索引值还原枚举
      name: map['name'],
      countryName: map['countryName'],
      region: map['region'],
      carrier: map['carrier'],
      labels: (map['labels'] as List?)
          ?.map((labelMap) => Label.fromMap(labelMap))
          .toList(),
      action: action,
      avatar: map['avatar'],
      count: map['count'] ?? 0,
    );
  }
  
  // 创建带有递增计数的新实例
  CallerIdData incrementCount() {
    return CallerIdData(
      id: id,
      phoneNumber: phoneNumber,
      numberType: numberType,
      name: name,
      countryName: countryName,
      region: region,
      carrier: carrier,
      labels: labels,
      avatar: avatar,
      count: count + 1,
      action: action,
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