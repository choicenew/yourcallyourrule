import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/ads/ad_list_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通用列表页面示例 - 展示如何在各种列表页面中使用AdListWidget
/// 
/// 这个示例展示了如何在以下页面中使用AdListWidget：
/// - plugin_management_page.dart
/// - allowed_blocked_page.dart
/// - regex_rule_page.dart
/// - rule_management_page.dart
/// - sms_management_page.dart
/// - sms_subscription_page.dart
/// - sms_filter_page.dart
/// - contacts_management_page.dart
/// - contact_subscription_page.dart
/// - phone_subscription_page_refactored.dart
class GenericListWithAdsExample<T> extends ConsumerStatefulWidget {
  /// 页面标题
  final String title;
  
  /// 列表项
  final List<T> items;
  
  /// 列表项构建器
  final Widget Function(BuildContext, T) itemBuilder;
  
  /// 广告构建器
  final Widget Function() adBuilder;
  
  /// 广告间隔
  final int adInterval;
  
  /// 空状态文本
  final String emptyText;
  
  /// 主题颜色
  final Color themeColor;
  
  /// 构造函数
  const GenericListWithAdsExample({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.adBuilder,
    this.adInterval = 3,
    required this.emptyText,
    this.themeColor = Colors.blue,
  }) : super(key: key);

  @override
  ConsumerState<GenericListWithAdsExample<T>> createState() => _GenericListWithAdsExampleState<T>();
}

class _GenericListWithAdsExampleState<T> extends ConsumerState<GenericListWithAdsExample<T>> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.themeColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // 列表
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    // 创建空状态组件
    final emptyWidget = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            widget.emptyText,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    // 使用AdListWidget构建列表
    return AdListWidget<T>(
      items: widget.items,
      adBuilder: widget.adBuilder,
      itemBuilder: widget.itemBuilder,
      adInterval: widget.adInterval,
      adControlServiceProvider: adControlServiceProvider,
      emptyWidget: emptyWidget,
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }
}

/// 使用示例：插件管理页面
class PluginManagementPageExample extends ConsumerStatefulWidget {
  const PluginManagementPageExample({Key? key}) : super(key: key);

  @override
  ConsumerState<PluginManagementPageExample> createState() => _PluginManagementPageExampleState();
}

