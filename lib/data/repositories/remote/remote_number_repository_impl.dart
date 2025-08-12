import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/data/database/remote/remote_data_access_restriction.dart';

/// 远程号码仓库实现类
/// 负责管理远程号码数据的存储和检索
class RemoteNumberRepositoryImpl implements RuleRepository {
  final ConfigRepository _configRepository;
  final RemoteDataAccessRestriction _remoteDataAccess;
  
  // 配置键
  static const String _configKey = 'config_remote_numbers';
  
  // 构造函数
  RemoteNumberRepositoryImpl(this._configRepository) : 
    _remoteDataAccess = RemoteDataAccessRestrictionImpl();
  
  @override
  Future<List<RemoteNumberEntry>> getAll() async {
    final config = await _configRepository.getConfig(_configKey);
    if (config == null) {
      return [];
    }
    
    final List<dynamic> entries = config['entries'] ?? [];
    return entries.map((entry) => RemoteNumberEntry.fromMap(entry)).toList();
  }
  
  @override
  Future<RemoteNumberEntry?> getById(String id) async {
    final entries = await getAll();
    try {
      return entries.firstWhere((entry) => entry.id == id);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<RemoteNumberEntry> save(dynamic entity) async {
    if (entity is! RemoteNumberEntry) {
      throw ArgumentError('Entity must be a RemoteNumberEntry');
    }
    
    final entries = await getAll();
    entries.add(entity);
    await _saveEntries(entries);
    return entity;
  }
  
  @override
  Future<List<RemoteNumberEntry>> saveAll(List<dynamic> entities) async {
    if (entities.isEmpty) {
      return [];
    }
    
    if (entities.first is! RemoteNumberEntry) {
      throw ArgumentError('Entities must be RemoteNumberEntry instances');
    }
    
    final List<RemoteNumberEntry> typedEntities = entities.cast<RemoteNumberEntry>();
    final entries = await getAll();
    entries.addAll(typedEntities);
    await _saveEntries(entries);
    return typedEntities;
  }
  
  @override
  Future<RemoteNumberEntry> update(dynamic entity) async {
    if (entity is! RemoteNumberEntry) {
      throw ArgumentError('Entity must be a RemoteNumberEntry');
    }
    
    final entries = await getAll();
    final index = entries.indexWhere((e) => e.id == entity.id);
    
    if (index >= 0) {
      entries[index] = entity;
      await _saveEntries(entries);
    } else {
      throw Exception('Entity not found');
    }
    return entity;
  }
  
  @override
  Future<bool> delete(dynamic entity) async {
    if (entity is! RemoteNumberEntry) {
      throw ArgumentError('Entity must be a RemoteNumberEntry');
    }
    
    return await deleteById(entity.id);
  }
  
  @override
  Future<bool> deleteById(String id) async {
    final entries = await getAll();
    final initialLength = entries.length;
    
    entries.removeWhere((entry) => entry.id == id);
    
    if (entries.length != initialLength) {
      await _saveEntries(entries);
      return true;
    }
    
    return false;
  }
  
  // 保存所有条目到配置
  Future<void> _saveEntries(List<RemoteNumberEntry> entries) async {
    final entriesJson = entries.map((e) => e.toMap()).toList();
    await _configRepository.saveConfig(_configKey, {'entries': entriesJson});
  }
  
  // 根据电话号码查询远程号码
  Future<RemoteNumberEntry?> getByPhoneNumber(PhoneNumber phoneNumber) async {
    final entries = await getAll();
    try {
      return entries.firstWhere(
        (entry) => entry.phoneNumber.value == phoneNumber.value,
      );
    } catch (e) {
      return null;
    }
  }
  
  // 查询远程号码信息
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumber) async {
    return await _remoteDataAccess.queryRemoteNumberInfo(phoneNumber);
  }
  
  @override
  RuleBase createRuleFromMap(Map<String, dynamic> map) {
    return RemoteNumberEntry.fromMap(map);
  }

  @override
  RuleBase createEmptyRule() {
    return RemoteNumberEntry(
      id: '',
      priority: RulePriority.fromInt(0),
      phoneNumber: PhoneNumber.fromString(''),
      label: ''
    );
  }

  Future<List<RuleBase>> getAllByType(String type) async {
    // 由于RemoteNumberEntry没有type属性，直接返回空列表
    return [];
  }

  @override
  Future<List<RuleBase>> getAllDisabled() async {
    final entries = await getAll();
    return entries.where((entry) => !entry.isEnabled).toList();
  }

  @override
  Future<List<RuleBase>> getAllEnabled() async {
    final entries = await getAll();
    return entries.where((entry) => entry.isEnabled).toList();
  }

  @override
  Future<RuleBase?> getRuleById(String ruleId) async {
    return await getById(ruleId);
  }

  @override
  Future<List<RuleBase>> getRulesByType(String type) async {
    return await getAllByType(type);
  }

  @override
  Future<List<RuleBase>> searchByName(String name) async {
    final entries = await getAll();
    return entries.where((entry) => 
      entry.label.toLowerCase().contains(name.toLowerCase())).toList();
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    await deleteById(ruleId);
  }

  @override
  Future<void> saveRule(RuleBase rule) async {
    if (rule is RemoteNumberEntry) {
      await save(rule);
    } else {
      throw ArgumentError('Rule must be a RemoteNumberEntry');
    }
  }

  @override
  Future<void> updateRule(RuleBase rule) async {
    if (rule is RemoteNumberEntry) {
      await update(rule);
    } else {
      throw ArgumentError('Rule must be a RemoteNumberEntry');
    }
  }

  @override
  Future<RuleBase> updateEnabledStatus(String id, bool isEnabled) async {
    final entry = await getById(id);
    if (entry == null) {
      throw Exception('Entry not found');
    }
    
    final updatedEntry = entry.copyWith(isEnabled: isEnabled);
    await update(updatedEntry);
    return updatedEntry;
  }

  @override
  Future<RuleBase> updatePriority(String id, int priority) async {
    final entry = await getById(id);
    if (entry == null) {
      throw Exception('Entry not found');
    }
    
    final updatedEntry = entry.copyWith(priority: RulePriority.fromInt(priority));
    await update(updatedEntry);
    return updatedEntry;
  }
  
  // 实现BaseRepository接口中缺少的方法
  
  @override
  Future<bool> deleteAll(List<dynamic> entities) async {
    if (entities.isEmpty) {
      return true;
    }
    
    bool allDeleted = true;
    for (final entity in entities) {
      if (entity is RemoteNumberEntry) {
        final success = await delete(entity);
        if (!success) {
          allDeleted = false;
        }
      } else {
        throw ArgumentError('Entity must be a RemoteNumberEntry');
      }
    }
    
    return allDeleted;
  }
  
  @override
  Future<bool> exists(String id) async {
    final entry = await getById(id);
    return entry != null;
  }
  
  @override
  Future<int> count() async {
    final entries = await getAll();
    return entries.length;
  }
  
  @override
  RemoteNumberEntry fromMap(Map<String, dynamic> map) {
    return RemoteNumberEntry.fromMap(map);
  }
}