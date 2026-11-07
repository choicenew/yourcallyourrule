// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_policy_evaluator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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

  Override overrideWithValue(CallPolicyEvaluator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallPolicyEvaluator>(value),
    );
  }
}

String _$callPolicyEvaluatorHash() =>
    r'49c44516ff8a83edae96bc5bf991361c4bb67a84';
