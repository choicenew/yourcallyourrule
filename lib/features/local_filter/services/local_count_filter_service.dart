import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/local_filter/config/local_count_filter_config.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';

part 'local_count_filter_service.g.dart';

@riverpod
LocalCountFilterService localCountFilterService(Ref ref) {
  final service = LocalCountFilterService(
    callerIdentityService: ref.watch(callerIdentityServiceProvider),
    getConfig: () async => await ref.read(localCountFilterConfigProvider.future),
  );
  service.initialize();
  ref.onDispose(() => service.dispose());
  return service;
}

/// 本地号码计数过滤服务�?
class LocalCountFilterService implements CallFilterInterface {
  final CallerIdentityService _callerIdentityService;
  final Future<LocalCountFilterConfig> Function() _getConfig;

  PluginSourceData? _latestPluginData;
  bool _isDisposed = false;
  
  StreamSubscription<PluginSourceData>? _pluginDataSubscription;

  LocalCountFilterService({
    required CallerIdentityService callerIdentityService,
    required Future<LocalCountFilterConfig> Function() getConfig,
  })  : _callerIdentityService = callerIdentityService,
        _getConfig = getConfig;

  @override
  CallFilterType get filterType => CallFilterType.localCount;

 // 判断是否应该接受来电
  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr, {SimInfo? simInfo}) async {
    try {
      if (_isDisposed) {
        return true;
      }
      final config = await _getConfig();
      // 如果未启用本地号码计数过滤，则默认接�?
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
        // 检查计数是否超过阈�?
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
    } catch (_) {
      return true;
    }
  }

  @override
  Future<void> initialize() async {
    _pluginDataSubscription ??= _callerIdentityService.pluginDataStream.listen((pluginSourceData) {
      _latestPluginData = pluginSourceData;
    });
  }
  
  /// 释放资源
  void dispose() {
    _isDisposed = true;
    _pluginDataSubscription?.cancel();
  }
}
