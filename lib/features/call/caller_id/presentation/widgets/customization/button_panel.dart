import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ButtonPanel extends StatelessWidget {
  final CallerIdStyleProvider styleProvider;
  final ConfigurationManager configurationManager;
  final Function(BuildContext, CallerIdStyleProvider) onPreviewPressed;

  const ButtonPanel({
    super.key,
    required this.styleProvider,
    required this.configurationManager,
    required this.onPreviewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
            onPressed: () async {
              try {
                final result = await FilePicker.platform.pickFiles();
                if (result != null && result.files.single.path != null) {
                  await configurationManager.importConfig(result.files.single.path!, styleProvider);
                }
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(AppLocalizations.of(context)!.importSuccess)),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(AppLocalizations.of(context)!.importFailure)),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            child: const Text('Import'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                final file = await configurationManager.exportConfig();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                        content: Text(AppLocalizations.of(context)!.exportSuccess)),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                        content: Text(AppLocalizations.of(context)!.exportFailure)),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green[400],
            ),
            child: const Text('Export'),
          ),
          FilledButton(
            onPressed: () async {
              onPreviewPressed(context, styleProvider); // Preview
              await configurationManager.saveToRepository(styleProvider);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Configuration saved successfully')),
                );
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.pink[300],
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}