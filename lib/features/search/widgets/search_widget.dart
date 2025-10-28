import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/search/providers/search_provider.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 从 ConsumerStatefulWidget 改为 ConsumerStatefulWidget 以便使用 TextEditingController 和 Timer。
class SearchWidget extends ConsumerStatefulWidget {
  const SearchWidget({super.key});

  @override
  ConsumerState<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounceTimer;
  
  // [重构]: 移除 _searchResults 和 _isSearching，状态由 searchProvider 管理。

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebounceTimer?.cancel();
    super.dispose();
  }

  /// [重构]: _performSearch 只是一个触发器，调用 Notifier 的方法。
  void _triggerSearch(String query) {
      ref.read(searchProvider.notifier).search(query);
  }

  /// [注释]: 导航到搜索页面的逻辑保持不变。
  void _navigateToSearchPage(String searchText) {
    context.push('/search', extra: searchText);
  }

  @override
  Widget build(BuildContext context) {
    // [重构]: 监听 searchProvider 的状态。
    final searchState = ref.watch(searchProvider);

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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchController.clear();
                              // [重构]: 清空搜索时，也重置 provider 的状态。
                              _triggerSearch('');
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    _searchDebounceTimer?.cancel();
                    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
                      _triggerSearch(value);
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Text(AppLocalizations.of(context)!.search),
              ),
            ],
          ),
        ),
        // [重构]: 使用 searchState 来显示加载指示器和结果。
        if (searchState.isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (searchState.hasValue && searchState.value!.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchState.value!.length,
              itemBuilder: (context, index) {
                final result = searchState.value![index];
                return SearchResultItem(
                  result: result,
                  onTap: () {
                    // [注释]: 点击后清空当前预览并导航到完整搜索页。
                    _searchController.clear();
                    _triggerSearch('');
                    _navigateToSearchPage(result.phoneNumber);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}