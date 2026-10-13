import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM 卡槽 Tab 切换栏组件 (自动识别单卡/双卡在卡状态，采用简短地道的 SIM Slot 1 / 2 排版)
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
        // 判断 SIM 1 与 SIM 2 是否真正存在并激活
        final isSim1Active = simCards.any((sim) => (sim.simSlotIndex ?? 0) == 0) || simCards.isNotEmpty;
        final isSim2Active = simCards.any((sim) => (sim.simSlotIndex ?? 0) == 1) || simCards.length >= 2;

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
                  slotName: 'SIM Slot 1',
                  statusText: isSim1Active ? l10n.enabledStatus : l10n.disabledStatus,
                  color: isSim1Active ? EliteDopamineTheme.freshMint : EliteDopamineTheme.textMuted,
                  isActive: isSim1Active,
                  isSelected: selectedSimSlot == 0,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildSimTabButton(
                  slotIndex: 1,
                  slotName: 'SIM Slot 2',
                  statusText: isSim2Active ? l10n.enabledStatus : l10n.disabledStatus,
                  color: isSim2Active ? EliteDopamineTheme.sunsetTangerine : EliteDopamineTheme.textMuted,
                  isActive: isSim2Active,
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
    required String slotName,
    required String statusText,
    required Color color,
    required bool isActive,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => onSimSlotSelected(slotIndex),
      borderRadius: BorderRadius.circular(13),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
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
            Icon(
              Icons.signal_cellular_alt_rounded,
              size: 14,
              color: isActive ? color : EliteDopamineTheme.textMuted,
            ),
            const SizedBox(width: 4),
            Text(
              '$slotName ($statusText)',
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: isSelected ? EliteDopamineTheme.textPrimary : EliteDopamineTheme.textSecondary,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive ? color : EliteDopamineTheme.textMuted,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
