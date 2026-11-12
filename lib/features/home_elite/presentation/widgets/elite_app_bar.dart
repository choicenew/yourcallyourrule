import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/call_monitor/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EliteAppBar extends ConsumerWidget {
  final VoidCallback? onSwitchToPro;

  const EliteAppBar({
    super.key,
    this.onSwitchToPro,
  });

  Future<void> _handleStatusTap(BuildContext context, WidgetRef ref, bool isProtectionActive) async {
    final l10n = AppLocalizations.of(context);
    if (isProtectionActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((l10n as dynamic)?.enabledStatus as String? ?? 'Enabled'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      final granted = await CallScreeningPlugin.requestCallScreeningRole();
      if (granted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((l10n as dynamic)?.enabledStatus as String? ?? 'Enabled'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      if (context.mounted) {
        context.pushNamed(AppRouter.permissionManagement);
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (context.mounted) {
        context.pushNamed(AppRouter.permissionManagement);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isProtectionActive = true;
    final isVip = true;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pushNamed(AppRouter.purchase),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isVip
                              ? const Color(0xFFFFB800)
                              : theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: (isVip
                                      ? const Color(0xFFFFB800)
                                      : theme.colorScheme.primary)
                                  .withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shield_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (l10n as dynamic)?.appName as String? ?? 'YourCall YourRule',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _handleStatusTap(context, ref, isProtectionActive),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isProtectionActive
                                    ? theme.colorScheme.secondary
                                    : theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isProtectionActive
                                  ? ((l10n as dynamic)?.enabled as String? ?? 'Enabled')
                                  : ((l10n as dynamic)?.disabled as String? ?? 'Disabled'),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                color: isProtectionActive
                                    ? theme.colorScheme.secondary
                                    : theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 11,
                              color: isProtectionActive
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 18,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                onPressed: () => context.pushNamed(AppRouter.notifications),
                tooltip: (l10n as dynamic)?.notifications as String? ?? 'Notifications',
              ),
              if (onSwitchToPro != null)
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      size: 18,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  onPressed: onSwitchToPro,
                  tooltip: 'Pro',
                ),
            ],
          ),
        ],
      ),
    );
  }
}

@Preview(name: 'Elite App Bar', group: 'Elite Showcase')
Widget previewEliteAppBar() {
  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SafeArea(
          child: EliteAppBar(),
        ),
      ),
    ),
  );
}

class MinimalistCrownIcon extends StatelessWidget {
  final double size;
  final Color color;

  const MinimalistCrownIcon({
    super.key,
    this.size = 12,
    this.color = const Color(0xFFFFB300),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.75,
      child: CustomPaint(
        painter: _MinimalistCrownPainter(color: color),
      ),
    );
  }
}

class _MinimalistCrownPainter extends CustomPainter {
  final Color color;

  _MinimalistCrownPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path();
    path.moveTo(0, h * 0.20);
    path.lineTo(w * 0.25, h * 0.72);
    path.lineTo(w * 0.50, 0);
    path.lineTo(w * 0.75, h * 0.72);
    path.lineTo(w, h * 0.20);
    path.lineTo(w * 0.88, h * 0.85);
    path.lineTo(w * 0.12, h * 0.85);
    path.close();

    canvas.drawPath(path, paint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.08, h * 0.82, w * 0.84, h * 0.18),
        const Radius.circular(1),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _MinimalistCrownPainter oldDelegate) =>
      oldDelegate.color != color;
}
