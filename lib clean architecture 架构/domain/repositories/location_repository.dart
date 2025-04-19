import 'base_repository.dart';

/// 电话号码归属地仓库接口
/// 定义电话号码归属地相关的数据操作
abstract class LocationRepository {
  /// 保存归属地信息
  Future<void> saveLocationData(Map<String, dynamic> locationData);
  
  /// 根据电话号码获取归属地信息
  Future<Map<String, dynamic>?> getLocationDataByPhoneNumber(String phoneNumber);
  
  /// 清理过期数据
  Future<void> cleanupExpiredData();
}