// local_subscription_data_source.dart (最终优化版，不依赖 Model.copyWith)

import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart'; // 假设这是 LocalDatabase 的路径

import '../../../data/models/subscription_model.dart';
import '../datasource_interface.dart';

// 本地订阅数据源实现
class LocalSubscriptionDataSource implements LocalDataSource<BaseSubscriptionModel> {
  
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();
  
  LocalSubscriptionDataSource(this._database);
  
  // --- 辅助方法: 数据转换 ---

  /// 将 Drift 生成的 SubscriptionData 转换为 BaseSubscriptionModel (多态转换)
  BaseSubscriptionModel _fromData(SubscriptionData data) {
    // 1. 基础字段映射 (由于 data 已经强类型，我们直接使用字段)
    final String id = data.id ?? _uuid.v4();
    final String urlString = data.url;
    final DateTime lastUpdated = DateTime.parse(data.lastUpdated);
    final String tableType = data.table_type;
    
    // 2. 根据 table_type 创建相应的 Model
    switch (tableType) {
      case 'contact':
        return ContactSubscriptionModel(
          id: id,
          name: data.name,
          url: Url.fromString(urlString),
          isEnabled: data.isEnabled == 1,
          lastUpdated: lastUpdated,
          autoUpdate: data.autoUpdate == 1,
          contactGroup: data.contact_group,
        );
      case 'sms':
        return SmsSubscriptionModel(
          id: id,
          name: data.name,
          url: Url.fromString(urlString),
          isEnabled: data.isEnabled == 1,
          lastUpdated: lastUpdated,
          autoUpdate: data.autoUpdate == 1,
          action: RuleAction.fromString(data.action),
        );
      case 'phone':
      default:
        return SubscriptionModel(
          id: id,
          name: data.name,
          url: Url.fromString(urlString),
          isEnabled: data.isEnabled == 1,
          lastUpdated: lastUpdated,
          autoUpdate: data.autoUpdate == 1,
          action: RuleAction.fromString(data.action),
        );
    }
  }

  /// 将 BaseSubscriptionModel 转换为 Drift Companion
  SubscriptionsCompanion _toCompanion(BaseSubscriptionModel model) {
    // 基础字段
    final baseCompanion = SubscriptionsCompanion(
      id: Value(model.id), // 保持原样，insert/insertAll 会修正
      name: Value(model.name),
      url: Value(model.url.toString()),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      lastUpdated: Value(model.lastUpdated.toIso8601String()),
      autoUpdate: Value(model.autoUpdate ? 1 : 0),
    );

    // 子类特有字段和 table_type 注入
    if (model is ContactSubscriptionModel) {
      return baseCompanion.copyWith(
        table_type: const Value('contact'),
        contact_group: Value(model.contactGroup),
        action: const Value.absent(), // 明确设为 absent，确保没有旧值污染
        keyword_filters: const Value.absent(),
      );
    } else if (model is SmsSubscriptionModel) {
      return baseCompanion.copyWith(
        table_type: const Value('sms'),
        action: Value(model.action.toString()),
        contact_group: const Value.absent(),
        keyword_filters: const Value.absent(),
      );
    } else { // SubscriptionModel (Phone)
      return baseCompanion.copyWith(
        table_type: const Value('phone'),
        action: Value((model as SubscriptionModel).action.toString()),
        contact_group: const Value.absent(),
        keyword_filters: const Value.absent(),
      );
    }
  }

  // --- 核心 CRUD ---
  
  @override
  Future<List<BaseSubscriptionModel>> getAll() async {
    final results = await _database.select(_database.subscriptions).get();
    return results.map(_fromData).toList();
  }
  
  @override
  Future<BaseSubscriptionModel?> getById(String id) async {
    final result = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
      
    return result != null ? _fromData(result) : null;
  }
  
