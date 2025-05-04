import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/screens/caller_id_import_export_dialog.dart';

class ConfigImportExportButton extends StatelessWidget {
  final Future<void> Function(String) onImport;
  final Future<void> Function(String) onExport;

  const ConfigImportExportButton({
    super.key,
    required this.onImport,
    required this.onExport,
  });

  Future<void> _handleOperation(BuildContext context, String? path) async {
    if (path == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在处理中...'),
          ],
        ),
      ),
    );

    try {
      if (path.contains('import')) {
        await onImport(path);
      } else {
        await onExport(path);
      }
      Navigator.pop(context);
      _showResultDialog(context, success: true);
    } catch (e) {
      Navigator.pop(context);
      _showResultDialog(context, success: false);
    }
  }

  void _showResultDialog(BuildContext context, {required bool success}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(success ? '操作成功' : '操作失败'),
        content: Text(success ? '配置文件已更新' : '请检查文件格式或权限'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_backup_restore),
      onPressed: () async {
        final path = await showImportExportDialog(context);
        if (path != null) {
          await _handleOperation(context, path);
        }
      },
    );
  }
}