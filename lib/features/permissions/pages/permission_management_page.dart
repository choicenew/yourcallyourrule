import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/services/permission_service.dart';
import 'package:yourcallyourrule/core/provider/providers/permission_service_provider.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 权限管理页面
class PermissionManagementPage extends ConsumerStatefulWidget {
  const PermissionManagementPage({super.key});

  @override
  ConsumerState<PermissionManagementPage> createState() => _PermissionManagementPageState();
}

class _PermissionManagementPageState extends ConsumerState<PermissionManagementPage> {
  bool _isLoading = true;
  Map<String, bool> _permissionStatus = {};
  late List<PermissionItem> _permissionItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _permissionItems = [
      PermissionItem(
        name: 'call',
        title: AppLocalizations.of(context)!.phonePermission,
        description: AppLocalizations.of(context)!.phonePermissionDescription,
        icon: Icons.phone,
        color: Colors.green,
      ),
      
      PermissionItem(
        name: 'sms',
        title: AppLocalizations.of(context)!.smsPermission,
        description: AppLocalizations.of(context)!.smsPermissionDescription,
        icon: Icons.sms,
        color: Colors.blue,
      ),
      PermissionItem(
        name: 'contacts',
        title: AppLocalizations.of(context)!.contactsPermission,
        description: AppLocalizations.of(context)!.contactsPermissionDescription,
        icon: Icons.contacts,
        color: Colors.orange,
      ),
      PermissionItem(
        name: 'storage',
        title: AppLocalizations.of(context)!.storagePermission,
        description: AppLocalizations.of(context)!.storagePermissionDescription,
        icon: Icons.storage,
        color: Colors.purple,
      ),
      PermissionItem(
        name: 'overlay',
        title: AppLocalizations.of(context)!.overlayPermission,
        description: AppLocalizations.of(context)!.overlayPermissionDescription,
        icon: Icons.picture_in_picture,
        color: Colors.teal,
      ),
      PermissionItem(
        name: 'notification',
        title: AppLocalizations.of(context)!.notificationPermission,
        description: AppLocalizations.of(context)!.notificationPermissionDescription,
        icon: Icons.notifications,
        color: Colors.red,
      ),
      PermissionItem(
        name: 'battery',
        title: AppLocalizations.of(context)!.batteryOptimizationPermission,
        description: AppLocalizations.of(context)!.batteryOptimizationPermissionDescription,
        icon: Icons.battery_charging_full,
        color: Colors.blueGrey,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final permissionService = ref.read(permissionServiceProvider);
      final Map<String, bool> status = {};

      for (final item in _permissionItems) {
        status[item.name] = await permissionService.hasPermission(item.name);
      }

      setState(() {
        _permissionStatus = status;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.checkPermissionFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _requestPermission(String permission) async {
    try {
      final permissionService = ref.read(permissionServiceProvider);
      final granted = await permissionService.requestPermission(permission);

      setState(() {
        _permissionStatus[permission] = granted;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(granted ? AppLocalizations.of(context)!.permissionGranted : AppLocalizations.of(context)!.permissionDenied),
        backgroundColor: granted ? Colors.green : Colors.orange,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.requestPermissionFailed(e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _requestAllPermissions() async {
    try {
      final permissionService = ref.read(permissionServiceProvider);
      final permissions = _permissionItems.map((item) => item.name).toList();
      final results = await permissionService.requestPermissions(permissions);

      setState(() {
        _permissionStatus = results;
      });

      final allGranted = results.values.every((granted) => granted);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(allGranted ? AppLocalizations.of(context)!.allPermissionsGranted : AppLocalizations.of(context)!.somePermissionsDenied),
        backgroundColor: allGranted ? Colors.green : Colors.orange,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.requestPermissionFailed(e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _openAppSettings() async {
    try {
      final permissionService = ref.read(permissionServiceProvider);
      await permissionService.openAppSettings();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.openAppSettingsFailed(e.toString())),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.permissionManagement),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _checkPermissions,
            tooltip: AppLocalizations.of(context)!.refreshPermissionStatus,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openAppSettings,
            tooltip: AppLocalizations.of(context)!.openAppSettings,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFF3E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildPermissionsList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _requestAllPermissions,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5A623),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(AppLocalizations.of(context)!.requestAllPermissions, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildPermissionsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoCard(),
        const SizedBox(height: 16),
        ..._permissionItems.map((item) => _buildPermissionCard(item)),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5A623).withValues(alpha:0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Color(0xFFF5A623),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.permissionManagement,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.onboardingPermissionsDescription,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionCard(PermissionItem item) {
    final isGranted = _permissionStatus[item.name] ?? false;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha:0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isGranted ? Colors.green.withValues(alpha:0.1) : Colors.red.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isGranted ? AppLocalizations.of(context)!.granted : AppLocalizations.of(context)!.notGranted,
                style: TextStyle(
                  fontSize: 12,
                  color: isGranted ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                isGranted ? Icons.check_circle : Icons.add_circle,
                color: isGranted ? Colors.green : const Color(0xFFF5A623),
              ),
              onPressed: () => _requestPermission(item.name),
              tooltip: isGranted ? AppLocalizations.of(context)!.granted : AppLocalizations.of(context)!.requestPermission,
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionItem {
  final String name;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  PermissionItem({
    required this.name,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}