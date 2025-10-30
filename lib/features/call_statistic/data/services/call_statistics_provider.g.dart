// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_statistics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CallStatisticsNotifier)
const callStatisticsProvider = CallStatisticsNotifierProvider._();

final class CallStatisticsNotifierProvider
    extends $NotifierProvider<CallStatisticsNotifier, CallStatisticsState> {
  const CallStatisticsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callStatisticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callStatisticsNotifierHash();

  @$internal
  @override
  CallStatisticsNotifier create() => CallStatisticsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallStatisticsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallStatisticsState>(value),
    );
  }
}

String _$callStatisticsNotifierHash() =>
    r'cd6b6149b543931bf49a61e241ad14025705bb2b';

abstract class _$CallStatisticsNotifier extends $Notifier<CallStatisticsState> {
  CallStatisticsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallStatisticsState, CallStatisticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallStatisticsState, CallStatisticsState>,
              CallStatisticsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
