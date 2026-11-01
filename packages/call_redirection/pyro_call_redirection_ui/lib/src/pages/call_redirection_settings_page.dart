import 'package:flutter/material.dart';

/// Call Redirection Settings & Configuration Screen.
class CallRedirectionSettingsPage extends StatefulWidget {
  const CallRedirectionSettingsPage({super.key});

  @override
  State<CallRedirectionSettingsPage> createState() => _CallRedirectionSettingsPageState();
}

class _CallRedirectionSettingsPageState extends State<CallRedirectionSettingsPage> {
  bool _enableRedirection = true;
  bool _enableWangiriProtection = true;
  bool _enablePremiumRateGuard = true;
  bool _carModeBypassEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Redirection Protection'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security_rounded, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Outbound Pre-Dial Protection',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Intercepts high-risk Wangiri callback scams and premium rate numbers before outbound dials reach the network.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    value: _enableRedirection,
                    title: const Text('Enable Call Redirection'),
                    subtitle: const Text('Requires ROLE_CALL_REDIRECTION role'),
                    onChanged: (val) {
                      setState(() => _enableRedirection = val);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SwitchListTile(
                  value: _enableWangiriProtection,
                  title: const Text('Wangiri Callback Scam Defense'),
                  subtitle: const Text('Warns when calling numbers that trigger one-ring scams'),
                  onChanged: _enableRedirection
                      ? (val) => setState(() => _enableWangiriProtection = val)
                      : null,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _enablePremiumRateGuard,
                  title: const Text('Premium Rate Number Guard'),
                  subtitle: const Text('Warns before dialing expensive toll-charge numbers'),
                  onChanged: _enableRedirection
                      ? (val) => setState(() => _enablePremiumRateGuard = val)
                      : null,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _carModeBypassEnabled,
                  title: const Text('Car Mode Ghost Call Guard'),
                  subtitle: const Text('Automatically bypasses holds while driving or in Android Auto'),
                  onChanged: _enableRedirection
                      ? (val) => setState(() => _carModeBypassEnabled = val)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
