// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_contact_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localContactDataSource)
final localContactDataSourceProvider = LocalContactDataSourceProvider._();

final class LocalContactDataSourceProvider
    extends
        $FunctionalProvider<
          LocalContactDataSource,
          LocalContactDataSource,
          LocalContactDataSource
        >
    with $Provider<LocalContactDataSource> {
  LocalContactDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localContactDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localContactDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalContactDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalContactDataSource create(Ref ref) {
    return localContactDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalContactDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalContactDataSource>(value),
    );
  }
}

String _$localContactDataSourceHash() =>
    r'8ed586b72d795f9c191e548707b171f4c429f005';
