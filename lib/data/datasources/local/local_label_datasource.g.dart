// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_label_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localLabelDataSource)
final localLabelDataSourceProvider = LocalLabelDataSourceProvider._();

final class LocalLabelDataSourceProvider
    extends
        $FunctionalProvider<
          LocalLabelDataSource,
          LocalLabelDataSource,
          LocalLabelDataSource
        >
    with $Provider<LocalLabelDataSource> {
  LocalLabelDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localLabelDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localLabelDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalLabelDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalLabelDataSource create(Ref ref) {
    return localLabelDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalLabelDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalLabelDataSource>(value),
    );
  }
}

String _$localLabelDataSourceHash() =>
    r'9a58a1fa5353862bc35cad9ef02f4342ba4b9eea';
