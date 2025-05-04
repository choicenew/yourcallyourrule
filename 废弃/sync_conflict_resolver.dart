import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import '../core/entities/rule/rule_base.dart';

/// 冲突解决策略枚举
enum ConflictResolutionStrategy {
  /// 使用本地版本
  useLocal,

  /// 使用云端版本
  useCloud,

  /// 合并版本（尝试智能合并）
  merge,

  /// 询问用户
  askUser,
}

/// 同步冲突解决器
/// 负责处理云同步过程中的数据冲突
class SyncConflictResolver {
  /// 计算规则集合哈希值
  String calculateEntitiesHash(List<dynamic> entities) {
    final sortedEntities = _sortEntities(entities);
    final jsonString = jsonEncode(
      sortedEntities.map((entity) => CloudDataConverter.serialize(entity)).toList(),
    );
    return _generateHash(jsonString);
  }

  /// 计算设置项哈希值
  String calculateSettingsHash(Map<String, dynamic> settings) {
    final sortedKeys = settings.keys.toList()..sort();
    final sortedMap = <String, dynamic>{};
    for (final key in sortedKeys) {
      sortedMap[key] = settings[key];
    }
    return _generateHash(jsonEncode(sortedMap));
  }

  String _generateHash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  List<dynamic> _sortEntities(List<dynamic> entities) {
    final sorted = List<dynamic>.from(entities);
    sorted.sort((a, b) => (a.id as Comparable).compareTo(b.id));
    return sorted;
  }

  Map<String, dynamic> _serializeRule(RuleBase rule) {
    return CloudDataConverter.serialize(rule);
  }

  /// 默认冲突解决策略
  final ConflictResolutionStrategy defaultStrategy;

  /// 用户选择的冲突解决策略
  ConflictResolutionStrategy? _userSelectedStrategy;

  /// 用户选择策略的Completer
  Completer<ConflictResolutionStrategy>? _strategyCompleter;

  /// 构造函数
  SyncConflictResolver({
    this.defaultStrategy = ConflictResolutionStrategy.askUser,
  });

  /// 设置用户选择的冲突解决策略
  void setUserSelectedStrategy(ConflictResolutionStrategy strategy) {
    _userSelectedStrategy = strategy;
    _strategyCompleter?.complete(strategy);
    _strategyCompleter = null;
  }

  /// 解决冲突
  Future<Map<String, dynamic>> resolveConflicts(
      Map<String, dynamic> conflicts) async {
    final resolvedData = <String, dynamic>{};

    for (final entry in conflicts.entries) {
      final key = entry.key;
      final conflict = entry.value as Map<String, dynamic>;

      final localData = conflict['local'];
      final cloudData = conflict['cloud'];
      final strategy =
          await _determineStrategy(key, localData, cloudData);

      switch (strategy) {
        case ConflictResolutionStrategy.useLocal:
          resolvedData[key] = localData;
          break;
        case ConflictResolutionStrategy.useCloud:
          resolvedData[key] = cloudData;
          break;
        case ConflictResolutionStrategy.merge:
          resolvedData[key] = await _mergeData(key, localData, cloudData);
          break;
        case ConflictResolutionStrategy.askUser:
          // 如果用户已经选择了策略，使用该策略
          if (_userSelectedStrategy != null) {
            final userStrategy = _userSelectedStrategy!;
            _userSelectedStrategy = null; // 重置用户选择

            switch (userStrategy) {
              case ConflictResolutionStrategy.useLocal:
                resolvedData[key] = localData;
                break;
              case ConflictResolutionStrategy.useCloud:
                resolvedData[key] = cloudData;
                break;
              case ConflictResolutionStrategy.merge:
                resolvedData[key] = await _mergeData(key, localData, cloudData);
                break;
              case ConflictResolutionStrategy.askUser:
                // 如果用户选择了askUser，默认使用本地版本
                resolvedData[key] = localData;
                break;
            }
          } else {
            // 等待用户选择
            _strategyCompleter = Completer<ConflictResolutionStrategy>();
            final userStrategy = await _strategyCompleter!.future;

            switch (userStrategy) {
              case ConflictResolutionStrategy.useLocal:
                resolvedData[key] = localData;
                break;
              case ConflictResolutionStrategy.useCloud:
                resolvedData[key] = cloudData;
                break;
              case ConflictResolutionStrategy.merge:
                resolvedData[key] = await _mergeData(key, localData, cloudData);
                break;
              case ConflictResolutionStrategy.askUser:
                // 如果用户选择了askUser，默认使用本地版本
                resolvedData[key] = localData;
                break;
            }
          }
          break;
      }
    }

    return resolvedData;
  }

  /// 确定解决策略
  Future<ConflictResolutionStrategy> _determineStrategy(
    String key,
    dynamic localData,
    dynamic cloudData,
  ) async {
    // 如果有默认策略且不是askUser，使用默认策略
    if (defaultStrategy != ConflictResolutionStrategy.askUser) {
      return defaultStrategy;
    }

    // 基于哈希值的冲突解决逻辑
    final localHash = calculateEntitiesHash(localData as List<dynamic>);
    final cloudHash = calculateEntitiesHash(cloudData as List<dynamic>);

    if (localHash == cloudHash) {
      return ConflictResolutionStrategy.useLocal;
    }

    // 如果是规则数据，尝试合并
    if (key.contains('rule') || key.contains('Rule')) {
      return ConflictResolutionStrategy.merge;
    }

    // 默认询问用户
    return ConflictResolutionStrategy.askUser;
  }

