// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_coordinator_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallCoordinatorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallCoordinatorService>(value),
    );
  }
}

String _$callCoordinatorServiceHash() =>
    r'28536701c6a1e00a58fe00984522983c072bf423';
