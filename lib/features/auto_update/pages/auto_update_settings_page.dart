import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/services/auto_update_service.dart';

class AutoUpdateSettingsPage extends StatefulWidget {
  const AutoUpdateSettingsPage({Key? key}) : super(key: key);

  @override
  State<AutoUpdateSettingsPage> createState() => _AutoUpdateSettingsPageState();
}

class _AutoUpdateSettingsPageState extends State<AutoUpdateSettingsPage> {
  final Map<String, String> _serviceTypeNames = {
    'phone': '电话订阅',
    'sms': '短信订阅',
    'contact': '联系人订阅',
    'plugin': '插件更新',
  };

  final Map<String, IconData> _serviceTypeIcons = {
    'phone': Icons.phone,
    'sms': Icons.sms,
    'contact': Icons.contacts,
    'plugin': Icons.extension,
  };

  final Map<String, int> _userIntervals = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserIntervals();
  }

  Future<void> _loadUserIntervals() async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    
    for (final type in _serviceTypeNames.keys) {
      final interval = await autoUpdateService.getUserUpdateInterval(type);
      _userIntervals[type] = interval.inDays;
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateInterval(String type, int days) async {
    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    await autoUpdateService.setUserUpdateInterval(type, days);
    
    setState(() {
      _userIntervals[type] = days;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_serviceTypeNames[type]}更新间隔已设置为$days天')),
    );
  }

  Future<void> _updateNow(String type) async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    try {
      final updatedRules = await autoUpdateService.updateByType(type);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_serviceTypeNames[type]}更新成功，共更新${updatedRules.length}条规则')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_serviceTypeNames[type]}更新失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateAll() async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = Provider.of<AutoUpdateService>(context, listen: false);
    try {
      final updatedRules = await autoUpdateService.updateAll();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('全部更新成功，共更新${updatedRules.length}条规则')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自动更新设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _updateAll,
            tooltip: '立即更新全部',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildInfoCard(),
                const SizedBox(height: 16),
                ..._serviceTypeNames.keys.map((type) => _buildServiceCard(type)),
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
                    '自动更新设置',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '您可以设置各类订阅的自动更新间隔，也可以手动立即更新。',
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

  Widget _buildServiceCard(String type) {
    final days = _userIntervals[type] ?? 1;
    final name = _serviceTypeNames[type] ?? type;
    final icon = _serviceTypeIcons[type] ?? Icons.settings;

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
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  child: Icon(icon, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('更新间隔'),
                DropdownButton<int>(
                  value: days,
                  items: [1, 3, 7, 14, 30].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value天'),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      _updateInterval(type, newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.sync),
                label: const Text('立即更新'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading ? null : () => _updateNow(type),
              ),
            ),
          ],
        ),
      ),
    );
  }
}