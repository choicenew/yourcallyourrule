// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_center_config_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(featureCenterConfigService)
final featureCenterConfigServiceProvider =
    FeatureCenterConfigServiceProvider._();

final class FeatureCenterConfigServiceProvider
    extends
        $FunctionalProvider<
          FeatureCenterConfigService,
          FeatureCenterConfigService,
          FeatureCenterConfigService
        >
    with $Provider<FeatureCenterConfigService> {
  FeatureCenterConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featureCenterConfigServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featureCenterConfigServiceHash();

  @$internal
  @override
  $ProviderElement<FeatureCenterConfigService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FeatureCenterConfigService create(Ref ref) {
    return featureCenterConfigService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeatureCenterConfigService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeatureCenterConfigService>(value),
    );
  }
}

String _$featureCenterConfigServiceHash() =>
    r'bf173211c0214d386c860e1195f56ccb07e097f3';
