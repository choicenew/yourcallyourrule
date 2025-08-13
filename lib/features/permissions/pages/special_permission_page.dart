import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/permissions/widgets/battery_optimization_permission_widget.dart';
import 'package:yourcallyourrule/features/permissions/widgets/overlay_permission_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class SpecialPermissionPage extends StatelessWidget {
  const SpecialPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.permissionTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          OverlayPermissionWidget(),
          SizedBox(height: 16),
          BatteryOptimizationPermissionWidget(),
        ],
      ),
    );
  }
}