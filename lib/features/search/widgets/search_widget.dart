import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/search/providers/search_service_provider.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class SearchWidget extends ConsumerStatefulWidget {
  const SearchWidget({super.key});

  @override
  ConsumerState<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  Timer? _searchDebounceTimer;
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebounceTimer?.cancel();
    super.dispose();
  }

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final searchService = ref.read(searchServiceProvider(context));
    try {
      final results = await searchService.searchPhoneNumber(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      debugPrint('${AppLocalizations.of(context)!.operationFailure}: $e');
    }
  }

  // 导航到搜索页面
  void _navigateToSearchPage(String searchText) {
    // 使用 GoRouter 导航到搜索页面，并传递搜索文本
    context.push('/search', extra: searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchResults.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    _searchDebounceTimer?.cancel();
                    _searchDebounceTimer =
                        Timer(const Duration(milliseconds: 500), () {
                      _performSearch(value);
                    });
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _navigateToSearchPage(value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final searchText = _searchController.text.trim();
                  if (searchText.isNotEmpty) {
                    _navigateToSearchPage(searchText);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Text(AppLocalizations.of(context)!.search),
              ),
            ],
          ),
        ),
        if (_isSearching)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (_searchResults.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return SearchResultItem(
                  result: result,
                  onTap: () {
                    setState(() {
                      _searchController.clear();
                      _searchResults.clear();
                    });
                    context.push('/search', extra: result.phoneNumber);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}