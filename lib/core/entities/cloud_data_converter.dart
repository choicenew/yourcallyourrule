import 'package:yourcallyourrule/core/entities/contact/contact_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/blacklist_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/whitelist_rule.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';

class CloudDataConverter {
  // 通用序列化方法
  static Map<String, dynamic> serialize(dynamic entity) {
    if (entity is RuleBase) {
      return _serializeRule(entity);
    } else if (entity is PluginEntry) {
      return _serializePlugin(entity);
    } else if (entity is SmsSubscription) {
      return _serializeSubscription(entity);
    } else if (entity is Contact) {
      return _serializeContact(entity);
    } else if (entity is CallLog) {
      return _serializeCallLog(entity);
    } else if (entity is LabelEntry) {
      return _serializeLabel(entity);
    } else if (entity is LocationEntry) {
      return _serializeLocation(entity);
    } else if (entity is ListEntry) {
      return _serializeListEntry(entity);
    } else if (entity is ContactSubscription) {
      return _serializeContactSubscription(entity);
    } else if (entity is SmsSubscription) {
      return _serializeSmsSubscription(entity);
    } else if (entity is Subscription) {
      return _serializeGenericSubscription(entity);
    }
    throw ArgumentError('Unsupported entity type: ${entity.runtimeType}');
  }

  // 通用反序列化方法
  static T deserialize<T>(Map<String, dynamic> data) {
    if (T == RuleBase) {
      return _deserializeRule(data) as T;
    } else if (T == PluginEntry) {
      return _deserializePlugin(data) as T;
    } else if (T == SmsSubscription) {
      return _deserializeSmsSubscription(data) as T;
    } else if (T == Contact) {
      return _deserializeContact(data) as T;
    } else if (T == CallLog) {
      return _deserializeCallLog(data) as T;
    } else if (T == LabelEntry) {
      return _deserializeLabel(data) as T;
    } else if (T == LocationEntry) {
      return _deserializeLocation(data) as T;
    } else if (T == ListEntry) {
      return _deserializeListEntry(data) as T;
    } else if (T == ContactSubscription) {
      return _deserializeContactSubscription(data) as T;
    } else if (T == Subscription) {
      return _deserializeSubscription(data) as T;
    }
    throw ArgumentError('Unsupported entity type: $T');
  }

  // 规则序列化
  static Map<String, dynamic> _serializeRule(RuleBase rule) {
    final data = rule.toMap();
    data['_type'] = rule.runtimeType.toString();
    return data;
  }

  // 规则反序列化


  // 插件序列化
  static Map<String, dynamic> _serializePlugin(PluginEntry plugin) {
    return plugin.toMap();
  }

  // 插件反序列化
  static PluginEntry _deserializePlugin(Map<String, dynamic> data) {
    return PluginEntry.fromMap(data);
  }

  // 订阅序列化
  static Map<String, dynamic> _serializeSubscription(SmsSubscription sub) {
    return sub.toMap();
  }

  // SMS订阅序列化
  static Map<String, dynamic> _serializeSmsSubscription(SmsSubscription sub) {
    final data = sub.toMap();
    data['_type'] = 'SmsSubscription';
    return data;
  }

  // 通用订阅序列化
  static Map<String, dynamic> _serializeGenericSubscription(Subscription sub) {
    final data = sub.toMap();
    data['_type'] = sub.runtimeType.toString();
    return data;
  }

  // 新增序列化方法
  static Map<String, dynamic> _serializeContact(Contact contact) => contact.toMap();
  static Map<String, dynamic> _serializeCallLog(CallLog log) => log.toMap();
  static Map<String, dynamic> _serializeLabel(LabelEntry label) => label.toMap();
  static Map<String, dynamic> _serializeLocation(LocationEntry location) => location.toMap();
  static Map<String, dynamic> _serializeListEntry(ListEntry entry) => entry.toMap();
  static Map<String, dynamic> _serializeContactSubscription(ContactSubscription sub) => sub.toMap();

  // 新增反序列化方法
  static Contact _deserializeContact(Map<String, dynamic> data) => Contact.fromMap(data);
  static CallLog _deserializeCallLog(Map<String, dynamic> data) => CallLog.fromMap(data);
  static LabelEntry _deserializeLabel(Map<String, dynamic> data) => LabelEntry.fromMap(data);
  static LocationEntry _deserializeLocation(Map<String, dynamic> data) => LocationEntry.fromMap(data);
  static ListEntry _deserializeListEntry(Map<String, dynamic> data) => ListEntry.fromMap(data);

  static SmsSubscription _deserializeSmsSubscription(Map<String, dynamic> data) {
    return SmsSubscription.fromMap(data);
  }

  // 规则反序列化支持新增类型
  static RuleBase _deserializeRule(Map<String, dynamic> data) {
    final type = data['_type'] as String;
    switch (type) {
      case 'BlockedRule':
        return BlockedRule.fromMap(data);
      case 'AllowedRule':
        return AllowedRule.fromMap(data);
      case 'BlacklistRule':
        return BlacklistRule.fromMap(data);
      case 'WhitelistRule':
        return WhitelistRule.fromMap(data);
      case 'RegexRule':
        return RegexRule.fromMap(data);
      case 'sms_regex':
        return SmsRegexRule.fromMap(data);
      case 'ContactRule':
        return ContactRule.fromMap(data);
      default:
        throw FormatException('Unknown rule type: $type');
    }
  }
  static ContactSubscription _deserializeContactSubscription(Map<String, dynamic> data) => ContactSubscription.fromMap(data);



  static Subscription _deserializeSubscription(Map<String, dynamic> data) {
    return Subscription.fromMap(data);
  }
}