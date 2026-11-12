import 'dart:async';
import 'package:drift/drift.dart' hide Column;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_sms_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalSmsDataSource localSmsDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalSmsDataSource(db);
}

abstract class SmsMessageModelMapper {
  static SmsMessageEntity fromData(dynamic data) {
    return SmsMessageEntity(
      id: data.id as String,
      sender: data.phoneNumber as String,
      body: data.content as String,
      timestamp: DateTime.tryParse(data.timestamp as String? ?? '') ?? DateTime.now(),
    );
  }

  static SmsCompanion toCompanion(SmsMessageEntity model) {
    return SmsCompanion.insert(
      id: model.id,
      phoneNumber: model.sender,
      messageType: 'incoming',
      content: model.body,
      timestamp: model.timestamp.toIso8601String(),
    );
  }
}

class LocalSmsDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalSmsDataSource(this._database);

  Future<List<SmsMessageEntity>> getAll() async {
    final results = await _database.select(_database.sms).get();
    return results.map(SmsMessageModelMapper.fromData).toList();
  }

  Future<SmsMessageEntity?> getById(String id) async {
    final result = await (_database.select(_database.sms)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return result != null ? SmsMessageModelMapper.fromData(result) : null;
  }

  Future<String> insert(SmsMessageEntity sms) async {
    final companion = SmsMessageModelMapper.toCompanion(sms);
    await _database.into(_database.sms).insertOnConflictUpdate(companion);
    return companion.id.value;
  }

  Future<void> insertAll(List<SmsMessageEntity> messages) async {
    for (final message in messages) {
      await insert(message);
    }
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.sms)..where((tbl) => tbl.id.equals(id))).go();
  }
}
