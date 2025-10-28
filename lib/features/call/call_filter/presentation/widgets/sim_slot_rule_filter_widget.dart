import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 仍然需要 Consumer 来构建列表项
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

// [重构]: 将 Widget 从 ConsumerWidget 改为 StatelessWidget，因为它现在是纯UI组件。
// [修正]: 移除构造函数中的 simSlotRuleService 和 enhancedCompositeFilterService。
class SimSlotRuleFilterWidget extends StatelessWidget {
  final int simSlotIndex;
  final Map<String, bool> filterEnabledMap;
  final List<Map<String, dynamic>> simSlotRules;
  final Function(String, bool) onToggleFilterEnabled;

  const SimSlotRuleFilterWidget({
    super.key,
    required this.simSlotIndex,
    required this.filterEnabledMap,
    required this.simSlotRules,
    required this.onToggleFilterEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildFilterEnableSection(context),
        const Divider(height: 32),
        GoogleAdWidget(adInfo: AdManager.bannerAd),
        const SizedBox(height: 32),
        // [注释]: 恢复了规则列表部分的显示。
        _buildRuleListSection(context),
        const SizedBox(height: 32),
        _buildExplanationCard(context),
        const SizedBox(height: 32),
        InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
      ],
    );
  }

  /// 构建过滤器启用部分
  Widget _buildFilterEnableSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.simSlotFilterSettingsTitle(simSlotIndex + 1),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.filterToggleInstructions),
            const SizedBox(height: 8),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.localCounterFilter),
              subtitle: Text(AppLocalizations.of(context)!.localCounterFilterSubtitle),
              value: filterEnabledMap['LocalCountFilterService'] ?? true,
              onChanged: (value) => onToggleFilterEnabled('LocalCountFilterService', value),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.remoteNumberFilter),
              subtitle: Text(AppLocalizations.of(context)!.remoteNumberFilterSubtitle),
              value: filterEnabledMap['RemoteNumberFilterService'] ?? true,
              onChanged: (value) => onToggleFilterEnabled('RemoteNumberFilterService', value),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.basicRuleFilter),
              subtitle: Text(AppLocalizations.of(context)!.basicRuleFilterSubtitle),
              value: filterEnabledMap['CallFilterService'] ?? true,
              onChanged: (value) => onToggleFilterEnabled('CallFilterService', value),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建规则列表部分
  /// [注释]: 这里我们需要一个 Consumer Widget 来异步获取标签文本。
  Widget _buildRuleListSection(BuildContext context) {
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
            simSlotRules.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(AppLocalizations.of(context)!.noRulesPrompt),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: simSlotRules.length,
                    itemBuilder: (context, index) {
                      final rule = simSlotRules[index];
                      // [注释]: 使用 Consumer 包裹 ListTile 以便在需要时访问 ref。
                      return Consumer(
                        builder: (context, ref, child) {
                          return ListTile(
                            title: Text(rule['name'] ?? rule['phoneNumber']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(rule['phoneNumber']),
                                if (rule['labelId'] != null && rule['labelId'].isNotEmpty)
                                  // [注释]: FutureBuilder 仍然是处理一次性异步操作的好方法。
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
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  /// 构建说明卡片
  Widget _buildExplanationCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.simRuleInstructionsTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.simRuleInstructions),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.featureListTitle),
            Text("• ${AppLocalizations.of(context)!.featureEnableDisable}"),
            Text("• ${AppLocalizations.of(context)!.featureAddRules}"),
            Text("• ${AppLocalizations.of(context)!.featureManageRules}"),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.dualSimAdvice),
          ],
        ),
      ),
    );
  }
}