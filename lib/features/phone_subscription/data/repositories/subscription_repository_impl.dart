import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/features/phone_subscription/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'subscription_repository_impl.g.dart';

@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return SubscriptionRepositoryImpl(db);
}

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  SubscriptionRepositoryImpl(this._db);

  RulesCompanion _toCompanion(PhoneSubscriptionPayload entity) {
    final id = entity.payloadId.isEmpty ? _uuid.v4() : entity.payloadId;
    final name = entity.displayName?.trim().isNotEmpty == true
        ? entity.displayName!.trim()
        : (entity.rawJsonMap['name']?.toString().trim().isNotEmpty == true
            ? entity.rawJsonMap['name'].toString().trim()
            : (entity.rawJsonMap['title']?.toString() ?? ''));
    final url = entity.downloadUrl ?? entity.rawJsonMap['url']?.toString() ?? '';
    return RulesCompanion.insert(
      id: id,
      name: name,
      ruleType: 'subscription',
      phoneNumber: Value(url),
      pattern: Value(url),
      isSubscribed: const Value(1),
    );
  }

  PhoneSubscriptionPayload _fromData(dynamic data) {
    String url = '';
    String displayName = '';
    String id = '';
    if (data is PhoneRuleEntity) {
      id = data.id;
      displayName = data.name;
      url = data.phoneNumber.isNotEmpty ? data.phoneNumber : data.labelId;
    } else if (data is Map) {
      id = data['id']?.toString() ?? '';
      displayName = data['name']?.toString() ?? data['displayName']?.toString() ?? '';
      url = data['phoneNumber']?.toString() ?? data['pattern']?.toString() ?? data['url']?.toString() ?? '';
    } else {
      try {
        id = (data.id ?? '').toString();
        displayName = (data.name ?? '').toString();
        url = (data.phoneNumber ?? data.pattern ?? '').toString();
      } catch (_) {}
    }
    return PhoneSubscriptionPayload(
      payloadId: id,
      kind: PhoneSubscriptionKind.phoneRules,
      rawJsonMap: {
        'displayName': displayName,
        'name': displayName,
        'downloadUrl': url,
        'url': url,
        'isEnabled': true,
      },
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<List<PhoneSubscriptionPayload>> getAll() async { 
    final rows = await (_db.select(_db.rules)..where((tbl) => tbl.ruleType.equals('subscription'))).get();
    return rows.map(_fromData).toList();
  }

  @override
  Future<PhoneSubscriptionPayload?> getById(String id) async {
    final row = await (_db.select(_db.rules)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<PhoneSubscriptionPayload> save(PhoneSubscriptionPayload entity) async {
    final companion = _toCompanion(entity);
    await _db.into(_db.rules).insertOnConflictUpdate(companion);
    return entity;
  }

  @override
  Future<PhoneSubscriptionPayload> update(PhoneSubscriptionPayload entity) async {
    await save(entity);
    return entity;
  }

  @override
  Future<bool> delete(PhoneSubscriptionPayload entity) async {
    return await deleteById(entity.payloadId);
  }

  @override
  Future<bool> deleteById(String id) async {
    final count = await (_db.delete(_db.rules)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<PhoneSubscriptionPayload> entities) async {
    final ids = entities.map((e) => e.payloadId).toList();
    await (_db.delete(_db.rules)..where((tbl) => tbl.id.isIn(ids))).go();
    return true;
  }

  @override
  Future<int> count() async {
    final items = await getAll();
    return items.length;
  }

  @override
  Future<PhoneSubscriptionPayload?> getByUrl(String url) async {
    final rows = await getAll();
    try {
      return rows.firstWhere((s) => s.downloadUrl == url);
    } catch (_) {
      return null;
    }
  }
}
