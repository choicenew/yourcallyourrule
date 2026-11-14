import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';

part 'phone_lookup_plugin_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneLookupPluginControlCenter phoneLookupPluginControlCenter(Ref ref) {
  return PhoneLookupPluginControlCenter.instance;
}

/// 查号插件调度与广播中枢 (PhoneLookupPluginControlCenter)
class PhoneLookupPluginControlCenter {
  static final PhoneLookupPluginControlCenter instance = PhoneLookupPluginControlCenter._();

  PhoneLookupPluginControlCenter._();

  PhoneLookupPluginDriver? _scriptDriver;
  final _pluginDataController = StreamController<PluginSourceData>.broadcast();

  /// 无差别公开广播网页/API 查号数据 Delta (Delta Stream)
  Stream<PluginSourceData> get pluginDataStream => _pluginDataController.stream;

  void registerScriptDriver(PhoneLookupPluginDriver driver) {
    _scriptDriver = driver;
    debugPrint('[PhoneLookupPluginHub] 已挂载注册 JS/API 查号驱动: ${driver.runtimeType}');
  }

  PhoneLookupPluginDriver? get scriptDriver => _scriptDriver;

  /// 触发广播 PluginSourceData Delta
  void broadcastPluginData(PluginSourceData data) {
    _pluginDataController.add(data);
    debugPrint('[PhoneLookupPluginHub] 无差别广播查号数据: ${data.phoneNumber} (count: ${data.count})');
  }

  /// 批量并发号码插件查询 (executeBatchLookup)
  Future<List<PluginSourceData>> executeBatchLookup(List<String> numbers) async {
    if (_scriptDriver == null) return [];
    final futures = numbers.map((num) => _scriptDriver!.fetchLookup(num)).toList();
    final responses = await Future.wait(futures);
    final results = <PluginSourceData>[];
    for (final res in responses) {
      if (res != null) {
        results.add(res);
        broadcastPluginData(res);
      }
    }
    return results;
  }
}
