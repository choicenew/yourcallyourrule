// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RemoteNumberFilterConfigNotifier)
final remoteNumberFilterConfigProvider =
    RemoteNumberFilterConfigNotifierProvider._();

final class RemoteNumberFilterConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          RemoteNumberFilterConfigNotifier,
          RemoteNumberFilterConfig
        > {
  RemoteNumberFilterConfigNotifierProvider._()
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
    r'b0024748a73e3cc97a0d181bea80ee458ddc0877';

abstract class _$RemoteNumberFilterConfigNotifier
    extends $AsyncNotifier<RemoteNumberFilterConfig> {
  FutureOr<RemoteNumberFilterConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}
