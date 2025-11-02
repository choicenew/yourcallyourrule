// 本地联系人数据源实现类，用于处理本地联系人数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/contact_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地联系人数据源实现
class LocalContactDataSource implements LocalDataSource<ContactModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _tableName = 'contacts';
  
  // 构造函数
  LocalContactDataSource(this._databaseManager);
// 获取所有联系人
  @override
  Future<List<ContactModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      final map = Map<String, dynamic>.from(maps[i]);
      if (map['phoneNumbers'] is String) {
        map['phoneNumbers'] = jsonDecode(map['phoneNumbers']);
      }
      if (map['labelIds'] is String) {
        map['labelIds'] = jsonDecode(map['labelIds']);
      }
      return ContactModel.fromMap(map);
    });
  }

  // 根据ID获取联系人
  @override
  Future<ContactModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      final map = Map<String, dynamic>.from(maps.first);
      if (map['phoneNumbers'] is String) {
        map['phoneNumbers'] = jsonDecode(map['phoneNumbers']);
      }
      if (map['labelIds'] is String) {
        map['labelIds'] = jsonDecode(map['labelIds']);
      }
      return ContactModel.fromMap(map);
    }
    return null;
  }

  @override
  Future<String> insert(ContactModel contact) async {
    final db = await _databaseManager.database;
    final String id = contact.id.isEmpty ? const Uuid().v4() : contact.id;
    final contactWithId = contact.copyWith(id: id);
    final contactMap = contactWithId.toMap();
    contactMap['phoneNumbers'] = jsonEncode(contactWithId.phoneNumbers);
    if (contactWithId.labelIds != null) {
      contactMap['labelIds'] = jsonEncode(contactWithId.labelIds);
    }
    await db.insert(
      _tableName,
      contactMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }
  
  // 更新联系人
  @override
  Future<int> update(ContactModel contact) async {
    final db = await _databaseManager.database;
    final contactMap = contact.toMap();
    contactMap['phoneNumbers'] = jsonEncode(contact.phoneNumbers);
    if (contact.labelIds != null) {
      contactMap['labelIds'] = jsonEncode(contact.labelIds);
    }
    return await db.update(
      _tableName,
      contactMap,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }
  
  // 删除联系人
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 批量插入联系人
  @override
  Future<List<String>> insertAll(List<ContactModel> contacts) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (final contact in contacts) {
        final String id = contact.id.isEmpty ? const Uuid().v4() : contact.id;
        final contactWithId = contact.copyWith(id: id);
        final contactMap = contactWithId.toMap();
        contactMap['phoneNumbers'] = jsonEncode(contactWithId.phoneNumbers);
        if (contactWithId.labelIds != null) {
          contactMap['labelIds'] = jsonEncode(contactWithId.labelIds);
        }
        await txn.insert(
          _tableName,
          contactMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        ids.add(id);
      }
    });
    return ids;
  }
  
  // 批量更新联系人
  @override
  Future<int> updateAll(List<ContactModel> contacts) async {
    int count = 0;
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (final contact in contacts) {
        final contactMap = contact.toMap();
        contactMap['phoneNumbers'] = jsonEncode(contact.phoneNumbers);
        if (contact.labelIds != null) {
          contactMap['labelIds'] = jsonEncode(contact.labelIds);
        }
        final int updated = await txn.update(
          _tableName,
          contactMap,
          where: 'id = ?',
          whereArgs: [contact.id],
        );
        count += updated;
      }
    });
    return count;
  }
  
  // 批量删除联系人
  @override
  Future<int> deleteAll(List<String> ids) async {
       if (ids.isEmpty) {
      return 0;
    }
    final db = await _databaseManager.database;
    // 生成与 ids 数量相匹配的占位符 '?, ?, ?'
    final placeholders = List.filled(ids.length, '?').join(', ');
    return await db.delete(
      _tableName,
      where: 'id IN ($placeholders)', // 使用生成的占位符
      whereArgs: ids, // 直接传递列表
    );
  }
  
  
  
  
  
  

  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }

  // 根据电话号码获取联系人
  Future<ContactModel?> getByPhoneNumber(String phoneNumber) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumbers LIKE ?',
      whereArgs: ['%"$phoneNumber"%'],
    );
    if (maps.isNotEmpty) {
      final map = Map<String, dynamic>.from(maps.first);
      if (map['phoneNumbers'] is String) {
        map['phoneNumbers'] = jsonDecode(map['phoneNumbers']);
      }
      if (map['labelIds'] is String) {
        map['labelIds'] = jsonDecode(map['labelIds']);
      }
      return ContactModel.fromMap(map);
    }
    return null;
  }

  Future<int> count() async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $_tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // 导出联系人数据
  @override
  Future<String> exportData() async {
    final contacts = await getAll();
    final List<Map<String, dynamic>> contactMaps = contacts.map((contact) => contact.toMap()).toList();
    return jsonEncode(contactMaps);
  }
  
  // 导入联系人数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> contactMaps = jsonDecode(data) as List<dynamic>;
      final List<ContactModel> contacts = contactMaps.map((map) => ContactModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(contacts);
      return true;
    } catch (e) {
      return false;
    }
  }
}