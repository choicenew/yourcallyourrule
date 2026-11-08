import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_statistic_hub/pyro_phone_call_statistic_hub.dart';
import 'package:pyro_phone_call_statistic_ui/pyro_phone_call_statistic_ui.dart' as stat_pkg_ui;
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallStatisticsPage extends ConsumerWidget {
  const CallStatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final statData = ref.watch(phoneCallStatisticControlCenterProvider).statisticData;

    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 3,
        onTap: (index) => AppRouter.navigateToTab(context, index),
      ),
      appBar: AppBar(title: Text(localizations.statisticsPageTitle)),
      body: stat_pkg_ui.PyroPhoneCallStatisticCardWidget(
        data: statData,
        onTap: () => ref.read(phoneCallStatisticControlCenterProvider).refreshStatistics(),
      ),
    );
  }
}