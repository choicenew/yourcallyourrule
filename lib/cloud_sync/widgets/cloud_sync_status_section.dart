import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CloudSyncStatusSection extends ConsumerWidget {
  const CloudSyncStatusSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 255, 167, 38),
            const Color.fromARGB(255, 255, 186, 59),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final syncStatusAsync = ref.watch(cloudSyncStatusProvider);
          return syncStatusAsync.when(
            data: (status) {
              final isConnected = status['connected'] as bool;
              final serviceType = status['service_type'] as String;
              final autoSyncEnabled = status['auto_sync_enabled'] as bool;
              final isOnline = status['online'] as bool? ?? false;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.syncStatusTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatusRow(
                    context,
                    isConnected ? Icons.cloud_done : Icons.cloud_off,
                    isConnected ? Colors.greenAccent : Colors.amberAccent,
                    '${AppLocalizations.of(context)!.connectionStatusLabel}: ${isConnected ? AppLocalizations.of(context)!.connectedStatus : AppLocalizations.of(context)!.disconnectedStatus}',
                  ),
                  const SizedBox(height: 8),
                  if (isConnected) ...[  
                    _buildStatusRow(
                      context,
                      isOnline ? Icons.signal_cellular_4_bar : Icons.signal_cellular_off,
                      isOnline ? Colors.greenAccent : Colors.redAccent,
                      'Online Status: ${isOnline ? "Online" : "Offline"}',
                    ),
                    const SizedBox(height: 8),
                  ],
                  _buildStatusRow(
                    context,
                    Icons.storage,
                    Colors.white,
                    '${AppLocalizations.of(context)!.serviceTypeLabel}: ${serviceType == "none" ? AppLocalizations.of(context)!.noneServiceType : serviceType}',
                  ),
                  if (isConnected) ...[  
                    const SizedBox(height: 8),
                    _buildStatusRow(
                      context,
                      autoSyncEnabled ? Icons.sync : Icons.sync_disabled,
                      Colors.white,
                      '${AppLocalizations.of(context)!.autoSyncLabel}: ${autoSyncEnabled ? AppLocalizations.of(context)!.enabledStatus : AppLocalizations.of(context)!.disabledStatus}',
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.sync, color: Colors.blue),
                            label: Text(
                              AppLocalizations.of(context)!.syncNowButton,
                              style: const TextStyle(color: Colors.blue),
                            ),
                            onPressed: () => _syncNow(context, ref),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(
                              Icons.cloud_off,
                              color: Colors.white,
                            ),
                            label: Text(
                              AppLocalizations.of(context)!.disconnectButton,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () => _disconnectCloud(context, ref),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              );
            },
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
            error:
                (error, stack) => Text(
                  '${AppLocalizations.of(context)!.loadStatusFailedMessage}: $error',
                  style: const TextStyle(color: Colors.white),
                ),
          );
        },
      ),
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String text,
  ) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<void> _syncNow(BuildContext context, WidgetRef ref) async {
    final activeService = ref.read(activeSyncServiceProvider);
    if (activeService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.noActiveCloudSyncServiceMessage,
          ),
        ),
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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.syncSuccessMessage),
        ),
      );

      // 刷新状态并等待完成
      final refreshResult = await ref.refresh(cloudSyncStatusProvider.future);
      // 使用刷新结果更新UI
      if (refreshResult['connected'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.syncStatusUpdatedMessage,
            ),
          ),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.syncFailedMessage}: $e',
          ),
        ),
      );
    }
  }

  Future<void> _disconnectCloud(BuildContext context, WidgetRef ref) async {
    final activeService = ref.read(activeSyncServiceProvider);
    if (activeService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.noActiveCloudSyncServiceMessage,
          ),
        ),
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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.disconnectedMessage),
        ),
      );

      // 刷新状态并等待完成
      final refreshResult = await ref.refresh(cloudSyncStatusProvider.future);
      // 使用刷新结果更新UI
      if (refreshResult['connected'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.syncStatusUpdatedMessage,
            ),
          ),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.disconnectFailedMessage}: $e',
          ),
        ),
      );
    }
  }
}