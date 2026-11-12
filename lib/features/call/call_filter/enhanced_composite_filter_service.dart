import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_call_filter_hub/pyro_call_filter_hub.dart';

part 'enhanced_composite_filter_service.g.dart';

/// 增强版组合过滤器服务中枢 Provider
/// 统一接入 package:pyro_call_filter_hub 中的 EnhancedCompositeFilterService
/// 避开对任何特定 feature 的横向依赖，所有子过滤器由各自 package 自注册接入！
@riverpod
EnhancedCompositeFilterService enhancedCompositeFilterService(Ref ref) {
  return EnhancedCompositeFilterService.instance;
}
