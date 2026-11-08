// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_sim_slot_rule_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localSimSlotRuleDataSource)
final localSimSlotRuleDataSourceProvider =
    LocalSimSlotRuleDataSourceProvider._();

final class LocalSimSlotRuleDataSourceProvider
    extends
        $FunctionalProvider<
          LocalSimSlotRuleDataSource,
          LocalSimSlotRuleDataSource,
          LocalSimSlotRuleDataSource
        >
    with $Provider<LocalSimSlotRuleDataSource> {
  LocalSimSlotRuleDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSimSlotRuleDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localSimSlotRuleDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalSimSlotRuleDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalSimSlotRuleDataSource create(Ref ref) {
    return localSimSlotRuleDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSimSlotRuleDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSimSlotRuleDataSource>(value),
    );
  }
}

String _$localSimSlotRuleDataSourceHash() =>
    r'3bc4dad448e4bb260e50c078c5c4ae8e8b2f7419';
