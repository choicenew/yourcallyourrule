import 'package:material_ui/material_ui.dart';
import 'package:pyro_stir_protocol/pyro_stir_protocol.dart';

/// Visual badge indicating STIR/SHAKEN caller verification status.
class StirVerificationBadge extends StatelessWidget {
  final StirVerificationStatus status;

  const StirVerificationBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color bg;
    Color fg;
    IconData icon;

    switch (status) {
      case StirVerificationStatus.passed:
        bg = colorScheme.primaryContainer;
        fg = colorScheme.onPrimaryContainer;
        icon = Icons.verified_user;
        break;
      case StirVerificationStatus.failed:
        bg = colorScheme.errorContainer;
        fg = colorScheme.onErrorContainer;
        icon = Icons.gpp_bad;
        break;
      case StirVerificationStatus.notVerified:
      case StirVerificationStatus.notAvailable:
        bg = colorScheme.surfaceContainerHighest;
        fg = colorScheme.onSurfaceVariant;
        icon = Icons.shield_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            status.label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
