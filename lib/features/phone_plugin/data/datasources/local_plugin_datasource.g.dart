// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_plugin_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localPluginDataSource)
final localPluginDataSourceProvider = LocalPluginDataSourceProvider._();

final class LocalPluginDataSourceProvider
    extends
        $FunctionalProvider<
          LocalPluginDataSource,
          LocalPluginDataSource,
          LocalPluginDataSource
        >
    with $Provider<LocalPluginDataSource> {
  LocalPluginDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localPluginDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localPluginDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalPluginDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalPluginDataSource create(Ref ref) {
    return localPluginDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalPluginDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalPluginDataSource>(value),
    );
  }
}

String _$localPluginDataSourceHash() =>
    r'd7f0bb61cedc008d9f7d4e13960676afdf2f6b26';
