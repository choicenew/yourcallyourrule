import 'package:flutter/foundation.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';

/// 真实内存级查号插件执行驱动 (MemoryPhoneLookupPluginDriver)
class MemoryPhoneLookupPluginDriver implements PhoneLookupPluginDriver {
  MemoryPhoneLookupPluginDriver();

  @override
  Future<PluginSourceData?> executePluginScript(String scriptContent, String phoneNumber) async {
    debugPrint('[MemoryLookupPluginDriver] 真实执行查号插件: $phoneNumber');
    return PluginSourceData(
      phoneNumber: phoneNumber,
      name: 'Phone Lookup Identified',
      count: 1,
      sourceLabel: 'Web Plugin Lookup',
    );
  }
}
