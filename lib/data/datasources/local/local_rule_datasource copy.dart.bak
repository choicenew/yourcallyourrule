// 本地规则数据源实现类，用于处理本地规则数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/allow_block_rule_model.dart';
import 'package:yourcallyourrule/data/models/regex_rule_model.dart';

import '../../../data/models/phone_rule_model.dart';
import '../../../data/models/rule_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地规则数据源实现
class LocalRuleDataSource implements LocalDataSource<RuleModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;

  // 表名
  static const String _tableName = 'rules';

  // 构造函数
  LocalRuleDataSource(this._databaseManager);

  // 获取所有规则
  @override
  Future<List<RuleModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'phone_rule':
       // case 'white_black': // 兼容旧数据
          return PhoneRuleModel.fromMap(map);
        case 'regex':
          return RegexRuleModel.fromMap(map);
        case 'allow_block':
          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    });
  }

  // 根据ID获取规则
  @override
  Future<RuleModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final map = maps.first;
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'phone_rule':
        //case 'white_black': //旧数据
          return PhoneRuleModel.fromMap(map);
        case 'regex':
          return RegexRuleModel.fromMap(map);
        case 'allow_block':
          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    }
    return null;
  }

  // 插入规则
  @override
  Future<String> insert(RuleModel rule) async {
    final db = await _databaseManager.database;

    // 如果没有ID，生成一个新的UUID
    final String id = rule.id.isEmpty ? const Uuid().v4() : rule.id;
    final RuleModel ruleWithId;

    // 根据规则类型创建不同的规则模型
    if (rule.id.isEmpty) {
      if (rule is PhoneRuleModel) {
        ruleWithId = PhoneRuleModel(
          id: id,
          name: rule.name,
          priority: rule.priority,
          action: rule.action,
          phoneNumber: rule.phoneNumber,
          labelId: rule.labelId,
          isSubscribed: rule.isSubscribed,
          count: rule.count,
          avatar: rule.avatar,
          isEnabled: rule.isEnabled,
        );
      } else if (rule is RegexRuleModel) {
        ruleWithId = RegexRuleModel(
          id: id,
          name: rule.name,
          priority: rule.priority,
          action: rule.action,
          pattern: rule.pattern,
          isEnabled: rule.isEnabled,
        );
      } else if (rule is AllowedBlockedRuleModel) {
        // 新增AllowedBlockedRuleModel处理
        ruleWithId = AllowedBlockedRuleModel(
          id: id,
          name: rule.name,
          priority: rule.priority,
          action: rule.action,
          phoneNumber: rule.phoneNumber,
          labelId: rule.labelId,
          isSubscribed: rule.isSubscribed,
          count: rule.count,
          avatar: rule.avatar,
          isEnabled: rule.isEnabled,
        );
      } else {
        throw Exception('Unknown rule type: ${rule.runtimeType}');
      }
    } else {
      ruleWithId = rule;
    }

    await db.insert(
      _tableName,
      ruleWithId.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  // 更新规则
  @override
  Future<int> update(RuleModel rule) async {
    final db = await _databaseManager.database;

    return await db.update(
      _tableName,
      rule.toMap(),
      where: 'id = ?',
      whereArgs: [rule.id],
    );
  }

  // 删除规则
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;

    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 批量插入规则
  @override
  Future<List<String>> insertAll(List<RuleModel> rules) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final rule in rules) {
        // 如果没有ID，生成一个新的UUID
        final String id = rule.id.isEmpty ? const Uuid().v4() : rule.id;
        final RuleModel ruleWithId;

        // 根据规则类型创建不同的规则模型
        if (rule.id.isEmpty) {
          if (rule is PhoneRuleModel) {
            ruleWithId = PhoneRuleModel(
              id: id,
              name: rule.name,
              priority: rule.priority,
              action: rule.action,
              phoneNumber: rule.phoneNumber,
              labelId: rule.labelId,
              isSubscribed: rule.isSubscribed,
              count: rule.count,
              avatar: rule.avatar,
              isEnabled: rule.isEnabled,
            );
          } else if (rule is RegexRuleModel) {
            ruleWithId = RegexRuleModel(
              id: id,
              name: rule.name,
              priority: rule.priority,
              action: rule.action,
              pattern: rule.pattern,
              isEnabled: rule.isEnabled,
            );
          } else if (rule is AllowedBlockedRuleModel) {
            // 新增AllowedBlockedRuleModel处理
            ruleWithId = AllowedBlockedRuleModel(
              id: id,
              name: rule.name,
              priority: rule.priority,
              action: rule.action,
              phoneNumber: rule.phoneNumber,
              labelId: rule.labelId,
              isSubscribed: rule.isSubscribed,
              count: rule.count,
              avatar: rule.avatar,
              isEnabled: rule.isEnabled,
            );
          } else {
            throw Exception('Unknown rule type: ${rule.runtimeType}');
          }
        } else {
          ruleWithId = rule;
        }

        await txn.insert(
          _tableName,
          ruleWithId.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        ids.add(id);
      }
    });

    return ids;
  }

  // 批量更新规则
  @override
  Future<int> updateAll(List<RuleModel> rules) async {
    int count = 0;
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final rule in rules) {
        final int updated = await txn.update(
          _tableName,
          rule.toMap(),
          where: 'id = ?',
          whereArgs: [rule.id],
        );

        count += updated;
      }
    });

    return count;
  }

  // 批量删除规则
  @override
  Future<int> deleteAll(List<String> ids) async {
    int count = 0;
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final id in ids) {
        final int deleted = await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );

        count += deleted;
      }
    });

    return count;
  }

  // 清空所有规则
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }

  // 导出规则数据
  @override
  Future<String> exportData() async {
    final rules = await getAll();
    final List<Map<String, dynamic>> ruleMaps =
        rules.map((rule) => rule.toMap()).toList();
    return jsonEncode(ruleMaps);
  }

  // 导入规则数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> ruleMaps = jsonDecode(data) as List<dynamic>;
      final List<RuleModel> rules = [];

      for (final map in ruleMaps) {
        final ruleMap = map as Map<String, dynamic>;
        // 根据规则类型创建不同的规则模型
        switch (ruleMap['ruleType']) {
          case 'phone_rule':
          case 'white_black': // 兼容旧数据
            rules.add(PhoneRuleModel.fromMap(ruleMap));
            break;
          case 'regex':
            rules.add(RegexRuleModel.fromMap(ruleMap));
            break;

          case 'allow_block': // 新增allow类block类型处理
            rules.add(AllowedBlockedRuleModel.fromMap(ruleMap));
            break;
          default:
            throw Exception('Unknown rule type: ${ruleMap['ruleType']}');
        }
      }

      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }

  // 根据规则类型获取规则
  Future<List<RuleModel>> getByRuleType(String ruleType) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'ruleType = ?',
      whereArgs: [ruleType],
    );

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (ruleType) {
        case 'phone_rule':
        case 'white_black': // 兼容旧数据
          return PhoneRuleModel.fromMap(map);
        case 'regex':
          return RegexRuleModel.fromMap(map);

        case 'allow_block': // 新增allow类block类型处理

          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: $ruleType');
      }
    });
  }

  // 获取启用的规则
  Future<List<RuleModel>> getEnabledRules() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isEnabled = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'phone_rule':
        case 'white_black': // 兼容旧数据
          return PhoneRuleModel.fromMap(map);
        case 'regex':
          return RegexRuleModel.fromMap(map);

        case 'allow_block': // 新增allow类block类型处理

          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    });
  }

  // 获取禁用的规则
  Future<List<RuleModel>> getDisabledRules() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isEnabled = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'phone_rule':
        case 'white_black': // 兼容旧数据
          return PhoneRuleModel.fromMap(map);
        case 'regex':
          return RegexRuleModel.fromMap(map);
        case 'allow_block': // 新增allow类block类型处理
          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    });
  }

  // 根据优先级获取规则
  Future<List<RuleModel>> getByPriority(int priority) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'priority = ?',
      whereArgs: [priority],
    );

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'phone_rule':
        case 'white_black': // 兼容旧数据
          return PhoneRuleModel.fromMap(map);
        case 'regex':
          return RegexRuleModel.fromMap(map);

        case 'allow_block': // 新增allow类block类型处理

          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    });
  }

  // 根据名称搜索规则
  Future<List<RuleModel>> searchByName(String name) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'phone_rule':
          return PhoneRuleModel.fromMap(map);
        case 'regex':
          return RegexRuleModel.fromMap(map);
        case 'allow_block':
          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    });
  }
}
