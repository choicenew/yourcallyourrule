// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallLogService 的 @Riverpod Provider

@ProviderFor(callLogService)
final callLogServiceProvider = CallLogServiceProvider._();

/// CallLogService 的 @Riverpod Provider

final class CallLogServiceProvider
    extends $FunctionalProvider<CallLogService, CallLogService, CallLogService>
    with $Provider<CallLogService> {
  /// CallLogService 的 @Riverpod Provider
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
  String debugGetCreateSourceHash() => _$callLogServiceHash();

  @$internal
  @override
  $ProviderElement<CallLogService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

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

String _$callLogServiceHash() => r'a009e0ba66ff0bf9fff7b4553d4fcc2e66847e11';
