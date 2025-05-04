import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/sms_regex_rule_model.dart';


import '../../database/database_manager.dart';
import '../datasource_interface.dart';

class LocalSmsRegexRuleDataSource implements LocalDataSource<SmsRegexRuleModel> {
  final LocalDatabaseManager _databaseManager;
  static const String _tableName = 'sms_rules';

  LocalSmsRegexRuleDataSource(this._databaseManager);

  @override
  Future<List<SmsRegexRuleModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => SmsRegexRuleModel.fromMap(map)).toList();
  }

  @override
  Future<SmsRegexRuleModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? SmsRegexRuleModel.fromMap(maps.first) : null;
  }

  @override
  Future<String> insert(SmsRegexRuleModel rule) async {
    _validateRegex(rule);
    final db = await _databaseManager.database;
    final String id = rule.id.isEmpty ? const Uuid().v4() : rule.id;
    final ruleWithId = rule.id.isEmpty ? rule.copyWith(id: id) : rule;

    await db.insert(
      _tableName,
      ruleWithId.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<int> update(SmsRegexRuleModel rule) async {
    _validateRegex(rule);
    final db = await _databaseManager.database;
    return db.update(
      _tableName,
      rule.toMap(),
      where: 'id = ?',
      whereArgs: [rule.id],
    );
  }

  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 批量操作方法保持与现有数据源一致
  @override
  Future<List<String>> insertAll(List<SmsRegexRuleModel> rules) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final rule in rules) {
        final String id = rule.id.isEmpty ? const Uuid().v4() : rule.id;
        final ruleWithId = rule.id.isEmpty ? rule.copyWith(id: id) : rule;

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

  @override
  Future<int> updateAll(List<SmsRegexRuleModel> rules) async {
    int count = 0;
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final rule in rules) {
        count += await txn.update(
          _tableName,
          rule.toMap(),
          where: 'id = ?',
          whereArgs: [rule.id],
        );
      }
    });
    return count;
  }

  void _validateRegex(SmsRegexRuleModel rule) {
    try {
      RegExp(rule.contentRegex);
      if (rule.senderRegex != null) RegExp(rule.senderRegex!);
    } catch (e) {
      throw FormatException('Invalid regex pattern: ${e.toString()}');
    }
  }

  // 其他必要接口实现
  @override
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    int count = 0;
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final id in ids) {
        count += await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    });
    return count;
  }

  @override
  Future<String> exportData() async {
    final rules = await getAll();
    return jsonEncode(rules.map((r) => r.toMap()).toList());
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> jsonList = jsonDecode(data);
      final rules = jsonList.map((j) => SmsRegexRuleModel.fromMap(j)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }
}