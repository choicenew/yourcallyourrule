// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 组合通话过滤器服务中枢 Provider (合并 enhancedCompositeFilterService)
/// 零业务 Feature 依赖，所有子过滤器由各 Feature 自身实现并在 Coordinator 统一注册装配

@ProviderFor(callFilterService)
final callFilterServiceProvider = CallFilterServiceProvider._();

/// 组合通话过滤器服务中枢 Provider (合并 enhancedCompositeFilterService)
/// 零业务 Feature 依赖，所有子过滤器由各 Feature 自身实现并在 Coordinator 统一注册装配

final class CallFilterServiceProvider
    extends
        $FunctionalProvider<
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService
        >
    with $Provider<EnhancedCompositeFilterService> {
  /// 组合通话过滤器服务中枢 Provider (合并 enhancedCompositeFilterService)
  /// 零业务 Feature 依赖，所有子过滤器由各 Feature 自身实现并在 Coordinator 统一注册装配
  CallFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callFilterServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callFilterServiceHash();

  @$internal
  @override
  $ProviderElement<EnhancedCompositeFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnhancedCompositeFilterService create(Ref ref) {
    return callFilterService(ref);
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

String _$callFilterServiceHash() => r'dab4544350134158eee4505f34343c668913b202';

@ProviderFor(enhancedCompositeFilterService)
final enhancedCompositeFilterServiceProvider =
    EnhancedCompositeFilterServiceProvider._();

final class EnhancedCompositeFilterServiceProvider
    extends
        $FunctionalProvider<
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService
        >
    with $Provider<EnhancedCompositeFilterService> {
  EnhancedCompositeFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enhancedCompositeFilterServiceProvider',
        isAutoDispose: false,
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
    r'fc5809c3ecb371e6a35efaa366fe7a50ab045366';
