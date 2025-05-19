// 本地号码计数过滤服务类，用于根据本地计数规则判断是否接受来电

import 'dart:async';

import 'package:yourcallyourrule/core/entities/plugin/plugin_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_config.dart';

/// 本地号码计数过滤服务类，用于根据本地计数规则判断是否接受来电
class LocalCountFilterService implements CallFilterInterface {
  // 显式声明所有依赖项
  final CallerIdService _callerIdService;
  final ConfigRepository _configRepository;
  
  // 存储最新的插件数据
  PluginData? _latestPluginData;
  
  // 订阅处理
  StreamSubscription<PluginData>? _pluginDataSubscription;

  LocalCountFilterConfig localCountFilterConfig = LocalCountFilterConfig();

  // 构造函数明确依赖关系
  LocalCountFilterService({
    required CallerIdService callerIdService,
    required ConfigRepository configRepository,
  })  : _callerIdService = callerIdService,
        _configRepository = configRepository;

  // 判断是否应该接受来电
  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
    // 如果未启用本地号码计数过滤，则默认接受
    if (!localCountFilterConfig.enableLocalCountFilter) {
      return true;
    }

    final phoneNumber = PhoneNumber(phoneNumberStr);
    
    // 如果启用了日志记录，记录查询
    if (localCountFilterConfig.logAllLocalQueries) {
      // 这里可以添加日志记录逻辑
    }
    
    // 检查是否有计数数据
    if (_latestPluginData != null && _latestPluginData!.phoneNumber == phoneNumberStr && _latestPluginData!.count != null) {
      final count = _latestPluginData!.count!;
      
      // 检查计数是否超过阈值
      final isExceeded = count >= localCountFilterConfig.countThreshold;
      
      // 如果计数超过阈值且配置为拒绝超过阈值的号码
      if (isExceeded && localCountFilterConfig.rejectExceededNumbers) {
        return false;
      }
      
      // 如果计数未超过阈值且配置为允许未超过阈值的号码
      if (!isExceeded && localCountFilterConfig.allowNonExceededNumbers) {
        return true;
      }
    }
    
    // 默认情况下，不基于本地计数做决定
    return true;
  }

  /// 从配置仓库加载配置
  Future<void> loadConfig() async {
    final configMap = await _configRepository.getConfig('local_count_filter');
    if (configMap != null) {
      localCountFilterConfig = LocalCountFilterConfig.fromMap(configMap);
    }
  }

  /// 保存配置到配置仓库
  Future<void> saveConfig() async {
    await _configRepository.saveConfig('local_count_filter', localCountFilterConfig.toMap());
  }

  /// 更新配置
  Future<void> updateConfig(LocalCountFilterConfig newConfig) async {
    localCountFilterConfig = newConfig;
    await saveConfig();
  }

  /// 初始化服务
  @override
  Future<void> initialize() async {
    await loadConfig();
    
    // 订阅插件数据流
    _pluginDataSubscription = _callerIdService.pluginDataStream.listen((pluginData) {
      _latestPluginData = pluginData;
    });
  }
  
  /// 释放资源
  void dispose() {
    _pluginDataSubscription?.cancel();
  }
}