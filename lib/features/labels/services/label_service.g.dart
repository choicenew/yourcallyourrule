// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LabelService 的 @Riverpod Provider

@ProviderFor(labelService)
final labelServiceProvider = LabelServiceProvider._();

/// LabelService 的 @Riverpod Provider

final class LabelServiceProvider
    extends $FunctionalProvider<LabelService, LabelService, LabelService>
    with $Provider<LabelService> {
  /// LabelService 的 @Riverpod Provider
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
  String debugGetCreateSourceHash() => _$labelServiceHash();

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

String _$labelServiceHash() => r'4badd8cbd40530e407a551db99ec317f87868947';
