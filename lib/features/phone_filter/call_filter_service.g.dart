// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callFilterService)
final callFilterServiceProvider = CallFilterServiceProvider._();

final class CallFilterServiceProvider
    extends
        $FunctionalProvider<
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService,
          EnhancedCompositeFilterService
        >
    with $Provider<EnhancedCompositeFilterService> {
  CallFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callFilterServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callFilterServiceHash();

  @$internal
  @override
  $ProviderElement<EnhancedCompositeFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnhancedCompositeFilterService create(Ref ref) {
    return callFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnhancedCompositeFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnhancedCompositeFilterService>(value),
    );
  }
}

String _$callFilterServiceHash() => r'c2a543881df681577d611891e457fceabf4f3780';

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
      providerOverride: $SyncValueProvider<EnhancedCompositeFilterService>(value),
    );
  }
}

String _$enhancedCompositeFilterServiceHash() =>
    r'db6b937667822fe1fa22caec61fb55979bb945d8';
