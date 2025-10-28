// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod 3 Provider：提供 SimSlotRuleService 实例
// 2. 使用 @riverpod 注解创建新的 provider

@ProviderFor(simSlotRuleService)
const simSlotRuleServiceProvider = SimSlotRuleServiceProvider._();

/// Riverpod 3 Provider：提供 SimSlotRuleService 实例
// 2. 使用 @riverpod 注解创建新的 provider

final class SimSlotRuleServiceProvider
    extends
        $FunctionalProvider<
          SimSlotRuleService,
          SimSlotRuleService,
          SimSlotRuleService
        >
    with $Provider<SimSlotRuleService> {
  /// Riverpod 3 Provider：提供 SimSlotRuleService 实例
  // 2. 使用 @riverpod 注解创建新的 provider
  const SimSlotRuleServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simSlotRuleServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simSlotRuleServiceHash();

  @$internal
  @override
  $ProviderElement<SimSlotRuleService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SimSlotRuleService create(Ref ref) {
    return simSlotRuleService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimSlotRuleService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimSlotRuleService>(value),
    );
  }
}

String _$simSlotRuleServiceHash() =>
    r'dd076ef987232028f77aa2d2b63b88b0d3c9ce8d';

@ProviderFor(isSimSlotFilterEnabled)
const isSimSlotFilterEnabledProvider = IsSimSlotFilterEnabledFamily._();

final class IsSimSlotFilterEnabledProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const IsSimSlotFilterEnabledProvider._({
    required IsSimSlotFilterEnabledFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'isSimSlotFilterEnabledProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isSimSlotFilterEnabledHash();

  @override
  String toString() {
    return r'isSimSlotFilterEnabledProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as int;
    return isSimSlotFilterEnabled(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IsSimSlotFilterEnabledProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isSimSlotFilterEnabledHash() =>
    r'be40b0637d6631cd14994b47fc4dca65661eb9a6';

final class IsSimSlotFilterEnabledFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, int> {
  const IsSimSlotFilterEnabledFamily._()
    : super(
        retry: null,
        name: r'isSimSlotFilterEnabledProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsSimSlotFilterEnabledProvider call(int simSlotIndex) =>
      IsSimSlotFilterEnabledProvider._(argument: simSlotIndex, from: this);

  @override
  String toString() => r'isSimSlotFilterEnabledProvider';
}
