// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 商业化服务提供者

@ProviderFor(commercialService)
final commercialServiceProvider = CommercialServiceProvider._();

/// 商业化服务提供者

final class CommercialServiceProvider
    extends
        $FunctionalProvider<
          CommercialService,
          CommercialService,
          CommercialService
        >
    with $Provider<CommercialService> {
  /// 商业化服务提供者
  CommercialServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commercialServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'commercial_service_hash_v2';

  @$internal
  @override
  $ProviderElement<CommercialService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommercialService create(Ref ref) {
    return commercialService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommercialService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommercialService>(value),
    );
  }
}
