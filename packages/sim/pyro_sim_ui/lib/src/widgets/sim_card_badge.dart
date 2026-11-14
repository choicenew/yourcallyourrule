import 'package:material_ui/material_ui.dart';
import 'package:pyro_sim_protocol/pyro_sim_protocol.dart';

/// Compact visual badge for representing SIM 1 or SIM 2.
class SimCardBadge extends StatelessWidget {
  final SimSlotIndex slot;
  final String? carrierName;

  const SimCardBadge({
    super.key,
    required this.slot,
    this.carrierName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isSlot1 = slot == SimSlotIndex.slot1;
    final bg = isSlot1 ? colorScheme.primaryContainer : colorScheme.secondaryContainer;
    final fg = isSlot1 ? colorScheme.onPrimaryContainer : colorScheme.onSecondaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sim_card, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            carrierName != null && carrierName!.isNotEmpty ? '${slot.label} ($carrierName)' : slot.label,
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
