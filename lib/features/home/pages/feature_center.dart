import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/widgets/vip_access_checker.dart';
import 'package:yourcallyourrule/features/home/providers/feature_center_providers.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// Converted to a ConsumerStatefulWidget to use Riverpod
class FeatureCenter extends ConsumerStatefulWidget {
  const FeatureCenter({super.key});

  @override
  ConsumerState<FeatureCenter> createState() => _FeatureCenterState();
}

class _FeatureCenterState extends ConsumerState<FeatureCenter> {
  // The state is just the list of widgets themselves.
  List<Widget> _orderedFeatureWidgets = [];
  bool _isLoading = true;
  bool _isReorderEnabled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _loadAndOrderFeatures();
    }
  }

  Color _getFeatureColor(String id) {
    // 包含 24 种丰富、明快、各具辨识度的高级柔和色相池，自动适配未来任意扩展
    const palette = [
      Color(0xFFE8F5E9), // 薄荷浅绿
      Color(0xFFE3F2FD), // 天空浅蓝
      Color(0xFFF3E5F5), // 薰衣草紫
      Color(0xFFFFF3E0), // 温暖浅橙
      Color(0xFFE0F7FA), // 冰海浅青
      Color(0xFFFCE4EC), // 柔和浅粉
      Color(0xFFFFF8E1), // 明亮浅琥珀
      Color(0xFFEDE7F6), // 优雅深紫罗兰
      Color(0xFFE0F2F1), // 极光碧绿
      Color(0xFFFFEBEE), // 珊瑚柔红
      Color(0xFFE1F5FE), // 晴空海蓝
      Color(0xFFF1F8E9), // 嫩芽浅绿
      Color(0xFFFFFDE7), // 阳光柔黄
      Color(0xFFE8EAF6), // 经典靛蓝
      Color(0xFFF9FBE7), // 抹茶青柠
      Color(0xFFF8BBD0), // 樱花暖粉
      Color(0xFFB2DFDB), // 晶石青绿
      Color(0xFFFFCCBC), // 晚霞杏橙
      Color(0xFFD1C4E9), // 暮色紫藤
      Color(0xFFBBDEFB), // 琉璃透蓝
      Color(0xFFC8E6C9), // 森林翠绿
      Color(0xFFFFE0B2), // 麦浪金橙
      Color(0xFFB3E5FC), // 冰川淡蓝
      Color(0xFFD7CCC8), // 拿铁暖棕
    ];
    final hash = id.hashCode.abs();
    return palette[hash % palette.length];
  }

  Future<void> _loadAndOrderFeatures() async {
    // THIS IS THE MASTER LIST, DEFINED DIRECTLY AS YOU INSTRUCTED.
    // THE DEFAULT ORDER IS THE ORDER YOU WRITE THEM IN HERE.
    final allFeaturesInDefaultOrder = <Widget>[
      _buildFeatureItem(
        id: 'mark_phone_management',
        context: context,
        title: AppLocalizations.of(context)!.markPhoneManagementTitle,
        icon: Icons.label,
        color: _getFeatureColor('mark_phone_management'),
        onTap: () => context.push('/mark-phone-management-with-ads'),
      ),
      _buildFeatureItem(
        id: 'plugin_management',
        context: context,
        title: AppLocalizations.of(context)!.pluginManagement,
        icon: Icons.extension,
        color: _getFeatureColor('plugin_management'),
        onTap: () => context.push('/plugin-management-with-ads'),
      ),
      _buildFeatureItem(
        id: 'allow_block',
        context: context,
        title: AppLocalizations.of(context)!.allowBlock,
        icon: Icons.block,
        color: _getFeatureColor('allow_block'),
        onTap: () => context.push('/allowed-blocked-settings-with-ads'),
      ),
       _buildFeatureItem(
        id: 'rule-management',
        context: context,
        title: AppLocalizations.of(context)!.phoneRuleManagement,
        icon: Icons.list,
        color: _getFeatureColor('rule-management'),
        onTap: () => context.push('/rule-management-settings-with-ads'),
      ),
      _buildFeatureItem(
        id: 'sim_slot_rules',
        context: context,
        title: AppLocalizations.of(context)!.simSlotRules, // Assuming you will add this localization key
        icon: Icons.sim_card,
        color: _getFeatureColor('sim_slot_rules'),
        onTap: () => context.push('/sim-slot-rule-with-ads/0'), // Assuming simSlotIndex 0 for the first SIM slot
      ),
      _buildFeatureItem(
        id: 'regex_rules',
        context: context,
        title: AppLocalizations.of(context)!.regexRules,
        icon: Icons.code,
        color: _getFeatureColor('regex_rules'),
        onTap: () => context.push('/regex-rule-with-ads'),
      ),
      _buildFeatureItem(
        id: 'phone_subscription',
        context: context,
        title: AppLocalizations.of(context)!.phoneSubscription,
        icon: Icons.phone_callback,
        color: _getFeatureColor('phone_subscription'),
        onTap: () => context.push('/phone-subscription-with-ads'),
      ),
      _buildFeatureItem(
        id: 'call_history',
        context: context,
        title: AppLocalizations.of(context)!.callHistory,
        icon: Icons.call,
        color: _getFeatureColor('call_history'),
        onTap: () => context.push('/call-history'),
      ),
      _buildFeatureItem(
        id: 'contacts',
        context: context,
        title: AppLocalizations.of(context)!.contacts,
        icon: Icons.contacts,
        color: _getFeatureColor('contacts'),
        onTap: () => context.push('/contacts-management'),
      ),
      _buildFeatureItem(
        id: 'statistics',
        context: context,
        title: AppLocalizations.of(context)!.statistics,
        icon: Icons.bar_chart,
        color: _getFeatureColor('statistics'),
        onTap: () => context.push('/call-statistics'),
      ),
      _buildFeatureItem(
        id: 'deletion_proposal',
        context: context,
        title: AppLocalizations.of(context)!.deletionProposals,
        icon: Icons.how_to_vote_outlined,
        color: _getFeatureColor('deletion_proposal'),
        onTap: () => context.push('/deletion-proposal'),
      ),
      
    ];

    final service = ref.read(featureCenterConfigServiceProvider);
    final savedIdOrder = await service.getOrder();

    List<Widget> finalWidgetOrder;

    if (savedIdOrder == null) {
      finalWidgetOrder = allFeaturesInDefaultOrder;
    } else {
      final widgetMap = {
        for (var widget in allFeaturesInDefaultOrder) (widget.key as ValueKey<String>).value: widget
      };
      
      final sortedWidgets = <Widget>[];
      for (final id in savedIdOrder) {
        if (widgetMap.containsKey(id)) {
          sortedWidgets.add(widgetMap.remove(id)!);
        }
      }
      sortedWidgets.addAll(widgetMap.values);
      finalWidgetOrder = sortedWidgets;
    }
    
    if (mounted) {
      setState(() {
        _orderedFeatureWidgets = finalWidgetOrder;
        _isLoading = false;
      });
    }
  }

  void _saveOrder() {
    final currentIdOrder = _orderedFeatureWidgets
        .map((widget) => (widget.key as ValueKey<String>).value)
        .toList();
    ref.read(featureCenterConfigServiceProvider).saveOrder(currentIdOrder);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04),
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
                  AppLocalizations.of(context)!.featureCenter,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    _isReorderEnabled ? Icons.low_priority: Icons.edit,
                    color: Theme.of(context).primaryColor,
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
                itemCount: _orderedFeatureWidgets.length,
                itemBuilder: (context, index) {
                  final featureWidget = _orderedFeatureWidgets[index];
                  final featureId = (featureWidget.key as ValueKey<String>).value;

                  return LongPressDraggable<String>(
                    data: _isReorderEnabled ? featureId : null,
                    // --- CORRECTION STARTS HERE ---
                    // The complex SizedBox has been removed.
                    feedback: Material(
                      elevation: 4.0,
                      color: Colors.transparent, // Keeps item from having a weird background
                      child: featureWidget,
                    ),
                    // --- CORRECTION ENDS HERE ---
                    childWhenDragging: Container(),
                    child: DragTarget<String>(
                      onWillAcceptWithDetails: (details) => _isReorderEnabled && details.data != featureId,
                      onAcceptWithDetails: (details) {
                        if (!_isReorderEnabled) return;
                        final draggedId = details.data;
                        setState(() {
                          final oldIndex = _orderedFeatureWidgets.indexWhere(
                            (w) => (w.key as ValueKey<String>).value == draggedId);
                          
                          final newIndex = index;

                          if (oldIndex != -1) {
                            final item = _orderedFeatureWidgets.removeAt(oldIndex);
                            if (oldIndex < newIndex) {
                              _orderedFeatureWidgets.insert(newIndex - 1, item);
                            } else {
                              _orderedFeatureWidgets.insert(newIndex, item);
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

  // THIS IS YOUR FUNCTION, UNCHANGED, AS REQUESTED.
  Widget _buildFeatureItem({
    required String id,
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      key: ValueKey(id), // The ID is used to create the essential Key.
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2430) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 精致独立的彩色图标徽章容器
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? color.withOpacity(0.25) : color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.04),
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
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
























































































































































































































































