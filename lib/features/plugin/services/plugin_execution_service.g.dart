// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_execution_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PluginExecutionService 的 @Riverpod Provider

@ProviderFor(pluginExecutionService)
final pluginExecutionServiceProvider = PluginExecutionServiceProvider._();

/// PluginExecutionService 的 @Riverpod Provider

final class PluginExecutionServiceProvider
    extends
        $FunctionalProvider<
          PluginExecutionService,
          PluginExecutionService,
          PluginExecutionService
        >
    with $Provider<PluginExecutionService> {
  /// PluginExecutionService 的 @Riverpod Provider
  PluginExecutionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginExecutionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginExecutionServiceHash();

  @$internal
  @override
  $ProviderElement<PluginExecutionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PluginExecutionService create(Ref ref) {
    return pluginExecutionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginExecutionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginExecutionService>(value),
    );
  }
}

String _$pluginExecutionServiceHash() =>
    r'b70c540369411a27ac54cf790542ec5cc741399a';
