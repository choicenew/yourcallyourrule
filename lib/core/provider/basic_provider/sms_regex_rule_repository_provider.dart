import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_sms_regex_rule_datasource_provider.dart';

import 'package:yourcallyourrule/data/datasources/local/local_sms_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/models/sms_regex_rule_model.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_regex_rule_repository.dart';

/// SMS正则规则仓库提供者
final smsRegexRuleRepositoryProvider = Provider<SmsRegexRuleRepository>((ref) {
  final dataSource = ref.watch(localSmsRegexRuleDataSourceProvider);
  return SmsRegexRuleRepositoryImpl(dataSource);
});

class SmsRegexRuleRepositoryImpl implements SmsRegexRuleRepository {
  final LocalSmsRegexRuleDataSource _dataSource;

  SmsRegexRuleRepositoryImpl(this._dataSource);

  @override
  Future<int> count() async {
    final models = await _dataSource.getAll();
    return models.length;
  }

  @override
  Future<bool> delete(SmsRegexRule entity) async {
    final result = await _dataSource.delete(entity.id);
    return result > 0;
  }

  @override
  Future<bool> deleteAll(List<SmsRegexRule> entities) async {
    final ids = entities.map((e) => e.id).toList();
    final result = await _dataSource.deleteAll(ids);
    return result > 0;
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  @override
  Future<bool> exists(String id) async {
    final model = await _dataSource.getById(id);
    return model != null;
  }

  @override
  SmsRegexRule fromMap(Map<String, dynamic> map) {
    return SmsRegexRule.fromMap(map);
  }

  @override
  Future<List<SmsRegexRule>> getAll() async {
    final models = await _dataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<SmsRegexRule?> getById(String id) async {
    final model = await _dataSource.getById(id);
    return model?.toEntity();
  }

  @override
  Future<SmsRegexRule> save(SmsRegexRule entity) async {
    final model = SmsRegexRuleModel.fromEntity(entity);
    await _dataSource.insert(model);
    return entity;
  }

  @override
  Future<List<SmsRegexRule>> saveAll(List<SmsRegexRule> entities) async {
    final models = entities.map((e) => SmsRegexRuleModel.fromEntity(e)).toList();
    await _dataSource.insertAll(models);
    return entities;
  }

  @override
  Future<SmsRegexRule> update(SmsRegexRule entity) async {
    final model = SmsRegexRuleModel.fromEntity(entity);
    await _dataSource.update(model);
    return entity;
  }
}