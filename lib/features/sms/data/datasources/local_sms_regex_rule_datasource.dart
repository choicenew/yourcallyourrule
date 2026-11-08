import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_sms_regex_rule_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalSmsRegexRuleDataSource localSmsRegexRuleDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localSmsRegexRuleDataSource;
}

abstract class SmsRuleModelMapper {
  static PhoneRuleEntity fromData(SmsRuleData data) {
    return PhoneRuleEntity(
      id: data.id,
      name: data.name,
      priority: data.priority,
      action: data.action,
      pattern: data.contentRegex,
      isEnabled: data.isEnabled == 1,
      ruleType: data.ruleType,
    );
  }

  static SmsRulesCompanion toCompanion(PhoneRuleEntity model) {
    return SmsRulesCompanion(
      id: Value(model.id),
      name: Value(model.name),
      priority: Value(model.priority),
      action: Value(model.action),
      contentRegex: Value(model.pattern ?? ''),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      ruleType: Value(model.ruleType),
    );
  }
}

class LocalSmsRegexRuleDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalSmsRegexRuleDataSource(this._database);

  Future<List<PhoneRuleEntity>> getAll() async {
    final results = await _database.select(_database.smsRules).get();
    return results.map(SmsRuleModelMapper.fromData).toList();
  }

  Future<PhoneRuleEntity?> getById(String id) async {
    final result = await (_database.select(_database.smsRules)
      ..where((tbl) => tbl.id.equals(id)))
      .getSingleOrNull();
    return result != null ? SmsRuleModelMapper.fromData(result) : null;
  }

  Future<String> insert(PhoneRuleEntity rule) async {
    final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    final companion = SmsRuleModelMapper.toCompanion(rule);
    final companionWithId = companion.copyWith(id: Value(id));
    await _database.into(_database.smsRules).insertOnConflictUpdate(companionWithId);
    return id;
  }

  Future<int> update(PhoneRuleEntity rule) async {
    final companion = SmsRuleModelMapper.toCompanion(rule);
    return await (_database.update(_database.smsRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.smsRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  Future<List<String>> insertAll(List<PhoneRuleEntity> rules) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final rule in rules) {
        final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
        ids.add(id);
        final companion = SmsRuleModelMapper.toCompanion(rule);
        final companionWithId = companion.copyWith(id: Value(id));
        batch.insert(
          _database.smsRules,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }

  Future<int> updateAll(List<PhoneRuleEntity> rules) async {
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.smsRules,
          SmsRuleModelMapper.toCompanion(rule),
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
      final rules = jsonList.map((j) => PhoneRuleEntity.fromMap(j as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }
}