import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'base_model.dart';
import '../../core/entities/subscription.dart';

// 基础订阅模型（包含全部字段）
class SubscriptionModel extends BaseModel<Subscription> {
  final String name;
  final Url url;
  final bool enabled;
  final bool isWhitelist;
  final bool isBlacklist;
  final DateTime lastUpdated;
  final bool autoUpdate;

  const SubscriptionModel({
    required super.id,
    required this.name,
    required this.url,
    this.enabled = true,
    this.isWhitelist = false,
    this.isBlacklist = false,
    required this.lastUpdated,
    this.autoUpdate = false,
  });

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      id: map['id'],
      name: map['name'],
      url: Url.fromString(map['url']),
      enabled: map['enabled'] == 1,
      isWhitelist: map['isWhitelist'] == 1,
      isBlacklist: map['isBlacklist'] == 1,
      lastUpdated: DateTime.parse(map['lastUpdated']),
      autoUpdate: map['autoUpdate'] == 1,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url.toString(),
      'enabled': enabled ? 1 : 0,
      'isWhitelist': isWhitelist ? 1 : 0,
      'isBlacklist': isBlacklist ? 1 : 0,
      'lastUpdated': lastUpdated.toIso8601String(),
      'autoUpdate': autoUpdate ? 1 : 0,
    };
  }

  @override
  Subscription toEntity() {
    return Subscription(
      id: id,
      name: name,
      url: url,
      isEnabled: enabled,
      isWhitelist: isWhitelist,
      isBlacklist: isBlacklist,
      lastUpdated: lastUpdated,
      autoUpdate: autoUpdate,
    );
  }
}

// 联系人订阅模型（继承基础模型）
class ContactSubscriptionModel extends SubscriptionModel {
  final String? contactGroup;

  const ContactSubscriptionModel({
    required super.id,
    required super.name,
    required super.url,
    super.enabled,
    required super.lastUpdated,
    super.autoUpdate,
    this.contactGroup,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'contact_group': contactGroup,
        'table_type': 'contact'
      });
  }
}

// 短信订阅模型（继承基础模型）
class SmsSubscriptionModel extends SubscriptionModel {
  final bool isNumberType;

  const SmsSubscriptionModel({
    required super.id,
    required super.name,
    required super.url,
    super.enabled,
    required super.lastUpdated,
    super.autoUpdate,
    required super.isWhitelist,
    required super.isBlacklist,
    this.isNumberType = true,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'isNumberType': isNumberType ? 1 : 0,
        'table_type': 'sms'
      });
  }
}