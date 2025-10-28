// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_composite_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(enhancedCompositeFilterService)
const enhancedCompositeFilterServiceProvider =
    EnhancedCompositeFilterServiceProvider._();

final class EnhancedCompositeFilterServiceProvider
    extends
        $FunctionalProvider<
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService
        >
    with $Provider<EnhancedCompositeFilterService> {
  const EnhancedCompositeFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enhancedCompositeFilterServiceProvider',
        isAutoDispose: true,
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
    r'75fc9920d0813747d4480946abcaf8e24c9b3542';
