// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_policy_evaluator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callPolicyEvaluator)
final callPolicyEvaluatorProvider = CallPolicyEvaluatorProvider._();

final class CallPolicyEvaluatorProvider
    extends
        $FunctionalProvider<
          CallPolicyEvaluator,
          CallPolicyEvaluator,
          CallPolicyEvaluator
        >
    with $Provider<CallPolicyEvaluator> {
  CallPolicyEvaluatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callPolicyEvaluatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callPolicyEvaluatorHash();

  @$internal
  @override
  $ProviderElement<CallPolicyEvaluator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallPolicyEvaluator create(Ref ref) {
    return callPolicyEvaluator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallPolicyEvaluator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallPolicyEvaluator>(value),
    );
  }
}

String _$callPolicyEvaluatorHash() =>
    r'4575f463d72865cf19f00c3c263753aef4a195eb';
