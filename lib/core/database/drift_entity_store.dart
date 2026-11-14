import 'dart:async';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/core/database/entity_store.dart';

import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';

/// 基于 Drift 数据库的通用 EntityStore 抽象代理 (100% 对齐 Protocol 微包强实体)
class DriftEntityStore<T> implements EntityStore<T> {
  final LocalDatabase db;
  final Uuid uuid = const Uuid();

  DriftEntityStore(this.db);

  @override
  Future<List<T>> getAll() async {
    if (T == PhoneRuleEntity) {
      final rows = await db.select(db.phoneRules).get();
      return rows.cast<T>();
    } else if (T == RegexRuleEntity) {
      final rows = await db.select(db.regexRules).get();
      return rows.cast<T>();
    } else if (T == CallLogEntry) {
      final rows = await db.select(db.callHistory).get();
      return rows.cast<T>();
    } else if (T == PhoneContactEntry) {
      final rows = await db.select(db.contacts).get();
      return rows.cast<T>();
    } else if (T == LabelPhoneEntry) {
      final rows = await db.select(db.labelPhones).get();
      return rows.cast<T>();
    } else if (T == SimSlotRuleEntity) {
      final rows = await db.select(db.simSlotRules).get();
      return rows.cast<T>();
    } else if (T == PhoneSubscriptionPayload) {
      final rows = await (db.select(db.rules)..where((tbl) => tbl.ruleType.equals('subscription'))).get();
      return rows.map((r) => PhoneSubscriptionPayload(
        payloadId: r.id,
        kind: PhoneSubscriptionKind.rulesManifest,
        rawJsonMap: {
          'displayName': r.name,
          'downloadUrl': r.phoneNumber,
        },
      )).toList().cast<T>();
    }
    throw UnsupportedError('Unsupported entity type for DriftEntityStore: $T');
  }

