// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CallFilterConfigNotifier)
const callFilterConfigProvider = CallFilterConfigNotifierProvider._();

final class CallFilterConfigNotifierProvider
    extends $AsyncNotifierProvider<CallFilterConfigNotifier, CallFilterConfig> {
  const CallFilterConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callFilterConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callFilterConfigNotifierHash();

  @$internal
  @override
  CallFilterConfigNotifier create() => CallFilterConfigNotifier();
}

String _$callFilterConfigNotifierHash() =>
    r'3f9552992d40d4f0093b563f8929b34638682318';

abstract class _$CallFilterConfigNotifier
    extends $AsyncNotifier<CallFilterConfig> {
  FutureOr<CallFilterConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<CallFilterConfig>, CallFilterConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CallFilterConfig>, CallFilterConfig>,
              AsyncValue<CallFilterConfig>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
