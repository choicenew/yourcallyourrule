import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/dialogs.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_service_provider.dart';
import 'package:yourcallyourrule/features/search/providers/search_provider.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [注释]: 导入所有需要的 Service Provider 用于处理点击事件。

import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/features/rules/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

class SearchPage extends ConsumerStatefulWidget {
  final String? initialSearchText;

  const SearchPage({super.key, this.initialSearchText});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      String? searchText;

      if (extra != null && extra is String) {
        searchText = extra;
      } else if (widget.initialSearchText != null) {
        searchText = widget.initialSearchText;
      }

      if (searchText != null && searchText.isNotEmpty) {
        _searchController.text = searchText;
        // [注释]: 在 initState 之后调用 Notifier 的方法来执行初始搜索。
        ref.read(searchProvider.notifier).search(searchText);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// [注释]: 触发搜索的方法，现在调用了 Notifier。
  void _triggerSearch() {
    final searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.enterSearchContent),
        ),
      );
      // [注释]: 即使为空，也调用 search 方法，Notifier 内部会处理清空逻辑。
      ref.read(searchProvider.notifier).search(searchText);
      return;
    }
    ref.read(searchProvider.notifier).search(searchText);
  }

  /// [注释]: 处理点击事件的逻辑保持不变。
  void _handleResultTap(SearchResult result) {
    if (result.type == SearchResultType.remoteNumber) {
      CallerIdDialog.show(context, result.phoneNumber);
    } else if (result.type == SearchResultType.notFound) {
      CountrySelectionDialog.show(context, result.phoneNumber);
    } else if (result.type == SearchResultType.contact) {
      final contactService = ref.read(contactServiceProvider);
      contactService
          .findContactByPhoneNumber(PhoneNumber(result.phoneNumber))
          .then((contact) {
            if (contact != null) {
              ContactEditDialog.show(
                context,
                contact: contact,
                onContactUpdated: () => _triggerSearch(),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.contactNotFound),
                ),
              );
            }
          });
    } else if (result.type == SearchResultType.label) {
      final labelService = ref.read(labelServiceProvider);
      labelService.getLabelByPhoneNumberString(result.phoneNumber).then((
        label,
      ) {
        if (label != null) {
          LabelEditDialog.show(
            context,
            label,
            onLabelUpdated: () => _triggerSearch(),
            themeColor: Theme.of(context).primaryColor,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.labelNotFound),
            ),
          );
        }
      });
    } else if (result.type == SearchResultType.allow ||
        result.type == SearchResultType.block ||
        result.type == SearchResultType.silence ||
        result.type == SearchResultType.none) {
      final ruleService = ref.read(ruleManagementServiceProvider);
      final allowedBlockedService = ref.read(allowedBlockedServiceProvider);

      if (result.ruleType == 'phone') {
        ruleService
            .getAllRulesByActionType(null)
            .then((rules) {
              final rule = rules.firstWhere((r) => r.id == result.id);
              PhoneRuleEditDialog.show(
                context,
                rule,
                onRuleUpdated: () => _triggerSearch(),
                themeColor: Theme.of(context).primaryColor,
              );
            })
            .catchError(
              (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context).ruleNotFound(e.toString()),
                    ),
                  ),
                );
                return null;
              },
            );
      } else if (result.ruleType == 'allowedBlocked') {
        allowedBlockedService
            .getAllRulesByActionType(null)
            .then((rules) {
              final rule = rules.firstWhere((r) => r.id == result.id);
              AllowedBlockedRuleEditDialog.show(
                context,
                rule,
                onRuleUpdated: () => _triggerSearch(),
                themeColor: Theme.of(context).primaryColor,
              );
            })
            .catchError(
              (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.ruleNotFound(e.toString()),
                    ),
                  ),
                );
                return null;
              },
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // [注释]: 监听 searchProvider 的状态来驱动UI。
    final searchState = ref.watch(searchProvider);

    // ▼▼▼▼▼ 核心修正部分 ▼▼▼▼▼
    // [修正]: 使用 `ref.listen` 的 `next` 参数来访问新状态，而不是使用 `state`。
    // `next` 是一个类型安全的 `AsyncValue<List<SearchResult>>` 对象。
    ref.listen<AsyncValue<List<SearchResult>>>(searchProvider, (
      previous,
      next,
    ) {
      // 检查搜索完成且结果为空
      if (!next.isLoading &&
          next.hasValue &&
          next.value!.isEmpty &&
          _searchController.text.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.noMatchingNumbersFound),
          ),
        );
      }
      // 检查是否发生错误
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.searchError(next.error.toString()),
            ),
          ),
        );
      }
    });
    // ▲▲▲▲▲ 修正结束 ▲▲▲▲▲

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.numberSearch)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.enterPhoneNumber,
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    onSubmitted: (_) => _triggerSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: searchState.isLoading ? null : _triggerSearch,
                  child:
                      searchState.isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : Text(AppLocalizations.of(context)!.search),
                ),
              ],
            ),
          ),

          Expanded(
            // [注释]: 使用 searchState 来构建结果列表。
            child: searchState.when(
              data: (results) {
                // [注释]: _searchController.text.isEmpty 用于判断是否是初始状态。
                if (results.isEmpty && _searchController.text.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.enterPhoneNumberToStartSearch,
                    ),
                  );
                }
                if (results.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.noMatchingNumbersFound,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return SearchResultItem(
                      result: result,
                      onTap: () => _handleResultTap(result),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (e, st) => Center(
                    child: Text(
                      AppLocalizations.of(context)!.searchError(e.toString()),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
