// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_to_remote_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginToRemoteSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginToRemoteSyncService>(value),
    );
  }
}

String _$pluginToRemoteSyncServiceHash() =>
    r'11c43fc923f9abbb0460670ab74584bb1392a3b7';

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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pluginSyncServiceInitializerHash() =>
    r'865018cb8f5cf084d67d09f1ba09a9653c29f0a8';
