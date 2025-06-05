import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 过滤管理组件
/// 用于集中管理各种通话过滤功能的开关设置
class FilterManagementWidget extends StatefulWidget {
  const FilterManagementWidget({super.key});

  @override
  State<FilterManagementWidget> createState() => _FilterManagementWidgetState();
}

class _FilterManagementWidgetState extends State<FilterManagementWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // 标题栏
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.filterManagement,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          // 展开的内容
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // SIM卡过滤规则
                  _buildSimCardFilterSwitch(),
                  const SizedBox(height: 16),
                  // 通话过滤规则
                  _buildCallFilterSwitch(),
                  const SizedBox(height: 16),
                  // 本地计数过滤器
                  _buildLocalCountFilterSwitch(),
                  const SizedBox(height: 16),
                  // 远程号码过滤器
                  _buildRemoteNumberFilterSwitch(),
                  const SizedBox(height: 16),
                  // 时间拦截器
                  _buildTimeInterceptorSwitch(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// 构建SIM卡过滤规则开关
  Widget _buildSimCardFilterSwitch() {
    return FutureBuilder<List<dynamic>>(
      future: Provider.of<SimSlotRuleService>(context, listen: false)
          .getAllSimSlotRules(),
      builder: (context, snapshot) {
        int ruleCount = snapshot.hasData ? snapshot.data!.length : 0;
        return _buildFilterSwitchItem(
          title: AppLocalizations.of(context)!.simCardFilterRules,
          subtitle: AppLocalizations.of(context)!.simCardFilterRulesDescription,
          icon: Icons.sim_card,
          color: Colors.blue,
          count: ruleCount,
          isEnabled: Provider.of<EnhancedCompositeFilterService>(context)
              .isFilterEnabled('CallFilterService'),
          onToggle: (value) {
            final service = Provider.of<EnhancedCompositeFilterService>(
                context,
                listen: false);
            if (value) {
              service.enableFilter('CallFilterService');
            } else {
              service.disableFilter('CallFilterService');
            }
            setState(() {});
          },
        );
      },
    );
  }

  /// 构建本地计数过滤器开关
  Widget _buildLocalCountFilterSwitch() {
    final localCountFilterService =
        Provider.of<LocalCountFilterService>(context);
    return _buildFilterSwitchItem(
      title: AppLocalizations.of(context)!.localCountFilter,
      subtitle: AppLocalizations.of(context)!.localCountFilterDescription,
      icon: Icons.filter_list,
      color: Colors.orange,
      count: localCountFilterService.localCountFilterConfig.countThreshold,
      isEnabled: localCountFilterService.localCountFilterConfig.enableLocalCountFilter,
      onToggle: (value) async {
        final config = localCountFilterService.localCountFilterConfig;
        config.enableLocalCountFilter = value;
        await localCountFilterService.updateConfig(config);
        setState(() {});
      },
    );
  }

  /// 构建远程号码过滤器开关
  Widget _buildRemoteNumberFilterSwitch() {
    final remoteNumberFilterService =
        Provider.of<RemoteNumberFilterService>(context);
    return _buildFilterSwitchItem(
      title: AppLocalizations.of(context)!.remoteNumberFilter,
      subtitle: AppLocalizations.of(context)!.remoteNumberFilterDescription,
      icon: Icons.filter,
      color: Colors.purple,
      count: remoteNumberFilterService.remoteNumberFilterConfig.countThreshold,
      isEnabled: remoteNumberFilterService.remoteNumberFilterConfig.enableRemoteNumberFilter,
      onToggle: (value) async {
        final config = remoteNumberFilterService.remoteNumberFilterConfig;
        config.enableRemoteNumberFilter = value;
        await remoteNumberFilterService.updateConfig(config);
        setState(() {});
      },
    );
  }

  /// 构建通话过滤规则开关
  Widget _buildCallFilterSwitch() {
    final callFilterService =
        Provider.of<CallFilterService>(context);
    return ExpansionTile(
      title: Text(AppLocalizations.of(context)!.callFilterRules),
      subtitle: Text(AppLocalizations.of(context)!.callFilterRulesDescription),
      leading: const Icon(Icons.call_end, color: Colors.red),
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectAllCalls),
          subtitle: Text(AppLocalizations.of(context)!.rejectAllCallsDescription),
          value: callFilterService.callFilterConfig.rejectAllNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.rejectAllNumbers = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllowedNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowAllowedNumbersDesc),
          value: callFilterService.callFilterConfig.allowAllAllowedNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowAllAllowedNumbers = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowRegexAllowRules),
          subtitle: Text(AppLocalizations.of(context)!.allowRegexAllowRulesDescription),
          value: callFilterService.callFilterConfig.allowRegexAllowRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowRegexAllowRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowBlockedNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowBlockedNumbersDesc),
          value: callFilterService.callFilterConfig.allowBlockedNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowBlockedNumbers = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllAllowRules),
          subtitle: Text(AppLocalizations.of(context)!.allowAllAllowRulesDesc),
          value: callFilterService.callFilterConfig.allowAllAllowRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowAllAllowRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowRegexBlockRules),
          subtitle: Text(AppLocalizations.of(context)!.allowRegexBlockRulesDescription),
          value: callFilterService.callFilterConfig.allowRegexBlockRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowRegexBlockRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllBlockRules),
          subtitle: Text(AppLocalizations.of(context)!.allowAllBlockRulesDesc),
          value: callFilterService.callFilterConfig.allowAllBlockRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowAllBlockRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableMuteRules),
          subtitle: Text(AppLocalizations.of(context)!.enableMuteRulesDesc),
          value: callFilterService.callFilterConfig.allowSilenceRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowSilenceRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableNoneActionRules),
          subtitle: Text(AppLocalizations.of(context)!.enableNoneActionRulesDesc),
          value: callFilterService.callFilterConfig.allowNoneRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowNoneRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
      ],
    );
  }

  /// 构建时间拦截器开关
  Widget _buildTimeInterceptorSwitch() {
    final timeInterceptorService =
        Provider.of<TimeInterceptorService>(context);
    return _buildFilterSwitchItem(
      title: AppLocalizations.of(context)!.timeInterceptor,
      subtitle: AppLocalizations.of(context)!.timeInterceptorDescription,
      icon: Icons.timer,
      color: Colors.teal,
      count: timeInterceptorService.config.duration.inMinutes,
      isEnabled: timeInterceptorService.config.shouldIntercept,
      onToggle: (value) async {
        await timeInterceptorService.updateConfig(
          timeInterceptorService.config.duration,
          value,
        );
        setState(() {});
      },
    );
  }

  /// 构建过滤器开关项
  Widget _buildFilterSwitchItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int count,
    required bool isEnabled,
    required Function(bool) onToggle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: isEnabled,
            onChanged: onToggle,
            activeColor: color,
          ),
        ],
      ),
    );
  }
}