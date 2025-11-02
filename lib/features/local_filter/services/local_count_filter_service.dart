import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
// 导入依赖的 Provider
import 'package:yourcallyourrule/features/caller_id/providers/caller_id_service_provider.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';


part 'local_count_filter_service.g.dart';

@riverpod
LocalCountFilterService localCountFilterService(Ref ref) {
  final service = LocalCountFilterService(
    callerIdService: ref.watch(callerIdServiceProvider),
    ref: ref,
  );
  service.initialize(); // 服务本身需要初始化监听器
  // 当 provider 销毁时，调用 dispose
  ref.onDispose(() => service.dispose());
  return service;
}

/// 本地号码计数过滤服务类 (无状态)
class LocalCountFilterService implements CallFilterInterface {
  final CallerIdService _callerIdService;
  final Ref _ref;

  PluginSourceData? _latestPluginData;
  
  // 订阅处理
  StreamSubscription<PluginSourceData>? _pluginDataSubscription;
// 构造函数明确依赖关系
  LocalCountFilterService({
    required CallerIdService callerIdService,
    required Ref ref,
  })  : _callerIdService = callerIdService,
        _ref = ref;
 // 判断是否应该接受来电
  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
    final config = await _ref.read(localCountFilterConfigProvider.future);
      // 如果未启用本地号码计数过滤，则默认接受
    if (!config.enableLocalCountFilter) {
      return true;
    }

    final phoneNumber = PhoneNumber(phoneNumberStr);
      // 如果启用了日志记录，记录查询
    if (config.logAllLocalQueries) {
      // 日志记录逻辑
    }
     
 // 检查是否有计数数据
    if (_latestPluginData != null && _latestPluginData!.phoneNumber == phoneNumberStr && _latestPluginData!.count != null) {
      final count = _latestPluginData!.count!;
       // 检查计数是否超过阈值
      final isExceeded = count >= config.countThreshold;
       // 如果计数超过阈值且配置为拒绝超过阈值的号码
      if (isExceeded && config.rejectExceededNumbers) {
        return false;
      }
      // 如果计数未超过阈值且配置为允许未超过阈值的号码
      if (!isExceeded && config.allowNonExceededNumbers) {
        return true;
      }
    }
     // 默认情况下，不基于本地计数做决定
    return true;
  }

  @override
  Future<void> initialize() async {
    // 订阅插件数据流
    _pluginDataSubscription ??= _callerIdService.pluginDataStream.listen((pluginSourceData) {
      _latestPluginData = pluginSourceData;
    });
  }
  
  /// 释放资源
  void dispose() {
    _pluginDataSubscription?.cancel();
  }
}