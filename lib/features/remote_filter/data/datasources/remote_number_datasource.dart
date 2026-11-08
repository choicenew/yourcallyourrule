import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:yourcallyourrule/features/common/error/logger.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';

part 'remote_number_datasource.g.dart';

@Riverpod(keepAlive: true)
RemoteNumberDataSource remoteNumberDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.remoteNumberDataSource;
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
    return RemoteNumbersCompanion(
      id: Value(model.id),
      phoneNumber: Value(model.phoneNumber),
      name: Value(model.name),
      label: Value(model.label),
      count: Value(model.count),
      action: Value(model.actionType),
      priority: const Value(5),
      labelsJson: const Value.absent(),
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
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
          ..limit(1))
        .getSingleOrNull();

    return result != null ? RemoteNumberModelMapper.fromRemoteNumberData(result) : null;
  }

  Future<RemoteNumberEntry?> getByPhoneNumber(String phoneNumber) async {
    return getById(phoneNumber);
  }

  Future<String> insert(
    RemoteNumberEntry remoteNumber, {
    String? countryIsoCode,
  }) async {
    await _database.transaction(() async {
      await _database
          .into(_database.remoteNumbers)
          .insert(
            RemoteNumberModelMapper.toRemoteNumberCompanion(
              remoteNumber,
            ).copyWith(id: Value(_uuid.v4())),
            mode: InsertMode.insertOrReplace,
          );

      if (countryIsoCode != null) {
        await _database
            .into(_database.numberCountries)
            .insert(
              NumberCountriesCompanion.insert(
                phoneNumber: remoteNumber.phoneNumber,
                countryIsoCode: countryIsoCode,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
    });

    return remoteNumber.phoneNumber;
  }

  Future<int> update(
    RemoteNumberEntry remoteNumber, {
    String? countryIsoCode,
  }) async {
    int result = 0;
    await _database.transaction(() async {
      result = await (_database.update(_database.remoteNumbers)..where(
        (tbl) => tbl.phoneNumber.equals(remoteNumber.phoneNumber),
      )).write(RemoteNumberModelMapper.toRemoteNumberCompanion(remoteNumber));

      if (result > 0 && countryIsoCode != null) {
        await _database
            .into(_database.numberCountries)
            .insert(
              NumberCountriesCompanion.insert(
                phoneNumber: remoteNumber.phoneNumber,
                countryIsoCode: countryIsoCode,
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
    return result;
  }

  Future<int> delete(String phoneNumber) async {
    int result = 0;
    await _database.transaction(() async {
      result = await (_database.delete(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))).go();
    });
    return result;
  }

  Future<int> atomicIncrementCount(
    String phoneNumber,
    int incrementValue,
  ) async {
    return await _database.transaction(() async {
      final result = await (_database.update(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))).write(
        RemoteNumbersCompanion.custom(
          count: _database.remoteNumbers.count + Constant(incrementValue),
        ),
      );
      return result;
    });
  }

  Future<List<String>> insertAll(List<RemoteNumberEntry> remoteNumbers) async {
    final List<String> phoneNumbers = [];
    await _database.transaction(() async {
      for (final remoteNumber in remoteNumbers) {
        await _database
            .into(_database.remoteNumbers)
            .insert(
              RemoteNumberModelMapper.toRemoteNumberCompanion(
                remoteNumber,
              ).copyWith(id: Value(_uuid.v4())),
              mode: InsertMode.insertOrReplace,
            );
        phoneNumbers.add(remoteNumber.phoneNumber);
      }
    });
    return phoneNumbers;
  }

  Future<int> updateAll(List<RemoteNumberEntry> remoteNumbers) async {
    int count = 0;
    await _database.transaction(() async {
      for (final remoteNumber in remoteNumbers) {
        final int updated = await (_database.update(_database.remoteNumbers)
          ..where(
            (tbl) => tbl.phoneNumber.equals(remoteNumber.phoneNumber),
          )).write(RemoteNumberModelMapper.toRemoteNumberCompanion(remoteNumber));
        count += updated;
      }
    });
    return count;
  }

  Future<int> deleteAll(List<String> phoneNumbers) async {
    int count = 0;
    await _database.transaction(() async {
      for (final phoneNumber in phoneNumbers) {
        final int deleted = await (_database.delete(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))).go();
        count += deleted;
      }
    });
    return count;
  }

  Future<void> clear() async {
    await _database.delete(_database.remoteNumbers).go();
    await _database.delete(_database.pendingOperations).go();
  }

  Future<List<RemoteNumberEntry>> getByLabel(String label) async {
    final results = await (_database.select(_database.remoteNumbers)
      ..where((tbl) => tbl.label.equals(label))).get();
    return results.map(RemoteNumberModelMapper.fromRemoteNumberData).toList();
  }
}