// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeStatsNotifier)
final homeStatsProvider = HomeStatsNotifierProvider._();

final class HomeStatsNotifierProvider
    extends $AsyncNotifierProvider<HomeStatsNotifier, HomeStats> {
  HomeStatsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeStatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeStatsNotifierHash();

  @$internal
  @override
  HomeStatsNotifier create() => HomeStatsNotifier();
}

String _$homeStatsNotifierHash() => r'6bedd9f6ad088d059466bbe8884124c7d5fedacd';

abstract class _$HomeStatsNotifier extends $AsyncNotifier<HomeStats> {
  FutureOr<HomeStats> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HomeStats>, HomeStats>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeStats>, HomeStats>,
              AsyncValue<HomeStats>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
