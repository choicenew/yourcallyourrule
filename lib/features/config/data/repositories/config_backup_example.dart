import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_backup_service.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_cloud_converter.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

class ConfigBackupExample extends ConsumerWidget {
  const ConfigBackupExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupService = ref.watch(configBackupServiceProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Config Backup Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _backupAllConfigs(context, backupService),
              child: const Text('Backup Configs'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _restoreAllConfigs(context, backupService),
              child: const Text('Restore Configs'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _viewBackupVersions(context, backupService),
              child: const Text('Backup Versions'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _backupAllConfigs(BuildContext context, ConfigBackupService backupService) async {
    try {
      final backupPath = await backupService.backupAllConfigs();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup Success: $backupPath')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup Failed: $e')),
      );
    }
  }

  Future<void> _restoreAllConfigs(BuildContext context, ConfigBackupService backupService) async {
    try {
      final versions = await backupService.getBackupVersions();
      if (versions.isEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Backup Versions')),
        );
        return;
      }
      
      final latestVersion = versions.last;
      final backupPath = latestVersion['path'] as String;
      await backupService.restoreAllConfigs(backupPath);
      
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restore Success')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Restore Failed: $e')),
      );
    }
  }

  Future<void> _viewBackupVersions(BuildContext context, ConfigBackupService backupService) async {
    try {
      final versions = await backupService.getBackupVersions();
      if (versions.isEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Backup Versions')),
        );
        return;
      }
      
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Backup Versions'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: versions.length,
              itemBuilder: (context, index) {
                final version = versions[index];
                final timestamp = DateTime.fromMillisecondsSinceEpoch(
                  version['timestamp'] as int
                );
                final filename = version['filename'] as String;
                
                return ListTile(
                  title: Text(filename),
                  subtitle: Text(timestamp.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await backupService.deleteBackupVersion(version['path'] as String);
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                  onTap: () async {
                    await backupService.restoreAllConfigs(version['path'] as String);
                    if (context.mounted) Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

class ConfigCloudSyncExample {
  final ConfigRepository _configRepository;
  
  ConfigCloudSyncExample(this._configRepository);
  
  Future<void> uploadConfigToCloud() async {
    final converter = ConfigCloudConverter(_configRepository);
    final cloudData = await converter.convertToCloudFormat();
    debugPrint('Cloud data: $cloudData');
  }
  
  Future<void> downloadConfigFromCloud() async {
    final converter = ConfigCloudConverter(_configRepository);
    final Map<String, dynamic> cloudData = {
      'type': 'config_backup',
      'version': 1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': {
        'theme_config': {'darkMode': true},
        'user_preferences': {'language': 'zh_CN'},
      },
    };
    await converter.restoreFromCloudFormat(cloudData);
  }
}
