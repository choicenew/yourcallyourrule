import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 5：核心权限授权卡片组件
class OnboardingPermissionsCard extends StatefulWidget {
  const OnboardingPermissionsCard({super.key});

  @override
  State<OnboardingPermissionsCard> createState() => _OnboardingPermissionsCardState();
}

class _OnboardingPermissionsCardState extends State<OnboardingPermissionsCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.grantNecessaryPermissions,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.onboardingPermissionsDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          _buildPermissionTile(
            icon: Icons.phone_rounded,
            title: l10n.phonePermission,
            description: l10n.phonePermissionDescription,
            theme: theme,
          ),
          const SizedBox(height: 10),
          _buildPermissionTile(
            icon: Icons.contacts_rounded,
            title: l10n.contactsPermission,
            description: l10n.contactsPermissionDescription,
            theme: theme,
          ),
          const SizedBox(height: 10),
          _buildPermissionTile(
            icon: Icons.screen_lock_portrait_rounded,
            title: l10n.callScreeningPermission,
            description: l10n.callScreeningPermissionDescription,
            theme: theme,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () async {
              final result = await CallScreeningPlugin.requestCallScreeningRole();
              if (!result && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.callScreeningPermissionNotGranted)),
                );
              }
            },
            icon: const Icon(Icons.security_rounded, size: 18),
            label: Text(l10n.grantPermissions),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String description,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
                Text(description, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
