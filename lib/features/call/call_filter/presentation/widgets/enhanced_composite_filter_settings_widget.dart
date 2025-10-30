import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// [注释] 导入所有需要的 Provider 和子 Widget

import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/sim_slot_rule_filter_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EnhancedCompositeFilterSettingsWidget extends ConsumerStatefulWidget {
  const EnhancedCompositeFilterSettingsWidget({super.key});

  @override
  EnhancedCompositeFilterSettingsWidgetState createState() => EnhancedCompositeFilterSettingsWidgetState();
}

class EnhancedCompositeFilterSettingsWidgetState extends ConsumerState<EnhancedCompositeFilterSettingsWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // [注释] 移除所有本地数据状态变量

  @override
  void initState() {
    super.initState();
    // [注释] TabController 的初始化保持不变
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.localFilterSettings),
            Tab(text: AppLocalizations.of(context)!.remoteFilterSettings),
            Tab(text: AppLocalizations.of(context)!.basicRuleFilter),
            Tab(text: AppLocalizations.of(context)!.simSlotRuleManagement),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // [修正]: Tab 1: 直接渲染自包含的 LocalFilterSettingsWidget
              const SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: LocalFilterSettingsWidget(),
              ),
              
              // [修正]: Tab 2: 直接渲染自包含的 RemoteFilterSettingsWidget
              const SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: RemoteFilterSettingsWidget(),
              ),
              
              // [修正]: Tab 3: 直接渲染自包含的 CallFilterSettingsWidget
              const SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: CallFilterSettingsWidget(),
              ),
              
              // [注释]: Tab 4: 保持原样，因为它负责SIM卡选择和导航逻辑
              _buildSimSlotTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimSlotTab() {
    final simCardsAsync = ref.watch(simCardsProvider);
    return simCardsAsync.when(
      data: (sims) {
        if (sims.isEmpty) return Center(child: Text(AppLocalizations.of(context)!.noSimCardDetected));
        
        // 如果只有一个SIM卡，直接嵌入该卡的设置页面
        if (sims.length == 1) {
          final slotIndex = sims.first.simSlotIndex;
          return slotIndex != null ? SimSlotRuleFilterPage(simSlotIndex: slotIndex) : Center(child: Text(AppLocalizations.of(context)!.invalidSimData));
        }

        // 如果有多个SIM卡，显示一个选择列表以供导航
        return ListView.builder(
          itemCount: sims.length,
          itemBuilder: (context, index) {
            final sim = sims[index];
            final slotIndex = sim.simSlotIndex;
            if (slotIndex == null) return const SizedBox.shrink();
            return ListTile(
              leading: const Icon(Icons.sim_card_alert),
              title: Text(sim.carrierName ?? AppLocalizations.of(context)!.unassignedSIMCard),
              subtitle: Text(AppLocalizations.of(context)!.configureSimCardFilterRules),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SimSlotRuleFilterPage(simSlotIndex: slotIndex))
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text('Error: $err')),
    );
  }
}