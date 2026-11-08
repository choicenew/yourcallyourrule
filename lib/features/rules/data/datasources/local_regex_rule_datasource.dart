import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/rules/data/models/phone_rule_model.dart';

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

  Future<String> _save(PhoneRuleEntity rule) async {
    final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    final companion = PhoneRuleModelMapper.toRegexRulesCompanion(rule);
    final companionWithId = companion.copyWith(id: Value(id));
    await _database.into(_database.regexRules).insertOnConflictUpdate(companionWithId);
    return id;
  }

  Future<List<PhoneRuleEntity>> getAll() async {
    final results = await _database.select(_database.regexRules).get();
    return results.map(PhoneRuleModelMapper.fromRegexRuleData).toList();
  }

  Future<PhoneRuleEntity?> getById(String id) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result != null ? PhoneRuleModelMapper.fromRegexRuleData(result) : null;
  }

  Future<String> insert(PhoneRuleEntity model) async {
    return _save(model);
  }
  
  Future<String> save(PhoneRuleEntity rule) async {
    return _save(rule);
  }

  Future<int> update(PhoneRuleEntity rule) async {
    final companion = PhoneRuleModelMapper.toRegexRulesCompanion(rule);
    final updatedRows = await (_database.update(_database.regexRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
    return updatedRows;
  }
  
  Future<int> delete(String id) async {
    return await (_database.delete(_database.regexRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  Future<List<String>> insertAll(List<PhoneRuleEntity> models) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final rule in models) {
        final id = rule.id.isEmpty ? _uuid.v4() : rule.id;
        ids.add(id);
        final companion = PhoneRuleModelMapper.toRegexRulesCompanion(rule);
        final companionWithId = companion.copyWith(id: Value(id));
        batch.insert(
          _database.regexRules,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }
  
  Future<List<String>> saveAll(List<PhoneRuleEntity> rules) async {
    return insertAll(rules);
  }

  Future<int> updateAll(List<PhoneRuleEntity> rules) async {
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.regexRules,
          PhoneRuleModelMapper.toRegexRulesCompanion(rule),
          where: (tbl) => tbl.id.equals(rule.id),
        );
      }
    });
    return rules.length;
  }

  Future<int> deleteAll(List<String> ids) async {
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
      final List<PhoneRuleEntity> rules = maps.map((map) => PhoneRuleEntity.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<PhoneRuleEntity?> getByPattern(String pattern) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.pattern.equals(pattern))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result != null ? PhoneRuleModelMapper.fromRegexRuleData(result) : null;
  }

  Future<List<PhoneRuleEntity>> getEnabledRules() async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.isEnabled.equals(1));
    final results = await query.get();
    return results.map(PhoneRuleModelMapper.fromRegexRuleData).toList();
  }

  Future<List<PhoneRuleEntity>> getDisabledRules() async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.isEnabled.equals(0));
    final results = await query.get();
    return results.map(PhoneRuleModelMapper.fromRegexRuleData).toList();
  }

  Future<List<PhoneRuleEntity>> getByPriority(int priority) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.priority.equals(priority));
    final results = await query.get();
    return results.map(PhoneRuleModelMapper.fromRegexRuleData).toList();
  }

  Future<List<PhoneRuleEntity>> searchByName(String name) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.name.like('%$name%'));
    final results = await query.get();
    return results.map(PhoneRuleModelMapper.fromRegexRuleData).toList();
  }
}