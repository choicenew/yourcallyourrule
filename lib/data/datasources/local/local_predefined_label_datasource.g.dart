// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_predefined_label_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localPredefinedLabelDataSource)
final localPredefinedLabelDataSourceProvider =
    LocalPredefinedLabelDataSourceProvider._();

final class LocalPredefinedLabelDataSourceProvider
    extends
        $FunctionalProvider<
          LocalPredefinedLabelDataSource,
          LocalPredefinedLabelDataSource,
          LocalPredefinedLabelDataSource
        >
    with $Provider<LocalPredefinedLabelDataSource> {
  LocalPredefinedLabelDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localPredefinedLabelDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localPredefinedLabelDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalPredefinedLabelDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalPredefinedLabelDataSource create(Ref ref) {
    return localPredefinedLabelDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalPredefinedLabelDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalPredefinedLabelDataSource>(
        value,
      ),
    );
  }
}

String _$localPredefinedLabelDataSourceHash() =>
    r'ea3c1302486a18a2a2bb78b5878a81a3b7c11cb4';
