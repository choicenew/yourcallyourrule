// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_page_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SimSlotRulePage)
final simSlotRulePageProvider = SimSlotRulePageFamily._();

final class SimSlotRulePageProvider
    extends $AsyncNotifierProvider<SimSlotRulePage, SimSlotRulePageState> {
  SimSlotRulePageProvider._({
    required SimSlotRulePageFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'simSlotRulePageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$simSlotRulePageHash();

  @override
  String toString() {
    return r'simSlotRulePageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SimSlotRulePage create() => SimSlotRulePage();

  @override
  bool operator ==(Object other) {
    return other is SimSlotRulePageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$simSlotRulePageHash() => r'88bf173ba6a001e5ba64f8c86d23feb180713ca3';

final class SimSlotRulePageFamily extends $Family
    with
        $ClassFamilyOverride<
          SimSlotRulePage,
          AsyncValue<SimSlotRulePageState>,
          SimSlotRulePageState,
          FutureOr<SimSlotRulePageState>,
          int
        > {
  SimSlotRulePageFamily._()
    : super(
        retry: null,
        name: r'simSlotRulePageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SimSlotRulePageProvider call(int simSlotIndex) =>
      SimSlotRulePageProvider._(argument: simSlotIndex, from: this);

  @override
  String toString() => r'simSlotRulePageProvider';
}

abstract class _$SimSlotRulePage extends $AsyncNotifier<SimSlotRulePageState> {
  late final _$args = ref.$arg as int;
  int get simSlotIndex => _$args;

  FutureOr<SimSlotRulePageState> build(int simSlotIndex);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<SimSlotRulePageState>, SimSlotRulePageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<SimSlotRulePageState>,
                SimSlotRulePageState
              >,
              AsyncValue<SimSlotRulePageState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
