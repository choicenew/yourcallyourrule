import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/labels/domain/label_mark_record_model.dart';

part 'local_label_mark_statistics_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalLabelMarkStatisticsDataSource localLabelMarkStatisticsDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalLabelMarkStatisticsDataSource(db);
}

class LocalLabelMarkStatisticsDataSource {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  final StreamController<int> _markCountController = StreamController<int>.broadcast();
  StreamSubscription<UserMarkCountData?>? _userMarkCountSubscription;
  bool _disposed = false;

  LocalLabelMarkStatisticsDataSource(this._db) {
    _userMarkCountSubscription = _db
        .select(_db.userMarkCount)
        .watchSingleOrNull()
        .listen(
      (countData) {
        if (!_markCountController.isClosed) {
          _markCountController.add(countData?.totalCount ?? 0);
        }
      },
      onError: (error, stackTrace) {
      },
    );
  }

  Stream<int> get markCountStream => _markCountController.stream;

  LabelMarkRecordModel _fromRecordData(LabelMarkStatisticData data) {
    return LabelMarkRecordModel(
      id: data.id,
      phoneNumber: data.phoneNumber,
      labelId: data.labelId,
      markedAt: DateTime.parse(data.markedAt),
      isCounted: data.isCounted == 1,
    );
  }

  LabelMarkStatisticsCompanion _toRecordCompanion(LabelMarkRecordModel model) {
    return LabelMarkStatisticsCompanion(
      id: Value(model.id),
      phoneNumber: Value(model.phoneNumber),
      labelId: Value(model.labelId),
      markedAt: Value(model.markedAt.toIso8601String()),
      isCounted: Value(model.isCounted ? 1 : 0),
    );
  }

  Future<bool> recordMark(String phoneNumber, String labelId) async {
    if (labelId.toLowerCase() == 'unknown') {
      return false;
    }

    final existingMark = await (_db.select(_db.labelMarkStatistics)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
        .getSingleOrNull();

    if (existingMark != null) {
      return false;
    }

    await _db.transaction(() async {
      final markId = _uuid.v4();
      await _db.into(_db.labelMarkStatistics).insert(LabelMarkStatisticsCompanion.insert(
            id: markId,
            phoneNumber: phoneNumber,
            labelId: labelId,
            markedAt: DateTime.now().toIso8601String(),
            isCounted: const Value(1),
          ));

      final countRecord = await (_db.select(_db.userMarkCount)..limit(1)).getSingleOrNull();
      if (countRecord != null) {
        final newCount = (countRecord.totalCount) + 1;
        await (_db.update(_db.userMarkCount)..where((tbl) => tbl.id.equals(countRecord.id))).write(
          UserMarkCountCompanion(
            totalCount: Value(newCount),
            lastUpdated: Value(DateTime.now().toIso8601String()),
          ),
        );
      }
    });

    return true;
  }

  Future<int> getMarkCount() async {
     final countRecord = await (_db.select(_db.userMarkCount)..limit(1)).getSingleOrNull();
     return countRecord?.totalCount ?? 0;
  }

  Future<void> resetMarkCount() async {
     final countRecord = await (_db.select(_db.userMarkCount)..limit(1)).getSingleOrNull();
     if (countRecord != null) {
        await (_db.update(_db.userMarkCount)..where((tbl) => tbl.id.equals(countRecord.id))).write(
          UserMarkCountCompanion(
            totalCount: const Value(0),
            lastUpdated: Value(DateTime.now().toIso8601String()),
          ),
        );
     }
  }

  Future<List<LabelMarkRecordModel>> getAll() async {
    final data = await _db.select(_db.labelMarkStatistics).get();
    return data.map(_fromRecordData).toList();
  }

  Future<LabelMarkRecordModel?> getById(String id) async {
    final data = await (_db.select(_db.labelMarkStatistics)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? _fromRecordData(data) : null;
  }

  Future<String> insert(LabelMarkRecordModel item) async {
    final id = item.id.isEmpty ? _uuid.v4() : item.id;
    final companion = _toRecordCompanion(item).copyWith(id: Value(id));
    await _db.into(_db.labelMarkStatistics).insert(companion, mode: InsertMode.replace);
    return id;
  }

  Future<List<String>> insertAll(List<LabelMarkRecordModel> items) async {
    final ids = <String>[];
    await _db.batch((batch) {
      for (final item in items) {
        final id = item.id.isEmpty ? _uuid.v4() : item.id;
        ids.add(id);
        final companion = _toRecordCompanion(item).copyWith(id: Value(id));
        batch.insert(_db.labelMarkStatistics, companion, mode: InsertMode.replace);
      }
    });
    return ids;
  }

  Future<int> update(LabelMarkRecordModel item) async {
    return await (_db.update(_db.labelMarkStatistics)..where((tbl) => tbl.id.equals(item.id))).write(_toRecordCompanion(item));
  }

  Future<int> updateAll(List<LabelMarkRecordModel> items) async {
    await _db.batch((batch) {
      for (final item in items) {
        batch.update(
          _db.labelMarkStatistics,
          _toRecordCompanion(item),
          where: (tbl) => tbl.id.equals(item.id),
        );
      }
    });
    return items.length;
  }

  Future<int> delete(String id) async {
    return await (_db.delete(_db.labelMarkStatistics)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_db.delete(_db.labelMarkStatistics)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  Future<void> clear() async {
    await _db.delete(_db.labelMarkStatistics).go();
  }

  Future<String> exportData() async {
    final items = await getAll();
    return jsonEncode(items.map((item) => item.toMap()).toList());
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data);
      final items = maps.map((map) => LabelMarkRecordModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(items);
      return true;
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    try {
      _userMarkCountSubscription?.cancel();
    } catch (_) {
    }
    try {
      if (!_markCountController.isClosed) {
        _markCountController.close();
      }
    } catch (_) {
    }
  }
}
