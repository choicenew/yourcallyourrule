import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class AllCloudSyncStatusSection extends ConsumerWidget {
  const AllCloudSyncStatusSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSyncStatusAsync = ref.watch(allCloudSyncStatusProvider);

    return allSyncStatusAsync.when(
      data: (statuses) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey[700]!,
                Colors.blueGrey[800]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.allServicesStatusTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
               const SizedBox(height: 4), // Small spacing

              // --- Subtitle (Newly Added) ---
              Text(
                AppLocalizations.of(context)!.allServicesStatusSubtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 20), // Increased spacing before the list for better separation
              ...statuses.map((status) => _buildServiceStatusRow(context, status)),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text(
        '${AppLocalizations.of(context)!.loadStatusFailedMessage}: $error',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildServiceStatusRow(BuildContext context, Map<String, dynamic> status) {
    final serviceType = status['service_type'] as String;
    final isConnected = status['connected'] as bool;
    final isOnline = status['online'] as bool? ?? false;
    final error = status['error'] as String?;

    IconData _getServiceIcon(String serviceType) {
      switch (serviceType.toLowerCase()) {
        case 'webdav':
          return Icons.cloud_queue;
        case 'onedrive':
          return Icons.cloud;
        case 'googledrive':
          return Icons.cloud_circle;
        default:
          return Icons.storage;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(_getServiceIcon(serviceType), color: Colors.white, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              serviceType,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          if (error != null)
            Icon(Icons.error, color: Colors.redAccent, size: 24)
          else ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.power,
                  color: isConnected ? Colors.greenAccent : Colors.grey,
                  size: 24,
                ),
                Text(
                  isConnected ? AppLocalizations.of(context)!.connectedStatus : AppLocalizations.of(context)!.disconnectedStatus,
                  style: TextStyle(color: isConnected ? Colors.greenAccent : Colors.grey, fontSize: 10),
                )
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  isOnline ? Icons.signal_cellular_4_bar : Icons.signal_cellular_off,
                  color: isOnline ? Colors.greenAccent : Colors.redAccent,
                  size: 24,
                ),
                Text(
                  isOnline ? "Online" : "Offline",
                  style: TextStyle(color: isOnline ? Colors.greenAccent : Colors.redAccent, fontSize: 10),
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
}