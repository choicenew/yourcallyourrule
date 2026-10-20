// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_phone_rule_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localPhoneRuleDataSource)
final localPhoneRuleDataSourceProvider = LocalPhoneRuleDataSourceProvider._();

final class LocalPhoneRuleDataSourceProvider
    extends
        $FunctionalProvider<
          LocalPhoneRuleDataSource,
          LocalPhoneRuleDataSource,
          LocalPhoneRuleDataSource
        >
    with $Provider<LocalPhoneRuleDataSource> {
  LocalPhoneRuleDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localPhoneRuleDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localPhoneRuleDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalPhoneRuleDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalPhoneRuleDataSource create(Ref ref) {
    return localPhoneRuleDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalPhoneRuleDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalPhoneRuleDataSource>(value),
    );
  }
}

String _$localPhoneRuleDataSourceHash() =>
    r'2cbb3c0b784dc95078aa139f69c0da4dab6a5696';
