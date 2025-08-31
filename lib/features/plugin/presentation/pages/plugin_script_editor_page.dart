import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_script_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final pluginScriptServiceProvider = Provider((ref) => PluginScriptService());

class PluginScriptEditorPage extends ConsumerStatefulWidget {
  final PluginEntry plugin;

  const PluginScriptEditorPage({super.key, required this.plugin});

  @override
  _PluginScriptEditorPageState createState() => _PluginScriptEditorPageState();
}

class _PluginScriptEditorPageState extends ConsumerState<PluginScriptEditorPage> {
  final TextEditingController _scriptController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadScript();
  }

  Future<void> _loadScript() async {
    setState(() {
      _isLoading = true;
    });
    final script = await ref.read(pluginScriptServiceProvider).getScript(widget.plugin);
    setState(() {
      _scriptController.text = script;
      _isLoading = false;
    });
  }

  Future<void> _saveScript() async {
    await ref.read(pluginScriptServiceProvider).saveScript(widget.plugin, _scriptController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.scriptSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editScriptFor(widget.plugin.name)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveScript,
            tooltip: AppLocalizations.of(context)!.saveScript,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _scriptController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
    );
  }
}