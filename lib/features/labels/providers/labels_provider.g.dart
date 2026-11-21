// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labels_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(labelService)
final labelServiceProvider = LabelServiceProvider._();

final class LabelServiceProvider
    extends $FunctionalProvider<LabelService, LabelService, LabelService>
    with $Provider<LabelService> {
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

String _$labelServiceHash() => r'0c7ea8f97d72b80c4f191d24f4288a39350a224c';

@ProviderFor(labelSystem)
final labelSystemProvider = LabelSystemProvider._();

final class LabelSystemProvider
    extends $FunctionalProvider<LabelService, LabelService, LabelService>
    with $Provider<LabelService> {
  LabelSystemProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelSystemProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelSystemHash();

  @$internal
  @override
  $ProviderElement<LabelService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LabelService create(Ref ref) {
    return labelSystem(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelService>(value),
    );
  }
}

String _$labelSystemHash() => r'7e11071835a760817966118f2f5e8bd90a5ed99b';
