import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM 卡槽 Tab 切换栏组件
class PrimaryFilterSimSlotBar extends ConsumerWidget {
  final AppLocalizations l10n;
  final int selectedSimSlot;
  final ValueChanged<int> onSimSlotSelected;

  const PrimaryFilterSimSlotBar({
    super.key,
    required this.l10n,
    required this.selectedSimSlot,
    required this.onSimSlotSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simCardsAsync = ref.watch(simCardsProvider);

    return simCardsAsync.when(
      data: (simCards) {
        return Container(
          decoration: BoxDecoration(
            color: EliteDopamineTheme.slateSubtle,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(3),
          child: Row(
            children: [
              Expanded(
                child: _buildSimTabButton(
                  slotIndex: 0,
                  label: '${l10n.simSlotPosition(1)} (${l10n.enabledStatus})',
                  color: EliteDopamineTheme.freshMint,
                  isSelected: selectedSimSlot == 0,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildSimTabButton(
                  slotIndex: 1,
                  label: '${l10n.simSlotPosition(2)} (${l10n.enabledStatus})',
                  color: EliteDopamineTheme.sunsetTangerine,
                  isSelected: selectedSimSlot == 1,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildSimTabButton({
    required int slotIndex,
    required String label,
    required Color color,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => onSimSlotSelected(slotIndex),
      borderRadius: BorderRadius.circular(13),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_cellular_alt_rounded, size: 14, color: color),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: isSelected ? EliteDopamineTheme.textPrimary : EliteDopamineTheme.textBody,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
