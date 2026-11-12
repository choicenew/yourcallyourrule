import 'dart:async';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

final localSmsRegexRuleDataSourceProvider = Provider<LocalSmsRegexRuleDataSource>((ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalSmsRegexRuleDataSource(db);
});

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

  RegexRuleEntity _fromData(SmsRule data) {
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

  Future<void> insertAll(List<RegexRuleEntity> rules) async {
    for (final rule in rules) {
      await insert(rule);
    }
  }

  Future<void> update(RegexRuleEntity rule) async {
    await insert(rule);
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.smsRules)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.smsRules)
          ..where((tbl) => tbl.id.isIn(ids)))
        .go();
  }
}
