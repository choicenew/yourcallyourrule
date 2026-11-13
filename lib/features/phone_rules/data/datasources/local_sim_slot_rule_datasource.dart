import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_sim_slot_rule_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalSimSlotRuleDataSource localSimSlotRuleDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalSimSlotRuleDataSource(db);
}

abstract class SimSlotRuleModelMapper {
  static SimSlotRuleEntity fromData(SimSlotRule data) {
    return SimSlotRuleEntity(
      id: data.id,
      name: data.name,
      priority: data.priority,
      actionType: data.action,
      phoneNumber: data.phoneNumber,
      simSlotIndex: data.simSlotIndex,
      labelId: data.labelId,
      avatar: data.avatar,
      isEnabled: data.isEnabled == 1,
    );
  }

  static SimSlotRulesCompanion toCompanion(SimSlotRuleEntity model) {
    return SimSlotRulesCompanion(
      id: Value(model.id),
      name: Value(model.name),
      priority: Value(model.priority),
      action: Value(model.actionType),
      phoneNumber: Value(model.phoneNumber),
      simSlotIndex: Value(model.simSlotIndex),
      labelId: Value(model.labelId),
      avatar: Value(model.avatar),
      isEnabled: Value(model.isEnabled ? 1 : 0),
    );
  }
}

class LocalSimSlotRuleDataSource {
  final LocalDatabase _db;

  LocalSimSlotRuleDataSource(this._db);

  Future<List<SimSlotRuleEntity>> getAll() async {
    final list = await _db.select(_db.simSlotRules).get();
    return list.map((e) => SimSlotRuleModelMapper.fromData(e)).toList();
  }

  Future<SimSlotRuleEntity?> getById(String id) async {
    final query = _db.select(_db.simSlotRules)..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();
    return result == null ? null : SimSlotRuleModelMapper.fromData(result);
  }

  Future<List<SimSlotRuleEntity>> getBySimSlot(int simSlotIndex) async {
    final query = _db.select(_db.simSlotRules)..where((tbl) => tbl.simSlotIndex.equals(simSlotIndex));
    final list = await query.get();
    return list.map((e) => SimSlotRuleModelMapper.fromData(e)).toList();
  }

  Future<void> insertRule(SimSlotRuleEntity rule) async {
    final companion = SimSlotRuleModelMapper.toCompanion(rule);
    await _db.into(_db.simSlotRules).insert(companion, mode: InsertMode.insertOrReplace);
  }

  Future<void> updateRule(SimSlotRuleEntity rule) async {
    final companion = SimSlotRuleModelMapper.toCompanion(rule);
    await _db.update(_db.simSlotRules).replace(companion);
  }

  Future<void> deleteRule(String id) async {
    await (_db.delete(_db.simSlotRules)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteAll() async {
    await _db.delete(_db.simSlotRules).go();
  }

  Future<void> saveSimSlotRule(SimSlotRuleEntity rule) async {
    await insertRule(rule);
  }

  Future<List<SimSlotRuleEntity>> getSimSlotRules(int simSlotIndex) async {
    return getBySimSlot(simSlotIndex);
  }

  Future<void> setSimSlotRules(int simSlotIndex, List<SimSlotRuleEntity> rules) async {
    await (_db.delete(_db.simSlotRules)..where((tbl) => tbl.simSlotIndex.equals(simSlotIndex))).go();
    for (final r in rules) {
      await insertRule(r);
    }
  }

  Future<void> addSimSlotRule(int simSlotIndex, SimSlotRuleEntity rule) async {
    await insertRule(rule);
  }

  Future<void> deleteSimSlotRule(int simSlotIndex, String ruleId) async {
    await deleteRule(ruleId);
  }

  Future<void> toggleSimSlotRule(int simSlotIndex, String ruleId) async {
    final rule = await getById(ruleId);
    if (rule != null) {
      final updated = rule.copyWith(isEnabled: !rule.isEnabled);
      await updateRule(updated);
    }
  }

  Future<void> syncRulesToRemote(List<SimSlotRuleEntity> rules) async {
    final List<Map<String, dynamic>> maps = rules.map((rule) => rule.toMap()).toList();
    jsonEncode(maps);
  }

  Future<List<SimSlotRuleEntity>> syncRulesFromRemote() async {
    return [];
  }
}
