// lib/features/call/caller_id/widgets/customization/button_panel.dart

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';



class ButtonPanel extends ConsumerWidget {
  // ButtonPanel 恢复接收 ConfigurationManager
  final ConfigurationManager configurationManager;
  final VoidCallback onPreviewPressed;
  final VoidCallback onClosePressed;

  const ButtonPanel({
    super.key,
    required this.configurationManager,
    required this.onPreviewPressed,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取 Notifier 实例，以便在业务逻辑操作完成后，用新数据更新UI状态
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 12.0,
        runSpacing: 12.0,
        alignment: WrapAlignment.center,
        children: [
          // --- 导入按钮 ---
          FilledButton.icon(
            icon: const Icon(Icons.file_upload),
            label: Text(AppLocalizations.of(context)!.import),
            onPressed: () async {
              try {
                final result = await FilePicker.platform.pickFiles();
                if (result != null && result.files.single.path != null) {
                  // 1. 调用 manager 执行业务逻辑
                  final newConfig = await configurationManager.importConfig(result.files.single.path!);
                  // 2. 业务逻辑成功后，通知 Notifier 更新其状态，UI会自动刷新
                  notifier.updateStateWith(newConfig);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.importSuccess)),
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${AppLocalizations.of(context)!.importFailure}: $e")),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.amber),
          ),

          // --- 导出按钮 ---
          FilledButton.icon(
            icon: const Icon(Icons.file_download),
            label: Text(AppLocalizations.of(context)!.export),
            onPressed: () async {
              try {
                // 调用 manager 执行导出
                await configurationManager.exportConfig();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.exportSuccesslly)),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${AppLocalizations.of(context)!.exportFailure}: $e")),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.green[400]),
          ),

          // --- 保存按钮 ---
          FilledButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Save'),
            onPressed: () async {
              // 1. 从 Notifier 读取当前UI上的最新状态
              final currentConfig = ref.read(callerIdStyleSecurityProvider).value;
              if (currentConfig != null) {
                try {
                  // 2. 将当前状态传递给 manager 去保存
                  await configurationManager.saveConfig(currentConfig);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Configuration saved successfully')),
                    );
                  }
                } catch (e) {
                   if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to save configuration: $e')),
                    );
                  }
                }
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.pink[300]),
          ),
          
          // --- 预览按钮 ---
          FilledButton.icon(
            icon: const Icon(Icons.visibility),
            label: const Text('Preview'),
            onPressed: onPreviewPressed,
            style: FilledButton.styleFrom(backgroundColor: Colors.blue[300]),
          ),

          // --- 重置按钮 ---
          FilledButton.icon(
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset'),
            onPressed: () async {
               try {
                // 1. 调用 manager 获取默认配置
                final defaultConfig = await configurationManager.resetToDefault();
                // 2. 用默认配置更新 Notifier 的状态
                notifier.updateStateWith(defaultConfig);
                 if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Configuration has been reset to default')),
                    );
                  }
              } catch (e) {
                if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to reset configuration: $e')),
                    );
                  }
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.grey[600]),
          ),
          // --- 关闭按钮 ---
          FilledButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Close'),
            onPressed: onClosePressed,
            style: FilledButton.styleFrom(backgroundColor: Colors.red[300]),
          ),
        ],
      ),
    );
  }
}