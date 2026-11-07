import 'package:flutter/foundation.dart';
import 'package:pyro_phone_count_filter_protocol/pyro_phone_count_filter_protocol.dart';

/// 真实内存级本地频次过滤持久化驱动 (MemoryPhoneCountStorageDriver)
class MemoryPhoneCountStorageDriver implements PhoneCountStorageDriver {
  PhoneCountFilterConfig _config = const PhoneCountFilterConfig();

  MemoryPhoneCountStorageDriver();

  @override
  Future<PhoneCountFilterConfig> getConfig() async {
    return _config;
  }

  @override
  Future<void> saveConfig(PhoneCountFilterConfig config) async {
    _config = config;
    debugPrint('[MemoryPhoneCountDriver] 持久化保存频次配置: threshold = ${config.countThreshold}');
  }
}
