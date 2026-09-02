import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/provider/providers/phone_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';

/// 重构后的电话订阅页面 - 集成广告功能
/// 使用GenericListWithAdsPage组件减少重复代码并集成广告
class PhoneSubscriptionPageRefactoredWithAds extends ConsumerStatefulWidget {
  const PhoneSubscriptionPageRefactoredWithAds({super.key});

  @override
  ConsumerState<PhoneSubscriptionPageRefactoredWithAds> createState() => _PhoneSubscriptionPageRefactoredWithAdsState();
}

class _PhoneSubscriptionPageRefactoredWithAdsState extends ConsumerState<PhoneSubscriptionPageRefactoredWithAds> {
  List<Subscription> _subscriptions = [];
  bool _isLoading = true;
  String _searchKeyword = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  // 订阅的导入规则类型覆盖，键为订阅ID，值为 'phone_rule' | 'allow_block' | 'regex'
  final Map<String, String> _subscriptionRuleTypeOverrides = {};

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
      var subscriptions = await phoneSubscriptionService.getAll();
      if (_searchKeyword.isNotEmpty) {
        subscriptions = subscriptions.where((s) =>
          s.name.toLowerCase().contains(_searchKeyword.toLowerCase()) ||
          s.url.toString().toLowerCase().contains(_searchKeyword.toLowerCase())
        ).toList();
      }
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.loadSubscriptionsFailed}: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleSubscriptionStatus(Subscription subscription, bool isEnabled) async {
    try {
      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
      await phoneSubscriptionService.toggleSubscriptionStatus(subscription, isEnabled);
      await _loadSubscriptions();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.changeSubscriptionStatusFailed}: $e')),
      );
    }
  }

  Future<void> _updateSubscription(Subscription subscription) async {
    try {
      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
      // 后台同步更新并更新时间戳
      final selectedRuleType = _subscriptionRuleTypeOverrides[subscription.id] ?? 'phone_rule';
      await phoneSubscriptionService.updateRulesFromSubscription(
        subscription,
        ruleTypeOverride: selectedRuleType,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionUpdateSuccess)),
      );
      // 更新当前订阅项，避免整页刷新
      final updated = await phoneSubscriptionService.getById(subscription.id);
      if (updated != null) {
        setState(() {
          final index = _subscriptions.indexWhere((s) => s.id == subscription.id);
          if (index != -1) {
            _subscriptions[index] = updated;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.updateSubscriptionFailed}: $e')),
      );
    }
  }

  Future<void> _deleteSubscription(Subscription subscription) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteSubscription),
        content: Text(AppLocalizations.of(context)!.confirmDeleteSubscriptions(subscription.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.deleteButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
        await phoneSubscriptionService.deleteSubscription(subscription.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionDeleted)),
        );
        await _loadSubscriptions();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.deleteSubscriptionFailed}: $e')),
        );
      }
    }
  }

  void _showAddSubscriptionDialog({Subscription? subscription}) {
    _nameController.text = subscription?.name ?? '';
    _urlController.text = subscription?.url.toString() ?? '';
    final isEditing = subscription != null;
    RuleAction selectedAction = subscription?.action ?? RuleAction.none;
    // 规则类型选择：默认为 phone_rule；编辑时加载已有的覆盖
    String selectedRuleType =
        (subscription != null && _subscriptionRuleTypeOverrides.containsKey(subscription.id))
            ? _subscriptionRuleTypeOverrides[subscription.id]!
            : 'phone_rule';

    String dialogTitle = isEditing
        ? AppLocalizations.of(context)!.editSubscription
        : AppLocalizations.of(context)!.addSubscription;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(dialogTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.subscriptionName,
                        hintText: AppLocalizations.of(context)!.enterSubscriptionName,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.subscriptionUrl,
                        hintText: AppLocalizations.of(context)!.enterSubscriptionUrl,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<RuleAction>(
                      value: selectedAction,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.ruleAction,
                        border: const OutlineInputBorder(),
                      ),
                      items: RuleActionType.values.map((type) {
                        return DropdownMenuItem<RuleAction>(
                          value: RuleAction(type: type),
                          child: Text(RuleActionDisplayUtils.getActionTypeName(context, type)),
                        );
                      }).toList(),
                      onChanged: (RuleAction? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedAction = newValue;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedRuleType,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.ruleType,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: 'phone_rule',
                          child: Text(AppLocalizations.of(context)!.phoneRule),
                        ),
                        DropdownMenuItem<String>(
                          value: 'allow_block',
                          child: Text(AppLocalizations.of(context)!.allowedBlockedRule),
                        ),
                        DropdownMenuItem<String>(
                          value: 'regex',
                          child: Text(AppLocalizations.of(context)!.regexRule),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedRuleType = newValue;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context)!.cancelButton),
                ),
                TextButton(
                  onPressed: () async {
                    final name = _nameController.text.trim();
                    final url = _urlController.text.trim();
                    
                    if (name.isEmpty || url.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppLocalizations.of(context)!.enterValidNameAndUrl)),
                      );
                      return;
                    }

                    try {
                      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
                      if (isEditing) {
                        final updatedSubscription = subscription!.copyWith(
                          name: name, 
                          url: Url.fromString(url),
                          action: selectedAction,
                        );
                        await phoneSubscriptionService.updateSubscription(updatedSubscription);
                        // 更新该订阅的规则类型覆盖
                        _subscriptionRuleTypeOverrides[updatedSubscription.id] = selectedRuleType;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionUpdateSuccess)),
                        );
                      } else {
                        final newSub = await phoneSubscriptionService.addSubscription(name, url, action: selectedAction);
                        // 保存新增订阅的规则类型覆盖
                        _subscriptionRuleTypeOverrides[newSub.id] = selectedRuleType;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionAddSuccess(name))),
                        );
                      }
                      Navigator.of(context).pop();
                      await _loadSubscriptions();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${isEditing ? AppLocalizations.of(context)!.updateSubscriptionFailed : AppLocalizations.of(context)!.addSubscriptionFailed}: $e')),
                      );
                    }
                  },
                  child: Text(isEditing ? AppLocalizations.of(context)!.save : AppLocalizations.of(context)!.add),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _importRulesToRuleSystem(Subscription subscription) async {
    try {
      // 显示加载对话框
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)!.importRules),
            ],
          ),
        ),
      );

      // 调用新的导入服务
      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
      final selectedRuleType = _subscriptionRuleTypeOverrides[subscription.id] ?? 'phone_rule';
      final rules = await phoneSubscriptionService.importAndSaveRulesFromSubscription(
        subscription,
        ruleTypeOverride: selectedRuleType,
      );
      final count = rules.length;

      // 关闭加载对话框
      Navigator.of(context).pop();

      // 显示结果
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.importSuccess}: $count ${AppLocalizations.of(context)!.rulesImported}')),
      );
      
      // 导入后后台更新当前订阅的最后更新时间，避免整页刷新
      try {
        final updated = await phoneSubscriptionService.getById(subscription.id);
        if (updated != null) {
          setState(() {
            final index = _subscriptions.indexWhere((s) => s.id == subscription.id);
            if (index != -1) {
              _subscriptions[index] = updated;
            }
          });
        }
      } catch (_) {}

    } catch (e) {
      // 关闭加载对话框
      Navigator.of(context).pop();

      // 显示错误
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.importFailure}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<Subscription>(
      title: AppLocalizations.of(context)!.phoneRuleSubscription,
      items: _subscriptions,
      itemBuilder: (context, subscription) => _buildSubscriptionCard(subscription),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
 
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noSubscriptions,
      emptyIcon: Icons.subscriptions_outlined,
      themeColor:Color.fromRGBO(255, Random().nextInt(180), Random().nextInt(50), 0.8),
      isLoading: _isLoading,
      onRefresh: _loadSubscriptions,
      onAdd: () => _showAddSubscriptionDialog(),
      //headerContent: _buildInfoCard(),
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchSubscriptionsHint,
      infoCard: _buildInfoCard(),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D9CDB).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFF2D9CDB).withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2D9CDB).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF2D9CDB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.aboutPhoneSubscriptionRules,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D9CDB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.phoneSubscriptionRulesDescription,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.black87,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(Subscription subscription) {
    final lastUpdated = subscription.lastUpdated;
    final formattedDate =
        '${lastUpdated.year}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')} ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    String truncateUrl(String url, {int maxLength = 40}) {
      if (url.length <= maxLength) {
        return url;
      }
      return '${url.substring(0, maxLength)}...';
    }

    final actionColor = RuleActionDisplayUtils.getActionTypeColor(subscription.action.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      truncateUrl(subscription.url.toString()),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: actionColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            RuleActionDisplayUtils.getActionTypeName(context, subscription.action.type),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: actionColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.lastUpdated(formattedDate),
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: subscription.isEnabled,
                    onChanged: (value) => _toggleSubscriptionStatus(subscription, value),
                    activeThumbColor: const Color(0xFF2D9CDB),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, color: Colors.grey, size: 20),
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showAddSubscriptionDialog(subscription: subscription);
                      } else if (value == 'delete') {
                        _deleteSubscription(subscription);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(AppLocalizations.of(context)!.edit),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(AppLocalizations.of(context)!.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.sync_rounded, size: 16),
                  label: Text(AppLocalizations.of(context)!.syncNow, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                  onPressed: () => _updateSubscription(subscription),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D9CDB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.file_download_outlined, size: 16),
                  label: Text(AppLocalizations.of(context)!.import, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                  onPressed: () => _importRulesToRuleSystem(subscription),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2D9CDB),
                    side: const BorderSide(color: Color(0xFF2D9CDB), width: 1.1),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}