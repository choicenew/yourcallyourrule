import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/cloud_sync/provider/backup_restore_provider.dart';

class LocalExportWidget extends ConsumerWidget {
  const LocalExportWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.save_alt),
        title: Text(AppLocalizations.of(context)!.backup),
        subtitle: Text(AppLocalizations.of(context)!.exportAllApplicationSettings),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _exportAllToLocal(context, ref),
      ),
    );
  }

  Future<void> _exportAllToLocal(BuildContext context, WidgetRef ref) async {
    final backupService = ref.read(backupRestoreServiceProvider);
    try {
      // 统一备份（数据库表 + 设置）生成临时文件
      final tempPath = await backupService.backupAll('');
      final file = File(tempPath);
      final bytes = await file.readAsBytes();

      // 通过 FilePicker 保存到本地（手机存储）
      final result = await FilePicker.platform.saveFile(
        dialogTitle: AppLocalizations.of(context)!.backup,
        fileName: 'backup_${DateTime.now().millisecondsSinceEpoch}.json',
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: const ['json'],
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.settingsBackedUpTo(result)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.failedToBackupSettings(e.toString())),
        ),
      );
    }
  }
}