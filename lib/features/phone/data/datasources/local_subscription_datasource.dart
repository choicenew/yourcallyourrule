import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_subscription_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalSubscriptionDataSource localSubscriptionDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localSubscriptionDataSource;
}

abstract class SubscriptionModelMapper {
  static PhoneSubscriptionPayload fromData(SubscriptionData data) {
    final String id = data.id;
    return PhoneSubscriptionPayload(
      id: id,
      name: data.name,
      url: data.url,
      kind: PhoneSubscriptionKind.values.firstWhere(
        (e) => e.name == data.tableType,
        orElse: () => PhoneSubscriptionKind.phone,
      ),
      isEnabled: data.isEnabled == 1,
      lastUpdated: DateTime.tryParse(data.lastUpdated) ?? DateTime.now(),
      autoUpdate: data.autoUpdate == 1,
      action: data.action,
    );
  }

  static SubscriptionsCompanion toCompanion(PhoneSubscriptionPayload model) {
    return SubscriptionsCompanion(
      id: Value(model.id),
      name: Value(model.name),
      url: Value(model.url),
      tableType: Value(model.kind.name),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      lastUpdated: Value(model.lastUpdated.toIso8601String()),
      autoUpdate: Value(model.autoUpdate ? 1 : 0),
      action: Value(model.action ?? 'none'),
    );
  }
}

class LocalSubscriptionDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();
  
  LocalSubscriptionDataSource(this._database);

  Future<List<PhoneSubscriptionPayload>> getAll() async {
    final results = await _database.select(_database.subscriptions).get();
    return results.map(SubscriptionModelMapper.fromData).toList();
  }
  
  Future<PhoneSubscriptionPayload?> getById(String id) async {
    final result = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
    return result != null ? SubscriptionModelMapper.fromData(result) : null;
  }
  
  Future<String> insert(PhoneSubscriptionPayload subscription) async {
    final String id = subscription.id.isEmpty ? _uuid.v4() : subscription.id;
    final companion = SubscriptionModelMapper.toCompanion(subscription);
    final companionWithId = companion.copyWith(id: Value(id));
    await _database.into(_database.subscriptions).insertOnConflictUpdate(companionWithId);
    return id;
  }
  
  Future<int> update(PhoneSubscriptionPayload subscription) async {
    final companion = SubscriptionModelMapper.toCompanion(subscription);
    return await (_database.update(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(subscription.id)))
      .write(companion);
  }
  
  Future<int> delete(String id) async {
    return await (_database.delete(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  Future<List<String>> insertAll(List<PhoneSubscriptionPayload> subscriptions) async {
    final List<String> ids = [];
    await _database.batch((batch) {
      for (final subscription in subscriptions) {
        final String id = subscription.id.isEmpty ? _uuid.v4() : subscription.id;
        ids.add(id);
        final companion = SubscriptionModelMapper.toCompanion(subscription);
        final companionWithId = companion.copyWith(id: Value(id));
        batch.insert(
          _database.subscriptions,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }
  
  Future<int> updateAll(List<PhoneSubscriptionPayload> subscriptions) async {
    await _database.batch((batch) {
      for (final subscription in subscriptions) {
        batch.update(
          _database.subscriptions,
          SubscriptionModelMapper.toCompanion(subscription),
          where: (tbl) => tbl.id.equals(subscription.id),
        );
      }
    });
    return subscriptions.length;
  }
  
  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.subscriptions)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }
  
  Future<void> clear() async {
    await _database.delete(_database.subscriptions).go();
  }
  
  Future<String> exportData() async {
    final subscriptions = await getAll();
    final List<Map<String, dynamic>> subscriptionMaps = subscriptions.map((subscription) => subscription.toMap()).toList();
    return jsonEncode(subscriptionMaps);
  }
  
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> subscriptionMaps = jsonDecode(data) as List<dynamic>;
      final List<PhoneSubscriptionPayload> subscriptions = subscriptionMaps.map((map) => PhoneSubscriptionPayload.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(subscriptions);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<List<PhoneSubscriptionPayload>> getEnabledSubscriptions() async {
    final results = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.isEnabled.equals(1)))
      .get();
    return results.map(SubscriptionModelMapper.fromData).toList();
  }
  
  Future<List<PhoneSubscriptionPayload>> getAutoUpdateSubscriptions() async {
    final results = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.autoUpdate.equals(1)))
      .get();
    return results.map(SubscriptionModelMapper.fromData).toList();
  }
  
  Future<List<PhoneSubscriptionPayload>> getByType(String type) async {
    final results = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.tableType.equals(type)))
      .get();
    return results.map(SubscriptionModelMapper.fromData).toList();
  }

  Future<PhoneSubscriptionPayload?> getByUrl(String url) async {
    final result = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.url.equals(url))
      ..limit(1))
      .getSingleOrNull();
    return result != null ? SubscriptionModelMapper.fromData(result) : null;
  }
}