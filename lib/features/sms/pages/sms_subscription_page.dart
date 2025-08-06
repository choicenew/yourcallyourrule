import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';

import 'package:yourcallyourrule/core/provider/providers/sms_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_subscription_page.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


/// 重构后的短信订阅页面
/// 使用通用的GenericSubscriptionPage组件减少重复代码
class SmsSubscriptionPage extends ConsumerWidget {
  const SmsSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GenericSubscriptionPage<SmsSubscription, String, SmsSubscriptionService>(
      title: AppLocalizations.of(context)!.smsRuleSubscription,
      emptyText: AppLocalizations.of(context)!.noSubscriptions,
      serviceBuilder: (context) => ref.read(smsSubscriptionServiceProvider),
      emptyIcon: Icons.sms_outlined,
      buildInfoCard: () => _buildInfoCard(context),
      buildSubscriptionCard: _buildSubscriptionCard,
      showAddDialog: _showAddSubscriptionDialog,
      updateSubscription: (subscription, service) => service.updateRulesFromSubscription(subscription),
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
                    AppLocalizations.of(context)!.aboutSmsSubscriptionRules,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.smsSubscriptionRulesDescription,
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
  Widget _buildSubscriptionCard(SmsSubscription subscription, GenericSubscriptionPageState<SmsSubscription, String, SmsSubscriptionService> state) {
    final isBlock = subscription.action == RuleAction.block;
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
                              color: isBlock
                                  ? Colors.red.withValues(alpha:0.1)
                                  : Colors.green.withValues(alpha:0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isBlock ? AppLocalizations.of(state.context)!.blockRule : AppLocalizations.of(state.context)!.allowRule,
                              style: TextStyle(
                                fontSize: 12,
                                color: isBlock ? Colors.red : Colors.green,
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
                              color: Colors.orange.withValues(alpha:0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              AppLocalizations.of(state.context)!.pendingSync,
                              style: const TextStyle(fontSize: 12, color: Colors.orange),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${AppLocalizations.of(state.context)!.lastUpdated}: $formattedDate',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Consumer(builder: (context, ref, _) {
                  return Switch(
                    value: subscription.isEnabled,
                    onChanged: (value) async {
                      final service = ref.read(smsSubscriptionServiceProvider);
                      if (value) {
                        service.enableSubscription(subscription);
                      } else {
                        service.disableSubscription(subscription);
                      }
                    },
                  );
                }),
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
                    onPressed: () {
                      state.updateSubscription(subscription);
                    },
                  ),
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
                  onPressed: () {
                    state.deleteSubscription(subscription);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 显示添加订阅对话框
  void _showAddSubscriptionDialog(BuildContext context, SmsSubscriptionService service, Function refreshCallback) {
    final nameController = TextEditingController();
    final urlController = TextEditingController();
    RuleAction selectedAction = RuleAction.block;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addSmsSubscription),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.subscriptionName,
                  hintText: AppLocalizations.of(context)!.subscriptionNameHint,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.subscriptionUrl,
                  hintText: AppLocalizations.of(context)!.subscriptionUrlHint,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<RuleAction>(
                value: selectedAction,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.ruleAction,
                ),
                items: [
                  DropdownMenuItem(
                    value: RuleAction.block,
                    child: Row(
                      children: [
                        Icon(Icons.block, color: Colors.red.shade300, size: 20),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.block),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: RuleAction.allow,
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade300, size: 20),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.allow),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedAction = value;
                    });
                  }
                },
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
                    SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionNameAndUrlCannotBeEmpty)),
                  );
                  return;
                }

                try {
                  // 创建新的订阅
                  final subscription = SmsSubscription(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    url: Url(url),
                    isEnabled: true,
                    action: selectedAction,
                    lastUpdated: DateTime.now(),
                  );
                  
                  await service.save(subscription);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.smsSubscriptionAddedSuccessfully)),
                  );
                  Navigator.of(context).pop();
                  refreshCallback();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.failedToAddSmsSubscription(e.toString()))),
                  );
                }
              },
              child: Text(AppLocalizations.of(context)!.add),
            ),
          ],
        ),
      ),
    );
  }
}