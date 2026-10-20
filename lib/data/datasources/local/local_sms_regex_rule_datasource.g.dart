// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_sms_regex_rule_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localSmsRegexRuleDataSource)
final localSmsRegexRuleDataSourceProvider =
    LocalSmsRegexRuleDataSourceProvider._();

final class LocalSmsRegexRuleDataSourceProvider
    extends
        $FunctionalProvider<
          LocalSmsRegexRuleDataSource,
          LocalSmsRegexRuleDataSource,
          LocalSmsRegexRuleDataSource
        >
    with $Provider<LocalSmsRegexRuleDataSource> {
  LocalSmsRegexRuleDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSmsRegexRuleDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localSmsRegexRuleDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalSmsRegexRuleDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalSmsRegexRuleDataSource create(Ref ref) {
    return localSmsRegexRuleDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSmsRegexRuleDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSmsRegexRuleDataSource>(value),
    );
  }
}

String _$localSmsRegexRuleDataSourceHash() =>
    r'3df3050b49068dd576d602a9505f70be682a7b8e';
