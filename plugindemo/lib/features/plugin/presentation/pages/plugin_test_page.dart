import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/features/plugin/presentation/pages/plugin_url_webview_page.dart';
import 'package:plugindemo/features/plugin/providers/plugin_test_service_provider.dart';
import 'package:plugindemo/generated/app_localizations.dart';

class PluginTestPage extends ConsumerStatefulWidget {
  final PluginEntry plugin;

  const PluginTestPage({super.key, required this.plugin});

  @override
  ConsumerState<PluginTestPage> createState() => _PluginTestPageState();
}

class _PluginTestPageState extends ConsumerState<PluginTestPage> {
  final _simplePhoneController = TextEditingController();
  String _selectedFormat = 'phoneNumber';

  final _phoneNumberController = TextEditingController();
  final _nationalNumberController = TextEditingController();
  final _e164NumberController = TextEditingController();

  final _logs = <String>[];
  Map<String, dynamic>? _queryResult;
  bool _isLoading = false;

  bool _isAdvancedMode = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final service = ref.read(pluginTestServiceProvider);
      service.initialize();
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
    _simplePhoneController.dispose();
    _phoneNumberController.dispose();
    _nationalNumberController.dispose();
    _e164NumberController.dispose();
    super.dispose();
  }

  Future<void> _runTest() async {
    if (_isLoading) return;
    final service = ref.read(pluginTestServiceProvider);

    String? phoneNumber, nationalNumber, e164Number;

    if (_isAdvancedMode) {
      phoneNumber = _phoneNumberController.text.trim();
      nationalNumber = _nationalNumberController.text.trim();
      e164Number = _e164NumberController.text.trim();

      if (phoneNumber.isEmpty && nationalNumber.isEmpty && e164Number.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.pleaseEnterAtLeastOneNumber,
            ),
          ),
        );
        return;
      }
    } else {
      final singleNumber = _simplePhoneController.text.trim();
      if (singleNumber.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.enterPhoneNumber),
          ),
        );
        return;
      }
      switch (_selectedFormat) {
        case 'phoneNumber':
          phoneNumber = singleNumber;
          break;
        case 'nationalNumber':
          nationalNumber = singleNumber;
          break;
        case 'e164Number':
          e164Number = singleNumber;
          break;
      }
    }

    setState(() {
      _isLoading = true;
      _queryResult = null;
      _logs.clear();
    });

    try {
      final result = await service.testPlugin(
        widget.plugin,
        phoneNumber: phoneNumber,
        nationalNumber: nationalNumber,
        e164Number: e164Number,
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
        title: Text(
          '${AppLocalizations.of(context)!.testPlugin}: ${widget.plugin.name}',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.public),
            tooltip: AppLocalizations.of(context)!.openInWebView,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PluginUrlWebViewPage(plugin: widget.plugin),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPluginInfo(),
              const SizedBox(height: 16),
              _buildTestRunner(),
              const SizedBox(height: 16),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
              if (_queryResult != null) _buildResultView(),
              const SizedBox(height: 16),
              Text(
                '${AppLocalizations.of(context)!.log}:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildLogsView(),
            ],
          ),
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
            Text(
              '${AppLocalizations.of(context)!.pluginLabel}: ${widget.plugin.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${AppLocalizations.of(context)!.pluginID}: ${widget.plugin.id}',
            ),
            Text(
              '${AppLocalizations.of(context)!.pluginDescription}: ${widget.plugin.description}',
            ),
            Text(
              '${AppLocalizations.of(context)!.pluginURL}: ${widget.plugin.url}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestRunner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.advancedMode),
            Switch(
              value: _isAdvancedMode,
              onChanged: (value) {
                setState(() {
                  _isAdvancedMode = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_isAdvancedMode) ...[
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nationalNumberController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.nationalNumber,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _e164NumberController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.e164Number,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
        ] else ...[
          TextField(
            controller: _simplePhoneController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedFormat,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.numberFormat,
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: 'phoneNumber',
                child: Text(AppLocalizations.of(context)!.phoneNumber),
              ),
              DropdownMenuItem(
                value: 'nationalNumber',
                child: Text(AppLocalizations.of(context)!.nationalNumber),
              ),
              DropdownMenuItem(
                value: 'e164Number',
                child: Text(AppLocalizations.of(context)!.e164Number),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedFormat = value;
                });
              }
            },
          ),
        ],
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

  Widget _buildResultView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.result,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              const JsonEncoder.withIndent('  ').convert(_queryResult),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogsView() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: SelectableText(_logs[index]),
          );
        },
      ),
    );
  }
}
