// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Purchase)
const purchaseProvider = PurchaseProvider._();

final class PurchaseProvider
    extends $NotifierProvider<Purchase, PurchaseProviderState> {
  const PurchaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseHash();

  @$internal
  @override
  Purchase create() => Purchase();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseProviderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseProviderState>(value),
    );
  }
}

String _$purchaseHash() => r'af6b97af4479264df3f0a1e255102a6c11cefc30';

abstract class _$Purchase extends $Notifier<PurchaseProviderState> {
  PurchaseProviderState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PurchaseProviderState, PurchaseProviderState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PurchaseProviderState, PurchaseProviderState>,
              PurchaseProviderState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