class _PluginManagementPageExampleState extends ConsumerState<PluginManagementPageExample> {
  // 插件列表（示例数据）
  final List<Map<String, dynamic>> _plugins = [
    {'id': '1', 'name': '来电识别插件', 'enabled': true},
    {'id': '2', 'name': '短信过滤插件', 'enabled': false},
    {'id': '3', 'name': '通话录音插件', 'enabled': true},
    {'id': '4', 'name': '黑名单插件', 'enabled': true},
    {'id': '5', 'name': '白名单插件', 'enabled': false},
  ];

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsExample<Map<String, dynamic>>(
      title: '插件管理',
      items: _plugins,
      itemBuilder: (context, plugin) => _buildPluginItem(plugin),
      adBuilder: () => _buildAdItem(),
      adInterval: 3,
      emptyText: '暂无插件',
      themeColor: Colors.purple,
    );
  }

  Widget _buildPluginItem(Map<String, dynamic> plugin) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple,
          child: Icon(
            Icons.extension,
            color: Colors.white,
          ),
        ),
        title: Text(plugin['name']),
        trailing: Switch(
          value: plugin['enabled'],
          onChanged: (value) {
            setState(() {
              plugin['enabled'] = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildAdItem() {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(child: Text('广告位')),
    );
  }
}

/// 使用示例：规则管理页面
class RuleManagementPageExample extends ConsumerStatefulWidget {
  const RuleManagementPageExample({Key? key}) : super(key: key);

  @override
  ConsumerState<RuleManagementPageExample> createState() => _RuleManagementPageExampleState();
}

class _RuleManagementPageExampleState extends ConsumerState<RuleManagementPageExample> {
  // 规则列表（示例数据）
  final List<Map<String, dynamic>> _rules = [
    {'id': '1', 'pattern': '1[3-9]\d{9}', 'action': '拦截', 'enabled': true},
    {'id': '2', 'pattern': '400\d{7}', 'action': '允许', 'enabled': true},
    {'id': '3', 'pattern': '95[0-9]{3}', 'action': '拦截', 'enabled': false},
    {'id': '4', 'pattern': '0[0-9]{2,3}-[0-9]{7,8}', 'action': '允许', 'enabled': true},
    {'id': '5', 'pattern': '\+[0-9]{1,3}[0-9]{9,}', 'action': '拦截', 'enabled': true},
  ];

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsExample<Map<String, dynamic>>(
      title: '规则管理',
      items: _rules,
      itemBuilder: (context, rule) => _buildRuleItem(rule),
      adBuilder: () => _buildAdItem(),
      adInterval: 3,
      emptyText: '暂无规则',
      themeColor: Colors.teal,
    );
  }

  Widget _buildRuleItem(Map<String, dynamic> rule) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: rule['action'] == '拦截' ? Colors.red : Colors.green,
          child: Icon(
            rule['action'] == '拦截' ? Icons.block : Icons.check_circle,
            color: Colors.white,
          ),
        ),
        title: Text(rule['pattern']),
        subtitle: Text(rule['action']),
        trailing: Switch(
          value: rule['enabled'],
          onChanged: (value) {
            setState(() {
              rule['enabled'] = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildAdItem() {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(child: Text('广告位')),
    );
  }
}

/// 使用示例：短信管理页面
class SmsManagementPageExample extends ConsumerStatefulWidget {
  const SmsManagementPageExample({Key? key}) : super(key: key);

  @override
  ConsumerState<SmsManagementPageExample> createState() => _SmsManagementPageExampleState();
}

class _SmsManagementPageExampleState extends ConsumerState<SmsManagementPageExample> {
  // 短信列表（示例数据）
  final List<Map<String, dynamic>> _messages = [
    {'id': '1', 'sender': '10086', 'content': '您的话费余额为100元', 'time': '10:30', 'isRead': true},
    {'id': '2', 'sender': '10010', 'content': '您的流量已用完', 'time': '09:15', 'isRead': false},
    {'id': '3', 'sender': '12306', 'content': '您的车票已预订成功', 'time': '昨天', 'isRead': true},
    {'id': '4', 'sender': '95588', 'content': '您的银行卡消费1000元', 'time': '昨天', 'isRead': true},
    {'id': '5', 'sender': '10001', 'content': '您的验证码为123456', 'time': '前天', 'isRead': true},
  ];

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsExample<Map<String, dynamic>>(
      title: '短信管理',
      items: _messages,
      itemBuilder: (context, message) => _buildMessageItem(message),
      adBuilder: () => _buildAdItem(),
      adInterval: 3,
      emptyText: '暂无短信',
      themeColor: Colors.orange,
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            message['sender'][0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          message['sender'],
          style: TextStyle(
            fontWeight: message['isRead'] ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          message['content'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(message['time']),
      ),
    );
  }

  Widget _buildAdItem() {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(child: Text('广告位')),
    );
  }
}

/// 使用示例：联系人管理页面
class ContactsManagementPageExample extends ConsumerStatefulWidget {
  const ContactsManagementPageExample({Key? key}) : super(key: key);

  @override
  ConsumerState<ContactsManagementPageExample> createState() => _ContactsManagementPageExampleState();
}

class _ContactsManagementPageExampleState extends ConsumerState<ContactsManagementPageExample> {
  // 联系人列表（示例数据）
  final List<Map<String, dynamic>> _contacts = [
    {'id': '1', 'name': '张三', 'phone': '13800138000', 'group': '家人'},
    {'id': '2', 'name': '李四', 'phone': '13900139000', 'group': '朋友'},
    {'id': '3', 'name': '王五', 'phone': '13700137000', 'group': '同事'},
    {'id': '4', 'name': '赵六', 'phone': '13600136000', 'group': '家人'},
    {'id': '5', 'name': '钱七', 'phone': '13500135000', 'group': '朋友'},
  ];

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsExample<Map<String, dynamic>>(
      title: '联系人管理',
      items: _contacts,
      itemBuilder: (context, contact) => _buildContactItem(contact),
      adBuilder: () => _buildAdItem(),
      adInterval: 3,
      emptyText: '暂无联系人',
      themeColor: Colors.blue,
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            contact['name'][0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(contact['name']),
        subtitle: Text(contact['phone']),
        trailing: Chip(
          label: Text(contact['group']),
          backgroundColor: Colors.blue[100],
        ),
      ),
    );
  }

  Widget _buildAdItem() {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(child: Text('广告位')),
    );
  }
}