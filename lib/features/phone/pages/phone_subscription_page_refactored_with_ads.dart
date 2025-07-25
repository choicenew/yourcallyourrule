import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/provider/providers/phone_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

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

  Future<void> _loadSubscriptions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
      final subscriptions = await phoneSubscriptionService.getAll();
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
    setState(() {
      _isLoading = true;
    });

    try {
      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
      await phoneSubscriptionService.manualUpdateRulesFromSubscription(subscription);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionUpdateSuccess)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.updateSubscriptionFailed}: $e')),
      );
    } finally {
      await _loadSubscriptions();
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
            child: Text(AppLocalizations.of(context)!.cancel),
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

  void _showAddDialog() {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'add_block',
          child: Text(AppLocalizations.of(context)!.addBlockSubscription),
        ),
        PopupMenuItem<String>(
          value: 'add_allow',
          child: Text(AppLocalizations.of(context)!.addAllowSubscription),
        ),
        PopupMenuItem<String>(
          value: 'add_silence',
          child: Text(AppLocalizations.of(context)!.addSilenceSubscription),
        ),
        PopupMenuItem<String>(
          value: 'add_none',
          child: Text(AppLocalizations.of(context)!.addNoneSubscription),
        ),
      ],
    ).then((value) {
      if (value == 'add_block') {
        _showAddSubscriptionDialog(action: RuleAction.block);
      } else if (value == 'add_allow') {
        _showAddSubscriptionDialog(action: RuleAction.allow);
      } else if (value == 'add_silence') {
        _showAddSubscriptionDialog(action: RuleAction.silence);
      } else if (value == 'add_none') {
        _showAddSubscriptionDialog(action: RuleAction.none);
      }
    });
  }

  void _showAddSubscriptionDialog({RuleAction action = RuleAction.block}) {
    _nameController.clear();
    _urlController.clear();

    String dialogTitle;
    if (action == RuleAction.allow) {
      dialogTitle = AppLocalizations.of(context)!.addAllowSubscription;
    } else if (action == RuleAction.block) {
      dialogTitle = AppLocalizations.of(context)!.addBlockSubscription;
    } else if (action == RuleAction.silence) {
      dialogTitle = AppLocalizations.of(context)!.addSilenceSubscription;
    } else if (action == RuleAction.none) {
      dialogTitle = AppLocalizations.of(context)!.addNoneSubscription;
    } else {
      dialogTitle = AppLocalizations.of(context)!.addSubscription;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(dialogTitle),
        content: Column(
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
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
                await phoneSubscriptionService.addSubscription(name, url, action: action);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('订阅 "$name" 添加成功')),
                );
                Navigator.of(context).pop();
                await _loadSubscriptions();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${AppLocalizations.of(context)!.addSubscriptionFailed}: $e')),
                );
              }
            },
            child: Text(AppLocalizations.of(context)!.add),
          ),
        ],
      ),
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
      
      // 获取规则
      final phoneSubscriptionService = ref.read(phoneSubscriptionServiceProvider);
      final rules = await phoneSubscriptionService.manualUpdateRulesFromSubscription(subscription);
      
      // 获取规则管理服务
      final ruleManagementService = ref.read(ruleManagementServiceProvider);
      
      // 导入规则
      final count = await ruleManagementService.importRulesFromSubscription(rules, subscription.action);
      
      // 关闭加载对话框
      Navigator.of(context).pop();
      
      // 显示结果
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.importSuccess}: $count ${AppLocalizations.of(context)!.rulesImported}')),
      );
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
      adBuilder: () => const Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('广告位', textAlign: TextAlign.center),
        ),
      ),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noSubscriptions,
      emptyIcon: Icons.subscriptions_outlined,
      themeColor: Theme.of(context).primaryColor,
      isLoading: _isLoading,
      onRefresh: _loadSubscriptions,
      onAdd: _showAddDialog,
      headerContent: _buildInfoCard(),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.aboutPhoneSubscriptionRules,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.phoneSubscriptionRulesDescription,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(Subscription subscription) {
    final lastUpdated = subscription.lastUpdated;
    final formattedDate = '${lastUpdated.year}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')} ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            subscription.name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: subscription.action == RuleAction.allow
                                  ? Colors.green.withOpacity(0.1)
                                  : subscription.action == RuleAction.block
                                      ? Colors.red.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              subscription.action == RuleAction.allow 
                                ? '允许' 
                                : subscription.action == RuleAction.block 
                                  ? '阻止' 
                                  : subscription.action == RuleAction.silence
                                    ? '静音'
                                    : subscription.action == RuleAction.none
                                      ? '无动作'
                                      : '其他',
                              style: TextStyle(
                                fontSize: 12,
                                color: subscription.action == RuleAction.allow 
                                  ? Colors.green 
                                  : subscription.action == RuleAction.block 
                                    ? Colors.red 
                                    : subscription.action == RuleAction.silence
                                      ? Colors.orange
                                      : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subscription.url.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '已同步',
                              style: TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '最后更新: $formattedDate',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: subscription.isEnabled,
                  onChanged: (value) => _toggleSubscriptionStatus(subscription, value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.sync),
                      label: Text(AppLocalizations.of(context)!.syncNow),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _updateSubscription(subscription),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.file_download),
                    label: Text(AppLocalizations.of(context)!.import),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _importRulesToRuleSystem(subscription),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: Text(AppLocalizations.of(context)!.deleteButton),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _deleteSubscription(subscription),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}