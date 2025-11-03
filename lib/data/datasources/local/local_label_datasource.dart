import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/label_phone_model.dart';

import '../../database/local/local_database.dart';
import '../datasource_interface.dart';

class LocalLabelDataSource implements LocalDataSource<LabelModel> {
  final LocalDatabase _database;

  LocalLabelDataSource(this._database);

  LabelModel _fromData(LabelPhoneData data) {
    return LabelModel(
      id: data.id,
      name: data.name ?? '',
      icon: data.icon,
      phoneNumber: data.phoneNumber,
      labelId: data.labelId,
      avatar: data.avatar,
      priority: data.priority,
      action: data.action,
      isEnabled: data.isEnabled == 1,
    );
  }

  LabelPhonesCompanion _toCompanion(LabelModel label) {
    return LabelPhonesCompanion(
      id: Value(label.id),
      name: Value(label.name),
      icon: Value(label.icon),
      phoneNumber: Value(label.phoneNumber),
      labelId: Value(label.labelId),
      avatar: Value(label.avatar),
      priority: Value(label.priority),
      action: Value(label.action),
      isEnabled: Value(label.isEnabled ? 1 : 0),
    );
  }

  @override
  Future<List<LabelModel>> getAll() async {
    final data = await _database.select(_database.labelPhones).get();
    return data.map(_fromData).toList();
  }
  
  // 根据ID获取标签
  @override
  Future<LabelModel?> getById(String id) async {
    final data = await (_database.select(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  @override
  Future<String> insert(LabelModel label) async {
    final id = label.id.isEmpty ? const Uuid().v4() : label.id;
    final companion = _toCompanion(label).copyWith(id: Value(id));
    await _database
        .into(_database.labelPhones)
        .insert(companion, mode: InsertMode.replace);
    return id;
  }

  @override
  Future<int> update(LabelModel label) async {
    return await (_database.update(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(label.id)))
        .write(_toCompanion(label));
  }

  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.labelPhones)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<List<String>> insertAll(List<LabelModel> labels) async {
    final ids = <String>[];
    await _database.batch((batch) {
      for (final label in labels) {
        final id = label.id.isEmpty ? const Uuid().v4() : label.id;
        ids.add(id);
        final companion = _toCompanion(label).copyWith(id: Value(id));
        batch.insert(_database.labelPhones, companion,
            mode: InsertMode.replace);
      }
    });
    return ids;
  }

  @override
  Future<int> updateAll(List<LabelModel> labels) async {
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

  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.labelPhones)
          ..where((tbl) => tbl.id.isIn(ids)))
        .go();
  }

  @override
  Future<void> clear() async {
    await _database.delete(_database.labelPhones).go();
  }

  @override
  Future<String> exportData() async {
    final labels = await getAll();
    return jsonEncode(labels.map((label) => label.toMap()).toList());
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> labelMaps = jsonDecode(data) as List<dynamic>;
      final List<LabelModel> labels = labelMaps
          .map((map) => LabelModel.fromMap(map as Map<String, dynamic>))
          .toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      print('Error importing label data: $e');
      return false;
    }
  }

  // =======================================================================
  // Restored Functions
  // =======================================================================

  Future<List<LabelModel>> getByPhoneNumber(String phoneNumber) async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
    final data = await query.get();
    return data.map(_fromData).toList();
  }

  Future<List<LabelModel>> getByLabelId(String labelId) async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.labelId.equals(labelId));
    final data = await query.get();
    return data.map(_fromData).toList();
  }

  Future<List<LabelModel>> getByLabelText(String labelText) async {
    // This requires a join with PredefinedLabels table
    final query = _database.select(_database.labelPhones).join([
      innerJoin(
          _database.predefinedLabels,
          _database.predefinedLabels.id
              .equalsExp(_database.labelPhones.labelId))
    ])
      ..where(_database.predefinedLabels.labelText.equals(labelText));

    final results = await query.get();
    return results.map((row) {
      return _fromData(row.readTable(_database.labelPhones));
    }).toList();
  }

  Future<List<LabelModel>> getEnabledLabels() async {
    final query = _database.select(_database.labelPhones)
      ..where((tbl) => tbl.isEnabled.equals(1));
    final data = await query.get();
    return data.map(_fromData).toList();
  }

  Future<void> deleteByLabelId(String labelId) async {
    await (_database.delete(_database.labelPhones)
          ..where((tbl) => tbl.labelId.equals(labelId)))
        .go();
  }
}