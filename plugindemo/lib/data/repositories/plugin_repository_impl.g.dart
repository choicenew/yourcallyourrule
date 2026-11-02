// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 插件仓库提供者

@ProviderFor(pluginRepository)
final pluginRepositoryProvider = PluginRepositoryProvider._();

/// 插件仓库提供者

final class PluginRepositoryProvider
    extends
        $FunctionalProvider<
          PluginRepository,
          PluginRepository,
          PluginRepository
        >
    with $Provider<PluginRepository> {
  /// 插件仓库提供者
  PluginRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginRepositoryHash();

  @$internal
  @override
  $ProviderElement<PluginRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PluginRepository create(Ref ref) {
    return pluginRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginRepository>(value),
    );
  }
}

String _$pluginRepositoryHash() => r'6515ad85448141ebd618c6709644ef1bd7049032';
