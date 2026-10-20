// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_regex_rule_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localRegexRuleDataSource)
final localRegexRuleDataSourceProvider = LocalRegexRuleDataSourceProvider._();

final class LocalRegexRuleDataSourceProvider
    extends
        $FunctionalProvider<
          LocalRegexRuleDataSource,
          LocalRegexRuleDataSource,
          LocalRegexRuleDataSource
        >
    with $Provider<LocalRegexRuleDataSource> {
  LocalRegexRuleDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localRegexRuleDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localRegexRuleDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalRegexRuleDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalRegexRuleDataSource create(Ref ref) {
    return localRegexRuleDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalRegexRuleDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalRegexRuleDataSource>(value),
    );
  }
}

String _$localRegexRuleDataSourceHash() =>
    r'e3f271df5e63186482720adea890bb390d5ae263';
