import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/call_redirection_settings_provider.dart';

/// Full settings page for Outbound Anti-Scam Call Redirection using Riverpod 3.0
class CallRedirectionSettingsPage extends ConsumerStatefulWidget {
  final Widget? outboundLabelSelectionWidget;
  const CallRedirectionSettingsPage({super.key, this.outboundLabelSelectionWidget});

  @override
  ConsumerState<CallRedirectionSettingsPage> createState() => _CallRedirectionSettingsPageState();
}

class _CallRedirectionSettingsPageState extends ConsumerState<CallRedirectionSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(callRedirectionSettingsProvider);
    final notifier = ref.read(callRedirectionSettingsProvider.notifier);
    final isZh = Localizations.localeOf(context).languageCode.toLowerCase().startsWith('zh');

    return Scaffold(
      appBar: AppBar(
        title: Text(isZh ? '呼出防诈重定向与确认' : 'Outbound Call Anti-Scam Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(isZh ? '开启呼出防诈保护' : 'Enable Outbound Call Protection'),
                  subtitle: Text(isZh ? '在拨出号码前识别高额扣费及涉诈高危号码' : 'Screen high-cost and fraud numbers before dialing out'),
                  value: settings.enableRedirection,
                  onChanged: notifier.toggleRedirection,
                ),
                SwitchListTile(
                  title: Text(isZh ? '显示“仍要呼叫”确认弹窗' : 'Show "Call Anyway" Confirmation'),
                  subtitle: Text(isZh ? '针对可疑或风险外拨号码弹出二次确认横幅' : 'Prompt confirmation banner for suspicious outgoing calls'),
                  value: settings.enableConfirmationDialog,
                  onChanged: notifier.toggleConfirmationDialog,
                ),
                SwitchListTile(
                  title: Text(isZh ? '自动拦截高危涉诈外呼' : 'Auto-Block High Risk Fraud Outbound'),
                  subtitle: Text(isZh ? '对经核实的高危诈骗号码直接取消呼叫' : 'Automatically cancel calls to verified fraud numbers'),
                  value: settings.enableAutoBlockHighRisk,
                  onChanged: notifier.toggleAutoBlockHighRisk,
                ),
              ],
            ),
          ),
          if (widget.outboundLabelSelectionWidget != null) ...[
            const SizedBox(height: 16),
            widget.outboundLabelSelectionWidget!,
          ],
        ],
      ),
    );
  }
}
