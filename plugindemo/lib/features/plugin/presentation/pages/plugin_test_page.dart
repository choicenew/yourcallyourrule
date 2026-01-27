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
  // --- 状态变量 ---
  // 简单模式的控制器和格式
  final _simplePhoneController = TextEditingController();
  String _selectedFormat = 'phoneNumber';

  // 高级模式的控制器
  final _phoneNumberController = TextEditingController();
  final _nationalNumberController = TextEditingController();
  final _e164NumberController = TextEditingController();

  // 通用状态
  final _logs = <String>[];
  Map<String, dynamic>? _queryResult;
  bool _isLoading = false;

  // 用于切换模式的开关状态
  bool _isAdvancedMode = false;

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
      // --- 高级模式 ---
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
      // --- 简单模式 ---
      final singleNumber = _simplePhoneController.text.trim();
      if (singleNumber.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.enterPhoneNumber),
          ),
        );
        return;
      }
      // 根据选择的格式，将 singleNumber 赋值给对应的变量
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
      // --- 改动 1: 将 body 包裹在 SingleChildScrollView 中 ---
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
              const SizedBox(height: 8), // 添加一点间距
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
    // 这个 Widget 保持不变，因为它已经是可滚动的了（通过外层的 SingleChildScrollView）
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.result,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity, // 让容器撑满宽度
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 允许水平滚动以防 JSON 太宽
            child: Text(
              const JsonEncoder.withIndent('  ').convert(_queryResult),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogsView() {
    // 这里不再需要 Expanded，因为它现在位于 SingleChildScrollView 中
    // 我们给它一个固定的或者有限的高度，以便在有内容时显示
    return Container(
      height: 200, // 给日志视图一个固定的高度
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          // --- 改动 2: 使用 SelectableText 使日志可以被复制 ---
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: SelectableText(_logs[index]),
          );
        },
      ),
    );
  }
}
