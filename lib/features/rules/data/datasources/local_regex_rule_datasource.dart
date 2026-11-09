import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_regex_rule_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalRegexRuleDataSource localRegexRuleDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localRegexRuleDataSource;
}

class LocalRegexRuleDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalRegexRuleDataSource(this._database);

  RegexRulesCompanion _toCompanion(RegexRuleEntity rule) {
    final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    return RegexRulesCompanion.insert(
      id: Value(id),
      name: rule.name,
      ruleType: 'regex',
      pattern: rule.pattern,
      action: Value(rule.actionType),
      priority: Value(rule.priority),
      isEnabled: Value(rule.isEnabled ? 1 : 0),
      subscriptionId: Value(rule.subscriptionId),
    );
  }

  Future<String> _save(RegexRuleEntity rule) async {
    final companion = _toCompanion(rule);
    await _database.into(_database.regexRules).insertOnConflictUpdate(companion);
    return companion.id.value ?? '';
  }

  Future<List<RegexRuleEntity>> getAll() async {
    return await _database.select(_database.regexRules).get();
  }

  Future<RegexRuleEntity?> getById(String id) async {
    return await (_database.select(_database.regexRules)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
  }

  Future<String> insert(RegexRuleEntity model) async {
    return _save(model);
  }

  Future<String> save(RegexRuleEntity rule) async {
    return _save(rule);
  }

  Future<int> update(RegexRuleEntity rule) async {
    final companion = _toCompanion(rule);
    return await (_database.update(_database.regexRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.regexRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  Future<List<String>> insertAll(List<RegexRuleEntity> models) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final rule in models) {
        final companion = _toCompanion(rule);
        ids.add(companion.id.value ?? '');
        batch.insert(
          _database.regexRules,
          companion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }

  Future<List<String>> saveAll(List<RegexRuleEntity> rules) async {
    return insertAll(rules);
  }

  Future<int> updateAll(List<RegexRuleEntity> rules) async {
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.regexRules,
          _toCompanion(rule),
          where: (tbl) => tbl.id.equals(rule.id),
        );
      }
    });
    return rules.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.regexRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }

  Future<void> clear() async {
    await _database.delete(_database.regexRules).go();
  }

  Future<int> deleteAllRecords() async {
    return await _database.delete(_database.regexRules).go();
  }

  Future<int> count() async {
    final countExp = _database.regexRules.id.count();
    final query = _database.selectOnly(_database.regexRules)..addColumns([countExp]);
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }

  Future<String> exportData() async {
    final rules = await getAll();
    final List<Map<String, dynamic>> maps = rules.map((rule) => rule.toMap()).toList();
    return jsonEncode(maps);
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data) as List<dynamic>;
      final List<RegexRuleEntity> rules = maps.map((map) => RegexRuleEntity.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<RegexRuleEntity?> getByPattern(String pattern) async {
    return await (_database.select(_database.regexRules)
      ..where((tbl) => tbl.pattern.equals(pattern))
      ..limit(1))
      .getSingleOrNull();
  }

  Future<List<RegexRuleEntity>> getEnabledRules() async {
    return await (_database.select(_database.regexRules)
      ..where((tbl) => tbl.isEnabled.equals(1)))
      .get();
  }

  Future<List<RegexRuleEntity>> getDisabledRules() async {
    return await (_database.select(_database.regexRules)
      ..where((tbl) => tbl.isEnabled.equals(0)))
      .get();
  }

  Future<List<RegexRuleEntity>> getByPriority(int priority) async {
    return await (_database.select(_database.regexRules)
      ..where((tbl) => tbl.priority.equals(priority)))
      .get();
  }

  Future<List<RegexRuleEntity>> searchByName(String name) async {
    return await (_database.select(_database.regexRules)
      ..where((tbl) => tbl.name.like('%$name%')))
      .get();
  }
}
