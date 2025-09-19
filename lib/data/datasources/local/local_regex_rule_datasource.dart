// 本地正则规则数据源实现类，用于处理本地正则规则数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/regex_rule_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地正则规则数据源实现
class LocalRegexRuleDataSource implements LocalDataSource<RegexRuleModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;

  // 表名
  static const String _tableName = 'regex_rules';

  // 构造函数
  LocalRegexRuleDataSource(this._databaseManager);

  // 获取所有正则规则
  @override
  Future<List<RegexRuleModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'regex':
          return RegexRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    });
  }

  // 根据ID获取正则规则
  @override
  Future<RegexRuleModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RegexRuleModel.fromMap(maps.first);
    }
    return null;
  }

  // 保存正则规则
  @override
  Future<String> save(RegexRuleModel rule) async {
    final db = await _databaseManager.database;
    
    String id = rule.id;
    RegexRuleModel ruleWithId;
    
    if (id.isEmpty) {
      id = const Uuid().v4();
      ruleWithId = RegexRuleModel(
        id: id,
        name: rule.name,
        pattern: rule.pattern,
        action: rule.action,
        priority: rule.priority,
        isEnabled: rule.isEnabled,
        subscriptionId: rule.subscriptionId,
        ruleType: 'regex',
      );
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

  // 更新正则规则
  @override
  Future<int> update(RegexRuleModel rule) async {
    final db = await _databaseManager.database;

    return await db.update(
      _tableName,
      rule.toMap(),
      where: 'id = ?',
      whereArgs: [rule.id],
    );
  }
  
  // 插入单个规则
  @override
  Future<String> insert(RegexRuleModel model) async {
    return save(model);
  }
  
  // 批量插入规则
  @override
  Future<List<String>> insertAll(List<RegexRuleModel> models) async {
    final List<String> ids = [];
    for (final model in models) {
      final id = await save(model);
      ids.add(id);
    }
    return ids;
  }
  
  // 清空表
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }
  
  // 导出数据
  @override
  Future<String> exportData() async {
    final rules = await getAll();
    final List<Map<String, dynamic>> maps = rules.map((rule) => rule.toMap()).toList();
    return jsonEncode(maps);
  }
  
  // 导入数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data);
      final List<RegexRuleModel> rules = maps.map((map) => RegexRuleModel.fromMap(map)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      print('导入正则规则数据失败: $e');
      return false;
    }
  }

  // 删除正则规则
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;

    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 批量保存正则规则
  @override
  Future<List<String>> saveAll(List<RegexRuleModel> rules) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final rule in rules) {
        String id = rule.id;
        RegexRuleModel ruleWithId;
        
        if (id.isEmpty) {
          id = const Uuid().v4();
          ruleWithId = RegexRuleModel(
            id: id,
            name: rule.name,
            pattern: rule.pattern,
            action: rule.action,
            priority: rule.priority,
            isEnabled: rule.isEnabled,
          );
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

  // 批量更新正则规则
  @override
  Future<int> updateAll(List<RegexRuleModel> rules) async {
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

  // 批量删除正则规则
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

  // 删除所有正则规则
  @override
  Future<int> deleteAllRecords() async {
    final db = await _databaseManager.database;
    return await db.delete(_tableName);
  }

  // 获取正则规则数量
  @override
  Future<int> count() async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $_tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // 根据模式获取规则
  Future<RegexRuleModel?> getByPattern(String pattern) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'pattern = ?',
      whereArgs: [pattern],
    );

    if (maps.isNotEmpty) {
      return RegexRuleModel.fromMap(maps.first);
    }
    return null;
  }

  // 获取启用的正则规则
  Future<List<RegexRuleModel>> getEnabledRules() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isEnabled = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (i) {
      return RegexRuleModel.fromMap(maps[i]);
    });
  }

  // 获取禁用的正则规则
  Future<List<RegexRuleModel>> getDisabledRules() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isEnabled = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return RegexRuleModel.fromMap(maps[i]);
    });
  }

  // 根据优先级获取正则规则
  Future<List<RegexRuleModel>> getByPriority(int priority) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'priority = ?',
      whereArgs: [priority],
    );

    return List.generate(maps.length, (i) {
      return RegexRuleModel.fromMap(maps[i]);
    });
  }

  // 根据名称搜索正则规则
  Future<List<RegexRuleModel>> searchByName(String name) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return List.generate(maps.length, (i) {
      return RegexRuleModel.fromMap(maps[i]);
    });
  }
}