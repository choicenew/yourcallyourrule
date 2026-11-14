import 'dart:async';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class HomeAppBar extends ConsumerStatefulWidget {
  const HomeAppBar({super.key});

  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  Timer? _searchDebounceTimer;

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebounceTimer?.cancel();
    super.dispose();
  }

  void _performSearch(String query) async {
    final searchService = ref.read(searchServiceProvider);
    try {
      final results = await searchService.searchPhoneNumber(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      debugPrint('Search failed: $e');
    }
  }

  void _navigateToSearchPage(String searchText) {
    context.push('/search', extra: searchText);
  }

  @override
  Widget build(BuildContext context) {
    final bool isVip = true;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _isSearchVisible
                    ? TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).search,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _isSearchVisible = false;
                                _searchController.clear();
                                _searchResults.clear();
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          _searchDebounceTimer?.cancel();
                          _searchDebounceTimer =
                              Timer(const Duration(milliseconds: 500), () {
                            if (value.isNotEmpty) {
                              _performSearch(value);
                            } else {
                              setState(() {
                                _searchResults.clear();
                              });
                            }
                          });
                        },
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            _navigateToSearchPage(value);
                          }
                        },
                      )
                    : Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pushNamed(AppRouter.purchase),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.shield_outlined,
                                  size: 32,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Positioned(
                                  top: -4,
                                  right: -4,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: isVip
                                          ? const Color(0xFFFFD700)
                                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isVip
                                            ? const Color(0xFFB8860B)
                                            : Theme.of(context).colorScheme.outlineVariant,
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.workspace_premium_rounded,
                                      size: 11,
                                      color: isVip
                                          ? const Color(0xFF7A4300)
                                          : Theme.of(context).colorScheme.onSurfaceVariant
                                              .withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'YourCall YourRule',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
              IconButton(
                icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearchVisible = !_isSearchVisible;
                    if (!_isSearchVisible) {
                      _searchController.clear();
                      _searchResults.clear();
                    }
                  });
                },
              ),
              if (_isSearchVisible)
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final searchText = _searchController.text.trim();
                    if (searchText.isNotEmpty) {
                      _navigateToSearchPage(searchText);
                    }
                  },
                ),
              if (!_isSearchVisible) ...[
                IconButton(
                  icon: const Icon(Icons.bolt_rounded, color: Color(0xFF00E676)),
                  tooltip: 'Switch to Elite Home',
                  onPressed: () {
                    context.go('/elite-home');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {
                    context.push('/notifications');
                  },
                ),
              ],
            ],
          ),
        ),
        if (_isSearchVisible && _searchResults.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return SearchResultItem(
                  result: result,
                  onTap: () {
                    setState(() {
                      _isSearchVisible = false;
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
