// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_engine.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 纯底层内购与支付引擎 Provider

@ProviderFor(PurchaseEngine)
const purchaseEngineProvider = PurchaseEngineProvider._();

/// 纯底层内购与支付引擎 Provider
final class PurchaseEngineProvider
    extends $NotifierProvider<PurchaseEngine, void> {
  /// 纯底层内购与支付引擎 Provider
  const PurchaseEngineProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'purchaseEngineProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$purchaseEngineHash();

  @$internal
  @override
  PurchaseEngine create() => PurchaseEngine();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$purchaseEngineHash() => r'fa56bc8817be5ecdafffb4779e4485fa7d85b4c5';

/// 纯底层内购与支付引擎 Provider

abstract class _$PurchaseEngine extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleValue(ref, null);
  }
}
