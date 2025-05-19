import 'package:flutter/material.dart';

/// 远程号码过滤器设置组件
/// 用于配置远程号码过滤服务的相关参数
class RemoteFilterSettingsWidget extends StatelessWidget {
  // 配置参数
  final bool isEnabled;
  final bool useCloudDatabase;
  final bool useCommunityReports;
  final int minimumReportCount;
  final bool isLoading;
  
  // 回调函数
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<bool> onUseCloudDatabaseChanged;
  final ValueChanged<bool> onUseCommunityReportsChanged;
  final ValueChanged<int> onMinimumReportCountChanged;

  const RemoteFilterSettingsWidget({
    super.key,
    required this.isEnabled,
    required this.useCloudDatabase,
    required this.useCommunityReports,
    required this.minimumReportCount,
    this.isLoading = false,
    required this.onEnabledChanged,
    required this.onUseCloudDatabaseChanged,
    required this.onUseCommunityReportsChanged,
    required this.onMinimumReportCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEnableSwitch(),
        const Divider(),
        _buildCloudDatabaseSettings(),
        const Divider(),
        _buildCommunityReportSettings(context),
        const SizedBox(height: 32),
        _buildExplanationCard(),
      ],
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return SwitchListTile(
      title: const Text('启用远程号码过滤'),
      subtitle: const Text('使用云端数据库和社区举报识别骚扰电话'),
      value: isEnabled,
      onChanged: onEnabledChanged,
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
          value: useCloudDatabase,
          onChanged: onUseCloudDatabaseChanged,
        ),
      ],
    );
  }

  /// 构建社区举报设置
  Widget _buildCommunityReportSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('使用社区举报'),
          subtitle: const Text('根据其他用户的举报识别骚扰电话'),
          value: useCommunityReports,
          onChanged: onUseCommunityReportsChanged,
        ),
        if (useCommunityReports) ...[  
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('最小举报次数: $minimumReportCount', 
                  style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Slider(
                  value: minimumReportCount.toDouble(),
                  min: 1,
                  max: 20,
                  divisions: 19,
                  label: minimumReportCount.toString(),
                  onChanged: (value) {
                    onMinimumReportCountChanged(value.round());
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
}