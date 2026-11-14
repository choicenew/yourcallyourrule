import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:yourcallyourrule/features/common/widgets/dialogs/label_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';

class MarkPhoneManagementPage extends ConsumerStatefulWidget {
  const MarkPhoneManagementPage({super.key});

  @override
  ConsumerState<MarkPhoneManagementPage> createState() =>
      _MarkPhoneManagementPageState();
}

class _MarkPhoneManagementPageState
    extends ConsumerState<MarkPhoneManagementPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedLabelId;

  List<LabelPhoneEntry> _markedPhones = [];
  bool _isLoadingMarkedPhones = false;

  final Set<String> _selectedItemIds = {};
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadMarkedPhones();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadMarkedPhones() async {
    setState(() {
      _isLoadingMarkedPhones = true;
    });

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

      setState(() {
        _markedPhones = filteredPhones;
      });
    } catch (e) {
      _showSnackBar(
        AppLocalizations.of(context).loadMarkedPhonesFailed(e.toString()),
      );
    } finally {
      setState(() {
        _isLoadingMarkedPhones = false;
      });
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
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _saveMark() async {
    final phoneText = _phoneController.text.trim();
    final name = _nameController.text.trim();

    if (phoneText.isEmpty || _selectedLabelId == null) {
      _showSnackBar(
        AppLocalizations.of(context).selectLabelAndEnterPhoneNumber,
      );
      return;
    }

    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);

      final labelPhoneEntry = await markPhoneService.markPhone(
        phoneText,
        _selectedLabelId!,
        name: name,
      );

      final statisticsSyncService = ref.read(
        labelMarkStatisticsSyncServiceProvider,
      );
      await statisticsSyncService.syncSingleLabel(labelPhoneEntry);

      final entryToRemote = ref.read(labelPhoneEntryToRemoteProvider);
      await entryToRemote.syncSingleLabelToRemote(labelPhoneEntry);

      _phoneController.clear();
      _nameController.clear();
      setState(() {
        _selectedLabelId = null;
      });

      _loadMarkedPhones();

      _showSnackBar((AppLocalizations.of(context) as dynamic).saveSuccess as String? ?? 'Save Success');
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context).saveFailed}: $e');
    }
  }

  Future<void> _deleteMark(String id) async {
    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      await markPhoneService.removePhoneMark(id);
      _loadMarkedPhones();
      _showSnackBar(AppLocalizations.of(context).deleteSuccess);
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context).deleteFailed}: $e');
    }
  }

  Future<void> _deleteSelectedItems() async {
    if (_selectedItemIds.isEmpty) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text((AppLocalizations.of(context) as dynamic).confirmDeleteTitle as String? ?? 'Confirm Delete'),
        content: Text(
          (AppLocalizations.of(context) as dynamic).batchDeleteLabelsConfirm?.call(_selectedItemIds.length) as String? ?? 'Confirm Delete',
        ),
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

        setState(() {
          _selectedItemIds.clear();
        });

        _loadMarkedPhones();
        _showSnackBar((AppLocalizations.of(context) as dynamic).batchDeleteSuccess as String? ?? 'Batch Delete Success');
      } catch (e) {
        _showSnackBar('${(AppLocalizations.of(context) as dynamic).batchDeleteFailed as String? ?? 'Batch Delete Failed'}: $e');
      }
    }
  }

  void _showAddMarkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text((AppLocalizations.of(context) as dynamic).addMark as String? ?? 'Add Mark'),
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
                  setState(() {
                    _selectedLabelId = labelId;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _saveMark();
            },
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsHeaderCard() {
    final markCountStream = ref.watch(labelMarkStatisticsServiceProvider).markCountStream;

    return StreamBuilder<int>(
      stream: markCountStream,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.bookmark_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    (AppLocalizations.of(context) as dynamic).markedCountTitle as String? ?? 'Marked Count',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        );
      },
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.phoneNumber),
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
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _editMarkedPhone(entry),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _deleteMark(entry.id),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getLabelName(String labelId) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final label = await predefinedLabelService.getLabelById(labelId);
    return label?.text ?? AppLocalizations.of(context).unknown;
  }

  Future<void> _editMarkedPhone(LabelPhoneEntry entry) async {
    try {
      LabelEditDialog.show(
        context,
        entry,
        onLabelUpdated: () {
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
    return GenericListPage<LabelPhoneEntry>(
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
      headerContent: _buildStatisticsHeaderCard(),
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context).searchMarkedPhonesHint,
    );
  }
}
