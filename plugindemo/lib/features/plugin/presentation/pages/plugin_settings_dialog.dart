import 'package:flutter/material.dart';
import '/core/entities/plugin/plugin_entry.dart';
import '/features/plugin/services/plugin_invoker_service.dart';
import 'package:plugindemo/features/plugin/services/plugin_url_execution_service.dart';
import '/generated/app_localizations.dart';

class PluginSettingsDialog extends StatefulWidget {
  final PluginEntry plugin;
  final PluginInvokerService invokerService;

  const PluginSettingsDialog({
    super.key,
    required this.plugin,
    required this.invokerService,
  });

  @override
  State<PluginSettingsDialog> createState() => _PluginSettingsDialogState();
}

class _PluginSettingsDialogState extends State<PluginSettingsDialog> {
  bool _isLoading = true;
  List<dynamic> _schema = [];
  final Map<String, dynamic> _config = {};
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _uaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _config.addAll(widget.plugin.config);
    _uaController.text = _config['userAgent']?.toString() ?? '';
    _loadSchema();
  }

  @override
  void dispose() {
    _uaController.dispose();
    super.dispose();
  }

  Future<void> _loadSchema() async {
    try {
      final schema = await widget.invokerService.getPluginSettings(
        widget.plugin.id,
      );
      if (mounted) {
        setState(() {
          _schema = schema ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              ).failedToLoadSettingsSchema(e.toString()),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${AppLocalizations.of(context).settings}: ${widget.plugin.name}',
      ),
      content: SizedBox(
        width: double.maxFinite,
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: _uaController,
                          decoration: InputDecoration(
                            labelText: 'User Agent',
                            hintText:
                                AppLocalizations.of(
                                  context,
                                ).leaveEmptyToUseDefault,
                            helperText:
                                'Default: ${PluginUrlExecutionService.defaultUserAgent}',
                            helperMaxLines: 3,
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.phonelink_setup),
                              onPressed: () async {
                                final ua =
                                    await PluginUrlExecutionService()
                                        .getDeviceDefaultUserAgent();
                                if (context.mounted) {
                                  setState(() {
                                    _uaController.text = ua;
                                  });
                                }
                              },
                            ),
                          ),
                          onSaved: (value) => _config['userAgent'] = value,
                        ),
                      ),
                      ..._schema.map((field) => _buildField(field)),
                    ],
                  ),
                ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        if (!_isLoading)
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.of(context).pop(_config);
              }
            },
            child: Text(AppLocalizations.of(context).save),
          ),
      ],
    );
  }

  Widget _buildField(dynamic field) {
    final String key = field['key'];
    final String label = field['label'] ?? key;
    final String type = field['type'] ?? 'text';
    final String? hint = field['hint'];
    final bool required = field['required'] ?? false;
    final dynamic initialValue = _config[key] ?? field['defaultValue'];

    if (type == 'password') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          initialValue: initialValue?.toString(),
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          obscureText: true,
          validator:
              required
                  ? (value) =>
                      value == null || value.isEmpty
                          ? AppLocalizations.of(context).fieldIsRequired
                          : null
                  : null,
          onSaved: (value) => _config[key] = value,
        ),
      );
    }

    // Default to text
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue?.toString(),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator:
            required
                ? (value) =>
                    value == null || value.isEmpty
                        ? AppLocalizations.of(context).fieldIsRequired
                        : null
                : null,
        onSaved: (value) => _config[key] = value,
      ),
    );
  }
}
