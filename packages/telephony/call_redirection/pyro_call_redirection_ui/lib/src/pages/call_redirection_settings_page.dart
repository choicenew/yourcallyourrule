import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/call_redirection_settings_provider.dart';

/// Full settings page for Outbound Anti-Scam Call Redirection using Riverpod 3.0
class CallRedirectionSettingsPage extends ConsumerStatefulWidget {
  const CallRedirectionSettingsPage({super.key});

  @override
  ConsumerState<CallRedirectionSettingsPage> createState() => _CallRedirectionSettingsPageState();
}

class _CallRedirectionSettingsPageState extends ConsumerState<CallRedirectionSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(callRedirectionSettingsProvider);
    final notifier = ref.read(callRedirectionSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outbound Call Anti-Scam Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Enable Outbound Call Protection'),
                  subtitle: const Text('Screen high-cost and fraud numbers before dialing out'),
                  value: settings.enableRedirection,
                  onChanged: notifier.toggleRedirection,
                ),
                SwitchListTile(
                  title: const Text('Show "Call Anyway" Confirmation'),
                  subtitle: const Text('Prompt confirmation banner for suspicious outgoing calls'),
                  value: settings.enableConfirmationDialog,
                  onChanged: notifier.toggleConfirmationDialog,
                ),
                SwitchListTile(
                  title: const Text('Auto-Block High Risk Fraud Outbound'),
                  subtitle: const Text('Automatically cancel calls to verified fraud numbers'),
                  value: settings.enableAutoBlockHighRisk,
                  onChanged: notifier.toggleAutoBlockHighRisk,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
