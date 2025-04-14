import 'package:sqflite/sqflite.dart';

import '../../domain/repositories/location_repository.dart';
import '../datasources/local/database/dao/base_dao.dart';

/// 电话号码归属地仓库实现
/// 实现电话号码归属地仓库接口，提供归属地数据的存储和检索
class LocationRepositoryImpl implements LocationRepository {
  final Database _database;
  
  LocationRepositoryImpl(this._database);
  
  @override
  Future<void> saveLocationData(Map<String, dynamic> locationData) async {
    await _database.insert(
      'location_data',
      locationData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  @override
  Future<Map<String, dynamic>?> getLocationDataByPhoneNumber(String phoneNumber) async {
    final results = await _database.query(
      'location_data',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    return results.isNotEmpty ? results.first : null;
  }
  
  @override
  Future<void> cleanupExpiredData() async {
    // 实际项目中可以根据需要实现清理策略
    // 例如删除特定时间之前的数据
  }
}