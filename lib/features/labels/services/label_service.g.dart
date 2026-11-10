// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LabelService Provider

@ProviderFor(labelService)
final labelServiceProvider = LabelServiceProvider._();

/// LabelService Provider

final class LabelServiceProvider
    extends $FunctionalProvider<LabelService, LabelService, LabelService>
    with $Provider<LabelService> {
  /// LabelService Provider
  LabelServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'label_service_hash_v9';

  @$internal
  @override
  $ProviderElement<LabelService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LabelService create(Ref ref) {
    return labelService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelService>(value),
    );
  }
}
