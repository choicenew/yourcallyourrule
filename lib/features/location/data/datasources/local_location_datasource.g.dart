// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_location_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localLocationDataSource)
final localLocationDataSourceProvider = LocalLocationDataSourceProvider._();

final class LocalLocationDataSourceProvider
    extends
        $FunctionalProvider<
          LocalLocationDataSource,
          LocalLocationDataSource,
          LocalLocationDataSource
        >
    with $Provider<LocalLocationDataSource> {
  LocalLocationDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localLocationDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localLocationDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalLocationDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalLocationDataSource create(Ref ref) {
    return localLocationDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalLocationDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalLocationDataSource>(value),
    );
  }
}

String _$localLocationDataSourceHash() =>
    r'8acd1cd29b3fca8582a3f668440358be59adcf8f';
