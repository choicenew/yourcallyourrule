import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_entry_to_remote.g.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_sync_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_sync_service.g.dart';
import 'package:yourcallyourrule/features/labels/services/mark_phone_service.dart';
import 'package:yourcallyourrule/features/labels/services/mark_phone_service.g.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.g.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.g.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 号码标记管理页面
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
  int _markCount = 0;
  bool _isLoading = false;
  late LabelMarkStatisticsService _statisticsService;
  StreamSubscription? _markCountSubscription;

  List<LabelPhoneEntry> _markedPhones = [];
  bool _isLoadingMarkedPhones = false;

  @override
  void initState() {
    super.initState();
    _loadMarkCount();
    _loadMarkedPhones();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _statisticsService = ref.read(labelMarkStatisticsServiceProvider);

    _markCountSubscription?.cancel();
    _markCountSubscription = _statisticsService.markCountStream.listen((count) {
      setState(() {
        _markCount = count;
      });
    });
  }

  Future<void> _loadMarkCount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final count = await _statisticsService.getMarkCount();
      setState(() {
        _markCount = count;
      });
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context)!.loadMarkCountFailed}: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  Future<void> _loadMarkedPhones() async {
    setState(() {
      _isLoadingMarkedPhones = true;
    });

    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      final markedPhones = await markPhoneService.getAllPhoneMarks();

      setState(() {
        _markedPhones = markedPhones;
      });
    } catch (e) {
      _showSnackBar(
        AppLocalizations.of(context)!.loadMarkedPhonesFailed(e.toString()),
      );
    } finally {
      setState(() {
        _isLoadingMarkedPhones = false;
      });
    }
  }

  Future<void> _markPhone() async {
    final phoneText = _phoneController.text.trim();
    final name = _nameController.text.trim();

    if (phoneText.isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.phoneNumber);
      return;
    }

    if (_selectedLabelId == null || _selectedLabelId!.isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.selectLabel);
      return;
    }

    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final label = await predefinedLabelService.getLabelById(_selectedLabelId!);
    if (label == null) {
      _showSnackBar(AppLocalizations.of(context)!.invalidLabel);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final phoneNumber = PhoneNumber.fromString(phoneText);
      final markPhoneService = ref.read(markPhoneServiceProvider);

      final labelPhoneEntry = await markPhoneService.markPhone(
        phoneNumber,
        _selectedLabelId!,
        name: name,
      );

      final statisticsSyncService = ref.read(
        labelMarkStatisticsSyncServiceProvider,
      );
      await statisticsSyncService.syncSingleLabel(labelPhoneEntry);

      final labelToRemoteSyncService = ref.read(
        labelPhoneEntryToRemoteProvider,
      );
      await labelToRemoteSyncService.sync(labelPhoneEntry);

      _phoneController.clear();
      _nameController.clear();
      setState(() {
        _selectedLabelId = null;
      });

      _loadMarkedPhones();

      _showSnackBar(AppLocalizations.of(context)!.markPhoneSuccess);
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context)!.markPhoneFailed}: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToVipExchangePage() async {
    await Navigator.of(context).pushNamed('/vip-exchange');
    await _loadMarkCount();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _markCountSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.markPhoneManagementTitle),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'exchange') {
                _navigateToVipExchangePage();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'exchange',
                child: Row(
                  children: [
                    Icon(Icons.card_membership, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.exchangeVip),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMarkCountCard(),
                  const SizedBox(height: 24),
                  _buildMarkPhoneForm(),
                  const SizedBox(height: 24),
                  _buildMarkedPhonesList(),
                ],
              ),
            ),
    );
  }

  Widget _buildMarkCountCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.markCount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$_markCount',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _navigateToVipExchangePage,
              icon: const Icon(Icons.card_membership),
              label: Text(AppLocalizations.of(context)!.exchangeVip),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkPhoneForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.addPhoneMark,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phoneNumber,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            PublicSelectLabel(
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              themeColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _markPhone,
              icon: const Icon(Icons.label),
              label: Text(AppLocalizations.of(context)!.markPhone),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkedPhonesList() {
    if (_isLoadingMarkedPhones) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_markedPhones.isEmpty) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.label_off, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.noMarkedPhones,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.markedPhonesList,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _markedPhones.length,
                itemBuilder: (context, index) {
                  final entry = _markedPhones[index];
                  return _buildMarkedPhoneItem(entry);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkedPhoneItem(LabelPhoneEntry entry) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            entry.name.isNotEmpty ? entry.name[0] : '?',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        title: Text(entry.phoneNumber.value),
        subtitle: FutureBuilder<String>(
          future: _getLabelName(entry.labelId),
          builder: (context, snapshot) {
            return Text(snapshot.data ?? AppLocalizations.of(context)!.loading);
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _deleteMarkedPhone(entry),
        ),
      ),
    );
  }

  Future<String> _getLabelName(String labelId) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final label = await predefinedLabelService.getLabelById(labelId);
    return label?.text ?? AppLocalizations.of(context)!.unknown;
  }

  Future<void> _deleteMarkedPhone(LabelPhoneEntry entry) async {
    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      await markPhoneService.removePhoneMark(entry.id);

      _loadMarkedPhones();

      _showSnackBar(AppLocalizations.of(context)!.deleteSuccess);
    } catch (e) {
      _showSnackBar(AppLocalizations.of(context)!.deleteFailed(e.toString()));
    }
  }
}
