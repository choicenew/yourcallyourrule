import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_subscription_page.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';

/// 重构后的短信订阅页面
/// 使用通用的GenericSubscriptionPage组件减少重复代码
class SmsSubscriptionPage extends StatelessWidget {
  const SmsSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericSubscriptionPage<SmsSubscription, String, SmsSubscriptionService>(
      title: '短信规则订阅',
      emptyText: '暂无订阅',
      emptyIcon: Icons.sms_outlined,
      buildInfoCard: _buildInfoCard,
      buildSubscriptionCard: _buildSubscriptionCard,
      showAddDialog: _showAddSubscriptionDialog,
      updateSubscription: (subscription, service) => service.updateRulesFromSubscription(subscription),
    );
  }

  /// 构建信息卡片
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
                children: const [
                  Text(
                    '关于短信订阅规则',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '通过URL订阅短信规则列表，支持正则表达式匹配。可设置拦截或放行动作。',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isBlock ? '拦截规则' : '放行规则',
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
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '待同步',
                              style: TextStyle(fontSize: 12, color: Colors.orange),
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
                  onChanged: (value) {
                    final service = Provider.of<SmsSubscriptionService>(state.context, listen: false);
                    if (value) {
                      service.enableSubscription(subscription);
                    } else {
                      service.disableSubscription(subscription);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: const Text('立即同步'),
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
                  label: const Text('删除'),
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
          title: const Text('添加短信订阅'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '订阅名称',
                  hintText: '输入订阅的名称',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: '订阅URL',
                  hintText: '输入订阅的URL地址',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<RuleAction>(
                value: selectedAction,
                decoration: const InputDecoration(
                  labelText: '规则动作',
                ),
                items: [
                  DropdownMenuItem(
                    value: RuleAction.block,
                    child: Row(
                      children: [
                        Icon(Icons.block, color: Colors.red.shade300, size: 20),
                        const SizedBox(width: 8),
                        const Text('拦截'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: RuleAction.allow,
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade300, size: 20),
                        const SizedBox(width: 8),
                        const Text('放行'),
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
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final url = urlController.text.trim();
                
                if (name.isEmpty || url.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请输入有效的名称和URL')),
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
                    SnackBar(content: Text('订阅 "$name" 添加成功')),
                  );
                  Navigator.of(context).pop();
                  refreshCallback();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('添加订阅失败: $e')),
                  );
                }
              },
              child: const Text('添加'),
            ),
          ],
        ),
      ),
    );
  }
}