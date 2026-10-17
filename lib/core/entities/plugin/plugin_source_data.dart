
import '../../value_objects/rule_action.dart';

class PluginSourceData {
  final String? predefinedLabel;
  final String? sourceLabel;
  final String? avatar;
  final int? count;
  final String? province;
  final String? city;
  final String? carrier;
  final String? name;
  final String? phoneNumber;
  final RuleAction action;
  final Map<String, dynamic> extra;

  PluginSourceData({
    this.predefinedLabel,
    this.sourceLabel,
    this.avatar,
    this.count,
    this.province,
    this.city,
    this.carrier,
    this.name,
    this.phoneNumber,
    this.action = RuleAction.none,
    Map<String, dynamic>? extra,
  }) : extra = extra ?? {};

  // 自动整合多个 PluginSourceData 实例的自动化融合领域方法
  static PluginSourceData merge(List<PluginSourceData> list) {
    if (list.isEmpty) return PluginSourceData();
    if (list.length == 1) return list.first;

    String? name;
    String? predefinedLabel;
    String? sourceLabel;
    String? avatar;
    String? province;
    String? city;
    String? carrier;
    String? phoneNumber;
    int maxCount = 0;

    int blockCount = 0;
    int allowCount = 0;
    RuleAction action = RuleAction.none;

    for (final item in list) {
      if (item.action.type == RuleActionType.block) {
        blockCount++;
        action = RuleAction.block;
      } else if (item.action.type == RuleActionType.allow) {
        allowCount++;
      }

      if (name == null || name.isEmpty || name == 'Unknown') {
        if (item.name != null && item.name!.isNotEmpty && item.name != 'Unknown') {
          name = item.name;
        }
      }

      if (predefinedLabel == null || predefinedLabel.isEmpty) {
        if (item.predefinedLabel != null && item.predefinedLabel!.isNotEmpty) {
          predefinedLabel = item.predefinedLabel;
        }
      }

      if (sourceLabel == null || sourceLabel.isEmpty) {
        if (item.sourceLabel != null && item.sourceLabel!.isNotEmpty) {
          sourceLabel = item.sourceLabel;
        }
      }

      if (avatar == null || avatar.isEmpty) {
        if (item.avatar != null && item.avatar!.isNotEmpty) {
          avatar = item.avatar;
        }
      }

      if (item.count != null && item.count! > maxCount) {
        maxCount = item.count!;
      }

      phoneNumber ??= item.phoneNumber;
      province ??= item.province;
      city ??= item.city;
      carrier ??= item.carrier;
    }

    if (allowCount > blockCount) {
      action = RuleAction.allow;
    } else if (blockCount > 0) {
      action = RuleAction.block;
    }

    return PluginSourceData(
      name: name,
      predefinedLabel: predefinedLabel,
      sourceLabel: sourceLabel,
      avatar: avatar,
      count: maxCount > 0 ? maxCount : null,
      province: province,
      city: city,
      carrier: carrier,
      phoneNumber: phoneNumber,
      action: action,
    );
  }

  // 新增fromMap工厂方法
  factory PluginSourceData.fromMap(Map<String, dynamic> map) {
    final extra = Map<String, dynamic>.from(map);
    
    // 提取并移除已知字段
    final predefinedLabel = extra.remove('predefinedLabel');
    final sourceLabel = extra.remove('sourceLabel');
    final avatar = extra.remove('avatar');
    final count = extra.remove('count')?.toString();
    final province = extra.remove('province');
    final city = extra.remove('city');
    final carrier = extra.remove('carrier');
    final name = extra.remove('name');
    final phoneNumber = extra.remove('phoneNumber');
    final actionStr = extra.remove('action');
    
    // 解析action字段，如果存在
    RuleAction action = RuleAction.none;
    if (actionStr != null && actionStr is String && actionStr.isNotEmpty) {
      action = RuleAction.fromString(actionStr);
    }

    return PluginSourceData(
      predefinedLabel: predefinedLabel,
      sourceLabel: sourceLabel,
      avatar: avatar,
      count: count != null ? int.tryParse(count) : null,
      province: province,
      city: city,
      carrier: carrier,
      name: name,
      phoneNumber: phoneNumber,
      action: action,
      extra: extra,
    );
  }

  // 新增toMap实例方法
  Map<String, dynamic> toMap() {
    return {
      'predefinedLabel': predefinedLabel,
      'sourceLabel': sourceLabel,
      'avatar': avatar,
      'count': count?.toString(),
      'province': province,
      'city': city,
      'carrier': carrier,
      'name': name,
      'phoneNumber': phoneNumber,
      'action': action.toString(),
    }..addAll(extra);
  }

  PluginSourceData copyWith({
    String? predefinedLabel,
    String? sourceLabel,
    String? avatar,
    int? count,
    String? province,
    String? city,
    String? carrier,
    String? name,
    String? phoneNumber,
    RuleAction? action,
    Map<String, dynamic>? extra,
  }) {
    return PluginSourceData(
      predefinedLabel: predefinedLabel ?? this.predefinedLabel,
      sourceLabel: sourceLabel ?? this.sourceLabel,
      avatar: avatar ?? this.avatar,
      count: count ?? this.count,
      province: province ?? this.province,
      city: city ?? this.city,
      carrier: carrier ?? this.carrier,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      action: action ?? this.action,
      extra: extra != null ? {...this.extra, ...extra} : this.extra,
    );
  }

  // 保留现有fromJson方法
  factory PluginSourceData.fromJson(Map<String, dynamic> json) {
    // 解析action字段，如果存在
    RuleAction action = RuleAction.none;
    if (json['action'] != null && json['action'] is String && json['action'].isNotEmpty) {
      action = RuleAction.fromString(json['action']);
    }
    
    return PluginSourceData(
      predefinedLabel: json['predefinedLabel'],
      action: action,
      sourceLabel: json['sourceLabel'],
      avatar: json['avatar'],
      count: json['count'] != null ? int.tryParse(json['count'].toString()) : null,
      province: json['province'],
      city: json['city'],
      carrier: json['carrier'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      extra: json,
    );
  }
}