// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 瑙勫垯浠撳簱鎻愪緵鑰?(鐩磋繛 Drift LocalDatabase)

@ProviderFor(ruleRepository)
final ruleRepositoryProvider = RuleRepositoryProvider._();

/// 瑙勫垯浠撳簱鎻愪緵鑰?(鐩磋繛 Drift LocalDatabase)

final class RuleRepositoryProvider
    extends $FunctionalProvider<RuleRepository, RuleRepository, RuleRepository>
    with $Provider<RuleRepository> {
  /// 瑙勫垯浠撳簱鎻愪緵鑰?(鐩磋繛 Drift LocalDatabase)
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

String _$ruleRepositoryHash() => r'1d755165cb1f69d253c0ccf24a2abcaab4dcd6c4';
