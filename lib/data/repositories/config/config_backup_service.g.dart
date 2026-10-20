// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_backup_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 配置备份还原服务提供者

@ProviderFor(configBackupService)
final configBackupServiceProvider = ConfigBackupServiceProvider._();

/// 配置备份还原服务提供者

final class ConfigBackupServiceProvider
    extends
        $FunctionalProvider<
          ConfigBackupService,
          ConfigBackupService,
          ConfigBackupService
        >
    with $Provider<ConfigBackupService> {
  /// 配置备份还原服务提供者
  ConfigBackupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'configBackupServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$configBackupServiceHash();

  @$internal
  @override
  $ProviderElement<ConfigBackupService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConfigBackupService create(Ref ref) {
    return configBackupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConfigBackupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConfigBackupService>(value),
    );
  }
}

String _$configBackupServiceHash() =>
    r'29b18f253705d5eed1b3c5b277684f24ca1f143b';
