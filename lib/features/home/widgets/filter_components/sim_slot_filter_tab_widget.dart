import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/device/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'filter_switch_tile.dart';

/// SIM 卡槽独立分栏过滤器组件
class SimSlotFilterTabWidget extends ConsumerWidget {
  final TabController? tabController;
  final Widget callFilterSwitch;

  const SimSlotFilterTabWidget({
    super.key,
    required this.tabController,
    required this.callFilterSwitch,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simCardsAsync = ref.watch(simCardsProvider);
    final l10n = AppLocalizations.of(context);

    return simCardsAsync.when(
      data: (simCards) {
        if (simCards.isEmpty) {
          return Center(
            child: Text(
              l10n.noSimCardsDetected,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        }

        if (tabController == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: tabController,
              tabs: simCards.map((simInfo) {
                final simSlot = simInfo.simSlotIndex ?? 0;
                return Tab(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sim_card,
                        color: simSlot == 0 ? Colors.red : Colors.green,
                      ),
                      Text('SIM ${simSlot + 1}'),
                      Flexible(
                        child: Text(
                          simInfo.carrierName ?? '',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            SizedBox(
              height: 600,
              child: TabBarView(
                controller: tabController,
                children: simCards.map((simInfo) {
                  final simSlot = simInfo.simSlotIndex ?? 0;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.sim_card, color: Colors.blue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SIM ${simSlot + 1}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        simInfo.carrierName ?? l10n.unassignedSIMCard,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          callFilterSwitch,
                          const SizedBox(height: 16),
                          SimSlotFilterTile(
                            title: l10n.localCountFilter,
                            subtitle: l10n.localCountFilterDescription,
                            icon: Icons.filter_list,
                            color: Colors.orange,
                            simSlot: simSlot,
                            filterType: CallFilterType.localCount,
                            serviceId: 'LocalCountFilterService',
                          ),
                          const SizedBox(height: 16),
                          SimSlotFilterTile(
                            title: l10n.remoteNumberFilter,
                            subtitle: l10n.remoteNumberFilterDescription,
                            icon: Icons.filter,
                            color: Colors.purple,
                            simSlot: simSlot,
                            filterType: CallFilterType.remoteNumber,
                            serviceId: 'RemoteNumberFilterService',
                          ),
                          const SizedBox(height: 16),
                          SimSlotFilterTile(
                            title: l10n.timeInterceptor,
                            subtitle: l10n.timeInterceptorDescription,
                            icon: Icons.timer,
                            color: Colors.teal,
                            simSlot: simSlot,
                            filterType: CallFilterType.basicRule,
                            serviceId: 'TimeInterceptorService',
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(
        child: Text(l10n.dataLoadFailure(err.toString())),
      ),
    );
  }
}
