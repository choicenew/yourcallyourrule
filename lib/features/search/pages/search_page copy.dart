import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:world_flags/world_flags.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlibphone;
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';

import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';

import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';


import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
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
      _showCallerIdDialog(context, result.phoneNumber);
    } else if (result.type == SearchResultType.notFound) {
      _showCountrySelectionDialog(context, result.phoneNumber);
    } else if (result.type == SearchResultType.contact) {
      // 处理联系人结果，打开联系人编辑对话框
      final contactService = Provider.of<ContactService>(context, listen: false);
      // 使用正确的方法：getContactByPhoneNumber 或 findContactByPhoneNumber
      contactService.findContactByPhoneNumber(PhoneNumber(result.phoneNumber)).then((contact) {
        if (contact != null) {
          _showContactEditDialog(context, contact);
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
          _showLabelEditDialog(context, label);
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
          _showPhoneRuleEditDialog(context, rule);
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
          _showAllowedBlockedRuleEditDialog(context, rule);
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('无法找到规则: $error')),
          );
        });
      }
    }
  }

  // 显示国家选择对话框
  void _showCountrySelectionDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('选择国家', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: WorldCountry.list.length,
                  itemBuilder: (context, index) {
                    final country = WorldCountry.list[index];
                    return ListTile(
                      leading: CountryFlag.simplified(
                        country,
                        height: 24,
                      ),
                      title: Text(country.internationalName),
                      subtitle: Text(country.namesNative.first.common),
                      onTap: () {
                        Navigator.pop(context);
                        _showCallerIdDialog(
                          context,
                          phoneNumber,
                          countryCode: country.code,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 显示来电显示信息对话框
  void _showCallerIdDialog(BuildContext context, String phoneNumber, {String? countryCode}) async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final callerIdService = Provider.of<CallerIdService>(context, listen: false);

    // 创建 dlibphone.Locale
    final dlibLocale = dlibphone.Locale(
      language: localeProvider.locale.languageCode,
      country: countryCode ?? localeProvider.locale.countryCode ?? 'US',
    );

    try {
      // 显示加载对话框
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取来电显示信息
      final callerIdData = await callerIdService.getCallerId(phoneNumber, dlibLocale);

      // 关闭加载对话框
      Navigator.pop(context);

      // 显示结果对话框
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('号码: ${callerIdData.phoneNumber}'),
                const SizedBox(height: 8),
                Text('名称: ${callerIdData.name}'),
                if (callerIdData.countryName != null) ...[                  
                  const SizedBox(height: 8),
                  Text('国家: ${callerIdData.countryName}'),
                ],
                if (callerIdData.region != null) ...[                  
                  const SizedBox(height: 8),
                  Text('地区: ${callerIdData.region}'),
                ],
                if (callerIdData.carrier != null) ...[                  
                  const SizedBox(height: 8),
                  Text('运营商: ${callerIdData.carrier}'),
                ],
                if (callerIdData.labels != null) ...[                  
                  const SizedBox(height: 8),
                  Text('标签: ${callerIdData.labels!.map((l) => l.label).join(', ')}'),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('关闭'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      // 关闭加载对话框
      Navigator.pop(context);
      // 显示错误信息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('获取来电显示信息失败: $e')),
      );
    }
  }

  // 显示联系人编辑对话框
  void _showContactEditDialog(BuildContext context, Contact contact) {
    final nameController = TextEditingController(text: contact.name);
    final phoneController = TextEditingController(text: contact.phoneNumbers.isNotEmpty ? contact.phoneNumbers[0] : '');
    final emailController = TextEditingController(text: contact.email ?? '');
    String? selectedLabelId = contact.labelId;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('编辑联系人', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '姓名',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: '电话号码',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: '电子邮件',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),
                PublicSelectLabel(
                  initialLabelId: selectedLabelId,
                  onLabelIdChanged: (labelId) {
                    setState(() {
                      selectedLabelId = labelId;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // 验证输入
                        if (nameController.text.isEmpty || phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('姓名和电话号码不能为空')),
                          );
                          return;
                        }

                        try {
                          // 更新联系人
                          final updatedContact = Contact(
                            id: contact.id,
                            name: nameController.text,
                            phoneNumbers: [phoneController.text],
                            email: emailController.text.isNotEmpty ? emailController.text : null,
                            labelId: selectedLabelId,
                          );

                          final contactService = Provider.of<ContactService>(context, listen: false);
                          await contactService.updateContact(updatedContact);

                          // 刷新搜索结果
                          _performSearch();

                          // 关闭对话框
                          Navigator.pop(context);

                          // 显示成功提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('联系人更新成功'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          // 显示错误提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('更新联系人失败: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text('保存'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 显示标签编辑对话框
  void _showLabelEditDialog(BuildContext context, LabelPhoneEntry label) {
    final labelController = TextEditingController(text: label.name);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('编辑标签', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: labelController,
                decoration: const InputDecoration(
                  labelText: '标签名称',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('取消'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 验证输入
                      if (labelController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('标签名称不能为空')),
                        );
                        return;
                      }

                      try {
                        // 更新标签
                        final updatedLabel = LabelPhoneEntry(
                          id: label.id,
                          name: labelController.text,
                          phoneNumber: label.phoneNumber,
                          labelId: label.labelId,
                        );

                        final labelService = Provider.of<LabelService>(context, listen: false);
                        await labelService.updateLabel(updatedLabel);

                        // 刷新搜索结果
                        _performSearch();

                        // 关闭对话框
                        Navigator.pop(context);

                        // 显示成功提示
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('标签更新成功'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        // 显示错误提示
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('更新标签失败: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text('保存'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 显示电话规则编辑对话框
  void _showPhoneRuleEditDialog(BuildContext context, PhoneRule rule) {
    final nameController = TextEditingController(text: rule.name);
    final phoneController = TextEditingController(text: rule.phoneNumber.toString());
    String? selectedLabelId = rule.labelId;
    var selectedAction = rule.action;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('编辑规则', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '规则名称',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: '电话号码',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                PublicSelectLabel(
                  initialLabelId: selectedLabelId,
                  onLabelIdChanged: (labelId) {
                    setState(() {
                      selectedLabelId = labelId;
                    });
                  },
                ),
                const SizedBox(height: 8),
                RuleActionSelector(
                  initialAction: selectedAction,
                  onActionChanged: (action) {
                    setState(() {
                      selectedAction = action;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // 验证输入
                        if (nameController.text.isEmpty || phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('规则名称和电话号码不能为空')),
                          );
                          return;
                        }

                        try {
                          // 更新规则
                          final updatedRule = PhoneRule(
                            id: rule.id,
                            name: nameController.text,
                            phoneNumber: PhoneNumber.fromString(phoneController.text),
                            labelId: selectedLabelId ?? '',
                            action: selectedAction,
                            isEnabled: rule.isEnabled,
                          );

                          final ruleService = Provider.of<RuleManagementService>(context, listen: false);
                          await ruleService.updatePhoneNumberRule(updatedRule);

                          // 刷新搜索结果
                          _performSearch();

                          // 关闭对话框
                          Navigator.pop(context);

                          // 显示成功提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('规则更新成功'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          // 显示错误提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('更新规则失败: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text('保存'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 显示允许/阻止规则编辑对话框
  void _showAllowedBlockedRuleEditDialog(BuildContext context, AllowedBlockedRule rule) {
    final nameController = TextEditingController(text: rule.name);
    final phoneController = TextEditingController(text: rule.phoneNumber.toString());
    String? selectedLabelId = rule.labelId;
    var selectedAction = rule.action;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('编辑规则', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '规则名称',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: '电话号码',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                PublicSelectLabel(
                  initialLabelId: selectedLabelId,
                  onLabelIdChanged: (labelId) {
                    setState(() {
                      selectedLabelId = labelId;
                    });
                  },
                ),
                const SizedBox(height: 8),
                RuleActionSelector(
                  initialAction: selectedAction,
                  onActionChanged: (action) {
                    setState(() {
                      selectedAction = action;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // 验证输入
                        if (nameController.text.isEmpty || phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('规则名称和电话号码不能为空')),
                          );
                          return;
                        }

                        try {
                          // 更新规则
                          final updatedRule = AllowedBlockedRule(
                            id: rule.id,
                            name: nameController.text,
                            phoneNumber: PhoneNumber.fromString(phoneController.text),
                            labelId: selectedLabelId ?? '',
                            action: selectedAction,
                            isEnabled: rule.isEnabled,
                          );

                          final service = Provider.of<AllowedBlockedService>(context, listen: false);
                          await service.updateAllowedBlockedRule(updatedRule);

                          // 刷新搜索结果
                          _performSearch();

                          // 关闭对话框
                          Navigator.pop(context);

                          // 显示成功提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('规则更新成功'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          // 显示错误提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('更新规则失败: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text('保存'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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