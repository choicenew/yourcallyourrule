import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart' hide PredefinedLabel;
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_label_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalLabelDataSource localLabelDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalLabelDataSource(db);
}

class LocalLabelDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalLabelDataSource(this._database);

  LabelPhoneEntry _dataToEntry(dynamic data) {
    return LabelPhoneEntry(
      id: data.id,
      phoneNumber: data.phoneNumber,
      labelId: data.labelId,
      name: data.name ?? '',
      avatar: data.avatar,
      icon: data.icon,
      priority: data.priority ?? 100,
      isEnabled: data.isEnabled == 1,
    );
  }

  LabelPhonesCompanion _toCompanion(LabelPhoneEntry entry) {
    final id = entry.id.isEmpty ? _uuid.v4() : entry.id;
    return LabelPhonesCompanion.insert(
      id: id,
      name: Value(entry.name),
      icon: Value(entry.icon),
      phoneNumber: entry.phoneNumber,
      labelId: entry.labelId,
      avatar: Value(entry.avatar),
      priority: Value(entry.priority),
      isEnabled: Value(entry.isEnabled ? 1 : 0),
    );
  }

  Future<List<LabelPhoneEntry>> getAll() async {
    final dataList = await _database.select(_database.labelPhones).get();
    return dataList.map(_dataToEntry).toList();
  }

  Future<LabelPhoneEntry?> getById(String id) async {
    final data = await (_database.select(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return data != null ? _dataToEntry(data) : null;
  }

  Future<String> insert(LabelPhoneEntry label) async {
    final companion = _toCompanion(label);
    await _database
        .into(_database.labelPhones)
        .insert(companion, mode: InsertMode.replace);
    return companion.id.value;
  }

  Future<int> update(LabelPhoneEntry label) async {
    final companion = _toCompanion(label);
    return await (_database.update(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(label.id)))
        .write(companion);
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
        final companion = _toCompanion(label);
        ids.add(companion.id.value);
        batch.insert(_database.labelPhones, companion, mode: InsertMode.replace);
      }
    });
    return ids;
  }

  Future<int> updateAll(List<LabelPhoneEntry> labels) async {
    await _database.batch((batch) {
      for (final label in labels) {
        batch.update(
          _database.labelPhones,
          _toCompanion(label),
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
    final dataList = await (_database.select(_database.labelPhones)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
      .get();
    return dataList.map(_dataToEntry).toList();
  }

  Future<List<LabelPhoneEntry>> getByLabelId(String labelId) async {
    final dataList = await (_database.select(_database.labelPhones)
      ..where((tbl) => tbl.labelId.equals(labelId)))
      .get();
    return dataList.map(_dataToEntry).toList();
  }

  Future<List<LabelPhoneEntry>> getEnabledLabels() async {
    final dataList = await (_database.select(_database.labelPhones)
      ..where((tbl) => tbl.isEnabled.equals(1)))
      .get();
    return dataList.map(_dataToEntry).toList();
  }

  Future<void> deleteByLabelId(String labelId) async {
    await (_database.delete(_database.labelPhones)
          ..where((tbl) => tbl.labelId.equals(labelId)))
        .go();
  }

  Future<List<LabelPhoneEntry>> getByName(String name) async {
    final dataList = await (_database.select(_database.labelPhones)
      ..where((tbl) => tbl.name.equals(name)))
      .get();
    return dataList.map(_dataToEntry).toList();
  }
}
