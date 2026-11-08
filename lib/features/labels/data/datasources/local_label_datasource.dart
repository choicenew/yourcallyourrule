import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_label_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalLabelDataSource localLabelDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localLabelDataSource;
}

abstract class LabelModelMapper {
  static LabelPhoneEntry fromData(LabelPhoneData data) {
    return LabelPhoneEntry(
      id: data.id,
      name: data.name ?? '',
      phoneNumber: data.phoneNumber,
      labelId: data.labelId,
      icon: data.icon,
      avatar: data.avatar,
      priority: data.priority,
      action: data.action,
      isEnabled: data.isEnabled == 1,
    );
  }

  static LabelPhonesCompanion toCompanion(LabelPhoneEntry entry) {
    return LabelPhonesCompanion(
      id: Value(entry.id),
      name: Value(entry.name),
      icon: Value(entry.icon),
      phoneNumber: Value(entry.phoneNumber),
      labelId: Value(entry.labelId),
      avatar: Value(entry.avatar),
      priority: Value(entry.priority),
      action: Value(entry.action),
      isEnabled: Value(entry.isEnabled ? 1 : 0),
    );
  }
}

class LocalLabelDataSource {
  final LocalDatabase _database;

  LocalLabelDataSource(this._database);

  Future<List<LabelPhoneEntry>> getAll() async {
    final data = await _database.select(_database.labelPhones).get();
    return data.map(LabelModelMapper.fromData).toList();
  }
  
  Future<LabelPhoneEntry?> getById(String id) async {
    final data = await (_database.select(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return data != null ? LabelModelMapper.fromData(data) : null;
  }

  Future<String> insert(LabelPhoneEntry label) async {
    final id = label.id.isEmpty ? const Uuid().v4() : label.id;
    final companion = LabelModelMapper.toCompanion(label).copyWith(id: Value(id));
    await _database
        .into(_database.labelPhones)
        .insert(companion, mode: InsertMode.replace);
    return id;
  }

  Future<int> update(LabelPhoneEntry label) async {
    return await (_database.update(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(label.id)))
        .write(LabelModelMapper.toCompanion(label));
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<List<String>> insertAll(List<LabelPhoneEntry> labels) async {
    final ids = <String>[];
    await _database.batch((batch) {
      for (final label in labels) {
        final id = label.id.isEmpty ? const Uuid().v4() : label.id;
        ids.add(id);
        final companion = LabelModelMapper.toCompanion(label).copyWith(id: Value(id));
        batch.insert(_database.labelPhones, companion,
            mode: InsertMode.replace);
      }
    });
    return ids;
  }

  Future<int> updateAll(List<LabelPhoneEntry> labels) async {
    await _database.batch((batch) {
      for (final label in labels) {
        batch.update(
          _database.labelPhones,
          LabelModelMapper.toCompanion(label),
          where: (tbl) => tbl.id.equals(label.id),
        );
      }
    });
    return labels.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.labelPhones)
          ..where((tbl) => tbl.id.isIn(ids)))
        .go();
  }

  Future<void> clear() async {
    await _database.delete(_database.labelPhones).go();
  }

  Future<String> exportData() async {
    final labels = await getAll();
    return jsonEncode(labels.map((label) => label.toMap()).toList());
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> labelMaps = jsonDecode(data) as List<dynamic>;
      final List<LabelPhoneEntry> labels = labelMaps
          .map((map) => LabelPhoneEntry.fromMap(map as Map<String, dynamic>))
          .toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<LabelPhoneEntry>> getByPhoneNumber(String phoneNumber) async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
    final data = await query.get();
    return data.map(LabelModelMapper.fromData).toList();
  }

  Future<List<LabelPhoneEntry>> getByLabelId(String labelId) async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.labelId.equals(labelId));
    final data = await query.get();
    return data.map(LabelModelMapper.fromData).toList();
  }

  Future<List<LabelPhoneEntry>> getByLabelText(String labelText) async {
    final query = _database.select(_database.labelPhones).join([
      innerJoin(
          _database.predefinedLabels,
          _database.predefinedLabels.id
              .equalsExp(_database.labelPhones.labelId))
    ])
      ..where(_database.predefinedLabels.labelText.equals(labelText));

    final results = await query.get();
    return results.map((row) {
      return LabelModelMapper.fromData(row.readTable(_database.labelPhones));
    }).toList();
  }

  Future<List<LabelPhoneEntry>> getEnabledLabels() async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.isEnabled.equals(1));
    final data = await query.get();
    return data.map(LabelModelMapper.fromData).toList();
  }

  Future<void> deleteByLabelId(String labelId) async {
    await (_database.delete(_database.labelPhones)
          ..where((tbl) => tbl.labelId.equals(labelId)))
        .go();
  }

  Future<List<LabelPhoneEntry>> getByName(String name) async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.name.equals(name));
    final data = await query.get();
    return data.map(LabelModelMapper.fromData).toList();
  }

  Future<List<LabelPhoneEntry>> getByRuleType(String ruleType) async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.ruleType.equals(ruleType));
    final data = await query.get();
    return data.map(LabelModelMapper.fromData).toList();
  }
}