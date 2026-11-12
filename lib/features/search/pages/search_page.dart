import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/search/providers/search_provider.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class SearchPage extends ConsumerStatefulWidget {
  final String? initialSearchText;

  const SearchPage({super.key, this.initialSearchText});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialSearchText != null && widget.initialSearchText!.isNotEmpty) {
      _searchController.text = widget.initialSearchText!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(searchProvider.notifier).search(widget.initialSearchText!);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.enterSearchContent),
        ),
      );
      return;
    }

    ref.read(searchProvider.notifier).search(query.trim());
  }

  void _onResultItemTap(SearchResult result) {
    // Tap handler for search item
  }

  @override
  Widget build(BuildContext context) {
    final searchResultsAsync = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          autofocus: true,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchHint,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
          ),
          onSubmitted: _onSearchSubmitted,
          textInputAction: TextInputAction.search,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                ref.read(searchProvider.notifier).clear();
              },
            ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _onSearchSubmitted(_searchController.text),
          ),
        ],
      ),
      body: searchResultsAsync.when(
        data: (results) {
          if (results.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.noData,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return SearchResultItem(
                result: item,
                onTap: () => _onResultItemTap(item),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
