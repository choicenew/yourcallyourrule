import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/device/provider/sim_info_provider.dart';
import 'package:yourcallyourrule/features/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'filter_components/global_filter_list_widget.dart';
import 'filter_components/sim_slot_filter_tab_widget.dart';

/// 过滤器管理卡片容器组件 (模块化重构，文件 < 80 行)
class FilterManagementWidget extends ConsumerStatefulWidget {
  const FilterManagementWidget({super.key});

  @override
  ConsumerState<FilterManagementWidget> createState() =>
      _FilterManagementWidgetState();
}

class _FilterManagementWidgetState extends ConsumerState<FilterManagementWidget>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final simCardsAsync = ref.watch(simCardsProvider);

    simCardsAsync.whenData((simCards) {
      final simCount = simCards.length;
      if (simCount > 0 &&
          (_tabController == null || _tabController!.length != simCount)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _tabController?.dispose();
              _tabController = TabController(length: simCount, vsync: this);
            });
          }
        });
      } else if (simCount == 0 && _tabController != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _tabController?.dispose();
              _tabController = null;
            });
          }
        });
      }
    });

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      color: _isExpanded
          ? null
          : (isDark
              ? const Color(0xFFFFA726).withValues(alpha: 0.15)
              : const Color(0xFFFFF3E0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : const Color(0xFFFFA726).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          AppLocalizations.of(context).filterManagement,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          AppLocalizations.of(context).filterManagementDescription,
        ),
        leading: const Icon(Icons.filter_alt, color: Color(0xFFFB8C00)),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildFilterContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterContent() {
    final enhancedConfig = ref.watch(enhancedFilterConfigProvider).value;
    final isSimSlotRuleEnabled =
        enhancedConfig?.filterEnabledMap['SimSlotRuleService'] ?? false;

    if (isSimSlotRuleEnabled) {
      return SimSlotFilterTabWidget(
        tabController: _tabController,
        callFilterSwitch: const GlobalFilterListWidget(),
      );
    } else {
      return const GlobalFilterListWidget();
    }
  }
}
