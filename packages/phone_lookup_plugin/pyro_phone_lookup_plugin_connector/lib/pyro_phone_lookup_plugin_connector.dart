library pyro_phone_lookup_plugin_connector;

import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_lookup_plugin_hub/pyro_phone_lookup_plugin_hub.dart';
import 'package:pyro_phone_lookup_plugin_driver/pyro_phone_lookup_plugin_driver.dart';

/// 查号插件外观装配线 (Facade Assembly)
class PyroPhoneLookupPluginConnector {
  static void registerAll({PhoneLookupPluginDriver? customScriptDriver}) {
    final driver = customScriptDriver ?? MemoryPhoneLookupPluginDriver();
    PhoneLookupPluginControlCenter.instance.registerScriptDriver(driver);
  }
}
