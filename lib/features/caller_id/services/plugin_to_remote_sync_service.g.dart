// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_to_remote_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PluginToRemoteSyncService 的 @Riverpod Provider

@ProviderFor(pluginToRemoteSyncService)
final pluginToRemoteSyncServiceProvider = PluginToRemoteSyncServiceProvider._();

/// PluginToRemoteSyncService 的 @Riverpod Provider

final class PluginToRemoteSyncServiceProvider
    extends
        $FunctionalProvider<
          PluginToRemoteSyncService,
          PluginToRemoteSyncService,
          PluginToRemoteSyncService
        >
    with $Provider<PluginToRemoteSyncService> {
  /// PluginToRemoteSyncService 的 @Riverpod Provider
  PluginToRemoteSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginToRemoteSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginToRemoteSyncServiceHash();

  @$internal
  @override
  $ProviderElement<PluginToRemoteSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PluginToRemoteSyncService create(Ref ref) {
    return pluginToRemoteSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginToRemoteSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginToRemoteSyncService>(value),
    );
  }
}

String _$pluginToRemoteSyncServiceHash() =>
    r'33fc89e14320397ec8382d5271354ba82511f36b';

/// 插件同步服务初始化提供者

@ProviderFor(pluginSyncServiceInitializer)
final pluginSyncServiceInitializerProvider =
    PluginSyncServiceInitializerProvider._();

/// 插件同步服务初始化提供者

final class PluginSyncServiceInitializerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// 插件同步服务初始化提供者
  PluginSyncServiceInitializerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginSyncServiceInitializerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginSyncServiceInitializerHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return pluginSyncServiceInitializer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pluginSyncServiceInitializerHash() =>
    r'e2aace1aec9bfb1bbae28271ae34b95dec39dd97';
