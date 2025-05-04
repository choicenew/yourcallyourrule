import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';

/// 通话过滤设置页面，用于配置通话过滤规则
class CallFilterSettingsPage extends StatefulWidget {
  final CallFilterService callFilterService;

  const CallFilterSettingsPage({super.key, required this.callFilterService});

  @override
  CallFilterSettingsPageState createState() => CallFilterSettingsPageState();
}

class CallFilterSettingsPageState extends State<CallFilterSettingsPage> {
  late CallFilterConfig _config;

  @override
  void initState() {
    super.initState();
    // 修改第22行 config → callFilterConfig
    _config = widget.callFilterService.callFilterConfig;
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
        case 'allowBlockedNumbers':
          _config = _config.copyWith(allowBlockedNumbers: value);
          break;
        case 'allowRegexAllowRules': // 修改配置项名称
          _config = _config.copyWith(allowRegexAllowRules: value);
          break;
        case 'allowAllWhitelistedNumbers':
          _config = _config.copyWith(allowAllWhitelistedNumbers: value);
          break;
        case 'allowRegexBlockRules': // 修改配置项名称
          _config = _config.copyWith(allowRegexBlockRules: value);
          break;
        case 'allowAllBlacklistedNumbers':
          _config = _config.copyWith(allowAllBlacklistedNumbers: value);
          break;
      }
    });
  }

  /// 保存配置
  Future<void> _saveConfig() async {
    await widget.callFilterService.updateConfig(_config);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('设置已保存')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通话过滤设置'),
      ),
      body: ListView(
        children: [
          _buildSwitchListTile(
            '拒绝所有号码',
            '启用后将拒绝所有来电',
            _config.rejectAllNumbers,
            (value) => _handleConfigChange('rejectAllNumbers', value),
          ),
          _buildSwitchListTile(
            '允许所有已允许的号码',
            '允许来自允许名单中的号码',
            _config.allowAllAllowedNumbers,
            (value) => _handleConfigChange('allowAllAllowedNumbers', value),
          ),
          _buildSwitchListTile(
            '允许已阻止的号码',
            '允许来自阻止名单中的号码',
            _config.allowBlockedNumbers,
            (value) => _handleConfigChange('allowBlockedNumbers', value),
          ),
          _buildSwitchListTile(
            '允许匹配允许规则的正则表达式',
            '启用正则表达式匹配允许规则',
            _config.allowRegexAllowRules,
            (value) => _handleConfigChange('allowRegexAllowRules', value),
          ),
          _buildSwitchListTile(
            '允许所有白名单号码',
            '允许来自白名单中的号码',
            _config.allowAllWhitelistedNumbers,
            (value) => _handleConfigChange('allowAllWhitelistedNumbers', value),
          ),
          _buildSwitchListTile(
            '允许匹配阻止规则的正则表达式', // 更新描述
            '启用正则表达式匹配阻止规则',
            _config.allowRegexBlockRules,
            (value) => _handleConfigChange('allowRegexBlockRules', value),
          ),
          _buildSwitchListTile(
            '允许所有黑名单号码',
            '允许来自黑名单中的号码',
            _config.allowAllBlacklistedNumbers,
            (value) => _handleConfigChange('allowAllBlacklistedNumbers', value),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveConfig,
              child: const Text('保存设置'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
