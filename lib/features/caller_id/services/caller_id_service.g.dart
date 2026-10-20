// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallerIdService 的 @Riverpod Provider

@ProviderFor(callerIdService)
final callerIdServiceProvider = CallerIdServiceProvider._();

/// CallerIdService 的 @Riverpod Provider

final class CallerIdServiceProvider
    extends
        $FunctionalProvider<CallerIdService, CallerIdService, CallerIdService>
    with $Provider<CallerIdService> {
  /// CallerIdService 的 @Riverpod Provider
  CallerIdServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdServiceHash();

  @$internal
  @override
  $ProviderElement<CallerIdService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CallerIdService create(Ref ref) {
    return callerIdService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallerIdService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallerIdService>(value),
    );
  }
}

String _$callerIdServiceHash() => r'b0e291c6a1c162a7fce507e2bcb3818befcc6f20';