  /// 合并数据
  Future<dynamic> _mergeData(
      String key, dynamic localData, dynamic cloudData) async {
    // 如果是列表类型，尝试合并列表
    if (localData is List && cloudData is List) {
      return _mergeLists(localData, cloudData, key);
    }

    // 如果是Map类型，尝试合并Map
    if (localData is Map && cloudData is Map) {
      return _mergeMaps(
          localData as Map<String, dynamic>, cloudData as Map<String, dynamic>);
    }

    // 其他类型默认使用本地版本
    return localData;
  }

  /// 合并列表
  List<dynamic> _mergeLists(
      List<dynamic> localList, List<dynamic> cloudList, String key) {
    // 如果是规则列表，使用规则合并逻辑
    if (key.contains('rule') || key.contains('Rule')) {
      return _mergeRuleLists(localList, cloudList);
    }

    // 创建一个新列表，包含本地和云端的所有唯一项
    final mergedList = <dynamic>[];
    final seenItems = <String>{};

    // 添加本地项
    for (final item in localList) {
      final itemId = _getItemId(item);
      if (itemId != null) {
        seenItems.add(itemId);
      }
      mergedList.add(item);
    }

    // 添加云端唯一项
    for (final item in cloudList) {
      final itemId = _getItemId(item);
      if (itemId != null && !seenItems.contains(itemId)) {
        mergedList.add(item);
      }
    }

    return mergedList;
  }

  /// 合并规则列表
  List<dynamic> _mergeRuleLists(
      List<dynamic> localRules, List<dynamic> cloudRules) {
    final mergedRules = <dynamic>[];
    final localRuleMap = <String, dynamic>{};
    final cloudRuleMap = <String, dynamic>{};

    // 将本地规则按ID映射
    for (final rule in localRules) {
      final ruleId = _getRuleId(rule);
      if (ruleId != null) {
        localRuleMap[ruleId] = rule;
      } else {
        mergedRules.add(rule); // 没有ID的规则直接添加
      }
    }

    // 将云端规则按ID映射
    for (final rule in cloudRules) {
      final ruleId = _getRuleId(rule);
      if (ruleId != null) {
        cloudRuleMap[ruleId] = rule;
      }
    }

    // 处理所有规则ID
    final allRuleIds = <String>{};
    allRuleIds.addAll(localRuleMap.keys);
    allRuleIds.addAll(cloudRuleMap.keys);

    for (final ruleId in allRuleIds) {
      final localRule = localRuleMap[ruleId];
      final cloudRule = cloudRuleMap[ruleId];

      if (localRule != null && cloudRule != null) {
        // 两边都有，比较修改时间
        final localHash = calculateEntitiesHash([localRule]);
        final cloudHash = calculateEntitiesHash([cloudRule]);

        if (localHash != cloudHash) {
          mergedRules.add(localRule);
        } else {
          mergedRules.add(cloudRule);
        }
      } else if (localRule != null) {
        // 只有本地有，使用本地版本
        mergedRules.add(localRule);
      } else if (cloudRule != null) {
        // 只有云端有，使用云端版本
        mergedRules.add(cloudRule);
      }
    }

    return mergedRules;
  }

  /// 合并Map
  Map<String, dynamic> _mergeMaps(
      Map<String, dynamic> localMap, Map<String, dynamic> cloudMap) {
    final mergedMap = <String, dynamic>{};

    // 合并所有键
    final allKeys = <String>{};
    allKeys.addAll(localMap.keys);
    allKeys.addAll(cloudMap.keys);

    for (final key in allKeys) {
      final localValue = localMap[key];
      final cloudValue = cloudMap[key];

      if (localValue != null && cloudValue != null) {
        // 两边都有值
        if (localValue is Map && cloudValue is Map) {
          // 递归合并Map
          mergedMap[key] = _mergeMaps(
            localValue as Map<String, dynamic>,
            cloudValue as Map<String, dynamic>,
          );
        } else if (localValue is List && cloudValue is List) {
          // 合并列表
          mergedMap[key] = _mergeLists(localValue, cloudValue, key);
        } else {
          // 其他类型使用本地版本
          mergedMap[key] = localValue;
        }
      } else if (localValue != null) {
        // 只有本地有值
        mergedMap[key] = localValue;
      } else if (cloudValue != null) {
        // 只有云端有值
        mergedMap[key] = cloudValue;
      }
    }

    return mergedMap;
  }

  /// 获取项目ID
  String? _getItemId(dynamic item) {
    if (item is Map<String, dynamic>) {
      if (item.containsKey('id')) {
        return item['id'].toString();
      } else if (item.containsKey('uuid')) {
        return item['uuid'].toString();
      } else if (item.containsKey('identifier')) {
        return item['identifier'].toString();
      }
    } else if (item is RuleBase) {
      return item.id.toString();
    }
    return null;
  }

  /// 获取规则ID
  String? _getRuleId(dynamic rule) {
    if (rule is Map<String, dynamic>) {
      if (rule.containsKey('id')) {
        return rule['id'].toString();
      } else if (rule.containsKey('ruleId')) {
        return rule['ruleId'].toString();
      }
    } else if (rule is RuleBase) {
      return rule.id.toString();
    }
    return null;
  }


}
