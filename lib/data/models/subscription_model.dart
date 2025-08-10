import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'base_model.dart';
import '../../core/entities/subscription/subscription.dart';
import '../../core/entities/subscription/contact_subscription.dart';

// 基础订阅模型（只包含共同字段）
abstract class BaseSubscriptionModel<T extends BaseEntity> extends BaseModel<T> {
  final String name;
  final Url url;
  final bool isEnabled;
  final DateTime lastUpdated;
  final bool autoUpdate;

  const BaseSubscriptionModel({
    required super.id,
    required this.name,
    required this.url,
    this.isEnabled = true,
    required this.lastUpdated,
    this.autoUpdate = false,
  });
  
  // 基础toMap方法
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url.toString(),
      'isEnabled': isEnabled ? 1 : 0,
      'lastUpdated': lastUpdated.toIso8601String(),
      'autoUpdate': autoUpdate ? 1 : 0,
    };
  }
  
  // 抽象方法，子类必须实现
  @override
  T toEntity();
}

// 标准订阅模型（包含action字段）
class SubscriptionModel extends BaseSubscriptionModel<Subscription> {
  final RuleAction action; // 使用 action 替代 isWhitelist 和 isBlacklist

  const SubscriptionModel({
    required super.id,
    required super.name,
    required super.url,
    super.isEnabled,
    this.action = RuleAction.none, // 默认为none
    required super.lastUpdated,
    super.autoUpdate,
  });

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    // 处理 action 字段
    RuleAction action = RuleAction.fromString(map['action']);
    
    return SubscriptionModel(
      id: map['id'],
      name: map['name'],
      url: Url.fromString(map['url']),
      isEnabled: map['isEnabled'] == 1,
      action: action,
      lastUpdated: DateTime.parse(map['lastUpdated']),
      autoUpdate: map['autoUpdate'] == 1,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'action': action.toString(),
        'table_type': 'phone', // 添加默认类型
      });
  }

  @override
  Subscription toEntity() {
    return Subscription(
      id: id,
      name: name,
      url: url,
      isEnabled: isEnabled,
      action: action,
      lastUpdated: lastUpdated,
      autoUpdate: autoUpdate,
    );
  }
}

// 联系人订阅模型（继承基础模型，不包含action字段）
class ContactSubscriptionModel extends BaseSubscriptionModel<ContactSubscription> {
  final String? contactGroup;

  const ContactSubscriptionModel({
    required super.id,
    required super.name,
    required super.url,
    super.isEnabled,
    required super.lastUpdated,
    super.autoUpdate,
    this.contactGroup,
  });

  factory ContactSubscriptionModel.fromMap(Map<String, dynamic> map) {
    return ContactSubscriptionModel(
      id: map['id'],
      name: map['name'],
      url: Url.fromString(map['url']),
      isEnabled: map['isEnabled'] == 1,
      lastUpdated: DateTime.parse(map['lastUpdated']),
      autoUpdate: map['autoUpdate'] == 1,
      contactGroup: map['contact_group'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'contact_group': contactGroup,
        'table_type': 'contact'
      });
  }
  
  @override
  ContactSubscription toEntity() {
    return ContactSubscription(
      id: id,
      name: name,
      url: url,
      isEnabled: isEnabled,
      lastUpdated: lastUpdated,
      autoUpdate: autoUpdate,
    );
  }
}

// 短信订阅模型（继承标准订阅模型，包含action字段）
class SmsSubscriptionModel extends SubscriptionModel {
  final bool isNumberType;

  const SmsSubscriptionModel({
    required super.id,
    required super.name,
    required super.url,
    super.isEnabled,
    required super.lastUpdated,
    super.autoUpdate,
    required super.action,
    this.isNumberType = true,
  });

  factory SmsSubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SmsSubscriptionModel(
      id: map['id'],
      name: map['name'],
      url: Url.fromString(map['url']),
      isEnabled: map['isEnabled'] == 1,
      lastUpdated: DateTime.parse(map['lastUpdated']),
      autoUpdate: map['autoUpdate'] == 1,
      action: RuleAction.fromString(map['action']),
      isNumberType: map['isNumberType'] == 1,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'isNumberType': isNumberType ? 1 : 0,
        'table_type': 'sms'
      });
  }
  
  @override
  Subscription toEntity() {
    return Subscription(
      id: id,
      name: name,
      url: url,
      isEnabled: isEnabled,
      action: action,
      lastUpdated: lastUpdated,
      autoUpdate: autoUpdate,
    );
  }
}