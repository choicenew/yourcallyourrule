// 远程号码过滤服务类，用于根据计数规则判断是否接受来电

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_config.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

/// 远程号码过滤服务类，用于根据计数规则判断是否接受来电
class RemoteNumberFilterService implements CallFilterInterface {
  // 显式声明所有依赖项
  final RemoteNumberService _remoteNumberService;
  final ConfigRepository _configRepository;

  RemoteNumberFilterConfig remoteNumberFilterConfig = RemoteNumberFilterConfig();

  // 构造函数明确依赖关系
  RemoteNumberFilterService({
    required RemoteNumberService remoteNumberService,
    required ConfigRepository configRepository,
  })  : _remoteNumberService = remoteNumberService,
        _configRepository = configRepository;

  // 判断是否应该接受来电
  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
    // 如果未启用远程号码过滤，则默认接受
    if (!remoteNumberFilterConfig.enableRemoteNumberFilter) {
      return true;
    }

    final phoneNumber = PhoneNumber(phoneNumberStr);
    
    // 查询远程号码信息
    final remoteInfo = await _remoteNumberService.queryRemoteNumberInfo(phoneNumberStr);
    
    // 如果启用了日志记录，记录查询
    if (remoteNumberFilterConfig.logAllRemoteQueries) {
      // 这里可以添加日志记录逻辑
    }
    
    // 如果远程数据库中存在该号码
    if (remoteInfo != null) {
      // 增加计数
      final updatedEntry = await _remoteNumberService.incrementCount(phoneNumber);
      
      // 如果优先考虑远程动作设置
      if (remoteNumberFilterConfig.prioritizeRemoteAction && updatedEntry != null) {
        // 根据远程号码的动作和计数判断
        return await _remoteNumberService.shouldAcceptBasedOnCount(phoneNumber);
      }
      
      // 检查计数是否超过阈值
      final isExceeded = await _remoteNumberService.isCountExceeded(phoneNumber);
      
      // 如果计数超过阈值且配置为拒绝超过阈值的号码
      if (isExceeded && remoteNumberFilterConfig.rejectExceededNumbers) {
        return false;
      }
      
      // 如果计数未超过阈值且配置为允许未超过阈值的号码
      if (!isExceeded && remoteNumberFilterConfig.allowNonExceededNumbers) {
        return true;
      }
    }
    
    // 默认情况下，不基于远程号码做决定
    return true;
  }

  static const String _configKey = 'config_remote_number_filter';

  /// 从配置仓库加载配置
  Future<void> loadConfig() async {
    final configMap = await _configRepository.getConfig(_configKey);
    if (configMap != null) {
      remoteNumberFilterConfig = RemoteNumberFilterConfig.fromMap(configMap);
      // 同步更新服务中的计数阈值
      _remoteNumberService.setCountThreshold(remoteNumberFilterConfig.countThreshold);
    }
  }

  /// 保存配置到配置仓库
  Future<void> saveConfig() async {
    await _configRepository.saveConfig(_configKey, remoteNumberFilterConfig.toMap());
  }

  /// 更新配置
  Future<void> updateConfig(RemoteNumberFilterConfig newConfig) async {
    remoteNumberFilterConfig = newConfig;
    // 同步更新服务中的计数阈值
    _remoteNumberService.setCountThreshold(remoteNumberFilterConfig.countThreshold);
    await saveConfig();
  }

  /// 初始化服务
  @override
  Future<void> initialize() async {
    await loadConfig();
  }
}