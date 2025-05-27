import 'package:flutter/material.dart';

/// 本地计数过滤器设置组件
/// 用于配置本地计数过滤器的相关参数
class LocalFilterSettingsWidget extends StatelessWidget {
  // 配置参数 - 与LocalCountFilterConfig保持一致
  final bool enableLocalCountFilter;
  final int countThreshold;
  final bool rejectExceededNumbers;
  final bool allowNonExceededNumbers;
  final bool logAllLocalQueries;
  
  // 回调函数
  final ValueChanged<bool> onEnableLocalCountFilterChanged;
  final ValueChanged<int> onCountThresholdChanged;
  final ValueChanged<bool> onRejectExceededNumbersChanged;
  final ValueChanged<bool> onAllowNonExceededNumbersChanged;
  final ValueChanged<bool> onLogAllLocalQueriesChanged;

  const LocalFilterSettingsWidget({
    super.key,
    required this.enableLocalCountFilter,
    required this.countThreshold,
    required this.rejectExceededNumbers,
    required this.allowNonExceededNumbers,
    required this.logAllLocalQueries,
    required this.onEnableLocalCountFilterChanged,
    required this.onCountThresholdChanged,
    required this.onRejectExceededNumbersChanged,
    required this.onAllowNonExceededNumbersChanged,
    required this.onLogAllLocalQueriesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEnableSwitch(),
        const Divider(),
        _buildCountThresholdSetting(context),
        const SizedBox(height: 16),
        _buildRejectExceededNumbersSetting(),
        const SizedBox(height: 16),
        _buildAllowNonExceededNumbersSetting(),
        const SizedBox(height: 16),
        _buildLogAllLocalQueriesSetting(),
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
      value: enableLocalCountFilter,
      onChanged: onEnableLocalCountFilterChanged,
    );
  }

  /// 构建计数阈值设置
  Widget _buildCountThresholdSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('计数阈值: $countThreshold', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: countThreshold.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: countThreshold.toString(),
          onChanged: (value) {
            onCountThresholdChanged(value.round());
          },
        ),
        const Text('设置号码的计数阈值，超过此阈值将触发相应动作'),
      ],
    );
  }

  /// 构建拒绝超过阈值的号码设置
  Widget _buildRejectExceededNumbersSetting() {
    return SwitchListTile(
      title: const Text('拒绝超过阈值的号码'),
      subtitle: const Text('自动拒绝所有超过计数阈值的号码'),
      value: rejectExceededNumbers,
      onChanged: onRejectExceededNumbersChanged,
    );
  }
  
  /// 构建允许未超过阈值的号码设置
  Widget _buildAllowNonExceededNumbersSetting() {
    return SwitchListTile(
      title: const Text('允许未超过阈值的号码'),
      subtitle: const Text('自动允许所有未超过计数阈值的号码'),
      value: allowNonExceededNumbers,
      onChanged: onAllowNonExceededNumbersChanged,
    );
  }
  
  /// 构建记录所有本地查询设置
  Widget _buildLogAllLocalQueriesSetting() {
    return SwitchListTile(
      title: const Text('记录所有本地查询'),
      subtitle: const Text('记录所有本地号码查询的日志'),
      value: logAllLocalQueries,
      onChanged: onLogAllLocalQueriesChanged,
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
            Text('• 根据号码的计数值判断是否拦截'),
            Text('• 当号码的计数超过设定阈值时，可以选择自动拦截'),
            Text('• 可以选择性地允许未超过阈值的号码'),
            Text('• 可以选择是否记录所有查询日志'),
            SizedBox(height: 8),
            Text('此过滤器特别适用于识别自动拨号的骚扰电话和营销电话。'),
          ],
        ),
      ),
    );
  }
}