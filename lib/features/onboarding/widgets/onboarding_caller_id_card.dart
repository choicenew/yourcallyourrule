import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_overlay/providers/call_overlay_style_security_provider.dart';
import 'package:yourcallyourrule/features/permissions/services/permission_service_impl.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 4：可选悬浮窗 (Overlay) 来电弹窗样式与权限控制卡片组件
class OnboardingCallerIdCard extends ConsumerStatefulWidget {
  const OnboardingCallerIdCard({super.key});

  @override
  ConsumerState<OnboardingCallerIdCard> createState() => _OnboardingCallerIdCardState();
}

class _OnboardingCallerIdCardState extends ConsumerState<OnboardingCallerIdCard> {
  bool _hasOverlayPermission = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final permissionService = ref.read(permissionServiceProvider);
    final granted = await permissionService.hasOverlayPermission();
    if (mounted) {
      setState(() {
        _hasOverlayPermission = granted;
        _isChecking = false;
      });
    }
  }

  Future<void> _requestOverlayPermission() async {
    final permissionService = ref.read(permissionServiceProvider);
    final granted = await permissionService.requestOverlayPermission();
    if (mounted) {
      setState(() {
        _hasOverlayPermission = granted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final overlayAsync = ref.watch(callOverlayStyleSecurityProvider);
    final config = overlayAsync.value;
    final notifier = ref.read(callOverlayStyleSecurityProvider.notifier);

    final bgColor = config?.backgroundColorStart ?? theme.colorScheme.surface;
    final numberColor = config?.textNumberColor ?? theme.colorScheme.onSurface;
    final nameColor = config?.textNameColor ?? theme.colorScheme.onSurfaceVariant;
    final fontSize = config?.numberFontSize ?? 16.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上层：悬浮窗 Preview
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: bgColor.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(Icons.person_rounded, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '+1 (800) ***-0***',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: numberColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.smartCallerId,
                            style: TextStyle(fontSize: 11, color: nameColor),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        l10n.overlayMode,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFeatureTag(Icons.layers_rounded, 'Optional Overlay', theme),
                    _buildFeatureTag(Icons.tune_rounded, 'Custom Style', theme),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.smartCallerId,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.overlayModeDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),

          // 下层：直接交互控制面板——悬浮窗权限申请与样式调优
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                // 1. 悬浮窗系统权限申请开关
                InkWell(
                  onTap: _requestOverlayPermission,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _hasOverlayPermission
                                ? Colors.green.withValues(alpha: 0.15)
                                : theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.layers_rounded,
                            color: _hasOverlayPermission ? Colors.green : theme.colorScheme.primary,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.overlayPermission,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                l10n.overlayPermissionDescription,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_isChecking)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _hasOverlayPermission
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _hasOverlayPermission ? l10n.granted : l10n.requestPermission,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: _hasOverlayPermission ? Colors.green : theme.colorScheme.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 16),
                // 2. 字体大小调优 Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.numberFontSize,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Slider(
                        value: fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 6,
                        onChanged: (val) {
                          notifier.setNumberFontSize(val);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTag(IconData icon, String label, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
