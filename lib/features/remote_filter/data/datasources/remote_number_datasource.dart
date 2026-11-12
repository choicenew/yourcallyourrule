import 'dart:async';
import 'package:drift/drift.dart' hide Column;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';

part 'remote_number_datasource.g.dart';

@Riverpod(keepAlive: true)
RemoteNumberDataSource remoteNumberDataSource(Ref ref) {
  final db = ref.watch(remoteDatabaseProvider);
  return RemoteNumberDataSource(db);
}

abstract class RemoteNumberModelMapper {
  static RemoteNumberEntry fromRemoteNumberData(RemoteNumberData data) {
    return RemoteNumberEntry(
      id: data.id,
      phoneNumber: data.phoneNumber,
      name: data.name,
      label: data.label,
      count: data.count,
      actionType: data.action,
    );
  }

  static RemoteNumbersCompanion toRemoteNumberCompanion(RemoteNumberEntry model) {
    final String labelVal = model.label ?? '';
    return RemoteNumbersCompanion.insert(
      id: model.id,
      phoneNumber: model.phoneNumber,
      label: labelVal,
      name: Value(model.name),
      count: Value(model.count),
      action: Value(model.actionType),
    );
  }
}

class RemoteNumberDataSource {
  final RemoteDatabase _database;
  final Uuid _uuid = const Uuid();

  RemoteNumberDataSource(this._database);

  Future<List<RemoteNumberEntry>> getAll() async {
    final results = await _database.select(_database.remoteNumbers).get();
    return results.map(RemoteNumberModelMapper.fromRemoteNumberData).toList();
  }

  Future<RemoteNumberEntry?> getById(String phoneNumber) async {
    final result = await (_database.select(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
        .getSingleOrNull();
    return result != null ? RemoteNumberModelMapper.fromRemoteNumberData(result) : null;
  }

  Future<RemoteNumberEntry?> getByPhoneNumber(String phoneNumber) async {
    return getById(phoneNumber);
  }

  Future<void> insert(RemoteNumberEntry entry, {String? countryIsoCode}) async {
    final companion = RemoteNumberModelMapper.toRemoteNumberCompanion(entry);
    await _database.into(_database.remoteNumbers).insertOnConflictUpdate(companion);
  }

  Future<void> insertAll(List<RemoteNumberEntry> entries) async {
    for (final entry in entries) {
      await insert(entry);
    }
  }

  Future<void> update(RemoteNumberEntry entry, {String? countryIsoCode}) async {
    await insert(entry, countryIsoCode: countryIsoCode);
  }

  Future<int> delete(String phoneNumber) async {
    return await (_database.delete(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
        .go();
  }

  Future<int> deleteAll(List<String> phoneNumbers) async {
    if (phoneNumbers.isEmpty) return 0;
    return await (_database.delete(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.isIn(phoneNumbers)))
        .go();
  }

  Future<void> atomicIncrementCount(String phoneNumber, int delta) async {
    final entry = await getByPhoneNumber(phoneNumber);
    if (entry != null) {
      final updated = entry.copyWith(count: entry.count + delta);
      await update(updated);
    }
  }

  Future<DateTime?> getLastSyncTime() async {
    return DateTime.now().subtract(const Duration(hours: 25));
  }

  Future<void> linkNumberToCountry(String phoneNumber, String countryIsoCode) async {}

  Future<void> bulkInsertFromServer(String countryIsoCode, List<dynamic> numbers) async {
    for (final numData in numbers) {
      if (numData is Map<String, dynamic>) {
        final phone = numData['phoneNumber'] as String? ?? numData['phone'] as String? ?? '';
        if (phone.isNotEmpty) {
          final entry = RemoteNumberEntry(
            id: numData['id'] as String? ?? _uuid.v4(),
            phoneNumber: phone,
            name: numData['name'] as String? ?? '',
            label: numData['label'] as String? ?? '',
            actionType: numData['action'] as String? ?? 'block',
          );
          await insert(entry, countryIsoCode: countryIsoCode);
        }
      }
    }
  }

  Future<int> deleteNumbersByCountry(String countryIsoCode) async {
    return 0;
  }
}
