import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';

import '../base/base_entity.dart';
import 'contact/contact_entry.dart';
import 'label/label_phone_entry.dart';
import 'label/predefined_label_entry.dart';
import 'location/location_entry.dart';
import 'plugin/plugin_source_data.dart';
import 'remote/remote_number_entry.dart';
import 'rule/phone_rule.dart';
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

  /// 全自动化多源数据融合工厂（自动处理名称优先级、分类标签与安全头像）
  factory CallerIdData.resolve({
    required String rawNumber,
    fluttercontact.Contact? localContact,
    Contact? finalContact,
    PhoneRule? phoneRule,
    LabelPhoneEntry? labelEntry,
    PredefinedLabel? labelFromId,
    RemoteNumberEntry? remoteNumberEntry,
    PluginSourceData? pluginSourceData,
    LocationEntry? locationData,
  }) {
    // 1. 自动化计算名字 (系统通讯录 > App本地联系人 > 本地规则 > 云端库 > 插件 > 'Unknown'标准Key)
    final name = localContact?.displayName ??
        finalContact?.name ??
        phoneRule?.name ??
        remoteNumberEntry?.name ??
        pluginSourceData?.name ??
        'Unknown';

    // 2. 自动化计算分类标签文本 (本地绑定的标签 > 远程库标签 > 插件标签 > 'Unknown')
    final labelText = labelFromId?.text ??
        remoteNumberEntry?.label ??
        pluginSourceData?.predefinedLabel ??
        'Unknown';

    // 3. 自动化解析头像 (联系人头像 > 规则头像 > 插件头像 > 根据标签自动匹配图标)
    final avatar = finalContact?.avatar ??
        phoneRule?.avatar ??
        pluginSourceData?.avatar ??
        AvatarUtils.getSafeAvatarPath(labelText);

    // 4. 自动化计算标记次数
    final count = phoneRule?.count ??
        remoteNumberEntry?.count ??
        pluginSourceData?.count ??
        0;

    // 5. 自动化计算拦截动作 (规则 > 远程库 > 插件 > 标签 > RuleAction.none)
    final action = phoneRule?.action ??
        remoteNumberEntry?.action ??
        pluginSourceData?.action ??
        labelEntry?.action ??
        RuleAction.none;

    return CallerIdData(
      id: rawNumber,
      phoneNumber: PhoneNumber.fromString(rawNumber),
      numberType: locationData?.numberType ?? PhoneNumberType.unknown,
      name: name,
      countryName: locationData?.countryName,
      region: locationData?.region,
      carrier: locationData?.carrier,
      labels: [Label(label: labelText)],
      avatar: avatar,
      count: count,
      action: action,
    );
  }

  /// 异步插件数据返回后的全自动化融合富集方法
  CallerIdData enrichWith(
    PluginSourceData completePluginData, {
    bool hasHighPriorityName = false,
    bool hasHighPriorityAction = false,
    bool hasHighPriorityAvatar = false,
  }) {
    final newName = hasHighPriorityName
        ? name
        : (completePluginData.name ?? name);

    final newAction = hasHighPriorityAction
        ? action
        : (completePluginData.action != RuleAction.none ? completePluginData.action : action);

    final newAvatar = hasHighPriorityAvatar
        ? avatar
        : (completePluginData.avatar ?? avatar);

    final newCount = completePluginData.count ?? count;

    String labelText = 'Unknown';
    if (labels?.isNotEmpty == true) {
      labelText = labels!.first.label;
    }

    if ((labelText == 'Unknown' || labelText.isEmpty) &&
        completePluginData.predefinedLabel != null) {
      labelText = completePluginData.predefinedLabel!;
    }

    String? effectiveAvatar = newAvatar;
    if (!hasHighPriorityAvatar &&
        (effectiveAvatar == null || effectiveAvatar == 'assets/avatars/Unknown.png') &&
        labelText != 'Unknown' && labelText.isNotEmpty) {
      effectiveAvatar = AvatarUtils.getSafeAvatarPath(labelText);
    }

    return CallerIdData(
      id: id,
      phoneNumber: phoneNumber,
      numberType: numberType,
      name: newName,
      countryName: countryName,
      region: region,
      carrier: carrier,
      labels: [Label(label: labelText)],
      avatar: effectiveAvatar,
      count: newCount,
      action: newAction,
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