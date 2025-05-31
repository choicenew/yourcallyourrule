import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/services/auto_update_service.dart';

class AutoUpdateSettingsPage extends StatefulWidget {
  const AutoUpdateSettingsPage({super.key});

  @override
  State<AutoUpdateSettingsPage> createState() => _AutoUpdateSettingsPageState();
}

class _AutoUpdateSettingsPageState extends State<AutoUpdateSettingsPage> {
  bool _isLoading = true;
  Map<String, Duration> _updateIntervals = {};
  final Map<String, String> _serviceNames = {
    'phone': '电话规则',
    'sms': '短信规则',
    'contact': '联系人规则',
    'plugin': '插件',
  };

  @override
  void initState() {
    super.initState();
    _loadUpdateIntervals();
  }

  Future<void> _loadUpdateIntervals() async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    try {
      final intervals = <String, Duration>{};
      for (final serviceType in _serviceNames.keys) {
        intervals[serviceType] = await autoUpdateService.getUserUpdateInterval(serviceType);
      }

      setState(() {
        _updateIntervals = intervals;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载更新间隔失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateInterval(String serviceType, int days) async {
    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    try {
      await autoUpdateService.setUserUpdateInterval(serviceType, days);
      await _loadUpdateIntervals();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_serviceNames[serviceType]}更新间隔已设置为$days天')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('设置更新间隔失败: $e')),
      );
    }
  }

  Future<void> _updateAllNow() async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    try {
      final updatedRules = await autoUpdateService.updateAll();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更新完成，共更新${updatedRules.length}条规则')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更新失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateByType(String serviceType) async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    try {
      final updatedRules = await autoUpdateService.updateByType(serviceType);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_serviceNames[serviceType]}更新完成，共更新${updatedRules.length}条规则')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更新失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showUpdateIntervalDialog(String serviceType, Duration currentInterval) {
    final daysController = TextEditingController(
      text: (currentInterval.inDays).toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('设置${_serviceNames[serviceType]}更新间隔'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: daysController,
              decoration: const InputDecoration(
                labelText: '更新间隔（天）',
                hintText: '输入天数',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final daysText = daysController.text.trim();
              final days = int.tryParse(daysText);
              
              if (days == null || days <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('请输入有效的天数')),
                );
                return;
              }

              Navigator.of(context).pop();
              _updateInterval(serviceType, days);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自动更新设置'),
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
                _buildUpdateAllCard(),
                const SizedBox(height: 16),
                ..._serviceNames.keys.map((serviceType) => _buildServiceCard(serviceType)).toList(),
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
                    '关于自动更新',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '自动更新功能可以定期从订阅源获取最新的规则，保持您的规则库始终是最新的。您可以为每种规则类型设置不同的更新间隔。',
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

  Widget _buildUpdateAllCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '全部更新',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '立即更新所有类型的规则',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.sync),
                label: const Text('立即更新全部'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _updateAllNow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String serviceType) {
    final interval = _updateIntervals[serviceType] ?? const Duration(days: 1);
    final days = interval.inDays;

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
                Text(
                  _serviceNames[serviceType] ?? serviceType,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '每$days天更新',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: const Text('立即更新'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _updateByType(serviceType),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.settings),
                  label: const Text('设置间隔'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _showUpdateIntervalDialog(serviceType, interval),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}