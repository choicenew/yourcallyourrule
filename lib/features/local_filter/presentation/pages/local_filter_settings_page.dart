import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';

/// 本地计数过滤器设置页面
/// 用于配置本地计数过滤器的相关参数
class LocalFilterSettingsPage extends StatefulWidget {
  final LocalCountFilterService localCountFilterService;
  final ConfigRepository configRepository;

  const LocalFilterSettingsPage({
    super.key,
    required this.localCountFilterService,
    required this.configRepository,
  });

  @override
  LocalFilterSettingsPageState createState() => LocalFilterSettingsPageState();
}

class LocalFilterSettingsPageState extends State<LocalFilterSettingsPage> {
  // 配置参数
  bool _isEnabled = true;
  int _minCallCount = 3;
  int _timeWindowHours = 24;
  bool _blockUnknownCallers = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// 加载设置
  Future<void> _loadSettings() async {
    final configMap = await widget.configRepository.getConfig('local_filter_settings');
    if (configMap != null) {
      setState(() {
        _isEnabled = configMap['isEnabled'] ?? true;
        _minCallCount = configMap['minCallCount'] ?? 3;
        _timeWindowHours = configMap['timeWindowHours'] ?? 24;
        _blockUnknownCallers = configMap['blockUnknownCallers'] ?? false;
      });
    }
  }

  /// 保存设置
  Future<void> _saveSettings() async {
    final configMap = {
      'isEnabled': _isEnabled,
      'minCallCount': _minCallCount,
      'timeWindowHours': _timeWindowHours,
      'blockUnknownCallers': _blockUnknownCallers,
    };
    await widget.configRepository.saveConfig('local_filter_settings', configMap);
    await widget.localCountFilterService.initialize(); // 重新初始化服务以应用新设置
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('设置已保存')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地计数过滤器设置'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: '保存设置',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildEnableSwitch(),
          const Divider(),
          _buildMinCallCountSetting(),
          const SizedBox(height: 16),
          _buildTimeWindowSetting(),
          const Divider(),
          _buildBlockUnknownCallersSetting(),
          const SizedBox(height: 32),
          _buildExplanationCard(),
        ],
      ),
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return SwitchListTile(
      title: const Text('启用本地计数过滤'),
      subtitle: const Text('根据来电标记count自动过滤骚扰电话'),
      value: _isEnabled,
      onChanged: (value) {
        setState(() {
          _isEnabled = value;
        });
      },
    );
  }

  /// 构建最小来电次数设置
  Widget _buildMinCallCountSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('最小标记次数: $_minCallCount', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: _minCallCount.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: _minCallCount.toString(),
          onChanged: (value) {
            setState(() {
              _minCallCount = value.round();
            });
          },
        ),
        const Text('设置在指定时间窗口内，未知来电的最小标记次数阈值，超过此阈值将被拦截'),
      ],
    );
  }

  /// 构建时间窗口设置
  Widget _buildTimeWindowSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('时间窗口(小时): $_timeWindowHours', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: _timeWindowHours.toDouble(),
          min: 1,
          max: 72,
          divisions: 71,
          label: _timeWindowHours.toString(),
          onChanged: (value) {
            setState(() {
              _timeWindowHours = value.round();
            });
          },
        ),
        const Text('设置计算来电频率的时间窗口大小'),
      ],
    );
  }

  /// 构建拦截未知来电设置
  Widget _buildBlockUnknownCallersSetting() {
    return SwitchListTile(
      title: const Text('拦截未知来电'),
      subtitle: const Text('自动拦截所有未知号码的来电'),
      value: _blockUnknownCallers,
      onChanged: (value) {
        setState(() {
          _blockUnknownCallers = value;
        });
      },
    );
  }

  /// 构建说明卡片
  Widget _buildExplanationCard() {
    return const Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('本地计数过滤器说明', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text('本地计数过滤器通过分析来电历史记录，自动识别和拦截频繁骚扰电话。'),
            SizedBox(height: 8),
            Text('工作原理：'),
            Text('• 统计指定时间窗口内同一号码的来电次数'),
            Text('• 当未知号码的来电次数超过设定阈值时，自动拦截'),
            Text('• 可选择性地拦截所有未知来电'),
            SizedBox(height: 8),
            Text('此过滤器特别适用于识别自动拨号的骚扰电话和营销电话。'),
          ],
        ),
      ),
    );
  }
}