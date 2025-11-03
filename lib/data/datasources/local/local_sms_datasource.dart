// local_sms_data_source.dart (最终优化版)

import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

import '../../../data/models/sms_model.dart';
import '../datasource_interface.dart';

// 本地短信数据源实现 (使用 Drift)
class LocalSmsDataSource implements LocalDataSource<SmsModel> {
  
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();
  
  // 构造函数
  LocalSmsDataSource(this._database);
  
  // --- 辅助方法: 数据转换 ---

  /// 将 Drift 生成的 SmsMessageData (数据库行数据) 转换为 SmsModel
  SmsModel _fromData(SmsMessageData data) {
    // 1. LabelIds 反序列化: 从逗号分隔字符串转回 List<String>
    List<String>? parsedLabelIds;
    if (data.labelIds != null && data.labelIds!.isNotEmpty) {
      parsedLabelIds = data.labelIds!.split(',').where((s) => s.isNotEmpty).toList();
    }
    
    // 2. Timestamp 解析: 从 ISO8601 字符串转回 DateTime
    DateTime parsedTimestamp = DateTime.parse(data.timestamp);

    return SmsModel(
      // 修正：确保 ID 即使在意外情况下为 null 也能得到一个有效的 UUID
      id: data.id ?? _uuid.v4(),
      phoneNumber: data.phoneNumber,
      contactName: data.contactName,
      messageType: data.messageType,
      content: data.content,
      timestamp: parsedTimestamp, 
      isRead: data.isRead == 1,
      simInfo: data.simInfo,
      isMarked: data.isMarked == 1,
      labelIds: parsedLabelIds,
    );
  }
  
  /// 将 SmsModel (应用模型) 转换为 Drift Companion (用于写入数据库)
  SmsCompanion _toCompanion(SmsModel model) {
    // 1. LabelIds 序列化: 从 List<String>? 转为逗号分隔字符串
    final String? labelIdsString = model.labelIds?.join(',');

    return SmsCompanion(
      // ID 字段将由 insert/insertAll 方法通过 Companion.copyWith 注入
      id: Value(model.id), 
      phoneNumber: Value(model.phoneNumber),
      contactName: Value(model.contactName),
      messageType: Value(model.messageType),
      content: Value(model.content),
      timestamp: Value(model.timestamp.toIso8601String()),
      isRead: Value(model.isRead ? 1 : 0),
      simInfo: Value(model.simInfo),
      isMarked: Value(model.isMarked ? 1 : 0),
      // 存储为逗号分隔字符串
      labelIds: Value(labelIdsString),
    );
  }
  
  // --- 核心 CRUD ---

  // 获取所有短信
  @override
  Future<List<SmsModel>> getAll() async {
    final results = await _database.select(_database.sms).get();
    return results.map(_fromData).toList();
  }
  
  // 根据ID获取短信
  @override
  Future<SmsModel?> getById(String id) async {
    final result = await (_database.select(_database.sms)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
    
    return result != null ? _fromData(result) : null;
  }
  
  // 根据电话号码获取短信
  Future<List<SmsModel>> getByPhoneNumber(String phoneNumber) async {
    final results = await (_database.select(_database.sms)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
      .get();
    
    return results.map(_fromData).toList();
  }
  
  // 插入短信 (使用 Companion.copyWith 注入 ID)
  @override
  Future<String> insert(SmsModel sms) async {
    final String id = sms.id.isEmpty ? _uuid.v4() : sms.id;
    
    final companion = _toCompanion(sms);
    final companionWithId = companion.copyWith(id: Value(id));
    
    await _database.into(_database.sms).insertOnConflictUpdate(companionWithId);
    
    return id;
  }
  
  // 更新短信
  @override
  Future<int> update(SmsModel sms) async {
    final companion = _toCompanion(sms);
    
    return await (_database.update(_database.sms)
      ..where((tbl) => tbl.id.equals(sms.id)))
      .write(companion);
  }
  
  // 删除短信
  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.sms)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  // 批量插入短信
  @override
  Future<List<String>> insertAll(List<SmsModel> smsList) async {
    final List<String> ids = [];
    
    await _database.batch((batch) {
      for (final sms in smsList) {
        final String id = sms.id.isEmpty ? _uuid.v4() : sms.id;
        ids.add(id);

        final companion = _toCompanion(sms);
        final companionWithId = companion.copyWith(id: Value(id));

        batch.insert(
          _database.sms,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    
    return ids;
  }
  
  // 批量更新短信
  @override
  Future<int> updateAll(List<SmsModel> smsList) async {
    await _database.batch((batch) {
      for (final sms in smsList) {
        batch.update(
          _database.sms,
          _toCompanion(sms),
          where: (tbl) => tbl.id.equals(sms.id),
        );
      }
    });
    
    return smsList.length; // 返回尝试更新的数量
  }
  
  // 批量删除短信
  @override
  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.sms)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }
  
  // 清空所有短信
  @override
  Future<void> clear() async {
    await _database.delete(_database.sms).go();
  }
  
  // 导出短信数据
  @override
  Future<String> exportData() async {
    final smsList = await getAll();
    final List<Map<String, dynamic>> smsMaps = smsList.map((sms) => sms.toMap()).toList();
    return jsonEncode(smsMaps);
  }
  
  // 导入短信数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> smsMaps = jsonDecode(data) as List<dynamic>;
      final List<SmsModel> smsList = smsMaps.map((map) => SmsModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(smsList);
      return true;
    } catch (e) {
      // 错误处理
      return false;
    }
  }
  
  // 根据短信类型获取短信
  Future<List<SmsModel>> getByMessageType(String messageType) async {
    final results = await (_database.select(_database.sms)
      ..where((tbl) => tbl.messageType.equals(messageType)))
      .get();
    
    return results.map(_fromData).toList();
  }
  
  // 获取未读短信
  Future<List<SmsModel>> getUnreadSms() async {
    final results = await (_database.select(_database.sms)
      ..where((tbl) => tbl.isRead.equals(0)))
      .get();
    
    return results.map(_fromData).toList();
  }
  
  // 标记短信为已读
  Future<int> markAsRead(String id) async {
    return await (_database.update(_database.sms)
      ..where((tbl) => tbl.id.equals(id)))
      // 只需要更新 isRead 字段
      .write(SmsCompanion(isRead: const Value(1))); 
  }
  
  // 获取标记的短信
  Future<List<SmsModel>> getMarkedSms() async {
    final results = await (_database.select(_database.sms)
      ..where((tbl) => tbl.isMarked.equals(1)))
      .get();
    
    return results.map(_fromData).toList();
  }
  
  // 根据内容搜索短信
  Future<List<SmsModel>> searchByContent(String keyword) async {
    final results = await (_database.select(_database.sms)
      ..where((tbl) => tbl.content.like('%$keyword%')))
      .get();
    
    return results.map(_fromData).toList();
  }
}