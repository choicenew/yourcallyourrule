// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteNumberFilterService)
const remoteNumberFilterServiceProvider = RemoteNumberFilterServiceProvider._();

final class RemoteNumberFilterServiceProvider
    extends
        $FunctionalProvider<
          RemoteNumberFilterService,
          RemoteNumberFilterService,
          RemoteNumberFilterService
        >
    with $Provider<RemoteNumberFilterService> {
  const RemoteNumberFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteNumberFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteNumberFilterServiceHash();

  @$internal
  @override
  $ProviderElement<RemoteNumberFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteNumberFilterService create(Ref ref) {
    return remoteNumberFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteNumberFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteNumberFilterService>(value),
    );
  }
}

String _$remoteNumberFilterServiceHash() =>
    r'b97b18c9fa0ecacc1e3cc74a69caa1af5f7dae0d';
