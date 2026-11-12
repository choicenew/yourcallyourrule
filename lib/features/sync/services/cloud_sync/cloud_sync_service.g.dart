// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 主 App 云盘同步与加密备份 Riverpod 适配服务 (CloudSyncService)
/// 100% 委托调配 packages/clouddrive/ 包组 (CloudDriveControlCenter & DeviceManagementService)

@ProviderFor(cloudSyncService)
final cloudSyncServiceProvider = CloudSyncServiceProvider._();

/// 主 App 云盘同步与加密备份 Riverpod 适配服务 (CloudSyncService)
/// 100% 委托调配 packages/clouddrive/ 包组 (CloudDriveControlCenter & DeviceManagementService)

final class CloudSyncServiceProvider
    extends
        $FunctionalProvider<
          CloudSyncService,
          CloudSyncService,
          CloudSyncService
        >
    with $Provider<CloudSyncService> {
  /// 主 App 云盘同步与加密备份 Riverpod 适配服务 (CloudSyncService)
  /// 100% 委托调配 packages/clouddrive/ 包组 (CloudDriveControlCenter & DeviceManagementService)
  CloudSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloudSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloudSyncServiceHash();

  @$internal
  @override
  $ProviderElement<CloudSyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CloudSyncService create(Ref ref) {
    return cloudSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudSyncService>(value),
    );
  }
}

String _$cloudSyncServiceHash() => r'fe6a84c6ef73ac2559050993ed1fcfca2431c247';
