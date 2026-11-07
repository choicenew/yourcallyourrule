// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_backup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 配置仓库提供者

@ProviderFor(configRepository)
const configRepositoryProvider = ConfigRepositoryProvider._();

/// 配置仓库提供者

final class ConfigRepositoryProvider extends $FunctionalProvider<
    ConfigRepository,
    ConfigRepository,
    ConfigRepository> with $Provider<ConfigRepository> {
  /// 配置仓库提供者
  const ConfigRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'configRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$configRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConfigRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ConfigRepository create(Ref ref) {
    return configRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConfigRepository>(value),
    );
  }
}

String _$configRepositoryHash() => r'602db6ffdf10f94eb4f605596851265b751b5c8a';

/// 配置备份服务提供者

@ProviderFor(configBackupService)
const configBackupServiceProvider = ConfigBackupServiceProvider._();

/// 配置备份服务提供者

final class ConfigBackupServiceProvider extends $FunctionalProvider<
    ConfigBackupService,
    ConfigBackupService,
    ConfigBackupService> with $Provider<ConfigBackupService> {
  /// 配置备份服务提供者
  const ConfigBackupServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'configBackupServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$configBackupServiceHash();

  @$internal
  @override
  $ProviderElement<ConfigBackupService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

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
    r'f452e10be26b07b97e675e279bebfe226ca20c1b';
