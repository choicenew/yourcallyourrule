// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_url_execution_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PluginUrlExecutionService 的 @Riverpod Provider

@ProviderFor(pluginUrlWebViewService)
final pluginUrlWebViewServiceProvider = PluginUrlWebViewServiceProvider._();

/// PluginUrlExecutionService 的 @Riverpod Provider

final class PluginUrlWebViewServiceProvider
    extends
        $FunctionalProvider<
          PluginUrlExecutionService,
          PluginUrlExecutionService,
          PluginUrlExecutionService
        >
    with $Provider<PluginUrlExecutionService> {
  /// PluginUrlExecutionService 的 @Riverpod Provider
  PluginUrlWebViewServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginUrlWebViewServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginUrlWebViewServiceHash();

  @$internal
  @override
  $ProviderElement<PluginUrlExecutionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PluginUrlExecutionService create(Ref ref) {
    return pluginUrlWebViewService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginUrlExecutionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginUrlExecutionService>(value),
    );
  }
}

String _$pluginUrlWebViewServiceHash() =>
    r'9326b5b76bfd3f27509731983fdf46023de848d2';
