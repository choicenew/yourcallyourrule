import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';

/// 过滤器外观装配线 (Facade Assembly - 零内置，纯自注册)
class PyroCallFilterConnector {
  static void registerAll({List<CallFilterInterface>? customFilters}) {
    if (customFilters != null) {
      for (final f in customFilters) {
        EnhancedCompositeFilterService.instance.registerFilter(f);
      }
    }
  }
}
