// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RulesNotifier)
final rulesProvider = RulesNotifierProvider._();

final class RulesNotifierProvider
    extends $AsyncNotifierProvider<RulesNotifier, List<PhoneRuleEntity>> {
  RulesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rulesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rulesNotifierHash();

  @$internal
  @override
  RulesNotifier create() => RulesNotifier();
}

String _$rulesNotifierHash() => r'25da20dedf9b0c2942cdb0c01e6237d4d8a287bd';

abstract class _$RulesNotifier extends $AsyncNotifier<List<PhoneRuleEntity>> {
  FutureOr<List<PhoneRuleEntity>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<PhoneRuleEntity>>, List<PhoneRuleEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PhoneRuleEntity>>,
                List<PhoneRuleEntity>
              >,
              AsyncValue<List<PhoneRuleEntity>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
