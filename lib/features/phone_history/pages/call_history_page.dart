import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/phone_subscription/utils/phone_utils.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_page.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/phone_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/phone_history/entities/local_call_type.dart';
import 'package:yourcallyourrule/features/phone_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/phone_history/utils/call_history_action_handler.dart';
import 'package:yourcallyourrule/features/phone_history/widgets/call_log_card.dart';
import 'package:yourcallyourrule/features/phone_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/phone_location/services/location_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 用于承载 CallLogCard 所需的元数据
class CallLogMeta {
  final Map<String, String> labelIdToTextMap;
  final Map<String, String?> phoneToAvatarMap;
  final Map<String, String?> phoneToRegionMap;

  CallLogMeta({
    required this.labelIdToTextMap,
    required this.phoneToAvatarMap,
    required this.phoneToRegionMap,
  });
}

/// 100% 对齐 elite-ui 完整架构、具备双统计卡片、分类 Tab 与时间轴视图的 CallHistoryPage
class CallHistoryPage extends ConsumerStatefulWidget {
  const CallHistoryPage({super.key});

  @override
  ConsumerState<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends ConsumerState<CallHistoryPage> {
  List<CallLogEntry> _currentLogs = [];
  CallLogMeta? _meta;
  bool _isLoading = true;
  bool _isInitialized = false;

  String? _selectedLabelId;
  String _selectedTab = '';
  ListDisplayMode _displayMode = ListDisplayMode.timeline;
  final Set<String> _selectedLogIds = {};
  bool _isMultiSelectMode = false;
  String _searchKeyword = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _selectedTab = AppLocalizations.of(context).tabAll;
      _loadData();
      _isInitialized = true;
    }
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      if (_isMultiSelectMode) {
        _isMultiSelectMode = false;
        _selectedLogIds.clear();
      }
    });

    try {
      final callLogService = ref.read(callLogServiceProvider);
      final originalLogs = await callLogService.getRecentLogs();

      if (mounted) {
        setState(() {
          _currentLogs = originalLogs;
          _isLoading = false;
        });
      }

      final meta = await _getCallLogMetadata(originalLogs);
      if (mounted) {
        setState(() {
          _meta = meta;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).dataLoadFailure(e.toString()),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<CallLogMeta> _getCallLogMetadata(List<CallLogEntry> logs) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelService = ref.read(labelServiceProvider);
    final locationService = ref.read(locationServiceProvider);

    final allLabels = await predefinedLabelService.getAllLabels();
    final labelMap = {for (var label in allLabels) label.id: label.text};

    final avatarMap = <String, String?>{};
    final regionMap = <String, String?>{};

    final uniqueNumbers = logs.map((log) => log.phoneNumber).toSet();
    await Future.wait(uniqueNumbers.map((number) async {
      try {
        final locationEntry = await locationService.getByPhoneNumber(number);
        regionMap[number] = locationEntry?.region;

        final parsedResult = await PhoneUtils.parsePhoneNumber(number);
        final e164Number = parsedResult['e164Number'];
        if (e164Number != null && e164Number.isNotEmpty) {
          final entry = await labelService.getLabelByPhoneNumber(e164Number);
          if (entry != null) {
            avatarMap[number] = entry.avatar;
          }
        }
      } catch (_) {}
    }));

    return CallLogMeta(
      labelIdToTextMap: labelMap,
      phoneToAvatarMap: avatarMap,
      phoneToRegionMap: regionMap,
    );
  }

  List<CallLogEntry> _getFilteredLogs() {
    if (_isLoading) return [];

    final localizations = AppLocalizations.of(context);
    var filteredLogs = _currentLogs;

    // 1. 按标签筛选
    if (_selectedLabelId != null) {
      filteredLogs = filteredLogs
          .where((log) => log.labelIds?.contains(_selectedLabelId) ?? false)
          .toList();
    }

    // 2. 按 Tab 筛选
    if (_selectedTab != localizations.tabAll) {
      LocalCallType? targetType;
      if (_selectedTab == localizations.tabAnswered) {
        targetType = LocalCallType.incoming;
      } else if (_selectedTab == localizations.tabMissed) {
        targetType = LocalCallType.missed;
      } else if (_selectedTab == localizations.tabBlocked) {
        targetType = LocalCallType.blocked;
      } else if (_selectedTab == localizations.tabOutgoing) {
        targetType = LocalCallType.outgoing;
      }

      if (targetType != null) {
        filteredLogs = filteredLogs
            .where((log) => log.localCallType == targetType)
            .toList();
      }
    }

    // 3. 按搜索关键字筛选
    if (_searchKeyword.isNotEmpty) {
      final keyword = _searchKeyword.toLowerCase();
      filteredLogs = filteredLogs.where((log) {
        return (log.name?.toLowerCase().contains(keyword) ?? false) ||
            log.phoneNumber.toLowerCase().contains(keyword);
      }).toList();
    }

    // 4. 排序
    filteredLogs.sort((a, b) => (b.timestamp ?? 0).compareTo(a.timestamp ?? 0));
    return filteredLogs;
  }

  void _onSearchChanged(String keyword) {
    setState(() => _searchKeyword = keyword);
  }

  void _onTabChanged(String newTab) {
    setState(() => _selectedTab = newTab);
  }

  void _onLabelFilterChanged(String? labelId) {
    setState(() => _selectedLabelId = labelId);
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) _selectedLogIds.clear();
    });
  }

  void _toggleItemSelection(String logId) {
    setState(() {
      if (_selectedLogIds.contains(logId)) {
        _selectedLogIds.remove(logId);
      } else {
        _selectedLogIds.add(logId);
      }
    });
  }

  void _deleteSelectedLogs() async {
    final callLogService = ref.read(callLogServiceProvider);
    try {
      final idsToDelete = _selectedLogIds.toList();
      for (final id in idsToDelete) {
        await callLogService.deleteLog(id);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).deleteSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).deleteFailed(e.toString()),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      await _loadData();
    }
  }

  void _showMoreOptions() {
    final localizations = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                _displayMode == ListDisplayMode.timeline
                    ? Icons.view_list
                    : Icons.timeline,
              ),
              title: Text(
                _displayMode == ListDisplayMode.timeline
                    ? localizations.listView
                    : localizations.timelineView,
              ),
              onTap: () {
                Navigator.pop(ctx);
                setState(
                  () => _displayMode = _displayMode == ListDisplayMode.timeline
                      ? ListDisplayMode.list
                      : ListDisplayMode.timeline,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: Text(localizations.clearAllCallLogs),
              onTap: () {
                Navigator.pop(ctx);
                _showClearAllDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.label_outline),
              title: Text(localizations.labelManagement),
              onTap: () {
                Navigator.pop(ctx);
                context.pushNamed(AppRouter.labelManagementWithAds);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearAllDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(ctx).clearAllCallLogs),
        content: Text(AppLocalizations.of(ctx).clearAllCallLogsConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppLocalizations.of(ctx).cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(ctx).delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(callLogServiceProvider).clearAllLogs();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).allCallLogsCleared),
            backgroundColor: Colors.green,
          ),
        );
      }
      await _loadData();
    }
  }

  void _showLabelFilterDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(ctx).filterByLabel),
        content: SizedBox(
          width: double.maxFinite,
          child: PublicSelectLabel(
            initialLabelId: _selectedLabelId,
            onLabelIdChanged: (labelId) {
              _onLabelFilterChanged(labelId);
              Navigator.pop(ctx);
            },
            themeColor: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(ctx).cancelButton),
          ),
          if (_selectedLabelId != null)
            TextButton(
              onPressed: () {
                _onLabelFilterChanged(null);
                Navigator.pop(ctx);
              },
              child: Text(AppLocalizations.of(ctx).clearFilter),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return GenericTimelinePage<CallLogEntry>(
      title: localizations.callHistory,
      themeColor: theme.colorScheme.primary,
      items: _getFilteredLogs(),
      isLoading: _isLoading,
      onRefresh: _loadData,
      displayMode: _displayMode,
      getItemTimestamp: (log) => log.dateTime,
      headerContent: _buildHeaderContent(),
      itemBuilder: (context, log) => _buildCallLogCard(log),
      adBuilder: () => const AdsInlineBanner(),
      emptyText: localizations.noCallRecords,
      emptyIcon: Icons.call,
      searchHintText: localizations.searchHint,
      onSearchChanged: _onSearchChanged,
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedLogIds,
      getItemId: (log) => log.id,
      onToggleMultiSelectMode: _toggleMultiSelectMode,
      onToggleItemSelection: _toggleItemSelection,
      onDeleteSelected: _deleteSelectedLogs,
      onMoreOptions: _showMoreOptions,
      customActions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: _showLabelFilterDialog,
          tooltip: localizations.filterByLabel,
        ),
      ],
    );
  }

  Widget _buildCallLogCard(CallLogEntry log) {
    return CallLogCard(
      key: ValueKey(log.id),
      log: log,
      labelIdToTextMap: _meta?.labelIdToTextMap ?? {},
      avatarPath: _meta?.phoneToAvatarMap[log.phoneNumber],
      region: _meta?.phoneToRegionMap[log.phoneNumber],
      actionHandler: CallHistoryActionHandler(
        context: context,
        ref: ref,
        log: log,
        onRefresh: _loadData,
      ),
      onRequiresRefresh: _loadData,
      isSelected: _selectedLogIds.contains(log.id),
      onMultiSelectTap: _isMultiSelectMode
          ? () => _toggleItemSelection(log.id)
          : null,
    );
  }

  Widget _buildHeaderContent() {
    return _CallHistoryHeader(
      allItems: _currentLogs,
      selectedLabelId: _selectedLabelId,
      onTabChanged: _onTabChanged,
      onLabelChanged: _onLabelFilterChanged,
    );
  }
}

