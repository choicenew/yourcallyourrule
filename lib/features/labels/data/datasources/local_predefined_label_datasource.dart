import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart' hide PredefinedLabel;

part 'local_predefined_label_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalPredefinedLabelDataSource localPredefinedLabelDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalPredefinedLabelDataSource(db);
}

abstract class PredefinedLabelModelMapper {
  static PredefinedLabel fromData(dynamic data) {
    return PredefinedLabel(
      id: data.id as String,
      text: (data.labelText as String?) ?? '',
      avatar: data.avatar as String?,
      icon: data.icon as String?,
    );
  }

  static PredefinedLabelsCompanion toCompanion(PredefinedLabel model) {
    return PredefinedLabelsCompanion(
      id: Value(model.id),
      labelText: Value(model.text),
      avatar: Value(model.avatar),
      icon: Value(model.icon),
    );
  }
}

class LocalPredefinedLabelDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalPredefinedLabelDataSource(this._database);

  Future<List<PredefinedLabel>> getAll() async {
    final results = await _database.select(_database.predefinedLabels).get();
    return results.map(PredefinedLabelModelMapper.fromData).toList();
  }

  Future<PredefinedLabel?> getById(String id) async {
    final query = _database.select(_database.predefinedLabels)
      ..where((tbl) => tbl.id.equals(id));

    final result = await query.getSingleOrNull();
    return result != null ? PredefinedLabelModelMapper.fromData(result) : null;
  }

  Future<List<PredefinedLabel>> getByText(String text) async {
    final query = _database.select(_database.predefinedLabels)
      ..where((tbl) => tbl.labelText.like('%$text%'));

    final results = await query.get();
    return results.map(PredefinedLabelModelMapper.fromData).toList();
  }

  Future<String?> getIdByExactText(String text) async {
    final query = _database.selectOnly(_database.predefinedLabels)
      ..addColumns([_database.predefinedLabels.id])
      ..where(_database.predefinedLabels.labelText.equals(text))
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result?.read(_database.predefinedLabels.id);
  }

  Future<String> insert(PredefinedLabel label) async {
    final id = label.id.isEmpty ? _uuid.v4() : label.id;
    final companion = PredefinedLabelModelMapper.toCompanion(label).copyWith(id: Value(id));
    await _database.into(_database.predefinedLabels).insert(
      companion,
      mode: InsertMode.insertOrReplace,
    );
    return id;
  }

  Future<int> update(PredefinedLabel label) async {
    final companion = PredefinedLabelModelMapper.toCompanion(label);
    final updatedRows = await (_database.update(_database.predefinedLabels)
          ..where((tbl) => tbl.id.equals(label.id)))
        .write(companion);
    return updatedRows;
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.predefinedLabels)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<List<String>> insertAll(List<PredefinedLabel> labels) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final label in labels) {
        final id = label.id.isEmpty ? _uuid.v4() : label.id;
        ids.add(id);
        final companion = PredefinedLabelModelMapper.toCompanion(label).copyWith(id: Value(id));
        batch.insert(
          _database.predefinedLabels,
          companion,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }

  Future<int> updateAll(List<PredefinedLabel> labels) async {
    await _database.batch((batch) {
      for (final label in labels) {
        batch.update(
          _database.predefinedLabels,
          PredefinedLabelModelMapper.toCompanion(label),
          where: (tbl) => tbl.id.equals(label.id),
        );
      }
    });
    return labels.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.predefinedLabels)
          ..where((tbl) => tbl.id.isIn(ids)))
        .go();
  }

  Future<void> clear() async {
    await _database.delete(_database.predefinedLabels).go();
  }

  Future<String> exportData() async {
    final labels = await getAll();
    final List<Map<String, dynamic>> labelMaps = labels.map((label) => label.toMap()).toList();
    return jsonEncode(labelMaps);
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> labelMaps = jsonDecode(data) as List<dynamic>;
      final List<PredefinedLabel> labels = labelMaps.map((map) => PredefinedLabel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    try {
      final labels = predefinedLabels.map((map) => PredefinedLabel.fromMap(map)).toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      return false;
    }
  }
}
