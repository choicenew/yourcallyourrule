import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';

class CloudSyncStatusWidget extends ConsumerWidget {
  const CloudSyncStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(cloudSyncStatusProvider);
    return statusAsync.when(
      data: (status) {
        final bool isConnected = status['connected'] ?? false;
        final bool isOnline = status['online'] ?? false;
        final String serviceName = status['service_name'] ?? 'None';

        IconData iconData;
        Color color;
        String text;

        if (isConnected && isOnline) {
          iconData = Icons.cloud_done;
          color = Colors.green;
          text = '$serviceName: Online';
        } else if (isConnected && !isOnline) {
          iconData = Icons.cloud_off;
          color = Colors.orange;
          text = '$serviceName: Offline';
        } else {
          iconData = Icons.cloud_off;
          color = Colors.grey;
          text = 'Not Connected';
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: color),
            const SizedBox(width: 8),
            Text(text),
          ],
        );
      },
      loading: () => const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 8),
          Text('Checking Status...'),
        ],
      ),
      error: (err, stack) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 8),
          Text('Error: ${err.toString()}'),
        ],
      ),
    );
  }
}