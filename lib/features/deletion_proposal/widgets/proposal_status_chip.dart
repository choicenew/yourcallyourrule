import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ProposalStatusChip extends StatelessWidget {
  final String status;

  const ProposalStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    IconData icon;
    String displayText;

    switch (status.toLowerCase()) {
      case 'approved':
        chipColor = EliteDopamineTheme.freshMint;
        icon = Icons.check_circle;
        displayText = AppLocalizations.of(context)!.approved;
        break;
      case 'rejected':
        chipColor = Colors.red;
        icon = Icons.cancel;
        displayText = AppLocalizations.of(context)!.rejected;
        break;
      case 'completed':
        chipColor = Colors.blue;
        icon = Icons.done_all;
        displayText = AppLocalizations.of(context)!.completed;
        break;
      case 'pending':
      default:
        chipColor = Colors.orange;
        icon = Icons.pending;
        displayText = AppLocalizations.of(context)!.pending;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: chipColor),
          const SizedBox(width: 4),
          Text(
            displayText,
            style: TextStyle(
              color: chipColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
