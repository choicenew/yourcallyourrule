import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_subscription_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalSubscriptionDataSource localSubscriptionDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalSubscriptionDataSource(db);
}

class LocalSubscriptionDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalSubscriptionDataSource(this._database);

  SubscriptionsCompanion _toCompanion(PhoneSubscriptionPayload model) {
    final String id = model.payloadId.isEmpty ? _uuid.v4() : model.payloadId;
    return SubscriptionsCompanion.insert(
      id: id,
      name: model.payloadId,
      url: model.payloadId,
      tableType: model.kind.id,
      isEnabled: const Value(1),
      lastUpdated: DateTime.now().toIso8601String(),
      autoUpdate: const Value(0),
      action: const Value('none'),
    );
  }

  PhoneSubscriptionPayload _fromData(SubscriptionData data) {
    return PhoneSubscriptionPayload(
      payloadId: data.id,
      kind: PhoneSubscriptionKind(id: data.tableType),
      rawJsonMap: data.toJson(),
      timestamp: DateTime.tryParse(data.lastUpdated)?.millisecondsSinceEpoch,
    );
  }

  Future<List<PhoneSubscriptionPayload>> getAll() async {
    final results = await _database.select(_database.subscriptions).get();
    return results.map(_fromData).toList();
  }

  Future<PhoneSubscriptionPayload?> getById(String id) async {
    final result = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
    return result != null ? _fromData(result) : null;
  }

  Future<String> insert(PhoneSubscriptionPayload subscription) async {
    final companion = _toCompanion(subscription);
    await _database.into(_database.subscriptions).insertOnConflictUpdate(companion);
    return companion.id.value;
  }

  Future<int> update(PhoneSubscriptionPayload subscription) async {
    final companion = _toCompanion(subscription);
    return await (_database.update(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(subscription.payloadId)))
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
        final companion = _toCompanion(subscription);
        ids.add(companion.id.value);
        batch.insert(
          _database.subscriptions,
          companion,
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
          _toCompanion(subscription),
          where: (tbl) => tbl.id.equals(subscription.payloadId),
        );
      }
    });
    return subscriptions.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
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
    return results.map(_fromData).toList();
  }

  Future<List<PhoneSubscriptionPayload>> getByType(String type) async {
    final results = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.tableType.equals(type)))
      .get();
    return results.map(_fromData).toList();
  }

  Future<PhoneSubscriptionPayload?> getByUrl(String url) async {
    final result = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.url.equals(url))
      ..limit(1))
      .getSingleOrNull();
    return result != null ? _fromData(result) : null;
  }
}
