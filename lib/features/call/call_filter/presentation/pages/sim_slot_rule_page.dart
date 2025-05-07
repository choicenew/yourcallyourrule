import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';

/// SIM卡槽位规则管理页面
/// 用于管理每个SIM卡槽位的过滤规则
class SimSlotRulePage extends StatefulWidget {
  final SimSlotRuleService simSlotRuleService;
  final EnhancedCompositeFilterService enhancedCompositeFilterService;
  final ConfigRepository configRepository;
  final RuleRepository ruleRepository;
  final int simSlotIndex;

  const SimSlotRulePage({
    Key? key,
    required this.simSlotRuleService,
    required this.enhancedCompositeFilterService,
    required this.configRepository,
    required this.ruleRepository,
    required this.simSlotIndex,
  }) : super(key: key);

  @override
  SimSlotRulePageState createState() => SimSlotRulePageState();
}

class SimSlotRulePageState extends State<SimSlotRulePage> {
  // 过滤器配置
  Map<String, bool> _filterEnabledMap = {};
  List<Map<String, dynamic>> _simSlotRules = [];
  bool _isLoading = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  /// 加载数据
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 加载该SIM卡槽位的过滤器启用状态
      await _loadFilterEnabledStatus();
      
      // 加载该SIM卡槽位的规则列表
      await _loadSimSlotRules();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载数据失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 加载过滤器启用状态
  Future<void> _loadFilterEnabledStatus() async {
    // 获取所有过滤器的类名
    final filterNames = [
      'LocalCountFilterService',
      'RemoteNumberFilterService',
      'CallFilterService',
    ];

    // 检查每个过滤器在当前SIM卡槽位的启用状态
    for (var filterName in filterNames) {
      final isEnabled = widget.enhancedCompositeFilterService
          .isFilterEnabledForSimSlot(widget.simSlotIndex, filterName);
      _filterEnabledMap[filterName] = isEnabled;
    }
  }

  /// 加载SIM卡槽位规则
  Future<void> _loadSimSlotRules() async {
    final rules = await widget.simSlotRuleService.getSimSlotRules(widget.simSlotIndex);
    _simSlotRules = rules.map((rule) => rule.toMap()).toList();
  }

  /// 切换过滤器启用状态
  Future<void> _toggleFilterEnabled(String filterName, bool isEnabled) async {
    setState(() {
      _filterEnabledMap[filterName] = isEnabled;
    });

    if (isEnabled) {
      await widget.enhancedCompositeFilterService
          .enableFilterForSimSlot(widget.simSlotIndex, filterName);
    } else {
      await widget.enhancedCompositeFilterService
          .disableFilterForSimSlot(widget.simSlotIndex, filterName);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${isEnabled ? "启用" : "禁用"}过滤器: $filterName')),
    );
  }

  /// 添加SIM卡槽位规则
  Future<void> _addSimSlotRule() async {
    final phoneNumber = _phoneNumberController.text.trim();
    final name = _nameController.text.trim();
    final label = _labelController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('电话号码不能为空')),
      );
      return;
    }

    try {
      await widget.simSlotRuleService.addSimSlotRule(
        phoneNumber,
        widget.simSlotIndex,
        name: name,
        label: label,
      );

      // 清空输入框
      _phoneNumberController.clear();
      _nameController.clear();
      _labelController.clear();

      // 重新加载规则列表
      await _loadSimSlotRules();

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('规则添加成功')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('添加规则失败: $e')),
      );
    }
  }

  /// 删除SIM卡槽位规则
  Future<void> _deleteSimSlotRule(String phoneNumber) async {
    try {
      await widget.simSlotRuleService.removeSimSlotRule(
        phoneNumber,
      );

      // 重新加载规则列表
      await _loadSimSlotRules();

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('规则删除成功')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('删除规则失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIM卡${widget.simSlotIndex + 1}规则管理'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildFilterEnableSection(),
                const Divider(height: 32),
                _buildAddRuleSection(),
                const Divider(height: 32),
                _buildRuleListSection(),
                const SizedBox(height: 32),
                _buildExplanationCard(),
              ],
            ),
    );
  }

  /// 构建过滤器启用部分
  Widget _buildFilterEnableSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SIM卡${widget.simSlotIndex + 1}过滤器设置',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text('启用或禁用此SIM卡槽位的各个过滤器：'),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('本地计数过滤器'),
              subtitle: const Text('根据来电频率自动过滤骚扰电话'),
              value: _filterEnabledMap['LocalCountFilterService'] ?? true,
              onChanged: (value) => _toggleFilterEnabled('LocalCountFilterService', value),
            ),
            SwitchListTile(
              title: const Text('远程号码过滤器'),
              subtitle: const Text('使用云端数据库和社区举报识别骚扰电话'),
              value: _filterEnabledMap['RemoteNumberFilterService'] ?? true,
              onChanged: (value) => _toggleFilterEnabled('RemoteNumberFilterService', value),
            ),
            SwitchListTile(
              title: const Text('基础规则过滤器'),
              subtitle: const Text('使用黑白名单、正则表达式等规则过滤来电'),
              value: _filterEnabledMap['CallFilterService'] ?? true,
              onChanged: (value) => _toggleFilterEnabled('CallFilterService', value),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建添加规则部分
  Widget _buildAddRuleSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '添加SIM卡规则',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: '电话号码 *',
                hintText: '输入要添加规则的电话号码',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '名称',
                hintText: '输入联系人名称（可选）',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _labelController,
              decoration: const InputDecoration(
                labelText: '标签',
                hintText: '输入标签（可选）',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addSimSlotRule,
              child: const Text('添加规则'),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建规则列表部分
  Widget _buildRuleListSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SIM卡规则列表',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _simSlotRules.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('暂无规则，请添加规则'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _simSlotRules.length,
                    itemBuilder: (context, index) {
                      final rule = _simSlotRules[index];
                      return ListTile(
                        title: Text(rule['name'] ?? rule['phoneNumber']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(rule['phoneNumber']),
                            if (rule['label'] != null && rule['label'].isNotEmpty)
                              Text('标签: ${rule['label']}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteSimSlotRule(rule['phoneNumber']),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  /// 构建说明卡片
  Widget _buildExplanationCard() {
    return const Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SIM卡规则说明', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text('SIM卡规则允许您为每个SIM卡槽位配置独立的过滤规则。'),
            SizedBox(height: 8),
            Text('功能特点：'),
            Text('• 为每个SIM卡启用或禁用不同的过滤器'),
            Text('• 添加特定号码的SIM卡规则'),
            Text('• 管理每个SIM卡的规则列表'),
            SizedBox(height: 8),
            Text('此功能特别适用于双卡手机用户，可以为工作和个人SIM卡设置不同的过滤策略。'),
          ],
        ),
      ),
    );
  }
}