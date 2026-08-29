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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.deviceManagementTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCurrentDeviceSection(currentDeviceAsync),
                  const SizedBox(height: 24),
                                     GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd), //插入广告
            const SizedBox(height: 16),
                  _buildRegisteredDevicesSection(
                      registeredDevicesAsync, activeService),
              //插入广告
       const SizedBox(height: 16),
        nativeAdWidgetMedium(adWidth: 400, adHeight: 320),
    /*    
InlineAdaptiveBannerAdWidget(
         adInfo: AdManager.adaptiveBannerAd,width: 400,)
     */    
                ],
              ),
            ),
    );
  }

  Widget _buildCurrentDeviceSection(
      AsyncValue<DeviceEntity> currentDeviceAsync) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.currentDeviceTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            currentDeviceAsync.when(
              data: (device) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.deviceNameLabel),
                    subtitle: Text(device.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showRenameDeviceDialog(device),
                    ),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.deviceModelLabel),
                    subtitle: Text(device.model),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.deviceIDLabel),
                    subtitle: Text(device.id),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.lastSyncLabel),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(device.lastSyncTime),
                    ),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text(AppLocalizations.of(context)!.errorOccurredMessage(error.toString())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisteredDevicesSection(
      AsyncValue<List<DeviceEntity>> registeredDevicesAsync,
      CloudSyncService? activeService) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.registeredDevicesTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (activeService != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: Text(AppLocalizations.of(context)!.syncDevicesButton),
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
                  style: const TextStyle(color: Colors.orange),
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text(AppLocalizations.of(context)!.errorOccurredMessage(error.toString())),
            ),
          ],
        ),
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
