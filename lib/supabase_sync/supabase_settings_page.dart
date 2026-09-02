import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
// 1. 引入你的路由定义文件


import 'supabase_sync_manager.dart';
import 'supabase_sync_providers.dart';

enum _ActiveOperation { none, saving, initializing, syncing }

class SupabaseSettingsPage extends ConsumerStatefulWidget {
  const SupabaseSettingsPage({super.key});

  @override
  ConsumerState<SupabaseSettingsPage> createState() => _SupabaseSettingsPageState();
}

class _SupabaseSettingsPageState extends ConsumerState<SupabaseSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _urlCtrl;
  late TextEditingController _keyCtrl;
  late TextEditingController _connStringCtrl;

  _ActiveOperation _currentOp = _ActiveOperation.none;

  @override
  void initState() {
    super.initState();
    _urlCtrl = TextEditingController();
    _keyCtrl = TextEditingController();
    _connStringCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    _keyCtrl.dispose();
    _connStringCtrl.dispose();
    super.dispose();
  }

  void _populateControllers(SupabaseConfig config) {
    if (_urlCtrl.text.isEmpty) _urlCtrl.text = config.url;
    if (_keyCtrl.text.isEmpty) _keyCtrl.text = config.anonKey;
    if (_connStringCtrl.text.isEmpty) _connStringCtrl.text = config.connectionString;
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.saving);
    try {
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      if (mounted) {
        _showSnackBar(AppLocalizations.of(context)!.configSaved);
      }
    } finally {
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  bool _checkVipOrRedirect(bool isVip) {
    if (isVip) return true;
    context.pushNamed(AppRouter.purchase); 
    return false;
  }

  Future<void> _handleInitialize(bool isVip) async {
    if (!_checkVipOrRedirect(isVip)) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.initializing);
    try {
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      await ref.read(supabaseSyncControllerProvider.notifier).initializeDatabase();
    } finally {
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  Future<void> _handleSync(bool isVip) async {
    if (!_checkVipOrRedirect(isVip)) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.syncing);
    try {
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      await ref.read(supabaseSyncControllerProvider.notifier).runSync(force: true);
    } finally {
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? const Color(0xFFE11D48) : const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(supabaseConfigProvider);
    final purchaseState = ref.watch(purchaseStateProvider);
    final isVip = purchaseState.isPurchasedOrHasTempAccess();

    ref.listen<AsyncValue<SyncResult?>>(supabaseSyncControllerProvider, (previous, next) {
      next.when(
        data: (result) {
          if (previous?.isLoading == true && result == null) {
            _showSnackBar(AppLocalizations.of(context)!.dbInitSuccess);
          } else if (result != null && result.success) {
            if (result.skipped) {
              _showSnackBar("Sync skipped (Interval)", isError: false);
            } else {
              _showSnackBar(AppLocalizations.of(context)!.syncSuccess(result.pushedCount, result.pulledCount));
            }
          } else if (result != null && !result.success) {
            _showSnackBar(result.errorMessage ?? AppLocalizations.of(context)!.syncFailed, isError: true);
          }
        },
        error: (err, stack) {
          _showSnackBar("${AppLocalizations.of(context)!.errorPrefix}: $err", isError: true);
        },
        loading: () {},
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.localDatabaseSyncTitle,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("${AppLocalizations.of(context)!.errorLoadingSettings}: $err")),
        data: (config) {
          _populateControllers(config);
          
          final bool isBusy = _currentOp != _ActiveOperation.none;
          final bool canInteract = !isBusy;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              const _SupabaseStatusBar(),
              const SizedBox(height: 14),

              // Master Device Switch 卡片
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEDE8DF), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.hub_rounded, color: Color(0xFF3B82F6), size: 22),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.masterDeviceLabel,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black87),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)!.masterDeviceHelp,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  value: config.isMasterDevice,
                  activeColor: const Color(0xFF3B82F6),
                  onChanged: canInteract ? (val) {
                    ref.read(supabaseConfigProvider.notifier).toggleMasterDevice(val);
                  } : null,
                ),
              ),
              const SizedBox(height: 14),

              // Form Fields 卡片
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEDE8DF), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Supabase Configuration",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.black87),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _urlCtrl,
                        enabled: canInteract,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.supabaseProjectUrl,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          prefixIcon: const Icon(Icons.link_rounded),
                        ),
                        validator: (v) => v!.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _keyCtrl,
                        enabled: canInteract,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.supabaseAnonKey,
                          hintText: AppLocalizations.of(context)!.supabaseAnonKeyHint,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          prefixIcon: const Icon(Icons.vpn_key_rounded),
                        ),
                        obscureText: true,
                        validator: (v) => v!.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                      ),
                      
                      if (config.isMasterDevice) ...[
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _connStringCtrl,
                          enabled: canInteract,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.connectionString,
                            hintText: "postgres://postgres:pass@db.xxx...:5432/postgres",
                            helperText: AppLocalizations.of(context)!.connectionStringHelper,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                            prefixIcon: const Icon(Icons.storage_rounded, color: Colors.orange),
                          ),
                          obscureText: true,
                          validator: (v) => (config.isMasterDevice && (v == null || v.isEmpty))
                              ? AppLocalizations.of(context)!.requiredInitField
                              : null,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              
              // 同步选项卡片
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEDE8DF), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.call_rounded, color: Color(0xFF10B981), size: 22),
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.syncCallHistory,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context)!.syncCallHistorySubtitle,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      value: config.syncCallLogs,
                      activeColor: const Color(0xFF10B981),
                      onChanged: canInteract ? (val) {
                        ref.read(supabaseConfigProvider.notifier).toggleCallLogs(val);
                      } : null,
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.syncIntervalLabel,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF3E0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.syncIntervalValue(config.syncIntervalHours),
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Color(0xFFFF9500)),
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: config.syncIntervalHours.toDouble(),
                            min: 1,
                            max: 24,
                            divisions: 23,
                            activeColor: const Color(0xFFFF9500),
                            label: "${config.syncIntervalHours} h",
                            onChanged: canInteract ? (val) {
                              ref.read(supabaseConfigProvider.notifier).setSyncInterval(val.toInt());
                            } : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 操作按钮组
              // 1. 保存设置
              OutlinedButton.icon(
                onPressed: canInteract ? _handleSave : null,
                icon: _currentOp == _ActiveOperation.saving
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.save_rounded),
                label: Text(AppLocalizations.of(context)!.saveButton, style: const TextStyle(fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  side: const BorderSide(color: Color(0xFF3B82F6), width: 1.2),
                  foregroundColor: const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(height: 10),

              // 2. 初始化数据库 (仅主设备)
              if (config.isMasterDevice) ...[
                OutlinedButton.icon(
                  onPressed: canInteract ? () => _handleInitialize(isVip) : null,
                  icon: _currentOp == _ActiveOperation.initializing
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange))
                      : const Icon(Icons.settings_ethernet_rounded, color: Colors.orange),
                  label: Text(AppLocalizations.of(context)!.initDbButton, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    side: const BorderSide(color: Colors.orange, width: 1.2),
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // 3. 立即同步
              FilledButton.icon(
                onPressed: canInteract ? () => _handleSync(isVip) : null,
                icon: _currentOp == _ActiveOperation.syncing
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : (isVip ? const Icon(Icons.sync_rounded) : const Icon(Icons.lock_rounded)), 
                label: Text(
                  isVip ? AppLocalizations.of(context)!.syncNowButton : AppLocalizations.of(context)!.exchangeVip,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: isVip ? const Color(0xFF10B981) : const Color(0xFFFF9500),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class _SupabaseStatusBar extends ConsumerWidget {
  const _SupabaseStatusBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseState = ref.watch(purchaseStateProvider);
    final isVip = purchaseState.isPurchasedOrHasTempAccess();
    
    final config = ref.watch(supabaseConfigProvider).value;
    final isConfigured = config != null && config.url.isNotEmpty && config.anonKey.isNotEmpty;

    Color bgColor;
    IconData icon;
    Color iconColor;
    String titleText;
    String? subtitleText;
    VoidCallback? onTap;

    if (!isVip) {
      bgColor = const Color(0xFFFFF3E0);
      icon = Icons.lock_outline_rounded;
      iconColor = const Color(0xFFFF9500);
      titleText = AppLocalizations.of(context)!.needVipAccess;
      subtitleText = AppLocalizations.of(context)!.vipAccessSubtitle;
      onTap = () {
        context.pushNamed(AppRouter.purchase);
      };
    } else if (isConfigured) {
      bgColor = const Color(0xFFECFDF5);
      icon = Icons.check_circle_rounded;
      iconColor = const Color(0xFF10B981);
      titleText = AppLocalizations.of(context)!.statusConnected;
      subtitleText = null;
      onTap = null;
    } else {
      bgColor = Colors.grey.shade100;
      icon = Icons.settings_remote_rounded;
      iconColor = Colors.grey[700]!;
      titleText = AppLocalizations.of(context)!.statusNotConfigured;
      subtitleText = null;
      onTap = null;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: iconColor.withValues(alpha: 0.25), width: 1.1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 26),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.statusLabel,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        titleText,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: iconColor,
                        ),
                      ),
                      if (subtitleText != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitleText,
                          style: TextStyle(
                            fontSize: 12,
                            color: iconColor.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios_rounded, 
                    size: 14, 
                    color: iconColor.withValues(alpha: 0.7),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
