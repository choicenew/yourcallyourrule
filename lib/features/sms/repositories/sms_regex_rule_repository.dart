import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/sms/data/datasources/local_sms_regex_rule_datasource.dart';

/// 短信正则规则仓库实现类 (100% 独立，直接使用 RegexRuleEntity 包实体)
class SmsRegexRuleRepository {
  final LocalSmsRegexRuleDataSource _dataSource;

  SmsRegexRuleRepository(this._dataSource);

  Future<int> count() async {
    final rules = await _dataSource.getAll();
    return rules.length;
  }

  Future<bool> delete(RegexRuleEntity entity) async {
    final result = await _dataSource.delete(entity.id);
    return result > 0;
  }

  Future<bool> deleteAll(List<RegexRuleEntity> entities) async {
    final ids = entities.map((e) => e.id).toList();
    final result = await _dataSource.deleteAll(ids);
    return result > 0;
  }

  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  Future<bool> exists(String id) async {
    final rule = await _dataSource.getById(id);
    return rule != null;
  }

  Future<List<RegexRuleEntity>> getAll() async {
    return await _dataSource.getAll();
  }

  Future<RegexRuleEntity?> getById(String id) async {
    return await _dataSource.getById(id);
  }

  Future<RegexRuleEntity> save(RegexRuleEntity entity) async {
    await _dataSource.insert(entity);
    return entity;
  }

  Future<List<RegexRuleEntity>> saveAll(List<RegexRuleEntity> entities) async {
    await _dataSource.insertAll(entities);
    return entities;
  }

  Future<RegexRuleEntity> update(RegexRuleEntity entity) async {
    await _dataSource.update(entity);
    return entity;
  }
}
