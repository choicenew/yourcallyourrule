import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'core/js_execution_service.dart';
import 'core/native_request_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZTest POC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // JsExecutionService will be re-initialized in initState to accept callback
  late JsExecutionService _jsService;
  NativeRequestChannel? _requestChannel;
  Map<String, dynamic>? _result; // Store the latest result

  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _urlController = TextEditingController(
    text:
        "https://raw.githubusercontent.com/haygcao/test/main/slicklyHK%20TW%20MO%20html.js",
  );

  @override
  void initState() {
    super.initState();
    // Initialize services
    _jsService = JsExecutionService(onLog: _log);
    _initServices();
  }

  void _log(String message) {
    setState(() {
      _logs.add(
        "[${DateTime.now().toIso8601String().split('T')[1].split('.')[0]}] $message",
      );
    });
    // Auto scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _initServices() async {
    _log("Initializing JS Service...");
    await _jsService.init();

    // REGISTER PLUGIN RESULT LISTENER
    // This listens for 'PluginResultChannel' calls from JS
    // (Note: registerHandler is now used below)

    String userAgent = await InAppWebViewController.getDefaultUserAgent();
    _log("System User Agent: $userAgent");

    _requestChannel = NativeRequestChannel(
      _jsService,
      defaultUserAgent: userAgent,
      onLog: _log, // Pass log callback
    );
    _requestChannel?.register();

    // Register Result Channel on the JS Service (which hopefully handles the webview registration)
    // If JsExecutionService doesn't have `registerHandler`, I'll need to add it.
    _jsService.registerHandler('PluginResultChannel', (args) {
      _log("🎯 Received Result: $args");
      if (args.isNotEmpty) {
        try {
          // quick and dirty parsing for POC if header import is missing
          // but `dart:convert` is core. I'll add the import in the next step.
          // For now just storing to state to trigger rebuild
          setState(() {
            // Assuming args[0] is the JSON string
            // We will parse it in the next step when we add imports.
            // For now, let's just create a dummy map to prove UI works if string matches
            final str = args[0].toString();
            try {
              // Try JSON decode first if valid JSON string
              final parsed = jsonDecode(str);
              _result = parsed;
            } catch (_) {
              // Fallback to manual string check if decode fails (though new plugin sends pure JSON)
              if (str.contains('block')) {
                _result = {
                  'action': 'block',
                  'predefinedLabel': 'Fraud',
                  'sourceLabel': 'Test Fallback',
                  'count': 1,
                };
              } else {
                _result = {
                  'action': 'allow',
                  'predefinedLabel': 'Safe',
                  'sourceLabel': 'Test Fallback',
                  'count': 0,
                };
              }
            }
          });
        } catch (e) {
          _log("Error: $e");
        }
      }
      return {"status": "ok"};
    });

    _log("Services Ready.");
  }

  Future<void> _injectMockPlugin(String pluginId) async {
    // Define a mock plugin
    final script =
        """
      window.plugin['$pluginId'] = {
          handleResponse: function(data) {
              console.log('JS Plugin [$pluginId] Received Data: ' + JSON.stringify(data));
          },
          runTask: function(url) {
              console.log('JS Plugin [$pluginId] requesting: ' + url);
              window.flutter_inappwebview.callHandler('RequestChannel', {
                  url: url,
                  pluginId: '$pluginId',
                  phoneRequestId: 'req_'+Date.now()
              });
          }
      };
      console.log('Mock Plugin [$pluginId] Injected.');
    """;
    await _jsService.evaluate(script);
  }

  Future<void> _loadRealPluginFromUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      _log("Error: Plugin URL is empty.");
      return;
    }

    try {
      _log("Downloading plugin from: $url");
      // Use the existing dio instance from NativeRequestChannel or create a new one.
      // Since NativeRequestChannel owns Dio, we can create a simple temporary one or access it if we made it public.
      // Let's create a temporary one for simplicity.
      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        final scriptContent = response.data.toString();
        _log(
          "Plugin Downloaded (${scriptContent.length} bytes). Evaluating...",
        );
        final result = await _jsService.evaluate(scriptContent);
        _log("Evaluated. Result: $result");
        // Note: flutter_js evaluate returns string result of last expression
        _log("✅ Plugin Loaded Successfully!");
      } else {
        _log("❌ Failed to download plugin. Status: ${response.statusCode}");
      }
    } catch (e) {
      _log("❌ Error loading plugin from URL: $e");
    }
  }

  Future<void> _runTest(String targetUrl) async {
    if (_requestChannel == null) return;

    // 1. Always load the latest script from URL before running
    await _loadRealPluginFromUrl();

    const pluginId = 'slicklyTwHkPhoneNumberPlugin';

    // 2. Inject Configuration (System UA)
    // We assume the plugin is now registered in 'window.plugin'
    try {
      await _jsService.injectConfig(pluginId, {
        // 'userAgent': _requestChannel!.defaultUserAgent,
      });
      _log("Injected Config for $pluginId");

      _log("Executing Plugin Task...");
      // 3. Call generateOutput
      final script =
          "window.plugin['$pluginId'].generateOutput('$targetUrl', null, null, 'req_${DateTime.now().millisecondsSinceEpoch}');";
      final result = await _jsService.evaluate(script);
      _log("Task Executed. Result: $result");
    } catch (e) {
      _log("❌ Execution Error: $e (Maybe plugin failed to load?)");
    }
  }

  @override
  void dispose() {
    _jsService.dispose();
    _urlController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ZTest Architecture POC')),
        body: Column(
          children: [
            // URL Input Area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Plugin Raw URL (GitHub)',
                  border: OutlineInputBorder(),
                  hintText: 'https://raw.githubusercontent.com/...',
                ),
              ),
            ),

            // Result Display Area
            // Result Display Area
            if (_result != null)
              Builder(
                builder: (context) {
                  final bool isSuccess = _result!['success'] == true;
                  final bool isBlock = _result!['action'] == 'block';
                  final String errorMsg = _result!['error'] ?? 'Unknown Error';

                  if (!isSuccess) {
                    // ERROR CARD
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "⚠️ EXECUTION FAILED",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Error: $errorMsg", textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  }

                  // SUCCESS CARD
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isBlock ? Colors.red[100] : Colors.green[100],
                      border: Border.all(
                        color: isBlock ? Colors.red : Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Action: ${_result!['action']?.toUpperCase()}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Label: ${_result!['predefinedLabel'] ?? 'N/A'}"),
                        Text("Source: ${_result!['sourceLabel'] ?? 'N/A'}"),
                        Text("Count: ${_result!['count'] ?? 0}"),
                      ],
                    ),
                  );
                },
              ),

            // Console Output
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(
                    _logs.join('\n'),
                    style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            // Control Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            _runTest("98888216"), // Dummy Phone Number
                        child: const Text('Test Phone (98888216)'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _logs.clear();
                          setState(() {});
                        },
                        child: const Text('Clear Logs'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Note: 'Test Phone' downloads the JS from the URL above and runs it against '66666666'.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
