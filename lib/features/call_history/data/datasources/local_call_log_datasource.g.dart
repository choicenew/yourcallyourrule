// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_call_log_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localCallLogDataSource)
final localCallLogDataSourceProvider = LocalCallLogDataSourceProvider._();

final class LocalCallLogDataSourceProvider
    extends
        $FunctionalProvider<
          LocalCallLogDataSource,
          LocalCallLogDataSource,
          LocalCallLogDataSource
        >
    with $Provider<LocalCallLogDataSource> {
  LocalCallLogDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localCallLogDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localCallLogDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalCallLogDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalCallLogDataSource create(Ref ref) {
    return localCallLogDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalCallLogDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalCallLogDataSource>(value),
    );
  }
}

String _$localCallLogDataSourceHash() =>
    r'6e6ecb29d81c531fafc7982bee83bf3bd7b4e7de';
