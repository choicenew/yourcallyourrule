// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_monitor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callMonitorService)
final callMonitorServiceProvider = CallMonitorServiceProvider._();

final class CallMonitorServiceProvider
    extends
        $FunctionalProvider<
          CallMonitorService,
          CallMonitorService,
          CallMonitorService
        >
    with $Provider<CallMonitorService> {
  CallMonitorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callMonitorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callMonitorServiceHash();

  @$internal
  @override
  $ProviderElement<CallMonitorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallMonitorService create(Ref ref) {
    return callMonitorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallMonitorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallMonitorService>(value),
    );
  }
}

String _$callMonitorServiceHash() =>
    r'ddc4387b50bd85a2583b962aa4fbe7d977ec8005';
