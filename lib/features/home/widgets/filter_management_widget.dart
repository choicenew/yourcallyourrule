import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart' as flutter;
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/sim_slot_rule_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/enhanced_composite_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/call_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/local_count_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/remote_number_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/time_interceptor_service_provider.dart';
import 'package:yourcallyourrule/common/error/logger.dart';

/// 过滤管理组件
/// 用于集中管理各种通话过滤功能的开关设置
class FilterManagementWidget extends ConsumerStatefulWidget {
  const FilterManagementWidget({super.key});

  @override
  ConsumerState<FilterManagementWidget> createState() => _FilterManagementWidgetState();
}

class _FilterManagementWidgetState extends ConsumerState<FilterManagementWidget> {
  bool _isExpanded = false;
  final SimCardInfo _simCardInfoPlugin = SimCardInfo();
  List<flutter.SimInfo> _simInfo = [];
  bool isSupported = true;
  
  @override
  void initState() {
    super.initState();
    initSimInfoState();
  }
  
  /// 初始化SIM卡信息
  Future<void> initSimInfoState() async {
    List<flutter.SimInfo>? simCardInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
    } on PlatformException {
      simCardInfo = [];
      setState(() {
        isSupported = false;
      });
      AppLogger.error('获取SIM卡信息失败', 'SIM卡信息不受支持');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _simInfo = simCardInfo!;
    });
  }

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
      future: ref.read(simSlotRuleServiceProvider)
          .getAllSimSlotRules(),
      builder: (context, snapshot) {
        int ruleCount = snapshot.hasData ? snapshot.data!.length : 0;
        final enhancedService = ref.watch(enhancedCompositeFilterServiceProvider);
        return _buildFilterSwitchItem(
          title: AppLocalizations.of(context)!.simCardFilterRules,
          subtitle: AppLocalizations.of(context)!.simCardFilterRulesDescription,
          icon: Icons.sim_card,
          color: Colors.blue,
          count: ruleCount,
          isEnabled: enhancedService.isFilterEnabled('SimSlotRuleService'),
          onToggle: (value) {
            final service = ref.read(enhancedCompositeFilterServiceProvider);
            if (value) {
              service.enableFilter('SimSlotRuleService');
            } else {
              service.disableFilter('SimSlotRuleService');
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
        ref.watch(localCountFilterServiceProvider);
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
        ref.watch(remoteNumberFilterServiceProvider);
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
        ref.watch(callFilterServiceProvider);
    final enhancedService = ref.watch(enhancedCompositeFilterServiceProvider);
    
    // 获取可用的SIM卡槽位
    // 使用实际获取的SIM卡信息
    final availableSimSlots = _simInfo.isNotEmpty
        ? List.generate(_simInfo.length, (index) => index)
        : isSupported ? [0, 1] : []; // 如果不支持或获取失败，使用默认值或空列表
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 全局通话过滤规则开关
        ExpansionTile(
          title: Text(AppLocalizations.of(context)!.callFilterRules),
          subtitle: Text(AppLocalizations.of(context)!.callFilterRulesDescription),
          leading: const Icon(Icons.call_end, color: Colors.red),
          children: [
            // 全局过滤器开关
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.enableCallFilter),
              subtitle: Text(AppLocalizations.of(context)!.enableCallFilterDescription),
              value: enhancedService.isFilterEnabled('CallFilterService'),
              onChanged: (value) async {
                if (value) {
                  await enhancedService.enableFilter('CallFilterService');
                } else {
                  await enhancedService.disableFilter('CallFilterService');
                }
                setState(() {});
              },
            ),
            
            // 全局规则配置
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
        ),
        
        // 按SIM卡槽位配置过滤器
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context)!.simSlotFilterConfiguration,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.simSlotFilterConfigurationDescription,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        
        // 为每个SIM卡槽位创建配置面板
        for (final simSlot in availableSimSlots)
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.sim_card, color: simSlot == 0 ? Colors.blue : Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        _simInfo.isNotEmpty && simSlot < _simInfo.length
                            ? '${AppLocalizations.of(context)!.simCard} ${simSlot + 1} (${_simInfo[simSlot].carrierName})'
                            : '${AppLocalizations.of(context)!.simCard} ${simSlot + 1}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // 为该SIM卡槽位配置各个过滤器
                  // 通话过滤器
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.callFilter),
                    subtitle: Text(AppLocalizations.of(context)!.callFilterDescription),
                    value: enhancedService.isFilterEnabledForSimSlot(simSlot, 'CallFilterService'),
                    onChanged: (value) async {
                      if (value) {
                        await enhancedService.enableFilterForSimSlot(simSlot, 'CallFilterService');
                      } else {
                        await enhancedService.disableFilterForSimSlot(simSlot, 'CallFilterService');
                      }
                      setState(() {});
                    },
                  ),
                  
                  // 本地计数过滤器
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.localCountFilter),
                    subtitle: Text(AppLocalizations.of(context)!.localCountFilterDescription),
                    value: enhancedService.isFilterEnabledForSimSlot(simSlot, 'LocalCountFilterService'),
                    onChanged: (value) async {
                      if (value) {
                        await enhancedService.enableFilterForSimSlot(simSlot, 'LocalCountFilterService');
                      } else {
                        await enhancedService.disableFilterForSimSlot(simSlot, 'LocalCountFilterService');
                      }
                      setState(() {});
                    },
                  ),
                  
                  // 远程号码过滤器
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.remoteNumberFilter),
                    subtitle: Text(AppLocalizations.of(context)!.remoteNumberFilterDescription),
                    value: enhancedService.isFilterEnabledForSimSlot(simSlot, 'RemoteNumberFilterService'),
                    onChanged: (value) async {
                      if (value) {
                        await enhancedService.enableFilterForSimSlot(simSlot, 'RemoteNumberFilterService');
                      } else {
                        await enhancedService.disableFilterForSimSlot(simSlot, 'RemoteNumberFilterService');
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  /// 构建时间拦截器开关
  Widget _buildTimeInterceptorSwitch() {
    final timeInterceptorService =
        ref.watch(timeInterceptorServiceProvider);
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