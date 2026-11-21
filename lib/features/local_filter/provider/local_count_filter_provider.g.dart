// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_count_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalCountFilterConfigNotifier)
final localCountFilterConfigProvider =
    LocalCountFilterConfigNotifierProvider._();

final class LocalCountFilterConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          LocalCountFilterConfigNotifier,
          LocalCountFilterConfig
        > {
  LocalCountFilterConfigNotifierProvider._()
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
    r'745a7ca2b9aad95b8b8e9575577212382511fd53';

abstract class _$LocalCountFilterConfigNotifier
    extends $AsyncNotifier<LocalCountFilterConfig> {
  FutureOr<LocalCountFilterConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}
