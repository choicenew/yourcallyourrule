import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

/// SIM卡槽位规则管理组件
/// 用于管理每个SIM卡槽位的过滤规则
class SimSlotRuleWidget extends ConsumerStatefulWidget {
  final SimSlotRuleService simSlotRuleService;
  final EnhancedCompositeFilterService enhancedCompositeFilterService;
  final int simSlotIndex;
  final Map<String, bool> filterEnabledMap;
  final List<Map<String, dynamic>> simSlotRules;
  final Function(String, bool) onToggleFilterEnabled;
  final Function(String, String, String?) onAddSimSlotRule;
  final Function(String) onDeleteSimSlotRule;

  const SimSlotRuleWidget({
    super.key,
    required this.simSlotRuleService,
    required this.enhancedCompositeFilterService,
    required this.simSlotIndex,
    required this.filterEnabledMap,
    required this.simSlotRules,
    required this.onToggleFilterEnabled,
    required this.onAddSimSlotRule,
    required this.onDeleteSimSlotRule,
  });

  @override
  SimSlotRuleWidgetState createState() => SimSlotRuleWidgetState();
}

class SimSlotRuleWidgetState extends ConsumerState<SimSlotRuleWidget> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedLabelId;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  /// 添加SIM卡槽位规则
  void _addSimSlotRule() {
    final phoneNumber = _phoneNumberController.text.trim();
    final name = _nameController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.phoneNumberRequired)),
      );
      return;
    }

    widget.onAddSimSlotRule(phoneNumber, name, _selectedLabelId);

    // 清空输入框
    _phoneNumberController.clear();
    _nameController.clear();
    setState(() {
      _selectedLabelId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildFilterEnableSection(),
        const Divider(height: 32),
                 GoogleAdWidget(adInfo: AdManager.bannerAd),  
         const SizedBox(height: 32),
        _buildAddRuleSection(),
                 GoogleAdWidget(adInfo: AdManager.bannerAd),  
         const SizedBox(height: 32),
        const Divider(height: 32),
        _buildRuleListSection(),
        const SizedBox(height: 32),
 
 
        _buildExplanationCard(),
        const SizedBox(height: 32),
        InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd,width: 400),
      ],
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
              AppLocalizations.of(context)!.simSlotFilterSettingsTitle(widget.simSlotIndex + 1),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.filterToggleInstructions),
            const SizedBox(height: 8),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.localCounterFilter),
              subtitle: Text(AppLocalizations.of(context)!.localCounterFilterSubtitle),
              value: widget.filterEnabledMap['LocalCountFilterService'] ?? true,
              onChanged: (value) => widget.onToggleFilterEnabled('LocalCountFilterService', value),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.remoteNumberFilter),
              subtitle: Text(AppLocalizations.of(context)!.remoteNumberFilterSubtitle),
              value: widget.filterEnabledMap['RemoteNumberFilterService'] ?? true,
              onChanged: (value) => widget.onToggleFilterEnabled('RemoteNumberFilterService', value),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.basicRuleFilter),
              subtitle: Text(AppLocalizations.of(context)!.basicRuleFilterSubtitle),
              value: widget.filterEnabledMap['CallFilterService'] ?? true,
              onChanged: (value) => widget.onToggleFilterEnabled('CallFilterService', value),
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
              AppLocalizations.of(context)!.addSimRuleButton,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phoneNumberLabel,
                hintText: AppLocalizations.of(context)!.phoneNumberHintText,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.contactNameLabel,
                hintText: AppLocalizations.of(context)!.contactNameHint,
              ),
            ),
            const SizedBox(height: 8),
            // 使用PublicSelectLabel组件替换TextField
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              themeColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addSimSlotRule,
              child: Text(AppLocalizations.of(context)!.ruleAddButton),
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
              AppLocalizations.of(context)!.simSlotRuleListTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            widget.simSlotRules.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(AppLocalizations.of(context)!.noRulesPrompt),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.simSlotRules.length,
                    itemBuilder: (context, index) {
                      final rule = widget.simSlotRules[index];
                      return ListTile(
                        title: Text(rule['name'] ?? rule['phoneNumber']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(rule['phoneNumber']),
                            if (rule['labelId'] != null && rule['labelId'].isNotEmpty)
                              FutureBuilder<String?>(
                                future: ref.read(predefinedLabelServiceProvider)
                                    .getLabelById(rule['labelId'])
                                    .then((label) => label?.text),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text(AppLocalizations.of(context)!.loadingTags);
                                  }
                                  if (snapshot.hasData) {
                                    final labelText = snapshot.data ?? AppLocalizations.of(context)!.unknownTag;
                                    return Text(AppLocalizations.of(context)!.tagLabel(labelText));
                                  }
                                  return Text(AppLocalizations.of(context)!.unknownTag);
                                },
                              ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => widget.onDeleteSimSlotRule(rule['phoneNumber']),
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
    return  Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 规则说明卡片
            Text(AppLocalizations.of(context)!.simRuleInstructionsTitle, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.simRuleInstructions),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.featureListTitle),
            Text(AppLocalizations.of(context)!.featureEnableDisable),
            Text(AppLocalizations.of(context)!.featureAddRules),
            Text(AppLocalizations.of(context)!.featureManageRules),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.dualSimAdvice),
          ],
        ),
      ),
    );
  }
}