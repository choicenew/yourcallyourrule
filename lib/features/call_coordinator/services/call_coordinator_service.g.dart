// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_coordinator_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(callCoordinatorService)
final callCoordinatorServiceProvider = CallCoordinatorServiceProvider._();

final class CallCoordinatorServiceProvider
    extends
        $FunctionalProvider<
          CallCoordinatorService,
          CallCoordinatorService,
          CallCoordinatorService
        >
    with $Provider<CallCoordinatorService> {
  CallCoordinatorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callCoordinatorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callCoordinatorServiceHash();

  @$internal
  @override
  $ProviderElement<CallCoordinatorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallCoordinatorService create(Ref ref) {
    return callCoordinatorService(ref);
  }

  Override overrideWithValue(CallCoordinatorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallCoordinatorService>(value),
    );
  }
}

String _$callCoordinatorServiceHash() =>
    r'a11883fc51480fef8d34b3f889efc4f74d0234bc';
