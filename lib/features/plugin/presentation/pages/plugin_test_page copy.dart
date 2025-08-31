import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/features/plugin/presentation/pages/plugin_url_webview_page.dart';
import 'package:yourcallyourrule/features/plugin/providers/plugin_test_service_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class PluginTestPage extends ConsumerStatefulWidget {
  final PluginEntry plugin;

  const PluginTestPage({super.key, required this.plugin});

  @override
  ConsumerState<PluginTestPage> createState() => _PluginTestPageState();
}

class _PluginTestPageState extends ConsumerState<PluginTestPage> {
  final _phoneController = TextEditingController();
  final _logs = <String>[];
  Map<String, dynamic>? _queryResult;
  bool _isLoading = false;
  String _selectedFormat = 'phoneNumber'; // Default format

  @override
  void initState() {
    super.initState();
    // Initialize the service and listen to logs
    Future.microtask(() {
      final service = ref.read(pluginTestServiceProvider);
      service.initialize(); // Initialize headless webview
      service.logStream.listen((log) {
        if (mounted) {
          setState(() {
            _logs.insert(0, log);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _runTest() async {
    if (_isLoading) return;
    final service = ref.read(pluginTestServiceProvider);
    final phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.enterPhoneNumber)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _queryResult = null;
      _logs.clear();
    });

    try {
      final result = await service.testPlugin(
        widget.plugin,
        phoneNumber,
        _selectedFormat,
      );
      setState(() {
        _queryResult = result;
      });
    } catch (e) {
      setState(() {
        _queryResult = {'error': e.toString()};
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Plugin: ${widget.plugin.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.public),
            tooltip: 'Open in WebView',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PluginUrlWebViewPage(
                    plugin: widget.plugin,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPluginInfo(),
            const SizedBox(height: 16),
            _buildTestRunner(),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
            if (_queryResult != null)
              _buildResultView(),
            const SizedBox(height: 16),
            Text('${AppLocalizations.of(context)!.log}:',
            style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: _buildLogsView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPluginInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plugin: ${widget.plugin.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('ID: ${widget.plugin.id}'),
                Text('Description: ${widget.plugin.description}'),
            Text('URL: ${widget.plugin.url}'),
          ],
        ),
      ),
    );
  }

  Widget _buildTestRunner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.phoneNumber,
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _selectedFormat,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.numberFormat,
            border: OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(value: 'phoneNumber', child: Text(AppLocalizations.of(context)!.phoneNumber)),
            DropdownMenuItem(value: 'nationalNumber', child: Text(AppLocalizations.of(context)!.nationalNumber)),
            DropdownMenuItem(value: 'e164Number', child: Text(AppLocalizations.of(context)!.e164Number)),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedFormat = value;
              });
            }
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _runTest,
            child: Text(AppLocalizations.of(context)!.testPlugin),
          ),
        ),
      ],
    );
  }

  Widget _buildResultViewxx() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Result:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[400]!)
          ),
          child: SingleChildScrollView(
            child: Text(
              const JsonEncoder.withIndent('  ').convert(_queryResult),
              
            ),
          ),
        ),
      ],
    );
  }
Widget _buildResultView() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(AppLocalizations.of(context)!.result, style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      // 在这里用 Center 组件包裹 Container
      Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[400]!)
          ),
          child: SingleChildScrollView(
            child: Text(
              const JsonEncoder.withIndent('  ').convert(_queryResult),
            ),
          ),
        ),
      ),
    ],
  );
}
  Widget _buildLogsView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(_logs[index]),
          );
        },
      ),
    );
  }
}