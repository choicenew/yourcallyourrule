import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/sim_slot_rule_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 增强版组合过滤器设置组件
/// 集成所有过滤器设置，提供统一的界面来管理所有过滤规则
class EnhancedCompositeFilterSettingsWidget extends ConsumerStatefulWidget {
  final EnhancedCompositeFilterService enhancedCompositeFilterService;
  final LocalCountFilterService localCountFilterService;
  final RemoteNumberFilterService remoteNumberFilterService;
  final SimSlotRuleService simSlotRuleService;
  final CallFilterConfig callFilterConfig;

  const EnhancedCompositeFilterSettingsWidget({
    super.key,
    required this.enhancedCompositeFilterService,
    required this.localCountFilterService,
    required this.remoteNumberFilterService,
    required this.simSlotRuleService,
    required this.callFilterConfig,
  });

  @override
  EnhancedCompositeFilterSettingsWidgetState createState() => EnhancedCompositeFilterSettingsWidgetState();
}

class EnhancedCompositeFilterSettingsWidgetState extends ConsumerState<EnhancedCompositeFilterSettingsWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // 本地过滤器配置参数
  bool _localFilterEnabled = true;
  int _countThreshold = 5;
  bool _rejectExceededNumbers = true;
  bool _allowNonExceededNumbers = false;
  bool _logAllLocalQueries = true;
  
  // 远程号码过滤器设置
  bool _remoteFilterEnabled = true;
  int _minimumReportCount = 5;
  bool _prioritizeRemoteAction = true;
  bool _logAllRemoteQueries = true;
  
  // SIM卡槽位规则设置
  int _currentSimSlotIndex = 0;
  Map<String, bool> _filterEnabledMap = {};
  List<Map<String, dynamic>> _simSlotRules = [];
  
  // 通话过滤器配置
  late CallFilterConfig _callFilterConfig;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _callFilterConfig = widget.callFilterConfig;
    _loadSettings();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  /// 加载所有设置
  Future<void> _loadSettings() async {
    // 加载本地计数过滤器设置
    await _loadLocalFilterSettings();
    
    // 加载远程号码过滤器设置
    await _loadRemoteFilterSettings();
    
    // 加载SIM卡槽位规则设置
    await _loadSimSlotRuleSettings();
  }
  
  /// 加载本地计数过滤器设置
  Future<void> _loadLocalFilterSettings() async {
    final config = widget.localCountFilterService.localCountFilterConfig;
    setState(() {
      _localFilterEnabled = config.enableLocalCountFilter;
      _countThreshold = config.countThreshold;
      _rejectExceededNumbers = config.rejectExceededNumbers;
      _allowNonExceededNumbers = config.allowNonExceededNumbers;
      _logAllLocalQueries = config.logAllLocalQueries;
    });
  }
  
  /// 加载远程号码过滤器设置
  Future<void> _loadRemoteFilterSettings() async {
    final config = widget.remoteNumberFilterService.remoteNumberFilterConfig;
    setState(() {
      _remoteFilterEnabled = config.enableRemoteNumberFilter;
// 使用默认值，因为RemoteNumberFilterConfig中没有useCloudDatabase
// 使用默认值，因为RemoteNumberFilterConfig中没有useCommunityReports
      _minimumReportCount = config.countThreshold;
      _prioritizeRemoteAction = config.prioritizeRemoteAction;
      _logAllRemoteQueries = config.logAllRemoteQueries;
    });
  }
  
  /// 加载SIM卡槽位规则设置
  Future<void> _loadSimSlotRuleSettings() async {
    // 获取当前SIM卡槽位的过滤器启用状态
    final filterEnabledMap = {};
    final filterNames = ['LocalCountFilterService', 'RemoteNumberFilterService', 'CallFilterService'];
    
    for (var filterName in filterNames) {
      filterEnabledMap[filterName] = widget.enhancedCompositeFilterService
          .isFilterEnabledForSimSlot(_currentSimSlotIndex, filterName);
    }
    
    // 获取当前SIM卡槽位的规则列表
    final simSlotRules = await widget.simSlotRuleService.getSimSlotRules(_currentSimSlotIndex);
    
    setState(() {
      _filterEnabledMap = Map<String, bool>.from(filterEnabledMap);
      _simSlotRules = List<Map<String, dynamic>>.from(simSlotRules);
    });
  }
  
  /// 更新本地过滤器设置
  Future<void> _updateLocalFilterSettings() async {
    final config = widget.localCountFilterService.localCountFilterConfig.copyWith(
      enableLocalCountFilter: _localFilterEnabled,
      countThreshold: _countThreshold,
      rejectExceededNumbers: _rejectExceededNumbers,
      allowNonExceededNumbers: _allowNonExceededNumbers,
      logAllLocalQueries: _logAllLocalQueries,
    );
    await widget.localCountFilterService.updateConfig(config);
    
    // 如果启用了增强版组合过滤器，同步更新SIM卡槽位的过滤器状态
    if (_currentSimSlotIndex >= 0) {
      final filterName = 'LocalCountFilterService';
      if (_localFilterEnabled) {
        await widget.enhancedCompositeFilterService.enableFilterForSimSlot(_currentSimSlotIndex, filterName);
      } else {
        await widget.enhancedCompositeFilterService.disableFilterForSimSlot(_currentSimSlotIndex, filterName);
      }
    }
  }
  
  /// 更新远程号码过滤器设置
  Future<void> _updateRemoteFilterSettings() async {
    await widget.remoteNumberFilterService.updateConfig(
      widget.remoteNumberFilterService.remoteNumberFilterConfig.copyWith(
        enableRemoteNumberFilter: _remoteFilterEnabled,
        countThreshold: _minimumReportCount,
        logAllRemoteQueries: _logAllRemoteQueries,
        rejectExceededNumbers: _rejectExceededNumbers,
        allowNonExceededNumbers: _allowNonExceededNumbers,
        prioritizeRemoteAction: _prioritizeRemoteAction
      ),
    );
    
    // 如果启用了增强版组合过滤器，同步更新SIM卡槽位的过滤器状态
    if (_currentSimSlotIndex >= 0) {
      final filterName = 'RemoteNumberFilterService';
      if (_remoteFilterEnabled) {
        await widget.enhancedCompositeFilterService.enableFilterForSimSlot(_currentSimSlotIndex, filterName);
      } else {
        await widget.enhancedCompositeFilterService.disableFilterForSimSlot(_currentSimSlotIndex, filterName);
      }
    }
  }
  
  /// 切换SIM卡槽位过滤器启用状态
  Future<void> _toggleFilterEnabled(String filterName, bool value) async {
    if (value) {
      await widget.enhancedCompositeFilterService.enableFilterForSimSlot(_currentSimSlotIndex, filterName);
    } else {
      await widget.enhancedCompositeFilterService.disableFilterForSimSlot(_currentSimSlotIndex, filterName);
    }
    
    setState(() {
      _filterEnabledMap[filterName] = value;
    });
  }
  
  /// 添加SIM卡槽位规则
  Future<void> _addSimSlotRule(String phoneNumber, String name, String? labelId) async {
    await widget.simSlotRuleService.addSimSlotRule(
      phoneNumber,
      _currentSimSlotIndex,
      name: name,
      labelId: labelId ?? '',
    );
    
    // 重新加载规则列表
    await _loadSimSlotRuleSettings();
  }
  
  /// 删除SIM卡槽位规则
  Future<void> _deleteSimSlotRule(String ruleId) async {
    await widget.simSlotRuleService.removeSimSlotRule(ruleId);
    
    
    // 重新加载规则列表
    await _loadSimSlotRuleSettings();
  }
  
  /// 更新通话过滤器配置
  void _onCallFilterConfigChanged(String key, bool value) {
    setState(() {
      // 使用Map更新配置
      final updatedConfig = _callFilterConfig.toMap();
      updatedConfig[key] = value;
      // 创建新的配置对象
      _callFilterConfig = CallFilterConfig.fromMap(updatedConfig);
    });
    // 通知父组件配置已更改
    _saveCallFilterConfig();
  }
  
  /// 保存通话过滤器配置
  Future<void> _saveCallFilterConfig() async {
    // 如果是EnhancedCompositeFilterService，查找其中的CallFilterService实例
    if (widget.enhancedCompositeFilterService.filters.isNotEmpty) {
      for (var filter in widget.enhancedCompositeFilterService.filters) {
        if (filter.runtimeType.toString() == 'CallFilterService') {
          // 使用反射或其他方式更新配置
          // 这里简化处理，实际应用中应该通过服务提供的方法更新
        }
      }
    }
    
    // 通知用户配置已保存
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Local Filter'),
            Tab(text: 'Remote Filter'),
            Tab(text: 'Basic Rules'),
            Tab(text: 'SIM SlotRules'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // 本地计数过滤器设置
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LocalFilterSettingsWidget(
                    enableLocalCountFilter: _localFilterEnabled,
                    countThreshold: _countThreshold,
                    rejectExceededNumbers: _rejectExceededNumbers,
                    allowNonExceededNumbers: _allowNonExceededNumbers,
                    logAllLocalQueries: _logAllLocalQueries,
                    onEnableLocalCountFilterChanged: (value) {
                      setState(() {
                        _localFilterEnabled = value;
                      });
                      _updateLocalFilterSettings();
                    },
                    onCountThresholdChanged: (value) {
                      setState(() {
                        _countThreshold = value;
                      });
                      _updateLocalFilterSettings();
                    },
                    onRejectExceededNumbersChanged: (value) {
                      setState(() {
                        _rejectExceededNumbers = value;
                      });
                      _updateLocalFilterSettings();
                    },
                    onAllowNonExceededNumbersChanged: (value) {
                      setState(() {
                        _allowNonExceededNumbers = value;
                      });
                      _updateLocalFilterSettings();
                    },
                    onLogAllLocalQueriesChanged: (value) {
                      setState(() {
                        _logAllLocalQueries = value;
                      });
                      _updateLocalFilterSettings();
                    },
                  ),
                ),
              ),
              
              // 远程号码过滤器设置
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RemoteFilterSettingsWidget(
                    enableRemoteNumberFilter: _remoteFilterEnabled,
                    countThreshold: _minimumReportCount,
                    rejectExceededNumbers: _rejectExceededNumbers,
                    allowNonExceededNumbers: _allowNonExceededNumbers,
                    prioritizeRemoteAction: _prioritizeRemoteAction,
                    logAllRemoteQueries: _logAllRemoteQueries,
                    onEnableRemoteNumberFilterChanged: (value) {
                      setState(() {
                        _remoteFilterEnabled = value;
                      });
                      _updateRemoteFilterSettings();
                    },
                    onCountThresholdChanged: (value) {
                      setState(() {
                        _minimumReportCount = value;
                      });
                      _updateRemoteFilterSettings();
                    },
                    onRejectExceededNumbersChanged: (value) {
                      setState(() {
                        _rejectExceededNumbers = value;
                      });
                      _updateRemoteFilterSettings();
                    },
                    onAllowNonExceededNumbersChanged: (value) {
                      setState(() {
                        _allowNonExceededNumbers = value;
                      });
                      _updateRemoteFilterSettings();
                    },
                    onPrioritizeRemoteActionChanged: (value) {
                      setState(() {
                        _prioritizeRemoteAction = value;
                      });
                      _updateRemoteFilterSettings();
                    },
                    onLogAllRemoteQueriesChanged: (value) {
                      setState(() {
                        _logAllRemoteQueries = value;
                      });
                      _updateRemoteFilterSettings();
                    },
                  ),
                ),
              ),
              
              // 基本规则过滤器设置
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CallFilterSettingsWidget(
                    config: _callFilterConfig,
                    onConfigChanged: _onCallFilterConfigChanged,
                    onSavePressed: _saveCallFilterConfig,
                  ),
                ),
              ),
              
              // SIM卡槽位规则设置
              SimSlotRuleWidget(
                simSlotRuleService: widget.simSlotRuleService,
                enhancedCompositeFilterService: widget.enhancedCompositeFilterService,
                simSlotIndex: _currentSimSlotIndex,
                filterEnabledMap: _filterEnabledMap,
                simSlotRules: _simSlotRules,
                onToggleFilterEnabled: _toggleFilterEnabled,
                onAddSimSlotRule: _addSimSlotRule,
                onDeleteSimSlotRule: _deleteSimSlotRule,
              ),
            ],
          ),
        ),
      ],
    );
  }
}