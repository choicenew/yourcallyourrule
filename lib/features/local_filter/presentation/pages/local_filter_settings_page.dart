import 'package:flutter/material.dart';

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_config.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 本地计数过滤器设置页面
/// 用于配置本地计数过滤器的相关参数
class LocalFilterSettingsPage extends StatefulWidget {
  final LocalCountFilterService localCountFilterService;
  final ConfigRepository configRepository;

  const LocalFilterSettingsPage({
    super.key,
    required this.localCountFilterService,
    required this.configRepository,
  });

  @override
  LocalFilterSettingsPageState createState() => LocalFilterSettingsPageState();
}

class LocalFilterSettingsPageState extends State<LocalFilterSettingsPage> {
  // 配置参数 - 与LocalCountFilterConfig保持一致
  bool _enableLocalCountFilter = true;
  int _countThreshold = 5;
  bool _rejectExceededNumbers = true;
  bool _allowNonExceededNumbers = false;
  bool _logAllLocalQueries = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// 加载设置
  Future<void> _loadSettings() async {
    // 直接从LocalCountFilterService获取配置
    final config = widget.localCountFilterService.localCountFilterConfig;
    setState(() {
      _enableLocalCountFilter = config.enableLocalCountFilter;
      _countThreshold = config.countThreshold;
      _rejectExceededNumbers = config.rejectExceededNumbers;
      _allowNonExceededNumbers = config.allowNonExceededNumbers;
      _logAllLocalQueries = config.logAllLocalQueries;
    });
  }

  /// 保存设置
  Future<void> _saveSettings() async {
    // 创建新的配置对象
    final newConfig = LocalCountFilterConfig(
      enableLocalCountFilter: _enableLocalCountFilter,
      countThreshold: _countThreshold,
      rejectExceededNumbers: _rejectExceededNumbers,
      allowNonExceededNumbers: _allowNonExceededNumbers,
      logAllLocalQueries: _logAllLocalQueries,
    );
    
    // 更新服务中的配置并保存
    await widget.localCountFilterService.updateConfig(newConfig);
    await widget.localCountFilterService.initialize(); // 重新初始化服务以应用新设置
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.localCountFilterSettings),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: AppLocalizations.of(context)!.saveSettings,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 使用提取的组件
          LocalFilterSettingsWidget(
            enableLocalCountFilter: _enableLocalCountFilter,
            countThreshold: _countThreshold,
            rejectExceededNumbers: _rejectExceededNumbers,
            allowNonExceededNumbers: _allowNonExceededNumbers,
            logAllLocalQueries: _logAllLocalQueries,
            onEnableLocalCountFilterChanged: (value) {
              setState(() {
                _enableLocalCountFilter = value;
              });
            },
            onCountThresholdChanged: (value) {
              setState(() {
                _countThreshold = value;
              });
            },
            onRejectExceededNumbersChanged: (value) {
              setState(() {
                _rejectExceededNumbers = value;
              });
            },
            onAllowNonExceededNumbersChanged: (value) {
              setState(() {
                _allowNonExceededNumbers = value;
              });
            },
            onLogAllLocalQueriesChanged: (value) {
              setState(() {
                _logAllLocalQueries = value;
              });
            },
          ),
        ],
      ),
    );
  }
}