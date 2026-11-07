// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_management_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RuleManagementService 的 @Riverpod Provider

@ProviderFor(ruleManagementService)
final ruleManagementServiceProvider = RuleManagementServiceProvider._();

/// RuleManagementService 的 @Riverpod Provider

final class RuleManagementServiceProvider
    extends
        $FunctionalProvider<
          RuleManagementService,
          RuleManagementService,
          RuleManagementService
        >
    with $Provider<RuleManagementService> {
  /// RuleManagementService 的 @Riverpod Provider
  RuleManagementServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ruleManagementServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ruleManagementServiceHash();

  @$internal
  @override
  $ProviderElement<RuleManagementService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RuleManagementService create(Ref ref) {
    return ruleManagementService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RuleManagementService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RuleManagementService>(value),
    );
  }
}

String _$ruleManagementServiceHash() =>
    r'f973f32c4024769f0f0a07756054c813ae43d135';
