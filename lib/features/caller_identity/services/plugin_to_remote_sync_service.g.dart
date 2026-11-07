// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_to_remote_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(pluginToRemoteSyncService)
final pluginToRemoteSyncServiceProvider = PluginToRemoteSyncServiceProvider._();

final class PluginToRemoteSyncServiceProvider
    extends
        $FunctionalProvider<
          PluginToRemoteSyncService,
          PluginToRemoteSyncService,
          PluginToRemoteSyncService
        >
    with $Provider<PluginToRemoteSyncService> {
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

  Override overrideWithValue(PluginToRemoteSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginToRemoteSyncService>(value),
    );
  }
}

String _$pluginToRemoteSyncServiceHash() =>
    r'33fc89e14320397ec8382d5271354ba82511f36b';

@ProviderFor(pluginSyncServiceInitializer)
final pluginSyncServiceInitializerProvider =
    PluginSyncServiceInitializerProvider._();

final class PluginSyncServiceInitializerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
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

  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pluginSyncServiceInitializerHash() =>
    r'e2aace1aec9bfb1bbae28271ae34b95dec39dd97';