  // 插入订阅 (Drift 惯用法)
  @override
  Future<String> insert(BaseSubscriptionModel subscription) async {
    final String id = subscription.id.isEmpty ? _uuid.v4() : subscription.id;
    
    final companion = _toCompanion(subscription);
    final companionWithId = companion.copyWith(id: Value(id));
    
    await _database.into(_database.subscriptions).insertOnConflictUpdate(companionWithId);
    
    return id;
  }
  
  // 更新订阅
  @override
  Future<int> update(BaseSubscriptionModel subscription) async {
    final companion = _toCompanion(subscription);
    
    return await (_database.update(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(subscription.id)))
      .write(companion);
  }
  
  // 删除订阅
  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.subscriptions)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  // 批量插入订阅
  @override
  Future<List<String>> insertAll(List<BaseSubscriptionModel> subscriptions) async {
    final List<String> ids = [];
    
    await _database.batch((batch) {
      for (final subscription in subscriptions) {
        final String id = subscription.id.isEmpty ? _uuid.v4() : subscription.id;
        ids.add(id);
        
        final companion = _toCompanion(subscription);
        final companionWithId = companion.copyWith(id: Value(id));

        batch.insert(
          _database.subscriptions,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    
    return ids;
  }
  
  // 批量更新订阅
  @override
  Future<int> updateAll(List<BaseSubscriptionModel> subscriptions) async {
    await _database.batch((batch) {
      for (final subscription in subscriptions) {
        batch.update(
          _database.subscriptions,
          _toCompanion(subscription),
          where: (tbl) => tbl.id.equals(subscription.id),
        );
      }
    });
    
    return subscriptions.length;
  }
  
  // 批量删除订阅
  @override
  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.subscriptions)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }
  
  // 清空所有订阅
  @override
  Future<void> clear() async {
    await _database.delete(_database.subscriptions).go();
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
      final List<BaseSubscriptionModel> subscriptions = [];
      
      for (final map in subscriptionMaps) {
        final subscriptionMap = map as Map<String, dynamic>;
        final String? tableType = subscriptionMap['table_type'];
        
        // 使用 fromMap 进行反序列化
        if (tableType == 'contact') {
          subscriptions.add(ContactSubscriptionModel.fromMap(subscriptionMap));
        } else if (tableType == 'sms') {
           subscriptions.add(SmsSubscriptionModel.fromMap(subscriptionMap));
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
  
  // --- 额外查询方法 ---
  
  // 辅助方法：统一的 WHERE 条件查询和多态转换
  Future<List<BaseSubscriptionModel>> _queryWhere(Expression<bool> whereClause) async {
    final results = await (_database.select(_database.subscriptions)
      ..where((tbl) => whereClause))
      .get();
    return results.map(_fromData).toList();
  }
  
  // 获取启用的订阅
  Future<List<BaseSubscriptionModel>> getEnabledSubscriptions() async {
    return _queryWhere(_database.subscriptions.isEnabled.equals(1));
  }
  
  // 获取自动更新的订阅
  Future<List<BaseSubscriptionModel>> getAutoUpdateSubscriptions() async {
    return _queryWhere(_database.subscriptions.autoUpdate.equals(1));
  }
  
  // 根据类型获取订阅
  Future<List<BaseSubscriptionModel>> getByType(String type) async {
    return _queryWhere(_database.subscriptions.table_type.equals(type));
  }

  Future<List<BaseSubscriptionModel>> queryAll() async {
    return await getAll();
  }

  Future<BaseSubscriptionModel?> queryById(String id) async {
    return await getById(id);
  }

  Future<List<BaseSubscriptionModel>> getByName(String name) async {
    return _queryWhere(_database.subscriptions.name.equals(name));
  }

  Future<BaseSubscriptionModel?> getByUrl(String url) async {
    final result = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.url.equals(url))
      ..limit(1))
      .getSingleOrNull();
      
    return result != null ? _fromData(result) : null;
  }

  Future<List<BaseSubscriptionModel>> getByContactName(String contactName) async {
    final results = await (_database.select(_database.subscriptions)
      ..where((tbl) => tbl.name.equals(contactName) & tbl.table_type.equals('contact')))
      .get();
    
    return results.map(_fromData).toList();
  }
}