// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_sync_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
@ProviderFor(activeCloudDriver)
final activeCloudDriverProvider = ActiveCloudDriverProvider._();

final class ActiveCloudDriverProvider
    extends
        $FunctionalProvider<
          CloudDriveAdapter?,
          CloudDriveAdapter?,
          CloudDriveAdapter?
        >
    with $Provider<CloudDriveAdapter?> {
  ActiveCloudDriverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCloudDriverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCloudDriverHash();

  @$internal
  @override
  $ProviderElement<CloudDriveAdapter?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CloudDriveAdapter? create(Ref ref) {
    return activeCloudDriver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudDriveAdapter? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudDriveAdapter?>(value),
    );
  }
}

String _$activeCloudDriverHash() => r'3b04e62857f4f68c028713c3df79ee86ae564136';

@ProviderFor(cloudSyncStatus)
final cloudSyncStatusProvider = CloudSyncStatusProvider._();

final class CloudSyncStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  CloudSyncStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloudSyncStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloudSyncStatusHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return cloudSyncStatus(ref);
  }
}

String _$cloudSyncStatusHash() => r'3c7d535f05018ca556ab7a6d248e1f51180a81aa';
