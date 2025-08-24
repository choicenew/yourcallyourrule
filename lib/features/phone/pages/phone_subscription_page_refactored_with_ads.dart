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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionUpdateSuccess)),
                        );
                      } else {
                        await phoneSubscriptionService.addSubscription(name, url, action: selectedAction);
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
      final rules = await phoneSubscriptionService.importAndSaveRulesFromSubscription(subscription);
      final count = rules.length;

      // 关闭加载对话框
      Navigator.of(context).pop();

      // 显示结果
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${AppLocalizations.of(context)!.importSuccess}: $count ${AppLocalizations.of(context)!.rulesImported}')),
      );
      
      // 导入后刷新订阅列表以更新时间戳
      await _loadSubscriptions();

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
      themeColor: Theme.of(context).primaryColor,
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
    final formattedDate =
        '${lastUpdated.year}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')} ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    String truncateUrl(String url, {int maxLength = 40}) {
      if (url.length <= maxLength) {
        return url;
      }
      return '${url.substring(0, maxLength)}...';
    }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscription.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        truncateUrl(subscription.url.toString()),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: RuleActionDisplayUtils.getActionTypeColor(subscription.action.type)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              RuleActionDisplayUtils.getActionTypeName(context, subscription.action.type),
                              style: TextStyle(
                                fontSize: 12,
                                color: RuleActionDisplayUtils.getActionTypeColor(subscription.action.type),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.lastUpdated(formattedDate),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: Text(AppLocalizations.of(context)!.syncNow),
                    onPressed: () => _updateSubscription(subscription),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.file_download),
                    label: Text(AppLocalizations.of(context)!.import),
                    onPressed: () => _importRulesToRuleSystem(subscription),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}