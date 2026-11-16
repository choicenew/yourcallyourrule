// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_rule_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(basicRuleFilterService)
final basicRuleFilterServiceProvider = BasicRuleFilterServiceProvider._();

final class BasicRuleFilterServiceProvider
    extends
        $FunctionalProvider<
          BasicRuleFilterService,
          BasicRuleFilterService,
          BasicRuleFilterService
        >
    with $Provider<BasicRuleFilterService> {
  BasicRuleFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'basicRuleFilterServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$basicRuleFilterServiceHash();

  @$internal
  @override
  $ProviderElement<BasicRuleFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BasicRuleFilterService create(Ref ref) {
    return basicRuleFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BasicRuleFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BasicRuleFilterService>(value),
    );
  }
}

String _$basicRuleFilterServiceHash() => r'b64e5287f37f37478d10332306239bc7a87e8321';
