import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';

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
            title: const Text(
              '过滤器管理',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          title: 'SIM卡过滤规则',
          subtitle: '根据SIM卡槽位设置不同的过滤规则',
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
      title: '本地计数过滤器',
      subtitle: '根据本地号码计数拦截频繁来电',
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
      title: '远程号码过滤器',
      subtitle: '根据远程数据库信息拦截骚扰电话',
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
      title: const Text('通话过滤规则'),
      subtitle: const Text('设置通话过滤的基本规则'),
      leading: const Icon(Icons.call_end, color: Colors.red),
      children: [
        SwitchListTile(
          title: const Text('拒绝所有号码'),
          subtitle: const Text('启用后将拒绝所有来电'),
          value: callFilterService.callFilterConfig.rejectAllNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.rejectAllNumbers = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('允许所有已允许号码'),
          subtitle: const Text('允许所有在允许列表中的号码'),
          value: callFilterService.callFilterConfig.allowAllAllowedNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowAllAllowedNumbers = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('允许被阻止号码'),
          subtitle: const Text('允许所有在阻止列表中的号码'),
          value: callFilterService.callFilterConfig.allowBlockedNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowBlockedNumbers = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('允许正则表达式允许规则'),
          subtitle: const Text('使用正则表达式规则允许号码'),
          value: callFilterService.callFilterConfig.allowRegexAllowRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowRegexAllowRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('允许所有白名单号码'),
          subtitle: const Text('允许所有在白名单中的号码'),
          value: callFilterService.callFilterConfig.allowAllWhitelistedNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowAllWhitelistedNumbers = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('允许正则表达式阻止规则'),
          subtitle: const Text('使用正则表达式规则阻止号码'),
          value: callFilterService.callFilterConfig.allowRegexBlockRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowRegexBlockRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('启用静音规则'),
          subtitle: const Text('启用静音来电的规则'),
          value: callFilterService.callFilterConfig.allowSilenceRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowSilenceRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('启用无动作规则'),
          subtitle: const Text('启用不执行任何动作的规则'),
          value: callFilterService.callFilterConfig.allowNoneRules,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowNoneRules = value;
            await callFilterService.updateConfig(newConfig);
            setState(() {});
          },
        ),
        SwitchListTile(
          title: const Text('允许所有黑名单号码'),
          subtitle: const Text('允许所有在黑名单中的号码'),
          value: callFilterService.callFilterConfig.allowAllBlacklistedNumbers,
          onChanged: (value) async {
            final newConfig = callFilterService.callFilterConfig;
            newConfig.allowAllBlacklistedNumbers = value;
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
      title: '时间拦截器',
      subtitle: '拦截短时间内的频繁来电',
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
        color: color.withOpacity(0.1),
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
              color: color.withOpacity(0.2),
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