// 本地订阅数据源实现类，用于处理本地订阅数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/subscription_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地订阅数据源实现
class LocalSubscriptionDataSource implements LocalDataSource<SubscriptionModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _tableName = 'subscriptions';
  
  // 构造函数
  LocalSubscriptionDataSource(this._databaseManager);
  
  // 获取所有订阅
  @override
  Future<List<SubscriptionModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    
    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据表类型创建不同的订阅模型
      final String? tableType = map['table_type'];
      if (tableType == 'contact') {
        return ContactSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          contactGroup: map['contact_group'],
        );
      } else if (tableType == 'sms') {
        return SmsSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          isWhitelist: map['isWhitelist'] == 1,
          isBlacklist: map['isBlacklist'] == 1,
          isNumberType: map['isNumberType'] == 1,
        );
      } else {
        return SubscriptionModel.fromMap(map);
      }
    });
  }
  
  // 根据ID获取订阅
  @override
  Future<SubscriptionModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      final map = maps.first;
      // 根据表类型创建不同的订阅模型
      final String? tableType = map['table_type'];
      if (tableType == 'contact') {
        return ContactSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          contactGroup: map['contact_group'],
        );
      } else if (tableType == 'sms') {
        return SmsSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          isWhitelist: map['isWhitelist'] == 1,
          isBlacklist: map['isBlacklist'] == 1,
          isNumberType: map['isNumberType'] == 1,
        );
      } else {
        return SubscriptionModel.fromMap(map);
      }
    }
    return null;
  }
  
  // 插入订阅
  @override
  Future<String> insert(SubscriptionModel subscription) async {
    final db = await _databaseManager.database;
    
    // 如果没有ID，生成一个新的UUID
    final String id = subscription.id.isEmpty ? const Uuid().v4() : subscription.id;
    final SubscriptionModel subscriptionWithId;
    
    // 根据订阅类型创建不同的订阅模型
    if (subscription.id.isEmpty) {
      if (subscription is ContactSubscriptionModel) {
        subscriptionWithId = ContactSubscriptionModel(
          id: id,
          name: subscription.name,
          url: subscription.url,
          enabled: subscription.enabled,
          lastUpdated: subscription.lastUpdated,
          autoUpdate: subscription.autoUpdate,
          contactGroup: subscription.contactGroup,
        );
      } else if (subscription is SmsSubscriptionModel) {
        subscriptionWithId = SmsSubscriptionModel(
          id: id,
          name: subscription.name,
          url: subscription.url,
          enabled: subscription.enabled,
          lastUpdated: subscription.lastUpdated,
          autoUpdate: subscription.autoUpdate,
          isWhitelist: subscription.isWhitelist,
          isBlacklist: subscription.isBlacklist,
          isNumberType: subscription.isNumberType,
        );
      } else {
        subscriptionWithId = SubscriptionModel(
          id: id,
          name: subscription.name,
          url: subscription.url,
          enabled: subscription.enabled,
          isWhitelist: subscription.isWhitelist,
          isBlacklist: subscription.isBlacklist,
          lastUpdated: subscription.lastUpdated,
          autoUpdate: subscription.autoUpdate,
        );
      }
    } else {
      subscriptionWithId = subscription;
    }
    
    await db.insert(
      _tableName,
      subscriptionWithId.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    return id;
  }
  
  // 更新订阅
  @override
  Future<int> update(SubscriptionModel subscription) async {
    final db = await _databaseManager.database;
    
    return await db.update(
      _tableName,
      subscription.toMap(),
      where: 'id = ?',
      whereArgs: [subscription.id],
    );
  }
  
  // 删除订阅
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 批量插入订阅
  @override
  Future<List<String>> insertAll(List<SubscriptionModel> subscriptions) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final subscription in subscriptions) {
        // 如果没有ID，生成一个新的UUID
        final String id = subscription.id.isEmpty ? const Uuid().v4() : subscription.id;
        final SubscriptionModel subscriptionWithId;
        
        // 根据订阅类型创建不同的订阅模型
        if (subscription.id.isEmpty) {
          if (subscription is ContactSubscriptionModel) {
            subscriptionWithId = ContactSubscriptionModel(
              id: id,
              name: subscription.name,
              url: subscription.url,
              enabled: subscription.enabled,
              lastUpdated: subscription.lastUpdated,
              autoUpdate: subscription.autoUpdate,
              contactGroup: subscription.contactGroup,
            );
          } else if (subscription is SmsSubscriptionModel) {
            subscriptionWithId = SmsSubscriptionModel(
              id: id,
              name: subscription.name,
              url: subscription.url,
              enabled: subscription.enabled,
              lastUpdated: subscription.lastUpdated,
              autoUpdate: subscription.autoUpdate,
              isWhitelist: subscription.isWhitelist,
              isBlacklist: subscription.isBlacklist,
              isNumberType: subscription.isNumberType,
            );
          } else {
            subscriptionWithId = SubscriptionModel(
              id: id,
              name: subscription.name,
              url: subscription.url,
              enabled: subscription.enabled,
              isWhitelist: subscription.isWhitelist,
              isBlacklist: subscription.isBlacklist,
              lastUpdated: subscription.lastUpdated,
              autoUpdate: subscription.autoUpdate,
            );
          }
        } else {
          subscriptionWithId = subscription;
        }
        
        await txn.insert(
          _tableName,
          subscriptionWithId.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        
        ids.add(id);
      }
    });
    
    return ids;
  }
  
  // 批量更新订阅
  @override
  Future<int> updateAll(List<SubscriptionModel> subscriptions) async {
    int count = 0;
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final subscription in subscriptions) {
        final int updated = await txn.update(
          _tableName,
          subscription.toMap(),
          where: 'id = ?',
          whereArgs: [subscription.id],
        );
        
        count += updated;
      }
    });
    
    return count;
  }
  
  // 批量删除订阅
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
  
  // 清空所有订阅
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }
  
  // 导出订阅数据
  @override
  Future<String> exportData() async {
    final subscriptions = await getAll();
    final List<Map<String, dynamic>> subscriptionMaps = subscriptions.map((subscription) => subscription.toMap()).toList();
    return jsonEncode(subscriptionMaps);
  }
  
  // 导入订阅数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> subscriptionMaps = jsonDecode(data) as List<dynamic>;
      final List<SubscriptionModel> subscriptions = [];
      
      for (final map in subscriptionMaps) {
        final subscriptionMap = map as Map<String, dynamic>;
        // 根据表类型创建不同的订阅模型
        final String? tableType = subscriptionMap['table_type'];
        if (tableType == 'contact') {
          subscriptions.add(ContactSubscriptionModel(
            id: subscriptionMap['id'],
            name: subscriptionMap['name'],
            url: subscriptionMap['url'],
            enabled: subscriptionMap['enabled'] == 1,
            lastUpdated: DateTime.parse(subscriptionMap['lastUpdated']),
            autoUpdate: subscriptionMap['autoUpdate'] == 1,
            contactGroup: subscriptionMap['contact_group'],
          ));
        } else if (tableType == 'sms') {
          subscriptions.add(SmsSubscriptionModel(
            id: subscriptionMap['id'],
            name: subscriptionMap['name'],
            url: subscriptionMap['url'],
            enabled: subscriptionMap['enabled'] == 1,
            lastUpdated: DateTime.parse(subscriptionMap['lastUpdated']),
            autoUpdate: subscriptionMap['autoUpdate'] == 1,
            isWhitelist: subscriptionMap['isWhitelist'] == 1,
            isBlacklist: subscriptionMap['isBlacklist'] == 1,
            isNumberType: subscriptionMap['isNumberType'] == 1,
          ));
        } else {
          subscriptions.add(SubscriptionModel.fromMap(subscriptionMap));
        }
      }
      
      await insertAll(subscriptions);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 获取启用的订阅
  Future<List<SubscriptionModel>> getEnabledSubscriptions() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'enabled = ?',
      whereArgs: [1],
    );
    
    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据表类型创建不同的订阅模型
      final String? tableType = map['table_type'];
      if (tableType == 'contact') {
        return ContactSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          contactGroup: map['contact_group'],
        );
      } else if (tableType == 'sms') {
        return SmsSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          isWhitelist: map['isWhitelist'] == 1,
          isBlacklist: map['isBlacklist'] == 1,
          isNumberType: map['isNumberType'] == 1,
        );
      } else {
        return SubscriptionModel.fromMap(map);
      }
    });
  }
  
  // 获取自动更新的订阅
  Future<List<SubscriptionModel>> getAutoUpdateSubscriptions() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'autoUpdate = ?',
      whereArgs: [1],
    );
    
    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据表类型创建不同的订阅模型
      final String? tableType = map['table_type'];
      if (tableType == 'contact') {
        return ContactSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          contactGroup: map['contact_group'],
        );
      } else if (tableType == 'sms') {
        return SmsSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          isWhitelist: map['isWhitelist'] == 1,
          isBlacklist: map['isBlacklist'] == 1,
          isNumberType: map['isNumberType'] == 1,
        );
      } else {
        return SubscriptionModel.fromMap(map);
      }
    });
  }
  
  // 根据类型获取订阅
  Future<List<SubscriptionModel>> getByType(String type) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'table_type = ?',
      whereArgs: [type],
    );
    
    return List.generate(maps.length, (i) {
      final map = maps[i];
      // 根据表类型创建不同的订阅模型
      if (type == 'contact') {
        return ContactSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          contactGroup: map['contact_group'],
        );
      } else if (type == 'sms') {
        return SmsSubscriptionModel(
          id: map['id'],
          name: map['name'],
          url: map['url'],
          enabled: map['enabled'] == 1,
          lastUpdated: DateTime.parse(map['lastUpdated']),
          autoUpdate: map['autoUpdate'] == 1,
          isWhitelist: map['isWhitelist'] == 1,
          isBlacklist: map['isBlacklist'] == 1,
          isNumberType: map['isNumberType'] == 1,
        );
      } else {
        return SubscriptionModel.fromMap(map);
      }
    });
  }
}