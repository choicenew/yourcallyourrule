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

  Color _randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 0.2);
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
        color: _randomColor(),
        onTap: () => context.push('/mark-phone-management-with-ads'),
      ),
      _buildFeatureItem(
        id: 'plugin_management',
        context: context,
        title: AppLocalizations.of(context)!.pluginManagement,
        icon: Icons.extension,
        color: _randomColor(),
        onTap: () => context.push('/plugin-management-with-ads'),
      ),
      _buildFeatureItem(
        id: 'allow_block',
        context: context,
        title: AppLocalizations.of(context)!.allowBlock,
        icon: Icons.block,
        color: _randomColor(),
        onTap: () => context.push('/allowed-blocked-settings-with-ads'),
      ),
       _buildFeatureItem(
        id: 'rule-management',
        context: context,
        title: AppLocalizations.of(context)!.phoneRuleManagement,
        icon: Icons.list,
        color: _randomColor(),
        onTap: () => context.push('/rule-management-settings-with-ads'),
      ),
      _buildFeatureItem(
        id: 'sim_slot_rules',
        context: context,
        title: AppLocalizations.of(context)!.simSlotRules, // Assuming you will add this localization key
        icon: Icons.sim_card,
        color: _randomColor(),
        onTap: () => context.push('/sim-slot-rule-with-ads/0'), // Assuming simSlotIndex 0 for the first SIM slot
      ),
      _buildFeatureItem(
        id: 'regex_rules',
        context: context,
        title: AppLocalizations.of(context)!.regexRules,
        icon: Icons.code,
        color: _randomColor(),
        onTap: () => context.push('/regex-rule-with-ads'),
      ),
      _buildFeatureItem(
        id: 'phone_subscription',
        context: context,
        title: AppLocalizations.of(context)!.phoneSubscription,
        icon: Icons.phone_callback,
        color: _randomColor(),
        onTap: () => context.push('/phone-subscription-with-ads'),
      ),
      _buildFeatureItem(
        id: 'call_history',
        context: context,
        title: AppLocalizations.of(context)!.callHistory,
        icon: Icons.call,
        color: _randomColor(),
        onTap: () => context.push('/call-history'),
      ),
      _buildFeatureItem(
        id: 'contacts',
        context: context,
        title: AppLocalizations.of(context)!.contacts,
        icon: Icons.contacts,
        color: _randomColor(),
        onTap: () => context.push('/contacts-management'),
      ),
      _buildFeatureItem(
        id: 'statistics',
        context: context,
        title: AppLocalizations.of(context)!.statistics,
        icon: Icons.bar_chart,
        color: _randomColor(),
        onTap: () => context.push('/call-statistics'),
      ),
      _buildFeatureItem(
        id: 'deletion_proposal',
        context: context,
        title: AppLocalizations.of(context)!.deletionProposals,
        icon: Icons.how_to_vote_outlined,
        color: _randomColor(),
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
    return InkWell(
      key: ValueKey(id), // The ID is used to create the essential Key.
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
























































































































































































































































