import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart' hide PredefinedLabel;
import '../../repositories/label_phone_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'label_phone_repository_impl.g.dart';

/// 电话标签仓库提供者 (直连 Drift LocalDatabase)
@Riverpod(keepAlive: true)
LabelPhoneRepository labelPhoneRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LabelPhoneRepositoryImpl(db);
}

/// 电话标签仓库实现类
class LabelPhoneRepositoryImpl implements LabelPhoneRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LabelPhoneRepositoryImpl(this._db);

  LabelPhonesCompanion _toCompanion(LabelPhoneEntry entry) {
    final id = entry.id.isEmpty ? _uuid.v4() : entry.id;
    return LabelPhonesCompanion.insert(
      id: id,
      phoneNumber: entry.phoneNumber,
      labelId: entry.labelId,
      name: Value(entry.name),
      icon: Value(entry.icon),
      avatar: Value(entry.avatar),
      priority: Value(entry.priority),
      isEnabled: Value(entry.isEnabled),
    );
  }

  LabelPhoneEntry _fromData(dynamic data) {
    final Map<String, dynamic> rawMap = Map<String, dynamic>.from((data as dynamic).toJson() as Map);
    rawMap.remove('action');
    return LabelPhoneEntry.fromMap(rawMap);
  }

  @override
  Future<List<LabelPhoneEntry>> getAll() async {
    final rows = await _db.select(_db.labelPhones).get();
    return rows.map(_fromData).toList();
  }

  @override
  Future<LabelPhoneEntry?> getById(String id) async {
    final rows = await getAll();
    try {
      return rows.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<LabelPhoneEntry> saveLabel(LabelPhoneEntry entity) async {
    final companion = _toCompanion(entity);
    await _db.into(_db.labelPhones).insertOnConflictUpdate(companion);
    return entity;
  }

  @override
  Future<LabelPhoneEntry> save(LabelPhoneEntry entity) async {
    return await saveLabel(entity);
  }

  @override
  Future<LabelPhoneEntry> updateLabel(LabelPhoneEntry entity) async {
    return await saveLabel(entity);
  }

  @override
  Future<LabelPhoneEntry> update(LabelPhoneEntry entity) async {
    return await saveLabel(entity);
  }

  @override
  Future<bool> delete(LabelPhoneEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    final entity = await getById(id);
    if (entity == null) return false;
    await saveLabel(entity);
    return true;
  }

  @override
  Future<bool> deleteAll(List<LabelPhoneEntry> entities) async {
    for (final entity in entities) {
      await delete(entity);
    }
    return true;
  }

  @override
  Future<List<LabelPhoneEntry>> saveAllLabels(List<LabelPhoneEntry> entities) async {
    for (final entity in entities) {
      await saveLabel(entity);
    }
    return entities;
  }

  @override
  Future<List<LabelPhoneEntry>> saveAll(List<LabelPhoneEntry> entities) async {
    return await saveAllLabels(entities);
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final labels = await getAll();
    return labels.length;
  }

  @override
  LabelPhoneEntry fromMap(Map<String, dynamic> map) {
    return LabelPhoneEntry.fromMap(map);
  }

  @override
  Future<LabelPhoneEntry?> getByName(String name) async {
    final rows = await getAll();
    try {
      return rows.firstWhere((r) => r.name == name);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<LabelPhoneEntry>> getByType(String type) async {
    final rows = await getAll();
    return rows.where((r) => r.labelId == type).toList();
  }

  @override
  Future<bool> nameExists(String name) async {
    final label = await getByName(name);
    return label != null;
  }

  @override
  Future<List<LabelPhoneEntry>> getAllEnabled() async {
    final rows = await getAll();
    return rows.where((r) => r.isEnabled).toList();
  }

  @override
  Future<LabelPhoneEntry?> getByPhoneNumber(String phoneNumber) async {
    final rows = await getAll();
    try {
      return rows.firstWhere((r) => r.phoneNumber == phoneNumber);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<LabelPhoneEntry>> getByLabelId(String labelId) async {
    final rows = await getAll();
    return rows.where((r) => r.labelId == labelId).toList();
  }
}
