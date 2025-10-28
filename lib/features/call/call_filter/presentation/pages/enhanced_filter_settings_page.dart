import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_reader/sim_reader.dart';

import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/sim_slot_rule_filter_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/call_filter_settings_page.dart';
import 'package:yourcallyourrule/features/device_profile/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/pages/local_filter_settings_page.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/pages/remote_filter_settings_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 从 StatefulWidget 改为 ConsumerStatefulWidget 以便使用 ref 和管理本地UI状态。
class EnhancedFilterSettingsPage extends ConsumerStatefulWidget {
  // [重构]: 移除所有构造函数参数。
  const EnhancedFilterSettingsPage({super.key});

  @override
  ConsumerState<EnhancedFilterSettingsPage> createState() => EnhancedFilterSettingsPageState();
}

class EnhancedFilterSettingsPageState extends ConsumerState<EnhancedFilterSettingsPage> {
  // [重构与修正]: 像 _isEntryPointMode 这样的纯局部UI状态，保留在 State 中是完全正确的。
  bool _isEntryPointMode = true;

  // [注释]: initState 中不再需要加载数据。
  @override
  void initState() {
    super.initState();
  }
  
  void _toggleViewMode() {
    setState(() {
      _isEntryPointMode = !_isEntryPointMode;
    });
  }

  // [注释]: 导航方法保持不变，但目标页面现在都是无参的 ConsumerWidget。
  void _navigateToLocalFilterSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocalFilterSettingsPage(),
      ),
    );
  }

  void _navigateToRemoteFilterSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RemoteFilterSettingsPage(),
      ),
    );
  }

  void _navigateToCallFilterSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CallFilterSettingsPage(),
      ),
    );
  }

  void _navigateToSimSlotRuleFilterPage(int simSlotIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimSlotRuleFilterPage(simSlotIndex: simSlotIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // [重构]: 使用 ref.watch 异步获取 SIM 卡信息。
    final simCardsAsync = ref.watch(simCardsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.enhancedFilterSettingsTitle),
        actions: [
          IconButton(
            icon: Icon(_isEntryPointMode ? Icons.tune : Icons.list),
            tooltip: _isEntryPointMode 
                ? AppLocalizations.of(context)!.detailedSettingsTitle 
                : AppLocalizations.of(context)!.entryPointViewTitle,
            onPressed: _toggleViewMode,
          ),
        ],
      ),
      // [重构]: 使用 simCardsAsync.when 来处理加载、错误和成功状态。
      body: simCardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(err.toString()),
        )),
        data: (simCards) {
          // [注释]: 根据本地状态 _isEntryPointMode 决定显示哪个视图。
          return _isEntryPointMode
              ? _buildEntryPointView(simCards)
              // [重构]: 直接嵌入 Widget，不再需要传递任何参数。
              : const EnhancedCompositeFilterSettingsWidget();
        },
      ),
    );
  }

  // [注释]: UI 构建辅助方法保持不变，仅修改数据来源。
  
  Widget _buildEntryPointView(List<SimInfo> simCards) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildGlobalFilterSection(),
        const Divider(height: 32),
        _buildSimSlotSection(simCards),
        const SizedBox(height: 32),
        _buildExplanationCard(),
      ],
    );
  }

  Widget _buildGlobalFilterSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.globalFilterSettings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.globalFilterDescription),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: Text(AppLocalizations.of(context)!.localCounterFilter),
              subtitle: Text(AppLocalizations.of(context)!.localCounterFilterSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: _navigateToLocalFilterSettings,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: Text(AppLocalizations.of(context)!.remoteNumberFilter),
              subtitle: Text(AppLocalizations.of(context)!.remoteNumberFilterSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: _navigateToRemoteFilterSettings,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.rule),
              title: Text(AppLocalizations.of(context)!.basicRuleFilter),
              subtitle: Text(AppLocalizations.of(context)!.basicRuleFilterSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: _navigateToCallFilterSettings,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimSlotSection(List<SimInfo> simCards) {
    // [注释]: 如果没有SIM卡，显示提示信息。
    if (simCards.isEmpty) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.sim_card_alert_outlined),
          title: Text(AppLocalizations.of(context)!.noSimCardDetected),
        ),
      );
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.simSlotManagement,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.simSlotFilterDescription),
            const SizedBox(height: 16),
            // [注释]: 使用真实的 simCards 数据。
            ...simCards.map((simInfo) {
              final slotIndex = simInfo.simSlotIndex;
              if (slotIndex == null) return const SizedBox.shrink();
              return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.sim_card),
                      title: Text(simInfo.carrierName ?? AppLocalizations.of(context)!.unassignedSIMCard),
                      subtitle: Text(AppLocalizations.of(context)!.simSlotPosition(slotIndex + 1)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _navigateToSimSlotRuleFilterPage(slotIndex),
                    ),
                    if (simInfo != simCards.last) const Divider(),
                  ],
                );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExplanationCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.enhancedFilterInstructionsTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.enhancedFilterSystemDescription),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.systemFeatures),
            Text("• ${AppLocalizations.of(context)!.globalFilterFeature}"),
            Text("• ${AppLocalizations.of(context)!.simSlotRuleFeature}"),
            Text("• ${AppLocalizations.of(context)!.flexibleCombinationFeature}"),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.configurationAdvice),
          ],
        ),
      ),
    );
  }
}