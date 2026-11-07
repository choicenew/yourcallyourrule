// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_identity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(callerIdentityService)
final callerIdentityServiceProvider = CallerIdentityServiceProvider._();

final class CallerIdentityServiceProvider
    extends
        $FunctionalProvider<CallerIdentityService, CallerIdentityService, CallerIdentityService>
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
  $ProviderElement<CallerIdentityService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CallerIdentityService create(Ref ref) {
    return callerIdentityService(ref);
  }

  Override overrideWithValue(CallerIdentityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallerIdentityService>(value),
    );
  }
}

String _$callerIdentityServiceHash() => r'b0e291c6a1c162a7fce507e2bcb3818befcc6f20';
