/// 电话号码归属地服务接口
/// 定义电话号码归属地相关的业务逻辑
abstract class LocationService {
  /// 获取电话号码的归属地信息
  /// [phoneNumber] 电话号码
  /// [languageCode] 语言代码，用于本地化显示
  /// 返回归属地信息，包含地区、国家代码、运营商等信息
  Future<Map<String, dynamic>?> getCallerLocationData(String phoneNumber, String languageCode);
  
  /// 从数据库查询归属地信息
  /// [phoneNumber] 电话号码
  Future<Map<String, dynamic>?> getLocationFromDatabase(String phoneNumber);
  
  /// 清理数据库中的过期数据
  Future<void> cleanupDatabase();
}