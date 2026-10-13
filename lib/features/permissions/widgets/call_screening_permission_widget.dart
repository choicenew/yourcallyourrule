import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_protection_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/features/home/di/home_stats_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 系统默认来电拦截与筛选权限控制卡片
class CallScreeningPermissionWidget extends ConsumerStatefulWidget {
  const CallScreeningPermissionWidget({super.key});

  @override
  ConsumerState<CallScreeningPermissionWidget> createState() => _CallScreeningPermissionWidgetState();
}

class _CallScreeningPermissionWidgetState extends ConsumerState<CallScreeningPermissionWidget> {
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
    CallProtectionService().clearCachedStatus();
    final isGranted = await CallProtectionService().isProtectionActive();
    if (mounted) {
      setState(() {
        _hasPermission = isGranted;
        _isLoading = false;
      });
    }
  }

  Future<void> _requestPermission() async {
    CallProtectionService().clearCachedStatus();
    final granted = await CallScreeningPlugin.requestCallScreeningRole();
    if (mounted) {
      setState(() {
        _hasPermission = granted;
      });
      ref.invalidate(homeStatsProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(granted
              ? AppLocalizations.of(context)!.permissionGranted
              : AppLocalizations.of(context)!.callScreeningPermissionNotGranted),
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
        title: Text(AppLocalizations.of(context)!.callScreeningPermission),
        subtitle: Text(AppLocalizations.of(context)!.callScreeningPermissionDescription),
        value: _hasPermission,
        onChanged: (_) => _requestPermission(),
        secondary: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                _hasPermission ? Icons.check_circle : Icons.error_outline_rounded,
                color: _hasPermission ? Colors.green : Colors.orange,
              ),
      ),
    );
  }
}
