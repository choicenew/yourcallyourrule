// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_identity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callerIdentityService)
final callerIdentityServiceProvider = CallerIdentityServiceProvider._();

final class CallerIdentityServiceProvider
    extends
        $FunctionalProvider<
          CallerIdentityService,
          CallerIdentityService,
          CallerIdentityService
        >
    with $Provider<CallerIdentityService> {
  CallerIdentityServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callerIdentityServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callerIdentityServiceHash();

  @$internal
  @override
  $ProviderElement<CallerIdentityService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallerIdentityService create(Ref ref) {
    return callerIdentityService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallerIdentityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallerIdentityService>(value),
    );
  }
}

String _$callerIdentityServiceHash() =>
    r'bc94893cad8ee9c2c30abf411325a5ae77cb09f5';
