import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/core_security_message_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ButtonPanel extends ConsumerWidget {
  final ConfigurationManager configurationManager;
  final VoidCallback onPreviewPressed;

  const ButtonPanel({
    super.key,
    required this.configurationManager,
    required this.onPreviewPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  final styleProvider = ref.read(callerIdStyleProvider.notifier);
                  final securityProvider = ref.read(coreSecurityMessageProvider.notifier);
                  await configurationManager.importConfig(result.files.single.path!, styleProvider, securityProvider);
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
            child: Text(AppLocalizations.of(context)!.import),
          ),
          FilledButton(
            onPressed: () async {
              try {
                final file = await configurationManager.exportConfig();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                        content: Text(AppLocalizations.of(context)!.exportSuccesslly)),
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
            child: Text(AppLocalizations.of(context)!.export),
          ),
          FilledButton(
            onPressed: () async {
              onPreviewPressed(); // Preview
              final styleProvider = ref.read(callerIdStyleProvider.notifier);
              final securityProvider = ref.read(coreSecurityMessageProvider.notifier);
              await configurationManager.saveToRepository(styleProvider, securityProvider);
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