import 'package:material_ui/material_ui.dart';
import 'package:pyro_call_control_hub/pyro_call_control_hub.dart';
import '../widgets/call_action_config_tile.dart';

/// Settings page for tuning Call Control execution preferences.
class CallControlSettingsPage extends StatefulWidget {
  const CallControlSettingsPage({super.key});

  @override
  State<CallControlSettingsPage> createState() => _CallControlSettingsPageState();
}

class _CallControlSettingsPageState extends State<CallControlSettingsPage> {
  CallActionType _selectedAction = CallActionType.reject;
  double _delayMs = 1000.0;
  bool _enableMicMuteProtection = true;

  @override
  void initState() {
    super.initState();
    _delayMs = CallControlHub.instance.defaultHangupDelayMs.toDouble();
    _enableMicMuteProtection = CallControlHub.instance.enableMicMuteProtection;
  }

  void _onDelayChanged(double value) {
    setState(() {
      _delayMs = value;
    });
    CallControlHub.instance.defaultHangupDelayMs = value.toInt();
  }

  void _onMicMuteToggle(bool value) {
    setState(() {
      _enableMicMuteProtection = value;
    });
    CallControlHub.instance.enableMicMuteProtection = value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('通话拦截动作设置 (Call Control)'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            '拦截动作策略设置',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...CallActionType.values.map((action) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CallActionConfigTile(
                actionType: action,
                isSelected: _selectedAction == action,
                onTap: (selected) {
                  setState(() {
                    _selectedAction = selected;
                  });
                },
              ),
            );
          }),
          const Divider(height: 32),
          Text(
            '秒接秒挂 (Answer-then-Hangup) 高级参数',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: colorScheme.surfaceContainerHighest.withAlpha(80),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '接通后挂断延迟',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${_delayMs.toInt()} ms',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _delayMs,
                    min: 500,
                    max: 3000,
                    divisions: 25,
                    label: '${_delayMs.toInt()} ms',
                    onChanged: _onDelayChanged,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('背景音闭麦保护 (Mic Mute Guard)'),
                    subtitle: const Text('接通瞬间自动关闭麦克风，挂断后恢复，100%防止泄漏周围环境隐私声纹'),
                    value: _enableMicMuteProtection,
                    onChanged: _onMicMuteToggle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
