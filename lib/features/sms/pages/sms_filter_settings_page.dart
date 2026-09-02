import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_management_page.dart';
import 'package:yourcallyourrule/features/sms/providers/sms_filter_service_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 短信过滤设置页面 (Elite Dopamine 现代视觉规范)
class SmsFilterSettingsPage extends ConsumerStatefulWidget {
  const SmsFilterSettingsPage({super.key});

  @override
  ConsumerState<SmsFilterSettingsPage> createState() => _SmsFilterSettingsPageState();
}

class _SmsFilterSettingsPageState extends ConsumerState<SmsFilterSettingsPage> {
  bool _isLoading = true;
  bool _filterEnabled = true;
  bool _useLocalNotification = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final smsFilterService = ref.read(smsFilterServiceProvider);
      _filterEnabled = await smsFilterService.shouldNotify('', '');
      _useLocalNotification = true;

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.loadSettingsFailed(e.toString()))),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleFilterEnabled(bool value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final smsFilterService = ref.read(smsFilterServiceProvider);
      await smsFilterService.setEnabled(value);
      
      setState(() {
        _filterEnabled = value;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value ? AppLocalizations.of(context)!.smsFilterEnabled : AppLocalizations.of(context)!.smsFilterDisabled)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaveFailed(e.toString()))),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleLocalNotification(bool value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final smsFilterService = ref.read(smsFilterServiceProvider);
      await smsFilterService.setUseLocalNotification(value);
      
      setState(() {
        _useLocalNotification = value;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value ? AppLocalizations.of(context)!.localNotificationEnabled : AppLocalizations.of(context)!.localNotificationDisabled)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.settingsSaveFailed(e.toString()))),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: Text(l10n.smsFilterSettings, style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                _buildInfoCard(),
                const SizedBox(height: 14),
                _buildFilterSettingsCard(),
                const SizedBox(height: 14),
                _buildNotificationSettingsCard(),
              ],
            ),
    );
  }

  Widget _buildInfoCard() {
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.aboutSmsFilter,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D9CDB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.smsFilterDescription,
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

  Widget _buildFilterSettingsCard() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.filterSettingsTitle,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.enableSmsFilter, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            subtitle: Text(l10n.enableSmsFilterDescription, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            value: _filterEnabled,
            onChanged: _toggleFilterEnabled,
            activeThumbColor: const Color(0xFF2D9CDB),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2D9CDB).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.filter_alt_rounded, color: Color(0xFF2D9CDB), size: 20),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEDE8DF)),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.rule_rounded, color: Color(0xFFFF9500), size: 20),
            ),
            title: Text(l10n.manageFilterRules, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            subtitle: Text(l10n.manageFilterRulesDescription, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SmsManagementPage(),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettingsCard() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.notificationSettings,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.enableLocalNotification, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            subtitle: Text(l10n.enableLocalNotificationDescription, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            value: _useLocalNotification,
            onChanged: _toggleLocalNotification,
            activeThumbColor: const Color(0xFF6C5CE7),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.notifications_rounded, color: Color(0xFF6C5CE7), size: 20),
            ),
          ),
        ],
      ),
    );
  }
}