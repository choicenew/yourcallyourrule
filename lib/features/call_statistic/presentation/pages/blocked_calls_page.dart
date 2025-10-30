import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';

import 'package:yourcallyourrule/features/call_statistic/domain/providers/blocked_calls_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/widgets/blocked_calls_chart.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class BlockedCallsPage extends ConsumerStatefulWidget {
  const BlockedCallsPage({super.key});

  @override
  ConsumerState<BlockedCallsPage> createState() => BlockedCallsPageState();
}

class BlockedCallsPageState extends ConsumerState<BlockedCallsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(blockedCallsProvider.notifier).changeTab(_tabController.index);
      }
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(blockedCallsProvider);
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.blockedCallsTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: localizations.allCallsTab),
            Tab(text: localizations.phoneCallsTab),
            Tab(text: localizations.smsTab),
          ],
        ),
      ),
      body: stateAsync.when(
        data: (state) {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlockedCallsChart(weeklyData: state.weeklyChartData),
                ),
              ),
              const InlineAdaptiveBannerAdWidget(adInfo: AdManager.adaptiveBannerAd),
              Expanded(
                flex: 3,
                child: state.logs.isEmpty
                  ? Center(child: Text(localizations.noData)) 
                  : ListView.builder(
                      itemCount: state.logs.length,
                      itemBuilder: (context, index) {
                        final log = state.logs[index];
                        IconData icon;
                        Color color;
                        String typeText;
                        switch (log.callType) {
                            case LocalCallType.rejected:
                                icon = Icons.call_end; color = Colors.red;
                                typeText = localizations.callTypeRejected; break;
                            case LocalCallType.blocked:
                                icon = Icons.shield; color = Colors.orange;
                                typeText = localizations.callTypeBlocked; break;
                            case LocalCallType.silenced:
                                icon = Icons.vibration; color = Colors.blue;
                                typeText = localizations.callTypeSilenced; break;
                            default:
                                icon = Icons.block; color = Colors.grey;
                                typeText = localizations.callTypeUnknown;
                        }
                        return ListTile(
                          leading: Icon(icon, color: color),
                          title: Text(log.name ?? log.phoneNumber),
                          subtitle: Text('${log.timestamp.toString().substring(0, 16)} · $typeText'),
                        );
                      },
                    ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(localizations.dataLoadFailure(err.toString()))),
      )
    );
  }
}