import 'package:flutter/material.dart';

import 'call_filter.dart';

class CallFilterSettingsPage extends StatefulWidget {
  final CallFilter callFilter;

  const CallFilterSettingsPage({super.key, required this.callFilter});

  @override
  CallFilterSettingsPageState createState() => CallFilterSettingsPageState();
}

class CallFilterSettingsPageState extends State<CallFilterSettingsPage> {
  late CallFilterConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.callFilter.config;
  }

  void _handleConfigChange(String key, bool value) {
    setState(() {
      switch (key) {
        // 如果拒绝所有号码，则直接返回 false
        case 'rejectAllNumbers':
          _config.rejectAllNumbers = value;
          break;
        // 检查号码是否在允许名单中
        case 'allowAllAllowedNumbers':
          _config.allowAllAllowedNumbers = value;
          break;
        // 检查号码是否在阻止名单中
        case 'allowBlockedNumbers':
          _config.allowBlockedNumbers = value;
          break;
        // 检查号码是否匹配白名单通配符
        case 'allowRegexWhitelistedPatterns':
          _config.allowRegexWhitelistedPatterns = value;
          break;
        // 检查号码是否在白名单中
        case 'allowAllWhitelistedNumbers':
          _config.allowAllWhitelistedNumbers = value;
          break;
        // 检查号码是否匹配黑名单通配符
        case 'allowRegexBlacklistedPatterns':
          _config.allowRegexBlacklistedPatterns = value;
          break;
        // 检查号码是否在黑名单中
        case 'allowAllBlacklistedNumbers':
          _config.allowAllBlacklistedNumbers = value;
          break;
      }
    });
  }

  void _saveConfig() {
    widget.callFilter.updateConfig(_config);
    widget.callFilter.saveConfig(); // 保存配置
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Filter Settings'),
      ),
      body: ListView(
        children: [
          _buildSwitchListTile(
            'Reject All Numbers',
            _config.rejectAllNumbers,
            (value) => _handleConfigChange('rejectAllNumbers', value),
          ),
          _buildSwitchListTile(
            'allow All Allowed Numbers',
            _config.allowAllAllowedNumbers,
            (value) => _handleConfigChange('allowAllAllowedNumbers', value),
          ),
          _buildSwitchListTile(
            'Allow Blocked Numbers',
            _config.allowBlockedNumbers,
            (value) => _handleConfigChange('allowBlockedNumbers', value),
          ),
          _buildSwitchListTile(
            'Allow Regex Whitelisted Patterns',
            _config.allowRegexWhitelistedPatterns,
            (value) =>
                _handleConfigChange('allowRegexWhitelistedPatterns', value),
          ),
          _buildSwitchListTile(
            'Allow All Whitelisted Numbers',
            _config.allowAllWhitelistedNumbers,
            (value) => _handleConfigChange('allowAllWhitelistedNumbers', value),
          ),
          _buildSwitchListTile(
            'Allow Regex Blacklisted Patterns',
            _config.allowRegexBlacklistedPatterns,
            (value) =>
                _handleConfigChange('allowRegexBlacklistedPatterns', value),
          ),
          _buildSwitchListTile(
            'Allow All Blacklisted Numbers',
            _config.allowAllBlacklistedNumbers,
            (value) => _handleConfigChange('allowAllBlacklistedNumbers', value),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveConfig,
              child: const Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(
      String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
