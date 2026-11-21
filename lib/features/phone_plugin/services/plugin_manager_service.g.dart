// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_manager_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pluginManagerService)
final pluginManagerServiceProvider = PluginManagerServiceProvider._();

final class PluginManagerServiceProvider
    extends
        $FunctionalProvider<
          PluginManagerService,
          PluginManagerService,
          PluginManagerService
        >
    with $Provider<PluginManagerService> {
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
    r'be93ff2693a917efc0f7ac6f427dc070edc10a34';
