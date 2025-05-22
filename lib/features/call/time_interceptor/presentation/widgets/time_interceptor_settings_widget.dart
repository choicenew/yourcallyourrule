import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

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
        _buildEnableSwitch(context),
        const Divider(),
        _buildDurationSetting(context),
        const SizedBox(height: 32),
        _buildExplanationCard(context),
      ],
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch(BuildContext context) {
    return SwitchListTile(
      title: Text(AppLocalizations.of(context)!.enableTimeInterceptor),
      subtitle: Text(AppLocalizations.of(context)!.timeInterceptorDescription),
      value: isEnabled,
      onChanged: onEnabledChanged,
    );
  }

  /// 构建时间窗口设置
  Widget _buildDurationSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.timeWindowLabel(durationMinutes), 
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
        Text(AppLocalizations.of(context)!.timeWindowDescription),
      ],
    );
  }

  /// 构建说明卡片
  Widget _buildExplanationCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.timeInterceptorExplanationTitle, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.timeInterceptorExplanationContent),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.howItWorksTitle),
            Text(AppLocalizations.of(context)!.howItWorksPoint1),
            Text(AppLocalizations.of(context)!.howItWorksPoint2),
            Text(AppLocalizations.of(context)!.howItWorksPoint3),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.useCasesTitle),
            Text(AppLocalizations.of(context)!.useCasesPoint1),
            Text(AppLocalizations.of(context)!.useCasesPoint2),
            Text(AppLocalizations.of(context)!.useCasesPoint3),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.differentFromLocalCounter),
          ],
        ),
      ),
    );
  }
}