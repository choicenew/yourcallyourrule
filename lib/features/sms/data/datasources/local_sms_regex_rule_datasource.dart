import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_sms_regex_rule_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalSmsRegexRuleDataSource localSmsRegexRuleDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalSmsRegexRuleDataSource(db);
}

class LocalSmsRegexRuleDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalSmsRegexRuleDataSource(this._database);

  SmsRulesCompanion _toCompanion(RegexRuleEntity rule) {
    final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    return SmsRulesCompanion.insert(
      id: id,
      name: rule.name,
      contentRegex: rule.pattern,
      action: rule.actionType,
      priority: Value(rule.priority),
      isEnabled: Value(rule.isEnabled ? 1 : 0),
      ruleType: 'sms_regex',
    );
  }

  RegexRuleEntity _fromData(SmsRuleData data) {
    return RegexRuleEntity(
      id: data.id,
      name: data.name,
      pattern: data.contentRegex,
      actionType: data.action,
      priority: data.priority,
      isEnabled: data.isEnabled == 1,
    );
  }

  Future<List<RegexRuleEntity>> getAll() async {
    final results = await _database.select(_database.smsRules).get();
    return results.map(_fromData).toList();
  }

  Future<RegexRuleEntity?> getById(String id) async {
    final result = await (_database.select(_database.smsRules)
      ..where((tbl) => tbl.id.equals(id)))
      .getSingleOrNull();
    return result != null ? _fromData(result) : null;
  }

  Future<String> insert(RegexRuleEntity rule) async {
    final companion = _toCompanion(rule);
    await _database.into(_database.smsRules).insertOnConflictUpdate(companion);
    return companion.id.value;
  }

  Future<int> update(RegexRuleEntity rule) async {
    final companion = _toCompanion(rule);
    return await (_database.update(_database.smsRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.smsRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  Future<List<String>> insertAll(List<RegexRuleEntity> rules) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final rule in rules) {
        final companion = _toCompanion(rule);
        ids.add(companion.id.value);
        batch.insert(
          _database.smsRules,
          companion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }

  Future<int> updateAll(List<RegexRuleEntity> rules) async {
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.smsRules,
          _toCompanion(rule),
          where: (tbl) => tbl.id.equals(rule.id),
        );
      }
    });
    return rules.length;
  }

  Future<void> clear() async {
    await _database.delete(_database.smsRules).go();
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.smsRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }

  Future<String> exportData() async {
    final rules = await getAll();
    return jsonEncode(rules.map((r) => r.toMap()).toList());
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
      final rules = jsonList.map((j) => RegexRuleEntity.fromMap(j as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }
}
