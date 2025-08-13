import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart' as permissionService;
import 'package:yourcallyourrule/core/provider/providers/permission_service_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class BatteryOptimizationPermissionWidget extends ConsumerStatefulWidget {
  const BatteryOptimizationPermissionWidget({super.key});

  @override
  ConsumerState<BatteryOptimizationPermissionWidget> createState() =>
      _BatteryOptimizationPermissionWidgetState();
}

class _BatteryOptimizationPermissionWidgetState
    extends ConsumerState<BatteryOptimizationPermissionWidget> {
  bool _hasPermission = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    setState(() {
      _isLoading = true;
    });
    final permissionService = ref.read(permissionServiceProvider);
    final hasPermission =
        await permissionService.hasBatteryOptimizationPermission();
    if (mounted) {
      setState(() {
        _hasPermission = hasPermission;
        _isLoading = false;
      });
    }
  }

  Future<void> _requestPermission() async {
    final permissionService = ref.read(permissionServiceProvider);
    final granted = await permissionService.requestBatteryOptimizationPermission();
    if (mounted) {
      setState(() {
        _hasPermission = granted;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(granted
              ? AppLocalizations.of(context)!.permissionGranted
              : AppLocalizations.of(context)!.permissionDenied),
          backgroundColor: granted ? Colors.green : Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        title: Text(AppLocalizations.of(context)!.batteryOptimizationPermission),
        subtitle:
            Text(AppLocalizations.of(context)!.batteryOptimizationPermissionDescription),
        value: _hasPermission,
        onChanged: (value) {
          if (value) {
            _requestPermission();
          } else {
            // Cannot revoke permission from app, user must do it in settings
            permissionService.openAppSettings();
          }
        },
        secondary: _isLoading
            ? const CircularProgressIndicator()
            : Icon(
                _hasPermission ? Icons.check_circle : Icons.error,
                color: _hasPermission ? Colors.green : Colors.red,
              ),
      ),
    );
  }
}