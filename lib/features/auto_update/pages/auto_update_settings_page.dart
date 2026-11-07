import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';
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
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.autoUpdateSettings,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _isLoading ? null : _updateAll,
            tooltip: l10n.updateAllNow,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: theme.colorScheme.primary),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildInfoCard(),
                const SizedBox(height: 14),
                ..._serviceTypeNames.keys.map((type) => _buildServiceCard(type)),
                const SizedBox(height: 16),
                nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
              ],
            ),
    );
  }

  Widget _buildInfoCard() {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: theme.colorScheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.autoUpdateSettings,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.autoUpdateDescription,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String type) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final days = _userIntervals[type] ?? 1;
    final name = _serviceTypeNames[type] ?? type;
    final icon = _serviceTypeIcons[type] ?? Icons.settings;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.updateInterval,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: days,
                    isDense: true,
                    dropdownColor: theme.colorScheme.surface,
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    items: [1, 3, 7, 14, 30].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          l10n.days(value),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        _updateInterval(type, newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.autorenew_rounded, size: 18),
              label: Text(
                l10n.updateNow,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: _isLoading ? null : () => _updateNow(type),
            ),
          ),
        ],
      ),
    );
  }
}
