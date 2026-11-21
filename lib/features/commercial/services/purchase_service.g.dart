// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(purchaseService)
final purchaseServiceProvider = PurchaseServiceProvider._();

final class PurchaseServiceProvider
    extends
        $FunctionalProvider<PurchaseService, PurchaseService, PurchaseService>
    with $Provider<PurchaseService> {
  PurchaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseServiceHash();

  @$internal
  @override
  $ProviderElement<PurchaseService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PurchaseService create(Ref ref) {
    return purchaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseService>(value),
    );
  }
}

String _$purchaseServiceHash() => r'b0d55364af083d23b62e5d073f535c62753d3b94';
