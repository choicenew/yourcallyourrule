// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 自动生成的 RuleRepositoryImpl Provider

@ProviderFor(ruleRepositoryImpl)
final ruleRepositoryImplProvider = RuleRepositoryImplProvider._();

/// 自动生成的 RuleRepositoryImpl Provider

final class RuleRepositoryImplProvider
    extends
        $FunctionalProvider<
          RuleRepositoryImpl,
          RuleRepositoryImpl,
          RuleRepositoryImpl
        >
    with $Provider<RuleRepositoryImpl> {
  /// 自动生成的 RuleRepositoryImpl Provider
  RuleRepositoryImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ruleRepositoryImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ruleRepositoryImplHash();

  @$internal
  @override
  $ProviderElement<RuleRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RuleRepositoryImpl create(Ref ref) {
    return ruleRepositoryImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RuleRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RuleRepositoryImpl>(value),
    );
  }
}

String _$ruleRepositoryImplHash() =>
    r'a3a09d646492c0ff906ad2325f26ad75b8c0582b';
