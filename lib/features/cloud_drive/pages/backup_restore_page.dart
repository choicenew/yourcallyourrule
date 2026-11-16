import 'dart:io';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_backup_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 本地配置与规则全量备份恢复页面 —— 独立、纯净、无云盘宣传混淆
class BackupRestorePage extends ConsumerStatefulWidget {
  const BackupRestorePage({super.key});

  @override
  ConsumerState<BackupRestorePage> createState() => _BackupRestorePageState();
}

class _BackupRestorePageState extends ConsumerState<BackupRestorePage> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _versions = [];

  @override
  void initState() {
    super.initState();
    _loadBackupVersions();
  }

  Future<void> _loadBackupVersions() async {
    setState(() => _isLoading = true);
    try {
      final service = ref.read(configBackupServiceProvider);
      await service.initialize();
      final list = await service.getBackupVersions();
      if (mounted) {
        setState(() {
          _versions = list.reversed.toList();
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _createBackup(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isLoading = true);
    try {
      final service = ref.read(configBackupServiceProvider);
      await service.initialize();
      final path = await service.backupAllConfigs();
      await _loadBackupVersions();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.operationSuccess}: $path'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.backupFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _restoreBackup(BuildContext context, String filePath) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.restoreSettings),
        content: Text(l10n.restoreSettingsConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.restore),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);
    try {
      final service = ref.read(configBackupServiceProvider);
      await service.initialize();
      await service.restoreAllConfigs(filePath);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.settingsRestoredSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.failedToRestoreSettingsWithError(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteBackup(BuildContext context, String filePath) async {
    final l10n = AppLocalizations.of(context);
    try {
      final service = ref.read(configBackupServiceProvider);
      await service.initialize();
      await service.deleteBackupVersion(filePath);
      await _loadBackupVersions();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.deleteSuccess),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.backupFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          GoRouter.of(context).goNamed(AppRouter.home);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            l10n.backupAndRestoreTitle,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: colorScheme.onSurface,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: colorScheme.onSurface,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: colorScheme.onSurface,
            ),
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                GoRouter.of(context).goNamed(AppRouter.home);
              }
            },
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // 1. 创建本地备份卡片
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.backup_rounded, color: colorScheme.primary, size: 24),
                              const SizedBox(width: 10),
                              Text(
                                l10n.backupSettings,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.backupAndRestoreSubtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          FilledButton.icon(
                            onPressed: () => _createBackup(context),
                            icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                            label: Text(l10n.backup),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. 备份历史与恢复卡片
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.history_rounded, color: colorScheme.secondary, size: 24),
                              const SizedBox(width: 10),
                              Text(
                                l10n.restoreSettings,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (_versions.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: Text(
                                  l10n.noData,
                                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _versions.length,
                              separatorBuilder: (_, _) => const Divider(height: 1),
                              itemBuilder: (ctx, index) {
                                final ver = _versions[index];
                                final filePath = ver['path'] as String? ?? '';
                                final filename = ver['filename'] as String? ?? (filePath.isNotEmpty ? filePath.split(Platform.pathSeparator).last : 'backup.json');
                                final timestamp = ver['timestamp'] as int? ?? 0;
                                final dateStr = timestamp > 0
                                    ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(timestamp))
                                    : '';

                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    filename,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                  ),
                                  subtitle: Text(
                                    dateStr.isNotEmpty ? dateStr : filePath,
                                    style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () => _restoreBackup(context, filePath),
                                        child: Text(l10n.restore),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete_outline_rounded, size: 18, color: colorScheme.error),
                                        onPressed: () => _deleteBackup(context, filePath),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
