import 'package:flutter/material.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_config.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';

/// 远程号码过滤器设置页面
/// 用于配置远程号码过滤服务的相关参数
class RemoteFilterSettingsPage extends StatefulWidget {
  final RemoteNumberFilterService remoteNumberFilterService;
  final RemoteNumberService remoteNumberService;
  final ConfigRepository configRepository;

  const RemoteFilterSettingsPage({
    super.key,
    required this.remoteNumberFilterService,
    required this.remoteNumberService,
    required this.configRepository,
  });

  @override
  RemoteFilterSettingsPageState createState() => RemoteFilterSettingsPageState();
}

class RemoteFilterSettingsPageState extends State<RemoteFilterSettingsPage> {
  // 配置参数
  bool _enableRemoteNumberFilter = true;
  int _countThreshold = 5;
  bool _rejectExceededNumbers = true;
  bool _allowNonExceededNumbers = false;
  bool _prioritizeRemoteAction = true;
  bool _logAllRemoteQueries = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// 加载设置
  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 从过滤服务加载配置
      await widget.remoteNumberFilterService.loadConfig();
      final config = widget.remoteNumberFilterService.remoteNumberFilterConfig;
      
      setState(() {
        _enableRemoteNumberFilter = config.enableRemoteNumberFilter;
        _countThreshold = config.countThreshold;
        _rejectExceededNumbers = config.rejectExceededNumbers;
        _allowNonExceededNumbers = config.allowNonExceededNumbers;
        _prioritizeRemoteAction = config.prioritizeRemoteAction;
        _logAllRemoteQueries = config.logAllRemoteQueries;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载设置失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 保存设置
  Future<void> _saveSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 创建新的配置对象
      final newConfig = RemoteNumberFilterConfig(
        enableRemoteNumberFilter: _enableRemoteNumberFilter,
        countThreshold: _countThreshold,
        rejectExceededNumbers: _rejectExceededNumbers,
        allowNonExceededNumbers: _allowNonExceededNumbers,
        prioritizeRemoteAction: _prioritizeRemoteAction,
        logAllRemoteQueries: _logAllRemoteQueries,
      );

      // 更新过滤服务的配置
      await widget.remoteNumberFilterService.updateConfig(newConfig);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('设置已保存')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存设置失败: $e')),
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
        title: const Text('远程号码过滤器设置'),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveSettings,
              tooltip: '保存设置',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // 使用提取的组件
                RemoteFilterSettingsWidget(
                  enableRemoteNumberFilter: _enableRemoteNumberFilter,
                  countThreshold: _countThreshold,
                  rejectExceededNumbers: _rejectExceededNumbers,
                  allowNonExceededNumbers: _allowNonExceededNumbers,
                  prioritizeRemoteAction: _prioritizeRemoteAction,
                  logAllRemoteQueries: _logAllRemoteQueries,
                  isLoading: _isLoading,
                  onEnableRemoteNumberFilterChanged: (value) {
                    setState(() {
                      _enableRemoteNumberFilter = value;
                    });
                  },
                  onCountThresholdChanged: (value) {
                    setState(() {
                      _countThreshold = value;
                    });
                  },
                  onRejectExceededNumbersChanged: (value) {
                    setState(() {
                      _rejectExceededNumbers = value;
                    });
                  },
                  onAllowNonExceededNumbersChanged: (value) {
                    setState(() {
                      _allowNonExceededNumbers = value;
                    });
                  },
                  onPrioritizeRemoteActionChanged: (value) {
                    setState(() {
                      _prioritizeRemoteAction = value;
                    });
                  },
                  onLogAllRemoteQueriesChanged: (value) {
                    setState(() {
                      _logAllRemoteQueries = value;
                    });
                  },
                ),
              ],
            ),
    );
  }

  }
