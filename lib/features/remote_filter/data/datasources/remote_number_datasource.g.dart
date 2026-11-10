// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteNumberDataSource)
final remoteNumberDataSourceProvider = RemoteNumberDataSourceProvider._();

final class RemoteNumberDataSourceProvider
    extends
        $FunctionalProvider<
          RemoteNumberDataSource,
          RemoteNumberDataSource,
          RemoteNumberDataSource
        >
    with $Provider<RemoteNumberDataSource> {
  RemoteNumberDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteNumberDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'remote_number_datasource_hash_v2';

  @$internal
  @override
  $ProviderElement<RemoteNumberDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteNumberDataSource create(Ref ref) {
    return remoteNumberDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteNumberDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteNumberDataSource>(value),
    );
  }
}
