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
    r'1fccf87dc60da5cdf3a66d76df73276a6c423e54';