  @override
  Future<T?> getById(String id) async {
    final all = await getAll();
    try {
      return all.firstWhere((item) => (item as dynamic)?.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(T entity) async {
    if (entity is PhoneRuleEntity) {
      final rule = entity;
      final companion = PhoneRulesCompanion(
        id: Value(rule.id.isEmpty ? uuid.v4() : rule.id),
        name: Value(rule.name),
        ruleType: const Value('phone'),
        phoneNumber: Value(rule.phoneNumber),
        action: Value(rule.actionType),
        priority: Value(rule.priority),
        count: Value(rule.count),
        isEnabled: Value(rule.isEnabled),
        labelId: Value(rule.labelId),
        avatar: Value(rule.avatar),
        subscriptionId: Value(rule.subscriptionId),
      );
      await db.into(db.phoneRules).insertOnConflictUpdate(companion);
      return;
    } else if (entity is RegexRuleEntity) {
      final rule = entity;
      final companion = RegexRulesCompanion(
        id: Value(rule.id.isEmpty ? uuid.v4() : rule.id),
        name: Value(rule.name),
        ruleType: const Value('regex'),
        pattern: Value(rule.pattern),
        action: Value(rule.actionType),
        priority: Value(rule.priority),
        isEnabled: Value(rule.isEnabled),
        subscriptionId: Value(rule.subscriptionId),
      );
      await db.into(db.regexRules).insertOnConflictUpdate(companion);
      return;
    } else if (entity is CallLogEntry) {
      final log = entity;
      final companion = CallHistoryCompanion(
        id: Value(log.id.isEmpty ? uuid.v4() : log.id),
        phoneNumber: Value(log.phoneNumber),
        name: Value(log.name),
        callType: Value(log.callType),
        timestamp: Value(log.timestamp),
        duration: Value(log.durationSeconds),
        carrierName: Value(log.location),
      );
      await db.into(db.callHistory).insertOnConflictUpdate(companion);
      return;
    } else if (entity is PhoneContactEntry) {
      final contact = entity;
      final companion = ContactsCompanion(
        id: Value(contact.id.isEmpty ? uuid.v4() : contact.id),
        name: Value(contact.name),
        phoneNumber: Value(contact.phoneNumber),
        avatar: Value(contact.avatar),
        url: Value(contact.url),
        note: Value(contact.note),
        labelIds: Value(contact.labelIds),
        isFavorite: Value(contact.isFavorite),
        lastUpdated: Value(contact.lastUpdated),
      );
      await db.into(db.contacts).insertOnConflictUpdate(companion);
      return;
    } else if (entity is LabelPhoneEntry) {
      final label = entity;
      final companion = LabelPhonesCompanion(
        id: Value(label.id.isEmpty ? uuid.v4() : label.id),
        name: Value(label.name),
        phoneNumber: Value(label.phoneNumber),
        labelId: Value(label.labelId),
        avatar: Value(label.avatar),
        icon: Value(label.icon),
        priority: Value(label.priority),
        isEnabled: Value(label.isEnabled),
      );
      await db.into(db.labelPhones).insertOnConflictUpdate(companion);
      return;
    } else if (entity is SimSlotRuleEntity) {
      final rule = entity;
      final companion = SimSlotRulesCompanion.insert(
        id: rule.id.isEmpty ? uuid.v4() : rule.id,
        name: rule.name,
        priority: rule.priority,
        action: rule.actionType,
        isEnabled: Value(rule.isEnabled ? 1 : 0),
        phoneNumber: rule.phoneNumber,
        simSlotIndex: rule.simSlotIndex,
        labelId: rule.labelId,
        avatar: Value(rule.avatar),
      );
      await db.into(db.simSlotRules).insertOnConflictUpdate(companion);
      return;
    }
  }

  @override
  Future<void> saveAll(List<T> entities) async {
    for (final entity in entities) {
      await save(entity);
    }
  }

  @override
  Future<void> update(T entity) async {
    await save(entity);
  }

  @override
  Future<int> delete(String id) async {
    if (T == PhoneRuleEntity) {
      return await (db.delete(db.phoneRules)..where((tbl) => tbl.id.equals(id))).go();
    } else if (T == RegexRuleEntity) {
      return await (db.delete(db.regexRules)..where((tbl) => tbl.id.equals(id))).go();
    } else if (T == CallLogEntry) {
      return await (db.delete(db.callHistory)..where((tbl) => tbl.id.equals(id))).go();
    } else if (T == PhoneContactEntry) {
      return await (db.delete(db.contacts)..where((tbl) => tbl.id.equals(id))).go();
    } else if (T == LabelPhoneEntry) {
      return await (db.delete(db.labelPhones)..where((tbl) => tbl.id.equals(id))).go();
    } else if (T == SimSlotRuleEntity) {
      return await (db.delete(db.simSlotRules)..where((tbl) => tbl.id.equals(id))).go();
    }
    return 0;
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    int total = 0;
    for (final id in ids) {
      total += await delete(id);
    }
    return total;
  }

  @override
  Future<int> clear() async {
    if (T == PhoneRuleEntity) {
      return await db.delete(db.phoneRules).go();
    } else if (T == RegexRuleEntity) {
      return await db.delete(db.regexRules).go();
    } else if (T == CallLogEntry) {
      return await db.delete(db.callHistory).go();
    } else if (T == PhoneContactEntry) {
      return await db.delete(db.contacts).go();
    } else if (T == LabelPhoneEntry) {
      return await db.delete(db.labelPhones).go();
    } else if (T == SimSlotRuleEntity) {
      return await db.delete(db.simSlotRules).go();
    }
    return 0;
  }

  @override
  Future<int> count() async {
    final list = await getAll();
    return list.length;
  }

  @override
  Stream<List<T>> watchAll() {
    if (T == PhoneRuleEntity) {
      return db.select(db.phoneRules).watch().map((rows) => rows.cast<T>());
    } else if (T == RegexRuleEntity) {
      return db.select(db.regexRules).watch().map((rows) => rows.cast<T>());
    } else if (T == CallLogEntry) {
      return db.select(db.callHistory).watch().map((rows) => rows.cast<T>());
    } else if (T == PhoneContactEntry) {
      return db.select(db.contacts).watch().map((rows) => rows.cast<T>());
    } else if (T == LabelPhoneEntry) {
      return db.select(db.labelPhones).watch().map((rows) => rows.cast<T>());
    }
    return Stream.value([]);
  }
}

/// 基于 Drift 的全局 EntityStoreFactory 实现
class DriftEntityStoreFactory implements EntityStoreFactory {
  final LocalDatabase db;
  DriftEntityStoreFactory(this.db);

  @override
  EntityStore<T> createStore<T>() {
    return DriftEntityStore<T>(db);
  }
}
