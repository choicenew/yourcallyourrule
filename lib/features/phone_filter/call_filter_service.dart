import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';

export 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';
export 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';

part 'call_filter_service.g.dart';

/// 组合通话过滤器服务中枢 Provider (合并 enhancedCompositeFilterService)
/// 零业务 Feature 依赖，所有子过滤器由各 Feature 自身实现并在 Coordinator 统一注册装配
@Riverpod(keepAlive: true)
EnhancedCompositeFilterService callFilterService(Ref ref) {
  return EnhancedCompositeFilterService.instance;
}

@Riverpod(keepAlive: true)
EnhancedCompositeFilterService enhancedCompositeFilterService(Ref ref) {
  return EnhancedCompositeFilterService.instance;
}
