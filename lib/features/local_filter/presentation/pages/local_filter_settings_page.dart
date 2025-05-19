import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';

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
          // 使用提取的组件
          LocalFilterSettingsWidget(
            isEnabled: _isEnabled,
            minCallCount: _minCallCount,
            timeWindowHours: _timeWindowHours,
            blockUnknownCallers: _blockUnknownCallers,
            onEnabledChanged: (value) {
              setState(() {
                _isEnabled = value;
              });
            },
            onMinCallCountChanged: (value) {
              setState(() {
                _minCallCount = value;
              });
            },
            onTimeWindowHoursChanged: (value) {
              setState(() {
                _timeWindowHours = value;
              });
            },
            onBlockUnknownCallersChanged: (value) {
              setState(() {
                _blockUnknownCallers = value;
              });
            },
          ),
        ],
      ),
    );
  }
}