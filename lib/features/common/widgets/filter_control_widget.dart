import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_config.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/service/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_config.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_config.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 过滤器控制组件
/// 用于统一控制各种过滤服务的开关状态，支持按SIM卡配置
class FilterControlWidget extends StatefulWidget {
  final CallFilterService callFilterService;
  final LocalCountFilterService localCountFilterService;
  final RemoteNumberFilterService remoteNumberFilterService;
  final TimeInterceptorService timeInterceptorService;
  final EnhancedCompositeFilterService?
      enhancedCompositeFilterService; // 增强版组合过滤器服务，支持SIM卡配置

  const FilterControlWidget({
    super.key,
    required this.callFilterService,
    required this.localCountFilterService,
    required this.remoteNumberFilterService,
    required this.timeInterceptorService,
    this.enhancedCompositeFilterService, // 可选参数，如果提供则启用SIM卡配置功能
  });

  @override
  State<FilterControlWidget> createState() => _FilterControlWidgetState();
}

class _FilterControlWidgetState extends State<FilterControlWidget> {
  // 各服务的配置对象
  late CallFilterConfig callFilterConfig;
  late LocalCountFilterConfig localCountFilterConfig;
  late RemoteNumberFilterConfig remoteNumberFilterConfig;
  late TimeInterceptorConfig timeInterceptorConfig;

  // SIM卡相关配置
  List<SimInfo> _availableSimSlots = [];
  int _selectedSimSlotIndex = -1; // -1表示全局设置
  bool _supportSimSlotConfig = false; // 是否支持SIM卡配置
  Map<int, Map<String, bool>> _simSlotFilterConfigMap = {}; // 每个SIM卡的过滤器配置

  @override
  void initState() {
    super.initState();
    // 初始化配置
    callFilterConfig = widget.callFilterService.callFilterConfig;
    localCountFilterConfig =
        widget.localCountFilterService.localCountFilterConfig;
    remoteNumberFilterConfig =
        widget.remoteNumberFilterService.remoteNumberFilterConfig;
    timeInterceptorConfig = widget.timeInterceptorService.config;

    // 检查是否支持SIM卡配置
    _supportSimSlotConfig = widget.enhancedCompositeFilterService != null;

    if (_supportSimSlotConfig) {
      _loadSimSlots();
      _loadSimSlotFilterConfig();
    }
  }

  /// 加载SIM卡槽位信息
  Future<void> _loadSimSlots() async {
    // 模拟获取SIM卡槽位信息，实际应用中应该从设备获取
    setState(() {
      _availableSimSlots = [
        SimInfo(
            simSlotIndex: 0,
            displayName: AppLocalizations.of(context)?.simCard(1) ?? 'SIM 1'),
        SimInfo(
            simSlotIndex: 1,
            displayName: AppLocalizations.of(context)?.simCard(2) ?? 'SIM 2'),
      ];
    });
  }

