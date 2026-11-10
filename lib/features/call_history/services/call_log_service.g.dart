// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallLogService Riverpod Provider

@ProviderFor(callLogService)
final callLogServiceProvider = CallLogServiceProvider._();

/// CallLogService Riverpod Provider

final class CallLogServiceProvider
    extends
        $FunctionalProvider<
          CallLogService,
          CallLogService,
          CallLogService
        >
    with $Provider<CallLogService> {
  /// CallLogService Riverpod Provider
  CallLogServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLogServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'call_log_service_hash_v2';

  @$internal
  @override
  $ProviderElement<CallLogService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallLogService create(Ref ref) {
    return callLogService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallLogService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallLogService>(value),
    );
  }
}
