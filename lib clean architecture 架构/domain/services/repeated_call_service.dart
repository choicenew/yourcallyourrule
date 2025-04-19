import '../value_objects/phone_number.dart';

/// 重复来电处理服务接口
abstract class RepeatedCallService {
  /// 记录来电
  Future<void> recordCall(PhoneNumber phoneNumber);
  
  /// 检查是否为重复来电
  Future<bool> isRepeatedCall(PhoneNumber phoneNumber);
  
  /// 获取来电次数
  Future<int> getCallCount(PhoneNumber phoneNumber);
  
  /// 清除记录
  Future<void> clearRecords();
  
  /// 加载配置
  Future<void> loadConfig();
  
  /// 保存配置
  Future<void> saveConfig();
}