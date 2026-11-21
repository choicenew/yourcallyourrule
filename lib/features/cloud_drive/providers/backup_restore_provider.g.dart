// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_restore_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 100% 绑定包内 pyro_cloud_drive_database 标准 BackupRestoreService 引擎

@ProviderFor(backupRestoreService)
final backupRestoreServiceProvider = BackupRestoreServiceProvider._();

/// 100% 绑定包内 pyro_cloud_drive_database 标准 BackupRestoreService 引擎

final class BackupRestoreServiceProvider
    extends
        $FunctionalProvider<
          BackupRestoreService,
          BackupRestoreService,
          BackupRestoreService
        >
    with $Provider<BackupRestoreService> {
  /// 100% 绑定包内 pyro_cloud_drive_database 标准 BackupRestoreService 引擎
  BackupRestoreServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupRestoreServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupRestoreServiceHash();

  @$internal
  @override
  $ProviderElement<BackupRestoreService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupRestoreService create(Ref ref) {
    return backupRestoreService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupRestoreService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupRestoreService>(value),
    );
  }
}

String _$backupRestoreServiceHash() =>
    r'2748f1afb56ffe67e46fd61ccd263d64e5e243b4';
