import 'package:flutter/material.dart';

/// 远程号码过滤器设置组件
/// 用于配置远程号码过滤服务的相关参数
class RemoteFilterSettingsWidget extends StatelessWidget {
  // 配置参数
  final bool enableRemoteNumberFilter;
  final int countThreshold;
  final bool rejectExceededNumbers;
  final bool allowNonExceededNumbers;
  final bool prioritizeRemoteAction;
  final bool logAllRemoteQueries;
  final bool isLoading;
  
  // 回调函数
  final ValueChanged<bool> onEnableRemoteNumberFilterChanged;
  final ValueChanged<int> onCountThresholdChanged;
  final ValueChanged<bool> onRejectExceededNumbersChanged;
  final ValueChanged<bool> onAllowNonExceededNumbersChanged;
  final ValueChanged<bool> onPrioritizeRemoteActionChanged;
  final ValueChanged<bool> onLogAllRemoteQueriesChanged;

  const RemoteFilterSettingsWidget({
    super.key,
    required this.enableRemoteNumberFilter,
    required this.countThreshold,
    required this.rejectExceededNumbers,
    required this.allowNonExceededNumbers,
    required this.prioritizeRemoteAction,
    required this.logAllRemoteQueries,
    this.isLoading = false,
    required this.onEnableRemoteNumberFilterChanged,
    required this.onCountThresholdChanged,
    required this.onRejectExceededNumbersChanged,
    required this.onAllowNonExceededNumbersChanged,
    required this.onPrioritizeRemoteActionChanged,
    required this.onLogAllRemoteQueriesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEnableSwitch(),
        const Divider(),
        _buildCountThresholdSettings(context),
        const Divider(),
        _buildFilterActionSettings(),
        const Divider(),
        _buildAdvancedSettings(),
        const SizedBox(height: 32),
        _buildExplanationCard(),
      ],
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return SwitchListTile(
      title: const Text('启用远程号码过滤'),
      subtitle: const Text('使用远程数据库过滤号码'),
      value: enableRemoteNumberFilter,
      onChanged: onEnableRemoteNumberFilterChanged,
    );
  }

  /// 构建计数阈值设置
  Widget _buildCountThresholdSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('计数阈值设置', 
            style: Theme.of(context).textTheme.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('计数阈值: $countThreshold', 
                style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              Slider(
                value: countThreshold.toDouble(),
                min: 1,
                max: 20,
                divisions: 19,
                label: countThreshold.toString(),
                onChanged: (value) {
                  onCountThresholdChanged(value.round());
                },
              ),
              const Text('设置触发过滤动作所需的最小计数阈值'),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建过滤动作设置
  Widget _buildFilterActionSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('拒绝超过阈值的号码'),
          subtitle: const Text('自动拒绝计数超过阈值的号码'),
          value: rejectExceededNumbers,
          onChanged: onRejectExceededNumbersChanged,
        ),
        SwitchListTile(
          title: const Text('允许未超过阈值的号码'),
          subtitle: const Text('自动允许计数未超过阈值的号码'),
          value: allowNonExceededNumbers,
          onChanged: onAllowNonExceededNumbersChanged,
        ),
      ],
    );
  }
  
  /// 构建高级设置
  Widget _buildAdvancedSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('优先使用远程动作设置'),
          subtitle: const Text('优先考虑远程数据库中的动作设置'),
          value: prioritizeRemoteAction,
          onChanged: onPrioritizeRemoteActionChanged,
        ),
        SwitchListTile(
          title: const Text('记录所有远程查询'),
          subtitle: const Text('记录所有远程号码查询操作'),
          value: logAllRemoteQueries,
          onChanged: onLogAllRemoteQueriesChanged,
        ),
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
            Text('远程号码过滤器通过查询远程数据库，基于号码计数来识别和拦截骚扰电话。'),
            SizedBox(height: 8),
            Text('功能特点：'),
            Text('• 计数阈值：根据号码出现次数判断'),
            Text('• 过滤动作：可配置对超过阈值号码的处理方式'),
            Text('• 优先级设置：可设置远程动作的优先级'),
            SizedBox(height: 8),
            Text('此过滤器使用独立远程数据库以获取最新的号码信息。'),
          ],
        ),
      ),
    );
  }
}