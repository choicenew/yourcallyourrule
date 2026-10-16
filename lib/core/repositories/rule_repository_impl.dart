import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_label_datasource_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_phone_rule_datasource_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_regex_rule_datasource_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_sim_slot_rule_datasource_provider.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/datasources/local/local_phone_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sim_slot_rule_datasource.dart';
import 'package:yourcallyourrule/data/models/allow_block_rule_model.dart';
import 'package:yourcallyourrule/data/models/phone_rule_model.dart';
import 'package:yourcallyourrule/data/models/regex_rule_model.dart';
import 'package:yourcallyourrule/data/models/label_phone_model.dart';
import 'package:yourcallyourrule/data/models/sim_slot_rule_model.dart';
import 'package:yourcallyourrule/data/models/rule_model.dart';

part 'rule_repository_impl.g.dart';

/// 自动生成的 RuleRepositoryImpl Provider
@riverpod
RuleRepositoryImpl ruleRepositoryImpl(Ref ref) {
  return RuleRepositoryImpl(
    ref.watch(localPhoneRuleDataSourceProvider),
    ref.watch(localRegexRuleDataSourceProvider),
    ref.watch(localLabelDataSourceProvider),
    ref.watch(localSimSlotRuleDataSourceProvider),
  );
}

/// 规则仓库实现类
class RuleRepositoryImpl implements RuleRepository {
  final LocalPhoneRuleDataSource _localPhoneRuleDataSource;
  final LocalRegexRuleDataSource _localRegexRuleDataSource;
  final LocalLabelDataSource _localLabelDataSource;
  final LocalSimSlotRuleDataSource _localSimSlotRuleDataSource;
  
  // 内部分发映射表，用于保存不同类型的模型
  late final Map<Type, Future<void> Function(RuleModel model)> _saveDispatchMap;


  RuleRepositoryImpl(
    this._localPhoneRuleDataSource,
    this._localRegexRuleDataSource,
    this._localLabelDataSource,
    this._localSimSlotRuleDataSource,
  ) {
    // 在构造函数中初始化分发映射表
    _setupUpdateDispatch();
    _setupSaveDispatch();
  }
  
  // 设置保存分发映射表
  void _setupSaveDispatch() {
    _saveDispatchMap = {
      PhoneRuleModel: (model) async => await _localPhoneRuleDataSource.insert(model as PhoneRuleModel),
      AllowedBlockedRuleModel: (model) async {
        // 在这里进行安全的转换
        final phoneModel = PhoneRuleModel.fromMap(model.toMap());
        await _localPhoneRuleDataSource.insert(phoneModel);
      },
      RegexRuleModel: (model) async => await _localRegexRuleDataSource.insert(model as RegexRuleModel),
      SimSlotRuleModel: (model) async => await _localSimSlotRuleDataSource.insert(model as SimSlotRuleModel),
      LabelModel: (model) async => await _localLabelDataSource.insert(model as LabelModel),
    };
  }
  
  // 内部工厂方法，根据实体类型创建对应的模型
  RuleModel _createModelFromEntity(RuleBase entity) {
    if (entity is PhoneRule) {
      return PhoneRuleModel.fromEntity(entity);
    } else if (entity is AllowedBlockedRule) {
      return AllowedBlockedRuleModel.fromEntity(entity);
    } else if (entity is RegexRule) {
      return RegexRuleModel.fromEntity(entity);
    } else if (entity is LabelPhoneEntry) {
      return LabelModel.fromEntity(entity);
    } else if (entity is SimSlotRule) {
      return SimSlotRuleModel.fromEntity(entity);
    }
    // 当未来有新的Rule类型时，只需要修改这一个地方
    throw ArgumentError('Unsupported rule type for model creation: ${entity.runtimeType}');
  }

  @override
  RuleBase createEmptyRule() {
    throw UnimplementedError();
  }

