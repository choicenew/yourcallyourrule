import 'package:flutter/material.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

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
                _buildEnableSwitch(),
                const Divider(),
                _buildCloudDatabaseSettings(),
                const Divider(),
                _buildCommunityReportSettings(),
                const SizedBox(height: 32),
                _buildExplanationCard(),
              ],
            ),
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return SwitchListTile(
      title: const Text('启用远程号码过滤'),
      subtitle: const Text('使用云端数据库和社区举报识别骚扰电话'),
      value: _isEnabled,
      onChanged: (value) {
        setState(() {
          _isEnabled = value;
        });
      },
    );
  }

  /// 构建云数据库设置
  Widget _buildCloudDatabaseSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('使用云端数据库'),
          subtitle: const Text('查询已知的骚扰电话号码数据库'),
          value: _useCloudDatabase,
          onChanged: (value) {
            setState(() {
              _useCloudDatabase = value;
            });
          },
        ),
      ],
    );
  }

  /// 构建社区举报设置
  Widget _buildCommunityReportSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('使用社区举报'),
          subtitle: const Text('根据其他用户的举报识别骚扰电话'),
          value: _useCommunityReports,
          onChanged: (value) {
            setState(() {
              _useCommunityReports = value;
            });
          },
        ),
        if (_useCommunityReports) ...[  
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('最小举报次数: $_minimumReportCount', 
                  style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Slider(
                  value: _minimumReportCount.toDouble(),
                  min: 1,
                  max: 20,
                  divisions: 19,
                  label: _minimumReportCount.toString(),
                  onChanged: (value) {
                    setState(() {
                      _minimumReportCount = value.round();
                    });
                  },
                ),
                const Text('设置将号码标记为骚扰电话所需的最小社区举报次数'),
              ],
            ),
          ),
        ],
      ],
    );
  }


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
            Text('远程号码过滤器说明', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text('远程号码过滤器通过查询云端数据库和社区举报，识别和拦截已知的骚扰电话。'),
            SizedBox(height: 8),
            Text('功能特点：'),
            Text('• 本地数据库：包含已知的骚扰电话号码'),
            Text('• 社区举报：利用其他用户的举报信息'),
            Text('• 定期更新：数据库定期更新以识别新的骚扰号码'),
            SizedBox(height: 8),
            Text('此过滤器使用本地数据库，无需实时网络连接。'),
          ],
        ),
      ),
    );
  }
