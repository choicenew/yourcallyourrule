import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/call_hero_command_banner.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/statistic_card.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/trend_chart_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/peak_hours_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/block_donut_chart_card.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/sim_bar_chart_card.dart';

class CallStatisticsContainerWidget extends ConsumerStatefulWidget {
  const CallStatisticsContainerWidget({super.key});

  @override
  ConsumerState<CallStatisticsContainerWidget> createState() =>
      _CallStatisticsContainerWidgetState();
}

class _CallStatisticsContainerWidgetState
    extends ConsumerState<CallStatisticsContainerWidget> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(callStatisticsProvider);

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null) {
      return Center(
        child: Text(
          state.error!,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CallHeroCommandBanner(state: state),
          const SizedBox(height: 14),

          _buildAdPlaceholder(),
          const SizedBox(height: 14),

          _buildStatsGrid(context, state),
          const SizedBox(height: 14),

          const AdsInlineBanner(),
          const SizedBox(height: 14),

          const TrendChartCard(),
          const SizedBox(height: 14),

          const BlockDonutChartCard(),
          const SizedBox(height: 14),

          const SimBarChartCard(),
          const SizedBox(height: 14),

          const PeakHoursCard(),
          const SizedBox(height: 14),

          _buildExportButton(context),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, CallStatisticsState state) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatisticCard(
                icon: Icons.shield,
                iconColor: colorScheme.error,
                backgroundColor: colorScheme.surface,
                title: state.blockedCallsCount.toString(),
                subtitle: l10n.blockedCallsTitle,
                period: 'Week',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatisticCard(
                icon: Icons.sms_failed,
                iconColor: colorScheme.secondary,
                backgroundColor: colorScheme.surface,
                title: state.filteredSmsCount.toString(),
                subtitle: 'Filtered SMS',
                period: 'Week',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatisticCard(
                icon: Icons.check_circle_outline,
                iconColor: Colors.green,
                backgroundColor: colorScheme.surface,
                title: state.allowRulesCount.toString(),
                subtitle: 'Allow Rules',
                period: 'Total',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatisticCard(
                icon: Icons.block,
                iconColor: colorScheme.error,
                backgroundColor: colorScheme.surface,
                title: state.blockRulesCount.toString(),
                subtitle: 'Block Rules',
                period: 'Total',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdPlaceholder() {
    return const AdsInlineBanner();
  }

  Widget _buildExportButton(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.download),
        label: const Text('Export Data'),
      ),
    );
  }
}