  /// 加载SIM卡槽位过滤器配置
  Future<void> _loadSimSlotFilterConfig() async {
    if (widget.enhancedCompositeFilterService != null) {
      // 获取每个SIM卡槽位的过滤器配置
      final filterNames = [
        'LocalCountFilterService',
        'RemoteNumberFilterService',
        'CallFilterService'
      ];

      for (var simInfo in _availableSimSlots) {
        final simSlotIndex = simInfo.simSlotIndex!;
        if (!_simSlotFilterConfigMap.containsKey(simSlotIndex)) {
          _simSlotFilterConfigMap[simSlotIndex] = {};
        }

        for (var filterName in filterNames) {
          _simSlotFilterConfigMap[simSlotIndex]![filterName] = widget
              .enhancedCompositeFilterService!
              .isFilterEnabledForSimSlot(simSlotIndex, filterName);
        }
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
            AppLocalizations.of(context)!.filterControlPanelTitle),
        const SizedBox(height: 16),
        if (_supportSimSlotConfig) _buildSimSlotSelector(),
        const SizedBox(height: 16),
        _buildCallFilterSection(),
        const Divider(),
        _buildLocalCountFilterSection(),
        const Divider(),
        _buildRemoteNumberFilterSection(),
        const Divider(),
        _buildTimeInterceptorSection(),
        const SizedBox(height: 32),
        _buildExplanationCard(),
      ],
    );
  }

  /// 构建SIM卡选择器
  Widget _buildSimSlotSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.configureSimCardFilterRules,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.selectSimCard,
                border: const OutlineInputBorder(),
              ),
              value: _selectedSimSlotIndex,
              items: [
                DropdownMenuItem<int>(
                  value: -1,
                  child: Text(AppLocalizations.of(context)!.globalSettings),
                ),
                ..._availableSimSlots
                    .map((simInfo) => DropdownMenuItem<int>(
                          value: simInfo.simSlotIndex,
                          child: Text(simInfo.displayName ??
                              AppLocalizations.of(context)!.unassignedSIMCard),
                        ))
                    .toList(),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSimSlotIndex = value ?? -1;
                  // 切换SIM卡时重新加载对应的配置
                  _updateConfigForSelectedSim();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 根据选择的SIM卡更新配置
  void _updateConfigForSelectedSim() {
    if (_selectedSimSlotIndex == -1 || !_supportSimSlotConfig) {
      // 全局设置，使用默认配置
      callFilterConfig = widget.callFilterService.callFilterConfig;
      localCountFilterConfig =
          widget.localCountFilterService.localCountFilterConfig;
      remoteNumberFilterConfig =
          widget.remoteNumberFilterService.remoteNumberFilterConfig;
    } else {
      // 特定SIM卡设置，暂时仍使用全局配置，但UI上显示为该SIM卡的配置
      // 实际应用中应该从EnhancedCompositeFilterService获取特定SIM卡的配置
      callFilterConfig = widget.callFilterService.callFilterConfig;
      localCountFilterConfig =
          widget.localCountFilterService.localCountFilterConfig;
      remoteNumberFilterConfig =
          widget.remoteNumberFilterService.remoteNumberFilterConfig;
    }
    setState(() {});
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  /// 构建基本规则过滤部分
  Widget _buildCallFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(AppLocalizations.of(context)!.basicRuleFiltering),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectAllCalls),
          subtitle:
              Text(AppLocalizations.of(context)!.rejectAllCallsDescription),
          value: callFilterConfig.rejectAllNumbers,
          onChanged: (value) {
            setState(() {
              callFilterConfig.rejectAllNumbers = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllowedNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowAllowedNumbersDesc),
          value: callFilterConfig.allowAllAllowedNumbers,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowAllAllowedNumbers = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowRegexAllowRules),
          subtitle: Text(
              AppLocalizations.of(context)!.allowRegexAllowRulesDescription),
          value: callFilterConfig.allowRegexAllowRules,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowRegexAllowRules = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowBlockedNumbers),
          subtitle: Text(AppLocalizations.of(context)!.allowBlockedNumbersDesc),
          value: callFilterConfig.allowBlockedNumbers,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowBlockedNumbers = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllAllowRules),
          subtitle: Text(
             AppLocalizations.of(context)!.allowAllAllowRulesDesc),
          value: callFilterConfig.allowAllAllowRules,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowAllAllowRules = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowRegexBlockRules),
          subtitle: Text(
              AppLocalizations.of(context)!.allowRegexBlockRulesDescription),
          value: callFilterConfig.allowRegexBlockRules,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowRegexBlockRules = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowAllBlockRules),
          subtitle: Text(AppLocalizations.of(context)!.allowAllBlockRulesDesc),
          value: callFilterConfig.allowAllBlockRules,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowAllBlockRules = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableMuteRules),
          subtitle: Text(AppLocalizations.of(context)!.enableMuteRulesDesc),
          value: callFilterConfig.allowSilenceRules,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowSilenceRules = value;
              _updateCallFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableNoneActionRules),
          subtitle: Text(AppLocalizations.of(context)!.enableNoneActionRulesDesc),
          value: callFilterConfig.allowNoneRules,
          onChanged: (value) {
            setState(() {
              callFilterConfig.allowNoneRules = value;
              _updateCallFilterConfig();
            });
          },
        ),
      ],
    );
  }

  /// 构建本地计数过滤部分
  Widget _buildLocalCountFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(
            AppLocalizations.of(context)!.localCountFiltering),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableLocalCountFilter),
          subtitle: Text(
              AppLocalizations.of(context)!.enableLocalCountFilterDescription),
          value: localCountFilterConfig.enableLocalCountFilter,
          onChanged: (value) {
            setState(() {
              localCountFilterConfig.enableLocalCountFilter = value;
              _updateLocalCountFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
          subtitle: Text(
              AppLocalizations.of(context)!.rejectExceededNumbersDescription),
          value: localCountFilterConfig.rejectExceededNumbers,
          onChanged: (value) {
            setState(() {
              localCountFilterConfig.rejectExceededNumbers = value;
              _updateLocalCountFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.allowNonExceededNumbers),
          subtitle: Text(
              AppLocalizations.of(context)!.allowNonExceededNumbersDescription),
          value: localCountFilterConfig.allowNonExceededNumbers,
          onChanged: (value) {
            setState(() {
              localCountFilterConfig.allowNonExceededNumbers = value;
              _updateLocalCountFilterConfig();
            });
          },
        ),
      ],
    );
  }

  /// 构建远程号码过滤部分
  Widget _buildRemoteNumberFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(
            AppLocalizations.of(context)!.remoteNumberFiltering),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableRemoteNumberFilter),
          subtitle: Text(AppLocalizations.of(context)!
              .enableRemoteNumberFilterDescription),
          value: remoteNumberFilterConfig.enableRemoteNumberFilter,
          onChanged: (value) {
            setState(() {
              remoteNumberFilterConfig.enableRemoteNumberFilter = value;
              _updateRemoteNumberFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.rejectExceededNumbers),
          subtitle: Text(
              AppLocalizations.of(context)!.rejectExceededNumbersDescription),
          value: remoteNumberFilterConfig.rejectExceededNumbers,
          onChanged: (value) {
            setState(() {
              remoteNumberFilterConfig.rejectExceededNumbers = value;
              _updateRemoteNumberFilterConfig();
            });
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.prioritizeRemoteAction),
          subtitle: Text(
              AppLocalizations.of(context)!.prioritizeRemoteActionDescription),
          value: remoteNumberFilterConfig.prioritizeRemoteAction,
          onChanged: (value) {
            setState(() {
              remoteNumberFilterConfig.prioritizeRemoteAction = value;
              _updateRemoteNumberFilterConfig();
            });
          },
        ),
      ],
    );
  }

  /// 构建时间拦截器部分
  Widget _buildTimeInterceptorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubSectionTitle(AppLocalizations.of(context)!.timeInterceptor),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableTimeInterception),
          subtitle: Text(
              AppLocalizations.of(context)!.enableTimeInterceptionDescription),
          value: timeInterceptorConfig.shouldIntercept,
          onChanged: (value) {
            setState(() {
              timeInterceptorConfig.shouldIntercept = value;
              _updateTimeInterceptorConfig();
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Text(
                  '${AppLocalizations.of(context)!.interceptionTimeInterval}: '),
              Text(
                  '${timeInterceptorConfig.duration.inMinutes} ${AppLocalizations.of(context)!.minutes}'),
            ],
          ),
        ),
        Slider(
          value: timeInterceptorConfig.duration.inMinutes.toDouble(),
          min: 5,
          max: 60,
          divisions: 11,
          label:
              '${timeInterceptorConfig.duration.inMinutes} ${AppLocalizations.of(context)!.minutes}',
          onChanged: (value) {
            setState(() {
              timeInterceptorConfig = timeInterceptorConfig.copyWith(
                duration: Duration(minutes: value.round()),
              );
              _updateTimeInterceptorConfig();
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildExplanationCard() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.filterExplanation,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.basicRuleFilteringExplanation),
            Text(AppLocalizations.of(context)!.localCountFilteringExplanation),
            Text(
                AppLocalizations.of(context)!.remoteNumberFilteringExplanation),
            Text(AppLocalizations.of(context)!.timeInterceptorExplanation),
            if (_supportSimSlotConfig)
              Text(AppLocalizations.of(context)!
                  .simCardConfigurationExplanation),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.filterPriorityNote),
          ],
        ),
      ),
    );
  }

  // 更新各配置并保存
  void _updateCallFilterConfig() async {
    if (_selectedSimSlotIndex == -1 || !_supportSimSlotConfig) {
      // 更新全局配置
      await widget.callFilterService.updateConfig(callFilterConfig);
    } else if (_supportSimSlotConfig &&
        widget.enhancedCompositeFilterService != null) {
      // 更新特定SIM卡的配置
      const filterName = 'CallFilterService';

      // 根据配置更新SIM卡特定的过滤器设置
      // 1. 拒绝所有来电
      if (callFilterConfig.rejectAllNumbers) {
        await widget.enhancedCompositeFilterService!
            .enableFilterForSimSlot(_selectedSimSlotIndex, filterName);
      } else {
        await widget.enhancedCompositeFilterService!
            .disableFilterForSimSlot(_selectedSimSlotIndex, filterName);
      }

      // 2. 更新其他基本规则配置
      // 注意：这里我们假设CallFilterService有一个updateConfigForSimSlot方法
      // 如果没有，你需要在CallFilterService中实现它
      // await widget.callFilterService.updateConfigForSimSlot(_selectedSimSlotIndex, callFilterConfig);

      // 更新本地缓存的配置
      if (!_simSlotFilterConfigMap.containsKey(_selectedSimSlotIndex)) {
        _simSlotFilterConfigMap[_selectedSimSlotIndex] = {};
      }
      _simSlotFilterConfigMap[_selectedSimSlotIndex]![filterName] =
          callFilterConfig.rejectAllNumbers;

      setState(() {});
    }
  }

  void _updateLocalCountFilterConfig() async {
    if (_selectedSimSlotIndex == -1 || !_supportSimSlotConfig) {
      // 更新全局配置
      await widget.localCountFilterService.updateConfig(localCountFilterConfig);
    } else if (_supportSimSlotConfig &&
        widget.enhancedCompositeFilterService != null) {
      // 更新特定SIM卡的配置
      const filterName = 'LocalCountFilterService';

      // 根据配置更新SIM卡特定的过滤器设置
      if (localCountFilterConfig.enableLocalCountFilter) {
        await widget.enhancedCompositeFilterService!
            .enableFilterForSimSlot(_selectedSimSlotIndex, filterName);
      } else {
        await widget.enhancedCompositeFilterService!
            .disableFilterForSimSlot(_selectedSimSlotIndex, filterName);
      }

      // 更新其他本地计数过滤器配置
      // 注意：这里我们假设LocalCountFilterService有一个updateConfigForSimSlot方法
      // 如果没有，你需要在LocalCountFilterService中实现它
      // await widget.localCountFilterService.updateConfigForSimSlot(_selectedSimSlotIndex, localCountFilterConfig);

      // 更新本地缓存的配置
      if (!_simSlotFilterConfigMap.containsKey(_selectedSimSlotIndex)) {
        _simSlotFilterConfigMap[_selectedSimSlotIndex] = {};
      }
      _simSlotFilterConfigMap[_selectedSimSlotIndex]![filterName] =
          localCountFilterConfig.enableLocalCountFilter;

      setState(() {});
    }
  }

  void _updateRemoteNumberFilterConfig() async {
    if (_selectedSimSlotIndex == -1 || !_supportSimSlotConfig) {
      // 更新全局配置
      await widget.remoteNumberFilterService
          .updateConfig(remoteNumberFilterConfig);
    } else if (_supportSimSlotConfig &&
        widget.enhancedCompositeFilterService != null) {
      // 更新特定SIM卡的配置
      const filterName = 'RemoteNumberFilterService';

      // 根据配置更新SIM卡特定的过滤器设置
      if (remoteNumberFilterConfig.enableRemoteNumberFilter) {
        await widget.enhancedCompositeFilterService!
            .enableFilterForSimSlot(_selectedSimSlotIndex, filterName);
      } else {
        await widget.enhancedCompositeFilterService!
            .disableFilterForSimSlot(_selectedSimSlotIndex, filterName);
      }

      // 更新其他远程号码过滤器配置
      // 注意：这里我们假设RemoteNumberFilterService有一个updateConfigForSimSlot方法
      // 如果没有，你需要在RemoteNumberFilterService中实现它
      // await widget.remoteNumberFilterService.updateConfigForSimSlot(_selectedSimSlotIndex, remoteNumberFilterConfig);

      // 更新本地缓存的配置
      if (!_simSlotFilterConfigMap.containsKey(_selectedSimSlotIndex)) {
        _simSlotFilterConfigMap[_selectedSimSlotIndex] = {};
      }
      _simSlotFilterConfigMap[_selectedSimSlotIndex]![filterName] =
          remoteNumberFilterConfig.enableRemoteNumberFilter;

      setState(() {});
    }
  }

  void _updateTimeInterceptorConfig() async {
    // 时间拦截器暂不支持SIM卡特定配置
    await widget.timeInterceptorService.updateConfig(
      timeInterceptorConfig.duration,
      timeInterceptorConfig.shouldIntercept,
    );
  }
}
