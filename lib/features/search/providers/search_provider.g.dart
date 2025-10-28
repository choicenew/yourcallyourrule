// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 一个 AsyncNotifier，用于管理搜索页面的状态。
/// 它封装了执行搜索、管理加载状态和持有搜索结果的全部逻辑。

@ProviderFor(Search)
const searchProvider = SearchProvider._();

/// 一个 AsyncNotifier，用于管理搜索页面的状态。
/// 它封装了执行搜索、管理加载状态和持有搜索结果的全部逻辑。
final class SearchProvider
    extends $AsyncNotifierProvider<Search, List<SearchResult>> {
  /// 一个 AsyncNotifier，用于管理搜索页面的状态。
  /// 它封装了执行搜索、管理加载状态和持有搜索结果的全部逻辑。
  const SearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHash();

  @$internal
  @override
  Search create() => Search();
}

String _$searchHash() => r'f71a9c32fdd69fd675fd4954544c02e5e1ad5044';

/// 一个 AsyncNotifier，用于管理搜索页面的状态。
/// 它封装了执行搜索、管理加载状态和持有搜索结果的全部逻辑。

abstract class _$Search extends $AsyncNotifier<List<SearchResult>> {
  FutureOr<List<SearchResult>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<SearchResult>>, List<SearchResult>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SearchResult>>, List<SearchResult>>,
              AsyncValue<List<SearchResult>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
