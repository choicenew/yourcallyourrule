// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_control_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adControlService)
final adControlServiceProvider = AdControlServiceProvider._();

final class AdControlServiceProvider
    extends
        $FunctionalProvider<
          AdControlService,
          AdControlService,
          AdControlService
        >
    with $Provider<AdControlService> {
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
  String debugGetCreateSourceHash() => _$adControlServiceHash();

  @$internal
  @override
  $ProviderElement<AdControlService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

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

String _$adControlServiceHash() => r'0270a695b9c8f94d666d4722f633ac7303a73322';
