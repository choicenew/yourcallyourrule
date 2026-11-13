// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_composite_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(enhancedCompositeFilterService)
final enhancedCompositeFilterServiceProvider =
    EnhancedCompositeFilterServiceProvider._();

final class EnhancedCompositeFilterServiceProvider
    extends
        $FunctionalProvider<
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService
        >
    with $Provider<EnhancedCompositeFilterService> {
  EnhancedCompositeFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enhancedCompositeFilterServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enhancedCompositeFilterServiceHash();

  @$internal
  @override
  $ProviderElement<EnhancedCompositeFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnhancedCompositeFilterService create(Ref ref) {
    return enhancedCompositeFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnhancedCompositeFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnhancedCompositeFilterService>(
        value,
      ),
    );
  }
}

String _$enhancedCompositeFilterServiceHash() =>
    r'60341c9a4cb74fa5f7d9fa3c46c76403512003bf';
