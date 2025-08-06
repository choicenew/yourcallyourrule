import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/provider/providers/phone_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_subscription_page.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 重构后的电话订阅页面
/// 使用通用的GenericSubscriptionPage组件减少重复代码
class PhoneSubscriptionPage extends ConsumerWidget {
  const PhoneSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GenericSubscriptionPage<Subscription, String, PhoneSubscriptionService>(
      title: AppLocalizations.of(context)!.phoneRuleSubscription,
      emptyText: AppLocalizations.of(context)!.noSubscriptions,
      buildInfoCard: () => _buildInfoCard(context),
      buildSubscriptionCard: (subscription, state) => _buildSubscriptionCard(subscription, state, ref),
      showAddDialog: _showAddDialog,
      updateSubscription: _updateSubscription,
      serviceBuilder: (_) => ref.read(phoneSubscriptionServiceProvider),
    );
  }

  /// 构建信息卡片
  Widget _buildInfoCard(BuildContext context) {
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

  /// 构建订阅卡片
  Widget _buildSubscriptionCard(Subscription subscription, GenericSubscriptionPageState<Subscription, String, PhoneSubscriptionService> state, WidgetRef ref) {
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
                                  ? Colors.green.withValues(alpha:0.1)
                                  : subscription.action == RuleAction.block
                                      ? Colors.red.withValues(alpha:0.1)
                                      : Colors.grey.withValues(alpha:0.1),
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
                              color: Colors.green.withValues(alpha:0.1),
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
                  onChanged: (value) => state.toggleSubscriptionStatus(subscription, value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.sync),
                      label: Text(AppLocalizations.of(state.context)!.syncNow),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => state.updateSubscription(subscription),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.file_download),
                    label: Text(AppLocalizations.of(state.context)!.import),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _importRulesToRuleSystem(state.context, subscription, ref.read(phoneSubscriptionServiceProvider), ref),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: Text(AppLocalizations.of(state.context)!.deleteButton),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => state.deleteSubscription(subscription),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 显示添加订阅对话框
  void _showAddDialog(BuildContext context, PhoneSubscriptionService service, Function refreshCallback) {
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
        _showAddSubscriptionDialog(context, service, refreshCallback, action: RuleAction.block);
      } else if (value == 'add_allow') {
        _showAddSubscriptionDialog(context, service, refreshCallback, action: RuleAction.allow);
      } else if (value == 'add_silence') {
        _showAddSubscriptionDialog(context, service, refreshCallback, action: RuleAction.silence);
      } else if (value == 'add_none') {
        _showAddSubscriptionDialog(context, service, refreshCallback, action: RuleAction.none);
      }
    });
  }

  /// 显示添加订阅对话框
  void _showAddSubscriptionDialog(BuildContext context, PhoneSubscriptionService service, Function refreshCallback, {RuleAction action = RuleAction.block}) {
    final nameController = TextEditingController();
    final urlController = TextEditingController();

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
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.subscriptionName,
                hintText: AppLocalizations.of(context)!.enterSubscriptionName,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
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
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final url = urlController.text.trim();
              
              if (name.isEmpty || url.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.enterValidNameAndUrl)),
                );
                return;
              }

              try {
                await service.addSubscription(name, url, action: action);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('订阅 "$name" 添加成功')),
                );
                Navigator.of(context).pop();
                refreshCallback();
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

  /// 更新订阅
  Future<void> _updateSubscription(Subscription subscription, PhoneSubscriptionService service) async {
    await service.manualUpdateRulesFromSubscription(subscription);
  }
  
  /// 导入规则到规则系统
  Future<void> _importRulesToRuleSystem(BuildContext dialogContext, Subscription subscription, PhoneSubscriptionService service, WidgetRef ref) async {
    try {
      // 显示加载对话框
      showDialog(
        context: dialogContext,
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
      final rules = await service.manualUpdateRulesFromSubscription(subscription);
      
      // 获取规则管理服务
      final ruleManagementService = ref.read(ruleManagementServiceProvider);
      
      // 导入规则
      final count = await ruleManagementService.importRulesFromSubscription(rules, subscription.action);
      
      // 关闭加载对话框
      Navigator.of(dialogContext).pop();
      
      // 显示结果
      ScaffoldMessenger.of(dialogContext).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(dialogContext)!.importSuccess}: $count ${AppLocalizations.of(dialogContext)!.rulesImported}')),
      );
    } catch (e) {
      // 关闭加载对话框
      Navigator.of(dialogContext).pop();
      
      // 显示错误
      ScaffoldMessenger.of(dialogContext).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(dialogContext)!.importFailure}: $e')),
      );
    }
  }
}