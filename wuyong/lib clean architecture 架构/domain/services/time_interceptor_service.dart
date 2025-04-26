import '../value_objects/phone_number.dart';

/// 时间拦截器服务接口
abstract class TimeInterceptorService {
  /// 加载配置
  Future<void> loadConfig();
  
  /// 保存配置
  Future<void> saveConfig();
  
  /// 判断是否应该拦截
  Future<bool> shouldIntercept(PhoneNumber phoneNumber);
  
  /// 获取当前配置
  Map<String, dynamic> getConfig();
  
  /// 更新配置
  Future<void> updateConfig(Map<String, dynamic> config);
}