import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_phone_rule_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalPhoneRuleDataSource localPhoneRuleDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localPhoneRuleDataSource;
}

class LocalPhoneRuleDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalPhoneRuleDataSource(this._database);

  PhoneRulesCompanion _toCompanion(PhoneRuleEntity rule) {
    final id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    return PhoneRulesCompanion.insert(
      id: Value(id),
      name: rule.name,
      ruleType: 'phone',
      phoneNumber: rule.phoneNumber,
      action: Value(rule.actionType),
      priority: Value(rule.priority),
      count: Value(rule.count),
      isEnabled: Value(rule.isEnabled ? 1 : 0),
      labelId: Value(rule.labelId),
      avatar: Value(rule.avatar),
      subscriptionId: Value(rule.subscriptionId),
    );
  }

  Future<String> _save(PhoneRuleEntity rule) async {
    final companion = _toCompanion(rule);
    await _database.into(_database.phoneRules).insertOnConflictUpdate(companion);
    return companion.id.value ?? '';
  }

  Future<List<PhoneRuleEntity>> getAll() async {
    return await _database.select(_database.phoneRules).get();
  }

  Future<String> insert(PhoneRuleEntity model) async {
    return _save(model);
  }

  Future<List<String>> insertAll(List<PhoneRuleEntity> models) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final model in models) {
        final companion = _toCompanion(model);
        ids.add(companion.id.value ?? '');
        batch.insert(
          _database.phoneRules,
          companion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }

  Future<void> clear() async {
    await _database.delete(_database.phoneRules).go();
  }

  Future<String> exportData() async {
    final rules = await getAll();
    final List<Map<String, dynamic>> maps = rules.map((rule) => rule.toMap()).toList();
    return jsonEncode(maps);
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data) as List<dynamic>;
      final List<PhoneRuleEntity> rules = maps.map((map) => PhoneRuleEntity.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<PhoneRuleEntity?> getById(String id) async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
  }

  Future<String> save(PhoneRuleEntity rule) async {
    return _save(rule);
  }

  Future<int> update(PhoneRuleEntity rule) async {
    final companion = _toCompanion(rule);
    return await (_database.update(_database.phoneRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.phoneRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  Future<List<String>> saveAll(List<PhoneRuleEntity> rules) async {
    return insertAll(rules);
  }

  Future<int> updateAll(List<PhoneRuleEntity> rules) async {
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.phoneRules,
          _toCompanion(rule),
          where: (tbl) => tbl.id.equals(rule.id),
        );
      }
    });
    return rules.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.phoneRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }

  Future<int> deleteAllRecords() async {
    return await _database.delete(_database.phoneRules).go();
  }

  Future<int> count() async {
    final countExp = _database.phoneRules.id.count();
    final query = _database.selectOnly(_database.phoneRules)..addColumns([countExp]);
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }

  Future<PhoneRuleEntity?> getByPhoneNumber(String phoneNumber) async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
      ..limit(1))
      .getSingleOrNull();
  }

  Future<List<PhoneRuleEntity>> getEnabledRules() async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.isEnabled.equals(1)))
      .get();
  }

  Future<List<PhoneRuleEntity>> getDisabledRules() async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.isEnabled.equals(0)))
      .get();
  }

  Future<List<PhoneRuleEntity>> getByPriority(int priority) async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.priority.equals(priority)))
      .get();
  }

  Future<List<PhoneRuleEntity>> searchByName(String name) async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.name.like('%$name%')))
      .get();
  }

  Future<List<PhoneRuleEntity>> searchByNamePrefix(String prefix) async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.name.like('$prefix%')))
      .get();
  }

  Future<List<PhoneRuleEntity>> getSubscribedRules() async {
    return await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.subscriptionId.isNotNull()))
      .get();
  }
}
