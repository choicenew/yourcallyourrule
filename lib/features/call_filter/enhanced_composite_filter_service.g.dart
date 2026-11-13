// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_composite_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 增强版组合过滤器服务中枢 Provider
/// 统一接入 package:pyro_call_filter_hub 中的 EnhancedCompositeFilterService
/// 避开对任何特定 feature 的横向依赖，所有子过滤器由各自 package 自注册接入！

@ProviderFor(enhancedCompositeFilterService)
final enhancedCompositeFilterServiceProvider =
    EnhancedCompositeFilterServiceProvider._();

/// 增强版组合过滤器服务中枢 Provider
/// 统一接入 package:pyro_call_filter_hub 中的 EnhancedCompositeFilterService
/// 避开对任何特定 feature 的横向依赖，所有子过滤器由各自 package 自注册接入！

final class EnhancedCompositeFilterServiceProvider
    extends
        $FunctionalProvider<
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService
        >
    with $Provider<EnhancedCompositeFilterService> {
  /// 增强版组合过滤器服务中枢 Provider
  /// 统一接入 package:pyro_call_filter_hub 中的 EnhancedCompositeFilterService
  /// 避开对任何特定 feature 的横向依赖，所有子过滤器由各自 package 自注册接入！
  EnhancedCompositeFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enhancedCompositeFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enhancedCompositeFilterServiceHash();

  @$internal
  @override
  $ProviderElement<EnhancedCompositeFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnhancedCompositeFilterService create(Ref ref) {
    return enhancedCompositeFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnhancedCompositeFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnhancedCompositeFilterService>(
        value,
      ),
    );
  }
}

String _$enhancedCompositeFilterServiceHash() =>
    r'791f67a3e94059d907a9cb5861b79d87184baee6';
