// local_location_data_source.dart (Drift 优化版)

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/data/models/location_model.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' show PhoneNumberType;
import 'package:yourcallyourrule/data/datasources/datasource_interface.dart';

class LocalLocationDataSource implements LocalDataSource<LocationModel> {
  
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LocalLocationDataSource(this._db);

  LocationModel _fromData(LocationData data) {
    return LocationModel(
      // 修正：确保 ID 非空
      id: data.id ?? _uuid.v4(),
      phoneNumber: PhoneNumber.fromString(data.phoneNumber),
      region: data.region,
      countryName: data.countryName,
      carrier: data.carrier,
      // 注意：PhoneNumberType 是枚举，我们将其存储为 index
      numberType: PhoneNumberType.values[data.numberType],
    );
  }

  LocationsCompanion _toCompanion(LocationModel model) {
    // 保持原样，ID 修正将在 insert/insertAll 中进行
    return LocationsCompanion(
      id: Value(model.id),
      phoneNumber: Value(model.phoneNumber.value),
      region: Value(model.region),
      countryName: Value(model.countryName),
      carrier: Value(model.carrier),
      numberType: Value(model.numberType.index),
    );
  }

  @override
  Future<List<LocationModel>> getAll() async {
    final data = await _db.select(_db.locations).get();
    return data.map(_fromData).toList();
  }

  @override
  Future<LocationModel?> getById(String id) async {
    final data = await (_db.select(_db.locations)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
      
    return data != null ? _fromData(data) : null;
  }

  // 修正：使用 Companion.copyWith 注入 ID
  @override
  Future<String> insert(LocationModel location) async {
    final id = location.id.isEmpty ? _uuid.v4() : location.id;
    
    final companion = _toCompanion(location);
    final companionWithId = companion.copyWith(id: Value(id));
    
    await _db.into(_db.locations).insert(companionWithId, mode: InsertMode.replace);
    return id;
  }

  @override
  Future<int> update(LocationModel location) async {
    return (_db.update(_db.locations)
      ..where((tbl) => tbl.id.equals(location.id)))
      .write(_toCompanion(location));
  }

  @override
  Future<int> delete(String id) async {
    return (_db.delete(_db.locations)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  // 修正：使用 Companion.copyWith 注入 ID，并使用 batch.insertAll
  @override
  Future<List<String>> insertAll(List<LocationModel> locations) async {
    final ids = <String>[];
    final companions = locations.map((location) {
      final id = location.id.isEmpty ? _uuid.v4() : location.id;
      ids.add(id);
      
      final companion = _toCompanion(location);
      // 直接在 Companion 上修正 ID
      return companion.copyWith(id: Value(id)); 
    }).toList();

    await _db.batch((batch) {
      batch.insertAll(_db.locations, companions, mode: InsertMode.replace);
    });
    return ids;
  }

  // 修正：使用 batch 优化批量更新
  @override
  Future<int> updateAll(List<LocationModel> locations) async {
    await _db.batch((batch) {
      for (final location in locations) {
        batch.update(
          _db.locations,
          _toCompanion(location),
          where: (tbl) => tbl.id.equals(location.id),
        );
      }
    });
    return locations.length;
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return (_db.delete(_db.locations)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  @override
  Future<void> clear() async {
    await _db.delete(_db.locations).go();
  }

  @override
  Future<String> exportData() async {
    final locations = await getAll();
    // 假设 LocationModel.toMap() 正确处理了 PhoneNumber/PhoneNumberType 的序列化
    return jsonEncode(locations.map((location) => location.toMap()).toList());
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> locationMaps = jsonDecode(data) as List<dynamic>;
      final locations = locationMaps.map((map) => LocationModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(locations);
      return true;
    } catch (e) {
      // Log the error appropriately
      return false;
    }
  }

  Future<LocationEntry?> getByPhoneNumber(String phoneNumber) async {
    final data = await (_db.select(_db.locations)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
      ..limit(1))
      .getSingleOrNull();
      
    return data != null ? _fromData(data).toEntity() : null;
  }

  Future<List<LocationEntry>> getByRegion(String region) async {
    final data = await (_db.select(_db.locations)..where((tbl) => tbl.region.equals(region))).get();
    return data.map((e) => _fromData(e).toEntity()).toList();
  }

  // 注意：Drift 不原生支持 SQLite 的 REGEXP 操作符，除非数据库有扩展或使用自定义函数。
  // 在 Android/iOS Native 环境下，默认的 SQLite 数据库不支持 REGEXP。
  // 如果要运行 REGEXP，需要确保您的 NativeDatabase setup 中添加了自定义 REGEXP 函数。
  Future<List<LocationEntry>> searchByPhoneRegex(String pattern) async {
    // 使用 customSelect 保持原有逻辑，并转换结果
    final result = await _db.customSelect(
      'SELECT * FROM locations WHERE phoneNumber REGEXP ?', // 注意：Drift 表名在 SQLite 可能是小写蛇形命名
      variables: [Variable.withString(pattern)],
      readsFrom: {_db.locations},
    ).get();
    
    return result.map((row) {
      // 手动将 Row 映射回 LocationData
      final locationData = _db.locations.map(row.data);
      return _fromData(locationData);
    }).map((e) => e.toEntity()).toList();
  }
}