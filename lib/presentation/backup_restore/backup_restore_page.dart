import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import 'package:yourcallyourrule/cloud_sync/entities/backup_config_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/backup_restore_provider.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_restore_service.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';

class BackupRestorePage extends ConsumerWidget {
  const BackupRestorePage({super.key});

  Future<void> _showBackupConfigDialog(
      BuildContext context, WidgetRef ref) async {
    final backupService = ref.read(backupRestoreServiceProvider);
    final config = await backupService.getBackupConfig();

    bool keepAllVersions = config.keepAllVersions;
    String deviceName = config.deviceName;
    bool encryptionEnabled = config.encryptionEnabled;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('备份设置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('保留所有版本'),
              subtitle: const Text('开启后将保留每次备份的历史版本'),
              value: keepAllVersions,
              onChanged: (value) => keepAllVersions = value,
            ),
            SwitchListTile(
              title: const Text('启用加密'),
              subtitle: const Text('开启后备份文件将被加密保存'),
              value: encryptionEnabled,
              onChanged: (value) {
                encryptionEnabled = value;
                if (value) {
                  // If enabling encryption, prompt for password
                  Navigator.pop(context);
                  _showEncryptionPasswordDialog(context, ref, true).then((_) {
                    // Re-open the backup config dialog after setting password
                    _showBackupConfigDialog(context, ref);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '设备名称',
                hintText: '请输入设备名称',
              ),
              initialValue: deviceName,
              onChanged: (value) => deviceName = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              await backupService.updateBackupConfig(
                BackupConfigEntity(
                  keepAllVersions: keepAllVersions,
                  deviceName: deviceName,
                  localBackupPath: config.localBackupPath,
                  encryptionEnabled: encryptionEnabled,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCloudSyncDialog(BuildContext context, WidgetRef ref) async {
    final cloudService = ref.read(activeSyncServiceProvider);
    if (cloudService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先在云端同步设置中配置同步服务')),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('云端同步'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: const Text('备份到云端'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final cloudService = ref.read(activeSyncServiceProvider);
                  if (cloudService == null) return;

                  // 备份规则
                  final rules = ref.read(rulesProvider).value ?? [];
                  final rulesSuccess = await cloudService.syncRules(rules);

                  // 备份设置
                  final backupService = ref.read(backupRestoreServiceProvider);
                  final settings = await backupService.getBackupConfig();
                  final settingsSuccess =
                      await cloudService.syncSettings(settings.toJson());

                  if (rulesSuccess && settingsSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('成功备份到云端')),
                    );
                  } else {
                    throw Exception('备份失败');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('备份到云端失败: $e')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud_download),
              title: const Text('从云端恢复'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final cloudService = ref.read(activeSyncServiceProvider);
                  if (cloudService == null) return;

                  // 从云端获取规则
                  final rules = await cloudService.getRulesFromCloud();
                  if (rules.isNotEmpty) {
                    final rulesNotifier = ref.read(rulesProvider.notifier);
                    await rulesNotifier.importRules(rules);
                  }

                  // 从云端获取设置
                  final settings = await cloudService.getSettingsFromCloud();
                  if (settings != null) {
                    final backupService =
                        ref.read(backupRestoreServiceProvider);
                    await backupService.restoreSettings(jsonEncode(settings));
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('成功从云端恢复')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('从云端恢复失败: $e')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupService = ref.watch(backupRestoreServiceProvider);
    final rulesAsync = ref.watch(rulesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackupSection(context, ref, backupService),
            const SizedBox(height: 24),
            _buildRestoreSection(context, ref, backupService),
            const SizedBox(height: 24),
            _buildDataMigrationSection(context, ref, backupService),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupSection(
      BuildContext context, WidgetRef ref, BackupRestoreService backupService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Backup',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Backup Settings'),
              subtitle: const Text('Configure backup options'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showBackupConfigDialog(context, ref),
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text('Export Rules'),
              subtitle: const Text('Export all rule configurations'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _exportRules(context, ref, backupService),
            ),
            ListTile(
              leading: const Icon(Icons.settings_backup_restore),
              title: const Text('Backup Settings'),
              subtitle: const Text('Export all application settings'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _backupSettings(context, ref, backupService),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: const Text('Cloud Sync'),
              subtitle: const Text('Sync with cloud storage'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showCloudSyncDialog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestoreSection(
      BuildContext context, WidgetRef ref, BackupRestoreService backupService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Restore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Import Rules'),
              subtitle: const Text('Import rule configurations from file'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _importRules(context, ref, backupService),
            ),
            ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('Restore Settings'),
              subtitle: const Text('Restore application settings from backup'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _restoreSettings(context, ref, backupService),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataMigrationSection(
      BuildContext context, WidgetRef ref, BackupRestoreService backupService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Migration',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: const Text('Migration Tool'),
              subtitle:
                  const Text('Transfer data between devices or platforms'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showDataMigrationDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportRules(BuildContext context, WidgetRef ref,
      BackupRestoreService backupService) async {
    try {
      final rules = ref.read(rulesProvider).value;
      if (rules == null || rules.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No rules to export')),
        );
        return;
      }

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Export Rules',
        fileName: 'rules_${DateTime.now().millisecondsSinceEpoch}.json',
      );

      if (result != null) {
        final path = await backupService.backupRules(rules, result);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rules exported to: $path')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export rules: $e')),
      );
    }
  }

  Future<void> _backupSettings(BuildContext context, WidgetRef ref,
      BackupRestoreService backupService) async {
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Backup Settings',
        fileName: 'settings_${DateTime.now().millisecondsSinceEpoch}.json',
      );

      if (result != null) {
        final path = await backupService.backupSettings(result);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Settings backed up to: $path')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to backup settings: $e')),
      );
    }
  }

  Future<void> _importRules(BuildContext context, WidgetRef ref,
      BackupRestoreService backupService) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        try {
          final rules = await backupService.restoreRules(file.path);

          // Show confirmation dialog with rule count
          final shouldImport = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Import Rules'),
                  content: Text(
                      'Found ${rules.length} rules. Do you want to import them?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Import'),
                    ),
                  ],
                ),
              ) ??
              false;

          if (shouldImport) {
            // Import rules using the rules provider
            final rulesNotifier = ref.read(rulesProvider.notifier);
            await rulesNotifier.importRules(rules);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('${rules.length} rules imported successfully')),
            );
          }
        } catch (error) {
          // If decryption failed, prompt for password
          if (error.toString().contains('Encryption') ||
              error.toString().contains('decrypt') ||
              error.toString().contains('password')) {
            // Show password dialog
            final passwordValid =
                await _showEncryptionPasswordDialog(context, ref, false);
            if (passwordValid) {
              // Try again with the correct password
              await _importRules(context, ref, backupService);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to decrypt backup file')),
              );
            }
          } else {
            rethrow;
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to import rules: $e')),
      );
    }
  }

  Future<void> _restoreSettings(BuildContext context, WidgetRef ref,
      BackupRestoreService backupService) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);

        // Show confirmation dialog
        final shouldRestore = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Restore Settings'),
                content: const Text(
                  'This will replace all your current settings. Are you sure you want to continue?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Restore'),
                  ),
                ],
              ),
            ) ??
            false;

        if (shouldRestore) {
          try {
            final success = await backupService.restoreSettings(file.path);
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Settings restored successfully. Please restart the app for changes to take effect.')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to restore settings')),
              );
            }
          } catch (error) {
            // If decryption failed, prompt for password
            if (error.toString().contains('Encryption') ||
                error.toString().contains('decrypt') ||
                error.toString().contains('password')) {
              // Show password dialog
              final passwordValid =
                  await _showEncryptionPasswordDialog(context, ref, false);
              if (passwordValid) {
                // Try again with the correct password
                await _restoreSettings(context, ref, backupService);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Failed to decrypt backup file')),
                );
              }
            }
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to restore settings: $e')),
      );
    }
  }

  void _showDataMigrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Migration'),
        content: const Text(
          'This feature allows you to transfer all your data between devices. '
          'Currently, you can use the backup and restore features to manually migrate your data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<bool> _showEncryptionPasswordDialog(
      BuildContext context, WidgetRef ref, bool isSettingPassword) async {
    final backupService = ref.read(backupRestoreServiceProvider);
    String password = '';
    String confirmPassword = '';
    bool passwordsMatch = true;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(isSettingPassword ? '设置加密密码' : '输入加密密码'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: '密码',
                  hintText: '请输入加密密码',
                ),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  if (isSettingPassword) {
                    setState(() {
                      passwordsMatch = password == confirmPassword;
                    });
                  }
                },
              ),
              if (isSettingPassword) ...[
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: '确认密码',
                    hintText: '请再次输入密码',
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    confirmPassword = value;
                    setState(() {
                      passwordsMatch = password == confirmPassword;
                    });
                  },
                ),
                if (!passwordsMatch && confirmPassword.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '两次输入的密码不一致',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                if (isSettingPassword) {
                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('密码不能为空')),
                    );
                    return;
                  }

                  if (!passwordsMatch) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('两次输入的密码不一致')),
                    );
                    return;
                  }

                  await backupService.setEncryptionPassword(password);
                  await backupService.setEncryptionEnabled(true);
                  Navigator.pop(context, true);
                } else {
                  // Validating password
                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('密码不能为空')),
                    );
                    return;
                  }

                  final isValid =
                      await backupService.validateEncryptionPassword(password);
                  if (isValid) {
                    Navigator.pop(context, true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('密码错误')),
                    );
                  }
                }
              },
              child: Text(isSettingPassword ? '设置' : '确认'),
            ),
          ],
        ),
      ),
    );

    return result ?? false;
  }
}
