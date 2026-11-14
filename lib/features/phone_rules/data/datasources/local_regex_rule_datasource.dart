import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_regex_rule_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalRegexRuleDataSource localRegexRuleDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalRegexRuleDataSource(db);
}

class LocalRegexRuleDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalRegexRuleDataSource(this._database);

  RegexRulesCompanion _toCompanion(RegexRuleEntity rule, String id) {
    return RegexRulesCompanion.insert(
      id: Value(id),
      name: rule.name,
      ruleType: 'regex',
      pattern: rule.pattern,
      action: Value(rule.actionType),
      priority: Value(rule.priority),
      isEnabled: Value(rule.isEnabled),
      subscriptionId: Value(rule.subscriptionId),
    );
  }

  Future<String> save(RegexRuleEntity rule) async {
    final id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    final companion = _toCompanion(rule, id);
    await _database.into(_database.regexRules).insertOnConflictUpdate(companion);
    return id;
  }

  Future<List<RegexRuleEntity>> getAll() async {
    final data = await _database.select(_database.regexRules).get();
    return data;
  }

  Future<RegexRuleEntity?> getById(String id) async {
    final query = _database.select(_database.regexRules)..where((tbl) => tbl.id.equals(id));
    final data = await query.getSingleOrNull();
    return data;
  }

  Future<void> deleteById(String id) async {
    await (_database.delete(_database.regexRules)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return;
    await (_database.delete(_database.regexRules)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  Future<void> updateStatus(String id, bool isEnabled) async {
    await (_database.update(_database.regexRules)..where((tbl) => tbl.id.equals(id)))
        .write(RegexRulesCompanion(isEnabled: Value(isEnabled)));
  }

  Future<String> exportData() async {
    final rules = await getAll();
    final List<Map<String, dynamic>> ruleMaps = rules.map((rule) => rule.toMap()).toList();
    return jsonEncode(ruleMaps);
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> ruleMaps = jsonDecode(data) as List<dynamic>;
      final List<RegexRuleEntity> rules = ruleMaps
          .map((map) => RegexRuleEntity.fromMap(map as Map<String, dynamic>))
          .toList();
      for (final rule in rules) {
        await save(rule);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
