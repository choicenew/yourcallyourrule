import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/permission_service_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 5：核心权限授权卡片组件（全面支持实时状态检查与一键/单项授权落地）
class OnboardingPermissionsCard extends ConsumerStatefulWidget {
  const OnboardingPermissionsCard({super.key});

  @override
  ConsumerState<OnboardingPermissionsCard> createState() => _OnboardingPermissionsCardState();
}

class _OnboardingPermissionsCardState extends ConsumerState<OnboardingPermissionsCard> {
  bool _phoneGranted = false;
  bool _contactsGranted = false;
  bool _callScreeningGranted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatuses();
  }

  /// 全量检查三项核心权限状态
  Future<void> _checkPermissionStatuses() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final permissionService = ref.read(permissionServiceProvider);
      final phone = await permissionService.hasPermission('call');
      final contacts = await permissionService.hasPermission('contacts');

      if (mounted) {
        setState(() {
          _phoneGranted = phone;
          _contactsGranted = contacts;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// 请求单项权限
  Future<void> _requestSinglePermission(String name) async {
    final permissionService = ref.read(permissionServiceProvider);
    if (name == 'callScreening') {
      final res = await CallScreeningPlugin.requestCallScreeningRole();
      if (mounted) {
        setState(() => _callScreeningGranted = res);
      }
    } else {
      final granted = await permissionService.requestPermission(name);
      if (mounted) {
        setState(() {
          if (name == 'call') _phoneGranted = granted;
          if (name == 'contacts') _contactsGranted = granted;
        });
      }
    }
  }

  /// 一键申请所有必要核心权限
  Future<void> _requestAllPermissions() async {
    final l10n = AppLocalizations.of(context)!;
    final permissionService = ref.read(permissionServiceProvider);

    try {
      // 1. 批量申请电话与联系人系统权限
      final results = await permissionService.requestPermissions(['call', 'contacts']);
      
      // 2. 申请默认 Call Screening Role 拦截角权限
      final screeningRes = await CallScreeningPlugin.requestCallScreeningRole();

      if (mounted) {
        setState(() {
          _phoneGranted = results['call'] ?? false;
          _contactsGranted = results['contacts'] ?? false;
          _callScreeningGranted = screeningRes;
        });

        final allGranted = _phoneGranted && _contactsGranted;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              allGranted
                  ? l10n.allPermissionsGranted
                  : l10n.somePermissionsDenied,
            ),
            backgroundColor: allGranted ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.requestPermissionFailed(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            )
          else ...[
            _buildPermissionTile(
              name: 'call',
              icon: Icons.phone_rounded,
              title: l10n.phonePermission,
              description: l10n.phonePermissionDescription,
              isGranted: _phoneGranted,
              theme: theme,
              l10n: l10n,
            ),
            const SizedBox(height: 10),
            _buildPermissionTile(
              name: 'contacts',
              icon: Icons.contacts_rounded,
              title: l10n.contactsPermission,
              description: l10n.contactsPermissionDescription,
              isGranted: _contactsGranted,
              theme: theme,
              l10n: l10n,
            ),
            const SizedBox(height: 10),
            _buildPermissionTile(
              name: 'callScreening',
              icon: Icons.screen_lock_portrait_rounded,
              title: l10n.callScreeningPermission,
              description: l10n.callScreeningPermissionDescription,
              isGranted: _callScreeningGranted,
              theme: theme,
              l10n: l10n,
            ),
          ],

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: _requestAllPermissions,
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
    required String name,
    required IconData icon,
    required String title,
    required String description,
    required bool isGranted,
    required ThemeData theme,
    required AppLocalizations l10n,
  }) {
    return InkWell(
      onTap: () => _requestSinglePermission(name),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isGranted
                ? Colors.green.withValues(alpha: 0.5)
                : theme.colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isGranted
                    ? Colors.green.withValues(alpha: 0.15)
                    : theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isGranted ? Colors.green : theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isGranted
                    ? Colors.green.withValues(alpha: 0.15)
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isGranted ? Icons.check_circle_rounded : Icons.add_circle_outline_rounded,
                    size: 14,
                    color: isGranted ? Colors.green : theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isGranted ? l10n.granted : l10n.requestPermission,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isGranted ? Colors.green : theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
