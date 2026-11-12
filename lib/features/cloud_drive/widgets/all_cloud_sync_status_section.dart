import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_ui/pyro_cloud_drive_ui.dart' as cloud_ui;
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 云盘全服务同步状态 UI 组件
/// 100% 渲染包内 pyro_cloud_drive_ui 标准组件
class AllCloudSyncStatusSection extends ConsumerWidget {
  const AllCloudSyncStatusSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.allServicesStatusTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          const cloud_ui.CloudSyncStatusWidget(
            providerName: 'Cloud Drive',
            isConnected: true,
          ),
        ],
      ),
    );
  }
}
