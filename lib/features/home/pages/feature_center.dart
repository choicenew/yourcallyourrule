import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/widgets/vip_access_checker.dart';
import 'package:yourcallyourrule/features/home/services/feature_center_config_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 功能偏好 / 功能中心组件 —— 遵照 Flutter 3.47+ 解耦架构，防空安全防护，绝无灰屏
class FeatureCenter extends ConsumerStatefulWidget {
  const FeatureCenter({super.key});

  @override
  ConsumerState<FeatureCenter> createState() => _FeatureCenterState();
}

class _FeatureCenterState extends ConsumerState<FeatureCenter> {
  static const List<String> _defaultFeatureIds = [
    'mark_phone_management',
    'plugin_management',
    'allow_block',
    'rule-management',
    'sim_slot_rules',
    'regex_rules',
    'phone_subscription',
    'call_history',
    'contacts',
    'statistics',
    'deletion_proposal',
  ];

  List<String> _orderedFeatureIds = List.from(_defaultFeatureIds);
  bool _isLoading = true;
  bool _isReorderEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadAndOrderFeatures();
  }

  Color _getFeatureColor(String id) {
    const palette = [
      Color(0xFFE8F5E9),
      Color(0xFFE3F2FD),
      Color(0xFFF3E5F5),
      Color(0xFFFFF3E0),
      Color(0xFFE0F7FA),
      Color(0xFFFCE4EC),
      Color(0xFFFFF8E1),
      Color(0xFFEDE7F6),
      Color(0xFFE0F2F1),
      Color(0xFFFFEBEE),
      Color(0xFFE1F5FE),
      Color(0xFFF1F8E9),
      Color(0xFFFFFDE7),
      Color(0xFFE8EAF6),
      Color(0xFFF9FBE7),
      Color(0xFFF8BBD0),
      Color(0xFFB2DFDB),
      Color(0xFFFFCCBC),
      Color(0xFFD1C4E9),
      Color(0xFFBBDEFB),
      Color(0xFFC8E6C9),
      Color(0xFFFFE0B2),
      Color(0xFFB3E5FC),
      Color(0xFFD7CCC8),
    ];
    final hash = id.hashCode.abs();
    return palette[hash % palette.length];
  }

  Future<void> _loadAndOrderFeatures() async {
    try {
      final service = ref.read(featureCenterConfigServiceProvider);
      final savedIdOrder = await service.getOrder();

      if (savedIdOrder != null && savedIdOrder.isNotEmpty) {
        final sorted = <String>[];
        final remaining = Set<String>.from(_defaultFeatureIds);

        for (final id in savedIdOrder) {
          if (remaining.remove(id)) {
            sorted.add(id);
          }
        }
        sorted.addAll(remaining);

        if (mounted) {
          setState(() {
            _orderedFeatureIds = sorted;
            _isLoading = false;
          });
          return;
        }
      }
    } catch (_) {
      // 容错兜底，使用默认列表
    }

    if (mounted) {
      setState(() {
        _orderedFeatureIds = List.from(_defaultFeatureIds);
        _isLoading = false;
      });
    }
  }

  void _saveOrder() {
    ref.read(featureCenterConfigServiceProvider).saveOrder(_orderedFeatureIds);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final headerTitle = l10n.featureCenter;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.04),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headerTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    _isReorderEnabled ? Icons.low_priority : Icons.edit,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    if (_isReorderEnabled) {
                      setState(() {
                        _isReorderEnabled = false;
                      });
                    } else {
                      VipAccessChecker.checkVipAccess(
                        ref: ref,
                        context: context,
                        onAccessGranted: () {
                          setState(() {
                            _isReorderEnabled = true;
                          });
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: _orderedFeatureIds.length,
                itemBuilder: (context, index) {
                  final featureId = _orderedFeatureIds[index];
                  final featureWidget = _buildFeatureTile(
                    id: featureId,
                    context: context,
                    l10n: l10n,
                    isDark: isDark,
                  );

                  return LongPressDraggable<String>(
                    data: _isReorderEnabled ? featureId : null,
                    feedback: Material(
                      elevation: 4.0,
                      color: Colors.transparent,
                      child: featureWidget,
                    ),
                    childWhenDragging: const SizedBox.shrink(),
                    child: DragTarget<String>(
                      onWillAcceptWithDetails: (details) =>
                          _isReorderEnabled && details.data != featureId,
                      onAcceptWithDetails: (details) {
                        if (!_isReorderEnabled) return;
                        final draggedId = details.data;
                        setState(() {
                          final oldIndex = _orderedFeatureIds.indexOf(draggedId);
                          final newIndex = index;

                          if (oldIndex != -1) {
                            final item = _orderedFeatureIds.removeAt(oldIndex);
                            if (oldIndex < newIndex) {
                              _orderedFeatureIds.insert(newIndex - 1, item);
                            } else {
                              _orderedFeatureIds.insert(newIndex, item);
                            }
                            _saveOrder();
                          }
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return featureWidget;
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required String id,
    required BuildContext context,
    required AppLocalizations l10n,
    required bool isDark,
  }) {
    final title = switch (id) {
      'mark_phone_management' => l10n.markPhoneManagementTitle,
      'plugin_management' => l10n.pluginManagement,
      'allow_block' => l10n.allowBlock,
      'rule-management' => l10n.phoneRuleManagement,
      'sim_slot_rules' => l10n.simSlotRules,
      'regex_rules' => l10n.regexRules,
      'phone_subscription' => l10n.phoneSubscription,
      'call_history' => l10n.callHistory,
      'contacts' => l10n.contacts,
      'statistics' => l10n.statistics,
      'deletion_proposal' => l10n.deletionProposals,
      _ => id,
    };

    final icon = switch (id) {
      'mark_phone_management' => Icons.label,
      'plugin_management' => Icons.extension,
      'allow_block' => Icons.block,
      'rule-management' => Icons.list,
      'sim_slot_rules' => Icons.sim_card,
      'regex_rules' => Icons.code,
      'phone_subscription' => Icons.phone_callback,
      'call_history' => Icons.call,
      'contacts' => Icons.contacts,
      'statistics' => Icons.bar_chart,
      'deletion_proposal' => Icons.how_to_vote_outlined,
      _ => Icons.star_rounded,
    };

    final route = switch (id) {
      'mark_phone_management' => '/mark-phone-management-with-ads',
      'plugin_management' => '/plugin-management-with-ads',
      'allow_block' => '/allowed-blocked-settings-with-ads',
      'rule-management' => '/rule-management-settings-with-ads',
      'sim_slot_rules' => '/sim-slot-rule-with-ads/0',
      'regex_rules' => '/regex-rule-with-ads',
      'phone_subscription' => '/phone-subscription-with-ads',
      'call_history' => '/call-history',
      'contacts' => '/contacts-management',
      'statistics' => '/call-statistics',
      'deletion_proposal' => '/deletion-proposal',
      _ => '/',
    };

    final color = _getFeatureColor(id);

    return InkWell(
      key: ValueKey(id),
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2430) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? color.withValues(alpha: 0.25) : color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.04),
                  width: 0.8,
                ),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isDark ? Colors.white : const Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : const Color(0xFF334155),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
