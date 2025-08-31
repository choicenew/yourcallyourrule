import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'package:yourcallyourrule/cloud_sync/entities/backup_config_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/backup_restore_provider.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_restore_service.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';


class BackupRestorePage extends ConsumerWidget {
  const BackupRestorePage({super.key});

  Future<void> _showBackupConfigDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final backupService = ref.read(backupRestoreServiceProvider);
    final config = await backupService.getBackupConfig();

    bool keepAllVersions = config.keepAllVersions;
    String deviceName = config.deviceName;
    bool encryptionEnabled = config.encryptionEnabled;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.backupSettings),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.keepAllVersions),
                subtitle: Text(
                  AppLocalizations.of(context)!.keepAllVersionsDescription,
                ),
                value: keepAllVersions,
                onChanged: (value) {
                  setState(() {
                    keepAllVersions = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.enableEncryption),
                subtitle: Text(
                  AppLocalizations.of(context)!.enableEncryptionDescription,
                ),
                value: encryptionEnabled,
                onChanged: (value) {
                  setState(() {
                    encryptionEnabled = value;
                  });
                  if (value) {
                    // If enabling encryption, prompt for password
                    Navigator.pop(context);
                    _showEncryptionPasswordDialog(context, ref, true).then((
                      _,
                    ) {
                      // Re-open the backup config dialog after setting password
                      _showBackupConfigDialog(context, ref);
                    });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.deviceName,
                    hintText: AppLocalizations.of(context)!.enterDeviceName,
                  ),
                  initialValue: deviceName,
                  onChanged: (value) => deviceName = value,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancelButton),
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
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ],
          ),
      )
    );
    
  }

  Future<void> _showCloudSyncDialog(BuildContext context, WidgetRef ref) async {
    final cloudService = ref.read(activeSyncServiceProvider);
    if (cloudService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.configureCloudSyncService,
          ),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.cloudSync),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.cloud_upload),
                  title: Text(AppLocalizations.of(context)!.backupToCloud),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      final cloudService = ref.read(activeSyncServiceProvider);
                      if (cloudService == null) return;

                      // 备份规则
                      final rules = ref.read(rulesProvider).value ?? [];
                      final rulesSuccess = await cloudService.syncRules(rules);

                      // 备份设置
                      final backupService = ref.read(
                        backupRestoreServiceProvider,
                      );
                      final settings = await backupService.getBackupConfig();
                      final settingsSuccess = await cloudService.syncSettings(
                        settings.toJson(),
                      );

                      if (rulesSuccess && settingsSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.backupToCloudSuccess,
                            ),
                          ),
                        );
                      } else {
                        throw Exception(
                          AppLocalizations.of(context)!.backupFailed,
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(
                              context,
                            )!.backupToCloudFailed(e.toString()),
                          ),
                        ),
                      );
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cloud_download),
                  title: Text(AppLocalizations.of(context)!.restoreFromCloud),
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
                      final settings =
                          await cloudService.getSettingsFromCloud();
                      if (settings != null) {
                        final backupService = ref.read(
                          backupRestoreServiceProvider,
                        );
                        await backupService.restoreSettings(
                          jsonEncode(settings),
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(
                              context,
                            )!.restoreFromCloudSuccess,
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(
                              context,
                            )!.restoreFromCloudFailed(e.toString()),
                          ),
                        ),
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
        title: Text(AppLocalizations.of(context)!.backupAndRestore),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackupSection(context, ref, backupService),
            const SizedBox(height: 24),
              GoogleAdWidget(adInfo: AdManager.bannerAd),  
              const SizedBox(height: 24),
            _buildRestoreSection(context, ref, backupService),
            const SizedBox(height: 24),
              GoogleAdWidget(adInfo: AdManager.bannerAd),  
              const SizedBox(height: 24),
            _buildDataMigrationSection(context, ref, backupService),
            const SizedBox(height: 24),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupSection(
    BuildContext context,
    WidgetRef ref,
    BackupRestoreService backupService,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.backup,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(AppLocalizations.of(context)!.backupSettings),
              subtitle: Text(
                AppLocalizations.of(context)!.configureBackupOptions,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showBackupConfigDialog(context, ref),
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: Text(AppLocalizations.of(context)!.exportRules),
              subtitle: Text(
                AppLocalizations.of(context)!.exportAllRuleConfigurations,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _exportRules(context, ref, backupService),
            ),
            ListTile(
              leading: const Icon(Icons.settings_backup_restore),
              title: Text(AppLocalizations.of(context)!.settingsBackup),
              subtitle: Text(
                AppLocalizations.of(context)!.exportAllApplicationSettings,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _backupSettings(context, ref, backupService),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: Text(AppLocalizations.of(context)!.cloudSync),
              subtitle: Text(
                AppLocalizations.of(context)!.syncWithCloudStorage,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showCloudSyncDialog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestoreSection(
    BuildContext context,
    WidgetRef ref,
    BackupRestoreService backupService,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.restore,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: Text(AppLocalizations.of(context)!.importRules),
              subtitle: Text(
                AppLocalizations.of(context)!.importRuleConfigurationsFromFile,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _importRules(context, ref, backupService),
            ),
            ListTile(
              leading: const Icon(Icons.restore),
              title: Text(AppLocalizations.of(context)!.restoreSettings),
              subtitle: Text(
                AppLocalizations.of(
                  context,
                )!.restoreApplicationSettingsFromBackup,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _restoreSettings(context, ref, backupService),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataMigrationSection(
    BuildContext context,
    WidgetRef ref,
    BackupRestoreService backupService,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.dataMigration,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: Text(AppLocalizations.of(context)!.migrationTool),
              subtitle: Text(
                AppLocalizations.of(
                  context,
                )!.transferDataBetweenDevicesOrPlatforms,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showDataMigrationDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportRules(
    BuildContext context,
    WidgetRef ref,
    BackupRestoreService backupService,
  ) async {
    try {
      final rules = ref.read(rulesProvider).value;
      if (rules == null || rules.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.noRulesToExport),
          ),
        );
        return;
      }

      final result = await FilePicker.platform.saveFile(
        dialogTitle: AppLocalizations.of(context)!.exportRules,
        fileName: 'rules_${DateTime.now().millisecondsSinceEpoch}.json',
      );

      if (result != null) {
        final path = await backupService.backupRules(rules, result);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.rulesExportedTo(path)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.failedToExportRules(e.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _backupSettings(
    BuildContext context,
    WidgetRef ref,
    BackupRestoreService backupService,
  ) async {
    try {
      // 先准备备份数据
      final tempPath = await backupService.prepareSettingsBackup();
      final backupFile = File(tempPath);
      final bytes = await backupFile.readAsBytes();
      
      // 使用FilePicker保存文件，提供bytes参数
      final result = await FilePicker.platform.saveFile(
        dialogTitle: AppLocalizations.of(context)!.backupSettings,
        fileName: 'settings_${DateTime.now().millisecondsSinceEpoch}.json',
        bytes: bytes,
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.settingsBackedUpTo(result),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.failedToBackupSettings(e.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _importRules(
    BuildContext context,
    WidgetRef ref,
    BackupRestoreService backupService,
  ) async {
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
          final shouldImport =
              await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.importRules),
                      content: Text(
                        AppLocalizations.of(context)!.foundRules(rules.length),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(AppLocalizations.of(context)!.cancelButton),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(AppLocalizations.of(context)!.import),
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
                content: Text(
                  AppLocalizations.of(
                    context,
                  )!.rulesImportedSuccessfully(rules.length),
                ),
              ),
            );
          }
        } catch (error) {
          // If decryption failed, prompt for password
          if (error.toString().contains('Encryption') ||
              error.toString().contains('decrypt') ||
              error.toString().contains('password')) {
            // Show password dialog
            final passwordValid = await _showEncryptionPasswordDialog(
              context,
              ref,
              false,
            );
            if (passwordValid) {
              // Try again with the correct password
              await _importRules(context, ref, backupService);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.failedToDecryptBackupFile,
                  ),
                ),
              );
            }
          } else {
            rethrow;
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.failedToImportRules(e.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _restoreSettings(
    BuildContext context,
    WidgetRef ref,
    BackupRestoreService backupService,
  ) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);

        // Show confirmation dialog
        final shouldRestore =
            await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.restoreSettings),
                    content: Text(
                      AppLocalizations.of(context)!.restoreSettingsConfirmation,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(AppLocalizations.of(context)!.cancelButton),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(AppLocalizations.of(context)!.restore),
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
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.settingsRestoredSuccessfully,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.failedToRestoreSettings,
                  ),
                ),
              );
            }
          } catch (error) {
            // If decryption failed, prompt for password
            if (error.toString().contains('Encryption') ||
                error.toString().contains('decrypt') ||
                error.toString().contains('password')) {
              // Show password dialog
              final passwordValid = await _showEncryptionPasswordDialog(
                context,
                ref,
                false,
              );
              if (passwordValid) {
                // Try again with the correct password
                await _restoreSettings(context, ref, backupService);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.failedToDecryptBackupFile,
                    ),
                  ),
                );
              }
            }
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            )!.failedToRestoreSettingsWithError(e.toString()),
          ),
        ),
      );
    }
  }

  void _showDataMigrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.dataMigration),
            content: Text(
              AppLocalizations.of(context)!.dataMigrationDescription,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.okButton),
              ),
            ],
          ),
    );
  }

  Future<bool> _showEncryptionPasswordDialog(
    BuildContext context,
    WidgetRef ref,
    bool isSettingPassword,
  ) async {
    final backupService = ref.read(backupRestoreServiceProvider);
    String password = '';
    String confirmPassword = '';
    bool passwordsMatch = true;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: Text(
                    isSettingPassword
                        ? AppLocalizations.of(context)!.setEncryptionPassword
                        : AppLocalizations.of(
                          context,
                        )!.enterEncryptionPasswordHint,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                          hintText:
                              AppLocalizations.of(
                                context,
                              )!.enterEncryptionPasswordHint,
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
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.confirmPassword,
                            hintText:
                                AppLocalizations.of(
                                  context,
                                )!.enterPasswordAgain,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              AppLocalizations.of(context)!.passwordsDoNotMatch,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(AppLocalizations.of(context)!.cancelButton),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (isSettingPassword) {
                          if (password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.passwordCannotBeEmpty,
                                ),
                              ),
                            );
                            return;
                          }

                          if (!passwordsMatch) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.passwordsDoNotMatch,
                                ),
                              ),
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
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.passwordCannotBeEmpty,
                                ),
                              ),
                            );
                            return;
                          }

                          final isValid = await backupService
                              .validateEncryptionPassword(password);
                          if (isValid) {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.incorrectPassword,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        isSettingPassword
                            ? AppLocalizations.of(context)!.setup
                            : AppLocalizations.of(context)!.confirmButton,
                      ),
                    ),
                  ],
                ),
          ),
    );

    return result ?? false;
  }
}