/// 独立的 Header Widget (双 Dopamine 统计卡片与分类 Tab)
class _CallHistoryHeader extends StatefulWidget {
  final List<CallLogEntry> allItems;
  final String? selectedLabelId;
  final ValueChanged<String> onTabChanged;
  final ValueChanged<String?> onLabelChanged;

  const _CallHistoryHeader({
    required this.allItems,
    required this.selectedLabelId,
    required this.onTabChanged,
    required this.onLabelChanged,
  });

  @override
  State<_CallHistoryHeader> createState() => _CallHistoryHeaderState();
}

class _CallHistoryHeaderState extends State<_CallHistoryHeader>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<String> _tabs = [];
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeTabsAndController();
      _isInitialized = true;
    }
  }

  void _initializeTabsAndController() {
    final localizations = AppLocalizations.of(context);
    _tabs = [
      localizations.tabAll,
      localizations.tabAnswered,
      localizations.tabMissed,
      localizations.tabBlocked,
      localizations.tabOutgoing,
    ];
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        widget.onTabChanged(_tabs[_tabController!.index]);
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final blockedCount = widget.allItems
        .where((log) => log.localCallType == LocalCallType.blocked)
        .length;
    final answeredCount = widget.allItems
        .where((log) => log.localCallType == LocalCallType.incoming)
        .length;

    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDopamineStatCard(
                title: AppLocalizations.of(context).statBlocked,
                value: blockedCount.toString(),
                icon: Icons.shield_rounded,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDopamineStatCard(
                title: AppLocalizations.of(context).statAnswered,
                value: answeredCount.toString(),
                icon: Icons.phone_callback_rounded,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(3),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(
                    alpha: 0.25,
                  ),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        if (widget.selectedLabelId != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
            child: LabelFilterChip(
              labelId: widget.selectedLabelId!,
              onDeleted: () => widget.onLabelChanged(null),
            ),
          ),
      ],
    );
  }

  Widget _buildDopamineStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
