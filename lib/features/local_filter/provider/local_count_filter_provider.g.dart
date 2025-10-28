// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_count_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalCountFilterConfigNotifier)
const localCountFilterConfigProvider =
    LocalCountFilterConfigNotifierProvider._();

final class LocalCountFilterConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          LocalCountFilterConfigNotifier,
          LocalCountFilterConfig
        > {
  const LocalCountFilterConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localCountFilterConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localCountFilterConfigNotifierHash();

  @$internal
  @override
  LocalCountFilterConfigNotifier create() => LocalCountFilterConfigNotifier();
}

String _$localCountFilterConfigNotifierHash() =>
    r'2acb3062a42a22c1a9c127e752fadb613a23313e';

abstract class _$LocalCountFilterConfigNotifier
    extends $AsyncNotifier<LocalCountFilterConfig> {
  FutureOr<LocalCountFilterConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<LocalCountFilterConfig>, LocalCountFilterConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<LocalCountFilterConfig>,
                LocalCountFilterConfig
              >,
              AsyncValue<LocalCountFilterConfig>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
