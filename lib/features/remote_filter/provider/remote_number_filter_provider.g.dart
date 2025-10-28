// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RemoteNumberFilterConfigNotifier)
const remoteNumberFilterConfigProvider =
    RemoteNumberFilterConfigNotifierProvider._();

final class RemoteNumberFilterConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          RemoteNumberFilterConfigNotifier,
          RemoteNumberFilterConfig
        > {
  const RemoteNumberFilterConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteNumberFilterConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteNumberFilterConfigNotifierHash();

  @$internal
  @override
  RemoteNumberFilterConfigNotifier create() =>
      RemoteNumberFilterConfigNotifier();
}

String _$remoteNumberFilterConfigNotifierHash() =>
    r'0c27a0cf7929b4a239f6c05adef5a24d1e96322c';

abstract class _$RemoteNumberFilterConfigNotifier
    extends $AsyncNotifier<RemoteNumberFilterConfig> {
  FutureOr<RemoteNumberFilterConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<RemoteNumberFilterConfig>,
              RemoteNumberFilterConfig
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<RemoteNumberFilterConfig>,
                RemoteNumberFilterConfig
              >,
              AsyncValue<RemoteNumberFilterConfig>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
