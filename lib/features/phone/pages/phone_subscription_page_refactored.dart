import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_subscription_page.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';

/// 重构后的电话订阅页面
/// 使用通用的GenericSubscriptionPage组件减少重复代码
class PhoneSubscriptionPageRefactored extends StatelessWidget {
  const PhoneSubscriptionPageRefactored({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericSubscriptionPage<Subscription, String, PhoneSubscriptionService>(
      title: '电话规则订阅',
      emptyText: '暂无订阅',
      buildInfoCard: _buildInfoCard,
      buildSubscriptionCard: _buildSubscriptionCard,
      showAddDialog: _showAddDialog,
      updateSubscription: _updateSubscription,
    );
  }

  /// 构建信息卡片
  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '关于电话订阅规则',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '通过URL订阅电话规则列表，自动更新黑白名单规则。支持JSON格式规则文件。',
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
  Widget _buildSubscriptionCard(Subscription subscription, GenericSubscriptionPageState<Subscription, String, PhoneSubscriptionService> state) {
    final isWhitelist = subscription.isWhitelist;
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
                              color: isWhitelist
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isWhitelist ? '白名单' : '黑名单',
                              style: TextStyle(
                                fontSize: 12,
                                color: isWhitelist ? Colors.green : Colors.red,
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
                    label: const Text('立即同步'),
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
                  icon: const Icon(Icons.delete),
                  label: const Text('删除'),
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
        const PopupMenuItem<String>(
          value: 'add_blacklist',
          child: Text('添加黑名单订阅'),
        ),
        const PopupMenuItem<String>(
          value: 'add_whitelist',
          child: Text('添加白名单订阅'),
        ),
      ],
    ).then((value) {
      if (value == 'add_blacklist') {
        _showAddSubscriptionDialog(context, service, refreshCallback, isWhitelist: false);
      } else if (value == 'add_whitelist') {
        _showAddSubscriptionDialog(context, service, refreshCallback, isWhitelist: true);
      }
    });
  }

  /// 显示添加订阅对话框
  void _showAddSubscriptionDialog(BuildContext context, PhoneSubscriptionService service, Function refreshCallback, {bool isWhitelist = false}) {
    final nameController = TextEditingController();
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isWhitelist ? '添加白名单订阅' : '添加黑名单订阅'),
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
                if (isWhitelist) {
                  await service.addWhitelistSubscription(name, url);
                } else {
                  await service.addBlacklistSubscription(name, url);
                }
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
    );
  }

  /// 更新订阅
  Future<void> _updateSubscription(Subscription subscription, PhoneSubscriptionService service) async {
    await service.manualUpdateRulesFromSubscription(subscription);
  }
}