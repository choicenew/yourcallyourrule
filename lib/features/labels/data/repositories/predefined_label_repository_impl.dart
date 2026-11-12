import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/repositories/predefined_label_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart' hide PredefinedLabel;

part 'predefined_label_repository_impl.g.dart';

@Riverpod(keepAlive: true)
PredefinedLabelRepository predefinedLabelRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return PredefinedLabelRepositoryImpl(db);
}

class PredefinedLabelRepositoryImpl implements PredefinedLabelRepository {
  final LocalDatabase _db;

  PredefinedLabelRepositoryImpl(this._db);

  PredefinedLabelsCompanion _toCompanion(PredefinedLabel label) {
    return PredefinedLabelsCompanion.insert(
      id: label.id,
      labelText: label.text,
      avatar: Value(label.avatar),
      icon: Value(label.icon),
    );
  }

  PredefinedLabel _fromData(dynamic data) {
    return PredefinedLabel(
      id: data.id as String,
      text: (data.labelText as String?) ?? '',
      avatar: data.avatar as String?,
      icon: data.icon as String?,
    );
  }

  @override
  Future<void> save(PredefinedLabel label) async {
    await _db.into(_db.predefinedLabels).insertOnConflictUpdate(_toCompanion(label));
  }

  @override
  Future<void> saveAll(List<PredefinedLabel> labels) async {
    for (final label in labels) {
      await save(label);
    }
  }

  @override
  Future<void> update(PredefinedLabel label) async {
    await save(label);
  }

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.predefinedLabels)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<PredefinedLabel>> getAll() async {
    final rows = await _db.select(_db.predefinedLabels).get();
    return rows.map(_fromData).toList();
  }

  @override
  Future<PredefinedLabel?> getById(String id) async {
    final row = await (_db.select(_db.predefinedLabels)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<List<PredefinedLabel>> getByText(String text) async {
    final rows = await (_db.select(_db.predefinedLabels)..where((tbl) => tbl.labelText.contains(text))).get();
    return rows.map(_fromData).toList();
  }

  @override
  Future<String?> getIdByText(String text) async {
    final row = await (_db.select(_db.predefinedLabels)..where((tbl) => tbl.labelText.equals(text))).getSingleOrNull();
    return row?.id;
  }

  @override
  Future<String?> getLabelTextAsync(String id) async {
    final label = await getById(id);
    return label?.text;
  }
}
