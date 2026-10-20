// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_label_mark_statistics_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localLabelMarkStatisticsDataSource)
final localLabelMarkStatisticsDataSourceProvider =
    LocalLabelMarkStatisticsDataSourceProvider._();

final class LocalLabelMarkStatisticsDataSourceProvider
    extends
        $FunctionalProvider<
          LocalLabelMarkStatisticsDataSource,
          LocalLabelMarkStatisticsDataSource,
          LocalLabelMarkStatisticsDataSource
        >
    with $Provider<LocalLabelMarkStatisticsDataSource> {
  LocalLabelMarkStatisticsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localLabelMarkStatisticsDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$localLabelMarkStatisticsDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalLabelMarkStatisticsDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalLabelMarkStatisticsDataSource create(Ref ref) {
    return localLabelMarkStatisticsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalLabelMarkStatisticsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalLabelMarkStatisticsDataSource>(
        value,
      ),
    );
  }
}

String _$localLabelMarkStatisticsDataSourceHash() =>
    r'b2c5d861735a1b3ffd9773af22f0551e718e1a85';
