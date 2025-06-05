import 'package:flutter/material.dart';


import 'package:yourcallyourrule/generated/app_localizations.dart';

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
    return Builder(builder: (context) {
      return SwitchListTile(
        title: Text(AppLocalizations.of(context)!.enableRemoteNumberFilter),
        subtitle: Text(AppLocalizations.of(context)!.enableRemoteNumberFilterDescription),
        value: enableRemoteNumberFilter,
        onChanged: onEnableRemoteNumberFilterChanged,
      );
    });
  }

  /// 构建计数阈值设置
  Widget _buildCountThresholdSettings(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context)!.countThresholdSettings, 
            style: Theme.of(context).textTheme.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.countThresholdValue(countThreshold), 
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
              Text(AppLocalizations.of(context)!.countThresholdDescription),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建过滤动作设置
  Widget _buildFilterActionSettings() {
    return Builder(builder: (context) {
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
            subtitle: Text(AppLocalizations.of(context)!.rejectExceededNumbersDescription),
            value: rejectExceededNumbers,
            onChanged: onRejectExceededNumbersChanged,
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.allowNonExceededNumbers),
            subtitle: Text(AppLocalizations.of(context)!.allowNonExceededNumbersDescription),
            value: allowNonExceededNumbers,
            onChanged: onAllowNonExceededNumbersChanged,
          ),
        ],
      );
    });
  }
  
  /// 构建高级设置
  Widget _buildAdvancedSettings() {
    return Builder(builder: (context) {
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.prioritizeRemoteAction),
            subtitle: Text(AppLocalizations.of(context)!.prioritizeRemoteActionDescription),
            value: prioritizeRemoteAction,
            onChanged: onPrioritizeRemoteActionChanged,
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.logAllRemoteQueries),
            subtitle: Text(AppLocalizations.of(context)!.logAllRemoteQueriesDescription),
            value: logAllRemoteQueries,
            onChanged: onLogAllRemoteQueriesChanged,
          ),
        ],
      );
    });
  }

  /// 构建说明卡片
  Widget _buildExplanationCard() {
    return Builder(builder: (context) {
      
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.remoteNumberFilterExplanationTitle, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.remoteNumberFilterExplanationContent),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.remoteNumberFilterFeatures),
              Text(AppLocalizations.of(context)!.remoteNumberFilterFeatureCountThreshold),
              Text(AppLocalizations.of(context)!.remoteNumberFilterFeatureFilterAction),
              Text(AppLocalizations.of(context)!.remoteNumberFilterFeaturePriority),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.remoteNumberFilterDatabaseInfo),
            ],
          ),
        ),
      );
    });
  }
}