import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_sms_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalSmsDataSource localSmsDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return LocalSmsDataSource(databaseService.localDatabase);
}

abstract class SmsMessageModelMapper {
  static SmsMessageEntry fromData(SmsMessageData data) {
    return SmsMessageEntry(
      id: data.id,
      sender: data.phoneNumber,
      body: data.content,
      timestamp: DateTime.parse(data.timestamp).millisecondsSinceEpoch,
      isRead: data.isRead == 1,
    );
  }

  static SmsCompanion toCompanion(SmsMessageEntry model) {
    return SmsCompanion(
      id: Value(model.id),
      phoneNumber: Value(model.sender),
      content: Value(model.body),
      timestamp: Value(DateTime.fromMillisecondsSinceEpoch(model.timestamp).toIso8601String()),
      isRead: Value(model.isRead ? 1 : 0),
      messageType: const Value('incoming'),
    );
  }
}

class LocalSmsDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();
  
  LocalSmsDataSource(this._database);

  Future<List<SmsMessageEntry>> getAll() async {
    final results = await _database.select(_database.sms).get();
    return results.map(SmsMessageModelMapper.fromData).toList();
  }
  
  Future<SmsMessageEntry?> getById(String id) async {
    final result = await (_database.select(_database.sms)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
    return result != null ? SmsMessageModelMapper.fromData(result) : null;
  }
  
  Future<List<SmsMessageEntry>> getByPhoneNumber(String phoneNumber) async {
    final results = await (_database.select(_database.sms)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
      .get();
    return results.map(SmsMessageModelMapper.fromData).toList();
  }
  
  Future<String> insert(SmsMessageEntry sms) async {
    final String id = sms.id.isEmpty ? _uuid.v4() : sms.id;
    final companion = SmsMessageModelMapper.toCompanion(sms);
    final companionWithId = companion.copyWith(id: Value(id));
    await _database.into(_database.sms).insertOnConflictUpdate(companionWithId);
    return id;
  }
  
  Future<int> update(SmsMessageEntry sms) async {
    final companion = SmsMessageModelMapper.toCompanion(sms);
    return await (_database.update(_database.sms)
      ..where((tbl) => tbl.id.equals(sms.id)))
      .write(companion);
  }
  
  Future<int> delete(String id) async {
    return await (_database.delete(_database.sms)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  Future<List<String>> insertAll(List<SmsMessageEntry> smsList) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final sms in smsList) {
        final String id = sms.id.isEmpty ? _uuid.v4() : sms.id;
        ids.add(id);
        final companion = SmsMessageModelMapper.toCompanion(sms);
        final companionWithId = companion.copyWith(id: Value(id));
        batch.insert(
          _database.sms,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }
  
  Future<int> updateAll(List<SmsMessageEntry> smsList) async {
    await _database.batch((batch) {
      for (final sms in smsList) {
        batch.update(
          _database.sms,
          SmsMessageModelMapper.toCompanion(sms),
          where: (tbl) => tbl.id.equals(sms.id),
        );
      }
    });
    return smsList.length;
  }
  
  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.sms)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }
  
  Future<void> clear() async {
    await _database.delete(_database.sms).go();
  }
  
  Future<String> exportData() async {
    final smsList = await getAll();
    final List<Map<String, dynamic>> smsMaps = smsList.map((sms) => sms.toMap()).toList();
    return jsonEncode(smsMaps);
  }
  
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> smsMaps = jsonDecode(data) as List<dynamic>;
      final List<SmsMessageEntry> smsList = smsMaps.map((map) => SmsMessageEntry.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(smsList);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<List<SmsMessageEntry>> getUnreadSms() async {
    final results = await (_database.select(_database.sms)
      ..where((tbl) => tbl.isRead.equals(0)))
      .get();
    return results.map(SmsMessageModelMapper.fromData).toList();
  }
  
  Future<int> markAsRead(String id) async {
    return await (_database.update(_database.sms)
      ..where((tbl) => tbl.id.equals(id)))
      .write(SmsCompanion(isRead: const Value(1))); 
  }
}