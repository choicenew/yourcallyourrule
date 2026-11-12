import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'contact_subscription_repository_impl.g.dart';

/// 鑱旂郴浜鸿闃呬粨搴撴彁渚涜€?(鐩磋繛 Drift LocalDatabase)
@Riverpod(keepAlive: true)
ContactSubscriptionRepository contactSubscriptionRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return ContactSubscriptionRepositoryImpl(db);
}

/// 鑱旂郴浜鸿闃呬粨搴撳疄鐜扮被
class ContactSubscriptionRepositoryImpl implements ContactSubscriptionRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  ContactSubscriptionRepositoryImpl(this._db);

  RulesCompanion _toCompanion(PhoneSubscriptionPayload entity) {
    final String pid = (entity as dynamic).payloadId as String;
    final id = pid.isEmpty ? _uuid.v4() : pid;
    return RulesCompanion.insert(
      id: id,
      name: entity.displayName ?? '',
      ruleType: 'contact_subscription',
      pattern: Value(entity.downloadUrl),
      isSubscribed: const Value(1),
    );
  }

  PhoneSubscriptionPayload _fromData(dynamic data) {
    return PhoneSubscriptionPayload(
      payloadId: data.id,
      kind: PhoneSubscriptionKind.phoneRules,
      rawJsonMap: {
        'displayName': data.name,
        'downloadUrl': data.pattern ?? '',
      },
    );
  }

  @override
  Future<List<PhoneSubscriptionPayload>> getAll() async { return []; 
    final rows = await (_db.select(_db.rules)..where((tbl) => tbl.ruleType.equals('contact_subscription'))).get();
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
    final String pid = (entity as dynamic).payloadId as String;
    final count = await (_db.delete(_db.rules)..where((tbl) => tbl.id.equals(pid))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteById(String id) async {
    final count = await (_db.delete(_db.rules)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<PhoneSubscriptionPayload> entities) async {
    final ids = entities.map((e) => (e as dynamic).payloadId as String).toList();
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
