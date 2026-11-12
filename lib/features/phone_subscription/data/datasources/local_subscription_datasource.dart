import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

final localSubscriptionDataSourceProvider = Provider<LocalSubscriptionDataSource>((ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalSubscriptionDataSource(db);
});

class LocalSubscriptionDataSource {
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalSubscriptionDataSource(this._database);

  Future<List<PhoneSubscriptionPayload>> getAll() async {
    final rows = await (_database.select(_database.rules)..where((tbl) => tbl.ruleType.equals('subscription'))).get();
    return rows.map((r) => PhoneSubscriptionPayload(
      payloadId: r.id,
      kind: PhoneSubscriptionKind.rulesManifest,
      rawJsonMap: {
        'displayName': r.name,
        'downloadUrl': r.phoneNumber,
      },
    )).toList();
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.rules)..where((tbl) => tbl.id.equals(id))).go();
  }
}
