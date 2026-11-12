// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pluginRepository)
final pluginRepositoryProvider = PluginRepositoryProvider._();

final class PluginRepositoryProvider
    extends
        $FunctionalProvider<
          PluginRepository,
          PluginRepository,
          PluginRepository
        >
    with $Provider<PluginRepository> {
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

String _$pluginRepositoryHash() => r'c86423c7b17d830fd0ceeefe42d66e186544c8f8';
