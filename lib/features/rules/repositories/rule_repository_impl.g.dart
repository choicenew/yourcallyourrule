// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 自动生成的 RuleRepository Provider

@ProviderFor(ruleRepository)
final ruleRepositoryProvider = RuleRepositoryProvider._();

/// 自动生成的 RuleRepository Provider

final class RuleRepositoryProvider
    extends $FunctionalProvider<RuleRepository, RuleRepository, RuleRepository>
    with $Provider<RuleRepository> {
  /// 自动生成的 RuleRepository Provider
  RuleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ruleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ruleRepositoryHash();

  @$internal
  @override
  $ProviderElement<RuleRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RuleRepository create(Ref ref) {
    return ruleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RuleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RuleRepository>(value),
    );
  }
}

String _$ruleRepositoryHash() => r'67eec2f4f5efbb4a7ebd3ad524dad650ee150bb2';
