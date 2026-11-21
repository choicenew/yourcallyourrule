// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commercialHub)
final commercialHubProvider = CommercialHubProvider._();

final class CommercialHubProvider
    extends $FunctionalProvider<CommercialHub, CommercialHub, CommercialHub>
    with $Provider<CommercialHub> {
  CommercialHubProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commercialHubProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commercialHubHash();

  @$internal
  @override
  $ProviderElement<CommercialHub> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CommercialHub create(Ref ref) {
    return commercialHub(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommercialHub value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommercialHub>(value),
    );
  }
}

String _$commercialHubHash() => r'1dd17941ae6c016b38881264c79a067be2b9f6ad';

/// 全局 VIP 用户特权响应式 Provider

@ProviderFor(isVipUser)
final isVipUserProvider = IsVipUserProvider._();

/// 全局 VIP 用户特权响应式 Provider

final class IsVipUserProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 全局 VIP 用户特权响应式 Provider
  IsVipUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isVipUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isVipUserHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isVipUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isVipUserHash() => r'8e38469234382b4b0d639f74e9cb513c96b8044e';

@ProviderFor(commercialService)
final commercialServiceProvider = CommercialServiceProvider._();

final class CommercialServiceProvider
    extends
        $FunctionalProvider<
          CommercialService,
          CommercialService,
          CommercialService
        >
    with $Provider<CommercialService> {
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
  String debugGetCreateSourceHash() => _$commercialServiceHash();

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

String _$commercialServiceHash() => r'9700ec986b176b68dc2b677ee3631f2c6670802d';
