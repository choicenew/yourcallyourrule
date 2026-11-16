// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_monitor_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callerIdMonitorService)
final callerIdMonitorServiceProvider = CallerIdMonitorServiceProvider._();

final class CallerIdMonitorServiceProvider
    extends
        $FunctionalProvider<
          CallerIdMonitorService,
          CallerIdMonitorService,
          CallerIdMonitorService
        >
    with $Provider<CallerIdMonitorService> {
  CallerIdMonitorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdMonitorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdMonitorServiceHash();

  @$internal
  @override
  $ProviderElement<CallerIdMonitorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallerIdMonitorService create(Ref ref) {
    return callerIdMonitorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallerIdMonitorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallerIdMonitorService>(value),
    );
  }
}

String _$callerIdMonitorServiceHash() =>
    r'02cd7f996e8215f695c6c0e4fd0a0eae27d22dd7';
