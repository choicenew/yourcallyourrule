// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_regex_rule_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SMS正则规则仓库提供者

@ProviderFor(smsRegexRuleRepository)
final smsRegexRuleRepositoryProvider = SmsRegexRuleRepositoryProvider._();

/// SMS正则规则仓库提供者

final class SmsRegexRuleRepositoryProvider
    extends
        $FunctionalProvider<
          SmsRegexRuleRepository,
          SmsRegexRuleRepository,
          SmsRegexRuleRepository
        >
    with $Provider<SmsRegexRuleRepository> {
  /// SMS正则规则仓库提供者
  SmsRegexRuleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsRegexRuleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsRegexRuleRepositoryHash();

  @$internal
  @override
  $ProviderElement<SmsRegexRuleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SmsRegexRuleRepository create(Ref ref) {
    return smsRegexRuleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmsRegexRuleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmsRegexRuleRepository>(value),
    );
  }
}

String _$smsRegexRuleRepositoryHash() =>
    r'e616cb54aec8ab3c15b03262322ecbca053fd16e';
