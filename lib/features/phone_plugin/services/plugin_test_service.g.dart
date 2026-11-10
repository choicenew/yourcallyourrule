// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_test_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PluginTestService 的 @Riverpod Provider

@ProviderFor(pluginTestService)
final pluginTestServiceProvider = PluginTestServiceProvider._();

/// PluginTestService 的 @Riverpod Provider

final class PluginTestServiceProvider
    extends
        $FunctionalProvider<
          PluginTestService,
          PluginTestService,
          PluginTestService
        >
    with $Provider<PluginTestService> {
  /// PluginTestService 的 @Riverpod Provider
  PluginTestServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginTestServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginTestServiceHash();

  @$internal
  @override
  $ProviderElement<PluginTestService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PluginTestService create(Ref ref) {
    return pluginTestService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginTestService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginTestService>(value),
    );
  }
}

String _$pluginTestServiceHash() => r'650466f55b8080aa581f322082f5b4c690461170';
