import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/sms/pages/sms_management_page.dart';
import 'package:yourcallyourrule/features/sms/providers/sms_filter_service_provider.dart';
import 'package:yourcallyourrule/features/sms/services/sms_filter_service.dart';


import 'package:yourcallyourrule/generated/app_localizations.dart';

class SmsFilterSettingsPage extends ConsumerStatefulWidget {
  const SmsFilterSettingsPage({super.key});

  @override
  ConsumerState<SmsFilterSettingsPage> createState() => _SmsFilterSettingsPageState();
}

class _SmsFilterSettingsPageState extends ConsumerState<SmsFilterSettingsPage> {
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
      final smsFilterService = ref.read(smsFilterServiceProvider);
      // 这里假设SmsFilterService有获取当前设置的方法
      // 实际实现可能需要根据服务的API调整
      _filterEnabled = await smsFilterService.shouldNotify('', '');
      _useLocalNotification = true; // 默认值，实际应从服务获取

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.loadSettingsFailed(e.toString()))),
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
      final smsFilterService = ref.read(smsFilterServiceProvider);
      await smsFilterService.setEnabled(value);
      
      setState(() {
        _filterEnabled = value;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value ? AppLocalizations.of(context)!.smsFilterEnabled : AppLocalizations.of(context)!.smsFilterDisabled)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaveFailed(e.toString()))),
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
      final smsFilterService = ref.read(smsFilterServiceProvider);
      await smsFilterService.setUseLocalNotification(value);
      
      setState(() {
        _useLocalNotification = value;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value ? AppLocalizations.of(context)!.localNotificationEnabled : AppLocalizations.of(context)!.localNotificationDisabled)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaveFailed(e.toString()))),
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
        title: Text(AppLocalizations.of(context)!.smsFilterSettings),
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
                children: [
                  Text(
                    AppLocalizations.of(context)!.aboutSmsFilter,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.smsFilterDescription,
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

  Widget _buildFilterSettingsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.filterSettingsTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.enableSmsFilter),
              subtitle: Text(AppLocalizations.of(context)!.enableSmsFilterDescription),
              value: _filterEnabled,
              onChanged: _toggleFilterEnabled,
              secondary: const Icon(Icons.filter_alt, color: Colors.blue),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.rule, color: Colors.orange),
              title: Text(AppLocalizations.of(context)!.manageFilterRules),
              subtitle: Text(AppLocalizations.of(context)!.manageFilterRulesDescription),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // 导航到规则管理页面
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SmsManagementPage(),
                ));
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
            Text(
              AppLocalizations.of(context)!.notificationSettings,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.enableLocalNotification),
              subtitle: Text(AppLocalizations.of(context)!.enableLocalNotificationDescription),
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
              //  Navigator.of(context).push(MaterialPageRoute(
             //     builder: (context) => const NotificationPriorityPage(),
             //   ));
              },
            ),
          ],
        ),
      ),
    );
  }
}