// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predefined_label_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PredefinedLabelService 的 @Riverpod Provider

@ProviderFor(predefinedLabelService)
final predefinedLabelServiceProvider = PredefinedLabelServiceProvider._();

/// PredefinedLabelService 的 @Riverpod Provider

final class PredefinedLabelServiceProvider
    extends
        $FunctionalProvider<
          PredefinedLabelService,
          PredefinedLabelService,
          PredefinedLabelService
        >
    with $Provider<PredefinedLabelService> {
  /// PredefinedLabelService 的 @Riverpod Provider
  PredefinedLabelServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'predefinedLabelServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$predefinedLabelServiceHash();

  @$internal
  @override
  $ProviderElement<PredefinedLabelService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PredefinedLabelService create(Ref ref) {
    return predefinedLabelService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PredefinedLabelService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PredefinedLabelService>(value),
    );
  }
}

String _$predefinedLabelServiceHash() =>
    r'451db74c8f695410be3211a46cc08da05b4587ee';
