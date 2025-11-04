import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/label_mark_statistics_model.dart';

import '../../database/local/local_database.dart';
import '../datasource_interface.dart';

class LocalLabelMarkStatisticsDataSource implements LocalDataSource<LabelMarkRecordModel> {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  // Stream controller for mark count changes
  final StreamController<int> _markCountController = StreamController<int>.broadcast();
  // Subscription to user mark count table changes
  StreamSubscription<UserMarkCountData?>? _userMarkCountSubscription;
  bool _disposed = false;

  LocalLabelMarkStatisticsDataSource(this._db) {
    // Listen to changes in the user mark count table and update the stream
    _userMarkCountSubscription = _db
        .select(_db.userMarkCount)
        .watchSingleOrNull()
        .listen(
      (countData) {
        if (!_markCountController.isClosed) {
          _markCountController.add(countData?.total_count ?? 0);
        }
      },
      onError: (error, stackTrace) {
        print('Error listening to user mark count changes: $error');
      },
    );
  }

  Stream<int> get markCountStream => _markCountController.stream;

  // Helper to convert from Drift data class to model
  LabelMarkRecordModel _fromRecordData(LabelMarkStatisticData data) {
    return LabelMarkRecordModel(
      id: data.id,
      phoneNumber: data.phone_number,
      labelId: data.label_id,
      markedAt: DateTime.parse(data.marked_at),
      isCounted: data.is_counted == 1,
    );
  }

  // Helper to convert from model to Drift companion
  LabelMarkStatisticsCompanion _toRecordCompanion(LabelMarkRecordModel model) {
    return LabelMarkStatisticsCompanion(
      id: Value(model.id),
      phone_number: Value(model.phoneNumber),
      label_id: Value(model.labelId),
      marked_at: Value(model.markedAt.toIso8601String()),
      is_counted: Value(model.isCounted ? 1 : 0),
    );
  }

  Future<bool> recordMark(String phoneNumber, String labelId) async {
    if (labelId.toLowerCase() == 'unknown') {
      return false; // Do not record unknown labels
    }

    // Check if the number has already been marked
    final existingMark = await (_db.select(_db.labelMarkStatistics)
          ..where((tbl) => tbl.phone_number.equals(phoneNumber)))
        .getSingleOrNull();

    if (existingMark != null) {
      return false; // Already marked
    }

    await _db.transaction(() async {
      // Record the new mark
      final markId = _uuid.v4();
      await _db.into(_db.labelMarkStatistics).insert(LabelMarkStatisticsCompanion.insert(
            id: markId,
            phone_number: phoneNumber,
            label_id: labelId,
            marked_at: DateTime.now().toIso8601String(),
            is_counted: const Value(1),
          ));

      // Increment the user mark count
      final countRecord = await (_db.select(_db.userMarkCount)..limit(1)).getSingleOrNull();
      if (countRecord != null) {
        final newCount = (countRecord.total_count) + 1;
        await (_db.update(_db.userMarkCount)..where((tbl) => tbl.id.equals(countRecord.id))).write(
          UserMarkCountCompanion(
            total_count: Value(newCount),
            last_updated: Value(DateTime.now().toIso8601String()),
          ),
        );
      }
    });

    return true;
  }

  Future<int> getMarkCount() async {
     final countRecord = await (_db.select(_db.userMarkCount)..limit(1)).getSingleOrNull();
     return countRecord?.total_count ?? 0;
  }

  Future<void> resetMarkCount() async {
     final countRecord = await (_db.select(_db.userMarkCount)..limit(1)).getSingleOrNull();
     if (countRecord != null) {
        await (_db.update(_db.userMarkCount)..where((tbl) => tbl.id.equals(countRecord.id))).write(
          UserMarkCountCompanion(
            total_count: const Value(0),
            last_updated: Value(DateTime.now().toIso8601String()),
          ),
        );
     }
  }

  @override
  Future<List<LabelMarkRecordModel>> getAll() async {
    final data = await _db.select(_db.labelMarkStatistics).get();
    return data.map(_fromRecordData).toList();
  }

  @override
  Future<LabelMarkRecordModel?> getById(String id) async {
    final data = await (_db.select(_db.labelMarkStatistics)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? _fromRecordData(data) : null;
  }

  @override
  Future<String> insert(LabelMarkRecordModel item) async {
    final id = item.id.isEmpty ? _uuid.v4() : item.id;
    final companion = _toRecordCompanion(item).copyWith(id: Value(id));
    await _db.into(_db.labelMarkStatistics).insert(companion, mode: InsertMode.replace);
    return id;
  }

  @override
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

  @override
  Future<int> update(LabelMarkRecordModel item) async {
    return await (_db.update(_db.labelMarkStatistics)..where((tbl) => tbl.id.equals(item.id))).write(_toRecordCompanion(item));
  }

  @override
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

  @override
  Future<int> delete(String id) async {
    return await (_db.delete(_db.labelMarkStatistics)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_db.delete(_db.labelMarkStatistics)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  @override
  Future<void> clear() async {
    await _db.delete(_db.labelMarkStatistics).go();
    // Note: This does not clear the user_mark_count table, which seems to be the original intent.
    // If you need to clear the count, call resetMarkCount().
  }

  @override
  Future<String> exportData() async {
    final items = await getAll();
    return jsonEncode(items.map((item) => item.toMap()).toList());
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data);
      final items = maps.map((map) => LabelMarkRecordModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(items);
      return true;
    } catch (e) {
      print('Error importing label mark statistics data: $e');
      return false;
    }
  }

  // Dispose resources: cancel table change subscription and close stream controller
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    try {
      _userMarkCountSubscription?.cancel();
    } catch (e) {
      print('LocalLabelMarkStatisticsDataSource dispose subscription error: $e');
    }
    try {
      if (!_markCountController.isClosed) {
        _markCountController.close();
      }
    } catch (e) {
      print('LocalLabelMarkStatisticsDataSource dispose controller error: $e');
    }
  }
}