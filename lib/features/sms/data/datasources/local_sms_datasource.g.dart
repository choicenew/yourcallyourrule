// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_sms_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localSmsDataSource)
final localSmsDataSourceProvider = LocalSmsDataSourceProvider._();

final class LocalSmsDataSourceProvider
    extends
        $FunctionalProvider<
          LocalSmsDataSource,
          LocalSmsDataSource,
          LocalSmsDataSource
        >
    with $Provider<LocalSmsDataSource> {
  LocalSmsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSmsDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localSmsDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalSmsDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalSmsDataSource create(Ref ref) {
    return localSmsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSmsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSmsDataSource>(value),
    );
  }
}

String _$localSmsDataSourceHash() =>
    r'e528defdc6a4aa163eb169f289c4b0de0f58a89e';