  @override
  RuleBase createRuleFromMap(Map<String, dynamic> map) {
    final type = RuleType.fromString(map['ruleType']);
    
    switch (type) {
      case RuleType.phone:
        return PhoneRule.fromMap(map);
      case RuleType.regex:
        return RegexRule.fromMap(map);
      case RuleType.allowBlock:
        return AllowedBlockedRule.fromMap(map);
      case RuleType.simSlot:
        return SimSlotRule.fromMap(map);
      case RuleType.smsRegex:
        throw UnsupportedError('SMS regex rules are managed by SmsRegexRuleRepository');
    }
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    await deleteById(ruleId);
  }

  Future<List<RuleBase>> getAllByType(String typeStr) async {
    final allRules = await getAll();
    final type = RuleType.fromString(typeStr);
    
    switch (type) {
      case RuleType.phone:
        return allRules.whereType<PhoneRule>().toList();
      case RuleType.regex:
        return allRules.whereType<RegexRule>().toList();
      case RuleType.allowBlock:
        return allRules.whereType<AllowedBlockedRule>().toList();
      case RuleType.simSlot:
        return allRules.whereType<SimSlotRule>().toList();
      case RuleType.smsRegex:
        return []; // 短信规则由专用的 SmsRegexRuleRepository 管理
    }
  }

  @override
  Future<List<RuleBase>> getRulesByType(String type) async {
    return getAllByType(type);
  }

  @override
  Future<RuleBase?> getRuleById(String ruleId) async {
    return getById(ruleId);
  }

  @override
  Future<void> saveRule(RuleBase rule) async {
    try {
      final model = _createModelFromEntity(rule);
      final saveFunction = _saveDispatchMap[model.runtimeType];
      
      if (saveFunction != null) {
        await saveFunction(model);
      } else {
        throw UnimplementedError('No save handler for model type: ${model.runtimeType}');
      }
    } catch (e) {
      debugPrint('保存规则失败: $e');
      throw e;
    }
  }

  @override
  Future<void> updateRule(RuleBase rule) async {
    await update(rule);
  }

  @override
  Future<List<RuleBase>> searchByName(String name) async {
    final allRules = await getAll();
    return allRules
        .where((rule) =>
            rule.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  @override
  Future<RuleBase> updateEnabledStatus(String id, bool isEnabled) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found: $id');
    }
    if (rule is PhoneRule) {
      final updated = rule.copyWith(isEnabled: isEnabled);
      await update(updated);
      return updated;
    } else if (rule is AllowedBlockedRule) {
      final updated = rule.copyWith(isEnabled: isEnabled);
      await update(updated);
      return updated;
    } else if (rule is SimSlotRule) {
      final updated = rule.copyWith(isEnabled: isEnabled);
      await update(updated);
      return updated;
    }
    return rule;
  }

