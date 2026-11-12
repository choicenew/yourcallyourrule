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
    r'f7ad3b602573b1c84a8b609dcdff808d1ce6ec8e';
