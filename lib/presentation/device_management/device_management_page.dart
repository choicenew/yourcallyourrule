import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/cloud_sync/services/cloud_sync_service.dart';

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
        title: const Text('Device Management'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurrentDeviceSection(currentDeviceAsync),
                  const SizedBox(height: 24),
                  _buildRegisteredDevicesSection(
                      registeredDevicesAsync, activeService),
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
            const Text(
              'Current Device',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            currentDeviceAsync.when(
              data: (device) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text('Device Name'),
                    subtitle: Text(device.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showRenameDeviceDialog(device),
                    ),
                  ),
                  ListTile(
                    title: const Text('Device Model'),
                    subtitle: Text(device.model),
                  ),
                  ListTile(
                    title: const Text('Device ID'),
                    subtitle: Text(device.id),
                  ),
                  ListTile(
                    title: const Text('Last Sync'),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(device.lastSyncTime),
                    ),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
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
                const Text(
                  'Registered Devices',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (activeService != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: const Text('Sync Devices'),
                    onPressed: () => _syncDevices(activeService),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (activeService == null)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please configure a cloud sync service to enable multi-device synchronization.',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            registeredDevicesAsync.when(
              data: (devices) => devices.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No devices registered yet.'),
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
              error: (error, stack) => Text('Error: $error'),
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
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Chip(
                label: Text('Current'),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(device.model),
          Text(
              'Last Sync: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(device.lastSyncTime)}'),
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
          title: const Text('Rename Device'),
          content: TextField(
            controller: _deviceNameController,
            decoration: const InputDecoration(
              labelText: 'Device Name',
              hintText: 'Enter a new name for this device',
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
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
                        const SnackBar(
                            content: Text('Device renamed successfully')),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error renaming device: $e')),
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
          title: const Text('Unregister Device'),
          content: Text('Are you sure you want to unregister ${device.name}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Unregister'),
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
                      const SnackBar(
                          content: Text('Device unregistered successfully')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error unregistering device: $e')),
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
          const SnackBar(content: Text('Devices synchronized successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error synchronizing devices: $e')),
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
