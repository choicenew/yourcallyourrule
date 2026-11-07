// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_recorder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callLogRecorder)
final callLogRecorderProvider = CallLogRecorderProvider._();

final class CallLogRecorderProvider
    extends
        $FunctionalProvider<CallLogRecorder, CallLogRecorder, CallLogRecorder>
    with $Provider<CallLogRecorder> {
  CallLogRecorderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLogRecorderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callLogRecorderHash();

  @$internal
  @override
  $ProviderElement<CallLogRecorder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CallLogRecorder create(Ref ref) {
    return callLogRecorder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallLogRecorder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallLogRecorder>(value),
    );
  }
}

String _$callLogRecorderHash() => r'51875d838c1b3624587a172341752bcc1b040134';
