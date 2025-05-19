import 'package:flutter/material.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
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
  bool _isEnabled = true;
  bool _useCloudDatabase = true;
  bool _useCommunityReports = true;
  int _minimumReportCount = 5;
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
      final configMap = await widget.configRepository.getConfig('remote_filter_settings');
      if (configMap != null) {
        setState(() {
          _isEnabled = configMap['isEnabled'] ?? true;
          _useCloudDatabase = configMap['useCloudDatabase'] ?? true;
          _useCommunityReports = configMap['useCommunityReports'] ?? true;
          _minimumReportCount = configMap['minimumReportCount'] ?? 5;
        });
      }
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
      final configMap = {
        'isEnabled': _isEnabled,
        'useCloudDatabase': _useCloudDatabase,
        'useCommunityReports': _useCommunityReports,
        'minimumReportCount': _minimumReportCount,
      };

      await widget.configRepository.saveConfig('remote_filter_settings', configMap);
      await widget.remoteNumberFilterService.initialize(); // 重新初始化服务以应用新设置
      
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
                  isEnabled: _isEnabled,
                  useCloudDatabase: _useCloudDatabase,
                  useCommunityReports: _useCommunityReports,
                  minimumReportCount: _minimumReportCount,
                  isLoading: _isLoading,
                  onEnabledChanged: (value) {
                    setState(() {
                      _isEnabled = value;
                    });
                  },
                  onUseCloudDatabaseChanged: (value) {
                    setState(() {
                      _useCloudDatabase = value;
                    });
                  },
                  onUseCommunityReportsChanged: (value) {
                    setState(() {
                      _useCommunityReports = value;
                    });
                  },
                  onMinimumReportCountChanged: (value) {
                    setState(() {
                      _minimumReportCount = value;
                    });
                  },
                ),
              ],
            ),
    );
  }

  }
