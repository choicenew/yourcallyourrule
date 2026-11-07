// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_policy_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callPolicyControlCenter)
final callPolicyControlCenterProvider = CallPolicyControlCenterProvider._();

final class CallPolicyControlCenterProvider
    extends
        $FunctionalProvider<
          CallPolicyControlCenter,
          CallPolicyControlCenter,
          CallPolicyControlCenter
        >
    with $Provider<CallPolicyControlCenter> {
  CallPolicyControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callPolicyControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callPolicyControlCenterHash();

  @$internal
  @override
  $ProviderElement<CallPolicyControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallPolicyControlCenter create(Ref ref) {
    return callPolicyControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallPolicyControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallPolicyControlCenter>(value),
    );
  }
}

String _$callPolicyControlCenterHash() =>
    r'cead5c21edc67b18690fc8a0ba615e3ce347f850';
