import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_sim_slot_rules_protocol/pyro_sim_slot_rules_protocol.dart';
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
      ruleType: const Value(''),
      phoneNumber: Value(model.phoneNumber),
      simSlotIndex: Value(model.simSlotIndex),
      labelId: Value(model.labelId),
      avatar: Value(model.avatar),
      isEnabled: Value(model.isEnabled ? 1 : 0),
    );
  }
}

class LocalSimSlotRuleDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();
  
  LocalSimSlotRuleDataSource(this._database);
  
  Future<List<SimSlotRuleEntity>> getAll() async {
    final results = await _database.select(_database.simSlotRules).get();
    return results.map<SimSlotRuleEntity>(SimSlotRuleModelMapper.fromData).toList();
  }
  
  Future<SimSlotRuleEntity?> getById(String id) async {
    final result = await (_database.select(_database.simSlotRules)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
    return result != null ? SimSlotRuleModelMapper.fromData(result) : null;
  }
  
  Future<String> insert(SimSlotRuleEntity model) async {
    final String id = model.id.isEmpty ? _uuid.v4() : model.id;
    final companion = SimSlotRuleModelMapper.toCompanion(model);
    final companionWithId = companion.copyWith(id: Value(id));
    await _database.into(_database.simSlotRules).insertOnConflictUpdate(companionWithId);
    return id;
  }
  
  Future<void> save(SimSlotRuleEntity model) async {
    await insert(model);
  }
  
  Future<int> update(SimSlotRuleEntity model) async {
    final companion = SimSlotRuleModelMapper.toCompanion(model);
    return await (_database.update(_database.simSlotRules)
      ..where((tbl) => tbl.id.equals(model.id)))
      .write(companion);
  }
  
  Future<int> delete(String id) async {
    return await (_database.delete(_database.simSlotRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  Future<List<SimSlotRuleEntity>> getBySimSlotIndex(int simSlotIndex) async {
    final query = _database.select(_database.simSlotRules)
      ..where((tbl) => tbl.simSlotIndex.equals(simSlotIndex));
    final results = await query.get();
    return results.map<SimSlotRuleEntity>(SimSlotRuleModelMapper.fromData).toList();
  }
  
  Future<List<SimSlotRuleEntity>> getByPhoneNumber(String phoneNumber) async {
    final query = _database.select(_database.simSlotRules)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
    final results = await query.get();
    return results.map<SimSlotRuleEntity>(SimSlotRuleModelMapper.fromData).toList();
  }
  
  Future<void> clear() async {
    await _database.delete(_database.simSlotRules).go();
  }
  
  Future<void> clearAll() async {
    await clear();
  }
  
  Future<List<String>> insertAll(List<SimSlotRuleEntity> items) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (var item in items) {
        final String id = item.id.isEmpty ? _uuid.v4() : item.id;
        ids.add(id);
        final companion = SimSlotRuleModelMapper.toCompanion(item);
        final companionWithId = companion.copyWith(id: Value(id));
        batch.insert(
          _database.simSlotRules,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }
  
  Future<int> updateAll(List<SimSlotRuleEntity> items) async {
    await _database.batch((batch) {
      for (var item in items) {
        batch.update(
          _database.simSlotRules,
          SimSlotRuleModelMapper.toCompanion(item),
          where: (tbl) => tbl.id.equals(item.id),
        );
      }
    });
    return items.length;
  }
  
  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.simSlotRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }
  
  Future<String> exportData() async {
    final rules = await getAll();
    final List<Map<String, dynamic>> maps = rules.map((rule) => rule.toMap()).toList();
    return jsonEncode(maps);
  }
  
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data) as List<dynamic>;
      final List<SimSlotRuleEntity> rules = maps.map((map) => SimSlotRuleEntity.fromMap(map as Map<String, dynamic>)).toList();
      await clear(); 
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }
}
