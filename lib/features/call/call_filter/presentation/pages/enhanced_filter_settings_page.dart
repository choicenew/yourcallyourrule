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
import 'package:yourcallyourrule/presentation/call_filter_settings_page.dart';

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
    Key? key,
    required this.enhancedCompositeFilterService,
    required this.simSlotRuleService,
    required this.localCountFilterService,
    required this.remoteNumberFilterService,
    required this.remoteNumberService,
    required this.configRepository,
    required this.ruleRepository,
  }) : super(key: key);

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
        SimInfo(simSlotIndex: 0, displayName: 'SIM卡1'),
        SimInfo(simSlotIndex: 1, displayName: 'SIM卡2'),
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
        title: const Text('增强版过滤器设置'),
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
              '全局过滤器设置',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text('配置适用于所有SIM卡的全局过滤器：'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: const Text('本地计数过滤器'),
              subtitle: const Text('根据来电频率自动过滤骚扰电话'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _navigateToLocalFilterSettings,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text('远程号码过滤器'),
              subtitle: const Text('使用云端数据库和社区举报识别骚扰电话'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _navigateToRemoteFilterSettings,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text('基础规则过滤器'),
              subtitle: const Text('使用黑白名单、正则表达式等规则过滤来电'),
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
              'SIM卡规则管理',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text('为每个SIM卡配置独立的过滤规则：'),
            const SizedBox(height: 16),
            ..._availableSimSlots.map((simInfo) => Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.sim_card),
                      title: Text(simInfo.displayName ?? '未命名SIM卡'),
                      subtitle: Text('SIM卡槽位 ${simInfo.simSlotIndex! + 1}'),
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
          children: const [
            Text('增强版过滤器说明', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text('增强版过滤器系统支持全局过滤规则和每个SIM卡独立的过滤规则配置。'),
            SizedBox(height: 8),
            Text('系统特点：'),
            Text('• 全局过滤器：适用于所有来电的基础过滤规则'),
            Text('• SIM卡规则：为每个SIM卡配置独立的过滤策略'),
            Text('• 灵活组合：可以根据需要启用或禁用特定SIM卡的过滤器'),
            SizedBox(height: 8),
            Text('通过合理配置，您可以为工作和个人SIM卡设置不同的过滤策略，实现精细化的来电管理。'),
          ],
        ),
      ),
    );
  }
}