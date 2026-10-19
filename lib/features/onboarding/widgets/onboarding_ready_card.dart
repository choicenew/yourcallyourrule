import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 6：准备就绪卡片组件
class OnboardingReadyCard extends StatelessWidget {
  const OnboardingReadyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green.withValues(alpha: 0.3), width: 2),
            ),
            child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 64),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.ready,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.allSettingsCompleted,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.onboardingCompleteDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurfaceVariant, height: 1.4),
          ),
        ],
      ),
    );
  }
}
