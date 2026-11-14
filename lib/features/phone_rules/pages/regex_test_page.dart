import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/phone_rules/services/regex_service.dart';

class RegexTestPage extends ConsumerStatefulWidget {
  const RegexTestPage({super.key});

  @override
  ConsumerState<RegexTestPage> createState() => _RegexTestPageState();
}

class _RegexTestPageState extends ConsumerState<RegexTestPage> {
  final _patternController = TextEditingController();
  final _testInputController = TextEditingController();
  bool _isMatch = false;
  bool _hasTested = false;

  @override
  void dispose() {
    _patternController.dispose();
    _testInputController.dispose();
    super.dispose();
  }

  void _testRegex() {
    final pattern = _patternController.text;
    final input = _testInputController.text;

    if (pattern.isEmpty) return;

    final regexService = ref.read(regexServiceProvider);
    bool match = false;
    if (regexService.isValidRegex(pattern)) {
      match = RegExp(pattern).hasMatch(input);
    }

    setState(() {
      _isMatch = match;
      _hasTested = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regex Tester'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _patternController,
              decoration: const InputDecoration(
                labelText: 'Regex Pattern',
                hintText: r'e.g. ^1[3-9]\d{9}$',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _testInputController,
              decoration: const InputDecoration(
                labelText: 'Test Input',
                hintText: 'e.g. 13800138000',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _testRegex,
              child: const Text('Test Regex'),
            ),
            const SizedBox(height: 16),
            if (_hasTested) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isMatch ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _isMatch ? Colors.green : Colors.red),
                ),
                child: Text(
                  _isMatch ? 'MATCHED' : 'NOT MATCHED',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isMatch ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 14),
            const AdsInlineBanner(),
            const SizedBox(height: 14),
            const AdsInlineBanner(),
          ],
        ),
      ),
    );
  }
}
