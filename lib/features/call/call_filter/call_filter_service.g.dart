// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallFilterService 的 @riverpod Provider

@ProviderFor(callFilterService)
final callFilterServiceProvider = CallFilterServiceProvider._();

/// CallFilterService 的 @riverpod Provider

final class CallFilterServiceProvider
    extends
        $FunctionalProvider<
          CallFilterService,
          CallFilterService,
          CallFilterService
        >
    with $Provider<CallFilterService> {
  /// CallFilterService 的 @riverpod Provider
  CallFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'call_filter_service_hash_v4';

  @$internal
  @override
  $ProviderElement<CallFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallFilterService create(Ref ref) {
    return callFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallFilterService>(value),
    );
  }
}
