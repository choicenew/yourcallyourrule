import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/sms/services/sms_filter_service.dart';

class SmsFilterSettingsPage extends StatefulWidget {
  const SmsFilterSettingsPage({Key? key}) : super(key: key);

  @override
  State<SmsFilterSettingsPage> createState() => _SmsFilterSettingsPageState();
}

class _SmsFilterSettingsPageState extends State<SmsFilterSettingsPage> {
  bool _isLoading = true;
  bool _filterEnabled = true;
  bool _useLocalNotification = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final smsFilterService = Provider.of<SmsFilterService>(context, listen: false);
      // 这里假设SmsFilterService有获取当前设置的方法
      // 实际实现可能需要根据服务的API调整
      _filterEnabled = await smsFilterService.shouldNotify('', '');
      _useLocalNotification = true; // 默认值，实际应从服务获取

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载设置失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleFilterEnabled(bool value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final smsFilterService = Provider.of<SmsFilterService>(context, listen: false);
      await smsFilterService.setEnabled(value);
      
      setState(() {
        _filterEnabled = value;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('短信过滤已${value ? '启用' : '禁用'}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('设置失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleLocalNotification(bool value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final smsFilterService = Provider.of<SmsFilterService>(context, listen: false);
      await smsFilterService.setUseLocalNotification(value);
      
      setState(() {
        _useLocalNotification = value;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('本地通知已${value ? '启用' : '禁用'}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('设置失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短信过滤设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildInfoCard(),
                const SizedBox(height: 16),
                _buildFilterSettingsCard(),
                const SizedBox(height: 16),
                _buildNotificationSettingsCard(),
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
                    '关于短信过滤',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '短信过滤功能可以帮助您自动筛选垃圾短信，保持您的短信列表整洁。您可以设置过滤规则和通知方式。',
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

  Widget _buildFilterSettingsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '过滤设置',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('启用短信过滤'),
              subtitle: const Text('开启后将根据规则自动过滤短信'),
              value: _filterEnabled,
              onChanged: _toggleFilterEnabled,
              secondary: const Icon(Icons.filter_alt, color: Colors.blue),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.rule, color: Colors.orange),
              title: const Text('管理过滤规则'),
              subtitle: const Text('添加、编辑或删除短信过滤规则'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // 导航到规则管理页面
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => SmsRuleManagementPage(),
                // ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettingsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '通知设置',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('使用本地通知'),
              subtitle: const Text('开启后将在设备上显示过滤短信的通知'),
              value: _useLocalNotification,
              onChanged: _toggleLocalNotification,
              secondary: const Icon(Icons.notifications, color: Colors.purple),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notification_important, color: Colors.red),
              title: const Text('通知优先级'),
              subtitle: const Text('设置过滤短信通知的优先级'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // 导航到通知优先级设置页面
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => NotificationPriorityPage(),
                // ));
              },
            ),
          ],
        ),
      ),
    );
  }
}