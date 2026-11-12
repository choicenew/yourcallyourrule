import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';

import 'package:yourcallyourrule/features/sync/domain/device_entity.dart';
import 'package:yourcallyourrule/features/sync/providers/cloud_sync/cloud_sync_provider.dart';
import 'package:yourcallyourrule/features/sync/providers/cloud_sync/device_management_provider.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/cloud_sync_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class DeviceManagementPage extends ConsumerStatefulWidget {
  const DeviceManagementPage({super.key});

  @override
  ConsumerState<DeviceManagementPage> createState() => _DeviceManagementPageState();
}

class _DeviceManagementPageState extends ConsumerState<DeviceManagementPage> {
  bool _isSyncing = false;

  @override
  Widget build(BuildContext context) {
    final currentDeviceAsync = ref.watch(currentDeviceProvider);
    final registeredDevicesAsync = ref.watch(registeredDevicesProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.deviceManagementTitle,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCurrentDeviceSection(context, currentDeviceAsync),
            const SizedBox(height: 16),
            const AdsInlineBanner(),
            const SizedBox(height: 16),
            _buildRegisteredDevicesSection(context, registeredDevicesAsync),
            const SizedBox(height: 16),
            const AdsInlineBanner(),
            const SizedBox(height: 16),
            _buildSyncActionsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentDeviceSection(
    BuildContext context,
    AsyncValue<DeviceEntity?> currentDeviceAsync,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.1,
        ),
      ),
      child: currentDeviceAsync.when(
        data: (device) {
          if (device == null) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No current device info'),
            );
          }
          final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.currentDeviceTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(AppLocalizations.of(context)!.deviceNameLabel),
                subtitle: Text(device.name, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                leading: Icon(Icons.phone_android_rounded, color: Theme.of(context).colorScheme.primary),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.deviceModelLabel),
                subtitle: Text(device.model, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Theme.of(context).colorScheme.onSurface)),
                leading: Icon(Icons.info_outline_rounded, color: Theme.of(context).colorScheme.primary),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.deviceIDLabel),
                subtitle: Text(device.id, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                leading: Icon(Icons.fingerprint_rounded, color: Theme.of(context).colorScheme.primary),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.lastSyncTimeLabel),
                subtitle: Text(dateFormat.format(device.lastSyncTime), style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface)),
                leading: Icon(Icons.access_time_rounded, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Failed to load device info: $error'),
        ),
      ),
    );
  }

  Widget _buildRegisteredDevicesSection(
    BuildContext context,
    AsyncValue<List<DeviceEntity>> registeredDevicesAsync,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.syncDevicesTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const Divider(height: 1),
          registeredDevicesAsync.when(
            data: (devices) {
              if (devices.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.noRegisteredDevicesMessage),
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: devices.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return _buildDeviceListItem(devices[index]);
                },
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Error: $error'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceListItem(DeviceEntity device) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return ListTile(
      leading: Icon(Icons.devices_rounded, color: Theme.of(context).colorScheme.primary),
      title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${device.model} | Last Sync: ${dateFormat.format(device.lastSyncTime)}'),
    );
  }

  Widget _buildSyncActionsSection(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isSyncing ? null : _syncWithCloud,
      icon: _isSyncing
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Icon(Icons.sync_rounded),
      label: Text(AppLocalizations.of(context)!.manualSyncButton),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Future<void> _syncWithCloud() async {
    setState(() => _isSyncing = true);
    try {
      final syncService = ref.read(cloudSyncServiceProvider);
      await syncService.startIncrementalSync();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.syncCompletedMessage)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.syncFailedMessage}: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }
}
