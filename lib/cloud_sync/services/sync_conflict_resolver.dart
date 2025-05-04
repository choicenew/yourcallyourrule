import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

enum ConflictResolutionStrategy {
  localWins,
  cloudWins,
  merge,
  askUser,
}

class SyncConflictResolver {
  final ConflictResolutionStrategy defaultStrategy;
  ConflictResolutionStrategy? userSelectedStrategy;
  
  SyncConflictResolver({this.defaultStrategy = ConflictResolutionStrategy.askUser});

  void updateResolutionStrategy(ConflictResolutionStrategy strategy) {
    userSelectedStrategy = strategy;
  }

  String calculateEntitiesHash(List<RuleBase> entities) {
    final sortedRules = List<RuleBase>.from(entities)
      ..sort((a, b) => a.id.compareTo(b.id));
    
    final jsonString = jsonEncode(
      sortedRules.map((rule) => CloudDataConverter.serialize(rule)).toList()
    );
    return _generateHash(jsonString);
  }

  String calculateSettingsHash(Map<String, dynamic> settings) {
    final sortedKeys = settings.keys.toList()..sort();
    final sortedMap = <String, dynamic>{}..addEntries(
      sortedKeys.map((key) => MapEntry(key, settings[key]))
    );
    return _generateHash(jsonEncode(sortedMap));
  }

  String _generateHash(String input) => sha256.convert(utf8.encode(input)).toString();

  Future<Map<String, dynamic>> resolveConflicts(Map<String, dynamic> conflicts) async {
    final resolvedData = <String, dynamic>{};
    
    for (final entry in conflicts.entries) {
      final strategy = await _determineStrategy(entry.key, entry.value['local'], entry.value['cloud']);
      resolvedData[entry.key] = await _applyResolutionStrategy(strategy, entry.value);
    }
    
    return resolvedData;
  }

  Future<ConflictResolutionStrategy> _determineStrategy(String key, dynamic local, dynamic cloud) async {
    if (userSelectedStrategy != null) return userSelectedStrategy!;
    if (defaultStrategy != ConflictResolutionStrategy.askUser) return defaultStrategy;
    
    final localHash = local is List<RuleBase> ? calculateEntitiesHash(local) : _generateHash(jsonEncode(local));
    final cloudHash = cloud is List<RuleBase> ? calculateEntitiesHash(cloud) : _generateHash(jsonEncode(cloud));
    
    return localHash == cloudHash ? ConflictResolutionStrategy.localWins 
      : key.contains('rule') ? ConflictResolutionStrategy.merge
      : ConflictResolutionStrategy.askUser;
  }

  Future<dynamic> _applyResolutionStrategy(ConflictResolutionStrategy strategy, Map<String, dynamic> conflict) async {
    switch (strategy) {
      case ConflictResolutionStrategy.localWins:
        return conflict['local'];
      case ConflictResolutionStrategy.cloudWins:
        return conflict['cloud'];
      case ConflictResolutionStrategy.merge:
        return _mergeData(conflict['local'], conflict['cloud']);
      default:
        return conflict['local'];
    }
  }

  dynamic _mergeData(dynamic local, dynamic cloud) {
    if (local is List<RuleBase> && cloud is List<RuleBase>) {
      final merged = <RuleBase>[];
      final cloudIds = cloud.map((e) => e.id).toSet();
      
      // 保留本地独有的规则
      merged.addAll(local.where((localRule) => !cloudIds.contains(localRule.id)));
      
      // 合并云端规则（覆盖本地同名规则）
      merged.addAll(cloud);
      
      // 对合并后的规则进行排序
      return merged..sort((a, b) => a.id.compareTo(b.id));
    }
    
    if (local is Map<String, dynamic> && cloud is Map<String, dynamic>) {
      // 深度合并map
      return _deepMergeMaps(local, cloud);
    }
    
    // 非集合类型直接返回本地版本
    return local;
  }

  Map<String, dynamic> _deepMergeMaps(Map<String, dynamic> local, Map<String, dynamic> cloud) {
    final merged = Map<String, dynamic>.from(local);
    
    cloud.forEach((key, cloudValue) {
      if (merged.containsKey(key)) {
        final localValue = merged[key];
        
        if (localValue is Map<String, dynamic> && cloudValue is Map<String, dynamic>) {
          merged[key] = _deepMergeMaps(localValue, cloudValue);
        } else if (localValue is List<RuleBase> && cloudValue is List<RuleBase>) {
          merged[key] = _mergeData(localValue, cloudValue);
        } else {
          merged[key] = cloudValue;
        }
      } else {
        merged[key] = cloudValue;
      }
    });
    
    return merged;
  }
}