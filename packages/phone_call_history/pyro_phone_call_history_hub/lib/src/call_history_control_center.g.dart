// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_history_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callHistoryControlCenter)
final callHistoryControlCenterProvider = CallHistoryControlCenterProvider._();

final class CallHistoryControlCenterProvider
    extends
        $FunctionalProvider<
          CallHistoryControlCenter,
          CallHistoryControlCenter,
          CallHistoryControlCenter
        >
    with $Provider<CallHistoryControlCenter> {
  CallHistoryControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callHistoryControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHistoryControlCenterHash();

  @$internal
  @override
  $ProviderElement<CallHistoryControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallHistoryControlCenter create(Ref ref) {
    return callHistoryControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallHistoryControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallHistoryControlCenter>(value),
    );
  }
}

String _$callHistoryControlCenterHash() =>
    r'ed733dcfbad031da313649824fa6c0327fcace9b';
