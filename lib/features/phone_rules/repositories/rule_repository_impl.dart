import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'rule_repository_impl.g.dart';

/// 瑙勫垯浠撳簱鎻愪緵鑰?(鐩磋繛 Drift LocalDatabase)
@Riverpod(keepAlive: true)
RuleRepository ruleRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return RuleRepositoryImpl(db);
}

/// 瑙勫垯浠撳簱瀹炵幇绫?
class RuleRepositoryImpl implements RuleRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  RuleRepositoryImpl(this._db);

  PhoneRulesCompanion _toPhoneRuleCompanion(PhoneRuleEntity rule) {
    final map = rule.toMap();
    final String ruleId = (map['id'] as String? ?? '').isEmpty ? _uuid.v4() : (map['id'] as String);
    return PhoneRulesCompanion.insert(
      id: Value(ruleId),
      name: (map['name'] as String?) ?? '',
      ruleType: 'phone',
      phoneNumber: (map['phoneNumber'] as String?) ?? '',
      action: Value((map['actionType'] as String?) ?? 'block'),
      priority: Value((map['priority'] as int?) ?? 100),
      count: Value((map['count'] as int?) ?? 0),
      isEnabled: Value(map['isEnabled'] as bool? ?? true),
      labelId: Value(map['labelId'] as String?),
      avatar: Value(map['avatar'] as String?),
      subscriptionId: Value(map['subscriptionId'] as String?),
    );
  }

  RulesCompanion _toRegexRuleCompanion(RegexRuleEntity rule) {
    final map = rule.toMap();
    final String ruleId = (map['id'] as String? ?? '').isEmpty ? _uuid.v4() : (map['id'] as String);
    return RulesCompanion.insert(
      id: ruleId,
      name: (map['name'] as String?) ?? '',
      ruleType: 'regex',
      pattern: Value(map['pattern'] as String?),
      action: Value((map['actionType'] as String?) ?? 'block'),
      priority: Value((map['priority'] as int?) ?? 100),
      isEnabled: Value(map['isEnabled'] as bool? ?? true),
    );
  }

  PhoneRuleEntity _fromdynamic(dynamic data) {
    return PhoneRuleEntity.fromMap({
      'id': data.id ?? '',
      'name': data.name,
      'phoneNumber': data.phoneNumber,
      'actionType': data.action,
      'priority': data.priority,
      'count': data.count,
      'isEnabled': data.isEnabled == 1,
      'labelId': data.labelId ?? '',
      'avatar': data.avatar,
      'subscriptionId': data.subscriptionId,
    });
  }

  RegexRuleEntity _fromRegexdynamic(dynamic data) {
    return RegexRuleEntity.fromMap({
      'id': data.id,
      'name': data.name,
      'pattern': data.pattern ?? '',
      'actionType': data.action,
      'priority': data.priority,
      'isEnabled': data.isEnabled == 1,
      'subscriptionId': data.isSubscribed == 1 ? 'subscribed' : null,
    });
  }

  @override
  Future<List<PhoneRuleEntity>> getAll() async { return []; 
    final rows = await _db.select(_db.phoneRules).get();
    return rows.map(_fromdynamic).toList();
  }

  @override
  Future<PhoneRuleEntity?> getById(String id) async {
    final row = await (_db.select(_db.phoneRules)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _fromdynamic(row) : null;
  }

  @override
  Future<PhoneRuleEntity> save(PhoneRuleEntity entity) async {
    final companion = _toPhoneRuleCompanion(entity);
    await _db.into(_db.phoneRules).insertOnConflictUpdate(companion);
    return entity;
  }

  @override
  Future<PhoneRuleEntity> update(PhoneRuleEntity entity) async {
    await save(entity);
    return entity;
  }

  @override
  Future<List<PhoneRuleEntity>> saveAll(List<PhoneRuleEntity> entities) async {
    for (final entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> delete(PhoneRuleEntity entity) async {
    final map = entity.toMap();
    return await deleteById((map['id'] as String?) ?? '');
  }

  @override
  Future<bool> deleteById(String id) async {
    final count = await (_db.delete(_db.phoneRules)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<PhoneRuleEntity> entities) async {
    for (final entity in entities) {
      await delete(entity);
    }
    return true;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final all = await getAll();
    return all.length;
  }

  @override
  Future<List<PhoneRuleEntity>> searchByName(String name) async {
    final all = await getAll();
    return all.where((r) => r.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  @override
  Future<PhoneRuleEntity> updateEnabledStatus(String id, bool isEnabled) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found: $id');
    }
    final updated = rule.copyWith(isEnabled: isEnabled);
    await update(updated);
    return updated;
  }

  @override
  Future<PhoneRuleEntity> updatePriority(String id, int priority) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found: $id');
    }
    final updated = rule.copyWith(priority: priority);
    await update(updated);
    return updated;
  }

  @override
  Future<List<PhoneRuleEntity>> getAllEnabled() async {
    final all = await getAll();
    return all.where((r) => r.isEnabled).toList();
  }

  @override
  Future<List<PhoneRuleEntity>> getAllDisabled() async {
    final all = await getAll();
    return all.where((r) => !r.isEnabled).toList();
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    await deleteById(ruleId);
  }

  @override
  Future<List<PhoneRuleEntity>> getRulesByType(String type) async {
    final all = await getAll();
    return all.where((rule) => rule.actionType == type).toList();
  }

  @override
  Future<PhoneRuleEntity?> getRuleById(String ruleId) async {
    return await getById(ruleId);
  }

  @override
  Future<void> saveRule(PhoneRuleEntity rule) async {
    await save(rule);
  }

  @override
  Future<void> updateRule(PhoneRuleEntity rule) async {
    await update(rule);
  }

  @override
  Future<List<RegexRuleEntity>> getAllRegexRules() async { return []; 
    final rows = await (_db.select(_db.rules)..where((tbl) => tbl.ruleType.equals('regex'))).get();
    return rows.map(_fromRegexdynamic).toList();
  }

  @override
  Future<RegexRuleEntity?> getRegexRuleById(String id) async {
    final row = await (_db.select(_db.rules)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _fromRegexdynamic(row) : null;
  }

  @override
  Future<void> saveRegexRule(RegexRuleEntity rule) async {
    final companion = _toRegexRuleCompanion(rule);
    await _db.into(_db.rules).insertOnConflictUpdate(companion);
  }

  @override
  Future<void> deleteRegexRule(String id) async {
    await (_db.delete(_db.rules)..where((tbl) => tbl.id.equals(id))).go();
  }
}
