import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// [注释] 导入所有需要的 Provider 和子 Widget
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/sim_slot_rule_filter_page.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

// [注释] 保持 ConsumerStatefulWidget 以管理 TabController
class EnhancedCompositeFilterSettingsWidget extends ConsumerStatefulWidget {
  // [注释] 移除所有构造函数参数
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
              // Tab 1: 本地计数过滤器设置
              _buildLocalFilterTab(),
              
              // Tab 2: 远程号码过滤器设置
              _buildRemoteFilterTab(),
              
              // Tab 3: 基本规则过滤器设置
              _buildCallFilterTab(),
              
              // Tab 4: SIM卡槽位规则设置
              _buildSimSlotTab(),
            ],
          ),
        ),
      ],
    );
  }

  // [注释] 为每个 Tab 创建独立的构建方法，以保持清晰

  Widget _buildLocalFilterTab() {
    // [注释] 使用 ref.watch 监听对应的 config provider
    final localConfigAsync = ref.watch(localCountFilterConfigProvider);
    // [注释] 使用 ref.read 获取 notifier
    final localNotifier = ref.read(localCountFilterConfigProvider.notifier);

    // [注释] 使用 .when 处理异步状态
    return localConfigAsync.when(
      data: (config) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: LocalFilterSettingsWidget(
          enableLocalCountFilter: config.enableLocalCountFilter,
          countThreshold: config.countThreshold,
          rejectExceededNumbers: config.rejectExceededNumbers,
          allowNonExceededNumbers: config.allowNonExceededNumbers,
          logAllLocalQueries: config.logAllLocalQueries,
          // [注释] onChanged 回调直接调用 notifier 的方法
          onEnableLocalCountFilterChanged: (value) => localNotifier.updateConfig(config.copyWith(enableLocalCountFilter: value)),
          onCountThresholdChanged: (value) => localNotifier.updateConfig(config.copyWith(countThreshold: value)),
          onRejectExceededNumbersChanged: (value) => localNotifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
          onAllowNonExceededNumbersChanged: (value) => localNotifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
          onLogAllLocalQueriesChanged: (value) => localNotifier.updateConfig(config.copyWith(logAllLocalQueries: value)),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildRemoteFilterTab() {
    final remoteConfigAsync = ref.watch(remoteNumberFilterConfigProvider);
    final remoteNotifier = ref.read(remoteNumberFilterConfigProvider.notifier);

    return remoteConfigAsync.when(
      data: (config) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RemoteFilterSettingsWidget(
          enableRemoteNumberFilter: config.enableRemoteNumberFilter,
          countThreshold: config.countThreshold,
          rejectExceededNumbers: config.rejectExceededNumbers,
          allowNonExceededNumbers: config.allowNonExceededNumbers,
          prioritizeRemoteAction: config.prioritizeRemoteAction,
          logAllRemoteQueries: config.logAllRemoteQueries,
          onEnableRemoteNumberFilterChanged: (value) => remoteNotifier.updateConfig(config.copyWith(enableRemoteNumberFilter: value)),
          onCountThresholdChanged: (value) => remoteNotifier.updateConfig(config.copyWith(countThreshold: value)),
          onRejectExceededNumbersChanged: (value) => remoteNotifier.updateConfig(config.copyWith(rejectExceededNumbers: value)),
          onAllowNonExceededNumbersChanged: (value) => remoteNotifier.updateConfig(config.copyWith(allowNonExceededNumbers: value)),
          onPrioritizeRemoteActionChanged: (value) => remoteNotifier.updateConfig(config.copyWith(prioritizeRemoteAction: value)),
          onLogAllRemoteQueriesChanged: (value) => remoteNotifier.updateConfig(config.copyWith(logAllRemoteQueries: value)),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildCallFilterTab() {
    final callConfigAsync = ref.watch(callFilterConfigProvider);
    final callNotifier = ref.read(callFilterConfigProvider.notifier);
    
    return callConfigAsync.when(
      data: (config) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: CallFilterSettingsWidget(
          config: config,
          onConfigChanged: (key, value) {
            final updatedMap = config.toMap()..[key] = value;
            callNotifier.updateConfig(CallFilterConfig.fromMap(updatedMap));
          },
          onSavePressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaved)),
            );
          },
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text('Error: $err')),
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