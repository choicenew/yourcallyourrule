// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_manager_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PluginManagerService 的 @Riverpod Provider

@ProviderFor(pluginManagerService)
final pluginManagerServiceProvider = PluginManagerServiceProvider._();

/// PluginManagerService 的 @Riverpod Provider

final class PluginManagerServiceProvider
    extends
        $FunctionalProvider<
          PluginManagerService,
          PluginManagerService,
          PluginManagerService
        >
    with $Provider<PluginManagerService> {
  /// PluginManagerService 的 @Riverpod Provider
  PluginManagerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginManagerServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginManagerServiceHash();

  @$internal
  @override
  $ProviderElement<PluginManagerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PluginManagerService create(Ref ref) {
    return pluginManagerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginManagerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginManagerService>(value),
    );
  }
}

String _$pluginManagerServiceHash() =>
    r'0cf4b13315bf8933df3bdb2526c98e2fcdafd034';
