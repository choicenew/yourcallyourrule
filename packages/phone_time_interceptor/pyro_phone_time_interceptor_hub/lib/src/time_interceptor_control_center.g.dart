// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interceptor_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timeInterceptorControlCenter)
final timeInterceptorControlCenterProvider =
    TimeInterceptorControlCenterProvider._();

final class TimeInterceptorControlCenterProvider
    extends
        $FunctionalProvider<
          TimeInterceptorControlCenter,
          TimeInterceptorControlCenter,
          TimeInterceptorControlCenter
        >
    with $Provider<TimeInterceptorControlCenter> {
  TimeInterceptorControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeInterceptorControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeInterceptorControlCenterHash();

  @$internal
  @override
  $ProviderElement<TimeInterceptorControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TimeInterceptorControlCenter create(Ref ref) {
    return timeInterceptorControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimeInterceptorControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimeInterceptorControlCenter>(value),
    );
  }
}

String _$timeInterceptorControlCenterHash() =>
    r'424b86a9ee0bfeee00f74910356c6287c8681f07';
