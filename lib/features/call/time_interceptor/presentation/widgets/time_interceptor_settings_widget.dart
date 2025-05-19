import 'package:flutter/material.dart';

/// 来电频率拦截设置组件
/// 用于配置来电频率拦截服务的相关参数
class TimeInterceptorSettingsWidget extends StatelessWidget {
  // 配置参数
  final bool isEnabled;
  final int durationMinutes;
  final bool isLoading;
  
  // 回调函数
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onDurationMinutesChanged;

  const TimeInterceptorSettingsWidget({
    super.key,
    required this.isEnabled,
    required this.durationMinutes,
    this.isLoading = false,
    required this.onEnabledChanged,
    required this.onDurationMinutesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEnableSwitch(),
        const Divider(),
        _buildDurationSetting(context),
        const SizedBox(height: 32),
        _buildExplanationCard(),
      ],
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return SwitchListTile(
      title: const Text('启用来电频率拦截'),
      subtitle: const Text('根据来电频率自动拦截可能的骚扰电话'),
      value: isEnabled,
      onChanged: onEnabledChanged,
    );
  }

  /// 构建时间窗口设置
  Widget _buildDurationSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('拦截时间窗口(分钟): $durationMinutes', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: durationMinutes.toDouble(),
          min: 5,
          max: 120,
          divisions: 23,
          label: durationMinutes.toString(),
          onChanged: (value) {
            onDurationMinutesChanged(value.round());
          },
        ),
        const Text('设置拦截重复来电的时间窗口大小，在此时间窗口内的重复来电将被拦截'),
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
            Text('来电频率拦截说明', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text('来电频率拦截功能通过分析来电频率，自动识别和拦截频繁骚扰电话。'),
            SizedBox(height: 8),
            Text('工作原理：'),
            Text('• 当同一号码在设定的时间窗口内多次呼叫时，系统会自动拦截'),
            Text('• 时间窗口越短，拦截越严格；时间窗口越长，拦截越宽松'),
            Text('• 系统会检查通话记录，判断是否为重复来电'),
            SizedBox(height: 8),
            Text('适用场景：'),
            Text('• 识别自动重拨的骚扰电话'),
            Text('• 拦截短时间内多次呼入的营销电话'),
            Text('• 防止电话轰炸和骚扰'),
            SizedBox(height: 8),
            Text('此功能与本地计数过滤器不同，它专注于短时间内的重复来电模式，而不是长期的标记次数。'),
          ],
        ),
      ),
    );
  }
}