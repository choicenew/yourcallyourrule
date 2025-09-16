// lib/features/call/call_history/pages/call_history_page_with_timeline_with_ads.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/location_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_history/utils/call_history_action_handler.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/call_log_card.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_filter_chip.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_with_ads_page.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

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

class CallHistoryPageWithTimelineWithAds extends ConsumerStatefulWidget {
  const CallHistoryPageWithTimelineWithAds({super.key});

  @override
  ConsumerState<CallHistoryPageWithTimelineWithAds> createState() => _CallHistoryPageWithTimelineWithAdsState();
}

class _CallHistoryPageWithTimelineWithAdsState extends ConsumerState<CallHistoryPageWithTimelineWithAds> {
  List<CallLog> _currentLogs = [];
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
      _selectedTab = AppLocalizations.of(context)!.tabAll;
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
      final (decoratedLogs, meta) = await _getDecoratedLogsAndMeta(originalLogs);

      if (mounted) {
        setState(() {
          _currentLogs = decoratedLogs; 
          _meta = meta;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.dataLoadFailure(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<(List<CallLog>, CallLogMeta)> _getDecoratedLogsAndMeta(List<CallLog> logs) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelService = ref.read(labelServiceProvider);
    final locationService = ref.read(locationServiceProvider);

    final allLabels = await predefinedLabelService.getAllLabels();
    final labelMap = { for (var label in allLabels) label.id: label.text };

    final Map<String, LabelPhoneEntry?> e164ToEntryMap = {};
    final Map<String, String> originalToE164Map = {};

    final uniqueNumbers = logs.map((log) => log.phoneNumber).toSet();
    for (var number in uniqueNumbers) {
      final parsedResult = await PhoneUtils.parsePhoneNumber(number);
      final e164Number = parsedResult['e164Number'];
      if (e164Number != null && e164Number.isNotEmpty) {
        originalToE164Map[number] = e164Number;
        if (!e164ToEntryMap.containsKey(e164Number)) {
          final e164PhoneNumberObject = PhoneNumber.fromString(e164Number);
          e164ToEntryMap[e164Number] = await labelService.getLabelByPhoneNumber(e164PhoneNumberObject);
        }
      }
    }
    
    final regionMap = <String, String?>{};
    for (var number in uniqueNumbers) {
        final locationEntry = await locationService.getByPhoneNumber(number);
        regionMap[number] = locationEntry?.region;
    }
    
    final decoratedLogs = logs.map((log) {
      final e164Number = originalToE164Map[log.phoneNumber];
      if (e164Number != null) {
        final entry = e164ToEntryMap[e164Number];
        if (entry != null) {
          return log.copyWith(
            name: entry.name,
            labelIds: (entry.labelId.isNotEmpty) ? [entry.labelId] : [],
          );
        }
      }
      return log;
    }).toList();

    final meta = CallLogMeta(
      labelIdToTextMap: labelMap,
      phoneToAvatarMap: { 
        for (var originalNum in uniqueNumbers)
          originalNum : e164ToEntryMap[originalToE164Map[originalNum]]?.avatar
      },
      phoneToRegionMap: regionMap,
    );

    return (decoratedLogs, meta);
  }

  List<CallLog> _getFilteredLogs() {
    if (_isLoading) return [];

    final localizations = AppLocalizations.of(context)!;
    var filteredLogs = _currentLogs;

    if (_selectedLabelId != null) {
      filteredLogs = filteredLogs.where((log) => log.labelIds?.contains(_selectedLabelId) ?? false).toList();
    }
    
    final tabMap = {
      localizations.tabAnswered: 'incoming',
      localizations.tabMissed: 'missed',
      localizations.tabBlocked: 'blocked',
      localizations.tabOutgoing: 'outgoing'
    };
    if (_selectedTab != localizations.tabAll) {
      filteredLogs = filteredLogs.where((log) => log.callType == tabMap[_selectedTab]).toList();
    }
    
    if (_searchKeyword.isNotEmpty) {
      final keyword = _searchKeyword.toLowerCase();
      filteredLogs = filteredLogs.where((log) {
        return (log.name?.toLowerCase().contains(keyword) ?? false) || log.phoneNumber.toLowerCase().contains(keyword);
      }).toList();
    }

    filteredLogs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
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
      final logsToDelete = _currentLogs.where((log) => _selectedLogIds.contains(log.id)).toList();
      await callLogService.deleteLogs(logsToDelete);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.deleteSuccess),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.deleteFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      await _loadData();
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(_displayMode == ListDisplayMode.timeline ? Icons.view_list : Icons.timeline),
              title: Text(_displayMode == ListDisplayMode.timeline ? AppLocalizations.of(ctx)!.listView : AppLocalizations.of(ctx)!.timelineView),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => _displayMode = _displayMode == ListDisplayMode.timeline ? ListDisplayMode.list : ListDisplayMode.timeline);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: Text(AppLocalizations.of(ctx)!.clearAllCallLogs),
              onTap: () {
                Navigator.pop(ctx);
                _showClearAllDialog();
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
        title: Text(AppLocalizations.of(ctx)!.clearAllCallLogs),
        content: Text(AppLocalizations.of(ctx)!.clearAllCallLogsConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.of(ctx)!.cancelButton)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(ctx)!.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(callLogServiceProvider).clearAllLogs();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.allCallLogsCleared),
          backgroundColor: Colors.green,
        ));
      }
      await _loadData();
    }
  }

  void _showLabelFilterDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(ctx)!.filterByLabel),
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
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(ctx)!.cancelButton)),
          if (_selectedLabelId != null)
            TextButton(
              onPressed: () {
                _onLabelFilterChanged(null);
                Navigator.pop(ctx);
              },
              child: Text(AppLocalizations.of(ctx)!.clearFilter),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 1,
        onTap: (index) => AppRouter.handleNavigation(context, index),
      ),
      body: GenericTimelineListWithAdsPage<CallLog>(
        title: AppLocalizations.of(context)!.callHistory,
        themeColor: Colors.teal,
        items: _getFilteredLogs(),
        isLoading: _isLoading,
        onRefresh: _loadData,
        displayMode: _displayMode,
        getItemTimestamp: (log) => log.timestamp,
        headerContent: _buildHeaderContent(),
        itemBuilder: (context, log) => _buildCallLogCard(log),
        adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
        emptyText: AppLocalizations.of(context)!.noCallRecords,
        emptyIcon: Icons.call,
        searchHintText: AppLocalizations.of(context)!.searchHint,
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
            tooltip: AppLocalizations.of(context)!.filterByLabel,
          ),
        ],
      ),
    );
  }
  
  Widget _buildCallLogCard(CallLog log) {
    return CallLogCard(
      key: ValueKey(log.id),
      log: log,
      labelIdToTextMap: _meta?.labelIdToTextMap ?? {},
      avatarPath: _meta?.phoneToAvatarMap[log.phoneNumber],
      region: _meta?.phoneToRegionMap[log.phoneNumber],
      actionHandler: CallHistoryActionHandler(context: context, ref: ref, log: log, onRefresh: _loadData),
      onRequiresRefresh: _loadData,
      isSelected: _selectedLogIds.contains(log.id),
      onMultiSelectTap: _isMultiSelectMode ? () => _toggleItemSelection(log.id) : null,
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

class _CallHistoryHeader extends StatefulWidget {
  final List<CallLog> allItems;
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

class _CallHistoryHeaderState extends State<_CallHistoryHeader> with TickerProviderStateMixin {
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
    final localizations = AppLocalizations.of(context)!;
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

    final blockedCount = widget.allItems.where((log) => log.callType == 'blocked').length;
    final answeredCount = widget.allItems.where((log) => log.callType == 'incoming').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 2.0,
          children: [
            _buildStatCard(AppLocalizations.of(context)!.statBlocked, blockedCount.toString(), Colors.red),
            _buildStatCard(AppLocalizations.of(context)!.statAnswered, answeredCount.toString(), Colors.green),
          ],
        ),
        const SizedBox(height: 16),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
        if (widget.selectedLabelId != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: LabelFilterChip(
              labelId: widget.selectedLabelId!,
              onDeleted: () => widget.onLabelChanged(null)
            ),
          ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}