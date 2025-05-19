import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/sim_slot_rule_page.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/pages/local_filter_settings_page.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/pages/remote_filter_settings_page.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/call_filter_settings_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 增强版过滤器设置页面
/// 作为各个过滤器设置的入口点，并提供SIM卡选择功能
class EnhancedFilterSettingsPage extends StatefulWidget {
  final EnhancedCompositeFilterService enhancedCompositeFilterService;
  final SimSlotRuleService simSlotRuleService;
  final LocalCountFilterService localCountFilterService;
  final RemoteNumberFilterService remoteNumberFilterService;
  final RemoteNumberService remoteNumberService;
  final ConfigRepository configRepository;
  final RuleRepository ruleRepository;

  const EnhancedFilterSettingsPage({
    super.key,
    required this.enhancedCompositeFilterService,
    required this.simSlotRuleService,
    required this.localCountFilterService,
    required this.remoteNumberFilterService,
    required this.remoteNumberService,
    required this.configRepository,
    required this.ruleRepository,
  });

  @override
  EnhancedFilterSettingsPageState createState() => EnhancedFilterSettingsPageState();
}

class EnhancedFilterSettingsPageState extends State<EnhancedFilterSettingsPage> {
  // 可用的SIM卡槽位
  List<SimInfo> _availableSimSlots = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSimSlots();
  }

  /// 加载SIM卡槽位信息
  Future<void> _loadSimSlots() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 模拟获取SIM卡槽位信息，实际应用中应该从设备获取
      _availableSimSlots = [
        SimInfo(simSlotIndex: 0, displayName: AppLocalizations.of(context)!.simCard(1)),
        SimInfo(simSlotIndex: 1, displayName: AppLocalizations.of(context)!.simCard(2)),
      ];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载SIM卡信息失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 导航到本地过滤器设置页面
  void _navigateToLocalFilterSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocalFilterSettingsPage(
          localCountFilterService: widget.localCountFilterService,
          configRepository: widget.configRepository,
        ),
      ),
    );
  }

  /// 导航到远程过滤器设置页面
  void _navigateToRemoteFilterSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RemoteFilterSettingsPage(
          remoteNumberFilterService: widget.remoteNumberFilterService,
          remoteNumberService: widget.remoteNumberService,
          configRepository: widget.configRepository,
        ),
      ),
    );
  }

  /// 导航到基础规则过滤器设置页面
  void _navigateToCallFilterSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallFilterSettingsPage(
          callFilterService: widget.enhancedCompositeFilterService,
        ),
      ),
    );
  }

  /// 导航到SIM卡规则管理页面
  void _navigateToSimSlotRulePage(int simSlotIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimSlotRulePage(
          simSlotRuleService: widget.simSlotRuleService,
          enhancedCompositeFilterService: widget.enhancedCompositeFilterService,
          configRepository: widget.configRepository,
          ruleRepository: widget.ruleRepository,
          simSlotIndex: simSlotIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.enhancedFilterSettingsTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildGlobalFilterSection(),
                const Divider(height: 32),
                _buildSimSlotSection(),
                const SizedBox(height: 32),
                _buildExplanationCard(),
              ],
            ),
    );
  }

  /// 构建全局过滤器部分
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

  /// 构建SIM卡槽位部分
  Widget _buildSimSlotSection() {
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
            ..._availableSimSlots.map((simInfo) => Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.sim_card),
                      title: Text(simInfo.displayName ?? AppLocalizations.of(context)!.unassignedSIMCard),
                      subtitle: Text(AppLocalizations.of(context)!.simSlotPosition(simInfo.simSlotIndex! + 1)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _navigateToSimSlotRulePage(simInfo.simSlotIndex!),
                    ),
                    if (simInfo != _availableSimSlots.last) const Divider(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// 构建说明卡片
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
            Text(AppLocalizations.of(context)!.globalFilterFeature),
            Text(AppLocalizations.of(context)!.simSlotRuleFeature),
            Text(AppLocalizations.of(context)!.flexibleCombinationFeature),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.configurationAdvice),
          ],
        ),
      ),
    );
  }
}