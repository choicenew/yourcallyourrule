// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_control_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 广告控制服务提供者
/// 基于 CommercialService 的购买状态决定是否展示广告

@ProviderFor(adControlService)
final adControlServiceProvider = AdControlServiceProvider._();

/// 广告控制服务提供者
/// 基于 CommercialService 的购买状态决定是否展示广告

final class AdControlServiceProvider
    extends
        $FunctionalProvider<AdControlService, AdControlService, AdControlService>
    with $Provider<AdControlService> {
  /// 广告控制服务提供者
  /// 基于 CommercialService 的购买状态决定是否展示广告
  AdControlServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adControlServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'ad_control_service_hash_v1';

  @$internal
  @override
  $ProviderElement<AdControlService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdControlService create(Ref ref) {
    return adControlService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdControlService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdControlService>(value),
    );
  }
}
