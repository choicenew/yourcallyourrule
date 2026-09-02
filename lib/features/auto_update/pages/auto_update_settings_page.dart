import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';
import 'package:yourcallyourrule/features/auto_update/di/auto_update_service_provider.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
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
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.autoUpdateSettings, style: const TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
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
                const SizedBox(height: 12),
                ..._serviceTypeNames.keys.map((type) => _buildServiceCard(type)),
                const SizedBox(height: 16),
                nativeAdWidgetMedium(adWidth: 320, adHeight: 320)
              ],
            ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D9CDB).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFF2D9CDB).withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2D9CDB).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF2D9CDB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.autoUpdateSettings,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D9CDB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.autoUpdateDescription,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.black87,
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
    final days = _userIntervals[type] ?? 1;
    final name = _serviceTypeNames[type] ?? type;
    final icon = _serviceTypeIcons[type] ?? Icons.settings;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFFFF9500), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.updateInterval,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5F0),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFEDE8DF)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: days,
                    items: [1, 3, 7, 14, 30].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(AppLocalizations.of(context)!.days(value), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
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
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.sync_rounded, size: 16),
              label: Text(AppLocalizations.of(context)!.updateNow, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D9CDB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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