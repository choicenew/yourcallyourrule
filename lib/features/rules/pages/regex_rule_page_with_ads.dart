import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/regex/regex_pattern.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/provider/providers/regex_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/import_export_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/rules/services/regex_rule_import_export_adapter.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/features/rules/widgets/rule_action_selector.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

/// 正则规则管理页面 - 带广告版本
/// 使用GenericListWithAdsPage组件实现带广告的列表页面
class RegexRulePageWithAds extends ConsumerStatefulWidget {
  const RegexRulePageWithAds({super.key});

  @override
  ConsumerState<RegexRulePageWithAds> createState() =>
      _RegexRulePageWithAdsState();
}

class _RegexRulePageWithAdsState extends ConsumerState<RegexRulePageWithAds> {
  List<RegexRule> _rules = [];
  bool _isLoading = true;
  RuleActionType? _selectedActionType;
  Set<String> _selectedRuleIds = {};
  bool _isMultiSelectMode = false;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadRules();
  }

  Future<void> _loadRules() async {
    setState(() {
      _isLoading = true;
    });

    final service = ref.read(regexServiceProvider);
    final rules = await service.getAllRegexRules();

    // 应用筛选条件
    final filteredRules =
        rules.where((rule) {
          // 动作类型筛选
          if (_selectedActionType != null &&
              rule.action.type != _selectedActionType) {
            return false;
          }

          // 搜索关键字筛选
          if (_searchKeyword.isNotEmpty) {
            final searchLower = _searchKeyword.toLowerCase();
            final nameMatch = rule.name.toLowerCase().contains(searchLower);
            final patternMatch = rule.pattern.toLowerCase().contains(
              searchLower,
            );
            if (!nameMatch && !patternMatch) {
              return false;
            }
          }

          return true;
        }).toList();

    setState(() {
      _rules = filteredRules;
      _isLoading = false;
    });
  }

  void _toggleRuleStatus(String ruleId, bool isEnabled) async {
    final service = ref.read(regexServiceProvider);
    await service.toggleRegexRule(ruleId, isEnabled);
    _loadRules();
  }

  void _deleteRule(String ruleId) async {
    final service = ref.read(regexServiceProvider);
    await service.removeRegexRule(ruleId);
    _loadRules();
  }

  void _deleteSelectedRules() async {
    final service = ref.read(regexServiceProvider);
    for (final ruleId in _selectedRuleIds) {
      await service.removeRegexRule(ruleId);
    }

    setState(() {
      _selectedRuleIds = {};
      _isMultiSelectMode = false;
    });

    _loadRules();
  }

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
    _loadRules();
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedRuleIds = {};
      }
    });
  }

  void _toggleItemSelection(String ruleId) {
    setState(() {
      if (_selectedRuleIds.contains(ruleId)) {
        _selectedRuleIds.remove(ruleId);
      } else {
        _selectedRuleIds.add(ruleId);
      }
    });
  }

  void _filterByAction(RuleActionType? actionType) {
    setState(() {
      _selectedActionType = actionType;
    });
    _loadRules();
  }

  void _showMoreOptions(BuildContext context) {
    final regexService = ref.read(regexServiceProvider);

    // 创建导入导出组件
    final importExportComponent =
        ImportExportServiceComponent<RegexRule, String>(
          importExportService: RegexRuleImportExportAdapter(
            regexService.importExportService,
          ),
          entityTypeName: AppLocalizations.of(context)!.regexRule,
          onEntitiesImported: (rules) async {
            // 使用服务类的公共方法保存规则
            for (final rule in rules) {
              await regexService.updateRegexRule(rule);
            }
            _loadRules();
          },
          getEntitiesToExport: () => regexService.getAllRegexRules(),
        );

    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.filter_list),
                title: Text(AppLocalizations.of(context)!.filterByAction),
                onTap: () {
                  Navigator.pop(context);
                  _showActionFilterDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.import_export),
                title: Text(AppLocalizations.of(context)!.importExport),
                onTap: () {
                  Navigator.pop(context);
                  importExportComponent.showImportExportDialog(context);
                },
              ),
            ],
          ),
    );
  }

  void _showActionFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.filterByAction),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.all),
                  onTap: () {
                    _filterByAction(null);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.allow),
                  onTap: () {
                    _filterByAction(RuleActionType.allow);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.block),
                  onTap: () {
                    _filterByAction(RuleActionType.block);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showAddRuleDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController patternController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.addRegexRule),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.ruleName,
                          hintText:
                              AppLocalizations.of(
                                context,
                              )!.exampleBlock400Prefix,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: patternController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.regexPattern,
                          hintText:
                              "${AppLocalizations.of(context)!.exampleRegex400Prefix}:'^400\\d{7}\$'",
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 使用RuleActionSelector组件替换简单的下拉选择框
                      RuleActionSelector(
                        initialAction: selectedAction,
                        onActionChanged: (action) {
                          setState(() {
                            selectedAction = action;
                          });
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppLocalizations.of(context)!.cancelButton),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (nameController.text.isEmpty ||
                            patternController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.regexRuleNamePatternRequired,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        try {
                          final service = ref.read(regexServiceProvider);

                          // 验证正则表达式
                          if (!service.isValidRegex(patternController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.invalidRegexPattern,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // 创建正则模式
                          final pattern = RegExPattern(
                            name: nameController.text,
                            pattern: patternController.text,
                            action: selectedAction,
                          );

                          // 添加规则
                          await service.addRegexRule(pattern);

                          // 刷新规则列表
                          Navigator.pop(context);
                          _loadRules();

                          // 显示成功提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.regexRuleAddSuccess,
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          // 显示错误提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(
                                  context,
                                )!.regexRuleAddFailed(e.toString()),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.save),
                    ),
                  ],
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<RegexRule>(
      title: AppLocalizations.of(context)!.regexRuleManagement,
      items: _rules,
      itemBuilder: (context, rule) => _buildRuleCard(context, rule),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noRegexRules,
      emptyIcon: Icons.code,
      themeColor: const Color(0xFFF5A623),
      isLoading: _isLoading,
      onRefresh: _loadRules,
      onAdd: () => _showAddRuleDialog(context),
      onMoreOptions: () => _showMoreOptions(context),
      onMultiSelect: (selectedRules) {},
      getItemId: (rule) => rule.id,
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedRuleIds,
      onToggleMultiSelectMode: _toggleMultiSelectMode,
      onDeleteSelected: _deleteSelectedRules,
      onToggleItemSelection: _toggleItemSelection,
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchRegexRulesHint,
      infoCard: _buildInfoCard(),
    );
  }

  Widget _buildRuleCard(BuildContext context, RegexRule rule) {
    final actionText = RuleActionDisplayUtils.getActionTypeName(
      context,
      rule.action.type,
    );
    final actionColor = RuleActionDisplayUtils.getActionTypeColor(
      rule.action.type,
    );

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: actionColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.code, color: actionColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rule.pattern,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: rule.isEnabled,
                  onChanged: (value) => _toggleRuleStatus(rule.id, value),
                  activeColor: const Color(0xFFF5A623),
                ),
                if (!_isMultiSelectMode)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteRule(rule.id),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Chip(
                label: Text(actionText),
                backgroundColor: actionColor.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: actionColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          AppLocalizations.of(context)!.regexRulesInfo,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }
}