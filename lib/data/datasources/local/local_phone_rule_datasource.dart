// 本地电话规则数据源实现类，用于处理本地电话规则数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/allow_block_rule_model.dart';
import '../../../data/models/phone_rule_model.dart';
import '../../../data/models/rule_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地电话规则数据源实现
class LocalPhoneRuleDataSource implements LocalDataSource<PhoneBasedRuleModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;

  // 表名
  static const String _tableName = 'phone_rules';

  // 构造函数
  LocalPhoneRuleDataSource(this._databaseManager);

  // 获取所有电话规则
  @override
  Future<List<PhoneBasedRuleModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据规则类型创建不同的规则模型
      switch (map['ruleType']) {
        case 'phone_rule':
          return PhoneRuleModel.fromMap(map);
        case 'allow_block': // 兼容两种类型
          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: ${map['ruleType']}');
      }
    });
  }
  
  // 插入单个规则
  @override
  Future<String> insert(PhoneBasedRuleModel model) async {
    return save(model);
  }
  
  // 批量插入规则
  @override
  Future<List<String>> insertAll(List<PhoneBasedRuleModel> models) async {
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
      final List<PhoneBasedRuleModel> rules = maps.map((map) {
        final ruleType = map['ruleType'];
        switch (ruleType) {
          case 'phone_rule':
            return PhoneRuleModel.fromMap(map);
          case 'allow_block':
            return AllowedBlockedRuleModel.fromMap(map);
          default:
            throw Exception('Unknown rule type: $ruleType');
        }
      }).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      print('导入电话规则数据失败: $e');
      return false;
    }
  }

  // 根据ID获取电话规则
  @override
  Future<PhoneBasedRuleModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final map = maps.first;
      final ruleType = map['ruleType'];
      switch (ruleType) {
        case 'phone_rule':
          return PhoneRuleModel.fromMap(map);
        case 'allow_block':
          return AllowedBlockedRuleModel.fromMap(map);
        default:
          throw Exception('Unknown rule type: $ruleType');
      }
    }
    return null;
  }

  // 保存电话规则
  Future<String> save(PhoneBasedRuleModel rule) async {
    final db = await _databaseManager.database;
    
    String id = rule.id;
    PhoneBasedRuleModel ruleWithId;
    
    if (id.isEmpty) {
      id = const Uuid().v4();
      // 根据具体类型创建新实例
      if (rule is PhoneRuleModel) {
        ruleWithId = PhoneRuleModel(
          id: id,
          name: rule.name,
          phoneNumber: rule.phoneNumber,
          action: rule.action,
          priority: rule.priority,
          isEnabled: rule.isEnabled,
          labelId: rule.labelId,
          avatar: rule.avatar,
          count: rule.count,
          ruleType: rule.ruleType,
        );
      } else if (rule is AllowedBlockedRuleModel) {
        ruleWithId = AllowedBlockedRuleModel(
          id: id,
          name: rule.name,
          phoneNumber: rule.phoneNumber,
          action: rule.action,
          priority: rule.priority,
          isEnabled: rule.isEnabled,
          labelId: rule.labelId,
          avatar: rule.avatar,
          count: rule.count,
        );
      } else {
        throw Exception('Unsupported rule type: ${rule.runtimeType}');
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

  // 更新电话规则
  @override
  Future<int> update(PhoneBasedRuleModel rule) async {
    final db = await _databaseManager.database;

    return await db.update(
      _tableName,
      rule.toMap(),
      where: 'id = ?',
      whereArgs: [rule.id],
    );
  }

  // 删除电话规则
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;

    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 批量保存电话规则
  Future<List<String>> saveAll(List<PhoneBasedRuleModel> rules) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final rule in rules) {
        String id = rule.id;
        PhoneBasedRuleModel ruleWithId;
        
        if (id.isEmpty) {
          id = const Uuid().v4();
          // 根据具体类型创建新实例
          if (rule is PhoneRuleModel) {
            ruleWithId = PhoneRuleModel(
              id: id,
              name: rule.name,
              phoneNumber: rule.phoneNumber,
              action: rule.action,
              priority: rule.priority,
              isEnabled: rule.isEnabled,
              labelId: rule.labelId,
              avatar: rule.avatar,
              count: rule.count,
              ruleType: rule.ruleType,
            );
          } else if (rule is AllowedBlockedRuleModel) {
            ruleWithId = AllowedBlockedRuleModel(
              id: id,
              name: rule.name,
              phoneNumber: rule.phoneNumber,
              action: rule.action,
              priority: rule.priority,
              isEnabled: rule.isEnabled,
              labelId: rule.labelId,
              avatar: rule.avatar,
              count: rule.count,
            );
          } else {
            throw Exception('Unsupported rule type: ${rule.runtimeType}');
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

  // 批量更新电话规则
  @override
  Future<int> updateAll(List<PhoneBasedRuleModel> rules) async {
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

  // 批量删除电话规则
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

  // 删除所有电话规则
  Future<int> deleteAllRecords() async {
    final db = await _databaseManager.database;
    return await db.delete(_tableName);
  }

  // 获取电话规则数量
  Future<int> count() async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $_tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // 根据电话号码获取规则
  Future<PhoneRuleModel?> getByPhoneNumber(String phoneNumber) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );

    if (maps.isNotEmpty) {
      return PhoneRuleModel.fromMap(maps.first);
    }
    return null;
  }

  // 获取启用的电话规则
  Future<List<PhoneRuleModel>> getEnabledRules() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isEnabled = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (i) {
      return PhoneRuleModel.fromMap(maps[i]);
    });
  }

  // 获取禁用的电话规则
  Future<List<PhoneRuleModel>> getDisabledRules() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isEnabled = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return PhoneRuleModel.fromMap(maps[i]);
    });
  }

  // 根据优先级获取电话规则
  Future<List<PhoneRuleModel>> getByPriority(int priority) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'priority = ?',
      whereArgs: [priority],
    );

    return List.generate(maps.length, (i) {
      return PhoneRuleModel.fromMap(maps[i]);
    });
  }

  // 根据名称搜索电话规则
  Future<List<PhoneRuleModel>> searchByName(String name) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return List.generate(maps.length, (i) {
      return PhoneRuleModel.fromMap(maps[i]);
    });
  }

  // 根据名称前缀搜索电话规则（用于订阅规则管理）
  Future<List<PhoneRuleModel>> searchByNamePrefix(String prefix) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['$prefix%'],
    );

    return List.generate(maps.length, (i) {
      return PhoneRuleModel.fromMap(maps[i]);
    });
  }

  // 获取所有已订阅的规则
  Future<List<PhoneRuleModel>> getSubscribedRules() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'subscriptionId IS NOT NULL',
    );

    return List.generate(maps.length, (i) {
      return PhoneRuleModel.fromMap(maps[i]);
    });
  }
}