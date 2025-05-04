import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';

final webdavConfigProvider = StateProvider<Map<String, String>>((ref) => {});
final oneDriveConfigProvider = StateProvider<Map<String, String>>((ref) => {});
final googleDriveConfigProvider =
    StateProvider<Map<String, String>>((ref) => {});

class CloudSettingsPage extends ConsumerWidget {
  const CloudSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('云端同步'),
      ),
      body: ListView(
        children: [
          _buildSyncStatusSection(context, ref),
          const Divider(),
          _buildWebDAVSection(context, ref.watch(webdavConfigProvider), ref),
          const Divider(),
          _buildOneDriveSection(
              context, ref.watch(oneDriveConfigProvider), ref),
          const Divider(),
          _buildGoogleDriveSection(
              context, ref.watch(googleDriveConfigProvider), ref),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('备份与恢复'),
            subtitle: const Text('备份或恢复应用数据'),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebDAVSection(
      BuildContext context, Map<String, String> config, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WebDAV配置',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '服务器地址',
              hintText: '请输入WebDAV服务器地址',
            ),
            initialValue: config['server_url'],
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['server_url'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '用户名',
              hintText: '请输入WebDAV用户名',
            ),
            initialValue: config['username'],
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['username'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '密码',
              hintText: '请输入WebDAV密码',
            ),
            obscureText: true,
            initialValue: config['password'],
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['password'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '同步文件夹名称',
              hintText: '请输入同步文件夹名称（默认：NotificationManager）',
            ),
            initialValue: config['folder_name'],
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['folder_name'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _testWebDAVConnection(context, config),
            child: const Text('测试连接'),
          ),
        ],
      ),
    );
  }

  Widget _buildOneDriveSection(
      BuildContext context, Map<String, String> config, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OneDrive配置',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
           const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('使用系统配置的OneDrive客户端ID和密钥进行授权'),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '同步文件夹名称',
              hintText: '请输入同步文件夹名称（默认：NotificationManager）',
            ),
            initialValue: config['folder_name'],
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['folder_name'] = value;
              ref.read(oneDriveConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _authorizeOneDrive(context, config, ref),
            child: const Text('授权登录'),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleDriveSection(
      BuildContext context, Map<String, String> config, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Google Drive配置',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('使用系统配置的Google Drive客户端ID和密钥进行授权'),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '同步文件夹名称',
              hintText: '请输入同步文件夹名称（默认：NotificationManager）',
            ),
            initialValue: config['folder_name'],
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['folder_name'] = value;
              ref.read(googleDriveConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _authorizeGoogleDrive(context, config, ref),
            child: const Text('授权登录'),
          ),
        ],
      ),
    );
  }

  Future<void> _testWebDAVConnection(
      BuildContext context, Map<String, String> config) async {
    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取WebDAV服务
      final webdavService = ProviderContainer().read(webdavSyncServiceProvider);

      // 初始化服务
      await webdavService.initialize({
        'server_url': config['server_url'],
        'username': config['username'],
        'password': config['password'],
      });

      // 测试连接
      final result = await webdavService.connect({
        'server_url': config['server_url'],
        'username': config['username'],
        'password': config['password'],
      });

      // 关闭加载指示器
      Navigator.of(context).pop();

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('连接成功')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('连接失败: 请检查服务器地址、用户名和密码')),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('连接失败: $e')),
      );
    }
  }

  Future<void> _authorizeOneDrive(
      BuildContext context, Map<String, String> config, WidgetRef ref) async {
    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取OneDrive服务
      final onedriveService =
          ProviderContainer().read(onedriveSyncServiceProvider);

      // 初始化服务
      await onedriveService.initialize({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 测试连接
      final result = await onedriveService.connect({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 关闭加载指示器
      Navigator.of(context).pop();

      if (result) {
        // 设置为活动服务
        ref.read(activeSyncServiceProvider.notifier).state = onedriveService;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('授权成功')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('授权失败: 请检查客户端ID和密钥')),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('授权失败: $e')),
      );
    }
  }

  Future<void> _authorizeGoogleDrive(
      BuildContext context, Map<String, String> config, WidgetRef ref) async {
    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取Google Drive服务
      final googleDriveService =
          ProviderContainer().read(googleDriveSyncServiceProvider);

      // 初始化服务
      await googleDriveService.initialize({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 测试连接
      final result = await googleDriveService.connect({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 关闭加载指示器
      Navigator.of(context).pop();

      if (result) {
        // 设置为活动服务
        ref.read(activeSyncServiceProvider.notifier).state = googleDriveService;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('授权成功')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('授权失败: 请检查客户端ID和密钥')),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('授权失败: $e')),
      );
    }
  }

  Widget _buildSyncStatusSection(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '同步状态',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, child) {
              final syncStatusAsync = ref.watch(cloudSyncStatusProvider);

              return syncStatusAsync.when(
                data: (status) {
                  final isConnected = status['connected'] as bool;
                  final serviceType = status['service_type'] as String;
                  final autoSyncEnabled = status['auto_sync_enabled'] as bool;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(
                          isConnected ? Icons.cloud_done : Icons.cloud_off,
                          color: isConnected ? Colors.green : Colors.red,
                        ),
                        title: Text('连接状态: ${isConnected ? "已连接" : "未连接"}'),
                        subtitle: Text(
                            '服务类型: ${serviceType == "none" ? "无" : serviceType}'),
                      ),
                      if (isConnected) ...[
                        ListTile(
                          leading: Icon(
                            autoSyncEnabled ? Icons.sync : Icons.sync_disabled,
                            color: autoSyncEnabled ? Colors.green : Colors.grey,
                          ),
                          title:
                              Text('自动同步: ${autoSyncEnabled ? "已启用" : "未启用"}'),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.sync),
                              label: const Text('立即同步'),
                              onPressed: () => _syncNow(context, ref),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.sync_disabled),
                              label: const Text('断开连接'),
                              onPressed: () => _disconnectCloud(context, ref),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('加载状态失败: $error'),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _syncNow(BuildContext context, WidgetRef ref) async {
    final activeService = ref.read(activeSyncServiceProvider);
    if (activeService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('没有活动的云同步服务')),
      );
      return;
    }

    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 同步规则数据
      final rules = await ref.read(rulesProvider.future);
      await activeService.syncRules(rules);

      // 同步设备数据
      final currentDevice = await ref.read(currentDeviceProvider.future);
      await activeService.registerDeviceForSync(currentDevice);
      await activeService.syncDevicesFromCloud();

      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('同步成功')),
      );

      // 刷新状态并等待完成
      final refreshResult = await ref.refresh(cloudSyncStatusProvider.future);
      // 使用刷新结果更新UI
      if (refreshResult['connected'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('同步状态已更新')),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('同步失败: $e')),
      );
    }
  }

  Future<void> _disconnectCloud(BuildContext context, WidgetRef ref) async {
    final activeService = ref.read(activeSyncServiceProvider);
    if (activeService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('没有活动的云同步服务')),
      );
      return;
    }

    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 断开连接
      await activeService.disconnect();

      // 清除活动服务
      ref.read(activeSyncServiceProvider.notifier).state = null;

      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已断开连接')),
      );

      // 刷新状态并等待完成
      final refreshResult = await ref.refresh(cloudSyncStatusProvider.future);
      // 使用刷新结果更新UI
      if (refreshResult['connected'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('同步状态已更新')),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('断开连接失败: $e')),
      );
    }
  }
}
