// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LocationSyncService 的 @Riverpod Provider

@ProviderFor(locationSyncService)
final locationSyncServiceProvider = LocationSyncServiceProvider._();

/// LocationSyncService 的 @Riverpod Provider

final class LocationSyncServiceProvider
    extends
        $FunctionalProvider<
          LocationSyncService,
          LocationSyncService,
          LocationSyncService
        >
    with $Provider<LocationSyncService> {
  /// LocationSyncService 的 @Riverpod Provider
  LocationSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationSyncServiceHash();

  @$internal
  @override
  $ProviderElement<LocationSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationSyncService create(Ref ref) {
    return locationSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationSyncService>(value),
    );
  }
}

String _$locationSyncServiceHash() =>
    r'473d076654cf48bacbda303a360264a26c992a44';
