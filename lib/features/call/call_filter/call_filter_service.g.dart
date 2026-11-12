// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallFilterService Riverpod Provider (完全解耦，零横向 rules import)

@ProviderFor(callFilterService)
final callFilterServiceProvider = CallFilterServiceProvider._();

/// CallFilterService Riverpod Provider (完全解耦，零横向 rules import)

final class CallFilterServiceProvider
    extends
        $FunctionalProvider<
          CallFilterService,
          CallFilterService,
          CallFilterService
        >
    with $Provider<CallFilterService> {
  /// CallFilterService Riverpod Provider (完全解耦，零横向 rules import)
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
  String debugGetCreateSourceHash() => _$callFilterServiceHash();

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

String _$callFilterServiceHash() => r'5d1a84dc04a4071779e0d3cb1244ec8371657e8a';
