import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通话过滤设置页面，用于配置通话过滤规则
/// 接受CallFilterInterface接口类型，支持CallFilterService和EnhancedCompositeFilterService
class CallFilterSettingsPage extends StatefulWidget {
  final CallFilterInterface callFilterService;

  const CallFilterSettingsPage({super.key, required this.callFilterService});

  @override
  CallFilterSettingsPageState createState() => CallFilterSettingsPageState();
}

class CallFilterSettingsPageState extends State<CallFilterSettingsPage> {
  late CallFilterConfig _config;

  @override
  void initState() {
    super.initState();
    // 获取配置
    // 由于callFilterService现在是接口类型，需要进行类型检查
    if (widget.callFilterService is CallFilterService) {
      _config = (widget.callFilterService as CallFilterService).callFilterConfig;
    } else if (widget.callFilterService is EnhancedCompositeFilterService) {
      // 如果是EnhancedCompositeFilterService，查找其中的CallFilterService实例
      final enhancedService = widget.callFilterService as EnhancedCompositeFilterService;
      
      // 遍历过滤器列表，查找CallFilterService实例
      bool foundCallFilterService = false;
      for (var filter in enhancedService.filters) {
        if (filter is CallFilterService) {
          // 找到CallFilterService实例后获取其配置
          _config = filter.callFilterConfig;
          foundCallFilterService = true;
          break;
        }
      }
      
      // 如果没有找到CallFilterService实例，使用默认配置
      if (!foundCallFilterService) {
        _config = CallFilterConfig();
      }
    } else {
      // 其他情况使用默认配置
      _config = CallFilterConfig();
    }
  }

  /// 处理配置变更
  void _handleConfigChange(String key, bool value) {
    setState(() {
      switch (key) {
        case 'rejectAllNumbers':
          _config = _config.copyWith(rejectAllNumbers: value);
          break;
        case 'allowAllAllowedNumbers':
          _config = _config.copyWith(allowAllAllowedNumbers: value);
          break;
        case 'allowRegexAllowRules':
          _config = _config.copyWith(allowRegexAllowRules: value);
          break;
        case 'allowBlockedNumbers':
          _config = _config.copyWith(allowBlockedNumbers: value);
          break;
        case 'allowAllAllowRules':
          _config = _config.copyWith(allowAllAllowRules: value);
          break;
        case 'allowRegexBlockRules':
          _config = _config.copyWith(allowRegexBlockRules: value);
          break;
        case 'allowAllBlockRules':
          _config = _config.copyWith(allowAllBlockRules: value);
          break;
        case 'allowSilenceRules':
          _config = _config.copyWith(allowSilenceRules: value);
          break;
        case 'allowNoneRules':
          _config = _config.copyWith(allowNoneRules: value);
          break;
      }
    });
  }

  /// 保存配置
  Future<void> _saveConfig() async {
    // 根据服务类型调用不同的更新方法
    if (widget.callFilterService is CallFilterService) {
      // 直接更新CallFilterService的配置
      await (widget.callFilterService as CallFilterService).updateConfig(_config);
    } else if (widget.callFilterService is EnhancedCompositeFilterService) {
      // 对于EnhancedCompositeFilterService，需要找到其中的CallFilterService实例
      final enhancedService = widget.callFilterService as EnhancedCompositeFilterService;
      
      // 遍历过滤器列表，查找CallFilterService实例
      for (var filter in enhancedService.filters) {
        if (filter is CallFilterService) {
          // 找到CallFilterService实例后更新其配置
          await filter.updateConfig(_config);
          break;
        }
      }
    }
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.callFilterSettings),
      ),
      body: ListView(
        children: [
          // 使用提取的组件
          CallFilterSettingsWidget(
            config: _config,
            onConfigChanged: _handleConfigChange,
            onSavePressed: _saveConfig,
          ),
        ],
      ),
    );
  }
}
