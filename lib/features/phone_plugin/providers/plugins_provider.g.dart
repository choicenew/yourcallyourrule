// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugins_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PluginsNotifier)
final pluginsProvider = PluginsNotifierProvider._();

final class PluginsNotifierProvider
    extends $AsyncNotifierProvider<PluginsNotifier, List<PluginSourceData>> {
  PluginsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginsNotifierHash();

  @$internal
  @override
  PluginsNotifier create() => PluginsNotifier();
}

String _$pluginsNotifierHash() => r'0c97d08e53c23fa120f217bf4c45357697f33c02';

abstract class _$PluginsNotifier
    extends $AsyncNotifier<List<PluginSourceData>> {
  FutureOr<List<PluginSourceData>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<PluginSourceData>>, List<PluginSourceData>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PluginSourceData>>,
                List<PluginSourceData>
              >,
              AsyncValue<List<PluginSourceData>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
