import 'package:flutter/material.dart';
import 'package:pyro_call_redirection_driver/pyro_call_redirection_driver.dart';
import 'package:pyro_call_redirection_hub/pyro_call_redirection_hub.dart';
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'package:pyro_call_redirection_ui/pyro_call_redirection_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Mount Call Redirection suite and register driver
  CallRedirectionConnectors.ensureMounted(
    driverRegistrars: [
      (hub) {
        hub.registerRedirectionDriver(CallRedirectionDriver());
      },
    ],
  );

  runApp(const CallRedirectionExampleApp());
}

class CallRedirectionExampleApp extends StatelessWidget {
  const CallRedirectionExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Redirection Runner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final TextEditingController _numberController = TextEditingController(text: '+18885550199');
  RedirectionDecision? _lastDecision;
  bool _isEvaluating = false;

  Future<void> _evaluateTestCall() async {
    setState(() => _isEvaluating = true);

    final rawNumber = _numberController.text.trim();
    final call = OutgoingCallEntity(
      id: 'test_${DateTime.now().millisecondsSinceEpoch}',
      rawPhoneNumber: rawNumber,
      normalizedPhoneNumber: rawNumber.replaceAll(RegExp(r'\D'), ''),
      timestampMs: DateTime.now().millisecondsSinceEpoch,
      isInteractiveAllowed: true,
      isCarModeActive: false,
    );

    final decision = await CallRedirectionHub.instance.pipeline.evaluate(call);

    setState(() {
      _lastDecision = decision;
      _isEvaluating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Redirection Isolated Tester'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CallRedirectionSettingsPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAlignment: CrossAlignment.start,
                children: [
                  Text(
                    'Outbound Pre-Dial Simulator',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      labelText: 'Test Outbound Phone Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isEvaluating ? null : _evaluateTestCall,
                      icon: _isEvaluating
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.play_arrow_rounded),
                      label: const Text('Simulate Pre-Dial Evaluation'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_lastDecision != null) ...[
            Card(
              color: _lastDecision!.action == RedirectionAction.proceed
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.errorContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAlignment: CrossAlignment.start,
                  children: [
                    Text(
                      'Evaluation Result:',
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Action: ${_lastDecision!.action.name.toUpperCase()}'),
                    if (_lastDecision!.reason != null)
                      Text('Reason: ${_lastDecision!.reason!.name}'),
                    Text('Description: ${_lastDecision!.description}'),
                    Text('Evaluation Elapsed: ${_lastDecision!.evaluationTimeMs} ms'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => const HeldCallLogSheet(),
                );
              },
              icon: const Icon(Icons.list_alt_rounded),
              label: const Text('View Held Outbound Call Log Sheet'),
            ),
          ],
        ],
      ),
    );
  }
}
