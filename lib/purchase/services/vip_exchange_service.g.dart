// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip_exchange_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vipExchangeService)
final vipExchangeServiceProvider = VipExchangeServiceProvider._();

final class VipExchangeServiceProvider
    extends
        $FunctionalProvider<
          VipExchangeService,
          VipExchangeService,
          VipExchangeService
        >
    with $Provider<VipExchangeService> {
  VipExchangeServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vipExchangeServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vipExchangeServiceHash();

  @$internal
  @override
  $ProviderElement<VipExchangeService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VipExchangeService create(Ref ref) {
    return vipExchangeService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VipExchangeService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VipExchangeService>(value),
    );
  }
}

String _$vipExchangeServiceHash() =>
    r'510b0ad2f19056ee37baddd8f4cced9a20d8471c';
