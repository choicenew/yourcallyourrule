import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart' hide PredefinedLabel;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_sync_service.dart';
import 'package:yourcallyourrule/features/labels/services/mark_phone_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/features/labels/widgets/dialogs/mark_phone_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';

/// 号码标记管理页面 - 完整 WithAds 实现
class MarkPhoneManagementPageWithAds extends ConsumerStatefulWidget {
  const MarkPhoneManagementPageWithAds({super.key});

  @override
  ConsumerState<MarkPhoneManagementPageWithAds> createState() =>
      _MarkPhoneManagementPageWithAdsState();
}

class _MarkPhoneManagementPageWithAdsState
    extends ConsumerState<MarkPhoneManagementPageWithAds> {
  int _markCount = 0;
  bool _isLoadingMarkCount = false;
  StreamSubscription? _markCountSubscription;
  String _searchKeyword = '';

  List<LabelPhoneEntry> _markedPhones = [];
  bool _isLoadingMarkedPhones = true;
  final Set<String> _selectedItemIds = {};

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedLabelId;

  @override
  void initState() {
    super.initState();
    _loadMarkedPhones();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initStatistics();
  }

  void _initStatistics() {
    final statisticsService = ref.read(labelMarkStatisticsServiceProvider);
    _loadMarkCount();

    _markCountSubscription?.cancel();
    _markCountSubscription = statisticsService.markCountStream.listen((count) {
      if (mounted) {
        setState(() {
          _markCount = count;
        });
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _markCountSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadMarkCount() async {
    if (!mounted) return;
    setState(() => _isLoadingMarkCount = true);
    try {
      final statisticsService = ref.read(labelMarkStatisticsServiceProvider);
      final count = await statisticsService.getMarkCount();
      if (mounted) {
        setState(() {
          _markCount = count;
        });
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('${AppLocalizations.of(context).loadMarkCountFailed}: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingMarkCount = false);
      }
    }
  }

  Future<void> _loadMarkedPhones() async {
    if (!mounted) return;
    setState(() => _isLoadingMarkedPhones = true);

    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      final markedPhones = await markPhoneService.getAllPhoneMarks();

      final filteredPhones = markedPhones.where((phone) {
        if (_searchKeyword.isNotEmpty) {
          final searchLower = _searchKeyword.toLowerCase();
          final phoneMatch = phone.phoneNumber.toLowerCase().contains(searchLower);
          final nameMatch = phone.name.toLowerCase().contains(searchLower);
          return phoneMatch || nameMatch;
        }
        return true;
      }).toList();

      if (mounted) {
        setState(() {
          _markedPhones = filteredPhones;
        });
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(AppLocalizations.of(context).loadMarkedPhonesFailed(e.toString()));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingMarkedPhones = false);
      }
    }
  }

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
    _loadMarkedPhones();
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  Future<void> _navigateToVipExchangePage() async {
    context.pushNamed(AppRouter.vipExchange);
    await _loadMarkCount();
  }

  Future<void> _saveMark() async {
    final phoneText = _phoneController.text.trim();
    final name = _nameController.text.trim();

    if (phoneText.isEmpty || _selectedLabelId == null) {
      _showSnackBar(AppLocalizations.of(context).selectLabelAndEnterPhoneNumber);
      return;
    }

    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      final labelPhoneEntry = await markPhoneService.markPhone(
        phoneText,
        _selectedLabelId!,
        name: name,
      );

      final statisticsSyncService = ref.read(labelMarkStatisticsSyncServiceProvider);
      await statisticsSyncService.syncSingleLabel(labelPhoneEntry);

      final entryToRemote = ref.read(labelPhoneEntryToRemoteProvider);
      await entryToRemote.syncSingleLabelToRemote(labelPhoneEntry);

      _phoneController.clear();
      _nameController.clear();
      if (mounted) {
        setState(() {
          _selectedLabelId = null;
        });
        _loadMarkedPhones();
        _loadMarkCount();
        _showSnackBar(AppLocalizations.of(context).markPhoneSuccess);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('${AppLocalizations.of(context).markPhoneFailed}: $e');
      }
    }
  }

  Future<void> _deleteMark(String id) async {
    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      await markPhoneService.removePhoneMark(id);
      if (mounted) {
        _loadMarkedPhones();
        _showSnackBar(AppLocalizations.of(context).deleteSuccess);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(AppLocalizations.of(context).deleteFailed(e.toString()));
      }
    }
  }

  Future<void> _deleteSelectedItems() async {
    if (_selectedItemIds.isEmpty) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteButton),
        content: Text(AppLocalizations.of(context).batchDeleteLabelsConfirm(_selectedItemIds.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).deleteButton),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final markPhoneService = ref.read(markPhoneServiceProvider);
        final idsToDelete = Set<String>.from(_selectedItemIds);
        for (final id in idsToDelete) {
          await markPhoneService.removePhoneMark(id);
        }

        if (mounted) {
          setState(() {
            _selectedItemIds.clear();
          });
          _loadMarkedPhones();
          _showSnackBar(AppLocalizations.of(context).deleteSuccess);
        }
      } catch (e) {
        if (mounted) {
          _showSnackBar('${AppLocalizations.of(context).deleteFailed}: $e');
        }
      }
    }
  }

  void _showAddMarkDialog(BuildContext context) {
    _phoneController.clear();
    _nameController.clear();
    setState(() {
      _selectedLabelId = null;
    });

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(AppLocalizations.of(context).add),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).phoneNumber,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).name,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                PublicSelectLabel(
                  initialLabelId: _selectedLabelId,
                  onLabelIdChanged: (labelId) {
                    setDialogState(() {
                      _selectedLabelId = labelId;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(AppLocalizations.of(context).cancelButton),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _saveMark();
              },
              child: Text(AppLocalizations.of(context).save),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkCountCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.workspace_premium_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context).markCount,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _isLoadingMarkCount
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        '$_markCount',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF9500),
                        ),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF9500), Color(0xFFFF5E3A)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _navigateToVipExchangePage,
              icon: const Icon(Icons.card_membership_rounded, color: Colors.white, size: 18),
              label: Text(
                AppLocalizations.of(context).exchangeVip,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkedPhoneCard(LabelPhoneEntry entry) {
    final isSelected = _selectedItemIds.contains(entry.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: ListTile(
        leading: AvatarUtils.buildAvatarWithIcon(
          context,
          name: entry.name.isNotEmpty ? entry.name : entry.phoneNumber,
          avatarUrl: entry.avatar,
          iconCode: entry.icon,
        ),
        title: Text(
          entry.name.isNotEmpty ? entry.name : entry.phoneNumber,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.phoneNumber,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            FutureBuilder<String>(
              future: _getLabelName(entry.labelId),
              builder: (context, snapshot) {
                final labelName = snapshot.data ?? '...';
                return Text(
                  LabelTranslationUtils.getTranslatedName(context, entry.labelId, fallback: labelName),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, color: Theme.of(context).colorScheme.primary),
              onPressed: () => _editMarkedPhone(entry),
              tooltip: AppLocalizations.of(context).edit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _deleteMark(entry.id),
              tooltip: AppLocalizations.of(context).deleteButton,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getLabelName(String labelId) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final label = await predefinedLabelService.getLabelById(labelId);
    if (!mounted) return label?.text ?? 'Unknown';
    return label?.text ?? AppLocalizations.of(context).unknown;
  }

  Future<void> _editMarkedPhone(LabelPhoneEntry entry) async {
    try {
      MarkPhoneEditDialog.show(
        context,
        entry,
        onEntryUpdated: () {
          _loadMarkedPhones();
        },
        themeColor: Theme.of(context).colorScheme.primary,
      );
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context).updateRuleFailed}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<LabelPhoneEntry>(
      title: AppLocalizations.of(context).markPhoneManagementTitle,
      items: _markedPhones,
      itemBuilder: (context, entry) => _buildMarkedPhoneCard(entry),
      adBuilder: () => const AdsInlineBanner(),
      adInterval: 3,
      emptyText: AppLocalizations.of(context).noMarkedPhones,
      emptyIcon: Icons.label_off,
      themeColor: Theme.of(context).colorScheme.primary,
      isLoading: _isLoadingMarkedPhones,
      onRefresh: _loadMarkedPhones,
      onAdd: () => _showAddMarkDialog(context),
      onMoreOptions: null,
      onToggleMultiSelectMode: () {
        setState(() {
          _selectedItemIds.clear();
        });
      },
      isMultiSelectMode: _selectedItemIds.isNotEmpty,
      selectedItemIds: _selectedItemIds,
      onDeleteSelected: _deleteSelectedItems,
      getItemId: (entry) => entry.id,
      onToggleItemSelection: (id) {
        setState(() {
          if (_selectedItemIds.contains(id)) {
            _selectedItemIds.remove(id);
          } else {
            _selectedItemIds.add(id);
          }
        });
      },
      headerContent: _buildMarkCountCard(),
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context).searchMarkedPhonesHint,
      customActions: [
        IconButton(
          icon: const Icon(Icons.card_membership),
          onPressed: _navigateToVipExchangePage,
          tooltip: AppLocalizations.of(context).exchangeVip,
        ),
      ],
    );
  }
}

/// 保持向下兼容的真实继承类（零 typedef）
class MarkPhoneManagementPage extends MarkPhoneManagementPageWithAds {
  const MarkPhoneManagementPage({super.key});
}
