import 'package:pyro_phone_lookup_plugin_protocol/src/models/plugin_source_data.dart';

/// 查号插件执行 Driver 抽象接口契约 (PhoneLookupPluginDriver)
abstract class PhoneLookupPluginDriver {
  Future<PluginSourceData?> executePluginScript(String scriptContent, String phoneNumber);
}
