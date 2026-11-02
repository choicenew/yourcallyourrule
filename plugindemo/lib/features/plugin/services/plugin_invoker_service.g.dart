// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_invoker_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PluginInvokerService 的 @Riverpod Provider

@ProviderFor(pluginService)
final pluginServiceProvider = PluginServiceProvider._();

/// PluginInvokerService 的 @Riverpod Provider

final class PluginServiceProvider
    extends
        $FunctionalProvider<
          PluginInvokerService,
          PluginInvokerService,
          PluginInvokerService
        >
    with $Provider<PluginInvokerService> {
  /// PluginInvokerService 的 @Riverpod Provider
  PluginServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginServiceHash();

  @$internal
  @override
  $ProviderElement<PluginInvokerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PluginInvokerService create(Ref ref) {
    return pluginService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginInvokerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginInvokerService>(value),
    );
  }
}

String _$pluginServiceHash() => r'b419478e1b394cd7fd76b3c5bd89c2ceb3ad8787';
