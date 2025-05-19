import 'package:flutter/material.dart';

/// 本地计数过滤器设置组件
/// 用于配置本地计数过滤器的相关参数
class LocalFilterSettingsWidget extends StatelessWidget {
  // 配置参数
  final bool isEnabled;
  final int minCallCount;
  final int timeWindowHours;
  final bool blockUnknownCallers;
  
  // 回调函数
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onMinCallCountChanged;
  final ValueChanged<int> onTimeWindowHoursChanged;
  final ValueChanged<bool> onBlockUnknownCallersChanged;

  const LocalFilterSettingsWidget({
    super.key,
    required this.isEnabled,
    required this.minCallCount,
    required this.timeWindowHours,
    required this.blockUnknownCallers,
    required this.onEnabledChanged,
    required this.onMinCallCountChanged,
    required this.onTimeWindowHoursChanged,
    required this.onBlockUnknownCallersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEnableSwitch(),
        const Divider(),
        _buildMinCallCountSetting(context),
        const SizedBox(height: 16),
        _buildTimeWindowSetting(context),
        const Divider(),
        _buildBlockUnknownCallersSetting(),
        const SizedBox(height: 32),
        _buildExplanationCard(),
      ],
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return SwitchListTile(
      title: const Text('启用本地计数过滤'),
      subtitle: const Text('根据来电标记count自动过滤骚扰电话'),
      value: isEnabled,
      onChanged: onEnabledChanged,
    );
  }

  /// 构建最小来电次数设置
  Widget _buildMinCallCountSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('最小标记次数: $minCallCount', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: minCallCount.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: minCallCount.toString(),
          onChanged: (value) {
            onMinCallCountChanged(value.round());
          },
        ),
        const Text('设置在指定时间窗口内，未知来电的最小标记次数阈值，超过此阈值将被拦截'),
      ],
    );
  }

  /// 构建时间窗口设置
  Widget _buildTimeWindowSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('时间窗口(小时): $timeWindowHours', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: timeWindowHours.toDouble(),
          min: 1,
          max: 72,
          divisions: 71,
          label: timeWindowHours.toString(),
          onChanged: (value) {
            onTimeWindowHoursChanged(value.round());
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
      value: blockUnknownCallers,
      onChanged: onBlockUnknownCallersChanged,
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