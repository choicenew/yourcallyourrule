// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchService)
const searchServiceProvider = SearchServiceProvider._();

final class SearchServiceProvider
    extends $FunctionalProvider<SearchService, SearchService, SearchService>
    with $Provider<SearchService> {
  const SearchServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchServiceHash();

  @$internal
  @override
  $ProviderElement<SearchService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchService create(Ref ref) {
    return searchService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchService>(value),
    );
  }
}

String _$searchServiceHash() => r'2bc9d622463042183c742f20d3f137dcf9539813';