  @override
  Future<RuleBase> updatePriority(String id, int priority) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found: $id');
    }
    final rulePriority = RulePriority.fromInt(priority);
    if (rule is PhoneRule) {
      final updated = rule.copyWith(priority: rulePriority);
      await update(updated);
      return updated;
    } else if (rule is AllowedBlockedRule) {
      final updated = rule.copyWith(priority: rulePriority);
      await update(updated);
      return updated;
    } else if (rule is SimSlotRule) {
      final updated = rule.copyWith(priority: rulePriority);
      await update(updated);
      return updated;
    }
    return rule;
  }

  @override
  Future<List<RuleBase>> getAllEnabled() async {
    final allRules = await getAll();
    return allRules.where((rule) => rule.isEnabled).toList();
  }

  @override
  Future<List<RuleBase>> getAllDisabled() async {
    final allRules = await getAll();
    return allRules.where((rule) => !rule.isEnabled).toList();
  }

  @override
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumberStr) async {
    // 实现远程号码查询逻辑
    return null;
  }

  @override
  Future<bool> syncRemoteNumbers() async {
    // 实现远程号码同步逻辑
    return true;
  }

  @override
  Future<bool> delete(RuleBase entity) async {
    if (entity is PhoneRule) {
      await _localPhoneRuleDataSource.delete(entity.id);
      return true;
    } else if (entity is RegexRule) {
      await _localRegexRuleDataSource.delete(entity.id);
      return true;
    } else if (entity is LabelPhoneEntry) {
      await _localLabelDataSource.delete(entity.id);
      return true;
    } else if (entity is SimSlotRule) {
      await _localSimSlotRuleDataSource.delete(entity.id);
      return true;
    } else {
      throw Exception('Unsupported rule type for delete: ${entity.runtimeType}');
    }
  }

  @override
  Future<bool> deleteById(String id) async {
    try {
      await _localPhoneRuleDataSource.delete(id);
      return true;
    } catch (e) {
      try {
        await _localRegexRuleDataSource.delete(id);
        return true;
      } catch (e) {
        try {
          await _localLabelDataSource.delete(id);
          return true;
        } catch (e) {
          try {
            await _localSimSlotRuleDataSource.delete(id);
            return true;
          } catch (e) {
            debugPrint('Error deleting rule: $e');
            return false;
          }
        }
      }
    }
  }
  
  @override
  Future<bool> deleteAll(List<RuleBase> entities) async {
    if (entities.isEmpty) return true;

    final phoneIds = <String>[];
    final regexIds = <String>[];
    final simSlotIds = <String>[];
    final labelIds = <String>[];

    for (final entity in entities) {
      if (entity is PhoneRule || entity is AllowedBlockedRule) {
        phoneIds.add(entity.id);
      } else if (entity is RegexRule) {
        regexIds.add(entity.id);
      } else if (entity is SimSlotRule) {
        simSlotIds.add(entity.id);
      } else if (entity is LabelPhoneEntry) {
        labelIds.add(entity.id);
      }
    }

    if (phoneIds.isNotEmpty) {
      await _localPhoneRuleDataSource.deleteAll(phoneIds);
    }
    if (regexIds.isNotEmpty) {
      await _localRegexRuleDataSource.deleteAll(regexIds);
    }
    if (simSlotIds.isNotEmpty) {
      await _localSimSlotRuleDataSource.deleteAll(simSlotIds);
    }
    if (labelIds.isNotEmpty) {
      await _localLabelDataSource.deleteAll(labelIds);
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
    final phoneCount = await _localPhoneRuleDataSource.count();
    final regexCount = await _localRegexRuleDataSource.count();
    return phoneCount + regexCount;
  }

  @override
  Future<List<RuleBase>> getAll() async {
    final phoneRules = await _localPhoneRuleDataSource.getAll();
    final regexRules = await _localRegexRuleDataSource.getAll();
    final simSlotRules = await _localSimSlotRuleDataSource.getAll();
    final labelRules = await _localLabelDataSource.getAll();
    
    final List<RuleBase> allRules = [];
    
    // 转换PhoneRule
    for (final model in phoneRules) {
      allRules.add(_convertPhoneRuleModelToEntity(model));
    }
    
    // 转换RegexRule
    allRules.addAll(regexRules.map((model) => RegexRule.fromMap(model.toMap())));
    
    // 转换SimSlotRule
    allRules.addAll(simSlotRules.map((model) => SimSlotRule.fromMap(model.toMap())));
    
    // 转换LabelPhoneEntry
    allRules.addAll(labelRules.map((model) => model.toEntity()));
    
    return allRules;
  }

  /// 辅助转换：统一基于 RuleType 强类型枚举判定 PhoneRuleModel 的实体类型
  RuleBase _convertPhoneRuleModelToEntity(PhoneRuleModel model) {
    final map = model.toMap();
    final type = RuleType.fromString(map['ruleType']);
    if (type == RuleType.allowBlock) {
      return AllowedBlockedRule.fromMap(map);
    }
    return PhoneRule.fromMap(map);
  }

  @override
  Future<RuleBase?> getById(String id) async {
    // 尝试从PhoneRule数据源获取
    PhoneRuleModel? phoneModel = await _localPhoneRuleDataSource.getById(id);
    if (phoneModel != null) {
      return _convertPhoneRuleModelToEntity(phoneModel);
    }
    
    // 尝试从LabelDataSource获取
    LabelModel? labelModel = await _localLabelDataSource.getById(id);
    if (labelModel != null) {
      return labelModel.toEntity();
    }
    
    // 尝试从RegexRule数据源获取
    RegexRuleModel? regexModel = await _localRegexRuleDataSource.getById(id);
    if (regexModel != null) {
      return RegexRule.fromMap(regexModel.toMap());
    }

    // 尝试从SimSlotRule数据源获取
    SimSlotRuleModel? simSlotModel = await _localSimSlotRuleDataSource.getById(id);
    if (simSlotModel != null) {
      return SimSlotRule.fromMap(simSlotModel.toMap());
    }
    
    // 未找到规则
    return null;
  }

  @override
  Future<RuleBase> save(RuleBase entity) async {
    try {
      final model = _createModelFromEntity(entity);
      final saveFunction = _saveDispatchMap[model.runtimeType];
      
      if (saveFunction != null) {
        await saveFunction(model);
        return entity;
      } else {
        throw UnimplementedError('No save handler for model type: ${model.runtimeType}');
      }
    } catch (e) {
      debugPrint('保存规则失败: $e');
      throw Exception('Unsupported rule type for save: ${entity.runtimeType}');
    }
  }

  @override
  Future<List<RuleBase>> saveAll(List<RuleBase> entities) async {
    if (entities.isEmpty) return [];

    final phoneModels = <PhoneRuleModel>[];
    final regexModels = <RegexRuleModel>[];
    final simSlotModels = <SimSlotRuleModel>[];
    final labelModels = <LabelModel>[];

    for (final entity in entities) {
      final model = _createModelFromEntity(entity);
      if (model is PhoneRuleModel) {
        phoneModels.add(model);
      } else if (model is AllowedBlockedRuleModel) {
        phoneModels.add(PhoneRuleModel.fromMap(model.toMap()));
      } else if (model is RegexRuleModel) {
        regexModels.add(model);
      } else if (model is SimSlotRuleModel) {
        simSlotModels.add(model);
      } else if (model is LabelModel) {
        labelModels.add(model);
      }
    }

    if (phoneModels.isNotEmpty) {
      await _localPhoneRuleDataSource.insertAll(phoneModels);
    }
    if (regexModels.isNotEmpty) {
      await _localRegexRuleDataSource.insertAll(regexModels);
    }
    if (simSlotModels.isNotEmpty) {
      await _localSimSlotRuleDataSource.insertAll(simSlotModels);
    }
    if (labelModels.isNotEmpty) {
      await _localLabelDataSource.insertAll(labelModels);
    }

    return entities;
  }

  // 内部分发映射表，用于更新不同类型的模型
  late final Map<Type, Future<void> Function(RuleModel model)> _updateDispatchMap;
  
  // 设置更新分发映射表
  void _setupUpdateDispatch() {
    _updateDispatchMap = {
      PhoneRuleModel: (model) async => await _localPhoneRuleDataSource.update(model as PhoneRuleModel),
      AllowedBlockedRuleModel: (model) async {
        // 在这里进行安全的转换
        final phoneModel = PhoneRuleModel.fromMap(model.toMap());
        await _localPhoneRuleDataSource.update(phoneModel);
      },
      RegexRuleModel: (model) async => await _localRegexRuleDataSource.update(model as RegexRuleModel),
      LabelModel: (model) async => await _localLabelDataSource.update(model as LabelModel),
      SimSlotRuleModel: (model) async => await _localSimSlotRuleDataSource.update(model as SimSlotRuleModel),
    };
  }
  
  @override
  Future<RuleBase> update(RuleBase entity) async {
    try {
      final model = _createModelFromEntity(entity);
      final updateFunction = _updateDispatchMap[model.runtimeType];
      
      if (updateFunction != null) {
        await updateFunction(model);
        return entity;
      } else {
        throw UnimplementedError('No update handler for model type: ${model.runtimeType}');
      }
    } catch (e) {
      debugPrint('更新规则失败: $e');
      throw Exception('Unsupported rule type for update: ${entity.runtimeType}');
    }
  }
  
  @override
  RuleBase fromMap(Map<String, dynamic> map) {
    return createRuleFromMap(map);
  }
}