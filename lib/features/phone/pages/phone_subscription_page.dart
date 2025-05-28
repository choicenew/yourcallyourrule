import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';

class PhoneSubscriptionPage extends StatefulWidget {
  const PhoneSubscriptionPage({super.key});

  @override
  State<PhoneSubscriptionPage> createState() => _PhoneSubscriptionPageState();
}

class _PhoneSubscriptionPageState extends State<PhoneSubscriptionPage> {
  List<Subscription> _subscriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    setState(() {
      _isLoading = true;
    });

    final subscriptionService = Provider.of<PhoneSubscriptionService>(context, listen: false);
    try {
      final subscriptions = await subscriptionService.getAll();
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载订阅失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleSubscriptionStatus(Subscription subscription) async {
    final subscriptionService = Provider.of<PhoneSubscriptionService>(context, listen: false);
    try {
      if (subscription.isEnabled) {
        await subscriptionService.disableSubscription(subscription);
      } else {
        await subscriptionService.enableSubscription(subscription);
      }
      await _loadSubscriptions();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更改订阅状态失败: $e')),
      );
    }
  }

  Future<void> _updateSubscription(Subscription subscription) async {
    setState(() {
      _isLoading = true;
    });

    final subscriptionService = Provider.of<PhoneSubscriptionService>(context, listen: false);
    try {
      final updatedRules = await subscriptionService.manualUpdateRulesFromSubscription(subscription);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('订阅更新成功，共更新${updatedRules.length}条规则')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更新订阅失败: $e')),
      );
    } finally {
      await _loadSubscriptions();
    }
  }

  Future<void> _deleteSubscription(Subscription subscription) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除订阅'),
        content: Text('确定要删除订阅 "${subscription.name}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final subscriptionService = Provider.of<PhoneSubscriptionService>(context, listen: false);
      try {
        await subscriptionService.deleteSubscription(subscription.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('订阅已删除')),
        );
        await _loadSubscriptions();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('删除订阅失败: $e')),
        );
      }
    }
  }

  void _showAddSubscriptionDialog({bool isWhitelist = false}) {
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

              final subscriptionService = Provider.of<PhoneSubscriptionService>(context, listen: false);
              try {
                if (isWhitelist) {
                  await subscriptionService.addWhitelistSubscription(name, url);
                } else {
                  await subscriptionService.addBlacklistSubscription(name, url);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('订阅 "$name" 添加成功')),
                );
                Navigator.of(context).pop();
                await _loadSubscriptions();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('电话规则订阅'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add_blacklist') {
                _showAddSubscriptionDialog(isWhitelist: false);
              } else if (value == 'add_whitelist') {
                _showAddSubscriptionDialog(isWhitelist: true);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'add_blacklist',
                child: Text('添加黑名单订阅'),
              ),
              const PopupMenuItem<String>(
                value: 'add_whitelist',
                child: Text('添加白名单订阅'),
              ),
            ],
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _subscriptions.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.subscriptions_outlined, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('暂无订阅', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('添加订阅'),
                        onPressed: () => _showAddSubscriptionDialog(),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildInfoCard(),
                    const SizedBox(height: 16),
                    ..._subscriptions.map(_buildSubscriptionCard).toList(),
                  ],
                ),
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
                children: const [
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

  Widget _buildSubscriptionCard(Subscription subscription) {
    final isWhitelist = subscription.isWhitelist;
    final isBlacklist = subscription.isBlacklist;
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
                  onChanged: (value) => _toggleSubscriptionStatus(subscription),
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
                    onPressed: () => _updateSubscription(subscription),
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