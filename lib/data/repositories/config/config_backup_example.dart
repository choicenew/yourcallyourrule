import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_backup_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_backup_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_cloud_converter.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// 配置备份还原示例
/// 本文件展示了如何使用配置备份还原功能
class ConfigBackupExample extends ConsumerWidget {
  const ConfigBackupExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 通过Provider获取服务实例
    final backupService = ref.watch(configBackupServiceProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('配置备份还原示例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _backupAllConfigs(context, backupService),
              child: const Text('备份所有配置'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _restoreAllConfigs(context, backupService),
              child: const Text('还原所有配置'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _viewBackupVersions(context, backupService),
              child: const Text('查看备份版本'),
            ),
          ],
        ),
      ),
    );
  }

  /// 备份所有配置
  Future<void> _backupAllConfigs(BuildContext context, ConfigBackupService backupService) async {
    try {
      final backupPath = await backupService.backupAllConfigs();
      
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('备份成功: $backupPath')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('备份失败: $e')),
      );
    }
  }

  /// 还原所有配置
  Future<void> _restoreAllConfigs(BuildContext context, ConfigBackupService backupService) async {
    try {
      // 获取备份版本列表
      final versions = await backupService.getBackupVersions();
      
      if (versions.isEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('没有可用的备份版本')),
        );
        return;
      }
      
      // 使用最新的备份版本
      final latestVersion = versions.last;
      final backupPath = latestVersion['path'] as String;
      
      // 还原配置
      await backupService.restoreAllConfigs(backupPath);
      
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('还原成功')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('还原失败: $e')),
      );
    }
  }

  /// 查看备份版本
  Future<void> _viewBackupVersions(BuildContext context, ConfigBackupService backupService) async {
    try {
      // 获取备份版本列表
      final versions = await backupService.getBackupVersions();
      
      if (versions.isEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('没有可用的备份版本')),
        );
        return;
      }
      
      if (!context.mounted) return;
      
      // 显示备份版本列表
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('备份版本列表'),
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
                      // 删除备份版本
                      await backupService.deleteBackupVersion(version['path'] as String);
                      Navigator.pop(context);
                      
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('删除成功')),
                      );
                    },
                  ),
                  onTap: () async {
                    // 还原此版本
                    await backupService.restoreAllConfigs(version['path'] as String);
                    Navigator.pop(context);
                    
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('还原成功')),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('关闭'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('获取备份版本失败: $e')),
      );
    }
  }
}

/// 配置云同步示例
/// 展示如何使用ConfigCloudConverter进行云同步
class ConfigCloudSyncExample {
  final ConfigRepository _configRepository;
  
  ConfigCloudSyncExample(this._configRepository);
  
  /// 将配置转换为云格式并上传
  Future<void> uploadConfigToCloud() async {
    // 创建转换器
    final converter = ConfigCloudConverter(_configRepository);
    
    // 转换为云格式
    final cloudData = await converter.convertToCloudFormat();
    
    // 这里应该实现将cloudData上传到云端的逻辑
    // 例如使用云存储服务或后端API
    
    debugPrint('配置数据已转换为云格式: $cloudData');
  }
  
  /// 从云端下载配置并还原
  Future<void> downloadConfigFromCloud() async {
    // 创建转换器
    final converter = ConfigCloudConverter(_configRepository);
    
    // 这里应该实现从云端获取cloudData的逻辑
    // 以下是示例数据
    final Map<String, dynamic> cloudData = {
      'type': 'config_backup',
      'version': 1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': {
        'theme_config': {'darkMode': true},
        'user_preferences': {'language': 'zh_CN'},
      },
    };
    
    // 从云格式还原
    await converter.restoreFromCloudFormat(cloudData);
    
    debugPrint('配置数据已从云格式还原');
  }
}