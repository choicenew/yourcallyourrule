// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commercialLocalDataSource)
const commercialLocalDataSourceProvider = CommercialLocalDataSourceProvider._();

final class CommercialLocalDataSourceProvider extends $FunctionalProvider<
    CommercialLocalDataSource,
    CommercialLocalDataSource,
    CommercialLocalDataSource> with $Provider<CommercialLocalDataSource> {
  const CommercialLocalDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'commercialLocalDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$commercialLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<CommercialLocalDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CommercialLocalDataSource create(Ref ref) {
    return commercialLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommercialLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommercialLocalDataSource>(value),
    );
  }
}

String _$commercialLocalDataSourceHash() =>
    r'a2d016da80739b7cfc158c291cffb0c322f1882a';
