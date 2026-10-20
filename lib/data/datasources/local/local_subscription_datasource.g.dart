// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_subscription_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localSubscriptionDataSource)
final localSubscriptionDataSourceProvider =
    LocalSubscriptionDataSourceProvider._();

final class LocalSubscriptionDataSourceProvider
    extends
        $FunctionalProvider<
          LocalSubscriptionDataSource,
          LocalSubscriptionDataSource,
          LocalSubscriptionDataSource
        >
    with $Provider<LocalSubscriptionDataSource> {
  LocalSubscriptionDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSubscriptionDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localSubscriptionDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalSubscriptionDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalSubscriptionDataSource create(Ref ref) {
    return localSubscriptionDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSubscriptionDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSubscriptionDataSource>(value),
    );
  }
}

String _$localSubscriptionDataSourceHash() =>
    r'd6cd148ce8cce8d27ad5178029c8cb797d623483';
