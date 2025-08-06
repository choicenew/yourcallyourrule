import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/core/services/auto_update_service.dart';
import 'package:yourcallyourrule/features/auto_update/di/auto_update_service_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class AutoUpdateSettingsPage extends ConsumerStatefulWidget {
  const AutoUpdateSettingsPage({super.key});

  @override
  ConsumerState<AutoUpdateSettingsPage> createState() => _AutoUpdateSettingsPageState();
}

class _AutoUpdateSettingsPageState extends ConsumerState<AutoUpdateSettingsPage> {
  // 将_serviceTypeNames改为late变量，在didChangeDependencies中初始化
  late Map<String, String> _serviceTypeNames;

  final Map<String, IconData> _serviceTypeIcons = {
    'phone': Icons.phone,
    //'sms': Icons.sms,
    'contact': Icons.contacts,
    'plugin': Icons.extension,
  };

  final Map<String, int> _userIntervals = {};
  bool _isLoading = true;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // 不在这里调用依赖context的方法
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在这里初始化依赖context的内容
    _serviceTypeNames = {
      'phone': AppLocalizations.of(context)!.serviceTypePhone,
    //  'sms': AppLocalizations.of(context)!.serviceTypeSms,
      'contact': AppLocalizations.of(context)!.serviceTypeContact,
      'plugin': AppLocalizations.of(context)!.serviceTypePlugin,
    };
    
    // 只在第一次调用时加载间隔
    if (!_initialized) {
      _loadUserIntervals();
      _initialized = true;
    }
  }

  Future<void> _loadUserIntervals() async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = ref.read(autoUpdateServiceProvider);
    
    for (final type in _serviceTypeNames.keys) {
      final interval = await autoUpdateService.getUserUpdateInterval(type);
      _userIntervals[type] = interval.inDays;
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateInterval(String type, int days) async {
    final autoUpdateService = ref.read(autoUpdateServiceProvider);
    await autoUpdateService.setUserUpdateInterval(type, days);
    
    setState(() {
      _userIntervals[type] = days;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.intervalSetSuccess(_serviceTypeNames[type]!, days))),
    );
  }

  Future<void> _updateNow(String type) async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = ref.read(autoUpdateServiceProvider);
    try {
      final updatedRules = await autoUpdateService.updateByType(type);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.updateSuccess(_serviceTypeNames[type]!, updatedRules.length))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_serviceTypeNames[type]}${AppLocalizations.of(context)!.serviceUpdateFailure(e)}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateAll() async {
    setState(() {
      _isLoading = true;
    });

    final autoUpdateService = ref.read(autoUpdateServiceProvider);
    try {
      final updatedRules = await autoUpdateService.updateAll();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.allUpdateSuccess(updatedRules.length))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.generalUpdateFailure(e))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.autoUpdateSettings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _updateAll,
            tooltip: AppLocalizations.of(context)!.updateAllNow,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildInfoCard(),
                const SizedBox(height: 16),
                ..._serviceTypeNames.keys.map((type) => _buildServiceCard(type)),
                const SizedBox(height: 16),
                nativeAdWidgetMedium(adWidth: 320, adHeight: 320)
              ],
            ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.autoUpdateSettings,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.autoUpdateDescription,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String type) {
    final days = _userIntervals[type] ?? 1;
    final name = _serviceTypeNames[type] ?? type;
    final icon = _serviceTypeIcons[type] ?? Icons.settings;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 0.2),
                  child: Icon(icon, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.updateInterval),
                DropdownButton<int>(
                  value: days,
                  items: [1, 3, 7, 14, 30].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(AppLocalizations.of(context)!.days(value)),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      _updateInterval(type, newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.sync),
                label: Text(AppLocalizations.of(context)!.updateNow),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading ? null : () => _updateNow(type),
              ),
            ),
          ],
        ),
      ),
    );
  }
}