import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/search/dialogs/dialogs.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';

/// 搜索页面
/// 用于搜索本地和远程数据库中的号码
class SearchPage extends StatefulWidget {
  final String? initialSearchText; // 添加初始搜索文本参数
  
  const SearchPage({super.key, this.initialSearchText});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    
    // 检查是否有初始搜索文本
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 获取路由参数
      final extra = GoRouterState.of(context).extra;
      String? searchText;
      
      // 处理从 home_page.dart 传递的搜索文本
      if (extra != null && extra is String) {
        searchText = extra;
      } else if (widget.initialSearchText != null) {
        searchText = widget.initialSearchText;
      }
      
      // 如果有搜索文本，则设置到搜索框并执行搜索
      if (searchText != null && searchText.isNotEmpty) {
        _searchController.text = searchText;
        _performSearch();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 执行搜索
  Future<void> _performSearch() async {
    final searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入搜索内容')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      final searchService = Provider.of<SearchService>(context, listen: false);
      final results = await searchService.searchPhoneNumber(searchText);

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });

      // 如果没有找到结果，显示提示
      if (results.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('未找到匹配的号码')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('搜索出错: $e')),
      );
    }
  }

  /// 处理搜索结果项点击
  void _handleResultTap(SearchResult result) {
    if (result.type == SearchResultType.remoteNumber) {
      CallerIdDialog.show(context, result.phoneNumber);
    } else if (result.type == SearchResultType.notFound) {
      CountrySelectionDialog.show(context, result.phoneNumber);
    } else if (result.type == SearchResultType.contact) {
      // 处理联系人结果，打开联系人编辑对话框
      final contactService = Provider.of<ContactService>(context, listen: false);
      // 使用正确的方法：getContactByPhoneNumber 或 findContactByPhoneNumber
      contactService.findContactByPhoneNumber(PhoneNumber(result.phoneNumber)).then((contact) {
        if (contact != null) {
          ContactEditDialog.show(
            context,
            contact: contact,
            onContactUpdated: _performSearch,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法找到联系人')),
          );
        }
      });
    } else if (result.type == SearchResultType.label) {
      // 处理标签结果，打开标签编辑对话框
      final labelService = Provider.of<LabelService>(context, listen: false);
      // 使用正确的方法：getLabelByPhoneNumber 或 getLabelByPhoneNumberString
      labelService.getLabelByPhoneNumberString(result.phoneNumber).then((label) {
        if (label != null) {
          LabelEditDialog.show(
            context, 
            label, 
            onLabelUpdated: _performSearch,
            themeColor: Theme.of(context).primaryColor,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法找到标签')),
          );
        }
      });
    } else if (result.type == SearchResultType.allow || 
               result.type == SearchResultType.block || 
               result.type == SearchResultType.silence || 
               result.type == SearchResultType.none) {
      // 处理规则结果，打开规则编辑对话框
      final ruleService = Provider.of<RuleManagementService>(context, listen: false);
      final allowedBlockedService = Provider.of<AllowedBlockedService>(context, listen: false);
      
      if (result.ruleType == 'phone') {
        // 使用正确的方法：getAllRulesByActionType 并过滤
        ruleService.getAllRulesByActionType(null).then((rules) {
          final rule = rules.firstWhere(
            (r) => r.id == result.id,
            orElse: () => throw Exception('无法找到规则'),
          );
          PhoneRuleEditDialog.show(
            context, 
            rule, 
            onRuleUpdated: _performSearch,
            themeColor: Theme.of(context).primaryColor,
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('无法找到规则: $error')),
          );
        });
      } else if (result.ruleType == 'allowedBlocked') {
        // 使用正确的方法：getAllRulesByActionType 并过滤
        allowedBlockedService.getAllRulesByActionType(null).then((rules) {
          final rule = rules.firstWhere(
            (r) => r.id == result.id,
            orElse: () => throw Exception('无法找到规则'),
          );
          AllowedBlockedRuleEditDialog.show(
            context, 
            rule, 
            onRuleUpdated: _performSearch,
            themeColor: Theme.of(context).primaryColor,
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('无法找到规则: $error')),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('号码搜索'),
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: '输入电话号码',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _performSearch,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('搜索'),
                ),
              ],
            ),
          ),

          // 搜索结果
          Expanded(
            child: _hasSearched
                ? _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _searchResults.isEmpty
                        ? const Center(child: Text('未找到匹配的号码'))
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final result = _searchResults[index];
                              return SearchResultItem(
                                result: result,
                                onTap: () => _handleResultTap(result),
                              );
                            },
                          )
                : const Center(
                    child: Text('输入电话号码开始搜索'),
                  ),
          ),
        ],
      ),
    );
  }
}