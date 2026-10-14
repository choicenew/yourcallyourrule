import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/cloud_sync/services/cloud_sync_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// Page for managing devices and multi-device synchronization
class DeviceManagementPage extends ConsumerStatefulWidget {
  /// Constructor
  const DeviceManagementPage({super.key});

  @override
  ConsumerState<DeviceManagementPage> createState() =>
      _DeviceManagementPageState();
}

class _DeviceManagementPageState extends ConsumerState<DeviceManagementPage> {
  final _deviceNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDeviceAsync = ref.watch(currentDeviceProvider);
    final registeredDevicesAsync = ref.watch(registeredDevicesProvider);
    final activeService = ref.watch(activeSyncServiceProvider);

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCurrentDeviceSection(currentDeviceAsync),
                  const SizedBox(height: 16),
                  GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
                  const SizedBox(height: 16),
                  _buildRegisteredDevicesSection(
                      registeredDevicesAsync, activeService),
                  const SizedBox(height: 16),
                  nativeAdWidgetMedium(adWidth: 400, adHeight: 320),
                ],
              ),
            ),
    );
  }

  Widget _buildCurrentDeviceSection(
      AsyncValue<DeviceEntity> currentDeviceAsync) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.smartphone_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.currentDeviceTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 16),
          currentDeviceAsync.when(
            data: (device) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppLocalizations.of(context)!.deviceNameLabel, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  subtitle: Text(device.name, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                  trailing: IconButton(
                    icon: Icon(Icons.edit_note_rounded, size: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    onPressed: () => _showRenameDeviceDialog(device),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppLocalizations.of(context)!.deviceModelLabel, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  subtitle: Text(device.model, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Theme.of(context).colorScheme.onSurface)),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppLocalizations.of(context)!.deviceIDLabel, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  subtitle: Text(device.id, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppLocalizations.of(context)!.lastSyncLabel, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(device.lastSyncTime),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            error: (error, stack) => Text(AppLocalizations.of(context)!.errorOccurredMessage(error.toString())),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisteredDevicesSection(
      AsyncValue<List<DeviceEntity>> registeredDevicesAsync,
      CloudSyncService? activeService) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.devices_rounded, color: Theme.of(context).colorScheme.secondary, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.registeredDevicesTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              if (activeService != null)
                ElevatedButton.icon(
                  icon: const Icon(Icons.sync_rounded, size: 16),
                  label: Text(AppLocalizations.of(context)!.syncDevicesButton),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _syncDevices(activeService),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (activeService == null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.configureCloudSyncServiceMessage,
                style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
              ),
            ),
          registeredDevicesAsync.when(
            data: (devices) => devices.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.noDevicesRegisteredMessage),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return _buildDeviceListItem(device);
                    },
                  ),
            loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            error: (error, stack) => Text(AppLocalizations.of(context)!.errorOccurredMessage(error.toString())),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceListItem(DeviceEntity device) {
    final currentDeviceAsync = ref.watch(currentDeviceProvider);
    bool isCurrentDevice = false;

    if (currentDeviceAsync is AsyncData<DeviceEntity>) {
      isCurrentDevice = currentDeviceAsync.value.id == device.id;
    }

    return ListTile(
      title: Row(
        children: [
          Text(device.name),
          if (isCurrentDevice)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Chip(
                label: Text(AppLocalizations.of(context)!.currentDeviceLabel),
                backgroundColor: Colors.green,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(device.model),
          Text(
              '${AppLocalizations.of(context)!.lastSyncLabel}: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(device.lastSyncTime)}'),
        ],
      ),
      trailing: !isCurrentDevice
          ? IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showUnregisterDeviceDialog(device),
            )
          : null,
    );
  }

  Future<void> _showRenameDeviceDialog(DeviceEntity device) async {
    _deviceNameController.text = device.name;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.renameDeviceTitle),
          content: TextField(
            controller: _deviceNameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.deviceNameLabel,
              hintText: AppLocalizations.of(context)!.enterNewDeviceNameHint,
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancelButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.saveButton),
              onPressed: () async {
                if (_deviceNameController.text.trim().isNotEmpty) {
                  setState(() {
                    _isLoading = true;
                  });

                  Navigator.of(context).pop();

                  try {
                    final deviceService =
                        ref.read(deviceManagementServiceProvider);
                    await deviceService
                        .updateDeviceName(_deviceNameController.text.trim());

                    // Refresh the device list
                    ref.refresh(currentDeviceProvider);
                    ref.refresh(registeredDevicesProvider);

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(AppLocalizations.of(context)!.deviceRenamedSuccessfullyMessage)),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppLocalizations.of(context)!.errorRenamingDeviceMessage(e.toString()))),
                      );
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUnregisterDeviceDialog(DeviceEntity device) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.unregisterDeviceTitle),
          content: Text(AppLocalizations.of(context)!.unregisterDeviceConfirmationMessage(device.name)),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancelButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.unregisterButton),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                Navigator.of(context).pop();

                try {
                  final deviceService =
                      ref.read(deviceManagementServiceProvider);
                  await deviceService.unregisterDevice(device.id);

                  // Refresh the device list
                  ref.refresh(registeredDevicesProvider);

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!.deviceUnregisteredSuccessfullyMessage)),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.errorUnregisteringDeviceMessage(e.toString()))),
                    );
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _syncDevices(CloudSyncService syncService) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final deviceService = ref.read(deviceManagementServiceProvider);
      final currentDevice = await deviceService.getCurrentDevice();

      // Update the last sync time for the current device
      await deviceService.updateDeviceSyncStatus(
        currentDevice.id,
        DateTime.now(),
      );

      // Register the current device with the cloud service
      await syncService.registerDeviceForSync(currentDevice);

      // Sync devices from the cloud
      await syncService.syncDevicesFromCloud();

      // Refresh the device list
      ref.refresh(currentDeviceProvider);
      ref.refresh(registeredDevicesProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.devicesSynchronizedSuccessfullyMessage)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorSynchronizingDevicesMessage(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
