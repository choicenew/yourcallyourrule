import 'package:drift/drift.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:uuid/uuid.dart';

class LocalStorageService {
  final LocalDatabase _db;

  LocalStorageService(this._db);

  // ---------------------------
  // Rules
  // ---------------------------
  Future<void> saveRules(List<RuleBase> rules) async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.rules).go();
        await _db.delete(_db.phoneRules).go();
        await _db.delete(_db.regexRules).go();
        await _db.delete(_db.smsRules).go();

        final uuid = const Uuid();

        // 使用 batch 提升插入效率
        await _db.batch((batch) {
          for (final rule in rules) {
            final map = CloudDataConverter.serialize(rule);
            // 根据 ruleType 分发到不同的表
            final ruleType = map['ruleType'] ?? rule.runtimeType.toString();

            if (rule is PhoneRule || ruleType == 'phone_rule') {
              final id = map['id'] ?? uuid.v4();
              batch.insert(
                _db.phoneRules,
                PhoneRulesCompanion(
                  id: Value(id),
                  name: Value(map['name'] ?? 'Unnamed')
                  ,
                  ruleType: Value('phone_rule'),
                  phoneNumber: Value(map['phoneNumber'] ?? ''),
                  labelId: Value(map['labelId']),
                  priority: Value(map['priority'] ?? 5),
                  action: Value(map['action'] ?? 'none'),
                  isEnabled: Value((map['isEnabled'] ?? 1) is bool
                      ? ((map['isEnabled'] ?? true) ? 1 : 0)
                      : (map['isEnabled'] ?? 1)),
                  count: Value(map['count'] ?? 0),
                  avatar: Value(map['avatar']),
                  subscriptionId: Value(map['subscriptionId']),
                ),
                mode: InsertMode.insertOrReplace,
              );
              continue;
            }

            if (rule is RegexRule || ruleType == 'regex') {
              final id = map['id'] ?? uuid.v4();
              batch.insert(
                _db.regexRules,
                RegexRulesCompanion(
                  id: Value(id),
                  name: Value(map['name'] ?? 'Unnamed'),
                  ruleType: Value('regex'),
                  pattern: Value(map['pattern'] ?? ''),
                  priority: Value(map['priority'] ?? 5),
                  action: Value(map['action'] ?? 'none'),
                  isEnabled: Value((map['isEnabled'] ?? 1) is bool
                      ? ((map['isEnabled'] ?? true) ? 1 : 0)
                      : (map['isEnabled'] ?? 1)),
                  subscriptionId: Value(map['subscriptionId']),
                ),
                mode: InsertMode.insertOrReplace,
              );
              continue;
            }

            if (rule is SmsRegexRule || ruleType == 'sms_regex') {
              final id = map['id'] ?? uuid.v4();
              batch.insert(
                _db.smsRules,
                SmsRulesCompanion(
                  id: Value(id),
                  name: Value(map['name'] ?? 'Unnamed'),
                  contentRegex: Value(map['contentRegex'] ?? map['pattern'] ?? ''),
                  senderRegex: Value(map['senderRegex']),
                  action: Value(map['action'] ?? 'none'),
                  priority: Value(map['priority'] ?? 5),
                  isEnabled: Value((map['isEnabled'] ?? 1) is bool
                      ? ((map['isEnabled'] ?? true) ? 1 : 0)
                      : (map['isEnabled'] ?? 1)),
                  ruleType: Value('sms_regex'),
                ),
                mode: InsertMode.insertOrReplace,
              );
              continue;
            }

            // 其他规则类型统一写入通用 Rules 表
            final id = map['id'] ?? uuid.v4();
            batch.insert(
              _db.rules,
              RulesCompanion(
                id: Value(id),
                name: Value(map['name'] ?? 'Unnamed'),
                ruleType: Value(map['ruleType'] ?? rule.runtimeType.toString()),
                phoneNumber: Value(map['contactId'] ?? map['phoneNumber']),
                labelId: Value(map['labelId']),
                priority: Value(map['priority'] ?? 5),
                action: Value(map['action'] ?? 'none'),
                isEnabled: Value((map['isEnabled'] ?? 1) is bool
                    ? ((map['isEnabled'] ?? true) ? 1 : 0)
                    : (map['isEnabled'] ?? 1)),
                pattern: Value(map['pattern']),
                avatar: Value(map['avatar']),
                isSubscribed: Value((map['isSubscribed'] ?? 0) is bool
                    ? ((map['isSubscribed'] ?? false) ? 1 : 0)
                    : (map['isSubscribed'] ?? 0)),
                count: Value(map['count'] ?? 0),
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
      });
    } catch (e) {
      // 保持完整错误处理：抛出异常以便上层可感知失败
      throw Exception('Failed to save rules: $e');
    }
  }

  Future<List<RuleBase>> loadRules() async {
    final List<RuleBase> result = [];
    try {
      // Phone rules
      final phoneRows = await _db.select(_db.phoneRules).get();
      for (final r in phoneRows) {
        final map = {
          'id': r.id ?? const Uuid().v4(),
          'name': r.name,
          'priority': r.priority,
          'action': r.action,
          'isEnabled': r.isEnabled,
          'phoneNumber': r.phoneNumber,
          'labelId': r.labelId,
          'count': r.count,
          'avatar': r.avatar,
          'ruleType': 'phone_rule',
          '_type': 'PhoneRule',
          'subscriptionId': r.subscriptionId,
        };
        result.add(CloudDataConverter.deserialize<RuleBase>(map));
      }

      // Regex rules
      final regexRows = await _db.select(_db.regexRules).get();
      for (final r in regexRows) {
        final map = {
          'id': r.id ?? const Uuid().v4(),
          'name': r.name,
          'pattern': r.pattern,
          'priority': r.priority,
          'action': r.action,
          'isEnabled': r.isEnabled,
          'ruleType': 'regex',
          '_type': 'RegexRule',
          'subscriptionId': r.subscriptionId,
        };
        result.add(CloudDataConverter.deserialize<RuleBase>(map));
      }

      // Sms regex rules
      final smsRows = await _db.select(_db.smsRules).get();
      for (final r in smsRows) {
        final map = {
          'id': r.id,
          'name': r.name,
          'contentRegex': r.contentRegex,
          'senderRegex': r.senderRegex,
          'action': r.action,
          'priority': r.priority,
          'isEnabled': r.isEnabled,
          'ruleType': 'sms_regex',
          '_type': 'sms_regex',
        };
        result.add(CloudDataConverter.deserialize<RuleBase>(map));
      }

      // General rules (ContactRule / AllowedBlockedRule 等)
      final generalRows = await _db.select(_db.rules).get();
      for (final r in generalRows) {
        // 将 ruleType 映射到 CloudDataConverter 需要的 _type
        String typeForConverter;
        switch (r.ruleType) {
          case 'allow_block':
            typeForConverter = 'AllowedBlockedRule';
            break;
          case 'contact':
            typeForConverter = 'ContactRule';
            break;
          case 'phone_rule':
            typeForConverter = 'PhoneRule';
            break;
          case 'regex':
            typeForConverter = 'RegexRule';
            break;
          case 'sms_regex':
            typeForConverter = 'sms_regex';
            break;
          default:
            // 未知类型，跳过以保证健壮性
            continue;
        }

        final map = {
          'id': r.id,
          'name': r.name,
          'priority': r.priority,
          'action': r.action,
          'isEnabled': r.isEnabled,
          // contactId 使用 phoneNumber 列承载
          'contactId': r.phoneNumber,
          'phoneNumber': r.phoneNumber,
          'labelId': r.labelId,
          'pattern': r.pattern,
          'avatar': r.avatar,
          'isSubscribed': r.isSubscribed,
          'count': r.count,
          'ruleType': r.ruleType,
          '_type': typeForConverter,
        };
        result.add(CloudDataConverter.deserialize<RuleBase>(map));
      }

      return result;
    } catch (e) {
      throw Exception('Failed to load rules: $e');
    }
  }

  // ---------------------------
  // Subscriptions
  // ---------------------------
  Future<void> saveSubscription(Subscription subscription) async {
    try {
      final map = CloudDataConverter.serialize(subscription);
      await _db.into(_db.subscriptions).insert(
        SubscriptionsCompanion(
          id: Value(map['id'] ?? const Uuid().v4()),
          name: Value(map['name'] ?? 'Unnamed'),
          url: Value(map['url'] ?? ''),
          table_type: Value(map['table_type'] ?? map['type'] ?? 'generic'),
          isEnabled: Value((map['isEnabled'] ?? 1) is bool
              ? ((map['isEnabled'] ?? true) ? 1 : 0)
              : (map['isEnabled'] ?? 1)),
          lastUpdated: Value(map['lastUpdated'] ?? DateTime.now().toIso8601String()),
          autoUpdate: Value((map['autoUpdate'] ?? 0) is bool
              ? ((map['autoUpdate'] ?? false) ? 1 : 0)
              : (map['autoUpdate'] ?? 0)),
          contact_group: Value(map['contact_group']),
          keyword_filters: Value(map['keyword_filters']),
          action: Value(map['action'] ?? 'none'),
        ),
        mode: InsertMode.insertOrReplace,
      );
    } catch (e) {
      throw Exception('Failed to save subscription: $e');
    }
  }

  Future<List<Subscription>> loadSubscriptions() async {
    try {
      final rows = await _db.select(_db.subscriptions).get();
      return rows.map((r) {
        final map = {
          'id': r.id,
          'name': r.name,
          'url': r.url,
          'table_type': r.table_type,
          'isEnabled': r.isEnabled,
          'lastUpdated': r.lastUpdated,
          'autoUpdate': r.autoUpdate,
          'contact_group': r.contact_group,
          'keyword_filters': r.keyword_filters,
          'action': r.action,
        };
        return CloudDataConverter.deserialize<Subscription>(map);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load subscriptions: $e');
    }
  }

  // ---------------------------
  // Contacts
  // ---------------------------
  Future<void> saveContacts(List<Contact> contacts) async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.contacts).go();
        await _db.batch((batch) {
          for (final c in contacts) {
            final m = CloudDataConverter.serialize(c);
            batch.insert(
              _db.contacts,
              ContactsCompanion(
                id: Value(m['id'] ?? const Uuid().v4()),
                phoneNumber: Value(m['phoneNumber'] ?? ''),
                name: Value(m['name'] ?? 'Unnamed'),
                avatar: Value(m['avatar']),
                url: Value(m['url']),
                note: Value(m['note']),
                labelIds: Value(m['labelIds']),
                isFavorite: Value((m['isFavorite'] ?? 0) is bool
                    ? ((m['isFavorite'] ?? false) ? 1 : 0)
                    : (m['isFavorite'] ?? 0)),
                lastUpdated: Value(m['lastUpdated'] ?? DateTime.now().toIso8601String()),
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
      });
    } catch (e) {
      throw Exception('Failed to save contacts: $e');
    }
  }

  Future<List<Contact>> loadContacts() async {
    try {
      final rows = await _db.select(_db.contacts).get();
      return rows.map((r) {
        final map = {
          'id': r.id,
          'phoneNumber': r.phoneNumber,
          'name': r.name,
          'avatar': r.avatar,
          'url': r.url,
          'note': r.note,
          'labelIds': r.labelIds,
          'isFavorite': r.isFavorite,
          'lastUpdated': r.lastUpdated,
        };
        return CloudDataConverter.deserialize<Contact>(map);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load contacts: $e');
    }
  }

  // ---------------------------
  // Plugins
  // ---------------------------
  Future<void> savePlugins(List<PluginEntry> plugins) async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.plugins).go();
        await _db.batch((batch) {
          for (final p in plugins) {
            final m = CloudDataConverter.serialize(p);
            batch.insert(
              _db.plugins,
              PluginsCompanion(
                id: Value(m['id'] ?? const Uuid().v4()),
                name: Value(m['name'] ?? 'Plugin'),
                url: Value(m['url'] ?? ''),
                version: Value(m['version'] ?? '1.0.0'),
                description: Value(m['description']),
                isEnabled: Value((m['isEnabled'] ?? 1) is bool
                    ? ((m['isEnabled'] ?? true) ? 1 : 0)
                    : (m['isEnabled'] ?? 1)),
                pluginOrder: Value(m['pluginOrder'] ?? 0),
                isAutoUpdate: Value((m['isAutoUpdate'] ?? 0) is bool
                    ? ((m['isAutoUpdate'] ?? false) ? 1 : 0)
                    : (m['isAutoUpdate'] ?? 0)),
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
      });
    } catch (e) {
      throw Exception('Failed to save plugins: $e');
    }
  }

  Future<List<PluginEntry>> loadPlugins() async {
    try {
      final rows = await _db.select(_db.plugins).get();
      return rows.map((r) {
        final map = {
          'id': r.id,
          'name': r.name,
          'url': r.url,
          'version': r.version,
          'description': r.description,
          'isEnabled': r.isEnabled,
          'pluginOrder': r.pluginOrder,
          'isAutoUpdate': r.isAutoUpdate,
        };
        return CloudDataConverter.deserialize<PluginEntry>(map);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load plugins: $e');
    }
  }

  // ---------------------------
  // Call Logs
  // ---------------------------
  Future<void> saveCallLogs(List<CallLog> logs) async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.callHistory).go();
        await _db.batch((batch) {
          for (final l in logs) {
            final m = CloudDataConverter.serialize(l);
            batch.insert(
              _db.callHistory,
              CallHistoryCompanion(
                id: Value(m['id'] ?? const Uuid().v4()),
                phoneNumber: Value(m['phoneNumber'] ?? ''),
                name: Value(m['name']),
                timestamp: Value(m['timestamp'] ?? DateTime.now().toIso8601String()),
                endTime: Value(m['endTime']),
                duration: Value(m['duration']),
                simDisplayName: Value(m['simDisplayName']),
                callType: Value(m['callType'] ?? 'unknown'),
                simSlotIndex: Value(m['simSlotIndex']),
                carrierName: Value(m['carrierName']),
                countryIso: Value(m['countryIso']),
                subscriptionId: Value(m['subscriptionId']),
                labelIds: Value(m['labelIds']),
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
      });
    } catch (e) {
      throw Exception('Failed to save call logs: $e');
    }
  }

  Future<List<CallLog>> loadCallLogs() async {
    try {
      final rows = await _db.select(_db.callHistory).get();
      return rows.map((r) {
        final map = {
          'id': r.id,
          'phoneNumber': r.phoneNumber,
          'name': r.name,
          'timestamp': r.timestamp,
          'endTime': r.endTime,
          'duration': r.duration,
          'simDisplayName': r.simDisplayName,
          'callType': r.callType,
          'simSlotIndex': r.simSlotIndex,
          'carrierName': r.carrierName,
          'countryIso': r.countryIso,
          'subscriptionId': r.subscriptionId,
          'labelIds': r.labelIds,
        };
        return CloudDataConverter.deserialize<CallLog>(map);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load call logs: $e');
    }
  }

  // ---------------------------
  // Labels & Predefined Labels
  // ---------------------------
  Future<void> saveLabels(List<LabelPhoneEntry> labels) async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.labelPhones).go();
        await _db.batch((batch) {
          for (final l in labels) {
            final m = CloudDataConverter.serialize(l);
            batch.insert(
              _db.labelPhones,
              LabelPhonesCompanion(
                id: Value(m['id'] ?? const Uuid().v4()),
                name: Value(m['name']),
                icon: Value(m['icon']),
                phoneNumber: Value(m['phoneNumber'] ?? ''),
                labelId: Value(m['labelId'] ?? ''),
                avatar: Value(m['avatar']),
                priority: Value(m['priority'] ?? 0),
                action: Value(m['action'] ?? 'none'),
                isEnabled: Value((m['isEnabled'] ?? 1) is bool
                    ? ((m['isEnabled'] ?? true) ? 1 : 0)
                    : (m['isEnabled'] ?? 1)),
                ruleType: Value(m['ruleType'] ?? 'label'),
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
      });
    } catch (e) {
      throw Exception('Failed to save labels: $e');
    }
  }

  Future<List<LabelPhoneEntry>> loadLabels() async {
    try {
      final rows = await _db.select(_db.labelPhones).get();
      return rows.map((r) {
        final map = {
          'id': r.id,
          'name': r.name,
          'icon': r.icon,
          'phoneNumber': r.phoneNumber,
          'labelId': r.labelId,
          'avatar': r.avatar,
          'priority': r.priority,
          'action': r.action,
          'isEnabled': r.isEnabled,
          'ruleType': r.ruleType,
        };
        return CloudDataConverter.deserialize<LabelPhoneEntry>(map);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load labels: $e');
    }
  }

  Future<void> savePredefinedLabels(List<PredefinedLabel> labels) async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.predefinedLabels).go();
        await _db.batch((batch) {
          for (final l in labels) {
            final m = CloudDataConverter.serialize(l);
            batch.insert(
              _db.predefinedLabels,
              PredefinedLabelsCompanion(
                id: Value(m['id'] ?? const Uuid().v4()),
                labelText: Value(m['labelText'] ?? m['text'] ?? ''),
                avatar: Value(m['avatar']),
                icon: Value(m['icon']),
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
      });
    } catch (e) {
      throw Exception('Failed to save predefined labels: $e');
    }
  }

  Future<List<PredefinedLabel>> loadPredefinedLabels() async {
    try {
      final rows = await _db.select(_db.predefinedLabels).get();
      return rows.map((r) {
        final map = {
          'id': r.id,
          'labelText': r.labelText,
          'avatar': r.avatar,
          'icon': r.icon,
        };
        return CloudDataConverter.deserialize<PredefinedLabel>(map);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load predefined labels: $e');
    }
  }

  // ---------------------------
  // Locations
  // ---------------------------
  Future<void> saveLocations(List<LocationEntry> locations) async {
    try {
      await _db.transaction(() async {
        await _db.delete(_db.locations).go();
        await _db.batch((batch) {
          for (final l in locations) {
            final m = CloudDataConverter.serialize(l);
            batch.insert(
              _db.locations,
              LocationsCompanion(
                id: Value(m['id'] ?? const Uuid().v4()),
                phoneNumber: Value(m['phoneNumber'] ?? ''),
                region: Value(m['region']),
                countryName: Value(m['countryName']),
                carrier: Value(m['carrier']),
                numberType: Value(m['numberType'] ?? 0),
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
      });
    } catch (e) {
      throw Exception('Failed to save locations: $e');
    }
  }

  Future<List<LocationEntry>> loadLocations() async {
    try {
      final rows = await _db.select(_db.locations).get();
      return rows.map((r) {
        final map = {
          'id': r.id,
          'phoneNumber': r.phoneNumber,
          'region': r.region,
          'countryName': r.countryName,
          'carrier': r.carrier,
          'numberType': r.numberType,
        };
        return CloudDataConverter.deserialize<LocationEntry>(map);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load locations: $e');
    }
  }
}